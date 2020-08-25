Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE6BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CB82074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D1h4phP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CB82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeF3-0003ca-CV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9y-0003hC-TK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9x-0002w2-6Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381946; x=1629917946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m2TKyr6HVsz9M9uNelK10bYsMCdJvpXP3PmII+kRDn8=;
 b=D1h4phP3eEjG72uKgbRiID65cOIip4GjidJg37gAKR2JAFwrneoCblDH
 1CLOt0fY2F/qE9mnkCQZNx3iU6YzbyAi4w+/kGr9HAO5oxnhHw7hG17oE
 a5MIggff2/h37ghDlzhi2SgjYI+2qwPwEEnfVWkfCB8hh1HUS97NoxMC3
 uvvuAYPLold8NaAAuepfe/g8jFDmDZd7njXlMkqeIOyEKp/plyUdWs3fM
 4hs0HBJsqsp0oAcfFFnpxcAjpAZrPSGL3PXSHF4MJZPmnKhjEOBAZUEJu
 GlXgzjnuUc/bV1rk2vOIULvOrwbdkEWe1hXw72nwUlr9qfyger2peOVMX Q==;
IronPort-SDR: YeqpLt1Fhw9myVKOgXUJKEvsH9RPaijbXkG6i5SBKwbDVu0OAZrzG2XwUwxXQ49FEcGusSCf7O
 w2Bj6NSxlDwcpN+xZdB+0JS4QCSsyVS0TRO2KjMgzB/9JLvRn0p9jWLlj5caM3/c+l/7e3JZZI
 3cEMacfD+/6gxcqUYBCDjtgzaxi/58Muj0m7eVcN1vUTas8ajyGFUyJ7UQtl/DDFXBunMexSP1
 0/ysqhevAlccEeV0vgyW8SStiAOi+t5HqRskRtIfFPmkFGKC/zH9wKb9rhIsq/0ZeOlSdWE04T
 Y0A=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145291"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:56 +0800
IronPort-SDR: fS4or2QUrmdaMoerdtypex97f07ve4VR3SBEa/VRs9cmSIDv885qoObAS/HnRUiEEBpLflice4
 WuYXBeUlIrrA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:31 -0700
IronPort-SDR: 97wI/lkp64qajBj3EDf+BQv1AmW/hSkOHdte2hnuy0P38AFfyTjM7fBAg+e3r+ptiIjZOfXKgf
 BKyDICiwxB7A==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] target/riscv: Don't allow guest to write to htinst
Date: Tue, 25 Aug 2020 11:48:27 -0700
Message-Id: <20200825184836.1282371-10-alistair.francis@wdc.com>
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
Message-id: ca5359fec6b2aff851eef3b3bc4b53cb5d4ad194.1597259519.git.alistair.francis@wdc.com
Message-Id: <ca5359fec6b2aff851eef3b3bc4b53cb5d4ad194.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/csr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6a96a01b1c..0f035d33b1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -922,7 +922,6 @@ static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
 {
-    env->htinst = val;
     return 0;
 }
 
-- 
2.28.0


