Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D71C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD50320862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lAOoNifi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKF6-0006kW-S1
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:08:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK41-0005Im-Pe
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuy-0004W1-0y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJux-0004TN-Mj; Fri, 24 May 2019 19:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741687; x=1590277687;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=jX/RpI7uSP8KPd5AF5ZDxr9NUzaT3LJkLiKb3mUVKRc=;
	b=lAOoNifiyQkeUBYrHidNduWFCN5hpyvRwpjnpFLtulWlV8xLuzXvuDTR
	ljjOiT+WH0YUxRL0hfmYtcCBfCDbv4AXY0nHjLmWBd+86B+b/hJG9mgZs
	wXwpx9Y9udfDMIi+6lRwnvPgFAJbHaRXHr4wqkj1Goj9QM50OW/iRfmxC
	BtNZ+tUxIENZPmthpEb/lCkePTtShTpOaFXde2f23s2d6GN8jLqC77KJV
	mJZky7Sl9qtPwIGFnN3+z9PlXfucLW5KomeBmeK+wJkeWHatum8gieLTp
	arhAmbySFsMWR0G/VVe+NocNE+efC0szapt/a4u83U/Qun4i6YrZ3IdUD g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265019"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:07 +0800
IronPort-SDR: ddL8kvuY/ImZOI1nXhap/HESfK1/VZQ1VzoExKKXVAfre04rhiBK06lnw9gpUzgTWSFExlNER6
	59b1fOXgrpUr8Y/e5hDV7/jK5cvcW9WlJ/CdhiYHcVfcXQexVMy/5DeWyvAeiBK4Moqm+vEzas
	UFVJuAjJfOa1DC/s86D3oxwbTH/sx9md1PiLhmBi08yKnx9ZyrtG6oYobMhZBsVSQ8XjNi6o5g
	5KCiBPHlLqn1Txf+h5hz1Fxev+QwVdRTZXjm3q2l/ANuH3iavaJYIfLEo3OvQXurbCVk/xaUsB
	GJlnQcqDmJkQ+/rwbNGfEYZq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:46 -0700
IronPort-SDR: aAFRx7VBpsLfvI66IaERPM6iTf2F1B3Sek2FF/jA1ahodM/jQ8fl92+3+u+32UlC59J+ekfcb1
	4PLpLMfbJrqjY3J5AfTnjbfmrOuI5Xz4KNtCkUOkVbJxMoyjhbiaZbroHnqLc6nLv8nFDBkTSW
	xcq9OEYJwKYK60KIQInJhS7Rt4X1T8eVHfafCvsSFcEEjNaPklsDxKTxb9S+lE310SEx3WkZDA
	fcZgqeeadg/E3Mnbv7gPKsSOyoXAoc7tCkftlU7odzVEqM1txyWcaQSZK06ljWd84j82ksVc6e
	e7k=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:12 -0700
Message-Id: <2072d4920dd97b56f5a15d8eab64d39fc78e9390.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 14/23] riscv: plic: Remove unused interrupt
 functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 07a032d93d..1e7e4c8d51 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -159,18 +159,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
     }
 }
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, true);
-    sifive_plic_update(plic);
-}
-
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, false);
-    sifive_plic_update(plic);
-}
-
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index ce8907f6aa..3b8a623919 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
     uint32_t aperture_size;
 } SiFivePLICState;
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
-
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t num_sources, uint32_t num_priorities,
     uint32_t priority_base, uint32_t pending_base,
-- 
2.21.0


