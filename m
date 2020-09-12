Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BA921548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYJbAEZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BA921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3xC-0006ap-E2
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tk-0001Re-Lo; Sat, 12 Sep 2020 07:40:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tj-0000Tv-9y; Sat, 12 Sep 2020 07:40:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id c18so13890509wrm.9;
 Sat, 12 Sep 2020 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fmud8Lbb3PnhfRHff2nlfxUUQJbBHq4EO52NCriy+1s=;
 b=vYJbAEZHbLqfoeL9iRz5iWgKqkJkWJsUIyoX5ePJhC/JUt/yPJHKUBF5b6dJzBdxQG
 daXfB5Z/jYIzNJRSazXT3Abd9UUAQJ9IgmZrmT1BtRvut/quC1Tfb8H08B+zsd+iDDFG
 Jaizh6ezIGa5LJ0lyRw6b/O/eU7xJU7/6SeqzHnU/eeG9ExdDahJm+fcO6Jj11xnRfUH
 dToR2BpePZr1nR5dcOA+vlOj2RY46IKPxvYs//i6RmeHuSnnhNxJp44btPfAR5iVQt3+
 /MC9HZzblmByiMQ7qWNWMUwnCmxic3wZV99O7KsFKg6r/MVme7yj0B0tK5aUKZRv5+FR
 jXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Fmud8Lbb3PnhfRHff2nlfxUUQJbBHq4EO52NCriy+1s=;
 b=T4KAisYZbMFYo3FbxQh01xQf9LmSMD8PqsHdK83soJyJ2GXCRYFjbk8wHXudd2Jlx+
 BUKmwSehWmC7O3dB+oUDlaWVkjTf2+x5IM5S0Erbf9kMfDpHANNtw8CPdtOdBm5RiRe/
 YqGU9Ii5bQFxMLbdM7gipekUx74ZXZNn8+Ui0C5GBNmYNYvbaiRXJLFjHBfAMtzymMlJ
 Tlons4rhHQm6ivEfvrZzb+I/zF3QXS62aSyxub2S8AU0mQx0xJkCjtiDcgAyo1//iCcK
 gfqPbqOj3FfsqjGc2Yw+1Oan2OpNifj1AlQqG7UFkIQ16zwm97aqQ8RHYJ7Gejtp2wZX
 lowQ==
X-Gm-Message-State: AOAM532+FVCaOwkzcaUIy4ZWs7b3EORc8TCPH6RUFNlWVytXK8Y0Lp5q
 vl9S2yYPcOpCsv6bk+HGYqmuWMYCLs0=
X-Google-Smtp-Source: ABdhPJzWb0TFRP6+IZ2tw5gL18ksvv+aRAEYvXo532BVMwzGTNnI+xK2FrjUGUnzgUAKEaVSJjZZTA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr6228485wro.233.1599910848926; 
 Sat, 12 Sep 2020 04:40:48 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] hw/char/serial: Make 'wakeup' property boolean
Date: Sat, 12 Sep 2020 13:40:38 +0200
Message-Id: <20200912114040.918464-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the "wakeup" property introduced in commit 9826fd597df
("suspend: make serial ports wakeup the guest") a boolean.

As we want to reuse the generic serial properties in the
ISA model (next commit), expose this property.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h | 2 +-
 hw/char/serial-isa.c     | 2 +-
 hw/char/serial.c         | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 264f529a7f1..09845721384 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -61,7 +61,7 @@ struct SerialState {
     uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
-    uint32_t wakeup;
+    bool wakeup;
 
     /* Time when the last byte was successfully sent out of the tsr */
     uint64_t last_xmit_ts;
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index d4aad81a85c..7e1b36c3f67 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -119,7 +119,7 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
     DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_UINT32("wakeup", ISASerialState, state.wakeup, 0),
+    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index ade4adfd526..ade89fadb44 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1015,6 +1015,7 @@ static const TypeInfo serial_io_info = {
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
+    DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


