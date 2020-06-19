Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE44C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D0220DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rhia0lgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D0220DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKa4-0006jG-CV
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUG-0000l9-Pe
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUE-0004Ps-IB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586454; x=1624122454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HF1JxGXWDSpTRfYKaMM0wJ4es08kDgUw2iC6UdUH7F8=;
 b=rhia0lgRqwz9Y15Pkh/mIBBCM6eWPdhJtR3YFBcy9qcR+n3r0+ZR8lWt
 /xTz3zGs4dQZe0HY5AYOX+umW66UWYxE5iXLIirniCSAQqJNLKJuP6KYn
 V4nwA12udohhrFa6vLkkfdUSCc5sjuvyz7Vx7CUIgOHXzNbGtY8UXHe83
 xjjsJlHzJokGaTI0l/cc+sIDmCl4uYr3j27GYwzF2ODqu3m/WkaNcFGTT
 GBtWm3fdu7v/BejP043vDeLI8mqWUrKSykWQh+tt4BnOCplyV9BRfNSfp
 h1Iy9JZo6kE2YP11Jzc3w0fKhJImpibMk+H482M4u57MgZobrUq44lGRL g==;
IronPort-SDR: KGyOF9kxo90jyrWzV5VQhrsR3CMISo6Iu8qvITnNg3u1Bek60i9Lu+6xRWYTHt7Xn92XSJZd73
 SSipozQwrxgxWpbXVeTitFmGP0Mnr9/kTUeP481Nb/T1uiKDAs1kx21DPwY33tY53OovUvVX4/
 AZpXxr/kc6PG5oRVIUH1rdLVAzH2+uZauAlUZoIXi2mV7sNULq1u7GYqrAYsixo1Ap3vq3S2bu
 s+526480XpL9VVLI8xasBI6L+wDOfYcH54K9rQHsxZz7+lzGYmTvfZr8FgkWozrAGRpeb/I0vh
 zgE=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417001"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:27 +0800
IronPort-SDR: ypZJUS+aOzYXvOoVLwatp1wO2qpZpRRZ8uAZcJ053SOiu1Ojqvw86EZDU/I3P78tl5nG+2Lgqe
 UjoMTWm0mII+DWBVtcfRV+h3TNbYjfWZs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:03 -0700
IronPort-SDR: bPOAPRcStAC7V+pKVMbBXqHoM8SZyXdp96ZFcMD+NlGaoDbZS8r4LVplLnmggT869DYzPARqRM
 aA8A4qhON3sQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 19/32] hw/riscv: sifive_u: Simplify the GEM IRQ connect code
 a little bit
Date: Fri, 19 Jun 2020 09:58:04 -0700
Message-Id: <20200619165817.4144200-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

There is no need to retrieve all PLIC IRQ information in order to
just connect the GEM IRQ. Use qdev_get_gpio_in() directly like
what is done for other peripherals.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-4-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ea197ab64f..20b0276ea3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -514,7 +514,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
-    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -594,10 +593,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
-    for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
-        plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
-    }
-
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
@@ -611,7 +606,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
-                       plic_gpios[SIFIVE_U_GEM_IRQ]);
+                       qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
-- 
2.27.0


