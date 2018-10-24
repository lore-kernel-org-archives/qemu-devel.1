Received: from eggs.gnu.org ([2001:4830:134:3::10]:56758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFQ0T-0003lc-KC
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFPxb-0005jt-9y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:41:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:44402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFPxb-0005iS-30
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFPxZ-0000rX-7z
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 20:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 35F292E8019
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 20:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Oct 2018 20:31:42 -0000
From: Sebastian Krzyszkowiak <1799792@bugs.launchpad.net>
Reply-To: Bug 1799792 <1799792@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154041310239.24736.3249552536528955636.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1799792] [NEW] Broken scaling with gtk,
 gl=on on a hidpi display
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

Tested on QEMU 3.0.0 on Arch Linux.

I'm using a hidpi screen, and therefore use those environment variables
in order to have GTK+ apps properly scaled:

GDK_SCALE=3D2
GDK_DPI_SCALE=3D0.5

However, QEMU, when launched with "-display gtk,gl=3Don" option, doesn't
scale the window content properly, as seen on the attached screenshot.

Switching to "-display gtk,gl=3Doff" and "-display sdl,gl=3Don" makes it
work fine.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Screenshot_20181024_222447.png"
   https://bugs.launchpad.net/bugs/1799792/+attachment/5205039/+files/Scree=
nshot_20181024_222447.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799792

Title:
  Broken scaling with gtk,gl=3Don on a hidpi display

Status in QEMU:
  New

Bug description:
  Tested on QEMU 3.0.0 on Arch Linux.

  I'm using a hidpi screen, and therefore use those environment
  variables in order to have GTK+ apps properly scaled:

  GDK_SCALE=3D2
  GDK_DPI_SCALE=3D0.5

  However, QEMU, when launched with "-display gtk,gl=3Don" option, doesn't
  scale the window content properly, as seen on the attached screenshot.

  Switching to "-display gtk,gl=3Doff" and "-display sdl,gl=3Don" makes it
  work fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799792/+subscriptions
