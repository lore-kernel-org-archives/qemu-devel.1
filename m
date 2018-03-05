Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esnYI-0000ap-Ir
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esnYD-0008LS-Ls
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:41:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:43300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1esnYC-0008IT-Tx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:41:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1esnY9-0004XE-IA
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 10:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 591B62E80D3
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 10:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Mar 2018 10:31:37 -0000
From: dcb <1753437@bugs.launchpad.net>
Reply-To: Bug 1753437 <1753437@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753437] [NEW] qemu/pc-bios/s390-ccw/libc.c:82:
 bad test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu/pc-bios/s390-ccw/libc.c:82]: (style) Unsigned variable 'num_idx'
can't be negative so it is unnecessary to test it.

Source code is


    while (num_idx >=3D 0) {

but

    size_t num_idx =3D 1; /* account for NUL */

So there is no escape from the while loop.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753437

Title:
  qemu/pc-bios/s390-ccw/libc.c:82: bad test ?

Status in QEMU:
  New

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
