Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3ABC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8C42074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ErvDp95Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeGj-0006zt-6T
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAO-0004Mj-Dn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAM-0002vn-3f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381971; x=1629917971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KkXpN/My5uz42htygwoCwOQL9QQ/iHNRPhmz5fxkdlA=;
 b=ErvDp95ZOdDGmjSoMnrltA9d53Qx7XVpOOx7ngj1ks3FuC4c5vjZWW8b
 8lhWgqFJAD4e+p14IAE3dvZIOhwxtgnv4GVL19QpPCpOA6UswW8jFyVmm
 pBJRY4xU5dJOik6FXfq86em8n1XFBhrYWH7tB94OWk+bqIiqTlnES28tx
 hq0+H+tvH9+FQAza2OWbIX/4x8GOc5lyxsEfq04Ymdv1wOfveXF5KU4il
 mHfvB8ME+c90VoFFSqPPc4sKoQzxFGLAto9u1qCb0KJHNSr8IW0B1DSPb
 4Qz30dnP9XWyYy3z+vOeOborOCcNZnXZiWzGNUqDE/mJ0wbMJvUt0PNDo Q==;
IronPort-SDR: P6cTXhiJsvtj7XSN5Evfaz7ODG86JQ7rvoHBmoGuzkis2asWzsOx3wZGeY11B/E+Xog6lQPh+u
 5ZrAF4+rPARpjRMPVhjsBAoYSbLYnqfqqW4RkS8i12Ftw4K84uHHoaf6d6SahLfTb/k6FlQ7yT
 M6pv0KQtQpqADUq/brpfu1GA0x72yzKNEoia5emj4aWcg2tYcrVkGM+2D9eoCCwy7ENRc3X/kw
 w3RFdlAZxlqVZuqHqgdKCPpc59njk0vHOmpSXMIeQLenq2RZbKuXvc1yZ1X6TAALo5fpC7mcW9
 JwM=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145296"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:57 +0800
IronPort-SDR: wO9TFhbfKPpCmY6G8Z1WFJ3gTwjOOrk6pwq+1VlIDmcCIXRFOM7gZx54V/mUTkP9tSD2C5NddC
 BzTyMnVGvuPw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:32 -0700
IronPort-SDR: vEoJnfuVBPhJXqHWkXH1ZQ7fi9BkfOHt1xp+9cbd/POL5aW2u6EejoTXd4W43ZnbsDSOXYalA1
 +Ze2+9Z9H65Q==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] target/riscv: Only support a single VSXL length
Date: Tue, 25 Aug 2020 11:48:32 -0700
Message-Id: <20200825184836.1282371-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: f3f4fd2ec22a07cc1d750e96895d6813f131de4d.1597259519.git.alistair.francis@wdc.com
Message-Id: <f3f4fd2ec22a07cc1d750e96895d6813f131de4d.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f9ac21d687..390ef781e4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -836,12 +836,21 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
 static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->hstatus;
+#ifdef TARGET_RISCV64
+    /* We only support 64-bit VSXL */
+    *val = set_field(*val, HSTATUS_VSXL, 2);
+#endif
     return 0;
 }
 
 static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     env->hstatus = val;
+#ifdef TARGET_RISCV64
+    if (get_field(val, HSTATUS_VSXL) != 2) {
+        qemu_log_mask(LOG_UNIMP, "QEMU does not support mixed HSXLEN options.");
+    }
+#endif
     return 0;
 }
 
-- 
2.28.0


