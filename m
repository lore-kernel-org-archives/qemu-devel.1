Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F08AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBCE2071E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B/6JgM/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBCE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyXw-0005mZ-Sy
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKT-0002W8-NX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKR-0001Fa-9a
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417675; x=1635953675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r57vaix6jaMv33EUrj+BDv2Ap6h5uq3sW8MQsYHDDPE=;
 b=B/6JgM/zkDiBCPHPmmx4FXs+K5qhEsALIwnAHTa+jzDEy6eU/ZBipX1S
 tybCkzwHotFkRttEMEOpEaNsRO3GPZ7F84ECvhDh9JaLx3TtB0x5LqPIF
 PJC7dmeeDOeOW2fO8nQEo+lirCcQATTWFRIZ8kREagblca+xQvmgGcfrR
 6Y9Bqq8CBirI6iZTK0ZV0g8QUeCsIMem+ajaoQkXq5UhWTIY22DasUpdR
 i4FfXGjK5MBfj9Pcykn/lU2w0hzWFxjL6/sgkzCswKFZMyLkJ2RPwLJ9B
 n167weuPpQ3TBj+33+ijL2nc+Fymh3Om1mTTYjQC9liBGYG+OIDqRkbwx w==;
IronPort-SDR: 6ADO8kF3uFxfIHhPd7uj5WWYbeSeVC9ifitvUrbEDZHMEWop3tboJuqd2twm1sIqoHdmoswLsj
 tlnKyE+eaUVR0SQdVgU/I7FavgnwwqJLn4sgRdGr4GaYB34xH/M3FT6XjSyecKvCoZl79A5M3f
 yJoV3kpHuAKCVloVfCOFn03duisubDMsgs4OoVQ4LojeHxkXDzPWKY0uRe0JJJyeFvbUH/6YYu
 pLb787v+7p4r33cbaQvP2D/X0vbIwm+fPqzKoD1XqtZIKE3z0l5sfGokMn45DcI/V4/aeyhsJT
 F/M=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867490"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:29 +0800
IronPort-SDR: fvYEqC0IChBRAmusUOwgdsGZbnT2UbHR4qFC5rpGJQ2sqicmufIcQvgw8VY8QkkuBdD1lxTxo3
 7enSktmv3mAU87spuL0GfepWAQD9f27NllY1F1r0H3SKwPYgzMALuD5G8V4lO4BDxIvzFITXy9
 HZeI7f/FRN6Whl/Ltv1kiV8gPT4x3iyN1WKI/bO7BO4+i5iu+xRzT7qS1H5bPYoKsN+b1oqVmA
 e2E6zYEajFobqw2zjO15mYi/e5bFnZIWyDr8TPVxEXa7COgLLwFKEWe/Lg1TEXGkYhjRJYbIYQ
 goXuwv4RfZxJMPALELWSUSjN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:37 -0800
IronPort-SDR: Pjf9/EEDsvH8CX4x0ID5x+NLL8g1ijHk3jQ32f+KAbfll3sJ25muznBSLJ0IFf11dEz2nim02n
 EVJPMNKPHWrLMHTajg8iUogILVajQiahvLELjrj4QYsApQUnb2u0WGvVgQ9dqTTSCjAosMd0DU
 0d1sDqr9z8uSu+jwNfZx30v5ooH9AtMkJW7IjuTMACmgWO/DygTIRnRF6HCyXDXWkxxASSbrEe
 MCeOuKcQcfy0hj+X7llnqNnl5Dxoxz+xfNM6jiZgrrmlcUNQ0U+zPcrAwAN2LALBwVBEfpq14b
 knc=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:29 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 19/19] target/riscv/csr.c : add space before the open
 parenthesis '('
Date: Tue,  3 Nov 2020 07:21:50 -0800
Message-Id: <20201103152150.2677566-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Euler Robot <euler.robot@huawei.com>, alistair23@gmail.com,
 Xinhao Zhang <zhangxinhao1@huawei.com>, Kai Deng <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Space required before the open parenthesis '('.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201030004815.4172849-1-zhangxinhao1@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e33f6cdc11..93263f8e06 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -882,7 +882,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
             return -RISCV_EXCP_ILLEGAL_INST;
         } else {
-            if((val ^ env->satp) & SATP_ASID) {
+            if ((val ^ env->satp) & SATP_ASID) {
                 tlb_flush(env_cpu(env));
             }
             env->satp = val;
-- 
2.28.0


