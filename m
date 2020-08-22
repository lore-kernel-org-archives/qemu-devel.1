Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E83A2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IM4DcbIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E83A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MSF-0003OI-F9
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQz-0001gx-QH
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQx-0000D0-Dd
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075479; x=1629611479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tfWFqJrLLp6C99unGM7CbZlimOiv1wfjzla0dCVOMts=;
 b=IM4DcbIRhYu8z5v0Efc9ONLGOWjbRrIYgcVlll/WsNmFQDGRG1PIbTUp
 KTfInNce03NMH6A1VzC5faSAN7+kSmxjyBzIJl6jCn6eiFbYbaRWcfTRZ
 +ylRRKvbCfB8m288V3oXVe8D9jFI/1frGSvYOgCZ1QgruLLldzPbjNfng
 S0R48nZ/GEdfG6fsYsFVeXtwQKwBFMtGNF6aGVboTQlIzoSWHkcAIfjR8
 88W44+4qBn70w9glpMdP2oPjbmFUizYDybYTa0fyEd97n4DKa6CKUlDVL
 M8ZprWngAWT8ntTuviSq4RdAerJ/qJbgn4NmkZfQzMOXf1TULGPAuGfz9 w==;
IronPort-SDR: zmAjV72mhze8Wx2duckXHyooggva4Dq5AjhglnqEIlnX88F4rLfFs3zyF02tDkIsLe6nGfBsEM
 ZKnZwAUYy0QwJCyQzyQflpxXJxDMJMMKDOyLiAlHq4RlW91t4vtgk7fKWBHKOwCDH5BYLjuReC
 Rjn9GhZEYdhE42XvDQf/e4L1qXLZTPq3BalLIW/ZvT1uYsxWh/uMZz3TUwZSOptWas8whkyDel
 kVH7JLjCryLL9DVR9jewMZvQstoyCdGcq9DlbiCfaV//kr7dKUNtnnU2fvmY7WF08soCaDTcmz
 DRI=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571952"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:17 +0800
IronPort-SDR: AtYemhvaVSERlmmINXr2ChaGG2Y5u443iQcEKXkoRa+S9jV9CiDu4COd8Cdrvr/PXEKOIqOqat
 PZzhVlar+sOA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:57 -0700
IronPort-SDR: lRA6W0ftKK0qzQETO7ldNsI5Hjr930OCaj7HnFrRMB+vrdVzlMXnINNrjjrV/Z/BGB5CFMyOdn
 cReD2wOFSm+w==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/20] target/riscv: Clean up fmv.w.x
Date: Fri, 21 Aug 2020 22:40:47 -0700
Message-Id: <20200822054101.1202175-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 alistair.francis@wdc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Use tcg_gen_extu_tl_i64 to avoid the ifdef.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200626205917.4545-7-zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200724002807.441147-7-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvf.c.inc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 832f01db6f..138e317723 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -406,11 +406,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
 
-#if defined(TARGET_RISCV64)
-    tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
-#else
-    tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
-#endif
+    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
     gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     mark_fs_dirty(ctx);
-- 
2.28.0


