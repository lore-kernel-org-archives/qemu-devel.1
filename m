Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPx-0008Rf-69
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPu-0005uN-4O
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:29 -0300
Message-Id: <20171006235023.11952-35-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 34/88] qapi: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qapi/opts-visitor.c           | 2 +-
 qapi/qapi-clone-visitor.c     | 2 +-
 qapi/qapi-dealloc-visitor.c   | 2 +-
 qapi/qobject-output-visitor.c | 2 +-
 qapi/string-input-visitor.c   | 2 +-
 qapi/string-output-visitor.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197495..34ac49f3c2 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -539,7 +539,7 @@ opts_visitor_new(const QemuOpts *opts)
     OptsVisitor *ov;
 
     assert(opts);
-    ov = g_malloc0(sizeof *ov);
+    ov = g_new0(OptsVisitor, 1);
 
     ov->visitor.type = VISITOR_INPUT;
 
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index d8b62792bc..3d216e5906 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -145,7 +145,7 @@ static Visitor *qapi_clone_visitor_new(void)
 {
     QapiCloneVisitor *v;
 
-    v = g_malloc0(sizeof(*v));
+    v = g_new0(QapiCloneVisitor, 1);
 
     v->visitor.type = VISITOR_CLONE;
     v->visitor.start_struct = qapi_clone_start_struct;
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ed70a0158b..ad0d0eb7e4 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -120,7 +120,7 @@ Visitor *qapi_dealloc_visitor_new(void)
 {
     QapiDeallocVisitor *v;
 
-    v = g_malloc0(sizeof(*v));
+    v = g_new0(QapiDeallocVisitor, 1);
 
     v->visitor.type = VISITOR_DEALLOC;
     v->visitor.start_struct = qapi_dealloc_start_struct;
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index d325163e55..7228986c0c 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -229,7 +229,7 @@ Visitor *qobject_output_visitor_new(QObject **result)
 {
     QObjectOutputVisitor *v;
 
-    v = g_malloc0(sizeof(*v));
+    v = g_new0(QObjectOutputVisitor, 1);
 
     v->visitor.type = VISITOR_OUTPUT;
     v->visitor.start_struct = qobject_output_start_struct;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 67a0a4a58b..3a2fe58478 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -356,7 +356,7 @@ Visitor *string_input_visitor_new(const char *str)
     StringInputVisitor *v;
 
     assert(str);
-    v = g_malloc0(sizeof(*v));
+    v = g_new0(StringInputVisitor, 1);
 
     v->visitor.type = VISITOR_INPUT;
     v->visitor.type_int64 = parse_type_int64;
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 7ab64468d9..a7bbbae109 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -341,7 +341,7 @@ Visitor *string_output_visitor_new(bool human, char **result)
 {
     StringOutputVisitor *v;
 
-    v = g_malloc0(sizeof(*v));
+    v = g_new0(StringOutputVisitor, 1);
 
     v->string = g_string_new(NULL);
     v->human = human;
-- 
2.14.2
