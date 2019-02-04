Received: from eggs.gnu.org ([209.51.188.92]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13550250669@139.com>) id 1gqWwm-00017m-H4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <13550250669@139.com>) id 1gqWkp-0008M3-8p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:25:12 -0500
Received: from n9-40.mail.139.com ([221.176.9.40]:54716)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13550250669@139.com>) id 1gqWko-0008FG-KN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:25:11 -0500
Date: Mon, 4 Feb 2019 13:16:00 +0800 (CST)
From: wangsh <13550250669@139.com>
Message-ID: <2b0d5c57adaa276-00042.Richmail.00012297457665646870@139.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] my compiled qemu-system can't work on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>


Hi, i compiled qemu on win10 by the newest msys64+mingw64, but they can't run with no print errors, can you help me?

I tried add "--disable-stack-protector ", then qemu-img.exe can works, but qemu-system-arm.exe still can't work and no stderr.txt or stdout.txt generated. 




my configure option:

../configure --target-list=arm-softmmu --disable-werror --disable-capstone --prefix=/usr/local/qemu/ --disable-stack-protector --enable-gtk --enable-sdl --disable-debug-info --python=python2 --disable-guest-agent-msi




my mingw gcc:

gcc version 8.2.1 20181214 (Rev1, Built by MSYS2 project)




Thanks for your help!
