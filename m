Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20C2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B09B206B7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXPSXSTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjet-0004fD-H9
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUs-0002Fj-IS; Sat, 04 Jul 2020 10:50:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUr-0003uQ-0J; Sat, 04 Jul 2020 10:50:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so37045184wmh.2;
 Sat, 04 Jul 2020 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lYK2LCkkm8mXjPosH/dQ8dVGr7IbLAxEMo5hKyX8gDM=;
 b=aXPSXSTXJgMKootuaitVYmZBSggQZgK5/msZtoZcg7I8jA8LHFIiATkIx5WCEZldCp
 SeaQ7H/JOLUc20KVhGcA7f0xl4oHCgEjVr98O8j746wh6K6hdXVhWWXSpum0kkLIE1Ll
 o0sWptvhIkbblNoImRzF3l09dCL3iVxJ0WW2ZeILMYy+tYCo1N5He53EBz1ZPY1YrT9P
 UVjDzzudJa9wnQi7oNvmU0XMFcjt7H4ZMvL4fKtFw3JleIBzE+YVCgrp2ICVwl2encpY
 Qq0n9vh6n8s2ZQnJVc4oUaSLVKsimpACr35vRSlpJj6uci1zi0CBBOOmhbGsI86MbzSm
 uOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lYK2LCkkm8mXjPosH/dQ8dVGr7IbLAxEMo5hKyX8gDM=;
 b=Mel234CDzzz6R1Wp7X1tht0MOGNHwC4PgcwrAytIwwiOgP8W8YPQuTJ//rHoMdAtU1
 CVqJKHGLfVHARNXPslAcrPvMcykV6Wtw/BKKJkg358Bgc8uIqoacTW7R2xCbw+Ep6Aph
 uBJcBlr8uKcvq2Jy/VJ4Nel9IMddPhHhYJwFczgb2j8qqFFc0SYa11tVD+hN/oLoNF1i
 MFfN1fRpr59+/Knd6hHZkyeP1nmMeFJFWeIc9Se2+2a6BB/qd+hTmLWGBBCQ7wUR0Iur
 ZK4zGAuAYXH0ZmQ827zo1uEJiJi/KbTVm7fE2tVMF8Rx+HsuGDLdMFmWwOoDqNrhRJBQ
 4xRQ==
X-Gm-Message-State: AOAM533By9LMonBd+dsDog9xyPaxtecnjz+r49VgLtXZFysrO7in6Cry
 NWv24IG9CyUq/htRSgSC9o8ksnAP+R4=
X-Google-Smtp-Source: ABdhPJyYWdPo4hPIeG0V9hnWAf/4U3I+ZmZnVun1avHp1mFNCeVPmAKMwxtGlSjuHYbjFpIPmXDhOA==
X-Received: by 2002:a1c:f301:: with SMTP id q1mr41171773wmq.110.1593874226397; 
 Sat, 04 Jul 2020 07:50:26 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 19/26] hw/ppc/spapr: Use usb_get_port_path()
Date: Sat,  4 Jul 2020 16:49:36 +0200
Message-Id: <20200704144943.18292-20-f4bug@amsat.org>
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

To avoid to access the USBDevice internals, and use the
recently added usb_get_port_path() helper instead.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/spapr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f6f034d039..221d3e7a8c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3121,7 +3121,8 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
              * We use SRP luns of the form 01000000 | (usb-port << 16) | lun
              * in the top 32 bits of the 64-bit LUN
              */
-            unsigned usb_port = atoi(usb->port->path);
+            g_autofree char *usb_port_path = usb_get_port_path(usb);
+            unsigned usb_port = atoi(usb_port_path);
             unsigned id = 0x1000000 | (usb_port << 16) | d->lun;
             return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
                                    (uint64_t)id << 32);
@@ -3137,7 +3138,8 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
     if (strcmp("usb-host", qdev_fw_name(dev)) == 0) {
         USBDevice *usbdev = CAST(USBDevice, dev, TYPE_USB_DEVICE);
         if (usb_host_dev_is_scsi_storage(usbdev)) {
-            return g_strdup_printf("storage@%s/disk", usbdev->port->path);
+            g_autofree char *usb_port_path = usb_get_port_path(usbdev);
+            return g_strdup_printf("storage@%s/disk", usb_port_path);
         }
     }
 
-- 
2.21.3


