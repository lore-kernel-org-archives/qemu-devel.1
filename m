Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7138C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C4F2065C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIl5vYlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C4F2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hsC-00042W-GN
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqi-00028N-0U
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqg-00052w-Dz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so15598754wrh.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vou0MK3wF2fBtWQ3jzXUST9E3PrwDChKhOUwUYVwMds=;
 b=FIl5vYlbKsO2sMgZaK5cLjOIOjd/NhKyNG9F/cPgbtPONAzjnJ/Wqimc7Vyl5gn7hH
 aRK9u7we7oNZjvBL4xeqDTkNCG7i7yyRB71xLd/AXQW2vzflSxzsM4Za+8+/OTApOpFU
 5ruQwzL0X5Uvj777/oGaAOyGu26NxDjdRfebkFx78UYbiGRk8F4EEVdzeDWxWl3OYTAv
 vPJx6XNKj7/cGCR8IgDOebEAXOiz5zZolLhK1mi/DoFaaW3DwD4lsiXS75x7Zvi7Jf2P
 D4CEpk6YwpWVzrq6P40UZFrs+9RGeMlOR4H2aMYZKY2aiDzbUC6meo6/wz8Z6it/Pi+J
 zYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Vou0MK3wF2fBtWQ3jzXUST9E3PrwDChKhOUwUYVwMds=;
 b=t1LW1TYbpC2pjDn4RccElvOLtTV/VkTzX6jdAOogVETbmo41duBhZx9p3NrGRJm8EE
 KnbP3Zi9AkFDiJuTKQr5sSyerVZ20zsw7FPJFKd5JYuJBfJIXWzHT1zMW5Lp57pak0/P
 3MUXvZjMAxpSmvdDtLd73kfaja1nagoNpkhSIhnpB/plqTRB1ZVz5VSjLCyPVO57iPKc
 KI2z6W+REgbp4lG1HKGY1tumP9S7+NGGmcPLfzn2eawc607k2a4Yp+7tC0dYNrvr3V2D
 VN+BK10LzFJLaY03YXDlcLzbNwSwQS64QdrZ6z+xTLARhq7m2t8Q/Bz3cGFyKkZI8VjX
 Yjag==
X-Gm-Message-State: AOAM531aCdOwGtckeaVmugl5hKIlR0+2Pbc4HV7PCLd4QBlyrDJ0zbay
 EPyekIocbjnQ+uOWY+iEJkJWcRdKPc0=
X-Google-Smtp-Source: ABdhPJwJzd2hqVH1B/S3bou44JmYFzrrpUAEO8NpQ1f+yP671tsFeF0vxh3iAd+VP/0s5ADlnKhJsA==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr17461019wrq.57.1597681139651; 
 Mon, 17 Aug 2020 09:18:59 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:18:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 2/9] qtest: Add local qtest_mem_as() getter
Date: Mon, 17 Aug 2020 18:18:46 +0200
Message-Id: <20200817161853.593247-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor the access to the default address space introducing the
qtest_mem_as() getter. This will help us to use another address
space in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/qtest.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 5672b75c35..81b5110783 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -273,6 +273,12 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     }
 }
 
+/* Default address space for MMIO accesses */
+static AddressSpace *qtest_mem_as(void)
+{
+    return first_cpu->as;
+}
+
 static void qtest_process_command(CharBackend *chr, gchar **words)
 {
     const gchar *command;
@@ -434,22 +440,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 8);
         }
         qtest_send_prefix(chr);
@@ -468,21 +474,21 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                &value, 8);
             tswap64s(&value);
         }
@@ -503,7 +509,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
         enc = g_malloc(2 * len + 1);
@@ -529,7 +535,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_read(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
@@ -564,7 +570,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
         g_free(data);
 
@@ -587,7 +593,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED,
                                 data, len);
             g_free(data);
         }
@@ -621,7 +627,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_write(qtest_mem_as(), addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
 
         qtest_send_prefix(chr);
-- 
2.26.2


