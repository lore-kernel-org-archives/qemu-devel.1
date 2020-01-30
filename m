Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F2F20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp1A/mzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F2F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCZM-0005kc-SU
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTr-0005Q1-P5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTq-0002uD-5c
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTp-0002tW-W0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id z7so4712261wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UzVFiyTiykHkcKgH//yZ3pEUHW70bVNjESf6/edPRD8=;
 b=Qp1A/mzSJZj31L9No0cBBIUMFz9ZLdIwKPsX4dekMBzZWsGMt5xD2btpDqGFiikeyK
 Iqkr7e3KN+yTpvcQHsXyB1Fq94JOWR00nlVXlbKBvP8V6Vbs5Jw4mgy/aHdOQnhngq8f
 ltTRz0K092TYqfLUrip3HG8y4gZhkDsBjT9MCeO3IO/9yBXh/6FlGaP97qcRp0TZbz9a
 Fz5xvPMVvOtDOZ8+Xsh+4E6jAIlf65fuTsfXMdHnbtdwFzClGN/E+Q+80EIQZdzaqBqs
 aUmWcuadiHmraxq7PavmMMZ+hcuaC52NHt1NT1hJoM8/mexsBcu/5hoX0KHCJDyoRrY+
 x3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UzVFiyTiykHkcKgH//yZ3pEUHW70bVNjESf6/edPRD8=;
 b=T0SAIxM0Cyxhe70HVjQs/Rm/A/B7ypIL3Cs8sgxtk+dbsrldLSJB/8/9wdA2FFaj9g
 a3Gkb3QLbdCkS3hKnp944LWNTuF6Qzb0hdOjk8HYq8kYg2mE8fy8I3SkjPiurynQrU3Z
 kGMRqjNyBA4PvXQgjbOmzrJyDPKsuPCupNrxvyydDdUlx9EWKm9840SUoQiCVmmaifZL
 UvPnHlVakeEzGsIgk2dVTg4VcbMx9gYRhMQyYWhJIBtRXzmR7A4S2rqXvUgBYdiYyrLP
 gt65jfMV8GDoK51t+GhxNvE8BEk7ChhMNePo78thx4+8BG4w6kxpNdjFRyB8eGXFdZKp
 JI8A==
X-Gm-Message-State: APjAAAWbJ7d5ZGabblHLh6RvsITK3McgGzECeWOHTesP/cvKb3nG4rXc
 K7SlR5+5EreotlMCuLiyUNqas4kZ3HDD/w==
X-Google-Smtp-Source: APXvYqxvv3qVktcGWOaGWzengSaV9ppkGLYeasr61nfylr/AtthPUXC6nGelMF9qVONT0mylVZ3doQ==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr6353791wru.411.1580400944659; 
 Thu, 30 Jan 2020 08:15:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] hw/arm/raspi: Remove obsolete use of -smp to set the soc
 'enabled-cpus'
Date: Thu, 30 Jan 2020 16:15:15 +0000
Message-Id: <20200130161533.8180-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Since we enabled parallel TCG code generation for softmmu (see
commit 3468b59 "tcg: enable multiple TCG contexts in softmmu")
and its subsequent fix (commit 72649619 "add .min_cpus and
.default_cpus fields to machine_class"), the raspi machines are
restricted to always use their 4 cores:

See in hw/arm/raspi2 (with BCM283X_NCPUS set to 4):

  222 static void raspi2_machine_init(MachineClass *mc)
  223 {
  224     mc->desc = "Raspberry Pi 2";
  230     mc->max_cpus = BCM283X_NCPUS;
  231     mc->min_cpus = BCM283X_NCPUS;
  232     mc->default_cpus = BCM283X_NCPUS;
  235 };
  236 DEFINE_MACHINE("raspi2", raspi2_machine_init)

We can no longer use the -smp option, as we get:

  $ qemu-system-arm -M raspi2 -smp 1
  qemu-system-arm: Invalid SMP CPUs 1. The min CPUs supported by machine 'raspi2' is 4

Since we can not set the TYPE_BCM283x SOC "enabled-cpus" with -smp,
remove the unuseful code.

We can achieve the same by using the '-global bcm2836.enabled-cpus=1'
option.

Reported-by: Laurent Bonnans <laurent.bonnans@here.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200120235159.18510-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 6a510aafc19..3996f6c63a4 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -192,8 +192,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-cpus",
-                            &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
-- 
2.20.1


