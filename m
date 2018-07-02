Received: from eggs.gnu.org ([2001:4830:134:3::10]:51936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTV-0002EV-MD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTS-0004ix-Il
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:42914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZqTS-0004iQ-DC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZqTQ-0001LA-UY
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E38F32E8198
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1314667@bugs.launchpad.net>
Reply-To: Bug 1314667 <1314667@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140430150437.26914.15156.malonedeb@gac.canonical.com>
Message-Id: <153050504905.6988.15818972826311023055.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1314667] Re: PMPrebUSB - appcrash of qemu in
 Win-7-64bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1314667

Title:
  PMPrebUSB - appcrash of qemu in Win-7-64bit

Status in QEMU:
  Expired

Bug description:
  I am not sure if this issue is a bug of qemu or by Win-7.
  I want to test in advance with QEMU the ability if my USB-Rescue-Drive is =

  booting correctly. I have Win-7-64 and run qemu v.o.15.1.0 out of the ins=
talled RMPrepUSB v.2.1.719 =

  program. The settings for the preparation of my USB drive were FAT32 boot=
 as
  HD, bootloader WinPE/Win-7/Vista, set for running iso-files directly in %=
_ISO
  \MAINMENU\Hiren=E2=80=99sBootCD.iso. When I run Qemu I get the messages i=
n the cmd starting window it says:

  Administrator: RMPrepUSB QEMU Launcher
  **************************************
  EXECUTING "C:\Program Files (x86)\RMPrepUSB\qemu\STARTFROMUSB.cmd"
  DRIVE NUMBER=3D3
  MEMORY SIZE=3D1000
  HARD DISK IMAGE=3Dharddisk.img
  NOWRITE=3D
  Found OS=3DVISTA_OR_LATER
  Sending command Start_VM.exe 3 500 qemu.exe -L . -name "RMPrepUSB Emulati=
on =

  Session  RAM=3D1000MB VirtualHDD=3Dharddisk.i
  lt+LCtrl)" -boot c -m 1000 -drive file=3D\\.
  \PhysicalDrive3,if=3Dide,index=3D0,media=3Ddisk -hdb harddisk.img to shel=
l...

  Win-7: in the second window appears:
  ***********************************
  -->qemu funktioniert nicht mehr
  Problemsignatur:
    Problemereignisname:	APPCRASH
    Anwendungsname:	qemu.exe
    Anwendungsversion:	0.15.1.0
    Anwendungszeitstempel:	4f478c16
    Fehlermodulname:	qemu.exe
    Fehlermodulversion:	0.15.1.0
    Fehlermodulzeitstempel:	4f478c16
    Ausnahmecode:	40000015
    Ausnahmeoffset:	00053b06
    Betriebsystemversion:	6.1.7601.2.1.0.256.48
    Gebietsschema-ID:	1031
    Zusatzinformation 1:	bf8d
    Zusatzinformation 2:	bf8d49108a2e5a0707fc48438e01652a
    Zusatzinformation 3:	b0f1
    Zusatzinformation 4:	b0f155b0f1de9c5eb22bd6d100737cbe

  If somebody can understand that behaviour I appreciate everybodies help. =
Thank you with regards
  H.O.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1314667/+subscriptions
