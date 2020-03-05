Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D75F20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+pNFh/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D75F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9thz-0001HR-AU
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPL-0003kw-1O
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPJ-0002jt-Iv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPJ-0002j5-Cg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id u9so6433675wml.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6W8jzw/Q8S/83WHGlolRYzdtVt9ZYOyZtLguuMV9df0=;
 b=s+pNFh/bqnRhFSESXDAQaPTs4lsSebmTBi5mPy+rxTau1/R/kKdojmbCKPaePk4EeA
 lPX7XZhglWReqR41vsawiWZomT1ssXDaxGj3n/cKxs4Bm7z4Y1thwUMGGhK29Qpm51+d
 LvasBo5O5MV9PJyt/BpQTcSM7ocMuNYja4Ra9h7G5wH9SZljSyhxXyRcU5n4LhQp+b+1
 P/5pDu4jO+CsEJYgxT7FJvV/osP9kaGs/Vtks/fj+v+x756188pOWWXNo1hGCwI+gogJ
 /cyNi1UUZx9aOmUfLy9oqeMx1Z5a3xS/WqqgxxstRL4k/UL+i9SQJIkzsadELl7FgiOc
 d3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6W8jzw/Q8S/83WHGlolRYzdtVt9ZYOyZtLguuMV9df0=;
 b=nQ7vos/BM/qlSuix0BeO2Jx89BznRTb3iA+ihwJ87oQ54NO6j11ZXHMzeTfj7k8HvQ
 Wvxr5vUgSpwPzbid9K83PaD/DK4yox+CEAuc1jbsIU293TB2vqxw2vL5Jpa1O7aYMARW
 OfEjiGF/4l3g4QVPvRBH0urwopSezONyNDsLfXjpu+G2CrA6gNnJGcy2vWH3EIxfc1+V
 3GuujuoFXTaJHqimOrw4+RfYX/3M2aiyOgfdKM6XWPrDe1NupjglUgshsQioIsB0pqms
 I2LaowLtd29A9aFyG4+3oT45Tkh7zXV2eIFkxkO7LLoFNsCYlR54QfS/tTQdoFQ+Wq40
 K16w==
X-Gm-Message-State: ANhLgQ0JNUvywjpvEOZ5MTcUX+W3O1W8+LhGWw5WB92BsHcFIZoATr9I
 tmEiHblAgjAi22VysvNrLW7nwqdklC7TQg==
X-Google-Smtp-Source: ADFU+vvY/Si3GfXHWBKJEipssf0WPzEazhTHczZOsV/G5TzhEobR3JILWVcQCpxfXMxz2l1YoA7CoQ==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr4973274wmf.88.1583425891883; 
 Thu, 05 Mar 2020 08:31:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU
 in machine definition
Date: Thu,  5 Mar 2020 16:30:50 +0000
Message-Id: <20200305163100.22912-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Cubieboard is a singleboard computer with an Allwinner A10 System-on-Chip [1].
As documented in the Allwinner A10 User Manual V1.5 [2], the SoC has an ARM
Cortex-A8 processor. Currently the Cubieboard machine definition specifies the
ARM Cortex-A9 in its description and as the default CPU.

This patch corrects the Cubieboard machine definition to use the ARM Cortex-A8.

The only user-visible effect is that our textual description of the
machine was wrong, because hw/arm/allwinner-a10.c always creates a
Cortex-A8 CPU regardless of the default value in the MachineClass struct.

 [1] http://docs.cubieboard.org/products/start#cubieboard1
 [2] https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf

Fixes: 8a863c8120994981a099
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200227220149.6845-2-nieklinnenbank@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[note in commit message that the bug didn't have much visible effect]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/cubieboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 089f9a30c12..0195925c73d 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -68,8 +68,8 @@ static void cubieboard_init(MachineState *machine)
 
 static void cubieboard_machine_init(MachineClass *mc)
 {
-    mc->desc = "cubietech cubieboard (Cortex-A9)";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->desc = "cubietech cubieboard (Cortex-A8)";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
     mc->init = cubieboard_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
-- 
2.20.1


