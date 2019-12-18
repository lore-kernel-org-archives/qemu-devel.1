Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D10C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA3B206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFqtA6w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA3B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYnP-000547-0E
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3k-0007AZ-7p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3i-0002sf-TU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3i-0002oz-LD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id b6so2032143wrq.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YQVEU3O9cxdPzw/GFJ2T/1zXOw28kW3W4l2Fhmj7puw=;
 b=MFqtA6w9Ni+vy+/kvPGMq+MWejGgU7CKpsgaNDizHLAkp8tY6QbSGqdJ2v9DUQcNVz
 GSj/0EuiG0SUuK7HsgZ5F54geVnOymMdj8lTepEzFCThWpOYyTuBLI1BxuzorZ2qttlg
 OYnubCptwV1Y2jgG0e78E/qQQZygC6g/fCD+InMFLbI777eN4enDb8yDnLA/MUPgKB+A
 Wsya8e+WG+fef3fqeN6kyqMih968qodKyctgp27TOEGS7j5MTQ3zRfY4KrlM96groKvV
 CtUy6vakxVb/jPMDflINhs0PRY9Ja8XPUL0XI0Q7mIo38cl3rBUJBb77HANpETFg184R
 ArHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=YQVEU3O9cxdPzw/GFJ2T/1zXOw28kW3W4l2Fhmj7puw=;
 b=l62BnTSLmdOs9fmqWdEryr6SHjfDJLfijPbieV2542qaXIitCS3EYLX2Q3tOMAkTVH
 dq8SwvomC6rXbcjk26maJJrANOaC2xPPRTqUtm0Z2jakPwDwGSYOTsbKjfXQs9+R/za3
 RhkM7nc8vStih/vmB3s04V8B3tSbOU1KogNikupi0j798pe5curAtgFvc+FTXZB2EJ2G
 F/Q0xGRc4wZSXXkrCk7STkklIkgztC2sBZddL9+rt8EBKujrAR7eJmp56O8qmXonZh4o
 wZVTwXOHxeyWJcIXgCIG6ndihNuuKeRAdZXTnLbTrLBnFNz/71Ib0CitiENL2mYwoEKk
 2dJw==
X-Gm-Message-State: APjAAAW+4H5CiPTFllHlTX+oNsp/GN+gccWbTM/KpHNd2+pqDRBMtZeh
 JvX2GvqruFIXgoT3d8WYPnfjI15M
X-Google-Smtp-Source: APXvYqzV3iOP1xJz0i+9SaThGGNKKUrbynBQL1+2BY3cP1euB/ZygZsag3B8a7Mk/6kq0maalOYnxg==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr2378483wru.353.1576670645402; 
 Wed, 18 Dec 2019 04:04:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 62/87] colo: fix return without releasing RCU
Date: Wed, 18 Dec 2019 13:02:28 +0100
Message-Id: <1576670573-48048-63-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
index 219e3ca..96feb40 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3890,26 +3890,27 @@ int colo_init_ram_cache(void)
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



