Received: from eggs.gnu.org ([2001:4830:134:3::10]:40494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frqPD-0006Ts-Oq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frqPC-0003Q5-Mz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:04:03 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e501ba8f-2862-b413-728c-40012873e234@redhat.com>
Date: Mon, 20 Aug 2018 15:03:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>

On 08/17/2018 02:04 PM, John Snow wrote:
> Jobs presently use both an Error object in the case of the create job,
> and char strings in the case of generic errors elsewhere.
> 
> Unify the two paths as just j->err, and remove the extra argument from
> job_completed. The integer error code for job_completed is kept for now
> for use by pre-emptive cancellation.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> @@ -535,7 +535,6 @@ void job_drain(Job *job)
>       }
>   }
>   
> -
>   /**
>    * All jobs must allow a pause point before entering their job proper. This
>    * ensures that jobs can be paused prior to being started, then resumed later.

Spurious hunk? I'm not opposed to consistent choice of how many newlines 
between functions, although it looks a bit odd in the overall patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
