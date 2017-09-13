Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1v0-0005T2-EV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1ux-0002iO-51
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:36087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds1uw-0002hu-VN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds1uu-0008FD-Ge
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:17:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E900F2E8494
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:16:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:03:39 -0000
From: Thomas Huth <584146@bugs.launchpad.net>
Reply-To: Bug 584146 <584146@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100522092545.29377.46473.malonedeb@soybean.canonical.com>
Message-Id: <150528622026.5509.11248024114915952797.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 584146] Re: Virtual fat breaks with -snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Wishlist =3D> Undecided

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/584146

Title:
  Virtual fat breaks with -snapshot

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Debian:
  Confirmed

Bug description:
  When using fat emulation together with snapshot, qemu fails to find
  the directory for the fat "filesystem".

  See Debian bug#504049, http://bugs.debian.org/cgi-
  bin/bugreport.cgi?bug=3D504049 and discussion on qemu-devel with Kevin
  Wolf, http://marc.info/?t=3D126850802800001 for details.

  There's a workaround for this bug: when using full path for
  fat:/dir/name it works.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/584146/+subscriptions
