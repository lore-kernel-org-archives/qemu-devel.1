Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ADC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF932071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5x5tKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF932071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilggy-0004wQ-5l
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV1-0007mr-QK
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUz-0004Ax-Qr
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgUy-00048S-4N
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:21 -0500
Received: by mail-wr1-x444.google.com with SMTP id d16so31180940wre.10
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=jj5x5tKYeQ1GYV4QoNkvMAKDb2DowqZgbctulR0sI8kPiGRVygr51EXYGo2LsaNMa6
 QrHCHaUW4j+pbMw5NAo1LCR1ERVXcHSFsXSlncrnbIALjVe0WQkEFYuZ0gKAyHoeI0tF
 oOb7qgvdjYeUfw7UO0WkcHNcRLxUoaCbx5RI1irHIYPNP0Y8dogQU6UoS3ILnlxqUjt0
 itvB4KtqZuErtGJJWO+ld7hgdMMWslcwsP7B+8oDfG74GowgIG8GhljDABZjq1YwOQGG
 Z4IageVZYZml8+p3NRgUr416dnqE39QI1yrawS0+s9TGNy8ffA3eZ+8VrHj86Hi+Wg9E
 UOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VYm/XIqEVgZC6h11WJ3979IWXTcW8fTDJ44bzexd108=;
 b=EzjhOzKPrdPuWgUFNJXQeehxZjjdm8CRZiwq0pfG+mbm/g15f4GSN71IDKsTxTitNc
 qMCpJT3lX3nBx+YjFFhBsYhOKW5S93cWbwaJkkV/C3yOilG5nXaGewpE1v3vtDhea85e
 p4JalsYE4+d0oM9QzyMiZ208vBSaLkvjgBIncBhZ6OnOP5Fj0+Ya/2W+fw0GvvjEvBmI
 RGq72EApVuFUFKNA3HjY3ytVFXN+jCSu36tVpuKmmkSlE7s8A3XdNHKs/KY/t8+UZQ9I
 AIi1p6mZBhZAke9s3wPYW/bPctC7WEhYqemlnUAQf6UclosQQJwLd+F68t9mJ9hwI9iF
 84Fg==
X-Gm-Message-State: APjAAAX4MURPkxDToTXhBiLLcoYylAdnmKNeaH5Jwc+0ehGMryBuBlwY
 qkrYziQ46/OFkjE8yG+7eRpgTJVHP05bAQ==
X-Google-Smtp-Source: APXvYqwTMax9oAE8b/3CGmf6yQjnPmgubJiSNImuk/isi9KSeCLONYhIiXX3utVDmPi6Tb9RH1Hlow==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr52727218wrj.325.1577656399050; 
 Sun, 29 Dec 2019 13:53:19 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:18 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 17/21] target/avr: Add machine none test
Date: Sun, 29 Dec 2019 23:51:54 +0200
Message-Id: <20191229215158.5788-18-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
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

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.17.2 (Apple Git-113)


