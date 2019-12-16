Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637A5206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr69G6hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637A5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtvE-0000uv-6e
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFo-00064O-AY
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFn-0000pK-4k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:52 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFm-0000ld-IT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so515885wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iSvd7kR69HHZhRhQRzsPwBtBWFePaMT2xa1YRgm+R84=;
 b=Wr69G6hmY4M6IsGX1Zcy9pTNIvrQYCiIG8cpSrPvTb/D+4+8So7lH3Jb9ndZPRmsio
 0dRDXAo9k8JYCWgz184C289Zwp+bkV+WBS+wYODp8h7Gm0tNGlXhSgz+Ii1RllEyDKzZ
 +ru5OsMFrloFOOr/hCv6u891aPTaLrnNG00XJjo65TNuqsfZXv2IDwpIX3K9t3p2azGY
 ds6mrFt9QGLakZgshZzTBNrU/6t4To6d9Jyg/VFxmOry5n1TJ0I2G2jhLxklTln+lTkl
 loA8P30MURqigaws69spBulr4O2b4E9RKZNcsdrl5tN86LuYC2u4hzmxwbWIPudkh0ev
 oY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iSvd7kR69HHZhRhQRzsPwBtBWFePaMT2xa1YRgm+R84=;
 b=CZSJrk4iDwq2y46NTqGBgQ2fYfl1loeEXs8OrWS+rW1ROLvG0QBRUFNSAfb14wHdjZ
 JE2NaSMYmliaahx1C9x4yFVsFTx5txdJkv1x+jhEPXTzHGD4kE6QQPdDeTnkXQjWaOYx
 WarmCbzFDkYfORyBFYE0Qn2Bb9rq2ErNeg/+yqaC0ecN7W/bS39TZRqxqmwWAJAOfkz4
 Lk75q6otbRBC1CLwEew9VkD5SG1QPw3NtZq5qkOEbKF921dksGhwih0/dX9692hMX3cZ
 UFcUEaReqTseSpaJcfBYNZkn+YoxKbl4n6N8NREo1LdoHwndcc7jpoHGXE1WdQo+ZL1Z
 L7jQ==
X-Gm-Message-State: APjAAAVOgpXUYb3h3CXDrXFlT2ogC6FHMp0/4adJTegvxJv1JMf6li/i
 EJS8YRcoLfQWoOPGoODZMFItcnHy
X-Google-Smtp-Source: APXvYqxFF4WBvrTC4OIyBL0ho+kV9Z0aagU72rwUlAfZeqvHMdXQeZuxA0qx6Vn5OuFcEZk1lJ9HiQ==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr30146077wro.56.1576513789346; 
 Mon, 16 Dec 2019 08:29:49 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 62/62] colo: fix return without releasing RCU
Date: Mon, 16 Dec 2019 17:28:46 +0100
Message-Id: <1576513726-53700-63-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use WITH_RCU_READ_LOCK_GUARD to avoid exiting colo_init_ram_cache
without releasing RCU.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/ram.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7dd7f81..8d7c015 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3891,26 +3891,27 @@ int colo_init_ram_cache(void)
 {
     RAMBlock *block;
 
-    rcu_read_lock();
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        block->colo_cache = qemu_anon_ram_alloc(block->used_length,
-                                                NULL,
-                                                false);
-        if (!block->colo_cache) {
-            error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                         block->used_length);
-            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-                if (block->colo_cache) {
-                    qemu_anon_ram_free(block->colo_cache, block->used_length);
-                    block->colo_cache = NULL;
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            block->colo_cache = qemu_anon_ram_alloc(block->used_length,
+                                                    NULL,
+                                                    false);
+            if (!block->colo_cache) {
+                error_report("%s: Can't alloc memory for COLO cache of block %s,"
+                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
+                             block->used_length);
+                RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+                    if (block->colo_cache) {
+                        qemu_anon_ram_free(block->colo_cache, block->used_length);
+                        block->colo_cache = NULL;
+                    }
                 }
+                return -errno;
             }
-            return -errno;
+            memcpy(block->colo_cache, block->host, block->used_length);
         }
-        memcpy(block->colo_cache, block->host, block->used_length);
     }
-    rcu_read_unlock();
+
     /*
     * Record the dirty pages that sent by PVM, we use this dirty bitmap together
     * with to decide which page in cache should be flushed into SVM's RAM. Here
-- 
1.8.3.1


