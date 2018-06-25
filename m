Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpv-0000yd-A0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpu-0007To-8q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:15 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:44499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpu-0007Tg-4z
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:14 -0400
Received: by mail-qk0-x236.google.com with SMTP id 185-v6so7357488qkk.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 05:43:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:41:56 -0300
Message-Id: <20180625124238.25339-5-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 04/46] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Pasi Savanainen <pasi.savanainen@nixu.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Joe Perches <joe@perches.com>

Do not match the IEC binary prefix as camelcase typedefs.

This fixes:

    ERROR: "foo * bar" should be "foo *bar"
    #310: FILE: hw/ppc/ppc440_uc.c:564:
    +        size = 8 * MiB * sh;
    total: 1 errors, 0 warnings, 433 lines checked

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3d8c2cdfc..223681bfd0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -242,6 +242,7 @@ our $UTF8	= qr{
 # There are still some false positives, but this catches most
 # common cases.
 our $typeTypedefs = qr{(?x:
+        (?![KMGTPE]iB)                      # IEC binary prefix (do not match)
         [A-Z][A-Z\d_]*[a-z][A-Za-z\d_]*     # camelcase
         | [A-Z][A-Z\d_]*AIOCB               # all uppercase
         | [A-Z][A-Z\d_]*CPU                 # all uppercase
-- 
2.18.0
