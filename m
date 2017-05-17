Received: from eggs.gnu.org ([2001:4830:134:3::10]:36627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwu7-0002JV-EF
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwu6-0002CP-Db
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAwu6-0002Bv-7X
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 365C180F6B
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:14:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 13:13:44 +0200
Message-Id: <20170517111346.21450-6-quintela@redhat.com>
In-Reply-To: <20170517111346.21450-1-quintela@redhat.com>
References: <20170517111346.21450-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] migration: Move page_cache.c to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

It is only used by migration, so move it there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile.objs                                 | 1 -
 migration/Makefile.objs                       | 2 +-
 page_cache.c => migration/page_cache.c        | 0
 {include/migration => migration}/page_cache.h | 0
 tests/Makefile.include                        | 2 +-
 5 files changed, 2 insertions(+), 3 deletions(-)
 rename page_cache.c => migration/page_cache.c (100%)
 rename {include/migration => migration}/page_cache.h (100%)

diff --git a/Makefile.objs b/Makefile.objs
index 6167e7b..2100845 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -49,7 +49,6 @@ common-obj-$(CONFIG_POSIX) += os-posix.o
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += migration/
-common-obj-y += page_cache.o #aio.o
 
 common-obj-$(CONFIG_SPICE) += spice-qemu-char.o
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 480dd49..c1920b6 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-y += migration.o socket.o fd.o exec.o
 common-obj-y += tls.o
 common-obj-y += colo-comm.o colo.o colo-failover.o
-common-obj-y += vmstate.o
+common-obj-y += vmstate.o page_cache.o
 common-obj-y += qemu-file.o
 common-obj-y += qemu-file-channel.o
 common-obj-y += xbzrle.o postcopy-ram.o
diff --git a/page_cache.c b/migration/page_cache.c
similarity index 100%
rename from page_cache.c
rename to migration/page_cache.c
diff --git a/include/migration/page_cache.h b/migration/page_cache.h
similarity index 100%
rename from include/migration/page_cache.h
rename to migration/page_cache.h
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 16ff8f3..4277597 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -554,7 +554,7 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o page_cache.o $(test-util-obj-y)
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
-- 
2.9.3
