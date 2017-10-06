Received: from eggs.gnu.org ([2001:4830:134:3::10]:40488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOL-0006qD-3c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOK-0004l4-Ar
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:00 -0300
Message-Id: <20171006235023.11952-6-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/88] cocci: use g_strfreev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/g_new.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.cocci
index 9643ce3f23..42ab166d04 100644
--- a/scripts/coccinelle/g_new.cocci
+++ b/scripts/coccinelle/g_new.cocci
@@ -173,6 +173,17 @@ expression s, e;
   ... when != p
   *p = e;
 
+// g_strfreev()
+@@
+identifier p, a;
+@@
+-   for (p = a; *p; p++) {
+-       g_free(*p);
+-   }
+    ... when != a
+-    g_free(a);
++    g_strfreev(a);
+
 ////////////////////////////////////////
 //
 // last transformations: cleanups
-- 
2.14.2
