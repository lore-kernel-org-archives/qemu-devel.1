Received: from eggs.gnu.org ([2001:4830:134:3::10]:33541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uv-0001YI-5Q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000Mb-CO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uq-0000Jv-VN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:24 +0100
Message-Id: <1489582656-31133-36-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 35/47] tests/qapi-schema: Rename
 doc-bad-args to doc-bad-command-arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                                            | 2 +-
 tests/qapi-schema/doc-bad-args.err                                | 1 -
 tests/qapi-schema/doc-bad-command-arg.err                         | 1 +
 tests/qapi-schema/{doc-bad-args.exit => doc-bad-command-arg.exit} | 0
 tests/qapi-schema/{doc-bad-args.json => doc-bad-command-arg.json} | 0
 tests/qapi-schema/{doc-bad-args.out => doc-bad-command-arg.out}   | 0
 6 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-bad-args.err
 create mode 100644 tests/qapi-schema/doc-bad-command-arg.err
 rename tests/qapi-schema/{doc-bad-args.exit => doc-bad-command-arg.exit} (100%)
 rename tests/qapi-schema/{doc-bad-args.json => doc-bad-command-arg.json} (100%)
 rename tests/qapi-schema/{doc-bad-args.out => doc-bad-command-arg.out} (100%)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 505f918..734c7ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -367,7 +367,7 @@ qapi-schema += base-cycle-direct.json
 qapi-schema += base-cycle-indirect.json
 qapi-schema += command-int.json
 qapi-schema += comments.json
-qapi-schema += doc-bad-args.json
+qapi-schema += doc-bad-command-arg.json
 qapi-schema += doc-bad-symbol.json
 qapi-schema += doc-before-include.json
 qapi-schema += doc-before-pragma.json
diff --git a/tests/qapi-schema/doc-bad-args.err b/tests/qapi-schema/doc-bad-args.err
deleted file mode 100644
index 5d44d9b..0000000
--- a/tests/qapi-schema/doc-bad-args.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/doc-bad-args.json:3: The following documented members are not in the declaration: b
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schema/doc-bad-command-arg.err
new file mode 100644
index 0000000..8075b14
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-command-arg.json:3: The following documented members are not in the declaration: b
diff --git a/tests/qapi-schema/doc-bad-args.exit b/tests/qapi-schema/doc-bad-command-arg.exit
similarity index 100%
rename from tests/qapi-schema/doc-bad-args.exit
rename to tests/qapi-schema/doc-bad-command-arg.exit
diff --git a/tests/qapi-schema/doc-bad-args.json b/tests/qapi-schema/doc-bad-command-arg.json
similarity index 100%
rename from tests/qapi-schema/doc-bad-args.json
rename to tests/qapi-schema/doc-bad-command-arg.json
diff --git a/tests/qapi-schema/doc-bad-args.out b/tests/qapi-schema/doc-bad-command-arg.out
similarity index 100%
rename from tests/qapi-schema/doc-bad-args.out
rename to tests/qapi-schema/doc-bad-command-arg.out
-- 
2.7.4
