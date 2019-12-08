Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC9C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9871205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE3P4qOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9871205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1sd-0003RC-Px
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1U2-0002PE-1W
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0003Pv-3e
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003GX-1d
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id y23so13753410wma.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=iE3P4qOkqN6/fNN5rSBJ1oHQzZqRZWNAMcrF90fBfc/tN15USuY6v80y7xZSCM14o3
 vfwvBv5jvQD1IGUzmoCIfbggF5Ekav+GYTk9qzfMAH3tWpQSr1w74itqTBvL7NTZ/hqX
 H82brKcbuNpmApkfrMI3lY0mLMKK4SiTPui6haFTsubrXISxaSIbFs2sPZ8FwzQzEZPR
 VjwCksyS5tT1meqNv3pR4rtUr18txaRXuoUXrHM5vHLdvhvxX66L74b7wNQ3HeuOkEKN
 AwyNxwWtL0ZpMwIIifKMqXAXtcJXI/Z/eagRev0ofJ1jTe3JIGIwjCCF5Z9HYgx37enV
 i+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=OoraO8RptphMZyEN35eqxQDECcPMcYHqv8AZfgJh7nHSGRtOBpXoXmevRVnbIf878z
 Brn9LfmY0imeH5flJ6iY5UfD6j6vNEZniI+rEB1dQ/d64iGa0qojJuubUhhi4FM/dmJd
 wrg5CMXacjW5tfqssZXin1OqqEjuy6/638C5MIG3m7DkIum8vyzEINrMG2wBfaH35lRy
 6mCWoSIY6cwLKLg+bdC6D5X/hoslZt5LWLZT7KgvoiQsEIrIVmloIus2Fv+Wq+EvnjTQ
 JErxNxCjS467XUdIHBJgi7XpzoyN9fj5aS6FmXPI79gCT9fToEnAF29uIlfraHsWkpiU
 sLaA==
X-Gm-Message-State: APjAAAW8zUjykLdl52YvVlysNCZ3o2aycdELm2Y39VlbxZySkz+YmziR
 Tz5tquboDGEwYPILgL0nhYr0V88G3Q8DLrzg
X-Google-Smtp-Source: APXvYqxATL0/3yTUeG4OZ0dAujhXl6SzyRjJpQ11n5LKKKaGWb7vzhj+2ealQI9t7eePNT813k+9WQ==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr19442108wma.88.1575830428576; 
 Sun, 08 Dec 2019 10:40:28 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:28 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 20/22] target/avr: Add boot serial test
Date: Sun,  8 Dec 2019 20:39:20 +0200
Message-Id: <20191208183922.13757-21-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


