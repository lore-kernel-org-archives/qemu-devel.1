Received: from eggs.gnu.org ([2001:4830:134:3::10]:55297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sL-0003PX-U4
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sI-0003lC-Dy
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:43252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cM5sI-0003kl-9B
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cM5sE-0001MX-By
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 583B92E80E8
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2016 04:17:27 -0000
From: Launchpad Bug Tracker <589231@bugs.launchpad.net>
Reply-To: Bug 589231 <589231@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100603153106.22969.43302.malonedeb@soybean.canonical.com>
Message-Id: <20161228041728.17184.67874.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 589231] Re: cirrus vga is very slow in
 qemu-kvm-0.12
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
https://bugs.launchpad.net/bugs/589231

Title:
  cirrus vga is very slow in qemu-kvm-0.12

Status in QEMU:
  Expired

Bug description:
  As has been reported multiple times (*), there were a regression in
  qemu-kvm from 0.11 to 0.12, which causes significant slowdown in
  cirrus vga emulation.  For windows guests, where "standard VGA" driver
  works reasonable well, -vga std is a good workaround. But for e.g.
  linux guests, where vesa driver is painfully slow by its own, that's
  not a solution.

  (*)
   debian qemu-kvm bug report #574988: http://bugs.debian.org/574988#17
   debian qemu bugreport (might be related): http://bugs.debian.org/575720
   kvm mailinglist thread: http://www.mail-archive.com/kvm@vger.kernel.org/=
msg33459.html
   another kvm ml thread: http://www.mail-archive.com/kvm@vger.kernel.org/m=
sg32744.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/589231/+subscriptions
