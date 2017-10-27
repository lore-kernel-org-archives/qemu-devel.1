Received: from eggs.gnu.org ([2001:4830:134:3::10]:53808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80Dh-0000RQ-EZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80Dg-000829-M3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:42:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:48467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e80Dg-00080x-Fn
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:42:24 -0400
Received: by mail-wr0-x243.google.com with SMTP id 15so5484324wrb.5
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:42:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027055612.2488-5-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
	<20171027055612.2488-5-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Oct 2017 10:41:52 +0200
Message-ID: <CAKmqyKONSt_JpixjLBKoV10bMSJ-x0ewPnx1iepYsNL7XmULiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 04/13] m25p80: Add support for
 n25q512a11 and n25q512a13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se, "mar.krzeminski" <mar.krzeminski@gmail.com>

On Fri, Oct 27, 2017 at 7:56 AM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Add support for Micron (Numonyx) n25q512a11 and n25q512a13 flashes.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/block/m25p80.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index cf39e36..054dc6f 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -240,6 +240,8 @@ static const FlashPartInfo known_devices[] =3D {
>      { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
>      { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
>      { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
> +    { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
>      { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
> --
> 2.9.3
>
>
