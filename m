Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B06C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B94E23A75
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEsdAbto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B94E23A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yAr-0008D3-Uh
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y9U-0006no-BO
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:31:24 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y9S-0004ZJ-MG
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:31:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id 74so5961550pfx.13
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xaxzc+r6r88xLIgQLZ64izxJ1KoUU6V1OBDgcD8ihqc=;
 b=XEsdAbto4EBxr+22K8//q6bDOn7/suDGUrZHLQavsIhHq4G3hWDuk7d7i6aVTdj//B
 D/RKGQPoWruq5suvFHVDCQAmvF54ajyNaGMieNJBnTjvDJsz2DOztGLzm8d+7NviYD12
 ZPcjumymMdhxrUmwdFo44S1ainKU4836d9g2UVFSgdtwEGZFLzFlOJTkPtw/NbMvqSmq
 YbecZdLm/QJe7ESrbaaO+Ox0U/5hEkxMY4ZIEJ7D1KmyPJYTYYB4suHPuozPlA/p0Gun
 otgDNTYpmvWRJv5cw5COmFqdLCboyNibCTlNIGDfmJXAS1Buj7eEeZTsFpbKv2jyiuFg
 SB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xaxzc+r6r88xLIgQLZ64izxJ1KoUU6V1OBDgcD8ihqc=;
 b=QmNPogqGqARlP8m54AIVQbhXorGFgAejtUjupNtxDwkVq0tdkvQiAbxOSph717uCEZ
 nKU10xEFY6PJq9bhaPWCR9BGBdYr8SBGAiLfdBoRgUQuM21k40e2kw6CUqRDBkqI9k2v
 G7CRzt2cx5GrjkP+kG7/R0JCwJTs2Y1q5MPRQQ74H4C60bGw5PKR/Sx4LxDcTE/VUAJ2
 eF8uALZOn/vU2uf3xhSpK3zYoEpg2i7vh4bSJmIqbxc3g+3Qvgewdy9fIAVjf5fs2Db1
 OVmRv82pcRcY+vkyRa7trfUqLcdEY6eBQ0Y077tl7pqyaAmHUOeidchK/rCYQ9B7IwPZ
 iFlw==
X-Gm-Message-State: AOAM5324+/3mSKYM6/DzqQ24QtnQV5JfLg/XlzcecHuORRVYCwn8PG9Y
 l2/M/jHRW/DMZDZDRsNyb3nbB5qDNtAaXA==
X-Google-Smtp-Source: ABdhPJzwy9zWZ9Wp/nNapuoYwq/d0IcrPRxYRmuKEipi7b5tVoBgzxmr9NRIlAEHpKUCC7npTgzeLg==
X-Received: by 2002:a63:4e56:: with SMTP id o22mr3256361pgl.381.1597455125698; 
 Fri, 14 Aug 2020 18:32:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/20] target/arm: Tidy SVE tszimm shift formats
Date: Fri, 14 Aug 2020 18:31:38 -0700
Message-Id: <20200815013145.539409-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

Rather than require the user to fill in the immediate (shl or shr),
create full formats that include the immediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4f580a25e7..6425396ac1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -150,13 +150,17 @@
 @rd_rn_i6       ........ ... rn:5 ..... imm:s6 rd:5             &rri
 
 # Two register operand, one immediate operand, with predicate,
-# element size encoded as TSZHL.  User must fill in imm.
-@rdn_pg_tszimm  ........ .. ... ... ... pg:3 ..... rd:5 \
-                &rpri_esz rn=%reg_movprfx esz=%tszimm_esz
+# element size encoded as TSZHL.
+@rdn_pg_tszimm_shl  ........ .. ... ... ... pg:3 ..... rd:5 \
+                    &rpri_esz rn=%reg_movprfx esz=%tszimm_esz imm=%tszimm_shl
+@rdn_pg_tszimm_shr  ........ .. ... ... ... pg:3 ..... rd:5 \
+                    &rpri_esz rn=%reg_movprfx esz=%tszimm_esz imm=%tszimm_shr
 
 # Similarly without predicate.
-@rd_rn_tszimm   ........ .. ... ... ...... rn:5 rd:5 \
-                &rri_esz esz=%tszimm16_esz
+@rd_rn_tszimm_shl   ........ .. ... ... ...... rn:5 rd:5 \
+                    &rri_esz esz=%tszimm16_esz imm=%tszimm16_shl
+@rd_rn_tszimm_shr   ........ .. ... ... ...... rn:5 rd:5 \
+                    &rri_esz esz=%tszimm16_esz imm=%tszimm16_shr
 
 # Two register operand, one immediate operand, with 4-bit predicate.
 # User must fill in imm.
@@ -289,14 +293,10 @@ UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
 ### SVE Shift by Immediate - Predicated Group
 
 # SVE bitwise shift by immediate (predicated)
-ASR_zpzi        00000100 .. 000 000 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
-LSR_zpzi        00000100 .. 000 001 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
-LSL_zpzi        00000100 .. 000 011 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shl
-ASRD            00000100 .. 000 100 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
+ASR_zpzi        00000100 .. 000 000 100 ... .. ... .....  @rdn_pg_tszimm_shr
+LSR_zpzi        00000100 .. 000 001 100 ... .. ... .....  @rdn_pg_tszimm_shr
+LSL_zpzi        00000100 .. 000 011 100 ... .. ... .....  @rdn_pg_tszimm_shl
+ASRD            00000100 .. 000 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
 
 # SVE bitwise shift by vector (predicated)
 ASR_zpzz        00000100 .. 010 000 100 ... ..... .....   @rdn_pg_rm
@@ -400,12 +400,9 @@ RDVL            00000100 101 11111 01010 imm:s6 rd:5
 ### SVE Bitwise Shift - Unpredicated Group
 
 # SVE bitwise shift by immediate (unpredicated)
-ASR_zzi         00000100 .. 1 ..... 1001 00 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shr
-LSR_zzi         00000100 .. 1 ..... 1001 01 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shr
-LSL_zzi         00000100 .. 1 ..... 1001 11 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shl
+ASR_zzi         00000100 .. 1 ..... 1001 00 ..... .....  @rd_rn_tszimm_shr
+LSR_zzi         00000100 .. 1 ..... 1001 01 ..... .....  @rd_rn_tszimm_shr
+LSL_zzi         00000100 .. 1 ..... 1001 11 ..... .....  @rd_rn_tszimm_shl
 
 # SVE bitwise shift by wide elements (unpredicated)
 # Note esz != 3
-- 
2.25.1


