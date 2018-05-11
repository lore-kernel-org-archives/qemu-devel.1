Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH7Gp-0001jL-VN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH7Gm-00011c-PV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:35:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:57834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fH7Gm-00010Z-HV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:35:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fH7Gl-0000GU-0k
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 12:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB41A2E8A3E
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 12:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 May 2018 12:28:54 -0000
From: =?utf-8?q?Mathias_B=C3=B6sl?= <1769189@bugs.launchpad.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <152604173427.27564.8624153424603133544.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + UEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have the same issue. When I open the task manager on the virtualized Wind=
ows 10 VM I see the HDD time is at 100% but the data transfer rate is actua=
l 0b/s. =

I've tried any combination of the options below and the issue was always re=
producible with qemu-2.12.0-1 and never with qemu-2.11.1-2.

Linux kernels:
- 4.14.5-1
- 4.16.7

Windows 10 Verson (for the VM) =

- 1709
- 1803

Boot HDD for VM
- Actual SSD (/dev/sda)
- QCOW2 Image

QEMU =

- qemu-2.11.1-2
- qemu-2.12.0-1


I also use ARCH Linux and have also downgraded to pre 2.12 QEMU

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + UEFI

Status in QEMU:
  New

Bug description:
  (first reported here:
  https://bugzilla.tianocore.org/show_bug.cgi?id=3D949 )

  I had a Windows 10 VM running perfectly fine with OVMF UEFI, since I
  upgraded to qemu 2.12, the guests hangs for a couple of minutes, works
  for a few seconds, and hangs again, etc. By "hang" I mean it doesn't
  freeze, but it looks like it's waiting on IO or something, I can move
  the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with OVMF
  What works: using BIOS or downgrading qemu to 2.11.1.

  Platform is arch linux 4.16.7 on skylake, I have attached the vm xml
  file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
