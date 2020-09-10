Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2964EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87593207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cYEdXf7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87593207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRHQ-0004Mp-Hd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBM-0003kv-Lu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBJ-0002j9-O0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762025; x=1631298025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DcSFJxbrWZPewmkc1peDcd+g7R2g60jkbjy/rJ/vb90=;
 b=cYEdXf7bKNKNxIQc9R9M7Xk8wca/nol08AlzdinP0ZDZ1rc45cj2obvn
 BsDCFFhSDVDMEvQ+Mno+0AvO6Q7i47/xazuPEwm5nhAMCmsfb4YNryuFJ
 mLmx5uTzF7vXEOKuNnfPQpOAUYjFdprvNIccg3JmKUw9VinNENtNYlqvF
 oxv9bGFkDcpE+AZ4DDa3Ap+yGx0RnqhRRR98qPoj/DYALmj4UtoNdNmGp
 5lcBTDwYB9ISo1sHAaszFtCwX4TDPEHc61kLesRIitJcv3rduL4jAY8e+
 J+PXWOiH1vZBpDyWWAFbzNomEpXkpVVZEgLQJg2cUTnFzbNsgmKOqYdRn w==;
IronPort-SDR: Covi7HhwEQBCxizNKuoOrgNeVZfGMpBmSkjo8eNYTvxDnWYWqIp9g45sQt5wNKfJ9p0NdiFIGV
 j+0RlvGFVFjWmUAgs9CaJRpPh9/p15Im+nCwCaeBeADA40fAdrH1CXar9lhmYm8OvzAEIbS4iP
 5RtNVDZqLX/f88n1JrZCwJFLFVJhnNqGMTbz9/iyXdVu8jJ4x/I6+0T6Q7hPuZAGBFIQIEkbwT
 BfkF+C1FpSTc3mKH2664cvmfCe5PiASELn9+KNyI3n9yDzIL21tnklnR3Af1byKrmAZ1diIlkm
 f+Y=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979212"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:15 +0800
IronPort-SDR: ivkWtxuyyHGkcFb6zl0K9jFCDgBC7LbUpKh2QB7zp7aN3gKHdjWmfjiE6Na6Vcthd4MJGNCcGE
 DJXOm0fN6ajA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:32 -0700
IronPort-SDR: AoyJV2PXrZHjGtxiAwVKaXX6jmNkDdwLV1vhEn67Ks65Zsv2LGtx/znHQY4kMIJh4r+69o4dDK
 ZuR5pbV3AH6Q==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/30] hw/riscv: hart: Add a new 'resetvec' property
Date: Thu, 10 Sep 2020 11:09:12 -0700
Message-Id: <20200910180938.584205-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1598924352-89526-3-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/riscv_hart.h | 1 +
 hw/riscv/riscv_hart.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index c75856fa73..77aa4bc948 100644
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
index f59fe52f0f..613ea2aaa0 100644
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
2.28.0


