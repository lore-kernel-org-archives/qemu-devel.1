Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEb-00043j-2Z
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEa-0006sN-Co
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:13 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEa-0006sG-7C
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so11848877qte.0
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 12:30:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 25 Jun 2017 16:29:48 -0300
Message-Id: <20170625192950.17677-3-f4bug@amsat.org>
In-Reply-To: <20170625192950.17677-1-f4bug@amsat.org>
References: <20170625192950.17677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/4] coccinelle: ignore ASTs pre-parsed
 cached C files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
2.13.1
