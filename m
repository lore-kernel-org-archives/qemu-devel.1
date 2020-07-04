Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A70C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113732070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnXK+ln5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113732070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjZ8-0002KD-9w
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUV-0001YY-Qm; Sat, 04 Jul 2020 10:50:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUU-0003fC-6h; Sat, 04 Jul 2020 10:50:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so35747440wrs.11;
 Sat, 04 Jul 2020 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KnwDCFnDP2p4VznLGchEQ7MhbCDHoouF9hb3OmMvFo=;
 b=qnXK+ln5rQy/kZGC3Fh2RFx/8LLRy2FzRaODh+swFw0DtexOC034PCwojAmD2p2qEc
 +xBeYKP6Sea6ucH8fkvrVNNAXzAZNbHz5N4CojECMrqUJVqYMYiMaro3hTSh93ifaaQa
 XZwymWtZAF5r5fjYDxoQfxgBDwsrJ+DJMbXURYjcQX+7tdru4xwSDdEYfIB4ftoZAWW3
 odapVHwJEugfsQL3deagFHvaMemeZ1/ffZNaL8ml9YhUlAPZWcmqAc9Ldb9FPwIY49F5
 nCg4ELh3hzoGogZjdC9IsUHrjWxHgtGLNK9IssYFB3ec8/8vdv8bxlDIDWrs/Yk59fX7
 Perw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8KnwDCFnDP2p4VznLGchEQ7MhbCDHoouF9hb3OmMvFo=;
 b=n+wjN09AMO/DSgSbcRmkDe2EYw7fC8n9BotB80ztABkOdyO8lyoVTK+B6UFqcEB5hm
 BCIy8CFDL8UIOveXF1usQ3SfLGBW/bdkavPNSlVKBkOVZy6PTgTNiReIVe6hKZxfL+K/
 9X/nUifqFIlwtIWO/flg7uDx7MjEX31oPGlaOsxRVizW8BbPBAI7gXv1pUTF0tv0m2QM
 SzUBORpYVQCRC82GHRmeqXHl35eJ2HAdwbWORZAkJ9t+013b+p2ShPiWU9UFmqbETLcz
 93fB9HN87I+qeTJ+AnECtA6pRwf83WnmABB8E59pbA0AdJgDuhMnC/OlXhz+WXBRDnsC
 NXdg==
X-Gm-Message-State: AOAM531WmS/WicnH7D+NsbwvTHhjX9FQwYefXgEKgan895RZKuN+7JeC
 rXd/WHyykGe257LWdp7L50bbG71bajA=
X-Google-Smtp-Source: ABdhPJy5uEuHNE6Qu6FF+bwIyX64Em7+RTT3tgkuG40gaTm44oygCnXfGMDpLMWbQQ/T4oOMWH2j6A==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr41607272wrv.177.1593874204051; 
 Sat, 04 Jul 2020 07:50:04 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 08/26] hw/usb/hcd-dwc2: Restrict 'dwc2-regs.h' scope
Date: Sat,  4 Jul 2020 16:49:25 +0200
Message-Id: <20200704144943.18292-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

We only use these register definitions in files under the
hw/usb/ directory. Keep that header local by moving it there.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 {include/hw => hw}/usb/dwc2-regs.h | 0
 hw/usb/hcd-dwc2.c                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {include/hw => hw}/usb/dwc2-regs.h (100%)

diff --git a/include/hw/usb/dwc2-regs.h b/hw/usb/dwc2-regs.h
similarity index 100%
rename from include/hw/usb/dwc2-regs.h
rename to hw/usb/dwc2-regs.h
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index ccf05d0823..252b60ef65 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -34,7 +34,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/usb/dwc2-regs.h"
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/irq.h"
 #include "sysemu/dma.h"
@@ -43,6 +42,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
+#include "dwc2-regs.h"
 
 #define USB_HZ_FS       12000000
 #define USB_HZ_HS       96000000
-- 
2.21.3


