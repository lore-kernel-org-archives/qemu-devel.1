Received: from eggs.gnu.org ([2001:4830:134:3::10]:56075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXuy-0001dO-5q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPXuw-0002Bc-DH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:12:08 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
	<0ddaeccd-94fd-22a8-f5e0-91fbafdf1761@deltatee.com>
	<CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0fac09ca-12d5-1462-4456-66646f168ab5@deltatee.com>
Date: Wed, 21 Nov 2018 12:11:55 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNitWerbpVzQrNye3KiPj=5DVFXan4SpiN-+br_P-RG+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>



On 2018-11-21 11:34 a.m., Alistair Francis wrote:
>> I don't understand what this patch actually accomplishes. It doesn't
>> seem to affect my network devices when running QEMU. Can you provide a
>> commit message explaining this?
> 
> Could you connect a PCIe networking device without this commit? This
> is what the other architectures all do as well.

Yes, actually.

Other architectures doing something is never a sufficient justification
to make a change. I'm also not sure how virtio relates to this patch...

I'd say unless you know you're fixing something specific and can
describe it, you should drop this patch.

Logan
