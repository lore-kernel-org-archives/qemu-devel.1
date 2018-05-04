Received: from eggs.gnu.org ([2001:4830:134:3::10]:54544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEbQP-0005PO-A7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEbQL-0003ib-7P
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:11:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fEbQL-0003hs-0z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:11:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fEbQJ-0002az-HA
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 14:10:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 765C52E80CD
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 14:10:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 May 2018 14:00:34 -0000
From: Thomas Huth <1753437@bugs.launchpad.net>
Reply-To: Bug 1753437 <1753437@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
Message-Id: <152544243446.2445.5905481147184491203.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753437] Re: pc-bios/s390-ccw/libc: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been committed:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De4f869621203955761c

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753437

Title:
  pc-bios/s390-ccw/libc: size_t should be unsigned

Status in QEMU:
  Fix Committed

Bug description:
  qemu/pc-bios/s390-ccw/libc.c:82]: (style) Unsigned variable 'num_idx'
  can't be negative so it is unnecessary to test it.

  Source code is

  =

      while (num_idx >=3D 0) {

  but

      size_t num_idx =3D 1; /* account for NUL */

  So there is no escape from the while loop.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753437/+subscriptions
