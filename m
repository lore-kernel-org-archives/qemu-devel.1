Received: from eggs.gnu.org ([209.51.188.92]:54673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqeKu-0000EG-8O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqeKt-00070F-7g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:30:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:37152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gqeKr-0006d5-1B
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:30:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gqeKf-0006Kn-AM
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 13:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C6892E80C7
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 13:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Feb 2019 13:23:23 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1813460 <1813460@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154858120998.1748.9152682687215641431.malonedeb@wampee.canonical.com>
Message-Id: <154928660312.20300.8171475052931956885.malone@wampee.canonical.com>
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

The patch is now in master.

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813460

Title:
  qemu/target/arm/translate-a64.c:2039: bad test ?

Status in QEMU:
  Fix Committed

Bug description:
  qemu/target/arm/translate-a64.c:2039]: (warning) Logical disjunction
  always evaluates to true: op3 !=3D 2 || op3 !=3D 3.

  Source code is

         if (op3 !=3D 2 || op3 !=3D 3) {

  Maybe better code

         if (op3 !=3D 2 && op3 !=3D 3) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813460/+subscriptions
