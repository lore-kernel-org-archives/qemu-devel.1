Received: from eggs.gnu.org ([2001:4830:134:3::10]:36882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs1CY-0003J1-KM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0yT-0004UV-3Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:21:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:58250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0yS-0004Sy-Mr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:21:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0yO-0003Us-Uw
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:21:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BEB8E2E8577
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:20:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 07:08:37 -0000
From: Andrew Cloke <andrew.cloke@canonical.com>
Reply-To: Bug 1788098 <1788098@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153482722911.31087.14583787529820350039.malonedeb@soybean.canonical.com>
Message-Id: <153483531811.30743.8198231266001326787.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788098] Re: Avoid migration issues with aligned
 2MB THB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: ubuntu-power-systems
   Importance: Undecided
       Status: New

** Changed in: ubuntu-power-systems
     Assignee: (unassigned) =3D> Canonical Kernel Team (canonical-kernel-te=
am)

** Changed in: ubuntu-power-systems
   Importance: Undecided =3D> Critical

** Tags added: triage-g

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788098

Title:
  Avoid migration issues with aligned 2MB THB

Status in The Ubuntu-power-systems project:
  New
Status in linux package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Invalid
Status in linux source package in Bionic:
  Confirmed
Status in linux source package in Cosmic:
  Confirmed

Bug description:
  ------- Comment From jhopper@us.ibm.com 2018-08-20 17:12 EDT-------
  Hi, in some environments it was observed that this qemu patch to enable T=
HP made it more likely to hit guest migration issues, however the following=
 kernel patch resolves those migration issues:

  https://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/commit=
/?h=3Dkvm-ppc-next&id=3Dc066fafc595eef5ae3c83ae3a8305956b8c3ef15
  KVM: PPC: Book3S HV: Use correct pagesize in kvm_unmap_radix()

  Once merged upstream, it would be good to include that change as well
  to avoid potential migration problems. Should I open a new bug for
  that or is it better to track here?

  Note Paelzer: I have not seen related migration issues myself, but it
  seems reasonable and confirmed by IBM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/1788098/+subscriptions
