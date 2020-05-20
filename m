Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6610C206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTlYbEmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6610C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSXn-00062N-J9
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVl-0001mP-Ts
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:09 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVj-0004JP-Vz
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:09 -0400
Received: by mail-pj1-x1042.google.com with SMTP id z15so195646pjb.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfOqd0W163btym5ANgJ/IhyJiwPH1qS8Yj0O7sKwHiQ=;
 b=LTlYbEmG0y9w9EEj+w6hceCghY+eIDoYDGfg/JlUnckhcOWWR4vb//edfXBLsAX4H6
 MbWFzGQ1tK6iH7pLANWBKicrx4+sGRToe6CcND+eAt//xL5pC3Yim6blMXn8nEhdI1sb
 QAhiM29FPK80xRqpS9U8vIlWAzDBLdpw3IWpiCgEujQVDIKSLt5m16lNZIgOO/6EfFh+
 iLEn/UuTIEDUdmlnwu9CndSRXkNmQ2PLiCv3XtrzpR24uG7HncBq2KCF3xxRrhDGHCUa
 QXXqUTTcDfjNzu25N/hnWyrrVS2D7JH0CrpT7ryM0uYRpY46Se/8u10tTZbfdviG+UKX
 CSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfOqd0W163btym5ANgJ/IhyJiwPH1qS8Yj0O7sKwHiQ=;
 b=pvd0SJNF0429hChATFj9UKwngfBX7DYRGKTwGdWG2yS7OLXS18TDdy6mm/nrbqOVXR
 ge7bf6E7r/SOhhi8bez8bJ51shRro7qPqOSXfkeLlm7LC6C8DKFFRVBeWgnNCrepDqVw
 pB/3nSu9HBaGjX/6gtWUXinHHJvdIxeVxH80nNIp+1zeRu3ALTkp0kJ1TWyVTm6JIEL3
 FeFWuuAvYF9PouKA9YmJxAw1FCMfxrFBCyfOytJrAe4cJESRRnZDKW1YfEx0Qs84lVtJ
 au0WVaFIMpWvU3yR7vdgP+lzTpKnwZnEuFYP5v3vVuMAHXeX6X846gm9MFB3bKgqFRR6
 GZ1g==
X-Gm-Message-State: AOAM531jusEIeUG5HqFh0hFjHFXjrvqL7iJz+mZJhHpJSowUFV4mRijh
 QVta6GjC10FwpM9jqo4sj20QRxR25+Q=
X-Google-Smtp-Source: ABdhPJxNqcIV0IUnioOdJpCgaG42lEsXeURUrgWovlLMMLcYh4tyeOlopLH2WF3LXDPiYdTdM3T5+A==
X-Received: by 2002:a17:90a:6e4f:: with SMTP id
 s15mr3459723pjm.194.1589995686158; 
 Wed, 20 May 2020 10:28:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k18sm2643672pfg.217.2020.05.20.10.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:28:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 3/5] include/elf: Add defines related to GNU property notes
 for AArch64
Date: Wed, 20 May 2020 10:27:58 -0700
Message-Id: <20200520172800.8499-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520172800.8499-1-richard.henderson@linaro.org>
References: <20200520172800.8499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
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
index 8fbfe60e09..9db4aae40c 100644
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
@@ -1652,6 +1656,24 @@ typedef struct elf64_shdr {
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
2.20.1


