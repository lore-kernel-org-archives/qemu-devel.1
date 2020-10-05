Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3EC4727D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9C520756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1c6wb3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQ2z-0001A6-O5
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQ13-0008AB-R6; Mon, 05 Oct 2020 08:54:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQ11-0000jC-Hk; Mon, 05 Oct 2020 08:54:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id e17so743312wru.12;
 Mon, 05 Oct 2020 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KBOv/CvOxxFmYdUajDkUeedXPOjqN/XNZCSE+Jws89M=;
 b=k1c6wb3QWq7RFeVEUXkSljHcigYjq+HOuyLSN1GoogwYDEafY7fbDkpBJ27tVUp5X4
 KpzlcTLww50TZPJXw4u1xbwhbJmxwk37YexAnGO3qO1lW3FcB9gJkgb//Eti9BZIUfp0
 Zbe5bsfLBdEC6kxDPIvMpzR5Y+NdRUoM+1gWLVT0QiJG/+KL8xN941BL3KvuuoqGvEMs
 dZS/vymH2hwqhpi6AkNBsSpkyf8aGCZbKWCGwoWsUsgNm4vFrgJZk/b3hEHyrunUh8rI
 fwi9l0+KwbCW6bZl8D1LPElNBaVnETgE575laLkenFp8VyNSI0f5Q48JuHO5Gj5ipvEB
 BJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KBOv/CvOxxFmYdUajDkUeedXPOjqN/XNZCSE+Jws89M=;
 b=WfeqrKmiacSYozHo3tvEYY31tWt+EMi0D9Dj5pgdrzpu3i2NO0cixGrmxveRavwvET
 j6P5lybm4NgYNh/1+b1N9WKasb/lDdua3bvmqlUhTE2Rmi7AYDq5X42BE3vGtsWXrip+
 Qw+/4290Vp+CxAJCmolF95l0CaWqodWKM7dF76lzXSQkMF1IokZznsZVWtrvijP8keWx
 zDACo0QkgDlakbc5BKN5KBdI5IHwt/fKauTd4lCoN028K+8KW6Zyxp6fwVffgpxsPTjT
 13yfrMAK1U2bJX7gLn2Jvf7xT7yjIxjaWRNY0mZhcSW9BPzPItslJDBS/HnsMuba7eWk
 Z7jA==
X-Gm-Message-State: AOAM533jERegYsRu79toQuDwZ5kCbVTzx4WaZKeZvoD7gMblFIssn/MT
 7oFEl3VSWU3g0mWArILVJ21HZl0oiPo=
X-Google-Smtp-Source: ABdhPJzKuyYm6rTCVJ1935tNQvilGIRMI8F6JgYgbBoEuR1rIpvjYZQ7LElPQC4UCG/yPZpS6hRVeQ==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr12222374wro.178.1601902493054; 
 Mon, 05 Oct 2020 05:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id h1sm13432501wrx.33.2020.10.05.05.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 05:54:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: block-dirty-bitmap: rewrite
 dirty_bitmap_load_header
Date: Mon,  5 Oct 2020 14:54:54 +0200
Message-Id: <20201005125454.429077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: vsementsov@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex reported an uninitialized variable warning in dirty_bitmap_load_header,
where the compiler cannot understand that the !s->cancelled check must be
true for the following one to pass.

Even though the issue happened only because of -Og, the function is very
convoluted.  Just rewrite it to first look up s->bs and then s->bitmap,
and to avoid long sequences of "else if"s.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/block-dirty-bitmap.c | 138 ++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 70 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5bef793ac0..24d749e35e 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1010,102 +1010,100 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
                                     GHashTable *alias_map)
 {
-    GHashTable *bitmap_alias_map = NULL;
-    Error *local_err = NULL;
-    bool nothing;
     s->flags = qemu_get_bitmap_flags(f);
     trace_dirty_bitmap_load_header(s->flags);
 
-    nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
-
+    /* Read the whole header early so we can easily cancel in case of errors.  */
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
         if (!qemu_get_counted_string(f, s->node_alias)) {
             error_report("Unable to read node alias string");
             return -EINVAL;
         }
-
-        if (!s->cancelled) {
-            if (alias_map) {
-                const AliasMapInnerNode *amin;
-
-                amin = g_hash_table_lookup(alias_map, s->node_alias);
-                if (!amin) {
-                    error_setg(&local_err, "Error: Unknown node alias '%s'",
-                               s->node_alias);
-                    s->bs = NULL;
-                } else {
-                    bitmap_alias_map = amin->subtree;
-                    s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
-                }
-            } else {
-                s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
-                                       &local_err);
-            }
-            if (!s->bs) {
-                error_report_err(local_err);
-                cancel_incoming_locked(s);
-            }
+    }
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
+        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
+            error_report("Unable to read bitmap alias string");
+            return -EINVAL;
         }
-    } else if (s->bs) {
+    }
+
+    if ((s->flags & ~DIRTY_BITMAP_MIG_FLAG_EOS) == 0 || s->cancelled) {
+        return 0;
+    }
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
+        Error *local_err = NULL;
         if (alias_map) {
             const AliasMapInnerNode *amin;
 
-            /* Must be present in the map, or s->bs would not be set */
             amin = g_hash_table_lookup(alias_map, s->node_alias);
-            assert(amin != NULL);
-
-            bitmap_alias_map = amin->subtree;
+            if (!amin) {
+                error_report("Error: Unknown node alias '%s'", s->node_alias);
+                s->bs = NULL;
+                goto cancel;
+            }
+            s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
+        } else {
+            s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias, &local_err);
         }
-    } else if (!nothing && !s->cancelled) {
+        if (!s->bs) {
+            error_report_err(local_err);
+            goto cancel;
+        }
+        s->bitmap_name[0] = 0;
+    }
+    if (!s->bs) {
         error_report("Error: block device name is not set");
-        cancel_incoming_locked(s);
+        goto cancel;
     }
 
-    assert(nothing || s->cancelled || !!alias_map == !!bitmap_alias_map);
-
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
         const char *bitmap_name;
 
-        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
-            error_report("Unable to read bitmap alias string");
-            return -EINVAL;
-        }
+        if (alias_map) {
+            const AliasMapInnerNode *amin;
+            GHashTable *bitmap_alias_map;
 
-        if (!s->cancelled) {
-            if (bitmap_alias_map) {
-                bitmap_name = g_hash_table_lookup(bitmap_alias_map,
-                                                  s->bitmap_alias);
-                if (!bitmap_name) {
-                    error_report("Error: Unknown bitmap alias '%s' on node "
-                                 "'%s' (alias '%s')", s->bitmap_alias,
-                                 s->bs->node_name, s->node_alias);
-                    cancel_incoming_locked(s);
-                }
-            } else {
-                bitmap_name = s->bitmap_alias;
-            }
-        }
+            amin = g_hash_table_lookup(alias_map, s->node_alias);
+            bitmap_alias_map = amin->subtree;
 
-        if (!s->cancelled) {
-            g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
-            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
-
-            /*
-             * bitmap may be NULL here, it wouldn't be an error if it is the
-             * first occurrence of the bitmap
-             */
-            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
-                error_report("Error: unknown dirty bitmap "
-                             "'%s' for block device '%s'",
-                             s->bitmap_name, s->bs->node_name);
-                cancel_incoming_locked(s);
+            /* Must be present in the map, or s->bs would not be set */
+            assert(bitmap_alias_map);
+            bitmap_name = g_hash_table_lookup(bitmap_alias_map,
+                                              s->bitmap_alias);
+            if (!bitmap_name) {
+                error_report("Error: Unknown bitmap alias '%s' on node "
+                             "'%s' (alias '%s')", s->bitmap_alias,
+                             s->bs->node_name, s->node_alias);
+                goto cancel;
             }
+        } else {
+            bitmap_name = s->bitmap_alias;
         }
-    } else if (!s->bitmap && !nothing && !s->cancelled) {
-        error_report("Error: block device name is not set");
-        cancel_incoming_locked(s);
+
+        g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
+    }
+
+    if (!s->bitmap_name[0]) {
+        error_report("Error: dirty bitmap name is not set");
+        goto cancel;
     }
 
+    /*
+     * bitmap may be NULL here, it wouldn't be an error if it is the
+     * first occurrence of the bitmap
+     */
+    s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+    if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
+        error_report("Error: unknown dirty bitmap "
+                     "'%s' for block device '%s'",
+                     s->bitmap_name, s->bs->node_name);
+        goto cancel;
+    }
+    return 0;
+
+cancel:
+    cancel_incoming_locked(s);
     return 0;
 }
 
-- 
2.26.2


