Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B984CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9AB2067D
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9AB2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5QR-0004Fr-S4
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FH-0007oP-HS
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:51 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FF-0008Ml-Pc
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:51 -0400
Received: by mail-ej1-f67.google.com with SMTP id w16so39668092ejj.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKs6X96nXmVGxSBlCnmj0Thw4I4tEtK+nbLrimHWD88=;
 b=V7Y//Q55LYTUuBApa2A2lSPAM2uEg8KtlA1QNXEoGwiRhjoYLhAkzA0nEctRMnJ0SC
 eoByXJV2kDNP4V7cLxjAu7y/fbNBkxndg0N75F4ipJAgv5ydFPkxQ3h5ZJH6KpoLfQYd
 9ShrADqbNPUGMTGiKb1X2L2tJka8vdJLVh24pH9P+ShttXj1rK9nUJlfBIEKs4D1b/kd
 +t8jhq/0JpH+u6QWP2tjAqu3ITQRNmOmUQL5AuhfX/HW+vPPQXgFdpsEGpd+F9Hngm9H
 pZm1+jthDzjKdr/4Jf8S2GDegSoVA+2rwgSFLUgozagX8RI4yNT1VSnRQM+oK1lGsX/z
 A5EA==
X-Gm-Message-State: AOAM532+V05TuxebiGh3doQl9tDxUAXvo5txoPM3bjhmgWFuVcuBzpMx
 nxZv2Kad4AA4/6MqLnACRd4COw/2
X-Google-Smtp-Source: ABdhPJxOE4n/+ThMM7VZAx5r7PhFSuhhtmbrzKkNfJevHvjoBsvBug4U90sDAk+r6RW9y6aeC5GpJw==
X-Received: by 2002:a17:906:17c8:: with SMTP id
 u8mr40463861eje.129.1593957828243; 
 Sun, 05 Jul 2020 07:03:48 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:47 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 28/30] tests/boot-serial: Test some Arduino boards (AVR
 based)
Date: Sun,  5 Jul 2020 16:03:13 +0200
Message-Id: <20200705140315.260514-29-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.67; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Print out 'T' through serial port.

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash Arduino adjustments from f4bug]
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/qtest/Makefile.include   |  2 ++
 tests/qtest/boot-serial-test.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 98af2c2d93..994ac47399 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -66,6 +66,8 @@ check-qtest-i386-y += numa-test
 
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += boot-serial-test
+
 check-qtest-alpha-y += boot-serial-test
 check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
 
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 85a3614286..bfe7624dc6 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -17,6 +17,15 @@
 #include "libqtest.h"
 #include "libqos/libqos-spapr.h"
 
+static const uint8_t bios_avr[] = {
+    0x88, 0xe0,             /* ldi r24, 0x08   */
+    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
+    0x86, 0xe0,             /* ldi r24, 0x06   */
+    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 */
+    0x84, 0xe5,             /* ldi r24, 0x54   */
+    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -104,6 +113,8 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.26.2


