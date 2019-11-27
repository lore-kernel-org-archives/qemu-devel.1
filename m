Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74738C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443782070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWAY0P4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443782070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1lb-0007Q5-Ry
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vw-0002JM-RJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vu-0006pp-Sc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:08 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1Vt-0006mK-1r
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so27743612wrr.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=DWAY0P4CfnOWrbyy0ck6c6WF67UEk8kemjpQ7OCkGabCb0nhwHBWoWgDKtaPyU1hTO
 oHD/iBHawvjXWoH6mo1MzxtnNxUxBSchJIZvGHLeMGxhHwrlPQVdeXMRT8jxegcSle66
 6+KJtrTbeNBhXddtrXqAFPFkiKCtoM7DkswBgquwpjB2aXhG4Z02Cge6JFQcw23yuNXg
 uEpmqBiEvWF+gqtM4FZDUS0RZWAvAySE7Ur5p3AVI9+RQtsmLpmyskU4jJ4wIacGfQXo
 K35sljajf7Sw4MbpRscpTvAWoi33ymkkPpShdHREOnbuJRRN5SSOsimgdkCQqo4X/BiR
 OkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=jLZMVYIYRNhlL8Bl07QwP0J9Y0K1VfhcyYt0yNyiv7eG6piCSO4UTlOg3QwmkmAREI
 //Cj4JDM+mAAUpJ66nyZSPldNsyV7hcERHYELMigEwXZYjz8rcMv5baFlK00jbXHRFOb
 BRYz8pSuHrK6cH8AjqlXPmC352FzpsDUNCt+R/y1W0nNFITUbyGCs0RgD9kgU7rSRwel
 iHLe+T/F0s2yIWwnhG6zjsRhY1VNzSmX8FUhE10g4lcWvl90YZTpY3KDtaYHnIJjjm5b
 /oKLCJUBIfJ4VQHTE056Wx6MGtVdgNyAJwH/QYmCyMzSrNAivwJscp2TMjLvuELeP4G5
 4OEg==
X-Gm-Message-State: APjAAAXxny+NeTNgTx+Y9jqewwXhCZEI/yqeHNekb0hdkGRuVvCEjueu
 49nzE5hYPztU+4ApZrDdzFFr2QgLU+33OJiG
X-Google-Smtp-Source: APXvYqwRdKFKmyAEG2qc/w/cwmd+DnqXncqhllEl41xZGJkmfeX5xTLOReAzda+1FaDse1B65pT0MQ==
X-Received: by 2002:a5d:6b51:: with SMTP id x17mr46091435wrw.148.1574877240318; 
 Wed, 27 Nov 2019 09:54:00 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.53.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:53:59 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 15/17] target/avr: Add boot serial test
Date: Wed, 27 Nov 2019 19:52:55 +0200
Message-Id: <20191127175257.23480-16-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Print out 'T' through serial port

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 10 ++++++++++
 tests/Makefile.include   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d3a54a0ba5..1121ed0db2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
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
@@ -103,6 +112,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..3e18e5770c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -208,6 +208,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += tests/boot-serial-test$(EXESUF)
+
 check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
 check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
-- 
2.17.2 (Apple Git-113)


