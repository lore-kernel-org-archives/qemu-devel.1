Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f51zI-0004hC-Hy
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 00:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f51zD-0001uG-KA
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 00:31:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:54864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f51zD-0001ti-D3
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 00:31:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f51zB-0006aS-U5
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 04:31:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E1AEE2E80C8
	for <qemu-devel@nongnu.org>; Sun,  8 Apr 2018 04:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Apr 2018 04:17:25 -0000
From: Launchpad Bug Tracker <1416246@bugs.launchpad.net>
Reply-To: Bug 1416246 <1416246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150130060727.581.75467.malonedeb@chaenomeles.canonical.com>
Message-Id: <152316104543.12836.6949780295533116414.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1416246] Re: create guest fail when compile qemu
 with parameter "--disable-gtk"
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
https://bugs.launchpad.net/bugs/1416246

Title:
  create guest fail when compile qemu with parameter "--disable-gtk"

Status in QEMU:
  Expired

Bug description:
  Environment:
  ------------
  Host OS (ia32/ia32e/IA64):ia32e
  Guest OS (ia32/ia32e/IA64):ia32e
  Guest OS Type (Linux/Windows):Linux
  kvm.git Commit:8fff5e374a2f6047d1bb52288af7da119bc75765
  qemu.kvm Commit:16017c48547960539fcadb1f91d252124f442482
  Host Kernel Version:3.19.0-rc3
  Hardware:Ivytown_EP, Haswell_EP

  =

  Bug detailed description:
  --------------------------
  compile the qemu with disable gtk, the create guest , the guest create fa=
il

  note:
  1.qemu.git: 699eae17b841e6784dc3864bf357e26bff1e9dfe
  when compile the qemu with enable gtk or disable gtk, the guest create pa=
ss

  2. this should be a qemu bug
  kvm.git   +  qemu.git   =3D result
  8fff5e37  +  16017c48   =3D bad
  8fff5e37  +  699eae17   =3D good

  Reproduce steps:
  ----------------
  1. git clone git://vt-sync/qemu.git qemu.git
  2. cd qemu.git
  3. ./configure --target-list=3Dx86_64-softmmu --disable-sdl --disable-gtk
  4. make -j16
  5. ./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -net none=
 /root/rhel6u5.qcow

  Current result:
  ----------------
  create gust fail when compile qemu with disable gtk

  Expected result:
  ----------------
  create guest pass when compile qemu with disable or enable gtk

  Basic root-causing log:
  ----------------------
  [root@vt-ivt2 qemu.git]# ./x86_64-softmmu/qemu-system-x86_64 -enable-kvm =
-m 4G -smp 2 -net none /root/rhel6u5-1.qcow =

  qemu-system-x86_64: Invalid parameter 'to'
  Segmentation fault (core dumped)

  some dmesg message:
  qemu-system-x86[96364]: segfault at 24 ip 00007fe6d9636a69 sp 00007fffc03=
cf970 error 4 in qemu-system-x86_64[7fe6d9330000+4ba000]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1416246/+subscriptions
