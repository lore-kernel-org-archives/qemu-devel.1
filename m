Received: from eggs.gnu.org ([2001:4830:134:3::10]:54288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga4LC-0005Pw-L7
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga4L9-0006IC-G2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:50:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ga4L7-0006EF-Na
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:50:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ga4L4-0003bg-RJ
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 19:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C17882E80C9
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 19:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2018 19:44:24 -0000
From: Julio Faracco <jcfaracco@gmail.com>
Reply-To: Bug 1809304 <1809304@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154533506483.19401.8849680441407310900.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809304] [NEW] qemu-img convert is freezing for
 some DMG files.
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

Recently, I created a file using hdiutil from MacOS (using Zlib
compression):

$ hdiutil create -volname MyVolName -srcfolder /path/to/my/vol/ -ov
-format UDZO myvolname.dmg

But, when I try to convert this volume using qemu-img convert, this
command is freezing.

I'm using the upstream version to test it.

It is freezing inside the binary search method to retrieve the chunk.

But, I still don't know why.

I'm attaching the file as an example.

It can be mounted using MacOS or other Linux apps like hfsleuth and
darling-dmg.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: dmg qemu-img

** Attachment added: "Firefox-Zlib.dmg"
   https://bugs.launchpad.net/bugs/1809304/+attachment/5223852/+files/Firef=
ox-Zlib.dmg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809304

Title:
  qemu-img convert is freezing for some DMG files.

Status in QEMU:
  New

Bug description:
  Recently, I created a file using hdiutil from MacOS (using Zlib
  compression):

  $ hdiutil create -volname MyVolName -srcfolder /path/to/my/vol/ -ov
  -format UDZO myvolname.dmg

  But, when I try to convert this volume using qemu-img convert, this
  command is freezing.

  I'm using the upstream version to test it.

  It is freezing inside the binary search method to retrieve the chunk.

  But, I still don't know why.

  I'm attaching the file as an example.

  It can be mounted using MacOS or other Linux apps like hfsleuth and
  darling-dmg.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809304/+subscriptions
