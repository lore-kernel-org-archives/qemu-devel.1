Received: from eggs.gnu.org ([209.51.188.92]:39979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnppP-0003dN-Ug
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnppP-000440-4c
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:10:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:48196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gnppO-00043U-V1
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:10:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gnppN-0003Ed-63
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 19:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2CE352E80C7
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 19:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Jan 2019 19:04:49 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1813460 <1813460@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154858120998.1748.9152682687215641431.malonedeb@wampee.canonical.com>
Message-Id: <154861588978.19624.1945585311119463857.malone@gac.canonical.com>
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

There is a patch on list for this:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06728.html

Using the flag is a good idea.

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813460

Title:
  qemu/target/arm/translate-a64.c:2039: bad test ?

Status in QEMU:
  In Progress

Bug description:
  qemu/target/arm/translate-a64.c:2039]: (warning) Logical disjunction
  always evaluates to true: op3 !=3D 2 || op3 !=3D 3.

  Source code is

         if (op3 !=3D 2 || op3 !=3D 3) {

  Maybe better code

         if (op3 !=3D 2 && op3 !=3D 3) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813460/+subscriptions
