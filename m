Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CFC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0E220678
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsQvQjdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlM9-0006L9-HF
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEG-0007En-0N
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEE-00030k-Ra
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEE-00030C-Kp; Sun, 12 Apr 2020 18:37:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id g12so530137wmh.3;
 Sun, 12 Apr 2020 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6EG1vhq7sjTB9ZSXWfgY7jLuzjsnK7wuhdMzV+BgTOM=;
 b=MsQvQjdOJctQaymMWzuHiIEE+lE19kYquiqYVPI8ArMQyMfUER4XHw9x6BuSyOtNKf
 lA/5a8DhdoV5UNUtzgCep+8KE8mnzFH9fThKoND+pqiF7rRm9vc0Emwo62vxbEmp4qkv
 Jk6v8A6jQHxVB0IseXpPtlnCeqj8194nNLq4BMLAVJ7XIR8RAOh0ZNgmi/NYXfQ5RVu5
 WQbnkElC2a4G+SJ2xRVbwKuokBS06ka+XYcwMunG53+1xCIM8EluyfK11rvsgbD7rmgj
 OJtcJxK6F9aKsAAA5PCU9ov1lOHTmUfxBulafyYFH06Xgvq60924wzckwO22Rt9vgUmQ
 ASdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6EG1vhq7sjTB9ZSXWfgY7jLuzjsnK7wuhdMzV+BgTOM=;
 b=TU1a1j5JI2JI1hO5NRdZ/jwAX9XSxcOGlwea1xc7vtr9sdnsfVDrISh6KqGufB6Y67
 BtH8H/1d+Tv2P85XwIWCU5ewlk5qGdV5w0ZKPaRJ5gPJ9qAKrEJGJ9XJyazFsLjUtPEE
 haZOqcwBeWLe3gIft9jMcrYDPr+ygqAMoas1K3clS6shiOMN7TX+T9OSyk6O2GAvFsfe
 pYqu2Bg2muRM3eBdGRqGNag647/wD83QWp3uTeTmcgFUN1PKPRh83zLCEaAW764fxvR6
 JShFOvEAPnn0QLBchJiYPkjRHUURXuACEa/BPYpDxt4rgQ2hT8YuWB3KbM8luK3QPfvf
 xFYw==
X-Gm-Message-State: AGi0PuYBjH/mBsCdf2uc/Xp9Wfaz7edKJD3axFJ560p12z5NmB6TfGTV
 dsH7yAgOOWejcnTmtEE04lQnLsxh7W+r8Q==
X-Google-Smtp-Source: APiQypJlLltEQFNE2vqF8ExiHlmy6ahTplWoe0ijPErKx9YJP0u0OJAAKYllEE0ddjztCeFBlLUyaA==
X-Received: by 2002:a1c:43c6:: with SMTP id
 q189mr15130503wma.115.1586731045453; 
 Sun, 12 Apr 2020 15:37:25 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 18/24] hw/pci-host/pnv_phb3: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:36:13 +0200
Message-Id: <20200412223619.11284-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/pci-host/pnv_phb3.c
  >>> possible moves from pnv_phb3_instance_init() to pnv_phb3_realize() in ./hw/pci-host/pnv_phb3.c:992

Move the calls using &error_abort which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/pci-host/pnv_phb3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 74618fadf0..57d717ed23 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -970,6 +970,8 @@ static void pnv_phb3_instance_init(Object *obj)
     /* LSI sources */
     object_initialize_child(obj, "lsi", &phb->lsis, sizeof(phb->lsis),
                              TYPE_ICS, &error_abort, NULL);
+    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
+                            &error_abort);
 
     /* Default init ... will be fixed by HW inits */
     phb->lsis.offset = 0;
@@ -977,6 +979,8 @@ static void pnv_phb3_instance_init(Object *obj)
     /* MSI sources */
     object_initialize_child(obj, "msi", &phb->msis, sizeof(phb->msis),
                             TYPE_PHB3_MSI, &error_abort, NULL);
+    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
+                            &error_abort);
 
     /* Power Bus Common Queue */
     object_initialize_child(obj, "pbcq", &phb->pbcq, sizeof(phb->pbcq),
@@ -1005,8 +1009,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     /* LSI sources */
     object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
                                    &error_abort);
-    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
-                            &error_abort);
     object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1024,8 +1026,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
                                    &error_abort);
-    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
-                            &error_abort);
     object_property_set_bool(OBJECT(&phb->msis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.21.1


