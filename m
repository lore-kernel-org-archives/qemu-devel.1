Received: from eggs.gnu.org ([2001:4830:134:3::10]:59866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epEcc-0008S7-1d
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epEca-0001zI-SZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:46:50 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-17-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90d7a9eb-566d-9c30-2f4a-41d15ba7ccaf@redhat.com>
Date: Fri, 23 Feb 2018 08:46:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/36] file-win32: Support
 .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to file-win32, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/file-win32.c | 45 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 8 deletions(-)
> 

> +
> +    options = (BlockdevCreateOptions) {
> +        .driver     = BLOCKDEV_DRIVER_FILE,
> +        .u.file     = {
> +            .filename           = (char *) filename,
> +            .size               = total_size,
> +            .has_preallocation  = false,
> +            .has_nocow          = false,

Technically, these last two lines aren't needed (you get false by 
default), but it doesn't hurt to list them either.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
