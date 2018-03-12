Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO5c-0005NX-3h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO5W-0007c2-BB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:06:12 -0400
References: <20180312132204.23683-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d47e7441-0166-07c6-20fd-6020e553903a@redhat.com>
Date: Mon, 12 Mar 2018 09:05:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180312132204.23683-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add include/block/aio-wait.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

On 03/12/2018 08:22 AM, Stefan Hajnoczi wrote:
> The include/block/aio-wait.h header file was added by commit
> 7719f3c968c59e1bcda7e177679dc765b59e578f ("block: extract
> AIO_WAIT_WHILE() from BlockDriverState") without updating MAINTAINERS.

A shame checkpatch.pl and/or patchew still doesn't flag this, even 
though it's been proposed as a syntax check.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f409f3b158..7adc04e477 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1331,6 +1331,7 @@ F: util/aio-*.c
>   F: block/io.c
>   F: migration/block*
>   F: include/block/aio.h
> +F: include/block/aio-wait.h
>   F: scripts/qemugdb/aio.py
>   T: git git://github.com/stefanha/qemu.git block
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
