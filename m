Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA4CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0272067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aeto629q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0272067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7atL-0002WT-Qt
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqS-0005ZQ-F0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqP-0004j4-3a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id k18so7886483pfp.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JhhKAsR91SYfmxUttL/rCv3V8bKpI/rdJvfDRiicAew=;
 b=aeto629qAH9W9V/4m6Gj9DXyHxOxHJ6XVybs3YX0pvFD/0RFwq4YmXvrskOTkI/+pI
 OhnjJnyUQqrjS3fT1LIbShtoIFsrbUa9q14z6BlajE61uPAnzkXEOMELYmhWmr42j2aJ
 n3fCLTX2xjRh03jZFQ7O/iUI+mzeBwT40pm6RggfyGyaroqjh/dvutDcB3+oikcLzMcs
 /JBoQbV3bmnLLEWtevHjArbWfkq+3f1FMn+G4AUuvQn9SnBijySSuStanJX62fvmEZP/
 ySjfAN3nQafhqXV6szHWjxR5C/1Wl0xwayd6B0yVgi2lrfufmsCUYMadHzL2aDP+EU5A
 YYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JhhKAsR91SYfmxUttL/rCv3V8bKpI/rdJvfDRiicAew=;
 b=uBrj9YgX3774Q9bzconYzX4SQXo4OpP0YIbsr8+dgxafcrCX8kEcO3iO4w3iNIeSzd
 3nTkhp1JwzNU1DuCjoQtPgrMSBq9vXnaT3sBq/h4O4Hfsr7ewug+riDEMCR2V4xA8U/+
 17C2iQywVhRcXzj38aYQVAGQyoO4zih9i783rmZkfXcYCmBfMH6/gfFAkTFNk3ShfCsC
 EPudKY6z8xkBkEQYSXWKjRDBEu/ui/JPmwm9Nvmtscei4+NssoOQL8gbu7Qfqpi889Hl
 MF+sDMWoImNlT9g8LgRkyAkbyI6Dh7M3JCFJlhppAmYOb4NxWmqXaicH5IYZSldgQF1D
 ZyHA==
X-Gm-Message-State: AOAM531N6wbQcKYa5xgykyugTiBh8im8eyIvLsBoRsG6ukTmH0JSMF9f
 2iTWNRvKka9ZWtmrbB5uuQI9kypo9flvZg==
X-Google-Smtp-Source: ABdhPJyxTsM0goVhjrAiDTANd6karEZ+6LkGu9oUC84lIJ+JN3TzpyvjhS3Wl4J83U5JzAIWFc93jg==
X-Received: by 2002:a63:f24a:: with SMTP id d10mr9210363pgk.4.1597654215248;
 Mon, 17 Aug 2020 01:50:15 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 04/70] target/riscv: rvv-1.0: add sstatus VS field
Date: Mon, 17 Aug 2020 16:48:49 +0800
Message-Id: <20200817084955.28793-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a8b31208833..5b0be0bb888 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -422,6 +422,7 @@
 #define SSTATUS_UPIE        0x00000010
 #define SSTATUS_SPIE        0x00000020
 #define SSTATUS_SPP         0x00000100
+#define SSTATUS_VS          0x00000600
 #define SSTATUS_FS          0x00006000
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b0413f52d77..46c35266cb5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -365,7 +365,7 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
-    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD | SSTATUS_VS;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 static const target_ulong vsip_writable_mask = MIP_VSSIP;
-- 
2.17.1


