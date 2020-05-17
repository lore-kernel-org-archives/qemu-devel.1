Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C060C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDA02070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGTCo5xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDA02070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM5U-0002Ix-3m
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2w-00065B-9x
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2v-0006kq-NG
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:50 -0400
Received: by mail-pg1-x543.google.com with SMTP id s10so1326099pgm.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lNXxP1UHysH4qcZU7kjQDsVfYjYcmtwzeSHzeDKdG/A=;
 b=bGTCo5xfRkQHLsx8lRTpf1rXGbpJNTEhJqxE59DZKZICVftfqeFq/LHD/zT0GHtdWE
 qcbLR0I7fILkv0tRFBWNlj/eD0An/B/LM4vRQQ0OAfHiG7oDnC+2SlfEuVT58IV3I/jd
 bWo+7FoSqW1CqsGanqTVEFETgNg9hpHkQ2yWikAwIAsvKgGzoM8w7acOgr0EhxmsNTHx
 mR49KJs++Oyp22dVO1x4D0TKAG8ArbGaiXUegt+pgJp0gyTiqs5NAAuNnmkZGVTsjICu
 09I+6Icbr3wfTr0qVXXwg/YcNeCWtmENFJySpSxTzFYPK3O+wWW7W301yN3yUysnV6SA
 DyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lNXxP1UHysH4qcZU7kjQDsVfYjYcmtwzeSHzeDKdG/A=;
 b=UcLvoqkusClcHv6A10YkD+tKYak8q0rOhmzPlNPLvtWqxEQBrkmr3p/mJ7URSCYMyf
 6bEcvLIiiPweQB7zU3OZ2Hld9fz8bcwf6rBig6/ibqibhXd+A8+K00AnFKufDXetv2NI
 l776E2N2kQYpaLZyRuQHQRMbTDOzSVNpm4bi53rSKvXhL6RSQVTlYE3SGqrikUIZ4m9o
 uymVtZ+vPAOVfVvhFI+9ICfOFvabomgxbd3zWtYZH7J7vaMQJKUlIK2pyNftaQyC2UwY
 kdW0lalQ8ehYJZgE897n2xOUN7qc8h7LatXKTK7T1Cej61gIXF5mzRuOOiu/94tl93vD
 bQug==
X-Gm-Message-State: AOAM532GRRxtr5yh86aiLiZo4PyEe/3A0roNN8s9S9i85K7R6RhrOQuE
 waMJSjUX1TQUwFWLJjHDq9o=
X-Google-Smtp-Source: ABdhPJyzEuw4HNjOP5BhNUAXPwub8K0qnSwdflkoPKVPBHpnMstGKYT5XbcY12/uazMIHohmEuO+eQ==
X-Received: by 2002:a62:3241:: with SMTP id y62mr12763178pfy.194.1589732508571; 
 Sun, 17 May 2020 09:21:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 16sm6328675pjg.56.2020.05.17.09.21.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:48 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 5/8] hw/arm/fsl-imx6: Connect watchdog interrupts
Date: Sun, 17 May 2020 09:21:32 -0700
Message-Id: <20200517162135.110364-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch applied, the watchdog in the sabrelite emulation
is fully operational, including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Philippe's Reviewed-by: tag
v2: No change

 hw/arm/fsl-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 13f1bf23a6..f58c85aa8c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -433,11 +433,20 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             FSL_IMX6_WDOG1_ADDR,
             FSL_IMX6_WDOG2_ADDR,
         };
+        static const int FSL_IMX6_WDOGn_IRQ[FSL_IMX6_NUM_WDTS] = {
+            FSL_IMX6_WDOG1_IRQ,
+            FSL_IMX6_WDOG2_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_WDOGn_IRQ[i]));
     }
 
     /* ROM memory */
-- 
2.17.1


