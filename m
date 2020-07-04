Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A16208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEPq0tBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A16208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjoL-00029R-VF
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjV5-0002lg-9O; Sat, 04 Jul 2020 10:50:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjV3-0003wo-LD; Sat, 04 Jul 2020 10:50:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id w3so24607430wmi.4;
 Sat, 04 Jul 2020 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uFl2X6lG6vil8sEXKsbieCQlkH7+teoSNXY57sY2N5o=;
 b=pEPq0tBtl3XW/xKrGA5imilI9ZmVHCddD6JX7pQf5W26Rrv3j0GgA9nuE3yRIkzKmh
 xHXVt9A0O2Sb6wPcOQhczgtzphR+PeHVZ4Fdijl43Nrxg+v0v2Hz13FZ7aE8sOrKMSba
 lfG8A6MMb+bM+xNdOi2/2GPMz+xyBlp2BCeJ2lrXsutgPmG7wdmm6i+UpuNi8+BMpdVg
 eiQN9k6197cbsfvPjRB78ybOhM3ezQzyqGNS+gSkzZo/tgdWfPLh9B5gQMHqP+XuG+Vf
 +5B1ATevPKzMRin82a+Fpe8eN19U96Tx56oDwDoz3bikVgrPUqsQH6eHcCsfnf4o51sH
 T5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uFl2X6lG6vil8sEXKsbieCQlkH7+teoSNXY57sY2N5o=;
 b=G4/oks1vyZKVosOigGfJnY9zkiwETomI8q5fuFy2ge9RLDltCcENmZNQJWNvSQMSuK
 D5z2V6zjqbHFbmCBSN+r7ee4Lao1eGHcRB4s+R23G8K4wQTSDtBcvYvfgfpevlLGeCCV
 Tqx4Fmcs/mM4LSad0++MeafZO+KhZHJiNz8mKWlS9sFmmm9yKTMRmlYZ/DH/i79Uvi4p
 UBKpZO9P0MVitrmDJTvAtAjF4JL+wP/0KOcD98Ipyo+nSEy4a8kNAnyLuaydYo2mYxDU
 5aRzNPYmoTXHWCOwDPxY1tGPSGLTZ9RwxMANeD3yNXsRKsj3sObFAWwyHE+xqcohRwy2
 AsQg==
X-Gm-Message-State: AOAM531g3Hx2WTGvv8eW2CIn+FFYQFqy1BlO2I23vLX3lp37ZgHFKx3R
 Y+TbaUNqY89YkugiggcCG5XyfU0oVrc=
X-Google-Smtp-Source: ABdhPJzM4tGe90D+YYy5lfrAPXqvO73Nu2kMmuLd9RH15Fay5P8lwxNw5t/4Uu8mV3OZMnQRXn0t1A==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr43119938wmi.66.1593874239587; 
 Sat, 04 Jul 2020 07:50:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 25/26] hw/usb/usb-hcd: Use XHCI type definitions
Date: Sat,  4 Jul 2020 16:49:42 +0200
Message-Id: <20200704144943.18292-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Various machine/board/soc models create XHCI device instances
with the generic QDEV API, and don't need to access USB internals.

Simplify header inclusions by moving the QOM type names into a
simple header, with no need to include other "hw/usb" headers.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-xhci.h        | 2 +-
 include/hw/usb/usb-hcd.h | 3 +++
 hw/ppc/spapr.c           | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index f9a3aaceec..b6c54e38a6 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -23,9 +23,9 @@
 #define HW_USB_HCD_XHCI_H
 
 #include "usb-internal.h"
+#include "hw/usb/usb-hcd.h"
 
 #define TYPE_XHCI "base-xhci"
-#define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
 
 #define XHCI(obj) \
diff --git a/include/hw/usb/usb-hcd.h b/include/hw/usb/usb-hcd.h
index c9d0a88984..56107fca62 100644
--- a/include/hw/usb/usb-hcd.h
+++ b/include/hw/usb/usb-hcd.h
@@ -30,4 +30,7 @@
 #define TYPE_VT82C686B_USB_UHCI     "vt82c686b-usb-uhci"
 #define TYPE_ICH9_USB_UHCI(n)       "ich9-usb-uhci" #n
 
+/* XHCI */
+#define TYPE_NEC_XHCI "nec-usb-xhci"
+
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db1706a66c..d8b3978f24 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2961,7 +2961,7 @@ static void spapr_machine_init(MachineState *machine)
         if (smc->use_ohci_by_default) {
             pci_create_simple(phb->bus, -1, TYPE_PCI_OHCI);
         } else {
-            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
+            pci_create_simple(phb->bus, -1, TYPE_NEC_XHCI);
         }
 
         if (spapr->has_graphics) {
-- 
2.21.3


