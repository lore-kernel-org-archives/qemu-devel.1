Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26BC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF21520780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkLiE5rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF21520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO08o-0001Lm-TI
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsc-00059b-Mx
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsa-0002zD-U5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so3210493wmi.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Y9QAXyCiJEecHCo6d8W/TvowXPNACal12JRPHiqZM5o=;
 b=gkLiE5rvgZITNQ4D3ztfYmUIMxNWVbDr9JPjXZqX+wDzn0Wo3iSuXpv1nCYitE5UL3
 c2KKPCR7Zjzcj0y5V+983kfUBbKHPO6rFV48RrSf9qzx9ndkk6FoAoZqGWtcfh6YlVWq
 X2B6o/bc8R/J/ekkxlOTeos0Di5cT6tIXcejOGc3NtadlgmCABBMz/6K3ya4JmIZncSO
 tfq/CCPAmaZ9SBInKoq1gwGusPUNEBkPjdYq7SeJvHF9n2/Bwrm3aZ1yeURVWQ67aj96
 YvWQ6+9bboYEadf4pp4D/AKT5N0+2WnykLcO+6LNPR9/51UlVfqBvW8Sb+cEBPBfW+0y
 VgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y9QAXyCiJEecHCo6d8W/TvowXPNACal12JRPHiqZM5o=;
 b=ERNs1zn8qV8aJaefpTyPlKYYPGRiV2PbYutqUP3Lkc0aV9T8Cx2GTVJGDSkUG/HgyO
 urJfh32DM3XLcfV+rAgwijjidgJjbg6/OE7O6KzrDS0eww+uWdg/l+zThzJZ8YIc+Pjj
 ITqYZaP8Nfyu6Lj+ObRtV1CI/cXRZlTu/DjhUZiQpb+AowgW+fxeo4ltdvI9S6QCWwMH
 0zwxvJ4jpOY6MyUxZZQx6EJEHRJe2wIsXyek4LxaC6sSWwlHVFfk0qPM1Zx411GMDybF
 4rQlmZW8SLoTIG8D+bkHWp/GEz8W5z/e86kdco6kWOSj+y4iWQpB5HvF8EBFs4rPTpj+
 QjBA==
X-Gm-Message-State: AOAM5325kbgXNbGQvPID26h7Ps8WMM75/9VZJdjdtht4nl8c9e4tKfaF
 bVkRVMrdAUO22/zgLXtQtQcNp0gdv43rSL6F
X-Google-Smtp-Source: ABdhPJzE3ZWm8fl575N6gh2T77sJF+IGK577O3lT7Bjvfxk8XwH0M3Os8/55JRELsLlsQgUWoWdUhQ==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr345967wmh.103.1601563699175; 
 Thu, 01 Oct 2020 07:48:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] hw/arm/raspi: Load the firmware on the first core
Date: Thu,  1 Oct 2020 15:47:53 +0100
Message-Id: <20201001144759.5964-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The 'first_cpu' is more a QEMU accelerator-related concept
than a variable the machine requires to use.
Since the machine is aware of its CPUs, directly use the
first one to load the firmware.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200924111808.77168-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


