Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fWGDa-0001gB-F7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fWGDX-0000QR-9E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:10:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:49878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fWGDX-0000Q0-2C
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fWGDW-0002mj-9W
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 44EC02E8010
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Jun 2018 07:01:59 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
	<ciro.santilli@gmail.com>
Reply-To: Bug 1778182 <1778182@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152965079249.25456.13265375438612212422.malonedeb@soybean.canonical.com>
Message-Id: <152965091921.2258.7685970310199908079.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1778182] Re: qemu-system-aarch64 shows black
 framebuffer window on minimal bare metal example on SDL but not on VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Things that work:

- https://github.com/cirosantilli/linux-kernel-module-cheat/tree/741f5215e9=
515c0d7179671f49fe1781f94e70e3#graphic-mode-arm which shows the Penguin wit=
h the Linux kernel, after hacking that repo up to use the exact same QEMU e=
xecutable as reported here
- the UART examples on the image repo: https://github.com/bztsrc/raspi3-tut=
orial/tree/9e5611a624b3037788d5b29d951304938bff13ea/05_uart0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778182

Title:
  qemu-system-aarch64 shows black framebuffer window on minimal bare
  metal example on SDL but not on VNC

Status in QEMU:
  New

Bug description:
  QEMU v2.12.0, Ubuntu 18.04 host.

  Build QEMU and the bare metal image exactly as described at:
  https://raspberrypi.stackexchange.com/revisions/85135/4 with:

  Then cd into example 09_framebuffer.

  Now if I do:

  ../../qemu/aarch64-softmmu/qemu-system-aarch64 -M raspi3 -kernel
  kernel8.img -serial stdio

  the SDL window shows up black.

  However, if I use VNC:

  ../../qemu/aarch64-softmmu/qemu-system-aarch64 -M raspi3 -kernel kernel8.=
img -serial stdio -vnc :1
  vinagre :5901

  an image of Homer Simpson appears as expected.

  Therefore, I think this must be a QEMU / SDL bug instead of the
  repository, since we get different behaviors with `-vnc` and with SDL.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778182/+subscriptions
