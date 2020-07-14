Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D916C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAD821835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gcV2CeAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv96K-0005lC-LL
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv92M-0006eq-2v
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:43:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv92I-0008Oh-Qm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687387; x=1626223387;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mIUuzb9nUqMl+WKgL29i4RxVd202cqc1kEZ8UvNT/Is=;
 b=gcV2CeAN6nWJxnR/NyA2NWZccRhQLO4jD9J3gUF3BhGP3UfBqvH8cDTK
 WK6JEjP5dSihHDfRyE6XMS08cqNivZuF+3/Qy6Z6A7sdC7SZI06zKTzKo
 LTS0J3FkmRgYoeRllfdSmHsTLpx/5SiRUuFLfbhz9+VI8QR/nC/we7q4h
 Yqs7g/4+6Px8DMQmtS8NxSVBK0ebHamkjIwFtpCktXVFoVkBd6kltEYlM
 9O7lml5HhKzcF1xeZ5KKtq/9iuMxZFjzIZwBQVP8/Dtl/8ao7hsWU3KGg
 YbAhPVkPeOu6SIhGl1oWCo4Ofa6OmgoZm+8oFXF2cwM14lEECNpeCNZco Q==;
IronPort-SDR: bz1nBgZtUV3BXSUd6F+gQbTm9UK0yZ8xn2OoARdervwcAmv+0XWY/RI6Ez7l7lWVLvd4q5lQrd
 wiAbJedw/bcLy180JtMeH5Q9eOeBxdjfX5LNa6XToWf8sVV02prUYpiiiY29LbIAxkG7ZwiPu1
 PHdeFkFegn1u+3bb2PjFjQPfRP7Uwi4STlU+RNFVaXZwNEg75kOJWDYsAqC2aQDRHNM/GXc4v5
 zel1giKO8vT9HtjXd6/lLYGSTk7m1tyOBrTi3tMJy042A2p8nabkrVdsXQbwUZnl6q2uvZjHXG
 tVk=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511937"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:31 +0800
IronPort-SDR: 7gjOg1RyGNSVqHlweb7o3qEojz/Dlml+xFyNtlQfIEKFUyF/FdAHCjcSncc4exp79ZUt7DfNOY
 qVjjHHApOiuwv1cv/kM/fwYM8aQKzRYv4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:59 -0700
IronPort-SDR: OCOTQCM23AF5VsabEGLKEAWrZ6Mg8KIMxb6R5pxgBG2IrRzjA/Z2+nw+K9EGheSbVroCmzu0O4
 TrQUWQqVGPrw==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] target/riscv: Fix pmp NA4 implementation
Date: Mon, 13 Jul 2020 17:32:54 -0700
Message-Id: <20200714003254.4044149-16-alistair.francis@wdc.com>
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexandre Mergnat <amergnat@baylibre.com>

The end address calculation for NA4 mode is wrong because the address
used isn't shifted.

It doesn't watch 4 bytes but a huge range because the end address
calculation is wrong.

The solution is to use the shifted address calculated for start address
variable.

Modifications are tested on Zephyr OS userspace test suite which works
for other RISC-V boards (E31 and E34 core).

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200706084550.24117-1-amergnat@baylibre.com
Message-Id: <20200706084550.24117-1-amergnat@baylibre.com>
[ Changes by AF:
 - Improve the commit title and message
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9418660f1b..2a2b9f5363 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -171,7 +171,7 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
 
     case PMP_AMATCH_NA4:
         sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
-        ea = (this_addr + 4u) - 1u;
+        ea = (sa + 4u) - 1u;
         break;
 
     case PMP_AMATCH_NAPOT:
-- 
2.27.0


