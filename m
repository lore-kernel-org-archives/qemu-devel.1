Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BC221835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I15T6urR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BC221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv98P-0001hU-5f
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91t-0005xO-KS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91r-0008Oh-Je
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687359; x=1626223359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RbtKPfPz33BnhoAafUzygBFbZBU/Z3EInIUbb3BvNO4=;
 b=I15T6urRtExIFJMpRUypMbR6Uod1C8jJGYReD1KgrAjKg+n/udwrCf/D
 j/HpJO8VsoDfLj+3rtuqBzieZLAiRGwpw8yrvDldOq9ezswlB8sYOm+lo
 UFSV6axB/TZWyrK9waTPshwkju2/kqOh3Hau4uRXMTKMcIWvzxuQ853x8
 08IfO5tVTjpZCyXApS6sDvTzVmPisdizoHhqlAtMszskLXdAEfnjyapEW
 lqHfWa773WJO516sBbvDm3vqOwgAUbHfDcrq6o+yYmusUDa+TK95WzDdE
 2U4+fBvYAPbqiqrXZ/AcJPRVZL/vxHrXPszv8vlfxJcEp3lzobkgSaPiB Q==;
IronPort-SDR: KOS8ZmMMTsdmgWWKIJ3CrrtCl3sS6/i9DIPVv01qqOli/GcFcSC1FkctvMf5e3MbiadYKtm61o
 vy5lFnGL+5eTGScinxUhRpNF8/XunQ4ZQ/DGDJBf83SBXjYJjdvk2YxZGbJGg3++wfyfznGU8H
 HAl42VaJeNquLUooMnmaQXl3ERqLa7CornAChAANGhpHxZbJ5F/zqyZB9dAsUSzlmanpzkw6gV
 AevvitKiXuUBkfwqJRkLATTArn79m042eCElU4oZEiGVA50APxAHxYIy2Ai2d/gnq5jup96Hmv
 YtU=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511929"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:29 +0800
IronPort-SDR: 7p5pyhW7njbYB0+VZ0AxTwou/zeLUnrrc60eHtu5c1Y6tu69Y1LEhOZvea4rj87wFKOzIpJD1L
 IQ1ilGcTOEqdQyNhRT+66f1ZLCmyY2Fog=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:58 -0700
IronPort-SDR: LEi87EMqB3Jl30g1sdSe+FAaMkpGIGn1xKbet98rpokX2vR+ioKoJWqhKDaM2r3eIb/SzkXIJa
 VKXlrPCyHAiA==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] target/riscv: correct the gvec IR called in
 gen_vec_rsub16_i64()
Date: Mon, 13 Jul 2020 17:32:48 -0700
Message-Id: <20200714003254.4044149-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200710104920.13550-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 433cdacbe1..7cd08f0868 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -937,7 +937,7 @@ static void gen_vec_rsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_vec_rsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_vec_sub8_i64(d, b, a);
+    tcg_gen_vec_sub16_i64(d, b, a);
 }
 
 static void gen_rsub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-- 
2.27.0


