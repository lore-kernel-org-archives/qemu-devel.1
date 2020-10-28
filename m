Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574EE22267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knAwzEAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574EE22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXeAK-0005hF-EX
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2u-0005Nt-6U; Wed, 28 Oct 2020 01:30:53 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2r-0000fi-VW; Wed, 28 Oct 2020 01:30:51 -0400
Received: by mail-pg1-x541.google.com with SMTP id r186so2120162pgr.0;
 Tue, 27 Oct 2020 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uYpfacLi0HFqLA2yupEcCAF5YHy1UkSwM/v5iaUryxA=;
 b=knAwzEAg8p9gV6pE+sF/k/smTwiMMLZtLD6fQgEhJz5Iba9+eBTvyrZut+M8nifGtt
 l0cwbTEldR1QplXyUidLWDwWKCPB8QFWQjSv9x4zezWzu6jdgBqkAxpaTllbBrWILH/I
 d0opl1yl5ymjdWkyK3PrRakfwCKJFC47FG68+1pWuLo5+fTB33XCi0T1qeIyD/+rmtou
 fjD1/nX6d9zMptzB+5XCS80zgDggnpc3QevMQb60+rBqzkwOnU16CatnuTeeNoUi0Ek7
 kitnFdcqpBLeNVoBu+VUHKe6uTCwE7sXDTJESj3revOWnL205hH9aNBmRpe86aWmAgXV
 ASJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uYpfacLi0HFqLA2yupEcCAF5YHy1UkSwM/v5iaUryxA=;
 b=gHbWsU+ZauHnaxW7jyZbkvf5JAZw9LibBSTBjCBMkq0JXtUnGb4qrslZ6VdCuMS8yK
 J+zfNBzp3mNLNvq2Uw4otjOU/6f/2ho2kdjRmzTcgd1BmOWCCZ6xttnMc05Hi0v7R2P0
 tJNVJByKHADhaCj95KlzpMyIfQM1GMJBDBkMp0Nn2GFmDw0F+bNimKHUK2aROG0GzBEz
 /QukLmznC+MykZMHFo33NEiDQf1qwfnF/NQdGRWzpm9G+Im0ltDa9xsn5RgtK8PHQ82U
 GhCZ67ymFsWl7JcZwvbHJPR6eFQqtHO2AWE31bF+nVz0y6ETVGplibi2kyvQYbPNME9j
 FeRA==
X-Gm-Message-State: AOAM5326bTMaBD256i4hdD6G6/rrlogAnhC0Ncc/Okj6HYgYNhii5iHp
 eoDX0fMpaAkJY5rqdQX1t3c=
X-Google-Smtp-Source: ABdhPJxO/L6i3UYHukr8s/SgvuksAbSb9Lpibf4fUovS2JODpOT3ON4TFw/r/1qomUKlYODet196cQ==
X-Received: by 2002:a62:7a8f:0:b029:163:d0b3:ac18 with SMTP id
 v137-20020a627a8f0000b0290163d0b3ac18mr5916858pfc.9.1603863047886; 
 Tue, 27 Oct 2020 22:30:47 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:47 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 08/10] hw/riscv: microchip_pfsoc: Map the reserved memory
 at address 0
Date: Wed, 28 Oct 2020 13:30:08 +0800
Message-Id: <1603863010-15807-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Somehow HSS needs to access address 0 [1] for the DDR calibration data
which is in the chipset's reserved memory. Let's map it.

[1] See the config_copy() calls in various places in ddr_setup() in
    the HSS source codes.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- change to map the reserved memory at address 0 instead of debug memory

 hw/riscv/microchip_pfsoc.c         | 11 ++++++++++-
 include/hw/riscv/microchip_pfsoc.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index bc908e0..44a8473 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -90,7 +90,8 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } microchip_pfsoc_memmap[] = {
-    [MICROCHIP_PFSOC_DEBUG] =           {        0x0,     0x1000 },
+    [MICROCHIP_PFSOC_RSVD0] =           {        0x0,      0x100 },
+    [MICROCHIP_PFSOC_DEBUG] =           {      0x100,      0xf00 },
     [MICROCHIP_PFSOC_E51_DTIM] =        {  0x1000000,     0x2000 },
     [MICROCHIP_PFSOC_BUSERR_UNIT0] =    {  0x1700000,     0x1000 },
     [MICROCHIP_PFSOC_BUSERR_UNIT1] =    {  0x1701000,     0x1000 },
@@ -176,6 +177,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MicrochipPFSoCState *s = MICROCHIP_PFSOC(dev);
     const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
     MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
@@ -195,6 +197,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(&s->e_cluster), NULL, &error_abort);
     qdev_realize(DEVICE(&s->u_cluster), NULL, &error_abort);
 
+    /* Reserved Memory at address 0 */
+    memory_region_init_ram(rsvd0_mem, NULL, "microchip.pfsoc.rsvd0_mem",
+                           memmap[MICROCHIP_PFSOC_RSVD0].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_RSVD0].base,
+                                rsvd0_mem);
+
     /* E51 DTIM */
     memory_region_init_ram(e51_dtim_mem, NULL, "microchip.pfsoc.e51_dtim_mem",
                            memmap[MICROCHIP_PFSOC_E51_DTIM].size, &error_fatal);
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 245c82d..f34a6b3 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -74,6 +74,7 @@ typedef struct MicrochipIcicleKitState {
                  TYPE_MICROCHIP_ICICLE_KIT_MACHINE)
 
 enum {
+    MICROCHIP_PFSOC_RSVD0,
     MICROCHIP_PFSOC_DEBUG,
     MICROCHIP_PFSOC_E51_DTIM,
     MICROCHIP_PFSOC_BUSERR_UNIT0,
-- 
2.7.4


