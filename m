Received: from eggs.gnu.org ([209.51.188.92]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLgL0-0001j2-HP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLgKx-0006bi-Fp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLgKx-0006a8-63
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:15 -0400
Received: by mail-lf1-x144.google.com with SMTP id o16so12418351lfl.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 20:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB0277192E4A6C255E30EFE627DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA_rJT3NxMAyoVFCbxNi0vNfCRg1bhHTsOmd5pa1pb_DzA@mail.gmail.com>
In-Reply-To: <CAFEAcA_rJT3NxMAyoVFCbxNi0vNfCRg1bhHTsOmd5pa1pb_DzA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 20:54:44 -0700
Message-ID: <CAKmqyKPGkgYNntZV70pys3PvzdneWWsk=jMiWJQ6SpHCA8rUXQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 9:04 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 06:34, Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Allow the kernel's entry point information to be returned when loading a
> > kernel.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  hw/arm/armv7m.c      | 6 +++---
> >  hw/arm/microbit.c    | 2 +-
> >  hw/arm/mps2-tz.c     | 3 ++-
> >  hw/arm/mps2.c        | 2 +-
> >  hw/arm/msf2-som.c    | 2 +-
> >  hw/arm/musca.c       | 3 ++-
> >  hw/arm/netduino2.c   | 2 +-
> >  hw/arm/stellaris.c   | 3 ++-
> >  include/hw/arm/arm.h | 4 +++-
> >  9 files changed, 16 insertions(+), 11 deletions(-)
>
> > -void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> > +void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size,
> > +                        uint64_t *entry)
>
> If we need to return the entry point, why not just return it
> as the return value of the function rather than having the
> caller pass in a pointer which we fill in ?

There wasn't really a reason, it was just following along with load_elf().

Alistair

>
> thanks
> -- PMM
