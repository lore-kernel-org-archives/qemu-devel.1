Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUR19-0006gX-BO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUR14-00083s-6d
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:50:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:47554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gUR13-0007zP-Ue
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 01:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gUR11-0000bg-DP
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 307D92E80D2
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 06:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Dec 2018 06:43:46 -0000
From: YVT <1806824@bugs.launchpad.net>
Reply-To: Bug 1806824 <1806824@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806824] [NEW] SIE-200 (TrustZone) MPC: BLK_MAX
 returns an incorrect value
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

Version: =

$ qemu-system-arm --version
QEMU emulator version 3.0.92 (v3.1.0-rc2-31-gd522fba244)

Arm SIE-200 Technical Reference Manual describes that BLK_MAX indicates
the maximum value of "block based index register" (BLK_IDX). For
example, the value 1 would indicate that BLK_IDX can be 0 or 1.
According to my experiments, the AN505 FPGA image apparently follows
this behavior.

In the current implementation of QEMU, it appears to indicate the number
of possible values for BLK_IDX, i.e., one plus the value it's supposed
to return.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806824

Title:
  SIE-200 (TrustZone) MPC: BLK_MAX returns an incorrect value

Status in QEMU:
  New

Bug description:
  Version: =

  $ qemu-system-arm --version
  QEMU emulator version 3.0.92 (v3.1.0-rc2-31-gd522fba244)

  Arm SIE-200 Technical Reference Manual describes that BLK_MAX
  indicates the maximum value of "block based index register" (BLK_IDX).
  For example, the value 1 would indicate that BLK_IDX can be 0 or 1.
  According to my experiments, the AN505 FPGA image apparently follows
  this behavior.

  In the current implementation of QEMU, it appears to indicate the
  number of possible values for BLK_IDX, i.e., one plus the value it's
  supposed to return.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806824/+subscriptions
