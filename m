Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2W-0002UG-A2
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2T-000242-0j
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:37 -0300
Message-Id: <20170728012542.29975-4-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
References: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 3/8] docs: fix broken paths to
 docs/devel/qapi-code-gen.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/devel/writing-qmp-commands.txt | 2 +-
 include/qapi/visitor.h              | 2 +-
 qapi/introspect.json                | 2 +-
 qapi/qapi-util.c                    | 2 +-
 scripts/qapi2texi.py                | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 69793e320e..4f5b24c0c4 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -7,7 +7,7 @@ This document doesn't discuss QMP protocol level details, nor does it dive
 into the QAPI framework implementation.
 
 For an in-depth introduction to the QAPI framework, please refer to
-docs/qapi-code-gen.txt. For documentation about the QMP protocol,
+docs/devel/qapi-code-gen.txt. For documentation about the QMP protocol,
 start with docs/interop/qmp-intro.txt.
 
 == Overview ==
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index fe9faf469f..0f3b8cb459 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -36,7 +36,7 @@
  * QemuOpts, and clone visitors have some implementation limitations;
  * see the documentation for each visitor for more details on what it
  * supports.  Also, see visitor-impl.h for the callback contracts
- * implemented by each visitor, and docs/qapi-code-gen.txt for more
+ * implemented by each visitor, and docs/devel/qapi-code-gen.txt for more
  * about the QAPI code generator.
  *
  * All of the visitors are created via:
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 1dbaef56eb..cf77ff0669 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -226,7 +226,7 @@
 #
 # @members: the alternate type's members, in no particular order.
 #           The members' wire encoding is distinct, see
-#           docs/qapi-code-gen.txt section Alternate types.
+#           docs/devel/qapi-code-gen.txt section Alternate types.
 #
 # On the wire, this can be any of the members.
 #
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e28dbd0ac3..46eda7d196 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -40,7 +40,7 @@ int qapi_enum_parse(const char * const lookup[], const char *buf,
  * It may be prefixed by __RFQDN_ (downstream extension), where RFQDN
  * may contain only letters, digits, hyphen and period.
  * The special exception for enumeration names is not implemented.
- * See docs/qapi-code-gen.txt for more on QAPI naming rules.
+ * See docs/devel/qapi-code-gen.txt for more on QAPI naming rules.
  * Keep this consistent with scripts/qapi.py!
  * If @complete, the parse fails unless it consumes @str completely.
  * Return its length on success, -1 on failure.
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 9e015002ef..a317526e51 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -91,7 +91,7 @@ def texi_format(doc):
         # doesn't.
         #
         # Make sure to update section "Documentation markup" in
-        # docs/qapi-code-gen.txt when fixing this.
+        # docs/devel/qapi-code-gen.txt when fixing this.
         if line.startswith('| '):
             line = EXAMPLE_FMT(code=line[2:])
         elif line.startswith('= '):
-- 
2.13.3
