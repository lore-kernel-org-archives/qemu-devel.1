Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3996E2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIP+dyNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3996E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6XHY-0008Ng-GI
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwO-0005fM-6s; Fri, 14 Aug 2020 05:24:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwM-0004LQ-Li; Fri, 14 Aug 2020 05:23:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so7724832wrc.7;
 Fri, 14 Aug 2020 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L7idNJovpPa5jNi2WSWeMXFjb9mKtDeVDPABH+yZP/4=;
 b=uIP+dyNkfSEZjBU5XargAH/VUHjSwv6A+ZPVKDkMNnZ8K/CD0u88ATnjiQHP6OmwkZ
 cm7TNL8ZqNiuw8tBvIi5Jy5EwNp4uRwwNp0m4Q/K0WN0hYRgZzqoqBl+PQidWyxr5Xdz
 ELe6eW0nm+Vf2j7CEURYjUEyH4QB8vEds+aTmqeoNDLZV78srXwhfSyX7ILjW8GqzUg2
 IxLRlDXMYXxbRCIjTXyko6/QR8SKB5KhnXm+OrHagIKFGAgvvYDQJuVYhK+O3GQzHGv/
 +cHcND44UMVZzYjpeNXiXdrzziTKtR4pjh87KhRZsfHsU7LOj3y7Ehz1s6/a22v4hajc
 cv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L7idNJovpPa5jNi2WSWeMXFjb9mKtDeVDPABH+yZP/4=;
 b=cb2h+pUIXrLzsrvcSceYbOtKkWSgsl+J0V8I4Vong2Aj4M+Jzf5YbwnQ0mHWgQkrvE
 kNtieVW8tqETJo6KGzZoGrmBhUCB4UJJFVF6yTpUUiwgMeppuYuPj0zgVt/5HDYPMego
 XwryAJLn5pFYWfeery0Lga35dBqMDX36WQBXdvtHJdmPp4UjBh+kGCYcV2R1fjdnDKRc
 3+UCEFGzs6WjJ4qPZo2jHJ64wWyNvKkxSZ3irNNPRnorHafFykBpBPqM23cDPO3/I000
 lHQZnAIKzDc71AytBi7IL12USv4CHUjGlZE5bk6FX612w5Z6/oDfrG/T6EBStjHOMvTA
 /r6g==
X-Gm-Message-State: AOAM532THVW0ryvLQJmWstw1gxXMyA6d8pC37p71/53ybR3pxr4YLv8j
 YxUkl9HVkjqdZ+XS8QpUjAoXvvOyhm4=
X-Google-Smtp-Source: ABdhPJxiVf/tLEDOOaLJsHw3v915clNa0sjwQvt37LCOhfjGfRhi1UY6zEMOND9YuLK3iik4D88GkQ==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr1896854wrr.370.1597397036430; 
 Fri, 14 Aug 2020 02:23:56 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b11sm12889395wrq.32.2020.08.14.02.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 02:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/sd: Add sdbus_read_data() to read multiples bytes on
 the data line
Date: Fri, 14 Aug 2020 11:23:45 +0200
Message-Id: <20200814092346.21825-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814092346.21825-1-f4bug@amsat.org>
References: <20200814092346.21825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
---
 include/hw/sd/sd.h |  9 +++++++++
 hw/sd/core.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 3ae3e8939b..ac02d61a7a 100644
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
index 9c2781ebf9..957d116f1a 100644
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
2.21.3


