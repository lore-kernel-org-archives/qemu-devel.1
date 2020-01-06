Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9497DC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5372072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtSaFG8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5372072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXnz-00075L-DO
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4t-0003Jc-MS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4s-0004yM-MB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:11 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4s-0004y0-I5; Mon, 06 Jan 2020 13:26:10 -0500
Received: by mail-qk1-x741.google.com with SMTP id k6so40298558qki.5;
 Mon, 06 Jan 2020 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3FG9qdDQWzZLGEvFHKtE2+cU1rKneLyoMCDilVuOhQw=;
 b=GtSaFG8D1mBVeP9wYwdRsmx7jcl3MN12LcQELS2dx6mPJSyN+d7D/TqBkLUCcUL91Z
 pshF27WZbKMYFQAIp0G4naYN6nBcbDAUwS3tGLKw+LiUdVLz/pk3TKGQMBQDx2FZHddP
 d0T4Twaa5/Hj9ChzEhzh3XDZd5t2VROGdeqMd+XXWfewSFZvAeKIwGw5ZO9sEHVBHcOR
 sGwzTMjVSmPuzGHTsv/n+t5sYkUbgcYQs8QKVKJbo1j/13rd6hIdiDI0zOrYsOa9MyXW
 cPlXfBfLUnBZDh/CPdxw/iGylpD0cCctLe4kxmE0IDmXsHHDx+0DvOhTrVMxUZTTZkSb
 xIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3FG9qdDQWzZLGEvFHKtE2+cU1rKneLyoMCDilVuOhQw=;
 b=XG+9UbDaGOr/+d3ZBow58jUjBNpFwGQBfFqBXam3JwNWMAC/u9zXX2G4FORF+P3i1j
 IhjHWBpaF82HJlQ+8sduPp2jf9ttLmaavRS2EPTDxwCxpEEyrHpU/ElajCSEXv8wEMSY
 ZYEQJ0dkGKr3TQ1QDnRLkNHy2/8Xg98i8QqLOAaWWB8D1xslTjSzOMQv1XtqVK7xWCnu
 rADTwYtCEQJwEtbwUaYlnQDGMPuqDnhQqW7Hz+bRnF8SO93Oa/BfwOxgMOpGYoLvb3nj
 IQYI4/2SctCTRRF4nWe52e1L1FEqJnC7G2hX4aKWt+/Z7uK2HZ+ttCip+O+AgUReSAp/
 sKdQ==
X-Gm-Message-State: APjAAAUGbv3EN1CiGYNTJaSOeCCAGZJN7Uu/qXl8gtVMEfEqZh7+Jzkc
 NHH7eSus5dc8OygoRKeGwyLSR3xm
X-Google-Smtp-Source: APXvYqzFew3AJMCvTiarhXTnm1iHIqDjLoyAdP9XUwvEvi4CAIw5zq9xyF6Xr0nVkXGwaZxqVdwk1g==
X-Received: by 2002:a37:48f:: with SMTP id 137mr83918265qke.25.1578335169968; 
 Mon, 06 Jan 2020 10:26:09 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:09 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 43/59] i386/amd_iommu.c: remove unneeded label in
 amdvi_int_remap_msi()
Date: Mon,  6 Jan 2020 15:24:09 -0300
Message-Id: <20200106182425.20312-44-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'remap_fail' label can be replaced by 'return' with the
adequate error value.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/i386/amd_iommu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b1175e52c7..711e1f6e40 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1268,7 +1268,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         trace_amdvi_ir_delivery_mode("fixed/arbitrated");
         ret = __amdvi_int_remap_msi(iommu, origin, translated, dte, &irq, sid);
         if (ret < 0) {
-            goto remap_fail;
+            return ret;
         } else {
             /* Translate IRQ to MSI messages */
             x86_iommu_irq_to_msi_message(&irq, translated);
@@ -1298,7 +1298,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
     }
 
     if (ret < 0) {
-        goto remap_fail;
+        return ret;
     }
 
     /*
@@ -1309,25 +1309,20 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
     dest_mode = (origin->address >> MSI_ADDR_DEST_MODE_SHIFT) & 1;
     if (dest_mode) {
         trace_amdvi_ir_err("invalid dest_mode");
-        ret = -AMDVI_IR_ERR;
-        goto remap_fail;
+        return -AMDVI_IR_ERR;
     }
 
     if (pass) {
         memcpy(translated, origin, sizeof(*origin));
     } else {
         trace_amdvi_ir_err("passthrough is not enabled");
-        ret = -AMDVI_IR_ERR;
-        goto remap_fail;
+        return -AMDVI_IR_ERR;
     }
 
 out:
     trace_amdvi_ir_remap_msi(origin->address, origin->data,
                              translated->address, translated->data);
     return 0;
-
-remap_fail:
-    return ret;
 }
 
 static int amdvi_int_remap(X86IOMMUState *iommu,
-- 
2.24.1


