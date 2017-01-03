Received: from eggs.gnu.org ([2001:4830:134:3::10]:33459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOFeb-0007jk-4R
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOFeW-0004n3-78
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:20:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOFeV-0004mk-I0
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:20:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOFeU-0003Pc-Cy
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 03:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 541A82E80C0
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 03:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Jan 2017 03:13:32 -0000
From: Nathan Rennie-Waldock <1653577@bugs.launchpad.net>
Reply-To: Bug 1653577 <1653577@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170103031332.1493.46452.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1653577] [NEW] Ability to set umask for 9pfs
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

We should be able to specify the umask for 9pfs so that files created by
the guest can be accessed by other users on the host. Currently they're
only accessible by the user running qemu (and of course, root).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653577

Title:
  Ability to set umask for 9pfs

Status in QEMU:
  New

Bug description:
  We should be able to specify the umask for 9pfs so that files created
  by the guest can be accessed by other users on the host. Currently
  they're only accessible by the user running qemu (and of course,
  root).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1653577/+subscriptions
