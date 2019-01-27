Received: from eggs.gnu.org ([209.51.188.92]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnh9q-0006w1-Cj
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gngvr-0001hq-1H
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:40:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gngvq-0001gj-MN
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:40:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gngvp-0000ks-Mg
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 09:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A895B2E8033
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 09:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Jan 2019 09:26:49 -0000
From: dcb <1813460@bugs.launchpad.net>
Reply-To: Bug 1813460 <1813460@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154858120998.1748.9152682687215641431.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813460] [NEW]
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

Public bug reported:

qemu/target/arm/translate-a64.c:2039]: (warning) Logical disjunction
always evaluates to true: op3 !=3D 2 || op3 !=3D 3.

Source code is

       if (op3 !=3D 2 || op3 !=3D 3) {

Maybe better code

       if (op3 !=3D 2 && op3 !=3D 3) {

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813460

Title:
  qemu/target/arm/translate-a64.c:2039: bad test ?

Status in QEMU:
  New

Bug description:
  qemu/target/arm/translate-a64.c:2039]: (warning) Logical disjunction
  always evaluates to true: op3 !=3D 2 || op3 !=3D 3.

  Source code is

         if (op3 !=3D 2 || op3 !=3D 3) {

  Maybe better code

         if (op3 !=3D 2 && op3 !=3D 3) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813460/+subscriptions
