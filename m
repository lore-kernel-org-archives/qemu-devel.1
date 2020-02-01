Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F1C35240
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DFF20663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxThINWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DFF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhZb-0004Kf-Ao
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIf-0004Wx-FX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhId-0006mZ-0Z
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIc-00069K-Mh; Fri, 31 Jan 2020 20:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519414; x=1612055414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Un87p05BHTC7q3iYM5JGl4ck5VhjcF8oqmPMHOJ6FRE=;
 b=dxThINWCCHYoVkw7py1OZ4oXcSkN0CexyAE0+3YvN6CWtRJjp8FmQxhr
 vBnR8iIVja2VZjYfxugdv3WCdTj8NkIqC5zDt1qQ7Tp6Lz30WmvAKC9q1
 4jdg/tEZVhtYyxug9Pv2muUmpmOEMdwwlRebGIqjBaXQ6MwuaSOvP/DJe
 vKVbLLjGdU6+yRR5sMfR/pvqKpXSckpXNfynP0uOUmLkn9zX2I9wM3PaW
 EV6BLs9wEs1bhHsRsnwP/qqK3rVifKsEvNVTPjCajN8vbp9mTyJHLOfdP
 Dxqk5UYuwf3OJBfsXkqc54+TVdWGlG99TLULng9T8UdnbKupR0p/p8uV/ w==;
IronPort-SDR: 9y38ktyTDgU+E+J2yMMKfIu7pbVw83QtnWVIjfj62+ty0PkmzR+viz0wLxssdrJyQTGv5F1g3B
 1IMErmh/snHMgvpbyxk4uBRsqEwgdq5zoFUEAJvq8J//aKFgFAZ3WFzPBVhQmhL8kheQZzMvHZ
 shQDWj/c9h8aI3ffy++Ugzj2iQ32Tfqn6ayv7iRsuf5fszs5Wzaa9PkqSjLHUYzCRa4YWEv2DA
 2ctMA995uzYhAMDxwHhTb31evLeUQYSmLyExV9k8FK/efVVQp4MAmf+3csDepSCY9EOzkYIa6D
 CSs=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872486"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:20 +0800
IronPort-SDR: M7nvFXEfisRLhi9RhGFdLHZ1F4BexyFo0zUyZkkUyhWGoAgMhZ27LcYTs6VYkDU/b6AJRtrUqb
 zxLfSpG1Ts9M9ETTZ7eOhrZvqR2F+eQzq8oiTdichuGJA8LzZEW29RJXSJ+6sW/qH5JFLATDUf
 QXg2j0Rp38lJgp5DyeqtraVyq1nMjwVKBxhJMHTHzxp2Ei7wnHj5bNeYrIq5NjnO5zTQke4Vpo
 TEL+RY7uFjRdKB/qM2v612Iq8HIzPd9Yabn8EBELhnhZFsMAinM1wTQQwjirw76bDVjK01zKR3
 hk+X4B9iu0FU4/+Rvp4QNYWh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:29 -0800
IronPort-SDR: vzJ6EMeryOGQXVk4PbmP7LkX14j/9exVGiRcCApSy0sTS7LqjmKOkbVXKEotwAYdVnAPEwQzq2
 dvKcPOUwo7fOkGmoKB2/98FU7HVG+JamwQhnvJhFli+xfBdUDuo1C/5KBxV+RGg5bOW+Ho4azz
 hfcY2NMKkv1x0lQeXnDIzRo/vmJdbCQOEnNxHMwHlcR0WoOefmAK/ImBoV8HL1U8pnRsKWLvyf
 0uNnPannvO8Q4SIjqqp1tfi85bnF6J+YzyC9NnydvT3E56gqDbzm0WAQ+7qPxB21F4YeGh7Mrc
 Dtg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:09:20 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 26/35] target/riscv: Disable guest FP support based on
 virtual status
Date: Fri, 31 Jan 2020 17:02:44 -0800
Message-Id: <af25bd3f009f8f73b43c91ab5205bfcb9d28666b.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the Hypervisor extension is in use we only enable floating point
support when both status and vsstatus have enabled floating point
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e7728cb0ca..827a38324c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -99,6 +99,9 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
     if (env->mstatus & MSTATUS_FS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->mstatus_hs & MSTATUS_FS)) {
+            return false;
+        }
         return true;
     }
 
-- 
2.25.0


