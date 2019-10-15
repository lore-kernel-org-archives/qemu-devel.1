Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9095F2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DagjfiVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9095F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKR1M-0007KR-Hl
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQz0-0004yP-46
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQyz-0003S9-05
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKQyy-0003Re-R0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id b128so12971570pfa.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=8nOrlYeU5zcIwPQAiPQrEysfQ5wBLY582fozX0r/c2U=;
 b=DagjfiVGE76/S65G6eK8NIEjaJ0kab+fsDI39tEYEjw+UOlTN3hrj885V1WFlfP38O
 IT520qzq/QtWQgIljzWKhHGbPtD0HI6B0VllBSuKzh0Xh1CoOe8n7U/uvz0VDmuAiWRp
 AslcbdRu8aw+Sk3gwjaqNq/dcMkizrU62IB51iBGvlvSclIaHAMcAYUUFk7+IHVpb7ak
 gfTXVcdNZbq33oN3KOs3W9nwe4BpVEVyz7rUm6aeFJUH0EyJotWes2LJzukliyPqtUUV
 OcuUFdEXPhP0PGsAbSeZFABJOfL6EQd85QiXzLmWX2kaH299tT4F4ojB9N/fZclGAw10
 039A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=8nOrlYeU5zcIwPQAiPQrEysfQ5wBLY582fozX0r/c2U=;
 b=dLYudaMzOrCvJPwwRQgUDefMIRwOCOP84j1IoO86HgHo2EODol4VLPLxOt5MTFgZxu
 qNgIxoxC1CqSuQ8GlIz56Zz7DBRz0Bcmm4sw7bjQOUs4s7htOYLSLE9TF4l/eVUiB7rO
 SBeiuMyar7txMsLnVmSxjYNPfM/ewfn7acnPtQwWwZXyKm1NTt3w5s40zmbSdUsRK3Mk
 c02qBAfcabXtvYI3WiQ+2w5GzvcXfWqDgkmJsaoOgyTsH0NzcmnAl9wWKH9oOfGuyd/X
 F45E8PBbdbIIlHofEUQ43fdFCV2xCidnEW6A5a+qOAq/txCEMd76nfpY0uKNcDGHTDp2
 YWEQ==
X-Gm-Message-State: APjAAAVSSEbZ5PNV5zt+XYgYTdra5tOxwzpphNV2KoH66b82zeHO39lG
 9viBJDZbbHZ6gGHngT0aPUyeAo5NRRo=
X-Google-Smtp-Source: APXvYqysThFjDkfzq0Rqk3aJITJ8a6I83UvXa2dDb4gH3ZXKZp8PayvPz1KdObrk2VM2VejoS5zHVw==
X-Received: by 2002:a17:90a:8085:: with SMTP id
 c5mr14018255pjn.60.1571161899372; 
 Tue, 15 Oct 2019 10:51:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t68sm20867845pgt.61.2019.10.15.10.51.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 10:51:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] capstone: Add s390x skipdata callback
Date: Tue, 15 Oct 2019 10:51:33 -0700
Message-Id: <20191015175133.16598-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015175133.16598-1-richard.henderson@linaro.org>
References: <20191015175133.16598-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Capstone assumes any unknown instruction is 2 bytes.
Instead, use the ilen field in the first two bits of
the instruction to stay in sync with the insn stream.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/disas.c b/disas.c
index 51c71534a3..2a000cbeb0 100644
--- a/disas.c
+++ b/disas.c
@@ -178,6 +178,39 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
    to share this across calls and across host vs target disassembly.  */
 static __thread cs_insn *cap_insn;
 
+/*
+ * The capstone library always skips 2 bytes for S390X.
+ * This is less than ideal, since we can tell from the first two bits
+ * the size of the insn and thus stay in sync with the insn stream.
+ */
+static size_t CAPSTONE_API
+cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    size_t ilen;
+
+    /* See get_ilen() in target/s390x/internal.h.  */
+    switch (code[offset] >> 6) {
+    case 0:
+        ilen = 2;
+        break;
+    case 1:
+    case 2:
+        ilen = 4;
+        break;
+    default:
+        ilen = 6;
+        break;
+    }
+
+    return ilen;
+}
+
+static const cs_opt_skipdata cap_skipdata_s390x = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_s390x_cb
+};
+
 /* Initialize the Capstone library.  */
 /* ??? It would be nice to cache this.  We would need one handle for the
    host and one for the target.  For most targets we can reset specific
@@ -208,6 +241,10 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
 
     /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
+    if (info->cap_arch == CS_ARCH_SYSZ) {
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_s390x);
+    }
 
     /* Allocate temp space for cs_disasm_iter.  */
     if (cap_insn == NULL) {
-- 
2.17.1


