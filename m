Received: from eggs.gnu.org ([2001:4830:134:3::10]:60830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCz0-0006al-1f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCyz-0000IA-6s
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:57286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCyz-0000Ht-0U
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCyy-0006cR-1X
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:06:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0870B2E80AE
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:06:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:45:56 -0000
From: Thomas Huth <1414293@bugs.launchpad.net>
Reply-To: Bug 1414293 <1414293@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150124131201.12909.9258.malonedeb@soybean.canonical.com>
Message-Id: <20170111064556.27527.68855.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1414293] Re: target-lm32/translate.c:336: bad ? :
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1414293

Title:
  target-lm32/translate.c:336: bad ? : operator

Status in QEMU:
  Fix Released

Bug description:
  [qemu/target-lm32/translate.c:336]: (style) Same expression in both
  branches of ternary operator.

     int rY =3D (dc->format =3D=3D OP_FMT_RR) ? dc->r0 : dc->r0;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1414293/+subscriptions
