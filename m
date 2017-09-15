Received: from eggs.gnu.org ([2001:4830:134:3::10]:44833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dsvPZ-0005uK-N4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dsvPW-0001Hq-IN
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:32:21 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dsvPW-0001GL-Dt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:32:18 -0400
Received: by mail-io0-x242.google.com with SMTP id n69so4828528ioi.3
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 11:32:17 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <E7665638-9EE7-45B0-AF95-BC37863AC0DA@gmail.com>
Date: Fri, 15 Sep 2017 14:32:14 -0400
Subject: Re: [Qemu-devel] [PATCH v5 08/12] char: convert the escc device to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Sorry but I saw this error when I tried your patches:

  OBJC    ui/cocoa.o
  CC      ui/curses.o
ui/input-keymap.c:17:10: fatal error: 'ui/input-keymap-qcode-to-sun.c' =
file not
      found
#include "ui/input-keymap-qcode-to-sun.c"
         ^
1 error generated.
make: *** [ui/input-keymap.o] Error 1
make: *** Waiting for unfinished jobs....


I could not find this file.=20=
