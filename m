Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4081F20707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOPnp8XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4081F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvK7-0007jq-F2
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHn-00044X-81; Mon, 31 Aug 2020 21:40:35 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHl-0005Up-Fd; Mon, 31 Aug 2020 21:40:34 -0400
Received: by mail-pl1-x644.google.com with SMTP id l9so2503029plt.8;
 Mon, 31 Aug 2020 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=As6XYe9jhFVqGZbNvmQD6KrpN2QvPQQgwbIW8SC2EbU=;
 b=TOPnp8XIu9hofS0iZW5wp8viP+ici1EcLs3p4pjlU+uQi9C++L+w8mey2Dtoj5yXOB
 0+xQ1UGtkWKQ048g4/8mH7cC4NCihb/XO/IxPCO5cR3Hea5bZPaRe5VYjx3c3eOfi1K0
 mvvpJQK7oDcL8v0lr0kxSsyJ4MOdBp4R3nfd0oUqkM/TemvI6Dy0HDKQ3s20ZvYgpn4Q
 m1tIJ09G/aoCdTgQjQ3MB/LRg7S/KRmaMDM0eZj1nXu4G07rdo8nui03SGUh2p4CIJJR
 vCRKNGViVzZbFcCRyg/+cce8pQR6mciivjZkhucRjuzTpnAZJhdB51428VRNSNErLQMH
 XwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=As6XYe9jhFVqGZbNvmQD6KrpN2QvPQQgwbIW8SC2EbU=;
 b=FWbOenI5BuWb+1uv/Um0vSrZBwND2TmlW2doo+dTvaiadeNPpIy+BifLFZrLXaAROv
 l52VW78YLV72te6YxXAhrZKmSDEJ+CI/eDn/cqdevcQHhpxad2zeuOmrSlK7XLizOQvt
 u/Ey58kjnhik9MTFUEKqJPJRul9M9DhpbGNBR+Qn//XuRiiUTGaHAqbF+asp86sbco4h
 1mgKclir2q5U+j0EgZVIRUp12FUpPJ93oyqVTiEraxc1J4wanr73TG7b9JwlbK8+hKTb
 0hkCtvopw5n7bA9TTWh7E8pWuPNEMSJ3s5BUIrMBIgFhVlGtpHbvM+iURN31SBu87zje
 X0DA==
X-Gm-Message-State: AOAM530aNMuBdo8/iUxFGYSw5MDBQvOAQw1M0w7BBeFkqVPrMmgsrQkJ
 +sbEHGcog8kUDcybgjINnes=
X-Google-Smtp-Source: ABdhPJzwkl2KMgZ9a6yzq1zJMXLBzOncCmwoGvBzS9Y6oHyaVx6ehDwNF0F0AJ5f8YPPFh/1K8VhAw==
X-Received: by 2002:a17:90b:110:: with SMTP id p16mr994714pjz.98.1598924431656; 
 Mon, 31 Aug 2020 18:40:31 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.40.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:40:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 02/16] hw/riscv: hart: Add a new 'resetvec' property
Date: Tue,  1 Sep 2020 09:38:57 +0800
Message-Id: <1598924352-89526-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x644.google.com
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


