Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Yco-00065i-AZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Ycl-0001cY-63
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2Ycl-0001cM-0C
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2Yci-00059h-HJ
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:41:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 351992E80E7
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:41:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 07:35:34 -0000
From: Thomas Huth <1655702@bugs.launchpad.net>
Reply-To: Bug 1655702 <1655702@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111162323.27094.66518.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170424073536.16029.13273.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655702] Re: qemu/hw/char/exynos4210_uart.c:
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655702

Title:
  qemu/hw/char/exynos4210_uart.c: possible pointless local variable ?

Status in QEMU:
  Fix Released

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
