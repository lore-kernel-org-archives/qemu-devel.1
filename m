Received: from eggs.gnu.org ([2001:4830:134:3::10]:49046)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cZcdv-0005Th-QB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cZcds-0004Af-NS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:07:07 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44812 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cZcds-00046n-Dr
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:07:04 -0500
From: Peter Lieven <pl@kamp.de>
Message-ID: <5a80994b-3eeb-6ac8-9fbf-e6fae15dfd7a@kamp.de>
Date: Fri, 3 Feb 2017 13:07:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Creating a dummy PCI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,


I have a special use case of creating a dummy PCI device with a certain vendor/device ID. The device does not have to actually function, it just

has to be visible under lspci.


Any idea how to achieve this? I was thinking of modifying the edu pci device to make the device/vendor ID passable via cmdline.


Don't know if thats a good idea.


Any thoughts?


Thank you,

Peter
