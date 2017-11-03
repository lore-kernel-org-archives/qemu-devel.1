Received: from eggs.gnu.org ([2001:4830:134:3::10]:39617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAWpz-0007HE-0Z
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAWpu-0003iJ-IJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:56:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:36534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAWpu-0003hu-Cw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:56:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAWpt-0004eB-8i
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 07:56:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02BA62E80CC
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 07:56:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 07:35:47 -0000
From: Thomas Huth <1013691@bugs.launchpad.net>
Reply-To: Bug 1013691 <1013691@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120615142445.16648.90728.malonedeb@wampee.canonical.com>
Message-Id: <150969454749.8905.9169019339497009092.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1013691] Re: ppc64 + virtio-scsi: only first scsi
 disk shows up in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU and guest kernel? Or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1013691

Title:
  ppc64 + virtio-scsi: only first scsi disk shows up in the guest

Status in QEMU:
  Incomplete

Bug description:
  When adding two virtio-scsi targets to a single guest, only the first
  disk is seen inside the guest.  For some unknown reason the guest
  doesn't enumerate the second disk.

  For full qemu-system-ppc64 command line and 'dmesg' output, see:

  http://lists.nongnu.org/archive/html/qemu-devel/2012-06/msg02430.html

  I have also tried this with Linus's git tree (3.5.0-rc2+ at time of writi=
ng),
  same thing.

  In both cases I'm using qemu from git.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1013691/+subscriptions
