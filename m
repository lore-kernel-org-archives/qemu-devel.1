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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874AE2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVL37wwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874AE2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXC9-00043E-5A
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3m-0001Wn-Pg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3l-0003k5-II
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:02 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:43225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3l-0003ja-Dv; Mon, 06 Jan 2020 13:25:01 -0500
Received: by mail-qv1-xf44.google.com with SMTP id p2so19406901qvo.10;
 Mon, 06 Jan 2020 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OpEeHG8VMYN/6kN5WjiHoFM09NjO3owbEnQZsuwufHY=;
 b=PVL37wwiLOZ/UhuxFDC6beTK3Lf9R834ZgZAJYqeOvLynH3sjlel0frLEvPiLVMTmv
 I/LeOBkD+Jgo2zHjiy9iMnfjAhX8rUE4e5MkM+02ieHu/p79swltEoStKpEakIWtithb
 RLqm0qkwBazQJZqH5SvwSM6UPV2Czq1U2HMhiF1MYNHT/dycOZ2Gu7HwL/6KDrS31EOR
 cqIwXOIXp4213MdwhaJDWaR3Ez3ScBDYzOWCAV0E0Nmw9Ys8ioCzdE2MqzEdoz/PO0/D
 Kt5n37l/WDj1fOJSj1qWPLfy7x3mK/0BeKZwlJMiRkDjEexJZzA/7hdNh24BpxWxtdVx
 baJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OpEeHG8VMYN/6kN5WjiHoFM09NjO3owbEnQZsuwufHY=;
 b=Z76ocpTOYCsz2a7ELql8+jIoj2DeQTVdOR+EE1zhMDCocqyi7UW2mxk+e6WffEspmN
 grj81z9MwLqJyN9ts+KDLPEz1OegjHxCAd1NALjw9b/VrGRAt1n0JYy2AP6v2KE7Wv2+
 cCAHNXmAEyyEopdvOfIBTRb7I5eQ+EmupBj1DzmJg9CAk4fYk805g0BEJU2EcMad1ijg
 tajMqlaS8K9iSk14IFTN6r3ZvUtGhR2oc5OSWQ24ajdXXRGPkNYhTEHKUtFH0qibiv1u
 R5d7h8DfszDimvNKFs0J/kUiWwtJ1WKgqmrXtxC0NuYQNCYc2YMhStpnTQDdkYXlRmvg
 4ZsA==
X-Gm-Message-State: APjAAAWXPpbO+Qh3PJWgx/sOCQgmoiszTs4h4eR90Mbg1awFVIVw5wfH
 RsUrUG7gB2I9FlVP2R7UVdUnl7O1
X-Google-Smtp-Source: APXvYqyfpYF68ZJGI74BOh433meVATIdOibL9LaFAPigjDejL8zyFx4rLNAADJRr2vi1oN7ik2OHog==
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr78946792qvo.20.1578335100652; 
 Mon, 06 Jan 2020 10:25:00 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:00 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/59] ram.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:23:31 -0300
Message-Id: <20200106182425.20312-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ram_save_queue_pages() has an 'err' label that can be replaced by
'return -1' instead.

Same thing with ram_discard_range(), and in this case we can also
get rid of the 'ret' variable and return either '-1' on error
or the result of ram_block_discard_range().

CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 migration/ram.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 96feb4062c..980cc644d7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2434,7 +2434,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
              * it's the 1st request.
              */
             error_report("ram_save_queue_pages no previous block");
-            goto err;
+            return -1;
         }
     } else {
         ramblock = qemu_ram_block_by_name(rbname);
@@ -2442,7 +2442,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
         if (!ramblock) {
             /* We shouldn't be asked for a non-existent RAMBlock */
             error_report("ram_save_queue_pages no block '%s'", rbname);
-            goto err;
+            return -1;
         }
         rs->last_req_rb = ramblock;
     }
@@ -2451,7 +2451,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
         error_report("%s request overrun start=" RAM_ADDR_FMT " len="
                      RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
                      __func__, start, len, ramblock->used_length);
-        goto err;
+        return -1;
     }
 
     struct RAMSrcPageRequest *new_entry =
@@ -2467,9 +2467,6 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     qemu_mutex_unlock(&rs->src_page_req_mutex);
 
     return 0;
-
-err:
-    return -1;
 }
 
 static bool save_page_use_compression(RAMState *rs)
@@ -3072,8 +3069,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
  */
 int ram_discard_range(const char *rbname, uint64_t start, size_t length)
 {
-    int ret = -1;
-
     trace_ram_discard_range(rbname, start, length);
 
     RCU_READ_LOCK_GUARD();
@@ -3081,7 +3076,7 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
 
     if (!rb) {
         error_report("ram_discard_range: Failed to find block '%s'", rbname);
-        goto err;
+        return -1;
     }
 
     /*
@@ -3093,10 +3088,7 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
                      length >> qemu_target_page_bits());
     }
 
-    ret = ram_block_discard_range(rb, start, length);
-
-err:
-    return ret;
+    return ram_block_discard_range(rb, start, length);
 }
 
 /*
-- 
2.24.1


