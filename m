Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kvapss@gmail.com>) id 1fOlLR-0003n3-RD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kvapss@gmail.com>) id 1fOlLR-0000w2-9y
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:47:57 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kvapss@gmail.com>) id 1fOlLQ-0000vB-TP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:47:57 -0400
Received: by mail-it0-x235.google.com with SMTP id k17-v6so5258070ita.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 07:47:56 -0700 (PDT)
MIME-Version: 1.0
From: kvaps <kvapss@gmail.com>
Date: Fri, 1 Jun 2018 16:47:55 +0200
Message-ID: <CAGO-sgOsRvJbjdDH4dbRJPgVu=oYqvEZdFmzSprDkcn-A6rc5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Mistake on man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, here is mistake in man page for qemu-nbd:

--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -1,2 +1,2 @@
--- a/qemu-nbd.texi
-Don't exit on the last connection
+++ b/qemu-nbd.texi
+Don't exit on the lost connection

Regards
-- kvaps
