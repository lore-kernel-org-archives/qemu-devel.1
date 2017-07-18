Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY5-0004US-MK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY5-000495-0t
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:53 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY4-00048r-SQ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:52 -0400
Received: by mail-qk0-x243.google.com with SMTP id q66so1228857qki.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:55:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:31 -0300
Message-Id: <20170718045540.16322-2-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/10] coccinelle: ignore ASTs pre-parsed
 cached C files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

files generated using coccinelle tool: 'spatch --use-cache'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 09c2363acf..cf65316863 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,8 @@ tags
 TAGS
 docker-src.*
 *~
+*.ast_raw
+*.depend_raw
 trace.h
 trace.c
 trace-ust.h
-- 
2.13.2
