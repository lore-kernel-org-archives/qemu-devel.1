Received: from eggs.gnu.org ([2001:4830:134:3::10]:59450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gATnG-0007q2-H6
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 01:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gATnD-0001uD-AJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 01:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gATmz-0001mB-Vt
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 01:45:51 -0400
Message-ID: <0879a2149c762b1ac714433eee00e45290bec0f3.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 11 Oct 2018 07:45:32 +0200
In-Reply-To: <99997a93-da91-6a03-bc0b-fb539f05d797@gmail.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
	<a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
	<5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
	<63b741e2-b3e5-283a-4dfc-9c1db757c575@gmail.com>
	<D55C15F1-937F-474B-82B1-3F891E03638F@raithlin.com>
	<99997a93-da91-6a03-bc0b-fb539f05d797@gmail.com>
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
To: Alistair <alistair23@gmail.com>, Stephen Bates <sbates@raithlin.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>

On Wed, 2018-10-10 at 12:53 -0700, Alistair wrote:
> On 10/10/2018 11:47 AM, Stephen  Bates wrote:
> > >     Strange. Is there any reason you need to use the e1000? The VirtIO
> > >     networking device works for me.
> > 
> > As per above. The e1000 is there to test PCIe not networking.

Unless I'm mistaken, e1000 is a conventional PCI device, with
e1000e being the PCI Express equivalent.

> Awe. My mistake. I thought that the VirtIO networking device was a PCIe 
> device for some reason.

Most VirtIO devices, including virtio-net, show up as either
conventional PCI or PCI Express based on the slot they're plugged
into, so if you have

  -device virtio-net-pci,bus=pci.0

it will show up as a conventional PCI device but if you have

  -device pcie-root-port,id=pci.1,bus=pcie.0 \
  -device virtio-net-pci,bus=pci.1

instead it will show up as a PCI Express device.

-- 
Andrea Bolognani / Red Hat / Virtualization
