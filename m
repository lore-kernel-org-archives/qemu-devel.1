Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A37C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CBE2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGgzjIEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CBE2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlZZ-0000cB-Se
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJ9-0001e7-Lq
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJ8-00066n-My
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJ8-00062j-Fm; Sun, 12 Apr 2020 18:42:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id a201so8023330wme.1;
 Sun, 12 Apr 2020 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z9KZ6eY6DRrXTHj5N0HrtI0MTUlERzvy0/HLB/IrQH4=;
 b=bGgzjIEqniohf+mlvT6SPL2WUceu7HTqs+DBMzLs+vU9gSIDrdVjfTd8xcrgOCAky5
 TDh2vRuFihmMGB462TBdOQPKih5ksBuXcT+29C0YsOitDdaimi9uo5kpTY3XUszml15P
 fZinBnJCt+z9YaYN0iIH2+V+uqlAHzQaeWvGuCQoeTNPPLyFu68op8CfwQeEbN+Csh5A
 w2Ku3l/giqijPu5Ixf88DXrRo+hF7edx7sdWJC/7eRqGTWT6tNwng5+26SxcXf21o4pi
 fbssSyzOVeYjVLMjSV9OT3CBM/9zFMIyz5VD0NDH9aZNmY9PSR78I6K1mLwfwl598XW6
 frtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=z9KZ6eY6DRrXTHj5N0HrtI0MTUlERzvy0/HLB/IrQH4=;
 b=RDny59dSGRgqiLldr71XbD0qcb6Ijr4VflxnpRd7zWB8wt8QBK8fAMBGE1a0EmYny6
 SvQuNXm76xCfSJl93jWMcOa6q1CuXpLVSptQI1/MPrvNo/f2Ve8H2EBr2eHLkwOdVtnv
 IuB7aksVA+oT1WYMffQK5VglHiqtgOlwoOz6Cj0TlFO+PLFDmEyThtCvfCXs32CkqOYX
 Cjr2EBKekzxNTh0UArVgDMx2JBnDtinm7PGm8Oe4CEbeQZsYPHygf03ahURBP5veENGK
 lLgbiZYT/pe93GtRlaykIW/g9+A2tUyK3ubB34dbWrETE0103pIXGfW5arEy+jl6qL0M
 0jfw==
X-Gm-Message-State: AGi0Pub4k0MVvTRFbdRtRNASUx3XgInYl/NaA5nCgFjQNuoDE1dABNMd
 Ku3jHU2giYku297I/ENIIYhRjEhgAUEX4w==
X-Google-Smtp-Source: APiQypLM5eyX9dZ+2OjFqysoVLHTT2ZiaOcl9zPGes7IMRWLxf7/1Fhiyo1+f+ujdIQ/6fOLwJNckw==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr8334867wmm.15.1586731343376; 
 Sun, 12 Apr 2020 15:42:23 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 10/23] hw/microblaze/xlnx-zynqmp-pmu: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:31 +0200
Message-Id: <20200412224144.12205-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 2aa602cf85..4ecbea7fdc 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -123,7 +123,11 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     /* Connect the IPI device */
     for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
         object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized",
-                                 &error_abort);
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0,
                            qdev_get_gpio_in(DEVICE(&s->intc), ipi_irq[i]));
-- 
2.21.1


