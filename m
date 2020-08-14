Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA01207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JA71S2Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA01207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bYA-00012h-Cc
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQT-0003gx-K5
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQR-0007eB-LP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418124; x=1628954124;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doNpaViVbQXhUPoI0l7z7b/wPhI0669bus90ugj418U=;
 b=JA71S2Sfg5XSrMF8Zx36TQHoSe9ewdxGr1D72d4U0NXl6ULiaVTR06PM
 tHIngkRumKk2g03Coa9AK2GD5EHF0tC9a56CktFTbPka8BDQaP84yVAXo
 B1yNMuhnoRQyTzjLMYc7MzojY7v77GuAHAd32K+5bkqRHsIcGTF7Uyxa8
 QSA/7oAJTWmUQ092o1cHacwvXCzXEZ9sUUDK9FlNnP8WQmFi49HNDki9t
 HCWLHu/3U1Cu/20saB9Wo+r05A0EJwZbRCWUrfUjD8+6HCSMnCWRH18PC
 L/whG3eBxm+awhTr09nhdy4YEvBIQirkHAgh3HSkSljcy6OhlnvMmWWR/ g==;
IronPort-SDR: cN3Jn3erD4LUeszbHIRl/RPvhbXpliNEXdCAdW6GES4IewBvi4d/OKjzrjJarnEBnP/cw3P6Iz
 WlqdtjB2RUt44yU4FqnaT2OpbeR8333/m4A6wOcFVDr/bviIxAz+5r1GNwQizuUumxefSWYYBh
 pa9ZLSRvSfZ8bLhnELBU3c21rimI5uvpNYaBYes6hp1bvwyRvyuflqfLezadqsOLeI0HPbTtTX
 KFjZZG/YEduwj5ApXczP7ONDLwS9/BviZPRIS3LGKM+QDLcHcUVXXlIiua16Aw4FX0oRhDmjh/
 nkY=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994823"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:13 +0800
IronPort-SDR: x0bY89ktMYhivImDWNsdhJwQq6pMlvnnoagng6o/CDRRsKoqz21AEeHVXsatGO9TwMuTNtKVhW
 gTPUnmI3Cbwg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:17 -0700
IronPort-SDR: 1zbXZZS3IsS8qcF72iAlHV1x59O3dNpROH1oEELAPK5GpdFqXBDVFRtpSQBF4GxfJJ5azFKaUa
 JoSaqcsfufMw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/20] target/riscv: Clean up fmv.w.x
Date: Fri, 14 Aug 2020 08:04:52 -0700
Message-Id: <20200814150506.2070566-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
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
 target/riscv/insn_trans/trans_rvf.inc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 832f01db6f..138e317723 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
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
2.27.0


