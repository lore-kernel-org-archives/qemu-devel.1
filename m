Received: from eggs.gnu.org ([2001:4830:134:3::10]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2IfN-0006wA-3q
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2IfI-0000Sh-KS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:11:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2IfI-0000SO-DV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:11:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2IfG-0000T3-QK
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 15:11:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 704062E80CF
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 15:11:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2017 14:57:51 -0000
From: Thomas Huth <1715007@bugs.launchpad.net>
Reply-To: Bug 1715007 <1715007@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150454728299.11465.16419614126542209437.malonedeb@wampee.canonical.com>
Message-Id: <150773387138.7817.7400714605287945112.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715007] Re: hw/block/onenand.c:520: dead code ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has now been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ddbfa934106d22402d

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715007

Title:
  hw/block/onenand.c:520: dead code ?

Status in QEMU:
  Fix Committed

Bug description:
  qemu/hw/block/onenand.c:520] -> [qemu/hw/block/onenand.c:521]:
  (warning) Opposite inner 'if' condition leads to a dead code block.

  Source code is

          for (b =3D 0; b < s->blocks; b ++) {
              if (b >=3D s->blocks) {
                  s->status |=3D ONEN_ERR_CMD;
                  break;
              }

  I am not sure if the if condition can be merely deleted, or something more
  complex needs to be implemented.

  Recent qemu trunk.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715007/+subscriptions
