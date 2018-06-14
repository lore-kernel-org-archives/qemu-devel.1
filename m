Received: from eggs.gnu.org ([2001:4830:134:3::10]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTXy7-0006ax-2f
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTXy3-0005Lw-2B
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:59560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTXy2-0005LE-Rw
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTXy0-0002OT-Io
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:31:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 89E9E2E80DF
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:31:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 19:22:33 -0000
From: John Snow <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <152900415325.27316.11118799892058089017.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Are you converting to a destination on APFS? If yes, do you have the
ability to easily reproduce this by converting to a non-APFS destination
and seeing if that breaks too?

Thanks,
--js

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
