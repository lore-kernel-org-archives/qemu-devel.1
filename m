Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F63C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7922071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwvwCLxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7922071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunMS-0005ao-TV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD3-0002s9-Ua
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD2-0005s5-Oq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD2-0005qB-IS; Thu, 23 Jan 2020 19:52:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so74859wrh.5;
 Thu, 23 Jan 2020 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OnpC27SyHpc9dVU+hh1ArBidC5H9rjuvClffq7/FDC8=;
 b=hwvwCLxk2IP66snNmc+W/Xk5+sQCQyEf+KpPefyG2m0hkWVCe4An8F+juz+kSSRCKm
 VX+HFRl4TdTcyHTkgjzMdaPb1h5tKejL35kSET1kMCvqAJY8H4qEgkGl8lkcltyZaWlD
 UduG5OkIgbNj1ydO/WTRK2G3l23PEKYSj7qa+vErDfN3wfP8k7WZ5cVa0czSkvsjDGy/
 4dQL4kzoTGKtf6HJ8yEStaiHtmLnV3tA9/rtWmyasb1rq9ADybAfSsfpRlTfySFoAu4t
 NtPJPaph4NRyWLWnRCW+17ClmWH5ZHKZU8czejHDjGeIaPOiJ/jvL3XM47pLaW8SWPeq
 NS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OnpC27SyHpc9dVU+hh1ArBidC5H9rjuvClffq7/FDC8=;
 b=hojdhJPrqnlI2zQjEwqXbgWGfd4g+sLmHcbrArBNN2aiyfOEbwBeNi5DMtRwhpPjYf
 AtaU9A1InF8jAZRWKqoa1v0Raqnn2dciCaE4W7+yao3kQiUWAU1+WUS4p6ZPr1YctyVi
 fLiC028QrSMCSBSLwTYYgonXVvr4CbOxl4RBeA8UFNsClMA58V9OmqXeF4TEg6q1iKZV
 /xe4hARYj/OCiVsJbR71cGLjlNcjXvdg+Nle3yvztjKbwh78uhi762jlX7S1aMVq0T60
 zQABlSWd9ChqnfKNJs3Ldrj5kteZipA7qrvQDlc2A4rDsS13zZo40V6UXzIwKu7c8CFL
 p9HQ==
X-Gm-Message-State: APjAAAW79EcItGL/HoWeXDkNy8XkbVsZrVyUzvkLZ+nUWf+FBf31GSBo
 z3FswfnVfwmAHtDDUDGFmSaHiZB0
X-Google-Smtp-Source: APXvYqwUmlBoRNZatAROoWt4+wpBIH2e4uoi6vIhNhlhPIOE1C/fSwCvjq91zXCz2c06wD+M45um2Q==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr883164wrt.229.1579827147338; 
 Thu, 23 Jan 2020 16:52:27 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 23/25] tests/boot-serial-test: Test some Arduino boards
 (AVR based)
Date: Fri, 24 Jan 2020 01:51:29 +0100
Message-Id: <20200124005131.16276-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Print out 'T' through serial port

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash Arduino adjustments from f4bug]
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/boot-serial-test.c | 11 +++++++++++
 tests/qtest/Makefile.include   |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 05c7f44457..07067b76a2 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -16,6 +16,15 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
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
@@ -103,6 +112,8 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index e6bb4ab28c..4817b6320f 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -65,6 +65,8 @@ check-qtest-i386-y += numa-test
 
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += boot-serial-test
+
 check-qtest-alpha-y += boot-serial-test
 check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
 
-- 
2.21.1


