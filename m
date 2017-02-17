Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceeAj-0002Cw-Ps
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceeAd-0004nU-W5
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ceeAd-0004mm-Ox
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ceeAc-0003Pd-SE
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D41792E80C4
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:45:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Feb 2017 08:26:38 -0000
From: Thomas Huth <1014099@bugs.launchpad.net>
Reply-To: Bug 1014099 <1014099@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120616165038.8986.77631.malonedeb@gac.canonical.com>
Message-Id: <20170217082638.4980.95152.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1014099] Re: hw/esp.c does not properly deal with
 TEST_UNIT_READY in NetBSD/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Has this problem been fixed in 2012, so that we could close this ticket
now? Or is there still something left to do?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1014099

Title:
  hw/esp.c does not properly deal with TEST_UNIT_READY in NetBSD/sparc

Status in QEMU:
  Incomplete

Bug description:
  The NetBSD ncr53c9x.c driver does a TEST_UNIT_READY command with
  SELATN but dma disabled sometimes (early during bus enumeration). This
  is fine, as the command will not produce nor consume any data, and
  works on real hardware.

  However, the qemu emulation does not allow this (for reasons I don't
  understand).

  The change below fixes the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1014099/+subscriptions
