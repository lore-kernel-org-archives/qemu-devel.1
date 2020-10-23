Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6FD2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bd/T0e5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6FD2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzWL-0008Pw-JC
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyys-0004HK-3d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyq-0001Xq-4y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466867; x=1635002867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KlL4/TccFf5vxuzV2NRnKp7iPznMCUwsa6I/bO5AZFM=;
 b=Bd/T0e5PBr4c6ftak/672zHlun83sQh2m8Xv1k9hOl4PaqFzVrgk3DRp
 ak82hcvueptEm5p7/pkGWVFD5gFXKa75sXLDrNubbVBWqRTRmbSIoH7P9
 wkDJXifcthadX6yfEAxjuT20ARdd+iGl8ne4R6faSd0uvlOGiLuRxk+yD
 NK9h2ABbpWrZCCFO+87W0ApBmFXa3dW/Z8onCNepNNyADBv/HhkbNDFQx
 YSEcVmeLuZy4uy0/3r3lXZ3VLlRHMsWJxm1ae2c46mcRG7NAOGxu5rN1B
 TPUZijRYLIsnBX8H1qhDhNmmrhLBKHKUvzZhoQu7cqQswXKjScJKzCR+U w==;
IronPort-SDR: Mp5KFvAjXxWZq4m6gFxvkSa/w6a/OFQi9TXN/xiLy/lw44k/4geI8iChv3C0IUoCBf6MtgBkF5
 6LYAP9NwBmvarRI8VsPeN0BgvSFFka0SuerIwQL8Z8909BTmzpdzYMu4l9hNzPoBPE3v8Kl6Ja
 Kd8JXi8q/xhn73Ar2PSqTBmYCK887QqZ5DUHRYlvxR2UDuJYVKwp/6BYzqZlxsK0HTupNXhJKM
 UUNx0UuZPoSHh091dmtJ9aGf7lzFRSzAsj521S2ggS+eVijpA8v/h4LxyoYWz/OGeU5T93PLh1
 Fug=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652319"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:43 +0800
IronPort-SDR: N1am2D9oiOY9eUuVVvip+AdisqgQUHFFay+QwN9Qtp4kVnjpNigzGEFl6+fvrQukCf55eEkWTg
 fd1J9deEiWgY0aZ1z4DHBvu2teQ5MkQet3kL4vJMfG6yp8yzYQTBj9e9PVsxBblvdTP8orK02v
 NmB9ZQEODTo5pTabcUxauv5dGgI55zgStagi9PYPWM4MPwiPGSudO2YHOAlORAyuqL8ubv7VRj
 sTB/TOCdh3KS7zCEZbjIGZEkuiIosY5UF6uX4Su/3qgpHaY+nw3j0MfMrhWAz/9/40NvYQLKlN
 kV9v8LYwQC4zuQVs+GnkXUiL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:58 -0700
IronPort-SDR: Egof5XNtYD2OcWUuhYPQFelEAVOZWyhjoyaSROwmiFJGBy2B1R+tNtk92OOzf1d6YHDnMZuwdg
 czetI/ppoPQI8kBAJbQw7XREkKQY+UkKkkCzLNwu6MJgGx/YAW7kkkIbSm8Q7cI2Z0PfKgbgHx
 Te7eDwe8rwApYzOb5oEMWtXvyhIM3Ia6CWr0zi/dxbLXCktG+JehAlvQOJWMXGNzALLOtAXf5R
 yAyteXMorg3tt29fJG2lPKtp4FBWSneuRIvpzhpZPMriZWEdA5cXGnBFFngukqmdkSfmBLV8+L
 5MM=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 03/12] target/riscv: Fix update of hstatus.SPVP
Date: Fri, 23 Oct 2020 08:16:10 -0700
Message-Id: <20201023151619.3175155-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>

When trapping from virt into HS mode, hstatus.SPVP was set to
the value of sstatus.SPP, as according to the specification both
flags should be set to the same value.
However, the assignment of SPVP takes place before SPP itself is
updated, which results in SPVP having an outdated value.

Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201013151054.396481-1-georg.kotheimer@kernkonzept.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c68239a46..47d05fe34c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -938,7 +938,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
-                                         get_field(env->mstatus, SSTATUS_SPP));
+                                         env->priv);
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
 
-- 
2.28.0


