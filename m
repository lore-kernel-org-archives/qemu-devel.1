Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BFC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D857208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bFkij243"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D857208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNCg-0000CR-Ai
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsU-0004me-Ov
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsO-00029Z-Nv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsG-00024S-1L; Fri, 07 Jun 2019 17:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944692; x=1591480692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZNZuM3ud4ewOehFF1pMa8/aEmQZhxIYKzTI2uUUFItQ=;
 b=bFkij2430sEOCjavXg1LHf8IDPLoNVWZCz/u2QmayKSjXQsrDBSqZW5X
 GYOPMEcfXqXb6Lcms1klVchtIpS4LrWH4TirencbuuLjCrbbWxIqXl2uQ
 Wblr5NH9wdICrR0UvKpxTPjn56XEjUsupvG7f8YnZ/2ZGUAplMcfrhW2h
 wl0h8R74p4NegqTVBKjTx3iSEYkFKXXXWzwdFmKEhfdAKe65xGwGpnClo
 sb+SiOEtm3HIeQyef/G3qXeNdIo3PD+do1eJZLAZZziahEl1FogVu9fEM
 beeIGonlzbyV8eOUJ4xvI6eWKAZbxNWdvKwg6Cs7R0/YqfOGbsobXZ/7+ A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="111342556"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:10 +0800
IronPort-SDR: jXRCzu0xnO4+Q2UYqgsk29fQqPJIpcRpRA+D+j1e4W5WZ4DV8TKACy6RPXf2NIJZjAIzgQGjBV
 KPqYqItxnwZnPwfK6eQrPKtysvnEMNGj15PSsjYebCJOMNtAWz/r9g26Vnx6FPOI7Azpq5V15G
 PSTOGGZQ7/9V3/sBXRR2AE7ycS202rLo/QbbiN6C3r/JHWIiTasGlnJKPJ/Kfz6atnawGtOsrc
 wGhXPR4k4KZ5Eh2f8sLn8qwyfYyjeKhzcNLjai2bvhMw2p60eyFlHicPgF2ktMfA2+POoQ+Db2
 4HnNWEXntcjH4uEFOKBgOYTA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:03 -0700
IronPort-SDR: 2Mltu8fGOnGDyPD0nFvqJBVMWGC+6tsww9g1n+UY9HlhRmnW7lGSTuhbht2dO8A7BLTJ9fU+eA
 7xQIejRN2pYIy6dDlefq3Vo/BGEwcgmpsTyY1CUqQSbGgScrCCne/649F46xSSAaecDB2rVt4I
 w/ph8DCTZtxEgPuMPkVYJL7a0VghOJ2AHUluudC9t1CGh/1BkCIGS7DiG5f8lBCJaMc5TPzJ69
 cmN6pH4kIR5OOTGHAGZ4TRcd/pBS1NKUwK6doNqza4CFcneObDgB4e6YAWk3wr2Ip3xgKjNemI
 pN0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:10 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:00 -0700
Message-Id: <c013a5c4e2edf4130c492e1a2a16447b6901c143.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 13/27] target/ricsv: Flush the TLB on
 virtulisation mode changes
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5e5029ac0b..6d6fff83a3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -157,6 +157,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (((env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT) != enable) {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+    }
+
     env->virt &= ~VIRT_MODE_MASK;
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
-- 
2.21.0


