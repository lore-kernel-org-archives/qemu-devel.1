Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F90C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DBD2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1cqeXkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DBD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunIK-0006M8-Hn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCm-0002Js-GA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCl-0005OC-8C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:12 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCl-0005NX-12; Thu, 23 Jan 2020 19:52:11 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so56765wro.9;
 Thu, 23 Jan 2020 16:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ormNrU4QuMELFLz7w7TvNiNHbcWJB29mFL8p32bEHnA=;
 b=i1cqeXkW+lbcJG78FGlAClSTtLHy9n58Zpggb9RYP3j3PGtTmFEmrJv279mRIk1TBk
 WIWclesUqBfZzUAlyZQf++/1DYRhYKaeaCnkmkrDRGhvir7Np5YS7OJ5WJEGF8CnHvr8
 G9GiJIgdvnmxdSNBSjJKycmKyPXs5yw3ZYLFjVxOdOzLaUOkNBkPARwoFUW4WfVvRf7b
 6p2C24LxwwFP5n8epPOi7ryQBoMH0kA3gjE8pHGLQmokdY6JZZs7JaJMQHJAMzpRWRme
 mzw4bad8/KYBpAQJvx+2Wt69OFT6NAlFCnEOIB03KmUJ0bfKjTf7/CX1KxeUpsmfPmu3
 qTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ormNrU4QuMELFLz7w7TvNiNHbcWJB29mFL8p32bEHnA=;
 b=J4KVHqVTYitIZsjm3Oxd4KGCezEXb22trXrh6sFk2ns7b5KZjuotrDE6B3qz1Z9wza
 VRtOluaztMnjPZmNVC/GbwMcV3sdM7KyOiyCertPpAzuIRzyrNpd1uQ3b0lZ5Te8w/kf
 mVPeCho5qcI0gnpFAoeRKLPb/TI2BL2EbWZP5noHdkH4p7cfVX37FlA5dSkYWVGGihTD
 T6i/mv5+cRsfebXRjLdU6jVT5ZvhgQGZ1iWjhogcgs41FM84u4FTgv1Ose9XXeYGshRv
 2gNMpHOF3/wsLBNySGwg9PMNboyuCGXm+IHqTP31gv23aH1UAtf96W9fRnDaz+9Ri6w8
 VJMQ==
X-Gm-Message-State: APjAAAUQOZRN/F8Y7M2eQN6+V3owHEmfaJ4BmW16y2y4//hfUujAcwaT
 fEdY1ajFwWmSQtwcdp2T+LN0Ss7O
X-Google-Smtp-Source: APXvYqzegLvZ6Aypa47T0ObiH/yHmgjL4DD0U1SWaBEz2/I0Nth8oeoGixoEzN6ahlKsWK4rb/Pefg==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr852408wrs.224.1579827129711;
 Thu, 23 Jan 2020 16:52:09 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 15/25] target/avr: Register AVR support with the rest of
 QEMU
Date: Fri, 24 Jan 2020 01:51:21 +0100
Message-Id: <20200124005131.16276-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add AVR related definitions into QEMU

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200118191416.19934-17-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/machine.json          |  3 ++-
 include/disas/dis-asm.h    | 19 +++++++++++++++++++
 include/sysemu/arch_init.h |  1 +
 arch_init.c                |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index b3d30bc816..f2dc385167 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -21,11 +21,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: since 5.0
 #
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..79bbc8b498 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,25 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1       1
+#define bfd_mach_avr2       2
+#define bfd_mach_avr25      25
+#define bfd_mach_avr3       3
+#define bfd_mach_avr31      31
+#define bfd_mach_avr35      35
+#define bfd_mach_avr4       4
+#define bfd_mach_avr5       5
+#define bfd_mach_avr51      51
+#define bfd_mach_avr6       6
+#define bfd_mach_avrtiny    100
+#define bfd_mach_avrxmega1  101
+#define bfd_mach_avrxmega2  102
+#define bfd_mach_avrxmega3  103
+#define bfd_mach_avrxmega4  104
+#define bfd_mach_avrxmega5  105
+#define bfd_mach_avrxmega6  106
+#define bfd_mach_avrxmega7  107
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..893df26ce2 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index 705d0b94ad..6a741165b2 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -89,6 +89,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
-- 
2.21.1


