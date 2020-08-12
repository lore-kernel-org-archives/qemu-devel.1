Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7DD20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nEjR8tUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7DD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zUE-00007T-65
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQV-0002IN-Tr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQT-0005mK-VV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272054; x=1628808054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=359gDMSZfCdWmjYaBw4t9fga9UEtLTY35NYUxlpDAyM=;
 b=nEjR8tUho1HovmLlGDUA4P3cUBm7reo/kUqG0GVZgh2SYFDzySMxwLiT
 Fp1wu0nC5uWqE3V2KBXgBhcyvBWBTDfGvMykyMHc8fdY73KN+VmLelSUy
 Vy34BQ5rq2kW/EPBFTAwXZM115s/en4pw6ui2Ejo8G/O0lh3SnyBRj8Zg
 zkRMt/2TMJYCqum/9AVeGNxOqiLuXTfJSrvMCpY69lvh1V9bR74NZbyaQ
 IuwlKoi5if0uePFw488TNTVPi6+88WrsuaJQ1nh731ZC0+ofD1Oe3LB1a
 GmEjjYNbAF5Nhf8//D+rbbohPNUEuLgthPdvorEJZM85v5XliUCjQ00f2 g==;
IronPort-SDR: mupeBQ+T7XOyzKzxLEQVnih5xBEvUmZ0ixwXt1DdWNztjD5Ohq1oZRuW1jTfrqNjM9ZRCJIG7f
 CfXdQy3GWo3LJtcb9hClJZ6Ly/DX1+uDPTwr3OLxr9MnqkXChqwnPLut0wPJ74a+S7z7HTeLyV
 9QpBhk9Z4YiNrqL0TQkuS9P+tc/8ZhigcrK0ikFgp42Z8DlyJm0JAFffJ0Ac5QEF29pyU0KJ9u
 08sVjU/ElrI/p/4XYbBYMQJ4198WMfN9dnSsuKzsdXcg+5LXDXN3cYxYHMXOqLLGdX7dmQ+pTM
 ME4=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:48 +0800
IronPort-SDR: SLhlLvbxrIcsPDb+Ul59M/r8RkEfaEkZ5TbMJWStAK9A7V3oQURXdJTvu5+SRNCU1ie4Ujb4gd
 jlp+ANleMEhA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:39 -0700
IronPort-SDR: Go991g+rXuuL2elKebBI4uoH6a4vNBgYMkEoajnJeiAdjo3Bt2eAMJ+JAze4gewagnh8H8ople
 UCYhDuBnhr9Q==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] target/riscv: Clean up fmv.w.x
Date: Wed, 12 Aug 2020 15:30:31 -0700
Message-Id: <20200812223045.96803-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
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
index f9a9e0643a..0d04677a02 100644
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


