Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1enGcj-0007FJ-KB
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1enGcg-0000TI-HM
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:32956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1enGcg-0000SR-B1
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1enGce-0008Jy-M4
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 04:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7E14C2E80D0
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 04:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Feb 2018 04:17:35 -0000
From: Launchpad Bug Tracker <1211910@bugs.launchpad.net>
Reply-To: Bug 1211910 <1211910@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130813175222.16219.80463.malonedeb@gac.canonical.com>
Message-Id: <151892745532.17410.3487852293402755993.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1211910] Re: Logical to linear address
 translation is wrong for 32-bit guests on a 64-bit hypervisor
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
https://bugs.launchpad.net/bugs/1211910

Title:
  Logical to linear address translation is wrong for 32-bit guests on a
  64-bit hypervisor

Status in QEMU:
  Expired

Bug description:
  I run a 64-bit hypervisor in qemu-system-x86_64 (without KVM) and on top =
of that I have a 32-bit guest. The guest configures the code-segment to hav=
e a base of 0x4000_0000 and a limit of 0xFFFF_FFFF with paging disabled. Th=
us, if a logical address of e.g. 0xC000_0000 is used, it should be translat=
ed to 0x0000_0000 (linear and physical), because of the overflow that happe=
ns.
  But this does not happen with the described setup. Instead, qemu seems to=
 calculate the logical to linear translation with 64-bit addresses so that =
no overflow happens. Consequently, the resulting address is 0x1_0000_0000 a=
nd this gets written to exitinfo2 in the VMCB structure. This causes troubl=
e for hypervisors that expect the upper 32 bits of exitinfo2 to be 0 for 32=
-bit guests.

  Note also that the exact same setup runs fine on real AMD machines
  with SVM. That is, the upper 32 bits in exitinfo2 are always 0 because
  of the overflow.

  I've tested that with the latest development version of QEMU (commit
  328465fd9f3a628ab320b5959d68d3d49df58fa6).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1211910/+subscriptions
