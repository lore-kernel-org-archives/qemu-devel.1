Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55853C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 14:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E65205F4
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 14:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkJgUmfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E65205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmfqo-0002XZ-SF
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 10:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hmfqf-00027B-22
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hmfqd-0002QO-7o
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:51:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hmfqc-0002PN-N7
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 10:51:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so6526736pgj.7
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wbXQ0ReYPaw6cL6QJZRR5dXQ3MmUpeCBsUBi8cnTKK4=;
 b=hkJgUmfoOZgPYcH7+LK7ptvnEHS1PsZDXBsP99P5OGlyL8ihIRz7gWDHmjLQc9ST5y
 m1pCC2/aNfY9SPM5BLEshpYlkocMezI3INw6ow++WE3y087m02UbplFMY/R1Ft8yHSfG
 0XCeyvwujaWLNejQ+/k+ReivbXCG2cYIf3AgIYYR0RTDN3Nm3yQ9EMjFkb7iZ5Nt+Xw9
 toqPvnPokWnjEe8o/zSofGVAHOfIIUgVZLkms9j10pKgXGK2aAVGFiV6V32Lb2KWIbNR
 mmO36LcRTfF/tEQGsLq4U5CbBXAeC5T0ZhbyqorHCC+bT5TWoOsWq2T4JITnrMXledr+
 KQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wbXQ0ReYPaw6cL6QJZRR5dXQ3MmUpeCBsUBi8cnTKK4=;
 b=AHyrtp3PJ0q8/HkgH1mJwHB4SoT27MvHKNu41+lKu0P9EkkmquckGBUTkQaFeIKpYW
 79xnjKyOC9X4PI7U8IZsvAqWA0SHJ5LuXD9GbWuWkPXItY5A6vgPBD65YUD8LmvWarX5
 4NiJ8vqQ1c+2aWYCaW08vmoFR1p2RWTTXZLoYOoRCSw7ckn0eVGExEyTq8KFq0NtKpln
 CXg6VrKyHtOcca6rDJa4btclnlZPPMwMT7V5k+mGippvIJ2amoRD0Mg+dLEp+Y4FqLQF
 UtdpEYZ+CJSSv9IWMA7qtw6KzPG60e6VQcKHCKFKqFrPRojKXD4JVnZ4vPxwblXOjIiV
 ia0A==
X-Gm-Message-State: APjAAAV7jADwmhzuH9sBkDWqPj4AI2ggflTng9Jj6MbHKFe6UZtlMhXK
 ip/l3/xSr94qdoZKggIMkTo=
X-Google-Smtp-Source: APXvYqxTw3eb2T9JLQtf/eG+qAGDvLG2WJzYznDn9E8KErEJPR0vMzbqk1CQZum9UksXGV9nLQ3dPg==
X-Received: by 2002:a17:90a:7d04:: with SMTP id
 g4mr24128726pjl.41.1563115888138; 
 Sun, 14 Jul 2019 07:51:28 -0700 (PDT)
Received: from VM_0_37_centos.localdomain ([129.226.63.251])
 by smtp.gmail.com with ESMTPSA id v27sm17216403pgn.76.2019.07.14.07.51.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 07:51:27 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Sun, 14 Jul 2019 22:51:19 +0800
Message-Id: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH] migration: always initial RAMBlock.bmap to 1
 for new migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reproduce the problem:
migrate
migrate_cancel
migrate

Error happen for memory migration

The reason as follows:
1. qemu start, ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] all set to
   1 by a series of cpu_physical_memory_set_dirty_range
2. migration start:ram_init_bitmaps
   - memory_global_dirty_log_start: begin log diry
   - memory_global_dirty_log_sync: sync dirty bitmap to
     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
   - migration_bitmap_sync_range: sync ram_list.
     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
3. migration data...
4. migrate_cancel, will stop log dirty
5. migration start:ram_init_bitmaps
   - memory_global_dirty_log_start: begin log diry
   - memory_global_dirty_log_sync: sync dirty bitmap to
     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
   - migration_bitmap_sync_range: sync ram_list.
     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero

   Here RAMBlock.bmap only have new logged dirty pages, don't contain
   the whole guest pages.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 908517fc2b..bbebaee0c1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3173,11 +3173,11 @@ static int ram_state_init(RAMState **rsp)
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
     /*
+     * Count the total number of pages used by ram blocks not including any
+     * gaps due to alignment or unplugs.
      * This must match with the initial values of dirty bitmap.
-     * Currently we initialize the dirty bitmap to all zeros so
-     * here the total dirty page count is zero.
      */
-    (*rsp)->migration_dirty_pages = 0;
+    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
     ram_state_reset(*rsp);
 
     return 0;
@@ -3196,12 +3196,13 @@ static void ram_list_init_bitmaps(void)
              * The initial dirty bitmap for migration must be set with all
              * ones to make sure we'll migrate every guest RAM page to
              * destination.
-             * Here we didn't set RAMBlock.bmap simply because it is already
-             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
-             * ram_block_add, and that's where we'll sync the dirty bitmaps.
-             * Here setting RAMBlock.bmap would be fine too but not necessary.
+             * Here we set RAMBlock.bmap all to 1 because when rebegin a
+             * new migration after a failed migration, ram_list.
+             * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the whole
+             * guest memory.
              */
             block->bmap = bitmap_new(pages);
+            bitmap_set(block->bmap, 0, pages);
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
-- 
2.17.2 (Apple Git-113)


