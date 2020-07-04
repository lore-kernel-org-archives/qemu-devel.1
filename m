Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1384C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D2F2070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOBuD8AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D2F2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjVQ-0003Gv-Ot
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUJ-00013o-FS; Sat, 04 Jul 2020 10:49:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUI-0003dc-0U; Sat, 04 Jul 2020 10:49:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so35747136wrs.11;
 Sat, 04 Jul 2020 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TYD3rdWUPlT0NII6NR282LsOncN84HigXsBo5vZptIs=;
 b=mOBuD8AYvWgD1eKqLpIBdjXVQ5Pph/+FmMaPRcgW2zETZQyqX8+ELNIs1My9xotg49
 yl9bERPQPS4BhKGyeBRx4Qd+uQFLZYRklMZbvqAuJXZY6sEyWYouhWOjPYTFIPLsN1nA
 GHwtlofg4fOkSOvAn8jYj6oYYhDGjGPP34trt8rdNRv6PvCFLzPAjucb8srw71EOzwXj
 tqxRmbVb81GwGMeF/lodyUfzMseIwejEvsc32wNWsbTHQldJGTBhlLiCfR5UelU3S8dR
 pT9OEuZPV2fjo7gKaYA+MWXkGAIMr5hn5Xs7KOlPZHvMRGlwOazCfo5B65rotWknhZhj
 6mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TYD3rdWUPlT0NII6NR282LsOncN84HigXsBo5vZptIs=;
 b=gA6p1L3KGSrAnSvliSW5Qb8tGn1IL34SCkJ1Rkp4cSNrwj3j/8O1AFqa/HWQ9I3pj8
 KDOetpaIZLMKw6t75AW8ZBHsMgTttIUMri/O9J/xDC7Y+QxgmxQFt4u6PlAsRNQBVcDE
 N7pJYFQqw2QvD1qEkJIjNtQnhDxwmuHUGGSqV9E3gLQtwA3FCmD46lHSvTQ34cW2E2FQ
 WNuABvahzwYIOAcJgV2LnBbrIHwRWb60R8lXkZzmeIgj8BrLKOH7mMUJsWd5Ypkkx8pi
 U1eTAkNRWt52rNYLEewTZRPvv0EY+PiXxkdw8bii49cGLyBd8klGQr2K9RUl2zHLHA8C
 oqxA==
X-Gm-Message-State: AOAM531rLgbdC9qvZX32zIc+SGphXI7yPoXzn0ggbwk2EclYU1LYJigi
 fs33RrAnellrquA7qG1XX5MPXBJEq9E=
X-Google-Smtp-Source: ABdhPJwmYB47kPgnriIBv4UAA2pvunyU+tdfS4/5cW6u0UXI8kGWbm5Q/26nom3RMXKe12Z+5cK61g==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr43245870wrh.95.1593874191948; 
 Sat, 04 Jul 2020 07:49:51 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 02/26] hw/ppc/sam460ex: Add missing 'hw/pci/pci.h' header
Date: Sat,  4 Jul 2020 16:49:19 +0200
Message-Id: <20200704144943.18292-3-f4bug@amsat.org>
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

This file uses pci_create_simple() and PCI_DEVFN() which are both
declared in "hw/pci/pci.h". This include is indirectly included
by an USB header. As we want to reduce the USB header inclusions
later, include the PCI header now, to avoid later:

  hw/ppc/sam460ex.c:397:5: error: implicit declaration of function ‘pci_create_simple’; did you mean ‘sysbus_create_simple’? [-Werror=implicit-function-declaration]
    397 |     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
        |     ^~~~~~~~~~~~~~~~~
        |     sysbus_create_simple
  hw/ppc/sam460ex.c:397:5: error: nested extern declaration of ‘pci_create_simple’ [-Werror=nested-externs]
  hw/ppc/sam460ex.c:397:32: error: implicit declaration of function ‘PCI_DEVFN’ [-Werror=implicit-function-declaration]
    397 |     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
        |                                ^~~~~~~~~
  hw/ppc/sam460ex.c:397:32: error: nested extern declaration of ‘PCI_DEVFN’ [-Werror=nested-externs]

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/sam460ex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1a106a68de..fae970b142 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -38,6 +38,7 @@
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 #include "hw/qdev-properties.h"
+#include "hw/pci/pci.h"
 
 #include <libfdt.h>
 
-- 
2.21.3


