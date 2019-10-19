Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D92DCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645F020872
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSEyfflr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645F020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLycK-0006Kp-Hx
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRh-0000SH-6L
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRg-0005f1-1T
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRf-0005ef-PY; Sat, 19 Oct 2019 19:47:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so9572273wmh.2;
 Sat, 19 Oct 2019 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O5oiXx5QsqcxjGrnz0sfvOqjkOSxCB/5RAZrFYtWlbA=;
 b=hSEyfflrQ3eukOQaelqiuw7eyOdcySc7vTMK2pnmAvEE7J1zsr9JlhoMrJoMDunNbM
 5GDZNNr15LpFVXKt+vJJDjWu7wT42+PZJqSyeoBPEdsAgTEUQRUrUOi/3EXNgwdO5Jcb
 w40OPmiaSfd7NJrYoxTbfBvk48iL/mU5Q9+qeOCGjskdY7fxmPCfMsTANaPmoLbFW5Xh
 xonxBvtxotLD5L/CXpfgQ/nlNUpt927sZFnnykOTAn3/1Owpf8rbWwiXbkXqq/cEl41H
 3M8ZEAQAZcxouQfiS7S3zox0l7m/rUQUZFkts13pOI37QJvOYVx8X1JbFHkuiFET875N
 /aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O5oiXx5QsqcxjGrnz0sfvOqjkOSxCB/5RAZrFYtWlbA=;
 b=D94CEFB/WuzNm2mP3dW2RniE5O1GPNQlNfn7BxjdmS6BnH8l28ZEizpW+b7waOrsk5
 btfOsHNAKT6iNoF85w6/8wyg29e/ShAjuZjgYTjTxWy0JJrlPFSfHxP7AOCqveEYWKT9
 cP7AgbNwB4thG/EKHt2pGvntJ/fbnEmPwbhwC9TI9jRuEzZNbqWIoKgN6x9UTOAcLinW
 BtTWrquKedwyYkvEteiCLRyI5ke3M+m3ZtJpC7QbaN4emnX4xZZbUdPKf1/V1L9LaL8S
 +dAFJIniNs7avhuA0MvuVn72H/S1Q3seAapiENBoF7FEmtQY2nHknpBgHsNPqS+FKMSg
 5s1g==
X-Gm-Message-State: APjAAAVSkTeQE37C4ZfdAf+ZLU/5+Vfi63M1zfwvx/L3Nyjak9uwjsQ1
 7qnK7UE+VQT0voMysAPMPbtry0M0
X-Google-Smtp-Source: APXvYqzVf2SptqGe6/JPvUC2cTQYj6I9cxO0T0camCpOVKQUvO4gEWq/6Bi0zHYk/Kkbj3noXHD+Vg==
X-Received: by 2002:a05:600c:2908:: with SMTP id
 i8mr12735560wmd.20.1571528858686; 
 Sat, 19 Oct 2019 16:47:38 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/16] hw/arm/bcm2836: Rename enabled_cpus -> enabled_cores
Date: Sun, 20 Oct 2019 01:47:11 +0200
Message-Id: <20191019234715.25750-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now use -smp cores=<n> to limit the number of cores powered
on reset. Rename the 'enabled_cpus' variable as 'enabled_cores'
to better match the new use. No functional changes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c         | 4 ++--
 hw/arm/raspi.c           | 2 +-
 include/hw/arm/bcm2836.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ada35e5620..e3cef69687 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -202,7 +202,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         }
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cpus,
+        object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cores,
                                  "start-powered-off", &err);
         if (err) {
             error_propagate(errp, err);
@@ -235,7 +235,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 }
 
 static Property bcm2836_props[] = {
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
+    DEFINE_PROP_UINT32("enabled-cores", BCM283XState, enabled_cores,
                        BCM283X_NCPUS),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 45d3f91f95..b1b488ca53 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -191,7 +191,7 @@ static void raspi_init(MachineState *machine, int version)
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), machine->smp.cores,
-                            "enabled-cpus", &error_abort);
+                            "enabled-cores", &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 787ab76738..2c3f1e6c6a 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -33,7 +33,7 @@ typedef struct BCM283XState {
     /*< public >*/
 
     char *cpu_type;
-    uint32_t enabled_cpus;
+    uint32_t enabled_cores;
 
     struct {
         MemoryRegion bus;
-- 
2.21.0


