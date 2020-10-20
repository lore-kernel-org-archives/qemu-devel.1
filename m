Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AE02224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C672Cu3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE02224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuIQ-0003Jz-DK
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1J-0005YM-12
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1F-0003xU-7w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id c16so2516141wmd.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Fr3Yb3O1oESiwTEzLYt93gIX3QkvXqf7yJZArc/ujso=;
 b=C672Cu3JFdyt38RRTAdG4YSqIYL4ZdUytgUQr+z0NiL1qWcWBXh4fcvgKMD/XESBZx
 rV1SalTaexCWVKIjH7A8/nfTebIe1hB9TGOOYtFRvcDdWFpbQ6oF3ax35n0xt52Uzq+N
 CwPDdalXRITRgMBQyL5mJwcJYjSK6sioeWXNWI5yrc/pl+pjZm1FzQwPR/DHqojwOzrm
 tGnnNysZeTAGqjdn50z03NvPgPw81Xn5V7bUwvgDE0jQNuRcLQAeVUo+RH+cwIsPvY9j
 Z52TpieQqDdc1jm2cHgzvEWgouL5m3t8dcCU04UoSzG4xsfCGlJjfqiHgiMa45Vm2lWh
 HTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fr3Yb3O1oESiwTEzLYt93gIX3QkvXqf7yJZArc/ujso=;
 b=Ct5oZAd1sz1m4Z/0ysYnt4/OntGOe74FV8YmyeH/wyt4K8SaIOBPUOX0DUcrAcLcRH
 BDAmE4jIdpQeLKp54pohDEZuFUC9GoLTGZ3TvLWRJFtsjHLuNFdrdJNPxHDY9KSCzOrS
 iOQMcX/XyeUZatVS08VPxUg7XaQycf+1pu06GIawJCnVflzxYwAIX/tE3nZ1fE5m7y2v
 dd/EhetuVLYhuA5VE2lFzYIYcXPnejs8SWKj7mZjTMiVFKsxeIJmMjpwR+vG1SJ9QHwd
 4P4Oml5mhE/NGrCwzZVa3fAWILPB8kk+pFBw57tqeLRe0ay/Yxgg/Ez21GCdRjqF78JR
 hHrQ==
X-Gm-Message-State: AOAM531c4cLW2qO9W7ChxBfFmSSmqJU+XWEKPzjUbC3GJMZZanF0ceqq
 jBj93IAJ6nShddIl2HsGVe3nCcMciwf7IQ==
X-Google-Smtp-Source: ABdhPJx9Y/+3S9IXp3VApiriH0bz7TCD144/5m+WEaMlOQOt+1opNi7vuGrHXOVaGXsmEKe1iC0bbA==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr3769359wmc.137.1603209467023; 
 Tue, 20 Oct 2020 08:57:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] include/elf: Add defines related to GNU property notes
 for AArch64
Date: Tue, 20 Oct 2020 16:56:47 +0100
Message-Id: <20201020155656.8045-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

These are all of the defines required to parse
GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
Other missing defines related to other GNU program headers
and notes are elided for now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201016184207.786698-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/elf.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index c117a4d1ab0..10126ff809a 100644
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
2.20.1


