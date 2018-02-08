Received: from eggs.gnu.org ([2001:4830:134:3::10]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejeMQ-0000Nq-Kg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejeMM-00053l-HU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:03:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejeMM-00053a-C2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:02:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
	<20180201111846.21846-13-armbru@redhat.com>
Date: Thu, 08 Feb 2018 06:02:49 +0100
In-Reply-To: <20180201111846.21846-13-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 1 Feb 2018 12:18:39 +0100")
Message-ID: <87vaf86pl2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/19] Include qapi/qmp/qdict.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

Markus Armbruster <armbru@redhat.com> writes:

> This cleanup makes the number of objects depending on qapi/qmp/qdict.h
> drop from 4550 (out of 4743) to 368 in my "build everything" tree.
> For qapi/qmp/qobject.h, the number drops from 4552 to 390.
>
> While there, separate #include from file comment with a blank line.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Squashing in:

diff --git a/block.c b/block.c
index 7269481050..f94585b230 100644
--- a/block.c
+++ b/block.c
@@ -31,6 +31,7 @@
 #include "module_block.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/file-posix.c b/block/file-posix.c
index 2a94a84417..dd8d7cbbd2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -33,6 +33,7 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
 #include "scsi/pr-manager.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index b1585ca218..9f99ae5e07 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -39,6 +39,7 @@
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
 #include "scsi/utils.h"
diff --git a/block/qapi.c b/block/qapi.c
index 12a8cb5a82..1fdeb1ef2f 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/blockdev.c b/blockdev.c
index 90ef3166de..bdbdeae7e4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-visit.h"
diff --git a/hmp.c b/hmp.c
index 13550b0191..7870d6a300 100644
--- a/hmp.c
+++ b/hmp.c
@@ -29,6 +29,7 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index fd994f86b1..bdb6c18a0f 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -14,6 +14,7 @@
 #include "qmp-commands.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "migration/register.h"
diff --git a/monitor.c b/monitor.c
index 31f7aa2488..f4992505b1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -51,6 +51,7 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/acl.h"
 #include "sysemu/tpm.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/net/net.c b/net/net.c
index 3044d60dcc..7d42925258 100644
--- a/net/net.c
+++ b/net/net.c
@@ -33,6 +33,7 @@
=20
 #include "monitor/monitor.h"
 #include "qemu/help_option.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 77bb1993ed..846238175f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -25,6 +25,7 @@
 #include "qmp-commands.h"
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/qga/main.c b/qga/main.c
index 30aa7f92f7..cb434d8c46 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -20,6 +20,7 @@
 #endif
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "qga/guest-agent-core.h"
diff --git a/qmp.c b/qmp.c
index d53021f7d4..793f6f3323 100644
--- a/qmp.c
+++ b/qmp.c
@@ -32,6 +32,7 @@
 #include "sysemu/block-backend.h"
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "hw/boards.h"
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 26c56c5062..f89d748ba4 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -294,6 +294,7 @@ fdef.write(mcgen('''
 #include "qemu-common.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/dealloc-visitor.h"
@@ -307,7 +308,6 @@ fdef.write(mcgen('''
=20
 fdecl.write(mcgen('''
 #include "%(prefix)sqapi-types.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/dispatch.h"
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 9d7134658d..c710968dc2 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -210,6 +210,7 @@ fdef.write(mcgen('''
 #include "%(prefix)sqapi-event.h"
 #include "%(prefix)sqapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp-event.h"
=20
@@ -218,7 +219,6 @@ fdef.write(mcgen('''
=20
 fdecl.write(mcgen('''
 #include "qapi/util.h"
-#include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
=20
 ''',
diff --git a/tests/test-char.c b/tests/test-char.c
index b17d094b85..b358620911 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -8,6 +8,7 @@
 #include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
 #include "qmp-commands.h"
=20
diff --git a/ui/input.c b/ui/input.c
index a5f1cbb3ca..8bef0fb038 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
 #include "trace.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 230c699a51..10cae120cc 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
--=20
2.13.6
