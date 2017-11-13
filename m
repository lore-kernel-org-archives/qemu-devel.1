Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEBJP-0003s1-J8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEBJJ-0003ND-Ph
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:45:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEBJJ-0003Mf-Ji
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:45:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEBJG-0001t8-9l
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 48C612E80CB
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 09:29:47 -0000
From: Thomas Huth <530077@bugs.launchpad.net>
Reply-To: Bug 530077 <530077@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100301145813.10998.7671.malonedeb@gandwana.canonical.com>
Message-Id: <151056538784.28361.1550278445471721702.malone@gac.canonical.com>
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

Triaging old bug tickets... has this ever been fixed, thus could we
close this ticket nowadays? Or is there something left to do here?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

** Changed in: qemu
     Assignee: Anthony Liguori (anthony-codemonkey) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/530077

Title:
  kvm: 16-bit code execution failure should be more friendly

Status in QEMU:
  Incomplete

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
