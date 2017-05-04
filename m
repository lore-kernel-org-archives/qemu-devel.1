Received: from eggs.gnu.org ([2001:4830:134:3::10]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabien.gregoire@outlook.com>) id 1d6Iav-00018J-JL
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabien.gregoire@outlook.com>) id 1d6Ias-0007T8-B0
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:23:05 -0400
Received: from mail-oln040092067078.outbound.protection.outlook.com
	([40.92.67.78]:54352
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabien.gregoire@outlook.com>)
	id 1d6Iar-0007Mb-VV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:23:02 -0400
From: Fabien GREGOIRE <fabien.gregoire@outlook.com>
Date: Thu, 4 May 2017 08:49:20 +0000
Message-ID: <VI1PR05MB167887445F80A38FED81EFABC9EA0@VI1PR05MB1678.eurprd05.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Issue with a manually compiled QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,



I have an issue with a manually compiled QEMU working with virt-manager/lib=
virt :

Internal Error: process exited while connecting to monitor:

qemu could not load PC BIOS 'bios-256k.bin'.



Here are the steps in order to reproduce :

- QEMU was previously installed from an "apt-get" : QEMU version is 2.5.0 (=
Debian 1:2.5+dfsg-5ubuntu10.11)

- To compile QEMU I use the following arguments :

--target-list=3Dx86_64-softmmu --disable-vnc --enable-sdl --enable-spice --=
enable-usb-redir --enable-kvm

with this version : https://github.com/qemu/qemu/archive/v2.5.0.zip

- I replace the QEMU binary (/usr/bin/qemu-system-x86_64-spice) and I have =
the issue with error message written above.



Do you have any advice / information about this error ? Any workaround ?



Kind regards,



Fabien
