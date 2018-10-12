Received: from eggs.gnu.org ([2001:4830:134:3::10]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gB03a-0001E8-Lo
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gB03Z-0002j4-V7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:12:54 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gB03X-0002cy-OC
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:12:53 -0400
Received: by mail-lf1-x142.google.com with SMTP id q39-v6so9703550lfi.8
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 09:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
In-Reply-To: <d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Oct 2018 09:12:21 -0700
Message-ID: <CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, stephen@eideticom.com, "Richard W.M. Jones" <rjones@redhat.com>

On Fri, Oct 12, 2018 at 6:46 AM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Thu, 2018-10-11 at 10:40 -0700, Alistair Francis wrote:
> > On Wed, Oct 10, 2018 at 11:00 PM Andrea Bolognani <abologna@redhat.com> wrote:
> > > The gpex-pcihost device was introduced at the same time as
> > > aarch64/virt gained PCI support, so we can probe the binary[1] and,
> > > if the device is present, we know that aarch64/virt guests will be
> > > able to use PCI. We cannot do the same for RISC-V for obvious
> > > reasons: the device is already there :)
> >
> > The device shouldn't exist in the RISC-V QEMU binary though until
> > after this patch series. So it should have the same effect.
>
> Duh! I just checked and *of course* you're right!
>
> Problem solved then :)

Does that mean you have it working?

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>
