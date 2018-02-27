Received: from eggs.gnu.org ([2001:4830:134:3::10]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiBD-0005VF-Pq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiB9-0007Lh-T7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:32:39 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3101da11-6577-3687-8333-9e35e5a8a01d@redhat.com>
Date: Tue, 27 Feb 2018 10:32:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 01/21] blockjobs: fix set-speed kick
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> If speed is '0' it's not actually "less than" the previous speed.
> Kick the job in this case too.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/blockjob.c b/blockjob.c
> index 3f52f29f75..24833ef30f 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -499,7 +499,7 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>       }
>   
>       job->speed = speed;
> -    if (speed <= old_speed) {
> +    if (speed && speed <= old_speed) {
>           return;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
