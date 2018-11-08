Received: from eggs.gnu.org ([2001:4830:134:3::10]:55786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gKpBm-0007tm-Ua
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gKpBm-0006B3-0K
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:37:58 -0500
MIME-Version: 1.0
References: <1793576616012e06e68cd9e0215eb907ff2ef12b.1541627403.git.alistair.francis@wdc.com>
	<mhng-2f508723-0da1-4d97-9e9e-cbc12898023f@palmer-si-x1c4>
In-Reply-To: <mhng-2f508723-0da1-4d97-9e9e-cbc12898023f@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Nov 2018 10:37:28 -0800
Message-ID: <CAKmqyKOXRVE_9fvrXMTXgtruV=UndnBC2oPPS7Qowqt=aqWP1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 3.1 v1 1/1] hw/riscv/virt: Free the
 test device tree node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Wed, Nov 7, 2018 at 6:38 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 07 Nov 2018 13:51:45 PST (-0800), Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/virt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 4a137a503c..2b38f89070 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
> >      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> >          0x0, memmap[VIRT_TEST].base,
> >          0x0, memmap[VIRT_TEST].size);
> > +    g_free(nodename);
> >
> >      nodename = g_strdup_printf("/uart@%lx",
> >          (long)memmap[VIRT_UART0].base);
> > --
> > 2.19.1
>
> Thanks.  I got a bit behind this week so I didn't send the pre-PR, but I indent
> to send a PR tomorrow.  That PR currently only contains this patch.

There should be two patches. One for spike and one for the virt machine.

Alistair
