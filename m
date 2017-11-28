Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJUUt-0002Et-M9
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJUUq-0005fv-IL
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:15:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:40474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJUUq-0005fb-Bs
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:15:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJUUp-0002ky-C9
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 01:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 548852E806B
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 01:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2017 01:05:45 -0000
From: Timothy Pearson <kb9vqf@pearsoncomputing.net>
Reply-To: Bug 1734792 <1734792@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151183114573.10651.11339653840196724023.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1734792] [NEW] qemu-x86_64 fails with unsupported
 syscall 319
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

qemu-x86_66 GIT HEAD fails on a userspace application that requires
memfd_create with:

"qemu: Unsupported syscall: 319".

memfd_create support needs to be implemented in QEMU.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1734792

Title:
  qemu-x86_64 fails with unsupported syscall 319

Status in QEMU:
  New

Bug description:
  qemu-x86_66 GIT HEAD fails on a userspace application that requires
  memfd_create with:

  "qemu: Unsupported syscall: 319".

  memfd_create support needs to be implemented in QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1734792/+subscriptions
