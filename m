Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD6C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 02:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0902075B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 02:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA+FsrXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0902075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrvUa-0004gC-TS
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 22:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hrvTE-0002Zj-QO
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hrvTD-00058M-N2
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hrvTD-00056Z-HG
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so21197539pgc.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E/4hPH9CYnRQOxbkw9I2lZDmI588i/uLbgGIwXRaeug=;
 b=HA+FsrXASIblvbu/s+Kp6wn0lf+e8lB4/Enl/yL1ZvOXnC3nZG4QEk+KXDFBv3qthu
 zHhq9q6MlENtAiDucRdfOThcZWEhB/JzhVCH3P/ssSOST304ksmMr3IXHRhgfUOMNcyR
 IbdjgKN4sqywcA4ziju+Ub3vGihiOpnSXVYlpGtS2oPsHIsjdq7fCYuasTp9HVC6DJAT
 PYBfez+Lx1BFItiUEJ7Sy+Vrmbbq1QZaDGlmi6OLgtMLL9JYtIO/RoPSIWJc3Qslqfx0
 O1CImgqckUaqISTCHngCmgvV4Pz41xMrQJJI4ajpzvhqD3vPuiEJK1fLbvnU5FI0pnaG
 PWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E/4hPH9CYnRQOxbkw9I2lZDmI588i/uLbgGIwXRaeug=;
 b=BSahXtklMWn2vHxk9KGoSHr4UUzh4X7zVEqwVN4xqChjZZvsmcsN5CBiZAwG3W90Zv
 z75u2ks2gKwZ+fRIUIV3ARRZ5dYQXFD8T8DuLxiFroS0zZR11WqEmq7OBdvRTaxEY33q
 WBKVlbUuCl2m9ijkN87FRAzaaxzwxCFFVGyUG2rhdNqR0b2GpQNb4m+pPYLvSAWXHeyD
 4AI6d4+FtsvODT6yGBsGjbmDLQpd1JeXZIR976LWIOuyTM9IWh6IsrRfVaeSPoc5WIjQ
 Nes+wdYJSyga1qP5lSTxb4UsPNVLCGJgYRUrkKt0KU7h9Ar1R+mD5va5Kp1NLydoGzTk
 0JtA==
X-Gm-Message-State: APjAAAVRf7kMB6wM/H0udws5lSD2lpPxBBmbddX+sM5+NZbViD34Gv5k
 IFQk9TsBfAWU1gN0LVtVlpQ=
X-Google-Smtp-Source: APXvYqydm6JusUjGUBxSrtiZHyeQyQ3rc+JdAMqgZBzTDSQ8bg4PyYQsy5d8SdwisLay1tf/dN/Brw==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr34178377pfc.62.1564367582664; 
 Sun, 28 Jul 2019 19:33:02 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id m9sm103281519pgr.24.2019.07.28.19.33.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jul 2019 19:33:02 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Mon, 29 Jul 2019 10:32:53 +0800
Message-Id: <1564367573-6327-3-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564367573-6327-1-git-send-email-ivanren@tencent.com>
References: <1564367573-6327-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 2/2] migration: add speed limit for multifd
 migration
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

Limit the speed of multifd migration through common speed limitation
qemu file.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 889148dd84..e3fde16776 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -922,7 +922,7 @@ struct {
  * false.
  */
 
-static int multifd_send_pages(void)
+static int multifd_send_pages(RAMState *rs)
 {
     int i;
     static int next_channel;
@@ -954,6 +954,7 @@ static int multifd_send_pages(void)
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;
+    qemu_file_update_rate_transfer(rs->f, transferred);
     ram_counters.multifd_bytes += transferred;
     ram_counters.transferred += transferred;;
     qemu_mutex_unlock(&p->mutex);
@@ -962,7 +963,7 @@ static int multifd_send_pages(void)
     return 1;
 }
 
-static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages = multifd_send_state->pages;
 
@@ -981,12 +982,12 @@ static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
         }
     }
 
-    if (multifd_send_pages() < 0) {
+    if (multifd_send_pages(rs) < 0) {
         return -1;
     }
 
     if (pages->block != block) {
-        return  multifd_queue_page(block, offset);
+        return  multifd_queue_page(rs, block, offset);
     }
 
     return 1;
@@ -1054,7 +1055,7 @@ void multifd_save_cleanup(void)
     multifd_send_state = NULL;
 }
 
-static void multifd_send_sync_main(void)
+static void multifd_send_sync_main(RAMState *rs)
 {
     int i;
 
@@ -1062,7 +1063,7 @@ static void multifd_send_sync_main(void)
         return;
     }
     if (multifd_send_state->pages->used) {
-        if (multifd_send_pages() < 0) {
+        if (multifd_send_pages(rs) < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return;
         }
@@ -1083,6 +1084,7 @@ static void multifd_send_sync_main(void)
         p->packet_num = multifd_send_state->packet_num++;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
+        qemu_file_update_rate_transfer(rs->f, p->packet_len);
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -2079,7 +2081,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    if (multifd_queue_page(block, offset) < 0) {
+    if (multifd_queue_page(rs, block, offset) < 0) {
         return -1;
     }
     ram_counters.normal++;
@@ -3482,7 +3484,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
 
-    multifd_send_sync_main();
+    multifd_send_sync_main(*rsp);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
 
@@ -3570,7 +3572,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
 out:
-    multifd_send_sync_main();
+    multifd_send_sync_main(rs);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
     ram_counters.transferred += 8;
@@ -3629,7 +3631,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     rcu_read_unlock();
 
-    multifd_send_sync_main();
+    multifd_send_sync_main(rs);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
 
-- 
2.17.2 (Apple Git-113)


