Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BEDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12635206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8TLh5T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12635206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SRL-0002nz-4I
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFo-0002Sa-VQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFn-0003C3-Mo
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFn-0003Au-GI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:27 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn20so1494698plb.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lpVDEK6XkJhhVKBHnaNqkOcPkmscKQhLgwYwcHANolA=;
 b=k8TLh5T0SkZRhUTc1xemSznrhpfSKB0qXL84u4yTZl6JdeHaDhyW2+JobcUgUE4VSJ
 rjo9oQth0j6LeejNVYCqtWv6sPuMf+Lelvx1CkNposwjofmtKNupuwm29sr77p3/0ZHB
 kw8qEqodAlWo0217VvJhlkm+/ct5kFJDov0jMP242aqnaBafr7QhOggAJhrYMbWYGl5p
 4vi/EpyJcKrF8X/HpywCORfGzLoHsepFud9RXosnoRBXr1L0xmNQExZNv2rHyRejXebL
 zXiT7W/eFs0XICMXLIRR99QIpJDG+ODoSKlg5bH7QZ9q4XxBfyj0eT6koR05/Gt1J+iH
 NJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lpVDEK6XkJhhVKBHnaNqkOcPkmscKQhLgwYwcHANolA=;
 b=XZwzHpKSX+lWC81ACrKCFUkpsE0DDXBcLL2bqJuejQKhnwlPGbiT6PYB+teucymC16
 b0kwWXdjLp3vtLV2g12kNz/z7fpIn0QzJwXsX9Fxe81uDrYpqQqHTNa2yuXIjtInWZgp
 1rkLoYjYuBzyOp4AIvj/+SviiD9w/2qxp+7tHZhavnuXUxtybIrXNU90eaqfVpTdnTfa
 IPxfDtnn1FV6gpBfeB0vJV1W1gvLNMH34uTatW9dXiRD5FtowcsibnDJkhd+6PboCbDb
 K0aoyItDVMgAtYaTknDvPi7F37UkBI2mGjQ8r9aN+C2nflBa8cYbA1vQizGxWIcbIBeE
 svXg==
X-Gm-Message-State: APjAAAU5bpXrrdTeb6vCeKgG/LdBVB1IIwhRYIPjVuW/+skEUdtoVwWi
 greO7R5qsiATevirA/hx5S9ZCPirBPI=
X-Google-Smtp-Source: APXvYqymXmNjfws0m6jxx1LOUoFCM1r94wqY6MyF/xFTVkQXEg0SYCMpf50M455KBdICrnrfaXbCmA==
X-Received: by 2002:a17:902:9a8d:: with SMTP id
 w13mr33681676plp.157.1566400226064; 
 Wed, 21 Aug 2019 08:10:26 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:25 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:08 +1000
Message-Id: <1d70cb4ae364c5fc9bac78043538929e9a6ceaab.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v8 14/21] exec: Hard code size with
 MO_{8|16|32|64}
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 memory_ldst.inc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 1e8a2fc3ba..de658c40c4 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(4), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap32(val);
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(8), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap64(val);
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(1), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(2), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap16(val);
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         stl_p(ptr, val);
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
             val = bswap32(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(1), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
             val = bswap16(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(2), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
             val = bswap64(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(8), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.23.0


