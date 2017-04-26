Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3UCj-0003kx-S6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3UCg-0001cc-NB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:10:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:59450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3UCg-0001bx-H7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:10:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3UCf-0000Nk-Dv
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 21:10:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5EFBC2E80C7
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 21:10:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Apr 2017 20:59:07 -0000
From: Stephan Henningsen <1392468@bugs.launchpad.net>
Reply-To: Bug 1392468 <1392468@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141113201019.18949.57499.malonedeb@gac.canonical.com>
Message-Id: <20170426205907.26879.98219.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1392468] Re: qemu uses a bitmap icon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Gees, some please fix this already! Ubuntu 16.04.2 also uses some ugly
icon.  Why not ditch the bitmaps and use this official svg?

http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Dpc-
bios/qemu_logo_no_text.svg;hb=3DHEAD

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1392468

Title:
  qemu uses a bitmap icon

Status in QEMU:
  New

Bug description:
  qemu currently uses the icon in pc-bios/qemu-icon.bmp, which,
  obviously, is a bitmap file. It is loaded such that white pixels will
  be transparent. This can cause nasty artifacts in the display.

  Unless there is a specific reason to use bitmaps, I'd suggest moving
  to, e.g., a PNG file with a proper alpha channel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1392468/+subscriptions
