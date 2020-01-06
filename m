Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E5C33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618B22072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szZ/2NDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXD1-0004uU-Qx
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3x-0001oU-GT
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3w-0003y9-6Z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:13 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3w-0003wo-1v; Mon, 06 Jan 2020 13:25:12 -0500
Received: by mail-qt1-x844.google.com with SMTP id n15so43210630qtp.5;
 Mon, 06 Jan 2020 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wNyN4G4tLR9E8OrgeCl2UNMlP8h56Iu2NzeloDyPJKs=;
 b=szZ/2NDmZZkk416Jl30SXuRfce1Lb8bCbcwl4bonG515oQAqjm11G3slp7ZGoLzXi4
 S+RofwQUkJkF9Qn99lzClL2uuBU4b0B2VKmQZMiquGMH4R4vAZ+54mSlroGK58IRr/8I
 vwVo43hVJ0ZuS8B2muoHUtiyKAWif044J3PN4tmCTYbL7fRYzYwZCyDwPOwiNuTEx4EP
 BroIUibWDoEnficSgeOgmkDOvAqZjqdYgTxy9ES3UXDoOxw+a1Ld5MPtB20wEJE6nsID
 erN6HGy2/Q6PdjQnS+N9pNcgcaF8lUyRwFHsOShIRfE1BA97gS+R4T7KXclRg6XqIoFC
 1Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wNyN4G4tLR9E8OrgeCl2UNMlP8h56Iu2NzeloDyPJKs=;
 b=FOAsoopdMOPPgGWtlgaaXLWtPHQCOg6WXh1lEQ9AGN8onkjQiI7Pmv3y8fCArrVr32
 zxBs5VFX9l7S6PNQAzrkehnu1OwbPYC2HTFYNaVROLcVJXJgcUCWo0AVa5pVnPJt3U1/
 crhl1J+jRAQo1v2BkiXpf9hKMRsHausWVrKFn8lX9BFDQblS8KgGATisqXZcI7pGEOTW
 0DMV6Okzm3gtmA9xAVepBLffyAcjta7pdSdUDIyEKK8EiC5HSoptj7CB8yC0GZJja3j8
 6EhSm2B/uGQ+xnalkL0/g5BGj/MG3zTx5+4usvCIC3GQVXFuTkkgSTUIhUu3NDFf/Mqc
 XJAw==
X-Gm-Message-State: APjAAAWVSbOrtMfs+yskP1HFUxW2GKCQKLBweCrYrh1hVHsM07/qCgXz
 iZevWxoTv7m20uo7Q/FuHvQx25kz
X-Google-Smtp-Source: APXvYqzLWtQJ+bUN46xBQKxQOfytbUMLBQTKH1xJ3o+iwnVg7mgodRy5RhKkkopvjs4bbqJqnnnRew==
X-Received: by 2002:ac8:4289:: with SMTP id o9mr76710977qtl.277.1578335111312; 
 Mon, 06 Jan 2020 10:25:11 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:10 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/59] exec.c: remove 'err' label in
 ram_block_discard_range()
Date: Mon,  6 Jan 2020 15:23:37 -0300
Message-Id: <20200106182425.20312-12-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'err' is a label that just executes 'return ret'. We can remove
the label and simply 'return ret' on error.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index d4b769d0d4..7cfd80826e 100644
--- a/exec.c
+++ b/exec.c
@@ -3898,7 +3898,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
     if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
         error_report("ram_block_discard_range: Unaligned start address: %p",
                      host_startaddr);
-        goto err;
+        return ret;
     }
 
     if ((start + length) <= rb->used_length) {
@@ -3906,7 +3906,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
         if (length & (rb->page_size - 1)) {
             error_report("ram_block_discard_range: Unaligned length: %zx",
                          length);
-            goto err;
+            return ret;
         }
 
         errno = ENOTSUP; /* If we are missing MADVISE etc */
@@ -3930,14 +3930,14 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                 error_report("ram_block_discard_range: Failed to fallocate "
                              "%s:%" PRIx64 " +%zx (%d)",
                              rb->idstr, start, length, ret);
-                goto err;
+                return ret;
             }
 #else
             ret = -ENOSYS;
             error_report("ram_block_discard_range: fallocate not available/file"
                          "%s:%" PRIx64 " +%zx (%d)",
                          rb->idstr, start, length, ret);
-            goto err;
+            return ret;
 #endif
         }
         if (need_madvise) {
@@ -3953,14 +3953,14 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                 error_report("ram_block_discard_range: Failed to discard range "
                              "%s:%" PRIx64 " +%zx (%d)",
                              rb->idstr, start, length, ret);
-                goto err;
+                return ret;
             }
 #else
             ret = -ENOSYS;
             error_report("ram_block_discard_range: MADVISE not available"
                          "%s:%" PRIx64 " +%zx (%d)",
                          rb->idstr, start, length, ret);
-            goto err;
+            return ret;
 #endif
         }
         trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
@@ -3971,7 +3971,6 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                      rb->idstr, start, length, rb->used_length);
     }
 
-err:
     return ret;
 }
 
-- 
2.24.1


