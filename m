Received: from eggs.gnu.org ([2001:4830:134:3::10]:59312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaM8X-00085o-Oa
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaM8U-0000nx-Fh
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:50:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gaM8U-0000l7-7v
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:50:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gaM8Q-0005c6-Fs
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A561E2E80CC
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Dec 2018 14:45:11 -0000
From: yuchenlin <1809304@bugs.launchpad.net>
Reply-To: Bug 1809304 <1809304@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154533506483.19401.8849680441407310900.malonedeb@soybean.canonical.com>
Message-Id: <154540351134.25501.16148879970699615201.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809304] Re: qemu-img convert is freezing for
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

I have submitted a patch to prevent hanging in binary search.
See: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05453.html?=
fbclid=3DIwAR0ObsaZ4kVMVv6MWIdq0ZCAN5tGhDsd9GmFv8_v7HBTl94Cu5EkRZ3z4n4

Thanks,
Yu-Chen Lin

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
