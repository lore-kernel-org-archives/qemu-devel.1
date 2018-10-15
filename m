Received: from eggs.gnu.org ([2001:4830:134:3::10]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gC41o-0001mE-Dx
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gC41j-00089c-4I
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gC41i-00084F-3K
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:39:22 -0400
Message-ID: <23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 15 Oct 2018 16:39:08 +0200
In-Reply-To: <CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
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

On Fri, 2018-10-12 at 09:12 -0700, Alistair Francis wrote:
> On Fri, Oct 12, 2018 at 6:46 AM Andrea Bolognani <abologna@redhat.com> wrote:
> > Problem solved then :)
> 
> Does that mean you have it working?

Yeah, it was trivial once I knew what to look for ;)


One more thing that I forgot to bring up earlier: at the same time
as PCIe support is added, we should also make sure that the
pcie-root-port device is built into the qemu-system-riscv* binaries
by default, as that device being missing will cause PCI-enabled
libvirt guests to fail to start.

-- 
Andrea Bolognani / Red Hat / Virtualization
