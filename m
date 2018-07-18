Received: from eggs.gnu.org ([2001:4830:134:3::10]:53294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffuz5-0004Ie-CC
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffuz4-0004HR-Cg
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:31:47 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:38324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ffuz4-0004Gf-3A
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:31:46 -0400
Received: by mail-lf0-x229.google.com with SMTP id a4-v6so4602149lff.5
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 15:31:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180718222755.9014-1-alistair.francis@wdc.com>
References: <20180718222755.9014-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Jul 2018 15:31:14 -0700
Message-ID: <CAKmqyKPw3eZc2pkSrRRy8wPowZWTWj-XyT_ZX3150wdyV0wAUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Jul 18, 2018 at 3:27 PM, Alistair Francis
<alistair.francis@wdc.com> wrote:
> The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:
>
>   Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180718-2
>
> for you to fetch changes up to 451ea962be0cbb6710737eeb90c2a801b979cad3:
>
>   spike: Fix crash when introspecting the device (2018-07-18 14:33:40 -0700)
>
> ----------------------------------------------------------------
> riscv: Fix introspection problems
>
> This is based on Thomas's work fixing introspection problems [1] and
> applied to the RISC-V port.
>
> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
>
> ----------------------------------------------------------------
> Alistair Francis (5):
>       sifive_e: Fix crash when introspecting the device
>       sifive_u: Fix crash when introspecting the device
>       virt: Fix crash when introspecting the device
>       riscv_hart: Fix crash when introspecting the device
>       spike: Fix crash when introspecting the device

Argh! I just realised I left off Michael's review. I'll have to send a v2.

I'll tag it as v3.0 as well.

Alistair

>
>  hw/riscv/riscv_hart.c |  7 +++----
>  hw/riscv/sifive_e.c   | 12 ++++++------
>  hw/riscv/sifive_u.c   | 15 +++++++--------
>  hw/riscv/spike.c      | 10 ++++------
>  hw/riscv/virt.c       |  5 ++---
>  5 files changed, 22 insertions(+), 27 deletions(-)
