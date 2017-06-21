Received: from eggs.gnu.org ([2001:4830:134:3::10]:50061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNcNQ-0002vC-Dt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNcNN-0003wg-CU
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:56:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNcNN-0003wP-6M
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:56:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNcNM-0005or-1L
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:56:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0972E2E8190
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:56:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2017 09:37:48 -0000
From: Kevin Wolf <1042654@bugs.launchpad.net>
Reply-To: Bug 1042654 <1042654@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120828092908.6948.63420.malonedeb@gac.canonical.com>
Message-Id: <149803786830.2968.5586674901900135180.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1042654] Re: Floppy disks and network not working
 on NT 3.1 on Qemu 1.2 rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The floppy fix appears to be commit 34abf9a7 (contained in qemu 1.3).

I don't think anyone ever looked into the networking problem.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1042654

Title:
  Floppy disks and network not working on NT 3.1 on Qemu 1.2 rc1

Status in QEMU:
  Incomplete

Bug description:
  When I try to put Floppy IMG/IMA/VFD images on NT 3.1 when it is running =
on Qemu 1.2 rc, they are not recognized and the network is not working even=
 though I set it correctly (especially the AMD PCnet adapter)
  Here's some screenshot of the floppy error:
  http://i49.tinypic.com/j77wcw.png

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1042654/+subscriptions
