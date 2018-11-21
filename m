Received: from eggs.gnu.org ([2001:4830:134:3::10]:47133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPaTd-00077r-6Q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPaTb-0003xE-Hy
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:56:05 -0500
MIME-Version: 1.0
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
	<0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
	<CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
	<0fac09ca-12d5-1462-4456-66646f168ab5@deltatee.com>
In-Reply-To: <0fac09ca-12d5-1462-4456-66646f168ab5@deltatee.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 13:55:34 -0800
Message-ID: <CAKmqyKMTxgk41cBz=hW-meCUAi-_20vguqN40f_ThRU-rsaJXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 6/6] hw/riscv/virt: Connect a
 VirtIO net PCIe device
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

On Wed, Nov 21, 2018 at 11:12 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-21 11:34 a.m., Alistair Francis wrote:
> >> I don't understand what this patch actually accomplishes. It doesn't
> >> seem to affect my network devices when running QEMU. Can you provide a
> >> commit message explaining this?
> >
> > Could you connect a PCIe networking device without this commit? This
> > is what the other architectures all do as well.
>
> Yes, actually.
>
> Other architectures doing something is never a sufficient justification
> to make a change. I'm also not sure how virtio relates to this patch...
>
> I'd say unless you know you're fixing something specific and can
> describe it, you should drop this patch.

It is required for networking for PCIe devices. What PCIe device works
for you without this patch? Can you tell me your command line
arguments.

Alistair

>
> Logan
