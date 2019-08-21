Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A26D216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7Hom9ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A26D216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SJK-0007WU-5y
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG7-0002zI-PG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG6-0003mv-Ly
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:47 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SG6-0003m3-GZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id u17so1480655pgi.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KqlVsnaOeX/E+Fhbyxg3evO4GmXPJ1XI8OVKBd0Xo/E=;
 b=q7Hom9ZUjNC/5X99dYhSrZycFAV7AY+4K/8P7oFuPUzfRODUnKd4u7ciP8WXv87NOH
 rhv9KdUTVLGdnJSiVw48EAKCTRSK1A8rW5Mg8UCViU4SNDW5F42v15eHzSojnuNUfy1k
 jAXxJVhG0Ac8q5M/pdGOFb2rz4RpXzTzkLE4uC3yq1x9mfhFIMuYK443XsK4D9610zTS
 x8O1O+AKcZSekdpLu6wUjr571I2wDkem9yMwP+lBjOjr+/pJFvHKOqfcbGwLlDy4aYuP
 191LtbOlAG9gxi8x7Ody0cV2EW6PFsv1A2dozQiXEYpiRIZhHp9hUrAc5DaXM/bzXjuy
 G2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqlVsnaOeX/E+Fhbyxg3evO4GmXPJ1XI8OVKBd0Xo/E=;
 b=lfz5VaPaCH5BDgJd/TQLvsbuq0LOx6hVUdIOfn2CA7bSD/wh+J4KK0zkKuHZb21AbM
 GRdZ8agpQYWYAsWuXiluJROTBNK0a9R5xIF3FSNEz26d1qJ9iqznIEAtVT7GT6uHn+JH
 evZfo5DUP+h3Rj6L8yyzI5roEFQL89qekZB/QxpekvMl3zGgJZB8AQrqApyIPxRpnPaG
 v0sj/CZb6f7zL38SS+T8b9QqNFYcekXf/Y3lgUikv6ZK8MXT5+13t8/Fc0X1Qyhw2MiJ
 0fhcRI5yRl4xRr7V3f9eBiCRqWD4QWmuK+o0y5J3z8wJZkhEN4vg36UyeJwCJeKLDxXK
 ZNaQ==
X-Gm-Message-State: APjAAAVV8yIMPg8F4/RhghZWWXFM7sBpFXrCbrXJb5ahO0QmcbmEXFTJ
 eAly3gkMiFxFYp7U4uG0NHJekUkMfyk=
X-Google-Smtp-Source: APXvYqwbQb/098CKzO6JBCvhCMFlE3+DQ1OKY8xndGOIvZT2zXZUu6D3eaTsOf99J/Jg20YtMMlxTA==
X-Received: by 2002:a65:684a:: with SMTP id q10mr29866732pgt.417.1566400245269; 
 Wed, 21 Aug 2019 08:10:45 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:44 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:13 +1000
Message-Id: <a10da7c5a553f51b89be01cb404f3a468bac244c.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v8 19/21] cputlb: Byte swap memory transaction
 attribute
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notice new attribute, byte swap, and force the transaction through the
memory slow path.

Required by architectures that can invert endianness of memory
transaction, e.g. SPARC64 has the Invert Endian TTE bit.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c      | 11 +++++++++++
 include/exec/memattrs.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3c9e634d99..f4573e2c7a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -738,6 +738,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
          */
         address |= TLB_RECHECK;
     }
+    if (attrs.byte_swap) {
+        address |= TLB_FORCE_SLOW;
+    }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
         /* IO memory case */
@@ -891,6 +894,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (iotlbentry->attrs.byte_swap) {
+        op ^= MO_BSWAP;
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -933,6 +940,10 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (iotlbentry->attrs.byte_swap) {
+        op ^= MO_BSWAP;
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a3477d71..95f2d20d55 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* Invert endianness for this page */
+    unsigned int byte_swap:1;
     /*
      * The following are target-specific page-table bits.  These are not
      * related to actual memory transactions at all.  However, this structure
-- 
2.23.0


