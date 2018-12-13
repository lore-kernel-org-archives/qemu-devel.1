Received: from eggs.gnu.org ([2001:4830:134:3::10]:34149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXTRM-00047X-KY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXTRG-0004C5-RY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:54346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXTRG-0003t0-I4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXTR4-0001P6-MF
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:02:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A740D2E808D
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:02:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Dec 2018 15:49:18 -0000
From: asd fghjkl <1703506@bugs.launchpad.net>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <154471615856.28534.5674193010214819135.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703506] Re: SMT not supported by QEMU on AMD
 Ryzen CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I got it to work:
sudo nano /etc/modprobe.d/kvm.conf
add "options kvm ignore_msrs=3D1" (without quotes)
reboot

Then changing "-machine q35" to "-machine pc" kept it from crashing
randomly.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703506

Title:
  SMT not supported by QEMU on AMD Ryzen CPU

Status in QEMU:
  New

Bug description:
  HyperThreading/SMT is supported by AMD Ryzen CPUs but results in this
  message when setting the topology to threads=3D2:

  qemu-system-x86_64: AMD CPU doesn't support hyperthreading. Please
  configure -smp options properly.

  Checking in a Windows 10 guest reveals that SMT is not enabled, and
  from what I understand, QEMU converts the topology from threads to
  cores internally on AMD CPUs. This appears to cause performance
  problems in the guest perhaps because programs are assuming that these
  threads are actual cores.

  Software: Linux 4.12, qemu 2.9.0 host with KVM enabled, Windows 10 pro
  guest

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703506/+subscriptions
