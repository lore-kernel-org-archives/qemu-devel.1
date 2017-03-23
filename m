Received: from eggs.gnu.org ([2001:4830:134:3::10]:45355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cX-0007mD-B9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cV-0000CI-UD
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cV-0000BJ-O8
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2F1FC04B31F
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:05 +0100
Message-Id: <20170323204544.12015-13-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/51] ram: Remove unused
 dup_mig_bytes_transferred()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/ram.c               | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..3e6bb68 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -276,7 +276,6 @@ void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 
-uint64_t dup_mig_bytes_transferred(void);
 uint64_t dup_mig_pages_transferred(void);
 uint64_t skipped_mig_bytes_transferred(void);
 uint64_t skipped_mig_pages_transferred(void);
diff --git a/migration/ram.c b/migration/ram.c
index 0da133f..af385c4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -192,11 +192,6 @@ static void acct_clear(void)
     memset(&acct_info, 0, sizeof(acct_info));
 }
 
-uint64_t dup_mig_bytes_transferred(void)
-{
-    return ram_state.zero_pages * TARGET_PAGE_SIZE;
-}
-
 uint64_t dup_mig_pages_transferred(void)
 {
     return ram_state.zero_pages;
-- 
2.9.3
