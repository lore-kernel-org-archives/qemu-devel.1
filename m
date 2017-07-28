Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8f4-0000Qh-26
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8f3-00028o-9x
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:02:50 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1db8f2-00027z-Sm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:02:49 -0400
Received: by mail-wr0-x244.google.com with SMTP id 12so18950402wrb.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:02:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jul 2017 10:02:17 -0700
Message-ID: <CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Steinhardt <ps@pks.im>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jun 26, 2017 at 12:20 PM, Patrick Steinhardt <ps@pks.im> wrote:
> The function `v9fs_xattrcreate` makes use of the define `XATTR_SIZE_MAX`
> to reject attempts of creating xattrs with an invalid size, which is
> defined in <linux/limits.h>. On glibc-based systems, this header is
> indirectly included via <limits.h>, <bits/posix1_lim.h>,
> <bitts/local_lim.h>, but on other platforms this is not guaranteed due
> to not being part of the POSIX standard. One examples are systems based
> on musl libc, which do not include the <linux/limits.h> indirectly,
> which leads to `XATTR_SIZE_MAX` being undefined.
>
> Fix this error by directly include <linux/limits.h>. As the 9P fs code
> is being Linux-based either way, we can simply do so without breaking
> other platforms. This enables building 9pfs on musl-based systems.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Ping!

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair


> ---
>  hw/9pfs/9p.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 96d2683348..48cd558e96 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include <glib/gprintf.h>
> +#include <linux/limits.h>
>  #include "hw/virtio/virtio.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> --
> 2.13.2
>
>
