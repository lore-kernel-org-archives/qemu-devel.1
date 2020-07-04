Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55419C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB452158C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB9L+DJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB452158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjdi-0002R5-BO
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUh-00022q-BD; Sat, 04 Jul 2020 10:50:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUe-0003iS-AP; Sat, 04 Jul 2020 10:50:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so35560275wmf.0;
 Sat, 04 Jul 2020 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k+8FH1LHVyWY5lxn8kaV6RhN5WT6vNL6Csn+tWtGqIU=;
 b=IB9L+DJ6fMSlRh6JnfVIyjRfs3r2+cKnkCMh6AOc0lm/+BaC+pa5gw3hPPcon8hyCC
 TQRh9Dsuy4N9iNSa+sDAo59Wb9OBUTJhWrGiQYUiHaJcD2YjCqcZFlX3q6wvN0kzv12y
 zjRWD0O+C14SgaG835wapqV4fOHwaoE+lia4hfdbd5Zyk+XJzdC2t6DGiCxQ8vTcnZgX
 354/5VYBjRfY9uD1tT+MK47AGBcB3P1p8J9RpLbDsqF2ri9rbyNs8LgFGF8k/fGIcKWy
 wmxNBkxWFAH/E/5EdZfvMLkUm0kbfAlZiV+UjR0G1MRggb5dB2nI2Req9hTae4hUmE3t
 glLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=k+8FH1LHVyWY5lxn8kaV6RhN5WT6vNL6Csn+tWtGqIU=;
 b=XYKZY/6jE/ty/XPqIXLKfWiic48wCT4R3JwYPcj0dsz4HkgiFM5QQNbXXWXQKjLlwZ
 Fy9DOc+cWWi1S0xedSyL699J+0qgoi8GRO4A05yxmDuc/rNtvtjvO6UfFpVF+Dy5y0L+
 7jNl+STy78hgugcNw6M/r3B337gyXdrOr+MGnRgcJooFHPdNaf01+3IObCPIR3jWvpe9
 Rz2Ph+lSnzv2N+NfRBev6EhTKBKxL+khFC0NmFMwAb6iJlx6Sueusszf6LzqRHEaQ307
 yTVyyA+/JtslHqE2n2BNYYhlIceETxxx6m1w02k53FvM0dWaQI7Qo6MeBjdR4XqCJlk4
 zN9w==
X-Gm-Message-State: AOAM533fG80KTD4yiR/27obNbJ25aNNFyRknTz7FEq4a3lYac4t2sIaw
 LhsC844iKwWG48ZCzd/QyNdqihIoKII=
X-Google-Smtp-Source: ABdhPJzNTGufYfLMeOUgBhGaylb5O5upKi84ytezyRjwfpHgpubMO2vfpa3tyGQAl3MlqZSVzS+XTQ==
X-Received: by 2002:a1c:48:: with SMTP id 69mr43033872wma.32.1593874214066;
 Sat, 04 Jul 2020 07:50:14 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 13/26] hw/usb/desc: Reduce some declarations scope
Date: Sat,  4 Jul 2020 16:49:30 +0200
Message-Id: <20200704144943.18292-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

USBDescString is forward-declared. Only bus.c uses the
usb_device_get_product_desc() and usb_device_get_usb_desc()
function. Move all that to the "desc.h" header to reduce
the big "hw/usb.h" header a bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/desc.h    | 10 ++++++++++
 include/hw/usb.h | 10 ----------
 hw/usb/bus.c     |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/usb/desc.h b/hw/usb/desc.h
index 92594fbe29..4bf6966c4b 100644
--- a/hw/usb/desc.h
+++ b/hw/usb/desc.h
@@ -242,4 +242,14 @@ int usb_desc_get_descriptor(USBDevice *dev, USBPacket *p,
 int usb_desc_handle_control(USBDevice *dev, USBPacket *p,
         int request, int value, int index, int length, uint8_t *data);
 
+const char *usb_device_get_product_desc(USBDevice *dev);
+
+const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
+
+struct USBDescString {
+    uint8_t index;
+    char *str;
+    QLIST_ENTRY(USBDescString) next;
+};
+
 #endif /* QEMU_HW_USB_DESC_H */
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 15b2ef300a..18f1349bdc 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -192,12 +192,6 @@ typedef struct USBDescOther USBDescOther;
 typedef struct USBDescString USBDescString;
 typedef struct USBDescMSOS USBDescMSOS;
 
-struct USBDescString {
-    uint8_t index;
-    char *str;
-    QLIST_ENTRY(USBDescString) next;
-};
-
 #define USB_MAX_ENDPOINTS  15
 #define USB_MAX_INTERFACES 16
 
@@ -555,10 +549,6 @@ int usb_device_alloc_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps,
                              int streams);
 void usb_device_free_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps);
 
-const char *usb_device_get_product_desc(USBDevice *dev);
-
-const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
-
 /* quirks.c */
 
 /* In bulk endpoints are streaming data sources (iow behave like isoc eps) */
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 957559b18d..111c3af7c1 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -9,6 +9,7 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "qemu/cutils.h"
+#include "desc.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
-- 
2.21.3


