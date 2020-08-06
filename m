Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A49C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6FD204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSXZ0WtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6FD204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3b2G-0004AD-2w
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax4-0002SL-Go; Thu, 06 Aug 2020 04:08:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax2-0005gn-Hh; Thu, 06 Aug 2020 04:08:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so6010740wmc.0;
 Thu, 06 Aug 2020 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OOTPgo4khN8yFS6+N1vBA/0RT1rnYM2M5KZls9TsuCE=;
 b=iSXZ0WtFI7B5lfFyIX5uhGvbcJ19xsOUClRvsinoOL5lNvhWfznHqHMXneREsl/MZX
 YVWh64SDX36P8EP3zCvJiMJ8jCAMOQQvwRJfG4OZuKQhVpkGVNXixGqJUfRY6Bx9LWc4
 3eBZ3M/2SaYrRZ7/c+tXi++EJDGujUV+ySteCAxfT6sQVnLo1sXGKu4NmzFlHPnke8OQ
 2na23Qmwt4EKYvq8N1BX2E5y6DrVfElOCKOxVzFUc81/PzwMdSgedE0BNCqq/p7UlkQc
 TXZEjvucfIo+8w7/vLWCxHASweIeVmVU43ApMjC3U050LpcjW6T9yVTlxH6M+WMdKFMW
 CKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OOTPgo4khN8yFS6+N1vBA/0RT1rnYM2M5KZls9TsuCE=;
 b=f2XJ4eNUlDC/nNVsMxw14aD2AnwEbdcicQnpyw1QV3iAqthAvFonGGKjjTddTrKa0F
 1EkMCSeDT8BSGCPJ/EzBSwuGXf8ZpHW9yK7n0E+fFCjTUT5R5uebxZ7KEK3TZVpUsLiN
 R3P/UqPNn7Yhuai7KOlWkqIBmLDD+aP1aN+uYDgRpGS7vPT/YonMHUhk+i73Tw8WR2aJ
 aHgunERHiVS4zXVxXxWvJtXF3e3Q1RF6dtx525R7PzAi9EjjG+6NMRdYBkILqtgHeaOb
 h0/uHxyxgxcIoqng8fXG238h4M74HHnLUb/TllzxZzRYE1peGK6sAhUteXaMTrjItlWU
 M7Sg==
X-Gm-Message-State: AOAM533Nfy3oHLIs7OCUQ8Ipq3IQvqTxETD8v/PU99XklCRhaj0/D9Ig
 P/55tJ04sdw8DMhLKRjBZUXvH/Zf
X-Google-Smtp-Source: ABdhPJwyvdSLMcAjmlc5DQxwKNrfKQltf9a62bTU8j7hl3JxTF9eBbMGtS2XfWimxPxSKd5QjOBW3A==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr6635342wmj.84.1596701314345; 
 Thu, 06 Aug 2020 01:08:34 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 6/7] hw/block/fdc: Use more descriptive TypeInfo names
Date: Thu,  6 Aug 2020 10:08:23 +0200
Message-Id: <20200806080824.21567-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better name TypeInfo structures:

- ISA bus
- Common floppy controller
- Intel 82078 floppy controller
- SUN floppy controller

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 278220ed29..6944b06e4b 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2930,7 +2930,7 @@ static void isabus_fdc_instance_init(Object *obj)
                                   DEVICE(obj));
 }
 
-static const TypeInfo isa_fdc_info = {
+static const TypeInfo isabus_fdc_info = {
     .name          = TYPE_ISA_FDC,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(FDCtrlISABus),
@@ -2971,7 +2971,7 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo sysbus_fdc_info = {
+static const TypeInfo sysbus_fdc_i82078_info = {
     .name          = "sysbus-fdc",
     .parent        = TYPE_SYSBUS_FDC,
     .instance_init = sysbus_fdc_initfn,
@@ -2997,7 +2997,7 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo sun4m_fdc_info = {
+static const TypeInfo sysbus_fdc_sun4m_info = {
     .name          = "SUNW,fdtwo",
     .parent        = TYPE_SYSBUS_FDC,
     .instance_init = sun4m_fdc_initfn,
@@ -3013,7 +3013,7 @@ static void sysbus_fdc_common_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_sysbus_fdc;
 }
 
-static const TypeInfo sysbus_fdc_type_info = {
+static const TypeInfo sysbus_fdc_common_info = {
     .name          = TYPE_SYSBUS_FDC,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FDCtrlSysBus),
@@ -3024,10 +3024,12 @@ static const TypeInfo sysbus_fdc_type_info = {
 
 static void fdc_register_types(void)
 {
-    type_register_static(&isa_fdc_info);
-    type_register_static(&sysbus_fdc_type_info);
-    type_register_static(&sysbus_fdc_info);
-    type_register_static(&sun4m_fdc_info);
+    type_register_static(&isabus_fdc_info);
+
+    type_register_static(&sysbus_fdc_common_info);
+    type_register_static(&sysbus_fdc_i82078_info);
+    type_register_static(&sysbus_fdc_sun4m_info);
+
     type_register_static(&floppy_bus_info);
     type_register_static(&floppy_drive_info);
 }
-- 
2.21.3


