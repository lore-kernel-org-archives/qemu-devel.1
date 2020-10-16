Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7865AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E684820EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYxAmiXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E684820EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUma-0006Lx-Fq
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgS-0000VL-1D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgC-00026L-TU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:29 -0400
Received: by mail-pf1-x442.google.com with SMTP id e7so1974553pfn.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8JkogZW08o4QbERarC4qat0jsqD9fmDjl7gKGBrUP6I=;
 b=pYxAmiXsf+Pkx1zPHtkgQ26+gslMTryFI8G/wZfTj1+dfUuDy226R4InFWRwX41VFr
 qxVN5dnY9q1VyMYdQUdvBFXNa61vjefdGUfsXW3kDRNUTroXLjF1J6+Uz9ERKKa54/OU
 NCP8OCHvxUGbaCVvaqBtZiBOHosXeagmAUzbHlG2vIucJL59bb+w11+MNgTmObqeswiH
 dzyyiOPXavsDxL5MXILiuUtQnYAK5FsrWg/5CwmckUPZ3M5dLrJ/TecdOSlBZdnSelp8
 6c5NkJ6il+IBr0CNEsldRsDuElb/w4itX7tj7u0xB3Zf1RRKokiXxVNOQACIIfx04Ly6
 Tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8JkogZW08o4QbERarC4qat0jsqD9fmDjl7gKGBrUP6I=;
 b=F8p1cIbkpBloOcO5L/oo3nWWzXHQ/tZawOQHY8QO+ylLJhJT1DdAg6or4QIGs25cQO
 kOwHm28ygwNzqmcUcI+S5Ktk3KNymVbX90EEQsfK6ffuQ5qUefClKZ5f72MoMh3ldzZJ
 lzXgQWCv4PRwpXvWxDpzhn4Z+bLtE/h3ubksjgogTqMbCcCrJh+vZdjtSjlpRe4ehitf
 utKtfueS80k2v5VzlFkPGRg2lb4lCMZiyQGJDRzos8u74Gi9a+K0J8+WggqZ3K4xf07X
 JsYulWwlg1jOIHIBX8uB1eDLSWz78gBf2T0CjZMboGoZvMQ8BT5vpjZZc08n/sduBf2K
 BsVg==
X-Gm-Message-State: AOAM532vvfXgdYKVL8hZn29V7zIPZvFtV1mqSNQPTAwQL4DeuCD+CoQI
 OT9+njtS4Oem100TUfqWioh1BdZUisw2Xw==
X-Google-Smtp-Source: ABdhPJwR5ETWzvZxN7kI3cwIm0wEq/IbQRHhQJbtb2EWfqMipSqa6orfExXnKpIzBmcVlNSemWa87Q==
X-Received: by 2002:a62:16ce:0:b029:155:2e1d:9c06 with SMTP id
 197-20020a6216ce0000b02901552e1d9c06mr5016448pfw.6.1602873734883; 
 Fri, 16 Oct 2020 11:42:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 03/12] include/elf: Add defines related to GNU property
 notes for AArch64
Date: Fri, 16 Oct 2020 11:41:58 -0700
Message-Id: <20201016184207.786698-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
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


