Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C358C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323A420644
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNnXVr4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323A420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlL8-0004Vb-AX
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlED-00079f-Pq
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEC-0002zN-K9
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEC-0002yU-Cj; Sun, 12 Apr 2020 18:37:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id 65so8551064wrl.1;
 Sun, 12 Apr 2020 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VBPwBn0xX7ZfnJO2pzvcTNAKfUhOrwNS7+yPtW8R83c=;
 b=jNnXVr4dG8viVg5rnzek32dtSW+BUhYeWkjBZ1Mts3oswQKVJpYJSb/a3xUDXGOCHA
 vcTj6IJgDVnClFLHZI6JYhj/0yWcwWE5bwqhuYu3R2xBF22KXJQQ7rCplx+QcIW/89cE
 +BBKNJ+F0zGh50S0fWJK5JqOjte0vczOmySWvgwDpImSOtGO6XoDmS35/miuuVCFR9MA
 lqgoD0i+oyqkV37MYYRKl9YG74lI7L5g2KgeKZzmMeu5Rd20XFJixQcSpiyV7WNjzXhZ
 HbTCubxFxkr3840pYFRaml02B4DpvRlESXmoIRqexkla676H2NRa5QvhYFZB3zKEwYbi
 +75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VBPwBn0xX7ZfnJO2pzvcTNAKfUhOrwNS7+yPtW8R83c=;
 b=nJoAx+l0mRuhOUd73eTLe0xdvJeL0eebz34GaMYM0JEuh0p/djsqc6GfW3gnLOnzHG
 xQWWq/tOjfGbLOJeuRpFga5MCvNJ+29msvKATa5+zCIOYOnNoogLbfN86lHPc7DTVHE3
 dLQ6kf8k5/ClAWscHbnN2C7CmUZGiCTYFRPKxNhHuyVtCW3nrOLAjANB55PeHl/COGXX
 TrblDfCj7iZzPqkb4exPk8hqn7NuLzi/0O8qFpjmJnM6oXGR6qX3NnFYBHmE1dxM7dxr
 yoGONslGvUhkU7VWp6LkgOyL0+CCrINa+cI0qPmtjEm7u0BMl9K/QQ+JDxm9hSWLmG8n
 jKQw==
X-Gm-Message-State: AGi0PuZTKtCldAhE6/qsMaU5/lHJcP13klZlk3IuQcjGLqSRsGcEb4BP
 OqeOWsLuWgkUSr2AUGLUk6zaaHqi5EeUDg==
X-Google-Smtp-Source: APiQypKYGpzF10hEF4QttQt6RwdkGIqdgLe8usUiHKfLGHbyDGEYP3t/OT3l++yL/qjDLFBwfOLQ3w==
X-Received: by 2002:a05:6000:104a:: with SMTP id
 c10mr701199wrx.254.1586731042243; 
 Sun, 12 Apr 2020 15:37:22 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 17/24] hw/microblaze/xlnx-zynqmp-pmu: Move some
 code from realize() to init()
Date: Mon, 13 Apr 2020 00:36:12 +0200
Message-Id: <20200412223619.11284-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
  HANDLING: ./hw/microblaze/xlnx-zynqmp-pmu.c
  >>> possible moves from xlnx_zynqmp_pmu_soc_init() to xlnx_zynqmp_pmu_soc_realize() in ./hw/microblaze/xlnx-zynqmp-pmu.c:79

Move the calls using &error_abort which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 46 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 028f31894d..2aa602cf85 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -63,24 +63,6 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 
     object_initialize_child(obj, "pmu-cpu", &s->cpu, sizeof(s->cpu),
                             TYPE_MICROBLAZE_CPU, &error_abort, NULL);
-
-    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
-                          TYPE_XLNX_PMU_IO_INTC);
-
-    /* Create the IPI device */
-    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
-        char *name = g_strdup_printf("ipi%d", i);
-        sysbus_init_child_obj(obj, name, &s->ipi[i],
-                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
-        g_free(name);
-    }
-}
-
-static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
-{
-    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
-    Error *err = NULL;
-
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
     object_property_set_bool(OBJECT(&s->cpu), true, "use-stack-protection",
@@ -99,18 +81,36 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
 
+    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
+                          TYPE_XLNX_PMU_IO_INTC);
     object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
+
+    /* Create the IPI device */
+    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        char *name = g_strdup_printf("ipi%d", i);
+        sysbus_init_child_obj(obj, name, &s->ipi[i],
+                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
+        g_free(name);
+    }
+}
+
+static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
+{
+    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
+    Error *err = NULL;
+
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.21.1


