Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA02206E2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjegYO4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA02206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjZn-0003iO-ET
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUb-0001nE-HG; Sat, 04 Jul 2020 10:50:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUa-0003g7-0s; Sat, 04 Jul 2020 10:50:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so37074163wml.3;
 Sat, 04 Jul 2020 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qlr3O8z8K3sxKCQEA3LIB47YWANsKrmr6NiJfPzW+pA=;
 b=BjegYO4FHLxpds48YkBBFzRrjEv1/GP+e4ATsl6+otTSGUY/901sR8dfeFezH6YE/H
 gyqcHtJDTSjMR3xSfApYj8hqtz/wSqo+AhH4cF/fm2j+9m/n0GaYISJPWJ/RwXFwMv0i
 zF35Mon1ROOvzuyLQlhn2ubfKHpMR6u+d6BRgIWzYqjNEGrlhI70Re1P2IMAC6x/WVCy
 UpAhaCc/lRUYHliXs64Cz+eMjpdgUsURvkEK6XHbHXGDgqkC12TEmbUML5S9HZLBsrDI
 CfvgBiMtwGNU5/W+nM99z3Uhdqnhwsjs6JgDwP2puNTcMnyTpTn0mUq5lKsTdp+nUtSr
 CzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Qlr3O8z8K3sxKCQEA3LIB47YWANsKrmr6NiJfPzW+pA=;
 b=cFOZs2K1Mc9DbIU7YJfGHI7UKLFiSGqcAlNYLRNbdrsEG66zymXL3nc4TbtmSQhTvb
 nUMGKBekZiPFpq5ICMZ5R0vBo3SrL6M7wiCvuf06v3qR1eJHcLH++mH+k6smwBT2rLSr
 vwM3dka4L16GOvgnuuZDnioPR6OmIqpQsOx0JkbNDR6L+PipJnymy8YEZFxo9yfeT5r0
 vCC4kvk5s5oaCjuT3N2welri79KNygdPzmRMU99lgOLd0/e04MaGcFoHirOotpSzylsF
 5S9/fa2aOVNMbl8zlvaXvLpJkE9VoM2jlKriXcRfYC1ouD/mu4W2GkrbYIuSfDfCQLr1
 ApFA==
X-Gm-Message-State: AOAM532JuSN+73KaUlMEp8s1EJjV0CRFV0oxCuGvtdypQFRrTFSYFipL
 TJHIUuP6D85mjKu7gNw3eZs34C4K7oc=
X-Google-Smtp-Source: ABdhPJwynHTB68DwvsWAVjiG8rSM/kHHHNQ70teJ+dR7LseKz9qmvzwpG0TxpNzjRrE6k7cH1DWiTw==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr41379225wmb.103.1593874209918; 
 Sat, 04 Jul 2020 07:50:09 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 11/26] hw/usb/hcd-xhci: Add missing header
Date: Sat,  4 Jul 2020 16:49:28 +0200
Message-Id: <20200704144943.18292-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

This header uses the USBPort type which is forward declared
by "hw/usb.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-xhci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 946af51fc2..8edbdc2c3e 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -22,6 +22,8 @@
 #ifndef HW_USB_HCD_XHCI_H
 #define HW_USB_HCD_XHCI_H
 
+#include "hw/usb.h"
+
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
-- 
2.21.3


