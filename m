Received: from eggs.gnu.org ([209.51.188.92]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjW3m-0007Sb-BM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjW3k-0001TG-QP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjW3k-0001RS-HT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:15:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjW3c-0005eY-66
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 21:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2C55E2E8029
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 21:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 21:04:01 -0000
From: Chris Ward <1811782@bugs.launchpad.net>
Reply-To: Bug 1811782 <1811782@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154754407492.19252.12061263609650359528.malonedeb@gac.canonical.com>
Message-Id: <154758624202.9333.5319831698206961618.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811782] Re: QEMU Windows fails to mount rootfs
 on an ISO where QEMU Linux works normally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This turned out to be not enough memory allocated to the virtual
machine. When I added "-m 1024" to the parameters, all was well.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811782

Title:
  QEMU Windows fails to mount rootfs on an ISO where QEMU Linux works
  normally

Status in QEMU:
  New

Bug description:
  I have installed QEMU 3.1.0 for Microsoft Windows from https://qemu.weiln=
etz.de/w64/ . When I give the command "qemu-system-x86_64.exe -cdrom ..\Qem=
uSaver\freeduc2.iso", qemu boots the ISO, but the resulting Linux kernel pa=
nics when trying to mount the root file system. Running the equivalent comm=
and under Linux (OpenSuSE Leap 15.0) results in success.
  I will attach a screenshot of the command and the kernel panic message.
  To reproduce the problem, download the zip file from Google Drive here ht=
tps://drive.google.com/file/d/1bAozvGeRF7PbkOnJKzrFHxhUh2kDLz6L/view?usp=3D=
sharing, and unpack it under Microsoft Windows. You can either run the inst=
aller (which will install QEMU 3.0.0 and an ISO image in C:\QemuSaver) or y=
ou can run the command I gave from the directory where your QEMU is install=
ed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811782/+subscriptions
