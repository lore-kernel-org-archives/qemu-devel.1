Received: from eggs.gnu.org ([2001:4830:134:3::10]:60727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXmPz-0006fc-Sq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXmPw-0001NY-Ez
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:41:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:60990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXmPw-0001N2-8x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:41:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXmPu-0001aR-GP
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 10:41:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 667CA2E8080
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 10:41:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 10:32:00 -0000
From: Imatimba <1703506@bugs.launchpad.net>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150046032080.26937.4760367254784989172.malone@chaenomeles.canonical.com>
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

I can confirm the same behavior with a Ryzen 7 1700.
Host Arch Linux x64 Kernel 4.11.9, Guest Windows 10 Pro.
Running with -cpu host and -smp 8,sockets=3D1,cores=3D4,threads=3D2.
Attached the logs of the host and results of the output of msinfo32 and "WM=
IC CPU Get NumberOfCores,NumberOfLogicalProcessors /Format:List" in the gue=
st.
Same results as scix, in my case 8 Core(s), 8 Logical Processors(s).

This seems relevant: https://bugzilla.redhat.com/show_bug.cgi?id=3D1135772
And a few extra reports on reddit:
https://www.reddit.com/r/VFIO/comments/6nuhb5/big_problem_with_my_ryzen_170=
0x/
https://www.reddit.com/r/VFIO/comments/6m6kry/smthyperthreading_support_wit=
h_ryzen_cpu_and/

I'll test with a Linux guest later.

** Bug watch added: Red Hat Bugzilla #1135772
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1135772

** Attachment added: "smt-ryzen.zip"
   https://bugs.launchpad.net/qemu/+bug/1703506/+attachment/4917550/+files/=
smt-ryzen.zip

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
