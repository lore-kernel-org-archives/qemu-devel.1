Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224CC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B52B20707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7XRqZey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B52B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2dt-0002Da-2x
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cS-0000OH-Ty; Sat, 29 Aug 2020 11:18:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cR-0005AL-59; Sat, 29 Aug 2020 11:18:16 -0400
Received: by mail-oi1-x244.google.com with SMTP id 185so384291oie.11;
 Sat, 29 Aug 2020 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=As6XYe9jhFVqGZbNvmQD6KrpN2QvPQQgwbIW8SC2EbU=;
 b=A7XRqZey6DxNHKcgCNS6kCtfHuRakl89HYMf1DV55ozIrbpHoD1TMk+m1bzviWPfi3
 SBiNr3DOPqb2MdPD31XvBu3mgoc7jt63Wj/LCiErMb3JBvHSKvah8lpQSil2q3dL3fey
 si7GMukJVhARyiDXKBD0tQgQF9xKTTAhYy7awl/9hWdsvLyawTMKsN34k/alLheIyNxc
 VO2KSxreNCCx7UzxGSB+eh7TMJ0rOSw4zAU13NM8wICpWRCcamx13ZquHTahHzeCpjHa
 PTy/WDWxAONXs8LSWmfelp7AExywUziY1pNvtDWDA7htpfi7b3UwMDOgoHeUTK4J2zzU
 q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=As6XYe9jhFVqGZbNvmQD6KrpN2QvPQQgwbIW8SC2EbU=;
 b=lc+Qv8Qfjv67NPzrVJg8XXtSAK2hFQQqKrM3l7DmJ7QHuriVhtW1yuHvJ820oRgk8M
 7iZ2Z8CaTQBPZ9LHXTlxLDsfC1/7MIOT3pgmfqKyk5rTTGQ+9rFDzGLIqOAWqYAECaAP
 S7dt7Yh/J10i6Zrga1jeu4Z+vKS0/bQFfC7FWLAzZefbXkPSB6yyjhDfQ0LjxlGVja/P
 XNGkHLOL3vIiV1cQ8z4FLwpSaEyNbCEYHMaQ4RSGsPbN0P/kD13iCees7cZGBsBB0NRF
 zAZ1+2+PTzDGCQ4HnJK3MahadfuXKl52CLVhtuZnlT9ZayilLLyqC88krFti+kcwLueK
 K1Og==
X-Gm-Message-State: AOAM533PVeEy1wezcEFoxdT2IAr4TZ4Ru/vg9uBx943MZXS8UKLCqaAP
 ETliuIP34DqHE/Ar4zCvL90=
X-Google-Smtp-Source: ABdhPJxIKauQ5/S2k9YdkZdOceOZ5X40NyGUBhvUGmNEl2Jyw7ct+m26WVp62Kzf0Li+90I4Kxldfw==
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr2170418oih.129.1598714293624; 
 Sat, 29 Aug 2020 08:18:13 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:13 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 02/16] hw/riscv: hart: Add a new 'resetvec' property
Date: Sat, 29 Aug 2020 23:17:26 +0800
Message-Id: <1598714261-8320-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=bmeng.cn@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

RISC-V machines do not instantiate RISC-V CPUs directly, instead
they do that via the hart array. Add a new property for the reset
vector address to allow the value to be passed to the CPU, before
CPU is realized.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 include/hw/riscv/riscv_hart.h | 1 +
 hw/riscv/riscv_hart.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index c75856f..77aa4bc 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -37,6 +37,7 @@ typedef struct RISCVHartArrayState {
     uint32_t num_harts;
     uint32_t hartid_base;
     char *cpu_type;
+    uint64_t resetvec;
     RISCVCPU *harts;
 } RISCVHartArrayState;
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index f59fe52..613ea2a 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -31,6 +31,8 @@ static Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
     DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
+    DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
+                       DEFAULT_RSTVEC),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -44,6 +46,7 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
                                char *cpu_type, Error **errp)
 {
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
+    qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
-- 
2.7.4


