Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903EC3F2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92552469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRxNIcER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92552469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7RFA-0002AN-VK
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 17:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REI-00018x-Qn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REG-0003ko-BZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:02:02 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7REF-0003k6-6T; Thu, 27 Feb 2020 17:01:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so7951003wmc.0;
 Thu, 27 Feb 2020 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w9GsmGdCeDlovWnkHL5RzV48eH16cTZY3b9rQUOLBwU=;
 b=SRxNIcERCgH0LrWsW75smZfdKOtL2lX4ZYJvUBFMq3CNSr7xgFGS6nqUbtW2O4hYm/
 GncxLJVBpL1pkTQqU8Ms6BDHydE8t70w8rrXNv1KtRFDQCohKpTMKSjzCUYAu0SfI+aH
 xk/S51ufxF4CRMEUoJbPBdP69eXGP3oTEbPcrZsONtJHn6ClbTp5OUoR9/2h4kMwOts2
 xEQAKmUfdydcOc1qEAPI0WPwSOnZEJaPu60E/gn3f5/YSBYKM4fmB0qnonn9nn3b+Im4
 eN8enXMq/aPB8uhPknZPvPsVZ6ASYRbNL+L/mCztm/FKJmFrbvPw08D+uIwc4w+NNFwc
 nIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w9GsmGdCeDlovWnkHL5RzV48eH16cTZY3b9rQUOLBwU=;
 b=mFTOPQCLexVe7IuRwzCC/Q00XlfyCH2NV1vSQVDL7gDJXaNEGdNJqD5US6RYvi/nYS
 Ls0Lk3TNuAFqRB4gbDoFkYf4NrMb0gnYdU04JPskb7aMHoF4Au8BAyB57TpV+Tt9bKNb
 M3RoecPaRtaIGYn1zu0uLoOELlzaR6pXjwCXsV7es0Aj1DjJafgbdVY9PeVJl4snOth9
 tRtyjgUlvj9hZD36JErmiONi4zDH5zuKYU6X9KXBu63kVkcmPFaVGlcL5mOsHoz7Ev/w
 lRUitjPfQzlpPKUWnKg3GWqIgUJUyhqqfipbSvl1aZJ0Fl9FDFpLjBvZ9GqSM/S7b97/
 Sj5g==
X-Gm-Message-State: APjAAAXGUBGzpkm26xIJ8YQu9xHctiKxOILqfvrn3LPzkAYObj9X8sB0
 GtY9/xz8seTTh5ustZroPrLvcrFA
X-Google-Smtp-Source: APXvYqzkvXHwyxUWqTLeAnLIDGswJN6riHMajmUwLdI9F+97U8m/u2kjKFWg7oxvywN8fFgFurq0UA==
X-Received: by 2002:a05:600c:2107:: with SMTP id
 u7mr884038wml.54.1582840917494; 
 Thu, 27 Feb 2020 14:01:57 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z14sm6447040wrg.76.2020.02.27.14.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 14:01:56 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] hw/arm/cubieboard: restrict allowed CPU type to ARM
 Cortex-A8
Date: Thu, 27 Feb 2020 23:01:47 +0100
Message-Id: <20200227220149.6845-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227220149.6845-1-nieklinnenbank@gmail.com>
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Cubieboard has an ARM Cortex-A8. Prevent changing the CPU
to a different type which could break user programs.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/cubieboard.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 0195925c73..010375f0a8 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -30,9 +30,17 @@ static struct arm_boot_info cubieboard_binfo = {
 
 static void cubieboard_init(MachineState *machine)
 {
-    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
+    AwA10State *a10;
     Error *err = NULL;
 
+    /* Only allow Cortex-A8 for this board */
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a8")) != 0) {
+        error_report("This board can only be used with cortex-a8 CPU");
+        exit(1);
+    }
+
+    a10 = AW_A10(object_new(TYPE_AW_A10));
+
     object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
-- 
2.17.1


