Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fyAKH-00077g-O9
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fyAKG-00006Y-Or
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:33:05 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fyAKG-0008TD-IK
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:33:04 -0400
Received: by mail-qk1-x742.google.com with SMTP id g13-v6so9049993qki.9
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 23:33:04 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 7 Sep 2018 14:32:26 +0800
Message-ID: <CAKXe6S+5ucQuyA4Ru5J4_WLJWMy4znnmnPAJcPX3+j+uSiSW4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Question] Question about the i440FX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Cc: liqiang02@corp.netease.com

Hello all,

I want to know why the i440FX in the following 'info qtree' information is
laid under the pci.0 bus.  In the chip spec here:
-->https://wiki.qemu.org/images/b/bb/29054901.pdf
I don't see this device.

Can anyone give me some hints?

Thanks,
Li Qiang

bus: main-system-bus
  type System
  dev: hpet, id ""
  dev: kvm-ioapic, id ""
  dev: i440FX-pcihost, id ""
    pci-hole64-size = 18446744073709551615 (16 EiB)
    short_root_bus = 0 (0x0)
    bus: pci.0
      type PCI
      dev: virtio-balloon-pci, id "balloon0"
      dev: cirrus-vga, id "video0"
      dev: PIIX4_PM, id "
      dev: piix3-ide, id ""

      dev: PIIX3, id ""

      dev: *i440FX*, id ""
        addr = 00.0
        romfile = ""
        rombar = 1 (0x1)
        multifunction = false
        command_serr_enable = true
        x-pcie-lnksta-dllla = true
        class Host bridge, addr 00:00.0, pci id 8086:1237 (sub 1af4:1100)
