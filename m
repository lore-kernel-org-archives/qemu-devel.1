Received: from eggs.gnu.org ([2001:4830:134:3::10]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEXrz-0002aV-Vi
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEXrw-00053m-RJ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:46:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:46404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEXrw-00053J-LU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:46:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEXru-0001CJ-Qd
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 08:46:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BD4762E820C
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 08:46:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2016 08:40:01 -0000
From: Thomas Huth <1643537@bugs.launchpad.net>
Reply-To: Bug 1643537 <1643537@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161121121617.5146.1948.malonedeb@wampee.canonical.com>
Message-Id: <20161207084002.23437.42105.malone@chaenomeles.canonical.com>
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

Fix has been committed:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da813fe73621e1221a09

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1643537

Title:
  target-ppc/int_helper.c: 2 * bad array index

Status in QEMU:
  Fix Committed

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
