Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5wj-0000sF-FZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5wg-0002ge-EF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:59:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT5wg-0002gK-8r
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:59:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT5wf-0008M8-55
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0D4812E80C9
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 11:45:49 -0000
From: Thomas Huth <1625987@bugs.launchpad.net>
Reply-To: Bug 1625987 <1625987@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160921082958.18035.57524.malonedeb@wampee.canonical.com>
Message-Id: <20170116114549.27052.87227.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1625987] Re: target-arm/translate-a64.c:2028:
 possible coding error ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with v2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1625987

Title:
  target-arm/translate-a64.c:2028: possible coding error ?

Status in QEMU:
  Fix Released

Bug description:
  target-arm/translate-a64.c:2028:37: warning: ?: using integer
  constants in boolean context [-Wint-in-bool-context]

  Source code is

          bool iss_sf =3D opc =3D=3D 0 ? 32 : 64;

  Maybe better code

          bool iss_sf =3D (opc =3D=3D 0) ? 32 : 64;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1625987/+subscriptions
