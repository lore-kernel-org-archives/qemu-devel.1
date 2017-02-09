Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wojciechzeb@gmail.com>) id 1cbk2a-0007v9-F9
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wojciechzeb@gmail.com>) id 1cbk2Z-0007qu-FK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:25:20 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:35645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wojciechzeb@gmail.com>)
	id 1cbk2Z-0007qL-9H
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:25:19 -0500
Received: by mail-it0-x22e.google.com with SMTP id 203so120350966ith.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:25:17 -0800 (PST)
MIME-Version: 1.0
From: Wojciech Zebrowski <wojciechzeb@gmail.com>
Date: Thu, 9 Feb 2017 09:25:16 +0100
Message-ID: <CAPasb5WKwx0kqsG+XUAENAxgUqL8YnJ7ha=qBfnWA8dde5Lvfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Asking about USB for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi

I try connect my host linux centos USB to Qemu for Xilinx Zynq solution.
I do following step :
1.Check usb vendor id , product id: lsusb




*Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hubBus 002
Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hubBus 003 Device 001:
ID 1d6b:0002 Linux Foundation 2.0 root hubBus 004 Device 001: ID 1d6b:0003
Linux Foundation 3.0 root hub*

2. I start Qemu with switch :

*-usbdevice host:<VendorID>:<ProductID>*

*-usbdevice host:1d6b:0002*

 3. On Centos Host computer where Xilinx Qemu is started , i've error as :

*No 'PCI' bus found for device 'usb-ehci'*

What is incorrect with my command or system configuration ?

4. I check my motherboard bridge as following:

*qemu-system-x86_64 -device help |& grep usb.*hci*

*name "ich9-usb-ehci1", bus PCI name *

*"ich9-usb-ehci2", bus PCI name *

*"ich9-usb-uhci1", bus PCI name *

*"ich9-usb-uhci2", bus PCI name *

*"ich9-usb-uhci3", bus PCI name *

*"ich9-usb-uhci4", bus PCI name *

*"ich9-usb-uhci5", bus PCI name *

*"ich9-usb-uhci6", bus PCI name *

*"nec-usb-xhci", bus PCI name *

*"piix3-usb-uhci", bus PCI name *

*"piix4-usb-uhci", bus PCI name *

*"usb-ehci", bus PCI name *

*"vt82c686b-usb-uhci", bus PCI*


*Any advice for check ?*


Best regards :

Wojciech Zebrowski
