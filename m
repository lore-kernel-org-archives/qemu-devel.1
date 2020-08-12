Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18675C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D796D20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F/ccqATw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D796D20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zTf-0007No-UR
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0002GK-7j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQQ-0005m7-Np
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272050; x=1628808050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uOT7bF66BUjn23EePzsUiUnjjzNFLMEUpDfYHK1C+rg=;
 b=F/ccqATwhWJEyQ/wg5BFY9FHc0SmxLNC1Shd+4Om5INZALXpMezjdjmo
 fJ7cbQI2sxPFIUF0vvS6+GnfhbCAX2UATO0YppjwzOb7C86iR6Fs9Fbhw
 GEPfy9YvOmuJ0nCLLYZVtbnH3riZIAnBzml+bcobhM5DFG2wAiyBHDYMw
 TqtKNuLOzFD5jSEusbMWlrfzMrJDeTdBu4nWLrTEZADw4Gzj7vMftOarK
 gtN3C9H/XryOv8a8kausdI8jmNDB106g4kXk7mFbNebjyvzSTuvBoUCwt
 9OQ+Au8vFh7Kk9RqGoEK0oXLRzA5B2/bh+f2vT2PLNNWwopm8JiEo1MLe Q==;
IronPort-SDR: hgYeQVsk4jfohyigAs01ncZjYdW9fmRYMKJZdHlHLV8p2hKJC0QO6CKcofVCbcBVNPEIY2ZbO3
 imKtOUz+sI0Vt815RQ/mFaR4Q0iOaTNSp7ess/Pn0+kQqtm2mOj8ANJE+Icbd9tp5lu+iOayBM
 zuNFyl6dZRyKEYtPtdMPJMHkzbIQxI2jiq4kMvBZwIfXa3sDqAVwypezp4wZPojhD/sY2+mchx
 jCamXZrhOnLhosQdnfS3FAruemsagC7wpg3EKndhnYN18AUBxE3Zi5VZpaxBh9a3Z/4vsHmJ7O
 610=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="254208922"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:47 +0800
IronPort-SDR: w+ELM2D+PDdDKIKRqp3ykx1b/zlqY5p0WceomGbPD3YWrAOIoF8pwreN4pIgZK/QQxIUhGekIv
 9Tu+0hHXXzWA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:27:56 -0700
IronPort-SDR: kewG0wE1NH5JgO6m9hrcMUvTeb2A3JK6NgnAIBB4dKf83y4fG4JORDMVvB6J8u6ZTSo0M8PwSj
 tKlDTuEGhsRA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] target/riscv: Generate nanboxed results from
 trans_rvf.inc.c
Date: Wed, 12 Aug 2020 15:30:28 -0700
Message-Id: <20200812223045.96803-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:48
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

From: Richard Henderson <richard.henderson@linaro.org>

Make sure that all results from inline single-precision scalar
operations are properly nan-boxed to 64-bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200724002807.441147-4-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index c7057482e8..264d3139f1 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -167,6 +167,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
                             0, 31);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -183,6 +184,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -199,6 +201,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
         tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -369,6 +372,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 #else
     tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
 #endif
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
-- 
2.27.0


