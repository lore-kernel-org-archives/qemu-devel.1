Received: from eggs.gnu.org ([2001:4830:134:3::10]:44345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZGck-000745-Rp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZGcg-0003hv-MK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:45:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:54180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZGce-0003YQ-EQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:45:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZGcd-0001uc-9U
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 14:45:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 28C0B2E80C7
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 14:45:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 14:32:41 -0000
From: Daniel Berrange <1392468@bugs.launchpad.net>
Reply-To: Bug 1392468 <1392468@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141113201019.18949.57499.malonedeb@gac.canonical.com>
Message-Id: <154514356120.8439.870644698916494940.malone@gac.canonical.com>
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

This series gives the QEMU SDL2 & GTK frontends high quality icons
http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg04475.html

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
