Received: from eggs.gnu.org ([2001:4830:134:3::10]:42062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQajy-0007z9-Ck
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQajv-00069P-9H
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:16:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:47352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQajv-00069G-3K
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:15:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQajt-0003q7-JC
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 14:15:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 474472E80C4
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:15:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 13:57:45 -0000
From: Thomas Huth <775604@bugs.launchpad.net>
Reply-To: Bug 775604 <775604@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110502140912.31190.97664.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170109135746.14023.66041.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 775604] Re: Could not open SDL display when
 running XP as guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... QEMU 0.14 is completely outdated nowadays.
Can you still reproduce this behavior with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/775604

Title:
  Could not open SDL display when running XP as guest

Status in QEMU:
  Incomplete

Bug description:
  When running XP as guest on Linux 2.6.38 x86_64 (Arch Linux) in full
  screen qemu will crash. Dropping to 1400x900 or below does not have a
  problem nor does windowed mode.

  1. Running:
  qemu-system-x86_64 -vga std -full-screen Virtual_Machines/Windows_XP/Wind=
ows_XP.img

  Produces error:
  Could not open SDL display (1920x1200x0): No video mode large enough for =
1920x1200

  qemu-kvm version 0.14.0-1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/775604/+subscriptions
