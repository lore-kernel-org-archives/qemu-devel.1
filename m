Received: from eggs.gnu.org ([209.51.188.92]:55416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVF1-0000NN-HM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVF0-00078C-AJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:04:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLVF0-00073t-3p
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:04:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id l1so9835368oib.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB0277192E4A6C255E30EFE627DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277192E4A6C255E30EFE627DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:04:03 +0100
Message-ID: <CAFEAcA_rJT3NxMAyoVFCbxNi0vNfCRg1bhHTsOmd5pa1pb_DzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/5] armv7m: Allow entry information to
 be returned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Mon, 29 Apr 2019 at 06:34, Alistair Francis <alistair@alistair23.me> wrote:
>
> Allow the kernel's entry point information to be returned when loading a
> kernel.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  hw/arm/armv7m.c      | 6 +++---
>  hw/arm/microbit.c    | 2 +-
>  hw/arm/mps2-tz.c     | 3 ++-
>  hw/arm/mps2.c        | 2 +-
>  hw/arm/msf2-som.c    | 2 +-
>  hw/arm/musca.c       | 3 ++-
>  hw/arm/netduino2.c   | 2 +-
>  hw/arm/stellaris.c   | 3 ++-
>  include/hw/arm/arm.h | 4 +++-
>  9 files changed, 16 insertions(+), 11 deletions(-)

> -void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> +void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size,
> +                        uint64_t *entry)

If we need to return the entry point, why not just return it
as the return value of the function rather than having the
caller pass in a pointer which we fill in ?

thanks
-- PMM
