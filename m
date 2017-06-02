Received: from eggs.gnu.org ([2001:4830:134:3::10]:55857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGfnl-0004bk-3v
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGfng-00042v-5i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:33955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dGfnf-00042T-Vr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:11:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dGfnc-0001FE-EW
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:11:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C15652E819A
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 06:11:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2017 06:00:53 -0000
From: wufucious <wonderfulwyqi9300@gmail.com>
Reply-To: Bug 1695169 <1695169@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149638325345.18112.8568328305518116665.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1695169] [NEW] qga fail to start when pidfile
 path is missing
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

The qga main program has two parameters: "--logfile" and "--pidfile"
which specifies the paths to the logfile and pidfile. It assumes that
the paths exit in the running OS but if not, the qga will fail to
start.I think qga should create the missing paths.

I found this bug exits in several Linux distributions including Ubuntu
14, Cent-OS 6 and 7 when the original and the latest master qga applies.
I have a patch which can fix it. Should I patch it to the QEMU master
branch?

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qga

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1695169

Title:
  qga fail to start when pidfile path is missing

Status in QEMU:
  New

Bug description:
  The qga main program has two parameters: "--logfile" and "--pidfile"
  which specifies the paths to the logfile and pidfile. It assumes that
  the paths exit in the running OS but if not, the qga will fail to
  start.I think qga should create the missing paths.

  I found this bug exits in several Linux distributions including Ubuntu
  14, Cent-OS 6 and 7 when the original and the latest master qga
  applies. I have a patch which can fix it. Should I patch it to the
  QEMU master branch?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1695169/+subscriptions
