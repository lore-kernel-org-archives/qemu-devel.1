Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPX4f-0001U5-8E
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPX4e-0002is-F8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:18:05 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<a2c70c88a145d2e239f113e28979c7a50d71aedf.1542819633.git.alistair.francis@wdc.com>
	<ff4ef556-0989-ec47-0424-3f153f10a8d0@deltatee.com>
In-Reply-To: <ff4ef556-0989-ec47-0424-3f153f10a8d0@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 10:17:34 -0800
Message-ID: <CAKmqyKOMsBda223ptqt2iVFi6oVifK_0L+=Mne=v9p_umwxVLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 1/6] hw/riscv/virt: Increase the
 number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>

On Wed, Nov 21, 2018 at 9:58 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> > Increase the number of interrupts to match the HiFive Unleashed board.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/riscv/virt.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 91163d6cbf..7cb2742070 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -45,7 +45,7 @@ enum {
> >      UART0_IRQ = 10,
> >      VIRTIO_IRQ = 1, /* 1 to 8 */
> >      VIRTIO_COUNT = 8,
> > -    VIRTIO_NDEV = 10
> > +    VIRTIO_NDEV = 0x35
>
> Why 0x35? Based on the PCI patch we are using only 36 interrupts, not 53...

This is just for future proofing. There is no reason to set the number
lower then the number of interrupts we have, now hopefully this won't
keep churning every time we add a device.

Alistair

>
> Logan
