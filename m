Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2904A23A1B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teHC3bGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2904A23A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPKG-0001ID-4o
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGW-0004KZ-JQ; Thu, 24 Sep 2020 07:18:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGU-0003vg-Eu; Thu, 24 Sep 2020 07:18:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so3169373wmb.4;
 Thu, 24 Sep 2020 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ic/xY7slvI0DSSOiTKsUuGtbaH5pAUlsTrPjkrl/0T0=;
 b=teHC3bGiY98HfGXrepDW2gdO8nfj9B311vXkwv9f/s9VfnsH37bfHLe5De9SVxJewP
 /d9JnF9XzCXjjeqxTdVarYZbUw/g8PlO/tSGb7OBPn7yLZWNMfCaMQBJdYGGK3+6+OBQ
 QDJwjFLz5v0yY8wkOX/p7UXmleLA1A+htHL9hLJdXhz99nAwpmVn6Qj5FAjyUr6ZUJXb
 BCqPhnt6oYcdTjhWn7yms9CGxUWF+XA76n8EtOWxmm9xuQCx99d8eAuJHAZNbeUCZhdY
 lDMP5KhLOsnDXvZCr+kKdb4W9VwV5Wi1mYeyj8Vf6BhJRpp/B/vMZt2P7pBzNBC2zmny
 aQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ic/xY7slvI0DSSOiTKsUuGtbaH5pAUlsTrPjkrl/0T0=;
 b=Mdh05pebUlagYyGn06I9T57+wW1GOioNY0YgWRFRmBE2WUdvDgY53rqwv0iQMTEs+7
 NBF/k9PuWjsDrj4pac/dZ8vrX3NCIhh3Ey0JPdipcyDaj11kN7jtJhRE4wQM31DHCOfP
 liTmi2/+MuqVANuCCG5y88yFXZyAq3hzXkc19IePnJnX1RcnaD2AsKQAqihk2AmeKQiD
 xfGAzgQK0ESEWJ+UfgYVeu5vm3+9DTVUb34hVLuRmhdzXPq/7GxIkZyjzyw9E5tW3eDG
 L6IDRXlX9srTWkUfGlIqPCiM4s1WP2VlZlpJ8ANNp+GMWMRANl7ja3nD8IfBXkx62UvH
 P4FA==
X-Gm-Message-State: AOAM533qOG2oWKuG5BnpjHEK4RABq2a3s8hA+QEO62S7lAy+a0D+eMFk
 dqN5CzOB5EqfT+PAhp9PbzYP+PP+wPQ=
X-Google-Smtp-Source: ABdhPJyRnY1hWsgCbw/Nw8Y70OTeIYRdDUYfKOUoK9nrQ6bmQ58KyEkIcvDkSCi/MAuk1tZ8F3GqYA==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr4226272wmb.22.1600946296745;
 Thu, 24 Sep 2020 04:18:16 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/8] hw/arm/raspi: Use more specific machine names
Date: Thu, 24 Sep 2020 13:18:05 +0200
Message-Id: <20200924111808.77168-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924111808.77168-1-f4bug@amsat.org>
References: <20200924111808.77168-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can instantiate different machines based on their
board_rev register value, we can have various raspi2 and raspi3.

In commit fc78a990ec103 we corrected the machine description.
Correct the machine names too. For backward compatibility, add
an alias to the previous generic name.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3000e6d57e6..3426521379e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -327,6 +327,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi2";
     rmc->board_rev = 0xa21041;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -337,6 +338,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi3";
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -344,12 +346,12 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("raspi2"),
+        .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
-        .name           = MACHINE_TYPE_NAME("raspi3"),
+        .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
 #endif
-- 
2.26.2


