Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE73C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBD920838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xd5gxuzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBD920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wMY-0006jX-25
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLW-0004wW-8L; Wed, 12 Aug 2020 15:23:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLU-0000SI-HQ; Wed, 12 Aug 2020 15:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260212; x=1628796212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i6TsF+nWPUY4kyBuHNnNc0d363KnlgxkQHE3CnRI+so=;
 b=Xd5gxuzPNipJ8kJPeYTioi2s2yb5BX5ttttn4tG45HiqMBUxpHA+6/G0
 Ds9kEPwhGBvrR+zLgLY1kBAQQ0r06nYQOgFlAbzC2zjxXhHVlKhe5PoTV
 2IyBILGbQdPHz2+nkisKg1DTNmDwojMVlEu7i6QKsTy4TG/mgmqq0ra1j
 NTSJOqsMjLFkfAFxVkEnl+f8x9bRIHTIMe2xuznc+hIjCTYmTMlfR7YHp
 kRdqw1qiCcj1elIp2FcmOeUwK3F0qT5d2sKLJkgbi0UviGRVVrHuwfSN0
 l/vKk3mfHuwdvhjJ2R68Evxb/FQEd4hE8xXh6RxBVoLvmZUHjc5RUgPoA g==;
IronPort-SDR: P/W7JL4aYtEIXRVRLbW9DDDlQQx1TlvWxlxundkXoPqqbH0iswoSYSKj8QTyY+xa4zkagsQbGz
 i9qvuGvmEhaWDsXKnpVF+vkdmDyFYwbLxiREcGkIeMbHXfBSluhPnKqJJK73Q5XceIwsmFF0Jx
 yF19Mpv5ol1CxpYKblQYW899UgYpF3rssc/xvVuElwuNSjtUs2r+dc2uuFc+HV1EBlKoukS8m/
 qbxXRTAeOsZCYxqWQQNliEkXL9bep5/bNgP9Xs0td9YJ/ga7vwbIo5JpMkQAcIZYoMqWQMUnW/
 6Gk=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029205"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:31 +0800
IronPort-SDR: FBl84v5v7N/qXvzKYKCppL8fhopBzNuv47Q6MzQ0T9s7sqKEFDB3ZYOnN9pNty+ZA0iotI+9TG
 GTAcvMu6UXvA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:39 -0700
IronPort-SDR: q1CVShgbAh1DsTxCETgXK7d4m8LfQfWuv9JA3nnNK09Vwn2+Q1xO6UTng9LqtrrmZ08uROlwOP
 Z25IpNxfjGBA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 06/13] target/riscv: Fix the interrupt cause code
Date: Wed, 12 Aug 2020 12:13:30 -0700
Message-Id: <85b7fdba8abd87adb83275cdc3043ce35a1ed5c3.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b5f4264525..9ab3ca4675 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -909,14 +909,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
+                /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
                  * no if hypervisor has delegated one of hs mode's interrupt
                  */
                 if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
-                    cause == IRQ_VS_EXT)
+                    cause == IRQ_VS_EXT) {
                     cause = cause - 1;
-                /* Trap to VS mode */
+                }
                 env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
-- 
2.27.0


