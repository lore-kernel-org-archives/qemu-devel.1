Received: from eggs.gnu.org ([2001:4830:134:3::10]:58268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYlks-0001OB-1a
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYlko-0002Uo-SH
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:11:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:36504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYlko-0002UQ-MA
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:10:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYlkn-0003Aq-JI
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 04:10:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 90E5F2E806D
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 04:10:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Jul 2017 04:02:28 -0000
From: Imatimba <1703506@bugs.launchpad.net>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150069614873.24827.18322908405819029392.malone@soybean.canonical.com>
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

I tried disabling the CmpLegacy bit directly on /target/i386/cpu.c deleting=
 the If statement on "case 0x80000001:" or changing "*ecx |=3D 1 << 1;" to =
"*ecx |=3D 0 << 1;"
But it didn't work, the VM still sees 8 physical cores.
I believe the HTT bit should be enabled by default
I tried changing it to "*edx |=3D 1 << 28;" in the If statement of "case 1:=
" just in case but it didn't matter.
Anything else that I could try to hard-code for testing?

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
