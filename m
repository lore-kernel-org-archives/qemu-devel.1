Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B681C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B1720873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0V2dexG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B1720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQefT-00072g-W7
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:09:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV4-0007lu-PB
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIi-0007W1-I0
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:30 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIb-0007H4-Pi
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:23 -0400
Received: by mail-lj1-x242.google.com with SMTP id z1so510734ljb.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hm1pySXCYRyqzKQMsacqw1+6viA6OKMUTJF5TynmyL0=;
	b=S0V2dexG17iC1iWmg+LukVUPWeX1ZOy5gO3+sUlQ5TK+8MjfHAKuNQLAG5PCIlMBgs
	jt57yZO9B2RFndZp/f+URFr6hNF/CpO4IrLtKhiqV7EZlruqXoIHMd5PLHeupxO17NgN
	0Kw40ImRwSgmCdgNV6YXvhYZnPRNChGeYtIZy99r8ajeSjECTY/RAr497duWK6Ii3Lcm
	pUVO3BWJX4Cww8rfzaVaZ9bx8Sck/cH0vEU4ucEOcVBUIdUuoohul05328F4e2p2NfSt
	bOgK3Lw4nBfc9k+PX15M7hgScwKmnGq+bmOibsk2B1C0N7kzMs4C7upNPihwN9wVlT5g
	c7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hm1pySXCYRyqzKQMsacqw1+6viA6OKMUTJF5TynmyL0=;
	b=eou27rs+Bm6wodf5ffh5D2sj2T6Xbc2UbPhSvhEokP5GAzcAOt63eygjKPgOymgL9B
	npFvql53cHpRGQJrRpWXPObRZWYg422i0Tnjgd/nonfUXnwnTJUMyCbvWszMi/mVZdQY
	9t9+B+IwMZ/XC+L+cfRrd/bFvWADW0+TD42wE4UJOf+xUrWqCjud7uj1KJvy9xGS9my7
	So7vw1xKn+UIGdtudIfoNye8pWltlhPjtb1cJAQxcOambilFjXLVEm0t7ZOX2Wx2ZXOL
	rjPYPPjf8ngLE1paPHaBYKd/gvd6vR0/ipQZkCEYzHREblYw+hdycDInWKPXIBlApRna
	wBkg==
X-Gm-Message-State: APjAAAVeaczYq+QlBh/p5o1HWWwdhiS7P/bzBz2UZrhhBZR+mEeLbiR7
	ZF5pvjid9IFYBBOoFPxMIj5X+12RgOQ=
X-Google-Smtp-Source: APXvYqyR923CIrLtuXBWFXuI2Fa22yH/Ancp6Sr+NSy0RmG6NtMMSuJTCHfWndqKX1e/GVLOasKmew==
X-Received: by 2002:a2e:9a1a:: with SMTP id o26mr3344579lji.174.1557866716300; 
	Tue, 14 May 2019 13:45:16 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:15 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:42 -0700
Message-Id: <20190514204447.17486-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: [Qemu-devel] [PATCH 4/9] target/xtensa: add parity/ECC option SRs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add SRs and rsr/wsr/xsr opcodes defined by the parity/ECC xtensa option.
The implementation is trivial since we don't emulate parity/ECC yet.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          |   6 ++
 target/xtensa/overlay_tool.h |   2 +
 target/xtensa/translate.c    | 162 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d4258fcc6199..74ee7d125360 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -144,6 +144,12 @@ enum {
     CACHEATTR = 98,
     ATOMCTL = 99,
     DDR = 104,
+    MEPC = 106,
+    MEPS = 107,
+    MESAVE = 108,
+    MESR = 109,
+    MECR = 110,
+    MEVADDR = 111,
     IBREAKA = 128,
     DBREAKA = 144,
     DBREAKC = 160,
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 8b380ce5e329..ffaab4b094cc 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -112,6 +112,8 @@
     XCHAL_OPTION(XCHAL_DCACHE_LINE_LOCKABLE, \
             XTENSA_OPTION_DCACHE_INDEX_LOCK) | \
     XCHAL_OPTION(XCHAL_UNALIGNED_LOAD_HW, XTENSA_OPTION_HW_ALIGNMENT) | \
+    XCHAL_OPTION(XCHAL_HAVE_MEM_ECC_PARITY, \
+                 XTENSA_OPTION_MEMORY_ECC_PARITY) | \
     /* Memory protection and translation */ \
     XCHAL_OPTION(XCHAL_HAVE_MIMIC_CACHEATTR, \
             XTENSA_OPTION_REGION_PROTECTION) | \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 100d6e126590..63a90fdd17dc 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -4216,6 +4216,60 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "rsr.mecr",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MECR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.mepc",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPC,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.meps",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPS,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.mesave",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESAVE,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.mesr",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.mevaddr",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
         .test_ill = test_ill_sr,
@@ -5036,6 +5090,60 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "wsr.mecr",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MECR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.mepc",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPC,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.meps",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPS,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.mesave",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESAVE,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.mesr",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.mevaddr",
+        .translate = translate_wsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
         .test_ill = test_ill_sr,
@@ -5702,6 +5810,60 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "xsr.mecr",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MECR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "xsr.mepc",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPC,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "xsr.meps",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MEPS,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "xsr.mesave",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESAVE,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "xsr.mesr",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "xsr.mevaddr",
+        .translate = translate_xsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MESR,
+            XTENSA_OPTION_MEMORY_ECC_PARITY,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
         .test_ill = test_ill_sr,
-- 
2.11.0


