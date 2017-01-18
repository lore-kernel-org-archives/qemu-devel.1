Received: from eggs.gnu.org ([2001:4830:134:3::10]:35252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTsah-0005ae-Gc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTsac-0003uC-My
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:56:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:45253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTsac-0003ty-Gc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:55:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTsaa-0002Vg-Dm
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:55:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6981F2E80E7
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:55:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jan 2017 15:44:30 -0000
From: Thomas Huth <1655708@bugs.launchpad.net>
Reply-To: Bug 1655708 <1655708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170118154430.20152.52042.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655708] Re: target/ppc/int_helper.c:2806:
 strange expression ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch has been posted to the mailing list:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02008.html

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655708

Title:
  target/ppc/int_helper.c:2806: strange expression ?

Status in QEMU:
  In Progress

Bug description:
  target/ppc/int_helper.c:2806:25: warning: =E2=80=98*=E2=80=99 in boolean =
context,
  suggest =E2=80=98&&=E2=80=99 instead [-Wint-in-bool-context]

  Source code is

         zone_digit =3D (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 :
  zone_lead;

  Which I read as

         zone_digit =3D (i * 2) ? (b->u8[BCD_DIG_BYTE(i * 2)] >> 4) :
  zone_lead;

  so I think the compiler warning is for the i * 2 lhs of the ?.

  I am not sure what to suggest as a bugfix.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655708/+subscriptions
