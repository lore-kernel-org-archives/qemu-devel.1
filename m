Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FFCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68BA207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxLyUgFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68BA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bUd-0002uM-74
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQQ-0003WS-5N
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQO-0007bQ-2E
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418120; x=1628954120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uOT7bF66BUjn23EePzsUiUnjjzNFLMEUpDfYHK1C+rg=;
 b=SxLyUgFqT4mD02rol/xXCIG/9kn9HHAPJcn72VDe/LU2JMgDu5kSafgs
 DWedaIcre/fPCIUYSWq7hJqAX+gL8RsjA76ndZa8MCJ935E/oTVqhjeNi
 deDKGNIP0vOKcCLfeqCvsHRWGbpEaERMIeAuidoKpjUhjfRvVQRcYpXVk
 TuUf0u/Atx4d7/Gk+fC3DUaa1TvZkZPFmhBxknp3TjRVJYy7hkhZYCurO
 CtzXQYs7+v5PGiFLYf47YHmKGb5L3eMpnCA6uW5E+QVnV8SMjjXIS5Vw+
 ckeKlhmsmoX8vGmKnrSqJLqZue8hFxjZlXpAjPwtyi1N/YRus8cBzlH8r w==;
IronPort-SDR: vkhaqqLqkuhHD29lc/Mh7661zU0d3YxOoUKMLZgfBmPCPhfg5sZxOkH7Bpc9eAFe+p4IDkHVvz
 rzhvauFxw2xNCVGRw6CGur4D/JwdcwQV4TkTUExqzMQD0wd3SgUj3I1Vu8Q+n3uBfcXTFZyOvC
 Wiz+nGdL2W6iH+uY+x9IhZ9B3jwGaaRHWlLvRtR1vGDd0gccT+Zk88a0/UaARnyzfnWKbVYsoB
 LTf+h4S3vPbmclnTvmIowKXFsr0Bty/RiRUZkqiWaWj6Zp8XLQkwo83D6/saLZnvh94VUjeBla
 h7g=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994810"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:12 +0800
IronPort-SDR: MU3X8FPzya5/yZ7sMfM+Glepr4iZnUfo1bALT80ZdYvz3WdHrClC8qNkRDEkmnESIHULD4q486
 7aBhvGGz0OkA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:17 -0700
IronPort-SDR: ukosTHpdMQ7OLGnocCjgSx6W+tB5WS6Rkvod/kyOFJqYJp7S5icrH+TKGIzXixquiDtmqdSk9m
 akaaqb0gis9w==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/20] target/riscv: Generate nanboxed results from
 trans_rvf.inc.c
Date: Fri, 14 Aug 2020 08:04:49 -0700
Message-Id: <20200814150506.2070566-4-alistair.francis@wdc.com>
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


