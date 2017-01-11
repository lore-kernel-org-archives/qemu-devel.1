Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfV-00044q-VH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfV-0008UJ-3Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:52027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCfU-0008U8-Tf
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCfT-0006OQ-JL
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8CF762E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:37:10 -0000
From: Thomas Huth <1631773@bugs.launchpad.net>
Reply-To: Bug 1631773 <1631773@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161009165555.4889.95289.malonedeb@gac.canonical.com>
Message-Id: <20170111063710.20935.25727.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1631773] Re: hw/dma/pl080.c:354: possible typo ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8.

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1631773

Title:
  hw/dma/pl080.c:354: possible typo ?

Status in QEMU:
  Fix Released

Bug description:
  hw/dma/pl080.c:354:1: warning: V578 An odd bitwise operation detected:
  s->conf & (0x2 | 0x2). Consider verifying it.

  Source code is

         if (s->conf & (PL080_CONF_M1 | PL080_CONF_M1)) {

  Maybe better code

         if (s->conf & (PL080_CONF_M1 | PL080_CONF_M2)) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1631773/+subscriptions
