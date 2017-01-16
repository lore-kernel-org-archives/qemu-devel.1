Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oP-00024K-O0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oM-0007rg-Kt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:34519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT5oM-0007rN-FN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT5oJ-0005yp-PI
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F27BF2E80E6
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 11:37:30 -0000
From: Thomas Huth <1643537@bugs.launchpad.net>
Reply-To: Bug 1643537 <1643537@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161121121617.5146.1948.malonedeb@wampee.canonical.com>
Message-Id: <20170116113730.20028.2828.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1643537] Re: target-ppc/int_helper.c: 2 * bad
 array index
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
https://bugs.launchpad.net/bugs/1643537

Title:
  target-ppc/int_helper.c: 2 * bad array index

Status in QEMU:
  Fix Released

Bug description:
  1.

  [qemu/target-ppc/int_helper.c:2575]: (error) Array 'reg.u16[8]'
  accessed at index 8, which is out of bounds.

  Source code is

     return reg->u16[8 - n];

  and

  qemu/target-ppc/cpu.h:    uint16_t u16[8];

  but at least once, n is zero, for example line 2725 in the
  int_helper.c file:

      uint16_t sgnb =3D get_national_digit(b, 0);

  2.

  [qemu/target-ppc/int_helper.c:2584]: (error) Array 'reg.u16[8]'
  accessed at index 8, which is out of bounds.

  Duplicate

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1643537/+subscriptions
