Received: from eggs.gnu.org ([2001:4830:134:3::10]:57460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSnil-00087a-A2
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSnii-0006bd-4i
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:40:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:56628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gSnih-0006bM-Ui
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:40:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gSnig-0004Ud-8m
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 18:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 20E412E80CC
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 18:40:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Nov 2018 18:32:21 -0000
From: Paolo Bonzini <bonzini@gnu.org>
Reply-To: Bug 1806040 <1806040@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154358384987.15321.7664021717575522872.malonedeb@soybean.canonical.com>
Message-Id: <154360274167.15793.3765961726296052363.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806040] Re: Nested VMX virtualization error on
 last Qemu versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

the kernel you are using should not have nested virtualization enabled
by default.  Are you by chance using nested virtualization of some other
virtual machines?  If so, it's enough to add "-vmx" at the end of "-cpu
host,-hypervisor,kvm=3Doff".

If you are not sure of the answer, please check if your
/etc/modprobe.conf file, or any file in your /etc/modprobe.d directory,
contains the line "options kvm_intel nested=3D1".

Thanks!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806040

Title:
  Nested VMX virtualization error on last Qemu versions

Status in QEMU:
  New

Bug description:
  Recently updated Qemu on a Sony VAIO sve14ag18m with Ubuntu Bionic
  4.15.0-38 from Git

  After launching a few VMs, noticed that i could not create Snapshot due t=
o this error:
  "Nested VMX virtualization does not support live migration yet"

  I've created a new Windows 7 X64 machine with this compilation of Qemu
  and the problem persisted, so it's not because of the old machines.

  I launch Qemu with this params (I use them for malware analisys adn re...=
):
  qemu-system-x86_64 -monitor stdio -display none -m 4096 -smp cpus=3D4 -us=
bdevice tablet -drive file=3DVM.img,index=3D0,media=3Ddisk,format=3Dqcow2,c=
ache=3Dunsafe -net nic,macaddr=3D"...." -net bridge,br=3Dbr0 -cpu host,-hyp=
ervisor,kvm=3Doff -vnc 127.0.0.1:0 -enable-kvm =


  =

  Deleting the changes made on this commit solved the problem, but I dont h=
ave idea what is this for, so... xDD =

  https://github.com/qemu/qemu/commit/d98f26073bebddcd3da0ba1b86c3a34e840c0=
fb8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806040/+subscriptions
