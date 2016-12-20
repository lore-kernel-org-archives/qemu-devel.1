Received: from eggs.gnu.org ([2001:4830:134:3::10]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cJ9kA-0005hb-45
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 21:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cJ9k9-0000zl-9n
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 21:01:30 -0500
MIME-Version: 1.0
In-Reply-To: <148215768690.13973.9042496691140000163.stgit@bahia>
References: <148215768690.13973.9042496691140000163.stgit@bahia>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 20 Dec 2016 10:01:26 +0800
Message-ID: <CAKXe6SJG1qGr5UQdqVs06frrQFbyH5-0xeZ9JQEqabwpg+fYrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix crash when fsdev is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, qemu-stable@nongnu.org

On 2016-12-19 22:28 GMT+08:00 Greg Kurz <groug@kaod.org> wrote:

> If the user passes -device virtio-9p without the corresponding -fsdev, QEMU
> dereferences a NULL pointer and crashes.
>
> This is a 2.8 regression introduced by commit 702dbcc274e2c.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/9pfs/9p.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index faebd91f5fab..68725b7a1c97 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3521,7 +3521,7 @@ int v9fs_device_realize_common(V9fsState *s, Error
> **errp)
>      rc = 0;
>  out:
>      if (rc) {
> -        if (s->ops->cleanup && s->ctx.private) {
> +        if (s->ops && s->ops->cleanup && s->ctx.private) {
>              s->ops->cleanup(&s->ctx);
>          }
>          g_free(s->tag);
>
>
