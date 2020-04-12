Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF0C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3488B206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBd+viBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3488B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlZg-0000tv-BT
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJS-0001tU-F7
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJR-0006FU-Bl
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJR-0006EJ-5C; Sun, 12 Apr 2020 18:42:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so8528848wrt.7;
 Sun, 12 Apr 2020 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hCgEmZ8AI9qEuOAvT32ajI8Fl44JGL9aN5nhSoKC5cM=;
 b=SBd+viBpKNQCqQUWksBouKPZSOSSsJAn47ATAN++ZNeiAe0faIIbQa3g3L4aR6i0mT
 Vg2y+PRyLKxmpV08dE+hZTXbNBfbENs+sQ5UvJLlQdb4pgODWSCNcc8Pz6NZEtSJNDRv
 86D6HgIYgJJBgrDUHwic8phO8rQuwyKeUi19wYhokBxVtQ+t5LQ5J1VPfdUewsDi6BWR
 7yy3wstS7SWiUu1KVXilqG1rK+X0Eqo98HH/EhddocHsjFQua7sCTKvVYUKpKQKZJxW8
 18BUVJdh7ZoXxUIgIV/keVQtA8BQTHxZDs+5MeSuavGYhoewsxwicTgQI7GUmx/GBAyG
 zuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hCgEmZ8AI9qEuOAvT32ajI8Fl44JGL9aN5nhSoKC5cM=;
 b=Y0dd7eueebniBJkul1hYcyUG4DnXNiQoHh++rrJaC4jLtjDSSHbYf+rvhFhgiyOgTR
 sQRBR0wLtEQBf1jkbzZDNpCceblVz3KiPRurgqnAs2+PcTpqYmVrzbACBpzkUM7aocYb
 cXtmDrHIf0fHNc19YFocdg5jjZS/QdjehXW1+UiAvszsnvAbW2wqoLls+Rx8Tn5usRN/
 ufvNWmJF67F8w+BbfpwfbUVev1nuusIVK6OZIxpVb8uy7mIzWopS2+ZZM5fTtar0p4RR
 oJOxw6qFj93bnT4TjB05S3fymmsd/eWSDxzU2pKbrHIPMKYp5+UiTVzmT/60Uh1VLDHG
 tkWA==
X-Gm-Message-State: AGi0PuZ8Mv7JCwjnfL2saDsXo3y8BXkPHbH5nNOCpq1LmqP14JqV6/9d
 2THtFBguxMJMmkYuKHGUH9Ftcs70Gi7z9Q==
X-Google-Smtp-Source: APiQypJDFJxGMn9FJuLgcSCbAWocdm79zSC2mMz2wveZGVl3kocSuE38GLeqCLATxKX3m5ONDUonAw==
X-Received: by 2002:adf:904e:: with SMTP id h72mr15647061wrh.367.1586731368081; 
 Sun, 12 Apr 2020 15:42:48 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 16/23] hw/arm/stm32fx05_soc: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:37 +0200
Message-Id: <20200412224144.12205-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Alistair Francis <alistair.francis@wdc.com>,
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
    --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stm32f205_soc.c | 4 ++++
 hw/arm/stm32f405_soc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index b1be4fde40..fba18bc204 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -159,6 +159,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 2b8a84a695..6db77d296b 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -181,6 +181,10 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.21.1


