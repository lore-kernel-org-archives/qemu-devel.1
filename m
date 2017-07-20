Received: from eggs.gnu.org ([2001:4830:134:3::10]:46611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYAvI-0006Qb-CL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYAvF-0004hD-5h
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:51:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:50948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYAvF-0004gc-0a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:51:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYAvC-0003he-IV
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:51:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E982E2E831B
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:50:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 12:44:40 -0000
From: Thomas Huth <1655708@bugs.launchpad.net>
Reply-To: Bug 1655708 <1655708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
Message-Id: <150055468056.24419.13991185150242560235.malone@soybean.canonical.com>
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

Fix had been committed here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D365206aeb3d0bb72043d

** Changed in: qemu
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655708

Title:
  target/ppc/int_helper.c:2806: strange expression ?

Status in QEMU:
  Fix Released

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
