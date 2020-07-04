Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8C22158C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzt2Ao+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8C22158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjdd-0002Bo-CW
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUo-0002AQ-L9; Sat, 04 Jul 2020 10:50:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUm-0003rV-C1; Sat, 04 Jul 2020 10:50:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so35769451wrw.5;
 Sat, 04 Jul 2020 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bNYiPy+H907R6GvRggaZDEAvq/yJ89RNH5vqYDziYiQ=;
 b=Zzt2Ao+qbpw+PyTf0gj3H8RK9KRIom4jWcvpaKOt4s1hW0V1FcCCbKJ+J1H1BoamQa
 X7yQWbLBOiWHDKwtYXNcSlpsadQlqloNBTBk3OoIeHNh7YjvW7yMB0amtIHW7A3uKNrF
 KIuBad86H5R6+A+garcJYO5R0cc0W1dnCsIKjrMacUlgm36Fhjt7sIWGaJjruzORr6Mw
 tCeATKmk7k/LQ9OiBic3Z6q8k1mV35zARhSfEfSLPMbQtj1CaWLLBsqEXHNhY7FCgnTB
 UPsPUgFVXy+a2LKVM7IwIcL6sBQUgKI3uk0ZNyDH/kMyxLLse6a/v9qA5iUjYWAwTnNg
 EH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bNYiPy+H907R6GvRggaZDEAvq/yJ89RNH5vqYDziYiQ=;
 b=II66UvMQVxzrR3ZWp9oAXjw8zYByE+Rg0Nohw1w/nWghUnsrJdp+sUh9Q5k5C8KlN2
 C4JPOe/js9EnASubm1nyc2Y9+1RqZSvHDGQ7yFuY2yl45NQ8qMW4ZGd20KgSUpGie5K8
 PRst6FvBTDwQTGNocVtkmDmKK6bYguUyoGHkDHmTNIgalRvr9H42V3tCJ2Fhk3praH0/
 YgDtniE7ZY8mqy4ppyHw6hS/EtOjjiCGyVlFc+r/8pWFefYOP4aQF80yYhWCRNiHld3k
 a95g/hLXALMJ28mXwUdbU2eC0woyqgLeNBb7s/KpWIfsLn9z8ZKtSd/4UIcwtnQHKfd9
 bUyw==
X-Gm-Message-State: AOAM530U7Fdg2/eLplpES5zG8B55LMhIvdBgGb4p00tu6pBdrJ3eak6E
 gUmtPKQl13ZUXbyhjuwGoDv1UsbgMnI=
X-Google-Smtp-Source: ABdhPJx8cXLO5EiX1MZNGYDXemombuB+cpvmJcqKanQIPyybTeiASdt/aAvkPNB3j02DjAjdPJizlA==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr43510389wrn.143.1593874222155; 
 Sat, 04 Jul 2020 07:50:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 17/26] hw/usb/bus: Rename usb_get_dev_path() as
 usb_get_full_dev_path()
Date: Sat,  4 Jul 2020 16:49:34 +0200
Message-Id: <20200704144943.18292-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

If the device has USB_DEV_FLAG_FULL_PATH set, usb_get_dev_path()
returns the full port path. Rename the function accordingly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index f8901e822c..fad8194bf5 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -13,7 +13,7 @@
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
-static char *usb_get_dev_path(DeviceState *dev);
+static char *usb_get_full_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
 static void usb_qdev_unrealize(DeviceState *qdev);
 
@@ -33,7 +33,7 @@ static void usb_bus_class_init(ObjectClass *klass, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->print_dev = usb_bus_dev_print;
-    k->get_dev_path = usb_get_dev_path;
+    k->get_dev_path = usb_get_full_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
     hc->unplug = qdev_simple_device_unplug_cb;
 }
@@ -577,7 +577,7 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
                    dev->attached ? ", attached" : "");
 }
 
-static char *usb_get_dev_path(DeviceState *qdev)
+static char *usb_get_full_dev_path(DeviceState *qdev)
 {
     USBDevice *dev = USB_DEVICE(qdev);
 
-- 
2.21.3


