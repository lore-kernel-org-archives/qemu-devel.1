Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D59C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5982070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP5+c+c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5982070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjXz-0000B4-Ul
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUZ-0001ik-P4; Sat, 04 Jul 2020 10:50:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUY-0003fr-8v; Sat, 04 Jul 2020 10:50:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id w3so24606689wmi.4;
 Sat, 04 Jul 2020 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CVXjF5m55kSlusAor5YG6lDc3XbyrrRebQzgpXEfhAM=;
 b=AP5+c+c62PoQXfTA/LtPm4Xh/2BhHY+f3Lrq+ywLKxnRs/teD8SlK4rBeR1W21QVVg
 MX5/zdYcr6MAV0tTj6y2JwWtreM0kI/3HLVXeM5Km0zk4LkxkDr+JUBRTgKPd4JDTNTQ
 qN+mtEml6SPGpVvDH0gvcL2DaAmIUkHFVWrvjkbOj7nMpqfWvSbHnLG867tnERkfPaEt
 R2NVOPlavAmVmA4nXJZ+9rKOMoryjsy3gDMvjOfRq/6T+kmZOAFOqpsdRHndZbJgqOt0
 X2QNL+czgbdip7AR/uSYj4AY75akrcM9UFux62yHvkIZB1h62OgvTkd3vwzX7RVlkGWT
 qEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CVXjF5m55kSlusAor5YG6lDc3XbyrrRebQzgpXEfhAM=;
 b=Rno1h0TOP40mC78G8rx7YznS4QFn1Yom1ptwWdKDmGONV6R4WXFkqErwvI0UA8cfTG
 o6yv7jOfQkybIjyxXWKAypRQIrPknNdgztSQxwb5H5i1mHC+zj3mjxHIseEAvK+M+P7l
 0glXu5E2qEehOevOKmMfWT9p0IeWj7ew8mCg4Zb/9Iw5W98H6Il+XffEue1dqOu+8rPX
 QIWPMwlBQjaHBU4GuGcnKGya+u87wrIso6TmFL9JmbCIuBXPxHJSPCknoL6Sw6L53w3u
 HQ/iZSnP64LtKWBDli40xNYvgbpchgbyN/TpV4ax7mbiUYmtk76FWfKs0x1SqH2u8RXg
 qd/A==
X-Gm-Message-State: AOAM533My5frZyNAu7Zc6o+JGOjd6VPd7BHMmzXupdPtz7PU+OVzfvmi
 ha1npqdSBR/8G6lE6evtjSSDcCL5kg4=
X-Google-Smtp-Source: ABdhPJymro0ZDYhdB5ObnYkjPPmmHwp/a0dtBWYIDo1/eOyMgDUzyUYBTppKmDKb9G4hobFLnzrm0w==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr10977102wmb.93.1593874208054; 
 Sat, 04 Jul 2020 07:50:08 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 10/26] hw/usb/hcd-ehci: Move few definitions from header to
 source
Date: Sat,  4 Jul 2020 16:49:27 +0200
Message-Id: <20200704144943.18292-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
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

Move definitions only useful for hcd-ehci.c to this source file.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-ehci.h | 11 -----------
 hw/usb/hcd-ehci.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 57b38cfc05..4577f5e31d 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -24,17 +24,6 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 
-#ifndef EHCI_DEBUG
-#define EHCI_DEBUG   0
-#endif
-
-#if EHCI_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
-
-#define MMIO_SIZE        0x1000
 #define CAPA_SIZE        0x10
 
 #define NB_PORTS         6        /* Max. Number of downstream ports */
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 256fb91e0c..a0beee527c 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -36,6 +36,18 @@
 #include "qemu/error-report.h"
 #include "sysemu/runstate.h"
 
+#ifndef EHCI_DEBUG
+#define EHCI_DEBUG   0
+#endif
+
+#if EHCI_DEBUG
+#define DPRINTF printf
+#else
+#define DPRINTF(...)
+#endif
+
+#define MMIO_SIZE        0x1000
+
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
 #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)
-- 
2.21.3


