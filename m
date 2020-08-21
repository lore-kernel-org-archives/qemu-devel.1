Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EACDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7010720702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS5vlcL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7010720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B85-0005RU-OB
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArS-0001og-5h; Fri, 21 Aug 2020 13:29:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArQ-0001G5-Gy; Fri, 21 Aug 2020 13:29:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id t2so2399504wma.0;
 Fri, 21 Aug 2020 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IZ0mmUXtbJnn9Ui7y/DaJV/VanYdeWJm2wImQIUXZuc=;
 b=aS5vlcL8qehB+U2J50NH4eZyAOfZ+PhXUR22+pGkmktPjbaysW9ylCWg03AEvurp8v
 kYwbN9TDynqtBc4Zpg+9K6l55Hl5oldB/jP/4JqN7zRn2unptpoBaUAni7ucYd7KsN29
 qmqSj/ykYwBOUdeahnwj4Y9QPta4jCWiTewboU5tGtsDxlXKCSTZfhZWWvx3vTjFnIGP
 LACFlNhVRnPyJlUX3jqMZ3W9m9AeFUIpuWgHWPdNRv1sRLfTI510aX2oxsFk5aqv1R/p
 v60C0i7HdsRRr4pLYOJl638AO4TRZ0ONhhgKfsKc6eZsprz07fKWRAZI5PK4cxNFtvV7
 kMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IZ0mmUXtbJnn9Ui7y/DaJV/VanYdeWJm2wImQIUXZuc=;
 b=Wj6Uk75awjAKBxNF/UpVLhgx4bdxvic/o7ivsAAaFVa9YuDuKY+K9NS/11GK0K+aj0
 oUtO3eQjoUQJ4LbET4okEIuDHZHsU0hw80KGS/ce5Umada1wobauq2pPn5Pmy+WDB6A2
 4tinVSL0A3M2nxnmrwUQmRt9rssiqQbIVax1fkD5tO1L8gje8LK0rWorvdiL9CW16Fpi
 H7mzXCefOXoR7NvmxF9WHFwMuk2r3K92yhq6M+F3sPK3SBkLbCt2E/8RKeljfHZH63YU
 MWcEBxsf3KW+BKLzSl+VHBlHcNfUO3fKBtNJO7rKb3qSpRcUSLA25Ppcf+Z8FVSpdRfg
 ZSug==
X-Gm-Message-State: AOAM532t89XjvOGMdElHj/uarYCXNskXPcG2g1QwNL49NoB19XjH+/aT
 JAXfx/G9W5kYy0Pa1Cxaw3y+jFxjcEc=
X-Google-Smtp-Source: ABdhPJyGmxM9LZBu923ZkZzMHsKZ5DdRdF3tc7MiDvx257PgTryKKwfLUPu2PaIkVQU0h723M/eH7A==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr4079410wmb.3.1598030990045;
 Fri, 21 Aug 2020 10:29:50 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] hw/sd: Add sdbus_read_data() to read multiples bytes on
 the data line
Date: Fri, 21 Aug 2020 19:29:13 +0200
Message-Id: <20200821172916.1260954-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a sdbus_read_data() method to read multiple bytes on the
data line of a SD bus.
We might improve the tracing later, for now keep logging each
byte individually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200814092346.21825-7-f4bug@amsat.org>
---
 include/hw/sd/sd.h |  9 +++++++++
 hw/sd/core.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 3ae3e8939b3..ac02d61a7a0 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -184,6 +184,15 @@ uint8_t sdbus_read_byte(SDBus *sd);
  * Write multiple bytes of data on the data lines of a SD bus.
  */
 void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length);
+/**
+ * Read data from a SD bus.
+ * @sdbus: bus
+ * @buf: buffer to read data into
+ * @length: number of bytes to read
+ *
+ * Read multiple bytes of data on the data lines of a SD bus.
+ */
+void sdbus_read_data(SDBus *sdbus, void *buf, size_t length);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
 bool sdbus_get_readonly(SDBus *sd);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 9c2781ebf96..957d116f1a7 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -144,6 +144,21 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
     return value;
 }
 
+void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
+{
+    SDState *card = get_card(sdbus);
+    uint8_t *data = buf;
+
+    if (card) {
+        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+
+        for (size_t i = 0; i < length; i++) {
+            data[i] = sc->read_byte(card);
+            trace_sdbus_read(sdbus_name(sdbus), data[i]);
+        }
+    }
+}
+
 bool sdbus_data_ready(SDBus *sdbus)
 {
     SDState *card = get_card(sdbus);
-- 
2.26.2


