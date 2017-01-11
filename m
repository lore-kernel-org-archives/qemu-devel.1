Received: from eggs.gnu.org ([2001:4830:134:3::10]:54331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfW-00044y-Jk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfV-0008Um-JF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:52037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCfV-0008UE-Ci
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCfU-0006Zm-CG
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 577FC2E8019
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:38:18 -0000
From: Thomas Huth <1631625@bugs.launchpad.net>
Reply-To: Bug 1631625 <1631625@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161008161931.5791.70475.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170111063818.20907.98080.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1631625] Re: target-mips/dsp_helper.c: two
 possible bad shifts
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
https://bugs.launchpad.net/bugs/1631625

Title:
  target-mips/dsp_helper.c: two possible bad shifts

Status in QEMU:
  Fix Released

Bug description:
  target-mips/dsp_helper.c:3480:1: error: V629 Consider inspecting the
  '0x01 << (size + 1)' expression. Bit shifting of the 32-bit value with
  a subsequent expansion to the 64-bit type.

  Source code is

          temp =3D temp & ((0x01 << (size + 1)) - 1);

  If size >=3D 32, then better code might be

          temp =3D temp & ((0x01UL << (size + 1)) - 1);

  target-mips/dsp_helper.c:3509:1: error: V629 Consider inspecting the
  '0x01 << (size + 1)' expression. Bit shifting of the 32-bit value with
  a subsequent expansion to the 64-bit type.

  Duplicate

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1631625/+subscriptions
