Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEAF22D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F9MMox5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEAF22D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dZo-00006e-QM
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQp-0000mX-7P
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:35183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQn-0007gm-D3
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id d188so18658949pfd.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JhhKAsR91SYfmxUttL/rCv3V8bKpI/rdJvfDRiicAew=;
 b=F9MMox5BjdqLkXHhf6LblJ+dQWaKwh9hyv1K9sENj7GuOEZfngB7wHtCKeVMGxNuxi
 0OpjKIy4CvhziiUYr4yXRS4kr/F0goOXpQlVA84NxC1okaUDC0RpqKTAHiSwCIH9yRMY
 BVa++V2DQ8BjX2D3ZFSiqTFZaEC6olNb/HCCl/krOd1wr0cba4LC/T//THuR8KAqBzHk
 PFHit3tfgM9iHAtV86WVhWk/DY35A4V2686oW/sfdiIJbZzAwIjmENqpXX90qYjDL+8B
 UJXmgPA6wbPNcKAEmwCTh/REITYOiHggbI7o2zAnl1LiZe1YDTj3BeA6NxkyR49H+iES
 n4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JhhKAsR91SYfmxUttL/rCv3V8bKpI/rdJvfDRiicAew=;
 b=ARhItLGSn536GgtWZrIvDHPBhRoZkepsPD4TqqV/b9G+Y5RQHc31tuzqG9eXhINvM0
 nR5qpftL+09axYrMOmdff3oplUIDf9f1pT4dEmC/fO/vuXBCVH9hoJ16zjkr2vcv/4e8
 Xu8Ji+GyP0FKrHLPmpZW+OfXoRJwJNXyx/c3ALRv+yKNPdxQkofCFm7PQX34pFqlXcu5
 AgOanu4iuIBWi2qIw0ZwB7ziMplGkzu3qXRdJ/uX9OlBPeFNoGyvVBaL0bGZImpT/Ymz
 oltuCOVDMOYfomIi4bieO7L2hTcaZ0gaYKM41d1Ml0TTsYlKnQDfa2qbYSu5Zn6rwWnt
 3zkQ==
X-Gm-Message-State: AOAM532kAi0/VybtPaajDj/3z+wNcfw1OHZS2imN0QlQddDjvogJqlSh
 TlN2q/AsX8TmlmHdvzfqSy69Pf3TXBo=
X-Google-Smtp-Source: ABdhPJwtW8vbQ8rGZJt/CxrFGqK0AicXcYprsdy7n4uUw/71EmyxSwZcYrIqA2i7/wQsNQxxDum0DA==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr6575182pgp.452.1596710847850; 
 Thu, 06 Aug 2020 03:47:27 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:27 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 04/71] target/riscv: rvv-1.0: add sstatus VS field
Date: Thu,  6 Aug 2020 18:46:01 +0800
Message-Id: <20200806104709.13235-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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


