Received: from eggs.gnu.org ([2001:4830:134:3::10]:48028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQ7O-0006eS-9z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQ7K-0000Ou-7L
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:59876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbQ7J-0000OR-U7
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbQ7I-0007sX-DL
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 12:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 631152E806F
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 12:37:36 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1778182 <1778182@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152965079249.25456.13265375438612212422.malonedeb@soybean.canonical.com>
Message-Id: <153088065616.18372.16201418269391278259.malone@chaenomeles.canonical.com>
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

Works for me with both the GTK display and '-display sdl' with current
head-of-git QEMU...


** Tags added: arm

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
