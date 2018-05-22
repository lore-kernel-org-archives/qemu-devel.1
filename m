Received: from eggs.gnu.org ([2001:4830:134:3::10]:59813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7WF-0003mk-3o
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7WA-0000cE-8D
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:40:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:49382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7WA-0000bw-22
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:39:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7W8-0007Q1-SM
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:39:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C9D262E8F3A
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:39:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:24:15 -0000
From: Thomas Huth <1439800@bugs.launchpad.net>
Reply-To: Bug 1439800 <1439800@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150402180047.7381.43475.malonedeb@chaenomeles.canonical.com>
Message-Id: <152699545584.8990.15741997364724713426.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1439800] Re: GTK fullscreen mode start stretched
 but fixes after leaving and returning full screen mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU and the latest version of GTK? Or could
we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1439800

Title:
  GTK fullscreen mode start stretched but fixes after leaving and
  returning full screen mode

Status in QEMU:
  Incomplete

Bug description:
  I'm running QEMU 2.2.91 compiled directly from git and starting QEMU
  with the -full-screen option using the GTK display. The guest OS is
  Windows 8.1 using the VGA driver from QEMU.

  The GTK window resizes three times on the boot process, and every time
  it deforms the output, but the image can be fixed leaving the full-
  screen mode and returning it back. So it appears that QEMU loses the
  information with multiple resolution changes of the boot process and
  fails in the end.

  The description can be a little confusing, so I've put a video on Youtube=
, so it can demonstrate the real issue:
  https://www.youtube.com/watch?v=3D-lWbWEUOSsk

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1439800/+subscriptions
