Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AR-0005aL-8T
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AQ-00086w-FM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7AQ-00086k-9g
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6230E8E3DC
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:34 +0200
Message-Id: <20170406130913.2232-16-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/54] ram: Remove unused
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/ram.c               | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 24487be..f07700f 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -276,7 +276,6 @@ void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 
-uint64_t dup_mig_bytes_transferred(void);
 uint64_t dup_mig_pages_transferred(void);
 uint64_t skipped_mig_bytes_transferred(void);
 uint64_t skipped_mig_pages_transferred(void);
diff --git a/migration/ram.c b/migration/ram.c
index cdd56b7..1398597 100644
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
