Received: from eggs.gnu.org ([209.51.188.92]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alison.burgess@wsu.edu>) id 1gmaZI-0001bv-3o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alison.burgess@wsu.edu>) id 1gmaTO-0007LG-Ur
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:34:56 -0500
Received: from mail-eopbgr730077.outbound.protection.outlook.com
	([40.107.73.77]:3787
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alison.burgess@wsu.edu>)
	id 1gmaTO-0007Dz-Mm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:34:54 -0500
From: "Burgess, Alison E" <alison.burgess@wsu.edu>
Date: Thu, 24 Jan 2019 08:34:50 +0000
Message-ID: <DM6PR01MB439558A3AEFF795A7072DB078E9A0@DM6PR01MB4395.prod.exchangelabs.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] unknown keycodes `(unnamed)',
 please report to qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I am running Ubuntu 18.04 and I am sending this email because when I try to=
 run these series of commands in an executable file in


arm-none-eabi-as -mcpu=3Darm926ej-s -g ts.s -o ts.o
arm-none-eabi-gcc -c -mcpu=3Darm926ej-s -g t.c -o t.o
arm-none-eabi-ld -T t.ld ts.o t.o -o t.elf
arm-none-eabi-objcopy -O binary t.elf t.bin
arm-none-eabi-readelf -a t.elf

rm *.o *.elf

echo ready to go?
read dummy

qemu-system-arm -M realview-pbx-a9 -m 128M -kernel t.bin \
-serial mon:stdio -serial /dev/pts/0 -serial /dev/pts/0 -serial /dev/pts/0

(where the number in /dev/pts/# is the number I get when I run ps in the te=
rminal)

The qemu terminal appears, but once I press 'Enter' again so that my code r=
uns, I am faced with the unknown keycodes `(unnamed)', please report to qem=
u-devel@nongnu.org error message. After a couple of hours searching online =
I have not been able to find a solution and I have download and reinstalled=
 qemu a couple of times.

Thanks,
Alison Burgess
