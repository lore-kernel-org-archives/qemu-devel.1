Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f2sSv-000682-T8
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 01:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f2sSs-0006W8-1c
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 01:57:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:45875)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f2sSr-0006NQ-Pd
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 01:57:09 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
Date: Mon, 2 Apr 2018 08:56:59 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>

In the recent 2.12-rc1 tarball, there are the following things present:

roms/u-boot-sam460ex/tools/updater/stubs.c -
 it is some strange symlink pointing to a strange place, probably should be removed?

When making u-boot-am460ex image, in roms/Makefile, we do a plain copy, while 5
lines above, u-boot image is being stripped on copy. Should we perform strip for
u-boot-am460ex image too, if not only to be consistent?

BTW, can't u-boot-am460ex image be made from regular u-boot sources, maybe with an
additional board added? :)

Also, skiboot image can't be built from roms/skiboot in the source tarball, it fails
because there's no .version file present in roms/skiboot/ directory, but this file
is present in the git repository (submodule). Perhaps this .version file is wrongly
removed when making release tarball?

Maybe these trivial issues can be fixed for 2.12 release?

Thanks,

/mjt
