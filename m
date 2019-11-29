Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8633A21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwbFRKD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8633A21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iah7S-0005Nc-HD
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqt-00029N-MT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqr-0003R4-Dr
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqp-0003ON-Au
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id n5so15203883wmc.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CKVENrRxKr+yy55UKAYjTBDTqL1/JJ86swpmf0+y21k=;
 b=fwbFRKD+1YbilVGvErK7cPKPmDiHX/94U1SysPMy+ea07KJ5aC8IW+OtHlmn/P1ZYA
 9Q/GoUnCIaZ8U756KytY6peyfNh564fFuyUE61C6VGw4szBxuquqG7zTYVVQVbqBeevE
 DZZh8G8g4yy2C0g12kGsRqDqW3pSXr6r2h0cYHB2lDx27IYMPmfSHdzx7EbpF4UnbfoM
 0PZjslUSUDiA/skUigPflZfH0AhySfAOb+8kYjS04FlDHdHg1OwaznjN/2bCGrEfBWcM
 2GaNYYTRsTGQT+iPSNbB++fxUQfNd0WUIzQ1jQji4l63eIwR5NtC6LdiauRJGWzOHt+t
 kavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CKVENrRxKr+yy55UKAYjTBDTqL1/JJ86swpmf0+y21k=;
 b=fCVD+JNTQrOS+GUYwTQa1J9J+GpfV+YwdAUkSe0EARsia/GFP6V0sar+sEiGDsKCNg
 Yjd1zZMM+GqsD0qIpLPXKgCa8i+x2QR2jzTA4T/JAWv81JWcXj0/Qpab6R3i/cMVpMGJ
 aKgicdlADEMedNYfjIvcU0cb86l9G2qFPkZE5gAPABNpaY535bS4dyFsL+9uBq5a/qA+
 1U6gzFXciGxFq9lib7vvhUvcehGlij/nh4Amz0onF5B4OcOH1H9kHKrORCbCgWcC3OtY
 oMPGphXhTyTmmQz7UGWkoQWlXxC/UNf9ubTH7D9G248ft/RVlhPuKQgaAH9ZtEicNY9K
 u1gQ==
X-Gm-Message-State: APjAAAWCREsG7XSgkFJ4JOuM6N1Gu2DE46aQrD0tR3khsa/tIeUNSI9N
 QwsDbVAKyCGshUre6KPT0QgfXbda
X-Google-Smtp-Source: APXvYqyudCsNKqBBoX/lHgexCg7d38Nr3EB1GK4pNeDXX7OsaUOSlRuTTTF1xcJxq69hNNXwfGkt+g==
X-Received: by 2002:a05:600c:290d:: with SMTP id
 i13mr14860689wmd.139.1575036145597; 
 Fri, 29 Nov 2019 06:02:25 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] memory.h: Silence kernel-doc complaints
Date: Fri, 29 Nov 2019 15:02:16 +0100
Message-Id: <20191129140217.17797-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a few instances where kernel-doc complains about doc comments
in memory.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc215b..1e875996ec 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -360,10 +360,14 @@ typedef struct IOMMUMemoryRegionClass {
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
+/** MemoryRegion:
+ *
+ * A struct representing a memory region.
+ */
 struct MemoryRegion {
     Object parent_obj;
 
-    /* All fields are private - violators will be prosecuted */
+    /* private: */
 
     /* The following fields should fit in a cache line */
     bool romd_mode;
@@ -452,7 +456,7 @@ struct MemoryListener {
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
-    /* All fields are private. */
+    /* private: */
     struct rcu_head rcu;
     char *name;
     MemoryRegion *root;
@@ -1673,8 +1677,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  *
  * Returns a #MemoryRegionSection that describes a contiguous overlap.
  * It will have the following characteristics:
- *    .@size = 0 iff no overlap was found
- *    .@mr is non-%NULL iff an overlap was found
+ * - @size = 0 iff no overlap was found
+ * - @mr is non-%NULL iff an overlap was found
  *
  * Remember that in the return value the @offset_within_region is
  * relative to the returned region (in the .@mr field), not to the
@@ -1685,8 +1689,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * returned one.  However, in the special case where the @mr argument
  * has no container (and thus is the root of the address space), the
  * following will hold:
- *    .@offset_within_address_space >= @addr
- *    .@offset_within_address_space + .@size <= @addr + @size
+ * - @offset_within_address_space >= @addr
+ * - @offset_within_address_space + .@size <= @addr + @size
  *
  * @mr: a MemoryRegion within which @addr is a relative address
  * @addr: start of the area within @as to be searched
-- 
2.21.0



