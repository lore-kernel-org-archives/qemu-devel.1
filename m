Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F186C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB6F2158C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8OdEPUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB6F2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjc2-0007RC-3g
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUd-0001ta-OH; Sat, 04 Jul 2020 10:50:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUc-0003gT-5M; Sat, 04 Jul 2020 10:50:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so34722402wmj.0;
 Sat, 04 Jul 2020 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LIvjoiOYGW8qxH03j7d+uMoGgATq8ow1BJ8pj4MMInc=;
 b=K8OdEPUyesQSU/S5m5qok6/IcUiWOAZO7BMajTrjGs6JPbceMxtuZf8byY8tbJEGHX
 JEhvrKsqhFGfeStk45pdmkIx1Crd26UqdfRtBkDFTF1ZcEpMz4Y9f8h/NujfAZ8zhopU
 tcgLUIVhx4SR2VngYxvbMDeifVcrfHrvzA0aQukuywYfCwQ6dqY2ovVF7OMVfTiF2YPn
 DNxSIQBEYNKYXgGw5SLUtGuykIXaIqdYUBYTZrYeQbwEa/h1m7E4cIMUq8sIDEztAFSW
 sjbJhzGGYK8GyRliwIteCXYFpst00XbTUThRJIANJG3Mz51oqbQ9X/YLHxyeR4B28a9a
 b3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LIvjoiOYGW8qxH03j7d+uMoGgATq8ow1BJ8pj4MMInc=;
 b=hXOxyCAn1+Z/CPaMVZprNfoPCIDoO0wqxN0gqMe/K8eSEq5XLPaYGdjov54EFc5T/N
 L/wW2qOVQ6tUh/PlMv6ILfxM5LQVPZYLacbnM+E9Rk0zTOccE4d92hF9OEEafEEMlUXY
 SZT0CKS44qodjwGZy8tEbNxTuMLofAKcjp5XuNob+YEwUy5YrJzq6q4uWLPREBUs0UX9
 G2yY0GB1u0tgqkbLra5OBeqlrioymfNu7f73hYy6bnx/NsQawfAwMVSgSRUtZfFAuoJU
 ULjZwmqZopheC3C9GdzvmRGIjpNxpuOxZhCSwgpmjVDIM9TC+8ksIEDClR+mrdF3APyA
 4++w==
X-Gm-Message-State: AOAM5311VhI3Iz7Pvm7gioSLfXw8fzN8t1953ZET5OmgjsXzD5UHa3l/
 C6rWL4XqyPLvA0UfkloET/W3ugC8tCg=
X-Google-Smtp-Source: ABdhPJxJqnEAihzmKK5m10VR2mbQ1Jco3QSfcvHgpyoRQzFTU2aqsRISnZhnGEZBTtk3/AGxed2vTA==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr26876880wmj.67.1593874211964; 
 Sat, 04 Jul 2020 07:50:11 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 12/26] hw/usb/hcd-musb: Restrict header scope
Date: Sat,  4 Jul 2020 16:49:29 +0200
Message-Id: <20200704144943.18292-13-f4bug@amsat.org>
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

"hcd-musb.h" is only required by USB device implementions.
As we keep these implementations in the hw/usb/ directory,
move the header there.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 {include/hw => hw}/usb/hcd-musb.h | 0
 hw/usb/hcd-musb.c                 | 2 +-
 hw/usb/tusb6010.c                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/hw => hw}/usb/hcd-musb.h (100%)

diff --git a/include/hw/usb/hcd-musb.h b/hw/usb/hcd-musb.h
similarity index 100%
rename from include/hw/usb/hcd-musb.h
rename to hw/usb/hcd-musb.h
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 85f5ff5bd4..b8d8766a4a 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -23,9 +23,9 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
-#include "hw/usb/hcd-musb.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
+#include "hcd-musb.h"
 
 /* Common USB registers */
 #define MUSB_HDRC_FADDR		0x00	/* 8-bit */
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 27eb28d3e4..9f9b81b09d 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -23,11 +23,11 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
-#include "hw/usb/hcd-musb.h"
 #include "hw/arm/omap.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "hcd-musb.h"
 
 #define TYPE_TUSB6010 "tusb6010"
 #define TUSB(obj) OBJECT_CHECK(TUSBState, (obj), TYPE_TUSB6010)
-- 
2.21.3


