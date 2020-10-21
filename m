Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA6C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4518D2242F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVF+cvIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518D2242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIFO-0000dV-1d
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3v-0006ag-O2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3j-0006SG-2j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id w21so1894870pfc.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8JkogZW08o4QbERarC4qat0jsqD9fmDjl7gKGBrUP6I=;
 b=QVF+cvIroLqGiN9P3Rzgp+eJI2A9EIDSWnv3RfHAjTc4yJM3bxsOYh495xGk3obymW
 fNjZY1Q3i82aEAdYMB3XoKZ81M+b3nG0DWKjDuZWHBKl9cBXer65XTvaYysfHUk1gKrI
 Cpi6eh8Dluo6ifbDOgALx4T0tndGXReXDmg1LFStgPKF/nOPk9tEq4stxFCU1tMwi543
 fz9CAwhA2xKxZY2A4KSw9kz0AAklfuwU65aPxbSkHQsHq/OIvPpO/lWabFKsYy65fDAb
 OuCcK/h4Hu2TuDfFYEiVlG+RbU3hLkB28dUVSc+OvvIj/fO2fPOyOt+m+m8NomTeD9+u
 UrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8JkogZW08o4QbERarC4qat0jsqD9fmDjl7gKGBrUP6I=;
 b=ihCrpJV0/YW60WyzVsZh5YIkPV2WoBtEBNkseWBdasNYZrpUQAvhrv6hVMyLxOTvSl
 N8efgnJaHAl8uqArBILstWe0zYdR+oPvc9Pvq3aQpIR8vRc0fnm7t380h9tbNN37GtS9
 rlfvCvXUh+bOxCROB6UUkpRENYXDNx+LOoZMdPNjFzRSn7zv8czbD9VP8UgNB4la2hcy
 H4vEb/KQcsrWcGE10Zo8U5CQkK4kfAiYugNs8xw3w2pz9xK+03D6oxVx1T+6drtxlSP1
 GwI9ZwNwEV+Fid0vuFEqP0nctkF1z+nF+S1jTchHmTlYcbg0XjC1BIYQB6iLQL2Oe6CC
 JjPw==
X-Gm-Message-State: AOAM530JOlRgBmlsIoedkRL5FDC3mOG80i5hsRIV+BnfznMmDgrHNvRe
 FPfi5B2jc8hxv0+NLw6J1j+edadsn1vyrQ==
X-Google-Smtp-Source: ABdhPJx/r3Y5JlOh5tTp8gtlWwg+gczMHl2CKK9Xgebaly+QddDTsI6nn31km79uftlAfPAECOKVRw==
X-Received: by 2002:a62:2905:0:b029:15b:57ef:3356 with SMTP id
 p5-20020a6229050000b029015b57ef3356mr4615207pfp.36.1603301875708; 
 Wed, 21 Oct 2020 10:37:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:37:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 03/12] include/elf: Add defines related to GNU property
 notes for AArch64
Date: Wed, 21 Oct 2020 10:37:40 -0700
Message-Id: <20201021173749.111103-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are all of the defines required to parse
GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
Other missing defines related to other GNU program headers
and notes are elided for now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/elf.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index c117a4d1ab..10126ff809 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -26,9 +26,13 @@ typedef int64_t  Elf64_Sxword;
 #define PT_NOTE    4
 #define PT_SHLIB   5
 #define PT_PHDR    6
+#define PT_LOOS    0x60000000
+#define PT_HIOS    0x6fffffff
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 
+#define PT_GNU_PROPERTY   (PT_LOOS + 0x474e553)
+
 #define PT_MIPS_REGINFO   0x70000000
 #define PT_MIPS_RTPROC    0x70000001
 #define PT_MIPS_OPTIONS   0x70000002
@@ -1657,6 +1661,24 @@ typedef struct elf64_shdr {
 #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
 #define NT_ARM_SVE      0x405           /* ARM Scalable Vector Extension regs */
 
+/* Defined note types for GNU systems.  */
+
+#define NT_GNU_PROPERTY_TYPE_0  5       /* Program property */
+
+/* Values used in GNU .note.gnu.property notes (NT_GNU_PROPERTY_TYPE_0).  */
+
+#define GNU_PROPERTY_STACK_SIZE                 1
+#define GNU_PROPERTY_NO_COPY_ON_PROTECTED       2
+
+#define GNU_PROPERTY_LOPROC                     0xc0000000
+#define GNU_PROPERTY_HIPROC                     0xdfffffff
+#define GNU_PROPERTY_LOUSER                     0xe0000000
+#define GNU_PROPERTY_HIUSER                     0xffffffff
+
+#define GNU_PROPERTY_AARCH64_FEATURE_1_AND      0xc0000000
+#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI      (1u << 0)
+#define GNU_PROPERTY_AARCH64_FEATURE_1_PAC      (1u << 1)
+
 /*
  * Physical entry point into the kernel.
  *
-- 
2.25.1


