Received: from eggs.gnu.org ([2001:4830:134:3::10]:54349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZG0U-000706-4Q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZG0R-0001ew-OP
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:05:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZG0R-0001eS-HX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:05:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZEHk-0004OI-Px
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:15:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B03702E80CB
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 12:03:37 -0000
From: Stefan Hajnoczi <1806196@bugs.launchpad.net>
Reply-To: Bug 1806196 <1806196@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154368343637.32200.15942853285785778925.malonedeb@wampee.canonical.com>
Message-Id: <154513461709.1689.2719575683203925584.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806196] Re: qed leaked clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for reporting this.  QED is not widely used and its features have
been incorporated into qcow2, QEMU's native image format.  Since there
is no development effort behind QED it is unlikely that this bug will be
addressed.  Patches are always welcome though!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806196

Title:
  qed leaked clusters

Status in QEMU:
  New

Bug description:
  There are examples of two QED files which AFAIK does not have any
  errors both. But `qemu-img check` says that one of them has 1 leaked
  cluster.

  I wrote my own tool and it does not find any error. Both files
  attached, as well as debug output from my program.

  Both files are about 4G in size after unpacking. Unpack with `tar -S`
  to handle sparse files.

  And also, I know, that QED is deprecated, but anyway, seems qemu-img
  has bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806196/+subscriptions
