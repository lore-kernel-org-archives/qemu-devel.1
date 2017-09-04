Received: from eggs.gnu.org ([2001:4830:134:3::10]:49466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dovgT-0007Oc-A8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dovgO-0006nG-KM
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:01:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dovgO-0006mr-EI
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:01:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dovgM-00065Q-SP
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 18:01:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9EE102E80D3
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 18:01:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Sep 2017 17:48:02 -0000
From: dcb <1715007@bugs.launchpad.net>
Reply-To: Bug 1715007 <1715007@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150454728299.11465.16419614126542209437.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715007] [NEW] hw/block/onenand.c:520: dead code ?
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

qemu/hw/block/onenand.c:520] -> [qemu/hw/block/onenand.c:521]: (warning)
Opposite inner 'if' condition leads to a dead code block.

Source code is

        for (b =3D 0; b < s->blocks; b ++) {
            if (b >=3D s->blocks) {
                s->status |=3D ONEN_ERR_CMD;
                break;
            }

I am not sure if the if condition can be merely deleted, or something more
complex needs to be implemented.

Recent qemu trunk.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715007

Title:
  hw/block/onenand.c:520: dead code ?

Status in QEMU:
  New

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
