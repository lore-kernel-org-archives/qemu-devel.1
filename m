Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHYeN-0007Pr-2X
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHYeK-0003lm-D5
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:48265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHYeK-0003lS-72
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHYeI-0004iQ-Sb
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 16:12:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 94C412E80D0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 16:12:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 15:52:39 -0000
From: Thomas Huth <712416@bugs.launchpad.net>
Reply-To: Bug 712416 <712416@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110203122616.12078.50539.malonedeb@palladium.canonical.com>
Message-Id: <20161215155240.19859.74210.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 712416] Re: kvm_intel kernel module crash with
 via nano vmx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This does not sound like a QEMU bug, so let's remove it from the QEMU
bug tracker

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/712416

Title:
  kvm_intel kernel module crash with via nano vmx

Status in linux package in Ubuntu:
  Confirmed
Status in kvm package in Debian:
  New

Bug description:
  kvm module for hardware virtualisation not work properly on via nano
  processors.

  Tested with processor: VIA Nano processor U2250.
  Processors flags (visible in /proc/cpuinfo): fpu vme de pse tsc msr pae m=
ce cx8 apic sep mtrr pge mca cmov pat clflush acpi mmx fxsr sse sse2 ss tm =
syscall nx lm constant_tsc up rep_good pni monitor vmx est tm2 ssse3 cx16 x=
tpr rng rng_en ace ace_en ace2 phe phe_en lahf_lm

  With kernel 2.6.32: kvm not work and dmesg contains a lot of:
  handle_exception: unexpected, vectoring info 0x8000000d intr info 0x80000=
b0d

  With kernel 2.6.35: all the system crash. Nothing visible in logs

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/712416/+subscriptions
