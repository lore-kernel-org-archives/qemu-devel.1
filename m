Received: from eggs.gnu.org ([2001:4830:134:3::10]:57154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAf3J-0000VQ-33
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAf3E-0007Cy-7A
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:42:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:51004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAf3E-0007C7-0b
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:42:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAf39-0008Hg-Qm
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 16:42:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BAA692E8250
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 16:42:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 16:26:57 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1480562 <1480562@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150801144611.25000.89046.malonedeb@soybean.canonical.com>
Message-Id: <150972641862.3780.16143622119784996473.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1480562] Re: register values in sp804 timer
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
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1480562

Title:
  register values in sp804 timer

Status in QEMU:
  Invalid

Bug description:
  In the arm_timer.c, when first reading the load register,  I got 0.

  ...
  case 0: /* TimerLoad */
  ...

  According to the specification at http://infocenter.arm.com/help/index.js=
p?topic=3D/com.arm.doc.ddi0271d/index.html, =

  "The minimum valid value for TimerXLoad is 1".  Is the initial value supp=
osed to be 0xffffffff?

  =

  When the 5th and 7th bit in Control Register are set, RIS and MIS remain =
0. But should they be enabled (i.e., 0x1 and 0x1) as both interrupt and tim=
er module are set. =


  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1480562/+subscriptions
