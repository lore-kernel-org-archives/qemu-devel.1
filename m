Received: from eggs.gnu.org ([209.51.188.92]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpO7-00006T-PP
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpO5-0005ih-BD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:33:47 -0400
MIME-Version: 1.0
References: <cover.1553712571.git.alistair.francis@wdc.com>
	<mhng-9286e210-d632-41e0-b30d-cfdef1a43396@palmer-si-x1c4>
In-Reply-To: <mhng-9286e210-d632-41e0-b30d-cfdef1a43396@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Apr 2019 16:32:11 -0700
Message-ID: <CAKmqyKOAMGBcgRscu9QzpQYsA=qTeGgkK+03F=0YRhtzUFaXVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 4.0 v2 0/2] Update the QEMU PLIC
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Wed, Mar 27, 2019 at 8:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 27 Mar 2019 11:51:15 PDT (-0700), Alistair Francis wrote:
> > This series updates the PLIC address to match the documentation.
> >
> > This fixes: https://github.com/riscv/opensbi/issues/97
> >
> > V2:
> >  - Squash patches to ensure biesctability
> >
> > Alistair Francis (2):
> >   riscv: plic: Fix incorrect irq calculation
> >   riscv: plic: Log guest errors
> >
> >  hw/riscv/sifive_plic.c      | 16 +++++++++++-----
> >  hw/riscv/sifive_u.c         |  2 +-
> >  include/hw/riscv/sifive_e.h |  2 +-
> >  include/hw/riscv/sifive_u.h |  4 ++--
> >  include/hw/riscv/virt.h     |  2 +-
> >  5 files changed, 16 insertions(+), 10 deletions(-)
> >
> > --
> > 2.21.0
>
> Thanks, I've got these on for-master.  I'll let them sit for a bit to see if
> there are any other comments, but
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Ping! Just want to make sure these make it into 4.0

Alistair
