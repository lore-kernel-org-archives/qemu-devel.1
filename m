Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6540AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C00821527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g1K3Wu0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C00821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzSm-0003xz-KH
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyt-0004Ii-6J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyr-0001Y4-9G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466869; x=1635002869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2mb5Uz+f+98KKWE+4ncQgKVHsa+GuxEN2KmJeLlwP94=;
 b=g1K3Wu0Q5ARK7C/hfOS7uHMEZ1LwrL4nyTSxmau282ZIbb6AHtGGZ5Y2
 miACT/bA1T7HtmSYVw/oBjuNCX90FxzyF0EgGx9g0rPb/O9rqeAV2P+8Q
 WrlRRkpFZC//qBNjzw0TiRPfFpuVzrT9XQiz6Pl7FcyAv23kJ6eYjb1A0
 OAIWQG5tVXVzWraI7iEUIlA3DfrarC3cOdOzUIF9zHhryehW3Qu0PoHuu
 Y7oqIX+UIVMMDy17IwIpuDzQACInN6aeuglOsB395JHhcWS2hRw9yHW3G
 lNSy0G8QJFa1DqqDnU9jz3lLFyRVchjkqM/U7zG5kC4z3MFq0ftqlg7lH g==;
IronPort-SDR: BGkZjERc49T/3LjmdOxAK3BTAyCHGHuAAyWgBKfiPj0f4xGMfUHztIiF7ot6tKG9pJNzwSjKIi
 eOReDN0qayosSC6hRVjSdVp9A8sUF6x46LH1I0tADxDjshC2CPMIntMeUly+O3fc1b6bTpJR1m
 6lsaPK/tlHm/b0yCqUoASknkNuBUgzfyeXg+QHdnYXFeG4OCmX7D9RR8fYIlyNRCHlZH+pnT3T
 /LlLyoufY1J5ZPcpZ04vfxnScZDG+MrvwYXTyqnBm8WMchUaCotXpWbEF3uN5cEi5XzAghZZ6b
 UPg=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652320"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:43 +0800
IronPort-SDR: zI9NjwApgkaX1IPmatZd/vSvGMCRrK/lbsCeQkY9R2VVHTME9Y77AwEbQdqxGcKT1RTnmULxPj
 G9tuZfqTPd85sknPD0R3zuzIjwJeOkPsOh5HLajy9lIjbtZGy9thiWXwSPzlwMA/8d4t3lIRPQ
 qa9iwHuPgYOTcFQEgzny8eAav6GynlfwEAnxKbC5bpQQ4XcP5vNPOqrowhlOKmDAGaGdCUf/yn
 k1dvELA8TqVZH8LG2xhGlUhs97C2Btu13Ch/4jsz1Wd2z9JrUwjdUGhn+o9DrpmS6GZ2Pa5gq9
 OJ0xWcutWwuxw/cGZ9v0/KSq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:58 -0700
IronPort-SDR: XBw71uOThxux0V+eQRurenEtIy7aoHD3nGMv62b9FUubXCGtMVr9RiV/4XJrMHvIRjYM0BMQCM
 WLdTn6UZcSgoLdxBssInOG/76sgRbiJ5/O5+TDOk80TjL6UNH2sSOEl8/zhlFDANbW9iybukqW
 Ol9HrinSd05m18Rnf5i8yp23NKStzgifWF3mYIQszVXSKjGm5g1hB12DA0TU7iZvIdqpCX7Cxs
 c88IT86xKwEdnUMAZrP3avsjHKxjQ93Fh4fFimmVXu5W2lx05KbXIyAdRWQK6brHrr76UaKNGb
 b3w=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 04/12] target/riscv: Fix update of hstatus.GVA in
 riscv_cpu_do_interrupt
Date: Fri, 23 Oct 2020 08:16:11 -0700
Message-Id: <20201023151619.3175155-5-alistair.francis@wdc.com>
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

The hstatus.GVA bit was not set if the faulting guest virtual address
was zero.

Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201013173054.451135-1-georg.kotheimer@kernkonzept.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 47d05fe34c..f363c1013c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -852,6 +852,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     target_ulong deleg = async ? env->mideleg : env->medeleg;
+    bool write_tval = false;
     target_ulong tval = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
@@ -873,6 +874,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_INST_PAGE_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
+            write_tval  = true;
             tval = env->badaddr;
             break;
         default:
@@ -910,7 +912,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
 
             if ((riscv_cpu_virt_enabled(env) ||
-                 riscv_cpu_two_stage_lookup(env)) && tval) {
+                 riscv_cpu_two_stage_lookup(env)) && write_tval) {
                 /*
                  * If we are writing a guest virtual address to stval, set
                  * this to 1. If we are trapping to VS we will set this to 0
-- 
2.28.0


