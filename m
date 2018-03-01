Received: from eggs.gnu.org ([2001:4830:134:3::10]:41045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7j-0001f4-Nf
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7i-0000MD-Na
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7i-0000Lg-I0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFEE4C057F83
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:44:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:45 -0600
Message-Id: <20180301194245.29854-31-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/30] qapi: Don't create useless directory
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
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

We used to generate first test and later QGA QAPI code into
qapi-generated/.  Commit b93b63f574 moved the test code to tests/.
Commit 54c2e50205 moved the QGA code to qga/qapi-generated/.  The
directory has been unused since.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-30-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 configure  | 1 -
 Makefile   | 1 -
 .gitignore | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configure b/configure
index 39f3a430016..7e1772741f1 100755
--- a/configure
+++ b/configure
@@ -7038,7 +7038,6 @@ DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm=
32 tests/libqos tests/qapi-sche
 DIRS=3D"$DIRS docs docs/interop fsdev scsi"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
-DIRS=3D"$DIRS qapi-generated"
 FILES=3D"Makefile tests/tcg/Makefile qdict-test-data.txt"
 FILES=3D"$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 FILES=3D"$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
diff --git a/Makefile b/Makefile
index a470168d985..4df1f67fe48 100644
--- a/Makefile
+++ b/Makefile
@@ -725,7 +725,6 @@ clean:
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
-	rm -rf qapi-generated
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
diff --git a/.gitignore b/.gitignore
index dabfe6bea89..4055e12ee85 100644
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
--=20
2.14.3
