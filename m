Received: from eggs.gnu.org ([2001:4830:134:3::10]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEI1g-0004DZ-OE
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEI1e-0005yY-6W
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:56:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:52386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEI1d-0005yE-VT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:55:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEI1b-0007er-Dv
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 16:55:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6747A2E8059
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 16:55:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 16:45:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1727737 <1727737@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150902607840.5143.15937446061017284272.malonedeb@chaenomeles.canonical.com>
Message-Id: <151059155235.8642.3556109151809826532.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727737] Re: qemu-arm stalls on a GCC sanitizer
 test since qemu-2.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It would be nice if we got /proc/self/environ right, though...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1727737

Title:
  qemu-arm stalls on a GCC sanitizer test since qemu-2.7

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  I have noticed that several GCC/sanitizer tests fail with timeout when
  executed under QEMU.

  After a bit of investigation, I have noticed that this worked with
  qemu-2.7, and started failing with qemu-2.8, and still fails with
  qemu-2.10.1

  I'm attaching a tarball containing:
  alloca_instruments_all_paddings.exe : the testcase, and the needed libs:
  lib/librt.so.1
  lib/libdl.so.2
  lib/ld-linux-armhf.so.3
  lib/libasan.so.5
  lib/libc.so.6
  lib/libgcc_s.so.1
  lib/libpthread.so.0
  lib/libm.so.6

  To reproduce the problem:
  $ qemu-arm -cpu any -R 0 -L $PWD $PWD/alloca_instruments_all_paddings.exe
  returns in less than a second with qemu-2.7, and never with qemu-2.8

  Using -d in_asm suggests that the program "almost" completes and qemu see=
ms to stall on:
  0x40b6eb44: e08f4004 add r4, pc, r4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1727737/+subscriptions
