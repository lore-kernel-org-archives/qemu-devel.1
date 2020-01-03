Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10065C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE80721835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2V1EPSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE80721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUSh-000705-MO
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inURY-0005dZ-Ne
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inURX-0004Vi-Im
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:16 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inURX-0004Sm-Ce
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:15 -0500
Received: by mail-pj1-x1044.google.com with SMTP id r67so5038701pjb.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ezOCrOe9hJhnEdtaNkFzyuT77XDmRMIs13qAk5OKeOQ=;
 b=l2V1EPSqXv8APxdZ3nsWqQml9JGluP+SiH2zOM6zEiWfAlQ2O6/UQ6jvFiN8nayImp
 LfjbnX3sCxCQGsoKugCwrQsOeJ05av76/Nr8Wu7CBo6AWLjCCwTbthKumTQyDaAUBQZc
 AZ5qwktC4KVdWKTfuhdQnAI4zv3GoCROh1QORYhqn/SjefoKVzq83krQgGY9DVlNBnVx
 48yR3Io2W72cOI9/JuVJYfzYNDl/L71MXAt5L2I/aoG5Nj5ubxPjn38yNucoj3iUQjDi
 NKzuUUch/ZMaJu0SMMZAe8B5hSVkVkxWPXWFa8IZUysUAlYDSvaEDA5Aqlcesegs87Lz
 rz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ezOCrOe9hJhnEdtaNkFzyuT77XDmRMIs13qAk5OKeOQ=;
 b=kom4pjGznRB7OqbLu79CqV9SN4ilW6ncpTSSakHecRlyOnTPStR3Xit/2Gjb4EjriC
 gCP1ednGvXgRJ0PrfhbFHXlC/nMbiSVNMu8J/pzF6M3NvN/WUWqVLDK13fpUpLMrr4gH
 ySAzrDFkiOIj2cJMKDKHaygaikpWvB3/v2annfCKYPspPTWvNO5aXdyhHg8WN0KQmVuN
 gW0mTTQzZ+alkOP/bY0bsODKBnPKHlO1xYs3C1rcUi2kS5jxpm5csAxQZtodZqWt0ylU
 eiBDVlruym2Ep7TBSZQb8ufWd3noe3imqqsDDq2o5Lu7awDEYCRCns+Bf3OZF8oZ8dYf
 PyiA==
X-Gm-Message-State: APjAAAW9EZHjdpQ2C2ZfNs9BPvP4nsHaY/pKtw1yycSScP3ebe4RqTQl
 GAE68upv+j/HRMUBVB7jpbqY/dtJdIW0yA==
X-Google-Smtp-Source: APXvYqxl0zi2oyNOAOnqzMwOF+5nqfWRrcGO+05ER8+ZcCqtUqbpw9BOM1+4YRUA2J/fsz6dvK+F3g==
X-Received: by 2002:a17:902:9a8d:: with SMTP id
 w13mr72737703plp.40.1578086714024; 
 Fri, 03 Jan 2020 13:25:14 -0800 (PST)
Received: from localhost.localdomain
 (59-100-211-22.bri.static-ipl.aapt.com.au. [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c15sm16668907pja.30.2020.01.03.13.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 13:25:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] capstone: Add skipdata hook for s390x
Date: Sat,  4 Jan 2020 07:25:00 +1000
Message-Id: <20200103212500.14384-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103212500.14384-1-richard.henderson@linaro.org>
References: <20200103212500.14384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Capstone assumes any s390x unknown instruction is 2 bytes.
Instead, use the ilen field in the first two bits of
the instruction to stay in sync with the insn stream.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/disas.c b/disas.c
index 845c40fca8..1095bad049 100644
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
2.20.1


