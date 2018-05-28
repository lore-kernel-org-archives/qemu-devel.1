Received: from eggs.gnu.org ([2001:4830:134:3::10]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNHbn-0002BR-JZ
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNHbi-0002oi-Np
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:50:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:51540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fNHbi-0002oL-GH
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:50:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fNHbh-0004bO-Ea
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 12:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E1F52E80CB
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 12:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 May 2018 12:36:58 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reply-To: Bug 1773753 <1773753@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152749874146.3829.13327505377905335957.malonedeb@chaenomeles.canonical.com>
Message-Id: <152751101886.3829.5753780494368544151.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1773753] Re: virsh managed save fails with qemu
 version v2.12.0-813-g5a5c383b13-dirty on powerpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

with above patch compiled on top of latest upstream fails with below
error:

# virsh managedsave avocado-vt-vm1 =

error: Failed to save domain avocado-vt-vm1 state
error: internal error: guest unexpectedly quit


rest of the behaviour same..
# virsh start avocado-vt-vm1 ----gets hung
---crtl+c --> to comeback to prompt
#

# virsh destroy avocado-vt-vm1
Domain avocado-vt-vm1 destroyed

# virsh undefine --managed-save avocado-vt-vm1
Domain avocado-vt-vm1 has been undefined

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1773753

Title:
  virsh managed save fails with qemu version
  v2.12.0-813-g5a5c383b13-dirty on powerpc

Status in QEMU:
  New

Bug description:
  Host Env:
  IBM Power8 with Fedora28 base with compiled upstream kernel, qemu, libvir=
t.

  Host Kernel: 4.17.0-rc5-00069-g3acf4e395260

  qemu-kvm(5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b):
  v2.12.0-813-g5a5c383b13-dirty

  libvirt(4804a4db33a37f828d033733bc47f6eff5d262c3):

  Guest Kernel: 4.17.0-rc7

  Steps to recreate:
  Define a guest attached with above setup and start.
  # virsh start avocado-vt-vm1

  guest console;...
  # uname -r
  4.17.0-rc7
  [root@atest-guest ~]# lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              3
  On-line CPU(s) list: 0-2
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           3
  NUMA node(s):        1
  Model:               2.1 (pvr 004b 0201)
  Model name:          POWER8 (architected), altivec supported
  Hypervisor vendor:   KVM
  Virtualization type: para
  L1d cache:           64K
  L1i cache:           32K
  NUMA node0 CPU(s):   0-2

  =

  # virsh managedsave avocado-vt-vm1 =


  Domain avocado-vt-vm1 state saved by libvirt

  # virsh list
   Id    Name                           State
  ----------------------------------------------------

  # virsh start avocado-vt-vm1 ----Hangs forever and vm state goes to
  paused.

  =

  # virsh list
   Id    Name                           State
  ----------------------------------------------------
   87    avocado-vt-vm1                 paused

  =

  P:S:- with same above setup, just changing the qemu-kvm comes bydefault w=
ith F28 works fine.

  /usr/bin/qemu-kvm --version
  QEMU emulator version 2.11.1(qemu-2.11.1-2.fc28)

  Summary: with above other setup.
  machine type pseries-2.12 and qemu-2.11.1-2.fc28 -Works fine.

  machine type pseries-2.12/pseries-2.13 and qemu
  5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b - Does not work.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1773753/+subscriptions
