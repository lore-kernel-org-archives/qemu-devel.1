Received: from eggs.gnu.org ([2001:4830:134:3::10]:49662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCSIL-0004jA-2e
	for qemu-devel@nongnu.org; Sun, 21 May 2017 10:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCSIK-0002jf-Dh
	for qemu-devel@nongnu.org; Sun, 21 May 2017 10:57:21 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:32898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dCSIK-0002jZ-86
	for qemu-devel@nongnu.org; Sun, 21 May 2017 10:57:20 -0400
Received: by mail-qt0-x22a.google.com with SMTP id t26so86274581qtg.0
	for <qemu-devel@nongnu.org>; Sun, 21 May 2017 07:57:19 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Sun, 21 May 2017 19:27:18 +0430
Message-ID: <CAGKXQyeWd3iOvnRGfQt1nzLcvf6vnSwmg_5RQvoOxfFs5d5yhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Precopy VM Live Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello
I have understood from code that In Precopy, there is no Priority for
sending dirty pages and qemu  sends a page as soon as it is found in a
block(by linear searching in blocks). in other word, qemu does not consider
to pages that dirties more than others until sends them later than other
pages.
is my understanding true?
thanks a lot
