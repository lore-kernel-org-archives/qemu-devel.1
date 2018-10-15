Received: from eggs.gnu.org ([2001:4830:134:3::10]:40736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gC6EI-00060N-55
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gC6E9-0003PP-Mq
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:00:24 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gC6E9-0003Mw-6G
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:00:21 -0400
Received: by mail-lf1-x141.google.com with SMTP id q39-v6so14616633lfi.8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
	<23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
In-Reply-To: <23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Oct 2018 09:59:49 -0700
Message-ID: <CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
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

On Mon, Oct 15, 2018 at 7:39 AM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Fri, 2018-10-12 at 09:12 -0700, Alistair Francis wrote:
> > On Fri, Oct 12, 2018 at 6:46 AM Andrea Bolognani <abologna@redhat.com> wrote:
> > > Problem solved then :)
> >
> > Does that mean you have it working?
>
> Yeah, it was trivial once I knew what to look for ;)
>
>
> One more thing that I forgot to bring up earlier: at the same time
> as PCIe support is added, we should also make sure that the
> pcie-root-port device is built into the qemu-system-riscv* binaries
> by default, as that device being missing will cause PCI-enabled
> libvirt guests to fail to start.

We are dong that aren't we?

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>
