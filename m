Received: from eggs.gnu.org ([2001:4830:134:3::10]:59462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dY1i0-0008No-4h
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dY1hx-0002eC-4T
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:40496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dY1hw-0002d9-UH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dY1hv-0003pM-0s
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 03:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ECFAB2E8076
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 03:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 02:48:30 -0000
From: Imatimba <1703506@bugs.launchpad.net>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150051891065.24380.15244780733870407217.malone@soybean.canonical.com>
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

Attached Ubuntu 17.04 guest logs.
I wasn't able to run x86info as root. Only as regular user.
Error shown:
readEntry: Operation not permitted
error reading 1KB from 0x3fffc00

There are a few bug reports about it but no workarounds. Seems to happen on=
 vm's.
So the output is missing a few sections.

>Also, can somebody confirm if the same Windows version works as
expected on bare metal?

Yes, same Windows version on bare metal works as expected. In my case showi=
ng 8 cores and 16 threads/logical processors.
I'm trying to use 4 cores 8 threads in the VMs. Both Windows and Ubuntu are=
 showing 8 physical cores.

** Attachment added: "ubuntu-guest-smt-ryzen.zip"
   https://bugs.launchpad.net/qemu/+bug/1703506/+attachment/4917874/+files/=
ubuntu-guest-smt-ryzen.zip

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
