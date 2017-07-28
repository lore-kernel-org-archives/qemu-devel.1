Received: from eggs.gnu.org ([2001:4830:134:3::10]:35357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2O-0002Pq-3z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2N-0001zY-6I
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:25:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:35 -0300
Message-Id: <20170728012542.29975-2-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
References: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 1/8] docs: fix broken paths to
 docs/interop dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Cleber Rosa <crosa@redhat.com>

With the move of some docs to docs/interop on d59157e, a couple of
references where not updated.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
[PMD: fixed another reference in docs/interop/qmp-spec.txt]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 2 +-
 qapi-schema.json                    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 1e6375495b..69793e320e 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -8,7 +8,7 @@ into the QAPI framework implementation.
 
 For an in-depth introduction to the QAPI framework, please refer to
 docs/qapi-code-gen.txt. For documentation about the QMP protocol,
-start with docs/qmp-intro.txt.
+start with docs/interop/qmp-intro.txt.
 
 == Overview ==
 
diff --git a/qapi-schema.json b/qapi-schema.json
index dcc12c83a9..5fda5fa4d2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -23,7 +23,7 @@
 # | -> data issued by the Client
 # | <- Server data response
 #
-# Please, refer to the QMP specification (docs/qmp-spec.txt) for
+# Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
 #
 # = Stability Considerations
@@ -108,7 +108,7 @@
 #
 # Notes: This command is valid exactly when first connecting: it must be
 # issued before any other command will be accepted, and will fail once the
-# monitor is accepting other commands. (see qemu docs/qmp-spec.txt)
+# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
 #
 # Since: 0.13
 #
-- 
2.13.3
