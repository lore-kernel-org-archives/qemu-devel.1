Received: from eggs.gnu.org ([2001:4830:134:3::10]:54057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3d-00071a-9K
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006Mv-HS
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3Y-0006Lc-6E
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:36:07 +0100
Message-Id: <20180211093607.27351-30-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 29/29] qapi: Don't create useless directory
 qapi-generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

We used to generate first test and later QGA QAPI code into
qapi-generated/.  Commit b93b63f574 moved the test code to tests/.
Commit 54c2e50205 moved the QGA code to qga/qapi-generated/.  The
directory has been unused since.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore | 1 -
 Makefile   | 1 -
 configure  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index dabfe6bea8..4055e12ee8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,7 +27,6 @@
 /libuser
 /linux-headers/asm
 /qga/qapi-generated
-/qapi-generated
 /qapi-gen-timestamp
 /qapi/qapi-builtin-types.[ch]
 /qapi/qapi-builtin-visit.[ch]
diff --git a/Makefile b/Makefile
index 84411ee6ab..7eb1ede6f4 100644
--- a/Makefile
+++ b/Makefile
@@ -726,7 +726,6 @@ clean:
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
-	rm -rf qapi-generated
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
diff --git a/configure b/configure
index 62562f08cf..f564a1639e 100755
--- a/configure
+++ b/configure
@@ -7015,7 +7015,6 @@ DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-sche
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
-DIRS="$DIRS qapi-generated"
 FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
 FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
-- 
2.13.6
