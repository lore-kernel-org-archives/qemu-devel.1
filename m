Received: from eggs.gnu.org ([209.51.188.92]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdQ-0001QX-Tq
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdP-00017p-Sr
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:48672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2TdP-00016R-MH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2TdO-000102-2s
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 04:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED2CA2E80D2
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 04:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Mar 2019 04:17:33 -0000
From: Launchpad Bug Tracker <1535497@bugs.launchpad.net>
Reply-To: Bug 1535497 <1535497@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160119020241.26347.75552.malonedeb@soybean.canonical.com>
Message-Id: <155210505393.19923.10172508958880254198.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1535497] Re: Guest can not boot up when assigned
 more than 20 vcpus with option "-no-acpi"
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
https://bugs.launchpad.net/bugs/1535497

Title:
  Guest can not boot up when assigned more than 20 vcpus with option
  "-no-acpi"

Status in QEMU:
  Expired

Bug description:
  Environment:
   -------------------------------
   KVM commit/branch: da3f7ca3/next
   Qemu commit/branch: 7b8a354d/master
   Host OS: RHEL7.2 ia32e
   Host Kernel: 4.4-rc2
   Guest OS: RHEL7.2 ia32e

  Description:
   --------------------------------
  When assign more than 20 vpcus with option "-no-acpi", guest can not boot=
 up.

  Reproduce:
   ----------------
   1.qemu-system-x86_64 --enable-kvm -m 1024 -smp 20 -no-acpi -device virti=
o-net-pci,netdev=3Dnic0,mac=3D00:16:3e:17:9b:4c -netdev tap,id=3Dnic0,scrip=
t=3D/etc/kvm/qemu-ifup -drive file=3D/root/7u2.qcow2,if=3Dnone,id=3Dvirtio-=
disk0 -device virtio-blk-pci,drive=3Dvirtio-disk0

  =

  Bisect show the bad commit is 9ee2e2625 of seabios.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1535497/+subscriptions
