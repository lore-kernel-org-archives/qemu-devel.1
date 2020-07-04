Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8BB2070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQJg1+Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8BB2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjWr-0006bx-4u
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUN-0001DL-HT; Sat, 04 Jul 2020 10:49:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUM-0003e7-2g; Sat, 04 Jul 2020 10:49:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so27701779wrs.0;
 Sat, 04 Jul 2020 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oswm/m1DAWqBYNXr2uTrm9A1MHSMTs1YgVZvoQJC8bI=;
 b=gQJg1+Wh58x4r1H2OG452+zx84IaV+E1T+M1C2BaKGGeGjGLijbGT/5fa47rZbH8+0
 wx3oFF6OQ4YShJqliLGLwkPIB5oJdoms+e1FUh9KOzyP0OaQJPWoQRUIivVmvk/OIni+
 pIzj1GiWmXLxj18zi7ZWsi1d3bC0/vHZhYuKuqhtZGYCTA6vwHL3QyRfwCu4wrFZiM4w
 nFj0qm+tx7V6fzx/zRQcGItYIzadZOv9ExIOm820D40RuWqtW4US5zoVgHElBrDFWXJU
 AbeBG/uIbXymxcCdns7Thwq8fUZU4bxlC2yWqkCy++/qfZTE6Jfr1HmDinGWpjPF9fWy
 Rs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Oswm/m1DAWqBYNXr2uTrm9A1MHSMTs1YgVZvoQJC8bI=;
 b=Gv8fiPiykCWNZIbv3RETfbZ3UModcW8+HsOh/FMYRvR5/TPaqEDIQ2orBy5V/BqeIY
 V64I2yjDS0FrdGMfwQW5cTKMw+3KYBv1KN/5iD2R33BR2QT4j9bjCX04o+3AoXsBBRQF
 SYbQRmvc5uM8aqv+fxmojeTMbpcvf9JOKiW24y9kc4WvP6VLUTLqMVS5iRthAN5ebRM/
 Dr5tQvc/VYIAU1+O6Ngkc8IjWZdyjBXvGTFuUGvXgp1HHKTIMivny2S7YL3j2LdJNsH/
 aWfnsTNtDNhOqwj4ts205637u6U9Qkc4YKyCWWHgnLH/u2Q7JeiysCis+IgIs2Ej9Sj2
 45Pw==
X-Gm-Message-State: AOAM531K0xUGZeDAEWjGOXUefsnDWCIPjjodPlIPmGKXlhnYqmLJCtzB
 F+0yz52yBSxBXudKb15/tTkUjsIbXH4=
X-Google-Smtp-Source: ABdhPJwNyiTXMTeB3cC7VryyLyGzYsyh9YLCpLFWWlt+IfdrZqIJno2o/CWRvBISeVrXF/zuyPa+Cw==
X-Received: by 2002:adf:9561:: with SMTP id 88mr11042389wrs.240.1593874195987; 
 Sat, 04 Jul 2020 07:49:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 04/26] hw/usb: Reduce 'exec/memory.h' inclusion
Date: Sat,  4 Jul 2020 16:49:21 +0200
Message-Id: <20200704144943.18292-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

"exec/memory.h" is only required by "hw/usb/hcd-musb.h".
Include it there directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h          | 1 -
 include/hw/usb/hcd-musb.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 4f04a1a879..15b2ef300a 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -25,7 +25,6 @@
  * THE SOFTWARE.
  */
 
-#include "exec/memory.h"
 #include "hw/qdev-core.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
diff --git a/include/hw/usb/hcd-musb.h b/include/hw/usb/hcd-musb.h
index c874b9f292..ec3ee5c4b0 100644
--- a/include/hw/usb/hcd-musb.h
+++ b/include/hw/usb/hcd-musb.h
@@ -13,6 +13,8 @@
 #ifndef HW_USB_MUSB_H
 #define HW_USB_MUSB_H
 
+#include "exec/memory.h"
+
 enum musb_irq_source_e {
     musb_irq_suspend = 0,
     musb_irq_resume,
-- 
2.21.3


