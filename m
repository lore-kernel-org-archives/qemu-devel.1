Received: from eggs.gnu.org ([2001:4830:134:3::10]:34262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dosWZ-0006Wv-JW
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dosWU-0004c4-DC
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:38:51 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Mon, 4 Sep 2017 14:38:32 +0000
Message-ID: <AM5P194MB0132337AF77CC74475687CF1C8910@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <AM5P194MB01329E868116B28535E050A3C8930@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <AM5P194MB01329E868116B28535E050A3C8930@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] e5500 pcce500 disabled network and no
 video on device virtio-gpu or virtio gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

i found probably another issue,

i cant made the img boot if i run qemu 2.10 build on an X86_64 (endianess?)=
.

tested on qemu 2.10 on MacOsx 10.12 and on Ubuntu Mate 17.04 (amd64)


this issue is present if i choose -hda instead -device file=3D too


[    8.564326] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

[    8.569373] ata6.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mas=
k=3D0x80)

[    8.575744] ata6: limiting SATA link speed to 1.5 Gbps

[   14.195086] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

[   14.200326] ata6.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mas=
k=3D0x80)

[   19.828186] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)[   19=
.867419] VFS: Cannot open root device "sda2" or unknown-block(0,0): error -=
6

[   19.872611] Please append a correct "root=3D" boot option; here are the =
availa

[   19.967119] Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(0,0)


Luigi




Oggetto: [Qemu-ppc] e5500 pcce500 disabled network and no video on device v=
irtio-gpu or virtio gpu-pci


Hi all,

like the topic i cant made the machine goes online plus the video output do=
n work.

on this email i made the links with

kernel 411 with virtio,bochs etc etc .

a base of distro with kernel modules

my usual lines configuration.


Note i tested all on real e5500 machine and all is working there.

Hope my job will help in fixing and developing


ubuntu base : https://www.dropbox.com/s/yzp657yad3cp48n/Amigaone_Ubuntu_16.=
04-Base-1.img.gz?dl=3D0


Kernel 411:https://www.dropbox.com/s/ne49j5bo62680l0/u411.gz?dl=3D0


qemu line config: https://www.dropbox.com/s/j5kekeut75ogs9r/qemu_config.gz?=
dl=3D0


Thanks

Luigi
