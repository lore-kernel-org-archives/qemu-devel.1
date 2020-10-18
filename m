Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491E222277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoktLn+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFTN-00010G-8M
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNj-0001jc-RD; Sun, 18 Oct 2020 16:34:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNh-0000yo-CS; Sun, 18 Oct 2020 16:34:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id p15so8334212wmi.4;
 Sun, 18 Oct 2020 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wZ942IpuEYn6heYqqSxOTzqAXYjCwIpQoTDS92tNWTM=;
 b=GoktLn+7Kg6e5bzY1x2YW/octAubvrjSEOSOVcinXgzvkMW2KKb6meio6GyucaI43K
 B7QOFoZKew9EpnWusMPoxU/WN4FeLEVyHQu6tWY1QJTnrxmvnG9Cw3d9IGYQf8wwdrAu
 3Yyjnz6lPrscGaiQYlFPIcbGDtMLmE7sCmhoYiV8nQYjLg8CvSMTclS7yErun2PAaiiu
 RQ4BLgKuPpewRuYw1l+/FVzjQn/q4PGpx7LmHRimAVYD3QlcsH3WTAAHF5COzSNT33Gj
 w3NNBbAZ/Lt+ugNgnvY7TPo/N9g5Mh7i122cmkKvOcpJnBNlc6GqgHctUMO31FD8sDVk
 XzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wZ942IpuEYn6heYqqSxOTzqAXYjCwIpQoTDS92tNWTM=;
 b=ddsIEd7qFUfDrq0G89oPvKPdTFskNE2TL6PpZiCCaaE/FfAmVH+2tNZPkJcnNeQXOx
 pXszNkKeIS2+T1t2cynaZtsUeetL/LU3x/33Q6vhrrk2qinlQ33XhKsCVVGjuxKupvVH
 7ugCeI0NUHOq94rHczA2xDJn9ADONdMlsSNofLqxkEQasiX5uP98Aev8//9V9rL7N9iv
 WXL4hYjlcqXQOa9sFlFU1RCm4juqe2sQBHVhaDS6dXuho650NxDIfUXipM/wwIKsQ4qp
 f5IAMkVqVJ6NLglb8FyyHctKPQQLdZGPHes4Chr8S4oPtK655UzaAGSL+Y2JTfmbjiCi
 CnHQ==
X-Gm-Message-State: AOAM532mlSXVCK+MnmHWTcjez4PjkBEsUJzcZUmTjPekURzWs5MvWiYy
 6jwFatO75QVSNcfv0QGh6STAT09MEiU=
X-Google-Smtp-Source: ABdhPJxTKAB4eRLpWLWpd5of0t7AjsT/yu0zk11mLI/oldhgFRRdU4qk1ZV+lGNw8FDJ6C4XlUZm1w==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr14077026wmi.29.1603053255469; 
 Sun, 18 Oct 2020 13:34:15 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id y7sm13123376wmg.40.2020.10.18.13.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:34:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] hw/arm/bcm2836: Introduce BCM283XClass::core_count
Date: Sun, 18 Oct 2020 22:33:52 +0200
Message-Id: <20201018203358.1530378-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018203358.1530378-1-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2835 has only one core. Introduce the core_count field to
be able to use values different than BCM283X_NCPUS (4).

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8f921d8e904..c5d46a8e805 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -23,6 +23,7 @@ typedef struct BCM283XClass {
     /*< public >*/
     const char *name;
     const char *cpu_type;
+    unsigned core_count;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
     int clusterid;
@@ -39,7 +40,7 @@ static void bcm2836_init(Object *obj)
     BCM283XClass *bc = BCM283X_GET_CLASS(obj);
     int n;
 
-    for (n = 0; n < BCM283X_NCPUS; n++) {
+    for (n = 0; n < bc->core_count; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 bc->cpu_type);
     }
@@ -149,6 +150,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     BCM283XClass *bc = BCM283X_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    bc->core_count = BCM283X_NCPUS;
     bc->peri_base = 0x3f000000;
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
@@ -163,6 +165,7 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     BCM283XClass *bc = BCM283X_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    bc->core_count = BCM283X_NCPUS;
     bc->peri_base = 0x3f000000;
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
-- 
2.26.2


