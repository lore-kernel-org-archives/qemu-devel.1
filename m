Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA622C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942C4207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KVu9jZnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942C4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQwx-0004Rw-N8
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvN-00027r-K4; Thu, 28 May 2020 18:22:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvK-0005hu-SS; Thu, 28 May 2020 18:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704572; x=1622240572;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vDZd4fWZoZGped8sJN4wTNf8wH4Xep9G/tkQsk69CK0=;
 b=KVu9jZnn9/C41Vw5nsrLVZCtpIaDfCRtJPoFx1Zc9oXPigZt9OALyFjk
 aCalVVD3U6INQ6HXjIEUqMD1yE6IjY/YTk6Uq1joe7020vwx73G61klfi
 S7E5fU6dymCUjHLjR074i25o+oOmZUTU8NfVBkxBYD0vImH/Yp6kEHhK6
 TZh0YvamG+tdUjfKIMX8ozZZ25nvZ+tTyOyOMMlMGP/pSMrRI+kaj47QO
 a5oiZSnXXDrqyoqXfq6KDlpIzmk9495Tfe1/jphgOgd5EVjUoYx4+wHwG
 wZf0Qw/L4g1zBI9k1FoZwvuK0uHL/1N7Pi6qxjApfNAVnfzY9Wgei58UC g==;
IronPort-SDR: cGlkGdL4KITIdHBwzHNoNWwTDIuCsVQqSpm0TeoUMRj/3jqVl8pywhxOUCSQPXhuOt1ePcLy0L
 cZGFeM0LN3nR6D/gsmWgCpuzfOIV6u46BHCQVe/Jm2KS6SQWxkLRaCbrVv3MPEq32RArRli3Yg
 IWTxbHnJucbPdn3yU1vyqxxAxMRvzDv3dX6zQndEj/zYKkObInJb5SPyAg85ZreyP1IFvCbN24
 M+joBRK5fyp9uQbFXZBgPg4CcCY5nu066vynKWO0vP4fEtNyuu2SBA8P0DfeyJmBKogWxHM8ev
 dH8=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="139073329"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:22:49 +0800
IronPort-SDR: JRngCyMcOIBzqaR6oa+WNnesprRBcC6zo/QK9pSWH87FUz8ezXCLOzejYq4XzPmbzJqdXR6s9a
 6KZV51RZdmuYm6w1eJNvwyOsKv3Gi8ddQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:03 -0700
IronPort-SDR: VMFvLY5S7qLuPZeUU9YEfHUupRUayj4a9hNENTlBBehMh3lyJKHxZacFNp2FyoA7wJx+k2ViqG
 m229gVsY5/eA==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:22:48 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 02/11] target/riscv: Don't overwrite the reset vector
Date: Thu, 28 May 2020 15:14:12 -0700
Message-Id: <c8efc9d0e31270d831a267e8ff78a2a70cda7d39.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:22:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The reset vector is set in the init function don't set it again in
realize.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..5eb3c02735 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,6 +133,7 @@ static void riscv_base32_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
+    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -180,6 +181,7 @@ static void riscv_base64_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
+    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -399,7 +401,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
-    set_resetvec(env, DEFAULT_RSTVEC);
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
-- 
2.26.2


