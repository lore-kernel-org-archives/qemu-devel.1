Received: from eggs.gnu.org ([209.51.188.92]:47194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeM-0005sN-Hs
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeL-00080i-CZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:38018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAeL-0007zx-6G
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAeI-0003sE-Tj
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E00852E80CB
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:30:42 -0000
From: Thomas Huth <1813460@bugs.launchpad.net>
Reply-To: Bug 1813460 <1813460@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154858120998.1748.9152682687215641431.malonedeb@wampee.canonical.com>
Message-Id: <155608384337.13917.14760856550047991610.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813460] Re:
 qemu/target/arm/translate-a64.c:2039: bad test ?
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813460

Title:
  qemu/target/arm/translate-a64.c:2039: bad test ?

Status in QEMU:
  Fix Released

Bug description:
  qemu/target/arm/translate-a64.c:2039]: (warning) Logical disjunction
  always evaluates to true: op3 !=3D 2 || op3 !=3D 3.

  Source code is

         if (op3 !=3D 2 || op3 !=3D 3) {

  Maybe better code

         if (op3 !=3D 2 && op3 !=3D 3) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813460/+subscriptions
