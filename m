Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C954C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D42D208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK34UbPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D42D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNFH-0007K2-KQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN77-0003x9-BI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN75-0006lm-JI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so32990705wru.6
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EaNr/NcUc3EkO5pc7J+JoEHPacZalxFiqmfKViYxLQc=;
 b=WK34UbPsiJAhbM4U7sGeEXGfhnC2L4r1teHd3RQGc4orARsedWYiEczyskRNErb9eo
 /FNtuHXN9IT5pe4tD6/SUxZbaQv5aIZjBK6qfaG87p9+eE8qObpXMRXR1MgvKG1/f2KR
 R4Sl1DF/G0Cmz5t6iviaPo/DorvnNiz/VaVRMQTxVXCOQRH2O22KLF93+TFmk0GwuyEw
 EoOv9oF8D8/jLeXvQsMy0RVQrMr8WoPHmgqpWe6AzuthKhk3s2ygOjO274Tx6VcNcoym
 2bwcPzo3fJwwRzsv9Zil4+GA4Dlo0QYRnG3hQz9gp3/MIEb608kg/T5GSNM8O76qqbVc
 ud4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EaNr/NcUc3EkO5pc7J+JoEHPacZalxFiqmfKViYxLQc=;
 b=NP0pp0EOKEkcR+/zYBvKh6MzXaU4NvZ66iLJRXXa7vnQAXhCb729TcUz/AsYB+P1ee
 7PThMFtAP/cyuJn9zr7cDYtgwFAhqqCbZuU+VMLLTh0OA7lA5MiaejT3//xQ7SD89eUp
 cWrwoIqCrDTYxuwgCBVzjSoNbWkTe2N297ezsIEQfSm1PgLMLtBKw1i2MWgJEFALjaCW
 V+yKvaXFzyzVSZXzvQiFMZGzvqlhpI5HoQRhORrksYQG3dxaax2SxanyZf4cRF5zgX7D
 j65UnEMZFD61WFsTPBlP3resoPvmRK1b+xQND8sfIjJmr5O/AZDr3Hv+gHuj9SK7pAat
 pExg==
X-Gm-Message-State: AOAM533C5x5dwl2BmwjbxABy9rswWsk2OD6owU8HlS8kH+C7U9PJbBpn
 iKg1EBV35K5H00JRlnZtsZlyZ9dYS7PBFw==
X-Google-Smtp-Source: ABdhPJwuJBRlJBDS62cwrqDoYGFqx8CZ9BOdmo4Li0lIDXjkYnmJWkqgAndajsII1qrNHXMQ8bjZAQ==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr39565907wru.115.1593788186033; 
 Fri, 03 Jul 2020 07:56:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] util/oslib-posix.c: Implement qemu_init_exec_dir() for
 Haiku
Date: Fri,  3 Jul 2020 15:56:13 +0100
Message-Id: <20200703145614.16684-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

The qemu_init_exec_dir() function is inherently non-portable;
provide an implementation for Haiku hosts.

Signed-off-by: David Carlier <devnexen@gmail.com>
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/oslib-posix.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7ad9195c445..72907d4d7fe 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -60,6 +60,10 @@
 #include <mach-o/dyld.h>
 #endif
 
+#ifdef __HAIKU__
+#include <kernel/image.h>
+#endif
+
 #include "qemu/mmap-alloc.h"
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -389,6 +393,21 @@ void qemu_init_exec_dir(const char *argv0)
             }
         }
     }
+#elif defined(__HAIKU__)
+    {
+        image_info ii;
+        int32_t c = 0;
+
+        *buf = '\0';
+        while (get_next_image_info(0, &c, &ii) == B_OK) {
+            if (ii.type == B_APP_IMAGE) {
+                strncpy(buf, ii.name, sizeof(buf));
+                buf[sizeof(buf) - 1] = 0;
+                p = buf;
+                break;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.20.1


