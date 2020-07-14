Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC388C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937F021835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BCYCYRMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937F021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv994-0002q3-Uz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv924-0006Pm-EN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv922-0008OU-LI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687370; x=1626223370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b/eEmTWGFFmyN1Z+hTb9cRNFj95fvhrTz8sK879H8Oc=;
 b=BCYCYRMDtGv2vjR0DEnHBDeHNduuzWSq1SmHk44w85d8yWEvnqgm/y0h
 YC7UyzGSEyidTMtbTb6a4Ro6wtxYVkk0BCbdP1pmOu9emRc95BJOwF9RN
 vPYpMHBbUMHCDnEe2LJ03HlLF8+uNC+r8A3KHF5tqPZ8qE8MFD9qUTGTk
 NXp5C+qGtAdXfYGuE7OimBbgC/jU+moDc3ZaWbardvoxAr1GwzTms1Ukz
 9YvmFO93GS8IQeMZiG5Bwd6YTwOUl9yzx8zR51BOi57nZtBya74QZT476
 szTngKTo1vsx45suLeNvwrdMAz8VSBjFC08Dq8EXsQhhDjoFCORRPJPEg Q==;
IronPort-SDR: mlmmPmR0IgUw3Z3ONFi/CA+dDKgYBGYIKpIwz2h14gpEXZ6XZ4wnOSl4cpQJAI6sZOaOGE6Tln
 FByfhSuaQezf3OIh14i3pJcY9S4wDkDt8ghQpZDgOncGo1oVk3ES3A4GtnLkVYOA7GGhPek4cy
 WNn624sImP6LTtSfXev9Lt3tmnjYARF0xpP52WyrdkaZol9jt3vOo8JPRoN4CloT9FosmlBz6G
 b2D8VVoVczCt8XSrNsAh/o/H1EXSS+SBaps8cl03sz6GBkkSY7wLOa/uGhMwB7x2r5pSUyiglV
 QZ4=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511930"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:30 +0800
IronPort-SDR: 8EqAs4LPOJg4sTB/rDD6OcyZQXDjruV/mpibjm8lv9a5Sf5DiZJFe4nzompfghxowP4aXhaa5f
 gssNraMaiyn2T9SI9htD6rTpwgC/tvW/s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:58 -0700
IronPort-SDR: U5BGm2IJ/MzGCOc94iLENdaQ0Gy746JcIRiYQ2rfL5x/S32hQIynJCVt6tObrUJUeyl5002mZF
 aHzG3xKiKwOA==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] target/riscv: fix return value of do_opivx_widen()
Date: Mon, 13 Jul 2020 17:32:49 -0700
Message-Id: <20200714003254.4044149-11-alistair.francis@wdc.com>
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

do_opivx_widen() should return false if check function returns false.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200710104920.13550-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7cd08f0868..c0b7375927 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1151,7 +1151,7 @@ static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
     if (opivx_widen_check(s, a)) {
         return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
     }
-    return true;
+    return false;
 }
 
 #define GEN_OPIVX_WIDEN_TRANS(NAME) \
-- 
2.27.0


