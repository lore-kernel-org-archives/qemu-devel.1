Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaDSF-0007jv-7W
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaDSC-00005E-53
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:30:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eaDSB-0008WU-Vc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:30:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eaDSA-0006AY-6U
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4BC142E8689
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 04:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jan 2018 04:17:24 -0000
From: Launchpad Bug Tracker <530077@bugs.launchpad.net>
Reply-To: Bug 530077 <530077@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100301145813.10998.7671.malonedeb@gandwana.canonical.com>
Message-Id: <151581704488.16027.6460589485624000311.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 530077] Re: kvm: 16-bit code execution failure
 should be more friendly
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
https://bugs.launchpad.net/bugs/530077

Title:
  kvm: 16-bit code execution failure should be more friendly

Status in QEMU:
  Expired

Bug description:
  Today, when kvm fails at 16-bit code execution, we report:

       spirit:~/qemu> qemu-kvm ./hda-fedora.img =

       kvm: unhandled exit 80000021
       kvm_run returned -22

  There are three reasons exit reason 21 happens.  The first is that a
  user is executing an image containing a workload that uses GFXBOOT or
  some other bootloader that exercises big real mode.  On pre-Westmere
  Intel processors, VT could not handle big real mode.  The second
  reason is that the guest's image is corrupted and we're executing
  random code.  We accidentally fall into one of the unsupported modes
  for VT.  Again, this is addressed on WSM.  The third case is where
  there's an actual bug in KVM.  This should be exceedingly rare at this
  stage.

  We should present a friendly error message explaining the possible
  causes and recommending corrective action.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/530077/+subscriptions
