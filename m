Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA8C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899DB239D4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLEZuBzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DB239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPI5-0005rd-9U
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGT-0004DD-72; Thu, 24 Sep 2020 07:18:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGR-0003ue-6K; Thu, 24 Sep 2020 07:18:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so3110361wmd.5;
 Thu, 24 Sep 2020 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45JbwGiTU0XnEwI0yz801a4d2AUl+45skNEUNaweO3I=;
 b=OLEZuBzp7AbwKad6vBWF2idBQSBhdXp7gT6Lt2Sje6DczgkG1vxLwQx7r3zbZ8L7U7
 fE7+GMYyiJav0vMae2lTwOx2GPuedPJv5OQqwQnn+pfMTRVXFWwv+lcdMc3l7zZLdrEU
 dNG4IW9BHG6psS0J4N24q5+d/BbLBxEgNAUN85uwsKF6SXVqU5PTItLc92Mjk0N5qJeD
 7GY+xpSZwUIzwQaREczuJjQWQKbEAHq0RUoDK6018ryKRO8zSwAQTQu8TPwsrTFpDjFY
 hYUFm5n+kRI4rnVkk+aRlqas6NMTUBVYmGdh1c6PkZZiE5fmQ//UuRsCl6KVOknnkmbY
 xJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=45JbwGiTU0XnEwI0yz801a4d2AUl+45skNEUNaweO3I=;
 b=R3grbKGifZlGEhfTqr0QBgjyrRDT/iSVi7I9YmNvnKjaJSk3V5H4p1cahuczMzuWL5
 wViL0c0kPvPOsUtS9/QtaPKrhMTkNEaCfv0eFx13SwBHomT2bBp9Pd4Bkqi8WZdm3yMn
 j9/R8WiWU+b+Co2R5fqQeH9Y2rmRAj5wVZ44y3a16HMN8Wgzbb+0qQoeH6kUiodDPHhY
 uZLca9bVtg2Eq+y3s7Vjt+bIpNupoo+2BhuOHb8GgiARVk3bCVvhfhZ1svFgKKQFLWmh
 sBXpAhF9ORFUeUSZHAPoL9Ux5FVy/Aj0DgXT1OYVDSJ83YQS2a1oriXzl6W8xeqUgOcv
 ESlg==
X-Gm-Message-State: AOAM533I71neIhzz8UkqO96V8QzqqAPvYzPKS0MM09rKMgtL2iavrj8V
 I0hN/AGcLW9oHKzDqBaj5HtiimvBoVc=
X-Google-Smtp-Source: ABdhPJz/rf8WaiYg3QZluJPadk0tRdlgxon3S9BEVJRf2QlNKVH0l2OMy5n8LNdyu89o3tGUpxzV6w==
X-Received: by 2002:a1c:65c1:: with SMTP id z184mr4037187wmb.61.1600946292926; 
 Thu, 24 Sep 2020 04:18:12 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/8] hw/arm/raspi: Load the firmware on the first core
Date: Thu, 24 Sep 2020 13:18:02 +0200
Message-Id: <20200924111808.77168-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924111808.77168-1-f4bug@amsat.org>
References: <20200924111808.77168-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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

The 'first_cpu' is more a QEMU accelerator-related concept
than a variable the machine requires to use.
Since the machine is aware of its CPUs, directly use the
first one to load the firmware.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 46d9ed7f054..8716a80a75e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -205,6 +205,7 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
 
 static void setup_boot(MachineState *machine, int version, size_t ram_size)
 {
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     static struct arm_boot_info binfo;
     int r;
 
@@ -253,7 +254,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
         binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
+    arm_load_kernel(&s->soc.cpu[0].core, machine, &binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
-- 
2.26.2


