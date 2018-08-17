Received: from eggs.gnu.org ([2001:4830:134:3::10]:49060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqYN0-0000nU-1u
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqYMw-0000IY-13
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:36:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fqYMv-0000Go-Si
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:36:21 -0400
Date: Fri, 17 Aug 2018 08:36:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180817063619.pi7bhuwgjj7asodc@sirius.home.kraxel.org>
References: <cover.1534435831.git.alistair.francis@wdc.com>
	<b54c28929f201751c4f41e5cb7170e5b9a774432.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54c28929f201751c4f41e5cb7170e5b9a774432.1534435831.git.alistair.francis@wdc.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] hw/riscv/virt: Connect a VGA PCIe
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, mjc@sifive.com, alistair23@gmail.com

  Hi,

> +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
> +
> +    pci_vga_init(pci_bus);

I'd suggest to use "-device bochs-display" instead, unless you need all
the legacy vga cruft (text mode, ...).  The bochs-drm kms driver can
handle this one just fine too, it is much smaller (in terms of code
lines and attack surface), and it has pcie support.

cheers,
  Gerd
