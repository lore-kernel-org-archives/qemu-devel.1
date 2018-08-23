Received: from eggs.gnu.org ([2001:4830:134:3::10]:50347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fsmyK-0000Zd-DQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fsmyH-0007w7-LR
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:36:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fsmyH-0007uk-Bd
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:36:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fsmyG-0000r8-AS
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:36:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C3DB2E851D
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:36:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Aug 2018 10:23:44 -0000
From: costinel <1775702@bugs.launchpad.net>
Reply-To: Bug 1775702 <1775702@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152840439622.3676.18260529468873821664.malonedeb@chaenomeles.canonical.com>
Message-Id: <153501982483.3422.13362300413530237341.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1775702] Re: High host CPU load and slower guest
 after upgrade guest OS Windows 10 to ver 1803
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hv_synic && hv_stimer only reduces the cpu from 40-50% to 4-5%.
still expecting under 1% like linux guests.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775702

Title:
  High host CPU load and slower guest after upgrade guest OS Windows 10
  to ver 1803

Status in QEMU:
  New

Bug description:
  After upgrading Windows 10 guest to version 1803, guests VM runs
  slower and there is high host CPU load even when guest is almost idle.
  Did not happened with windows 10 up to version 1709.

  See my 1st report here:
  https://askubuntu.com/questions/1033985/kvm-high-host-cpu-load-after-upgr=
ading-vm-to-windows-10-1803

  Another user report is here:
  https://lime-technology.com/forums/topic/71479-windows-10-vm-cpu-usage/

  Tested on: Ubuntu 16.04 with qemu 2.5.0 and i3-3217U, Arch with qemu
  2.12 i5-7200U, Ubuntu 18.04 qemu 2.11.1 AMD FX-4300. All three
  platform showing the same slowdown and higher host cpu load with
  windows 10 1803 VM compared to windows 10 1709 VM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1775702/+subscriptions
