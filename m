Received: from eggs.gnu.org ([209.51.188.92]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRUR-0003Dg-8p
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRUQ-0004Yd-F2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggRUO-0003lJ-RA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggRUA-0005lU-0n
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:46:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EDFEE2E80CB
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 09:46:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jan 2019 09:31:39 -0000
From: Thomas Huth <1535497@bugs.launchpad.net>
Reply-To: Bug 1535497 <1535497@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160119020241.26347.75552.malonedeb@soybean.canonical.com>
Message-Id: <154685349913.5548.15967341276819033984.malone@wampee.canonical.com>
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

Can you still reproduce this issue with the latest version of QEMU? If
this is a bug in seabios, have you tried to report this to seabios
instead?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1535497

Title:
  Guest can not boot up when assigned more than 20 vcpus with option
  "-no-acpi"

Status in QEMU:
  Incomplete

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
