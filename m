Received: from eggs.gnu.org ([2001:4830:134:3::10]:56270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtqax-000534-3N
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtqau-0005tn-0i
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:35:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:39497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dtqat-0005ta-Pl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:35:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dtqar-0008VT-BK
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C6CA2E848E
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:35:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Sep 2017 07:20:21 -0000
From: Thomas Huth <838974@bugs.launchpad.net>
Reply-To: Bug 838974 <838974@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110901174811.31330.49506.malonedeb@soybean.canonical.com>
Message-Id: <150571922120.23300.9251167386457354879.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 838974] Re: Confusing error report for missing
 vde support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think this has been fixed by this commit here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dd139e9a6cf01b8c31f59
... so closing this ticket now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/838974

Title:
  Confusing error report for missing vde support

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Triaged

Bug description:
  The error that appears in qemu 0.15 is "parameter 'type' expects a
  network client type" when trying to use vde for networking as if the
  parameter is wrong, but the problem is that the executable was
  compiled without vde support.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/838974/+subscriptions
