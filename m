Received: from eggs.gnu.org ([2001:4830:134:3::10]:42119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRLnU-0003lP-Mb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRLnR-0004ju-BO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:30:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRLnR-0004jh-3d
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRLnQ-0004ck-2P
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB7842E80C8
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 16:23:22 -0000
From: dcb <1655702@bugs.launchpad.net>
Reply-To: Bug 1655702 <1655702@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170111162323.27094.66518.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655702] [NEW] qemu/hw/char/exynos4210_uart.c:
 possible pointless local variable ?
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

$ fgrep frame_size qemu/hw/char/exynos4210_uart.c
    int speed, parity, data_bits, stop_bits, frame_size;
    frame_size =3D 1; /* start bit */
        frame_size++; /* parity bit */
    frame_size +=3D data_bits + stop_bits;
$

Suggest either use it or delete it.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655702

Title:
  qemu/hw/char/exynos4210_uart.c: possible pointless local variable ?

Status in QEMU:
  New

Bug description:
  $ fgrep frame_size qemu/hw/char/exynos4210_uart.c
      int speed, parity, data_bits, stop_bits, frame_size;
      frame_size =3D 1; /* start bit */
          frame_size++; /* parity bit */
      frame_size +=3D data_bits + stop_bits;
  $

  Suggest either use it or delete it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655702/+subscriptions
