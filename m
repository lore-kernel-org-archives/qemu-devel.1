Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766E722DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVA35vd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766E722DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BSx-0007b6-5A
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLx-0000HU-3x
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLv-000063-Jw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLr-0008Rd-2G
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id w2so4120434pfi.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BCJyROCPXXds3VscyTQOsfgCkthhXaXdTk16P2hR/Vo=;
 b=nVA35vd2h5vDvoHeJUg6C0bzkg9xx5apXeaTCcUv4dEgn4Mv8V/Nv2Ash21AaDYtyb
 Rd762GqBbfbX5QVFI3nl5GbrrXCIbwiLzOztLAtU3dBDdsi51Xsui02Ny1C93avNZi50
 c8JzQVqdhxoRXRaMynxID9Vaj2MOUnKngKX86eZppIOqkDPlJ40OxjtTHaxofTuzfY2J
 t7MFqu5BWAiH+O/kV1HMSIh2A3NuproLtIXAYiR1xciBjskgQejeSuCBi2YZPV1ZNEF3
 AaVaXGu32mLLWRH+VEcdgYJYyemy7U7RRO1a1Bh2A9zltB6X+abnncIfP+Qa7SHuy/4e
 xh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BCJyROCPXXds3VscyTQOsfgCkthhXaXdTk16P2hR/Vo=;
 b=SVyftuuuLSmXX7i7dg8Iv/YxHZXmVkbMCJWfZJAS822QYb5yrN6VmBDQSyzFA+BhBp
 PYvehNnXpUVs4WPjfcz5Wj5h3nB7tnnbAeCFXKI8yCW+hsz8Anjsok10qwoxkbK+g9yD
 7PP61K9H+KcInjQhpQ47NnzrEGcV6ZAn+3YmXD08yzvOoiFiHgGqE2QfaecJJ04SnOeS
 +3hHuo7w5s3B/3v3Mxsle2j24kdreBw6nbMO7XvmVxbkhObWyXHF+fooknuwcn1pfyMD
 2CVPOKO7n8LOo74Wkh0Co4NsBEUknEps6tLdMRz1FumGKELv4BjWMdT/1bfFXtSQPkE6
 iXQw==
X-Gm-Message-State: APjAAAUdGF5E2CMXREBV0UOTnGgelVTveSXE8OMeGzsEIpAbg1j/9OP8
 7dS+hAQpplsKGRZAZz74cC9Kmtt2XBk=
X-Google-Smtp-Source: APXvYqzCMLOwD/2KRtDJG1B9MPXE7UP5NFFBZ+6nHTapS8FiZ8VE13GXYngLzht5yVbxvtm2BsxI/g==
X-Received: by 2002:a17:90a:234e:: with SMTP id
 f72mr1885339pje.121.1566335252070; 
 Tue, 20 Aug 2019 14:07:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:10 -0700
Message-Id: <20190820210720.18976-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 07/17] target/arm: Split out
 rebuild_hflags_a32
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a trivial wrapper for rebuild_hflags_common_32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 570f2dcc98..0fea62dc12 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11068,6 +11068,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11180,7 +11186,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.17.1


