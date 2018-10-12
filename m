Received: from eggs.gnu.org ([2001:4830:134:3::10]:40972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAxms-0004XQ-Nh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAxmm-0003XJ-IM
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gAxmX-0002Kq-L6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:47:22 -0400
Message-ID: <d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 12 Oct 2018 15:46:49 +0200
In-Reply-To: <CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, stephen@eideticom.com, "Richard W.M. Jones" <rjones@redhat.com>

On Thu, 2018-10-11 at 10:40 -0700, Alistair Francis wrote:
> On Wed, Oct 10, 2018 at 11:00 PM Andrea Bolognani <abologna@redhat.com> wrote:
> > The gpex-pcihost device was introduced at the same time as
> > aarch64/virt gained PCI support, so we can probe the binary[1] and,
> > if the device is present, we know that aarch64/virt guests will be
> > able to use PCI. We cannot do the same for RISC-V for obvious
> > reasons: the device is already there :)
> 
> The device shouldn't exist in the RISC-V QEMU binary though until
> after this patch series. So it should have the same effect.

Duh! I just checked and *of course* you're right!

Problem solved then :)

-- 
Andrea Bolognani / Red Hat / Virtualization
