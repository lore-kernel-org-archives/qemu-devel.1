Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejrtD-0007yK-C7
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejrtA-0004HR-47
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:38784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejrt9-0004HD-Tb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejrt8-0000kH-7M
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 19:29:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 802CD2E80E0
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 19:29:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 19:15:34 -0000
From: Thomas Huth <1367365@bugs.launchpad.net>
Reply-To: Bug 1367365 <1367365@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140909163714.17873.62405.malonedeb@chaenomeles.canonical.com>
Message-Id: <151811733417.29267.16430191202727120896.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1367365] Re: qemu-img fixed vhd issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?
Otherwise, can you provide some test images or a description how to
create such images?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1367365

Title:
  qemu-img fixed vhd issues

Status in QEMU:
  Incomplete

Bug description:
  qemu-img returns fixed vhd images file format to be raw.

  This happens because only the header is seeked for image signatures
  when getting the image format. In fact, unlike dynamic vhd images,
  differencing vhds don't have the footer copied in the header.

  An easy fix would be to just search the last 512B for the 'conectix'
  signature.

  Also, the fixed vhds created by qemu-img seem to be corrupted from
  Powershell POV.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1367365/+subscriptions
