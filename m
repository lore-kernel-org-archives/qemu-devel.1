Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD02121721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iwASB9gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD02121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8B2-0001rx-Sd
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pb-0005H0-Nk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pa-0003rF-EF
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PZ-0003qa-9A
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id v4so7155177pff.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=TOZjPGaqbzlFPxN/8nnP07xTCGhUqh822BhqPA8uXpI=;
 b=iwASB9gCR+Q34m6kt71AMJfjamKq1lgOWHW89I4nYHzkp0zieNZPcVfKEoLwFEcHoq
 tY5riL3Cyc1UxctufTDZ0wWLPYUZCnZExo/4hzFvEcR+OCiKAvPCC+iWJ8lYQfL9LCxY
 Lve2GgX5MsKyvOzOJE6kcdxb9PMcIQsNLNeqcUmXikBHOsYchMUwpb+YmpKjWbv+qvOV
 S6eRlc/9jfPR3DFopaS087MYifM9EEkxjFb7cWVJBdnQhycdTq9v9vz9fFuSi7FattKr
 cQN/fC3PUIUFBl/SD1pnn6dQTjPlNnDkZtDNo/SZvUIlFQUeyIKWxh7DhvMeyluZEuJs
 T4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=TOZjPGaqbzlFPxN/8nnP07xTCGhUqh822BhqPA8uXpI=;
 b=akzOaYpcKyfJAk0jPXsHFqBTOWdFGTZGpx5yheYXTJwoH0Yi+5O6P7sgAvyqi6YRNB
 8KKmyHFcI1jUgK1EHVKcyipO5lXNmxd4G7xumq5grHF5cYwtlGHM47NgCV1rPh1RupUa
 YVvP0gGMrM4TcW7o+WSn2P19vm3BKsa8GF5YaBuKmoeoNJTzNstKuDltO4/8ZWa4xg99
 m5xs0gEmSydlzeo3KAjmNUmqf9QfoBoz3cj+T8VpIcdfO7UuLgmjOz4P7dD+WO7fAPkw
 sMfph/RDOThPSW9ryzgFftYjPC9RAfE//jMgNW5yPB9E87uaZfIsyjQxdvs8nU9cGSKi
 uEbw==
X-Gm-Message-State: APjAAAWb+HjBi70Rs+yWZ729em+TfXUFxlk4ck5fKfCm1Hbk5re1p680
 qLfWWWlEGtY5XrlpmbTWHjK+D7dE8Pdy6w==
X-Google-Smtp-Source: APXvYqzj3WqwHSFucM/P1z4zbJlAFrGp+ItW+DIcMFnJOQM8ORekePfOMgoscrj921vx0aYdbpMLFQ==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr17835pjo.16.1572278307994; 
 Mon, 28 Oct 2019 08:58:27 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id v25sm10646364pfn.78.2019.10.28.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:27 -0700 (PDT)
Subject: [PULL 07/18] riscv/sifive_u: Add L2-LIM cache memory
Date: Mon, 28 Oct 2019 08:48:51 -0700
Message-Id: <20191028154902.32491-8-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

On reset only a single L2 cache way is enabled, the others are exposed
as memory that can be used by early boot firmware. This L2 region is
generally disabled using the WayEnable register at a later stage in the
boot process. To allow firmware to target QEMU and the HiFive Unleashed
let's add the L2 LIM (LooselyIntegrated Memory).

Ideally we would want to adjust the size of this chunk of memory as the
L2 Cache Controller WayEnable register is incremented. Unfortunately I
don't see a nice way to handle reducing or blocking out the L2 LIM while
still allowing it be re returned to all enabled from a reset.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 16 ++++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1ac51e3632..fbaa3a234e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,6 +65,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
@@ -432,6 +433,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
@@ -460,6 +462,20 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
+    /*
+     * Add L2-LIM at reset size.
+     * This should be reduced in size as the L2 Cache Controller WayEnable
+     * register is incremented. Unfortunately I don't see a nice (or any) way
+     * to handle reducing or blocking out the L2 LIM while still allowing it
+     * be re returned to all enabled after a reset. For the time being, just
+     * leave it enabled all the time. This won't break anything, but will be
+     * too generous to misbehaving guests.
+     */
+    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
+                                l2lim_mem);
+
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
                            ms->smp.cpus;
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 4850805ee7..66ee76a780 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -58,6 +58,7 @@ enum {
     SIFIVE_U_DEBUG,
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
+    SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
-- 
2.21.0


