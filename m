Received: from eggs.gnu.org ([2001:4830:134:3::10]:55077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRQPO-0003z0-80
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 17:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRQPL-0003e9-1o
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 17:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:41916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRQPK-0003dV-Rt
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 17:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRQPJ-0003m6-VC
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 22:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E63BE2E802D
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 22:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2017 22:21:14 -0000
From: lamby <1739304@bugs.launchpad.net>
Reply-To: Bug 1739304 <1739304@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739304] [NEW] Passing a directory to (eg.)
 -cdrom results in misleading error message
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

For example:

    qemu-system-x86_64 -cdrom /path/to/directory

Results in:

    Could not read image for determining its format: File too large

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739304

Title:
  Passing a directory to (eg.) -cdrom results in misleading error
  message

Status in QEMU:
  New

Bug description:
  For example:

      qemu-system-x86_64 -cdrom /path/to/directory

  Results in:

      Could not read image for determining its format: File too large

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739304/+subscriptions
