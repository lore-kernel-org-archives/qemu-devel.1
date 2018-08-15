Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq3IZ-0003Gc-Pa
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq3IZ-0005H2-3v
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:25:47 -0400
References: <c449263bbcaffbd3db25d833fb57867fda8e3199.1534348766.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79de10c5-28fb-5be2-3141-f09fb4bb5f09@redhat.com>
Date: Wed, 15 Aug 2018 16:25:16 -0500
MIME-Version: 1.0
In-Reply-To: <c449263bbcaffbd3db25d833fb57867fda8e3199.1534348766.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

On 08/15/2018 10:59 AM, Jeff Cody wrote:
> The function job_cancel_async() will always cause an assert for blockjob
> user resume.  We set job->user_paused to false, and then call
> job->driver->user_resume().  In the case of blockjobs, this is the
> block_job_user_resume() function.
> 
> In that function, we assert that job.user_paused is set to true.
> Unfortunately, right before calling this function, it has explicitly
> been set to false.
> 
> The fix is pretty simple: set job->user_paused to false only after the
> job user_resume() function has been called.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>   job.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Does this need to CC qemu-stable?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
