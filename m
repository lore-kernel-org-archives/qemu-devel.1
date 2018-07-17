Received: from eggs.gnu.org ([2001:4830:134:3::10]:55068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffMmv-0001gn-Kb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffMmp-0001WP-OW
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ffMmp-0001Vc-Gm
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:00:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ffMmn-0005Vw-BL
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 529F32E80CF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jul 2018 09:47:26 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1782107 <1782107@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153181978967.32137.15387354948382398538.malonedeb@chaenomeles.canonical.com>
Message-Id: <153182084650.31372.11440773352326544570.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1782107] Re: Random errors when emulating armv7
 and using dh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The ioctl warnings are I think for BTRFS_IOC_CLONE, which are probably
harmless (the calling program ought to cope with it not working and fall
back to something else).

Which version of QEMU are you using ?

(Unfortunately the log is not very revealing about what has gone wrong:
it says "Running setup.py bdist_wheel for itsdangerous ... error" but
gives no detail about what the error was. Is it possible to get the
python build/install process to be more verbose?)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1782107

Title:
  Random errors when emulating armv7 and using dh

Status in QEMU:
  New

Bug description:
  Howdy,
  I'm encountering random errors when using qemu to cross-package my projec=
t using dh. In previous iterations of my project it would only fail once ev=
ery two attempts. Now it fails every time.

  Example error included.


  If you'd like to try and replicate this error, a version of my project is=
 publicly available with simple instructions on how to package it (using qe=
mu) here:
  https://github.com/Nadav-Ruskin/configsite

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1782107/+subscriptions
