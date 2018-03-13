Received: from eggs.gnu.org ([2001:4830:134:3::10]:50983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evoy4-0005rK-PQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evoy3-0003Vl-WD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:48:12 -0400
References: <20180313161803.1814-1-kwolf@redhat.com>
	<20180313161803.1814-19-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <502f868d-4b92-96fb-63e1-1e1f6c89d996@redhat.com>
Date: Tue, 13 Mar 2018 13:47:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180313161803.1814-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 18/41] blockjobs: add block-job-finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

On 03/13/2018 11:17 AM, Kevin Wolf wrote:
> From: John Snow <jsnow@redhat.com>
> 
> Instead of automatically transitioning from PENDING to CONCLUDED, gate
> the .prepare() and .commit() phases behind an explicit acknowledgement
> provided by the QMP monitor if auto_finalize = false has been requested.
> 

>   ##
> +# @block-job-finalize:
> +#
> +# Once a job that has manual=true reaches the pending state, it can be

Is this wording stale, given that you add two separate auto-* bool flags 
in 19/41?  You may want to prepare a followup patch (doc bug fixes are 
safe during softfreeze, so it need not hold up this pull request) that 
tweaks this and any similar stale wording.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
