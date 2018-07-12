Received: from eggs.gnu.org ([2001:4830:134:3::10]:49421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdhc3-000310-2c
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdhc0-0007bm-0W
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:52116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdhbz-0007aN-Py
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:50:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdhbw-0006FK-Sm
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 19:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 988F82E80CB
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 19:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jul 2018 19:35:03 -0000
From: David Martins <1781463@bugs.launchpad.net>
Reply-To: Bug 1781463 <1781463@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153142289132.32266.13097437819271021346.malonedeb@wampee.canonical.com>
Message-Id: <153142410462.24035.9765241566644960219.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1781463] Re: qemu don't start *.abs firmware files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
     Assignee: (unassigned) =3D> David Martins (screamfox)

** Tags added: qemu

** Tags added: firmware

** Tags added: abs amiko emulation receiver

** Tags added: satelitereceiver stb

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781463

Title:
  qemu don't start *.abs firmware files

Status in QEMU:
  New

Bug description:
  Hello Devs,

  I'm here to report this bug/issue because i'm using Win64 Qemu but i
  can't start a *.abs firmware at normally this firmware is based in
  Linux Kernel and this type of firmware is made for STB Receivers,

  So this is all information i provide to get support.

  Files extracted by ( binwalk -e )

  =

  Terminal output:

  # binwalk -e AMIKO_HD8150_2.4.43_emu.abs

  DECIMAL       HEXADECIMAL     DESCRIPTION

  -------------------------------------------------------------------------=
-------
  196736        0x30080         LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 11883876 bytes
  3866752       0x3B0080        LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 3255512 bytes
  5636224       0x560080        LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 87904 bytes

  =

  Files extracted with ALI TOOLS or Ali FirmwareDecriptor.

  Windows files output:

  Software used: Ali Main Code Decrypter 8.9

  Files unpacked:

  bootloader
  MemCfg
  maincode(AV)
  seecode
  default_lang
  cipluskey
  countryband
  logo_user
  logo_menu
  logo_radio
  logo_boot
  patch
  defaultdb(PRC)
  userdb(64+64)

  =

  Terminal OUTPUT:

  # hexdump -C

  part of file

  =

  00b51a30  00 00 00 00 4c 69 62 63  6f 72 65 20 76 65 72 73  |....Libcore =
vers|
  00b51a40  69 6f 6e 20 31 33 2e 31  36 2e 30 40 53 44 4b 34  |ion 13.16.0@=
SDK4|
  00b51a50  2e 30 66 61 2e 31 33 2e  31 36 5f 32 30 31 36 31  |.0fa.13.16_2=
0161|
  00b51a60  30 31 39 28 67 63 63 20  76 65 72 73 69 6f 6e 20  |019(gcc vers=
ion |
  00b51a70  33 2e 34 2e 34 20 6d 69  70 73 73 64 65 2d 36 2e  |3.4.4 mipssd=
e-6.|
  00b51a80  30 36 2e 30 31 2d 32 30  30 37 30 34 32 30 29 28  |06.01-200704=
20)(|
  00b51a90  41 64 6d 69 6e 69 73 74  72 61 74 6f 72 40 20 46  |Administrato=
r@ F|
  00b51aa0  72 69 2c 20 4a 75 6c 20  32 38 2c 20 32 30 31 37  |ri, Jul 28, =
2017|
  00b51ab0  20 31 32 3a 35 33 3a 32  38 20 41 4d 29 0a 00 00  | 12:53:28 AM=
)...|
  00b51ac0  44 4d 58 5f 53 33 36 30  31 5f 30 00 00 a1 03 18  |DMX_S3601_0.=
....|

  =

  When I use readelf it says files isn't an ELF file, so i can't run it lik=
e a kernel (Bootloader,Maincode, and etc. )

  so this is the cmd output when i use qemu Win64 (I don't whant to use
  linux to do the emulation about this *.abs extension firmware so
  please help me for win64 version from Qemu)

  CMD OUTPUT:

   C:\Program Files\qemu>qemu-system-mips.exe -machine mips -cpu
  mips32r6-generic -drive
  file=3DC:\30080.bin,index=3D0,media=3Ddisk,format=3Draw

  qemu-system-mips.exe: warning: could not load MIPS bios
  'mips_bios.bin'

  I also tried a lot of diferents qemu-system... and a lot of diferent
  configs like -machine -cpu -kernel -driver root=3D -PFLASH and etc...
  and nothing hapenned

  How can i reproduce this issue ? =

  Reply:. =


  Donwload *.abs firmware in amikoreceiver.com (only *.abs) and download
  AliDekompressor in http://www.satedu.cba.pl/

  Direct tools:

  FirmwareDecrypter_v8.9.zip :

  http://www.satedu.cba.pl/index.php?action=3Ddownloadfile&filename=3DFirmw=
areDecrypter_v8.9.zip&directory=3DTest%20Folder&

  Ali__tools_Console_v4.0__CRC_FIXER.rar :

  http://www.satedu.cba.pl/index.php?action=3Ddownloadfile&filename=3DAli__=
tools_Console_v4.0__CRC_FIXER.rar&directory=3DTest%20Folder&

  =

  so if Qemu can explain how can i fix this issue this can be highly helpfu=
ll.

  With my best regards,
  David Martins =

  Screamfox

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781463/+subscriptions
