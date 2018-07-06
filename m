Received: from eggs.gnu.org ([2001:4830:134:3::10]:45916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbWYS-0005oL-Qv
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 15:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbWYS-0002FY-28
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 15:38:08 -0400
References: <1530879678-20487-1-git-send-email-ari@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3671e9d-a417-d855-2473-6378c6b87b1e@redhat.com>
Date: Fri, 6 Jul 2018 14:37:59 -0500
MIME-Version: 1.0
In-Reply-To: <1530879678-20487-1-git-send-email-ari@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>

On 07/06/2018 07:21 AM, Ari Sundholm wrote:
> This was accidentally omitted. Thanks to Eric Blake for spotting this.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>   qapi/block-core.json | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 38b3125..62a92fa 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3057,6 +3057,8 @@
>   # @log-sector-size: sector size used in logging writes to @file, determines
>   #                   granularity of offsets and sizes of writes (default: 512)
>   #
> +# @log-append:      append to an existing log (default: false)
> +#
>   # @log-super-update-interval: interval of write requests after which the log
>   #                             super block is updated to disk (default: 4096)
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
