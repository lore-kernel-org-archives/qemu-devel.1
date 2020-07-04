Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED319206B7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKjMAbLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED319206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjg3-0006P4-2t
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUm-00028B-4p; Sat, 04 Jul 2020 10:50:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUk-0003q0-NQ; Sat, 04 Jul 2020 10:50:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so37074414wml.3;
 Sat, 04 Jul 2020 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LwCcRU3ITBZcN/p8m4Tvly+Gfq57t4rX34Kk3Uzziqs=;
 b=oKjMAbLQ2Nbdo7AVZTEMo5rKzXNXebbxS2YHgA5kZDA2Z2+DxgsuBaop4Nf7YP0t9g
 825K7Sz5l6DRKW2FWV64F6Y8PFEbfBZ/8mNGGq8q8I/v/XzgiVoT/c6cLtJ4Wq4+y8s/
 ZyQu3ZX70MOw0YMf2jRU84FoSuY8lwe6rfsONGi0EvhvcQH4agyx8WdTlthVPz7oUMLd
 7gZ2JkRsngTeq9VmBw6iuSdlXJYxQF7UzAOPFbD80qjvobuW2TUKX0fMm3Fjk3Rm4noB
 rWoSeUrHYZkkLtcx+JFqgKhA77mwlMll57o/tAzzPnbS9XSESKlGwrsNVmP1tPkGSkA/
 JlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LwCcRU3ITBZcN/p8m4Tvly+Gfq57t4rX34Kk3Uzziqs=;
 b=JU9ZGLfp+IKrelXi+y+CRQ0VhaCkexDDJ7h1rbIyzRzUjdSBXxOfdOMn1aPNFfxIe/
 FaV9ttEf13z26+sqbf5OYyZWewdtgXynir+BwxjDB4ieKWyOud2IaGh+Skqn8YP/Lp5F
 RFbYQvvK0xf/ceyCnS28d5B1SesKuwMh7IorXu4yorCgQF4uYYIo7ZTLc4zAa4Txv+vR
 YvRsjqITjj2iDe2s/zA9RWrvnRL5PCjt/jc31k9mn6ZdWqP4tymOowqtKM7fmKvwovlj
 3QQXbjLsQGG3UJKMXMnq44i/NPqC37hZlKOxpkKmLuWCuvfuk3Q225EwgL6DktBdWTH7
 +MwA==
X-Gm-Message-State: AOAM533khQ0XpLCK8Osqv+UkveTMFGDCStAjJ3Wo62U6dJtZH4lZwGlF
 L0Wg19e3BCQ7CpkJlOCDnInCimklmTo=
X-Google-Smtp-Source: ABdhPJxv37a8GSHu9gIk53qyLIpPiec4lNJ044JwM140Yq2vwztlBB8+hQI1sx3Og8exNtb1rbIDuw==
X-Received: by 2002:a1c:b686:: with SMTP id
 g128mr43033346wmf.145.1593874220071; 
 Sat, 04 Jul 2020 07:50:20 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 16/26] hw/usb/bus: Simplify usb_get_dev_path()
Date: Sat,  4 Jul 2020 16:49:33 +0200
Message-Id: <20200704144943.18292-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

Simplify usb_get_dev_path() a bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/bus.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 111c3af7c1..f8901e822c 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -580,19 +580,18 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
 static char *usb_get_dev_path(DeviceState *qdev)
 {
     USBDevice *dev = USB_DEVICE(qdev);
-    DeviceState *hcd = qdev->parent_bus->parent;
-    char *id = NULL;
 
     if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
-        id = qdev_get_dev_path(hcd);
-    }
-    if (id) {
-        char *ret = g_strdup_printf("%s/%s", id, dev->port->path);
-        g_free(id);
-        return ret;
-    } else {
-        return g_strdup(dev->port->path);
+        DeviceState *hcd = qdev->parent_bus->parent;
+        char *id = qdev_get_dev_path(hcd);
+
+        if (id) {
+            char *ret = g_strdup_printf("%s/%s", id, dev->port->path);
+            g_free(id);
+            return ret;
+        }
     }
+    return g_strdup(dev->port->path);
 }
 
 static char *usb_get_fw_dev_path(DeviceState *qdev)
-- 
2.21.3


