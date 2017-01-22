Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVO0V-0007kt-Vv
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 14:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVO0R-0007Zo-2r
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 14:40:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:52107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVO0Q-0007ZZ-T1
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 14:40:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVO0N-00082M-Dv
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 19:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 43E4B2E80C8
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 19:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jan 2017 19:34:34 -0000
From: dcb <1658506@bugs.launchpad.net>
Reply-To: Bug 1658506 <1658506@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170122193434.14023.61016.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658506] [NEW]
 qemu/hw/intc/arm_gicv3_cpuif.c:2433: bad expression ?
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

qemu/hw/intc/arm_gicv3_cpuif.c:2433]: (style) Expression '(X &
0x2000000000000000) =3D=3D 0x1' is always false.

Source code is

           ((lr & ICH_LR_EL2_HW) =3D=3D 1 || (lr & ICH_LR_EL2_EOI) =3D=3D 0=
)) {

Maybe better code

           ((lr & ICH_LR_EL2_HW) !=3D 0 || (lr & ICH_LR_EL2_EOI) =3D=3D 0))=
 {

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658506

Title:
  qemu/hw/intc/arm_gicv3_cpuif.c:2433: bad expression ?

Status in QEMU:
  New

Bug description:
  qemu/hw/intc/arm_gicv3_cpuif.c:2433]: (style) Expression '(X &
  0x2000000000000000) =3D=3D 0x1' is always false.

  Source code is

             ((lr & ICH_LR_EL2_HW) =3D=3D 1 || (lr & ICH_LR_EL2_EOI) =3D=3D=
 0))
  {

  Maybe better code

             ((lr & ICH_LR_EL2_HW) !=3D 0 || (lr & ICH_LR_EL2_EOI) =3D=3D 0=
))
  {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658506/+subscriptions
