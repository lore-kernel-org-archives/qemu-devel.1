Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00905C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6672168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leOF+Zv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6672168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GEM-0006pv-Th
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhP-0004qW-FZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Qc-VS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002MR-Ms
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id w12so6998098wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E0vrTAwIv6ImSaBw0xYQfg0MNy/68XI1n9XoOMzTabQ=;
 b=leOF+Zv+h/f/cgJwoXkO7fyLLgpd1G/AvHaIOQTmeB+QRKIpp97l9rqpS/NeHABKZK
 9xjLKlprdsWUtNtLgjMh4r3ZdSxVbdEN0y/dTt8JlupyhRk3aG/ZlwP+kgvfbzdQWKmW
 HHq02wsS51AYwotUO6XTntiogGEkeprma1EDpqswHOu90T1XiVikGM4ZZLDLncrYN0RP
 5YBTSfSxQwDgrfupYPVCMY3G/NJAZUfNlOw6dat5Dm6gPVlP9r5PrJN0BviydZQIhDTN
 anHX6YT8tYTCteyGg69uWCbhKawMhM7UV5O+jCKEa6Q/8J0pcfbyW4H8aaqQSxBos2Cw
 OGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E0vrTAwIv6ImSaBw0xYQfg0MNy/68XI1n9XoOMzTabQ=;
 b=aXY43MpKXqnKhBrmj/LaixrHPPJzQbjmRhEhTVpQI4iIgCJ9j2zqIj3OdWtRd5F4hM
 eMNXTnje1KHD4wDLhsI9Wkc/o5DCSffcXiRtbGPXwf62XqmCQHCO3omrmhjd9EpH3uTl
 Zk+madHPyp2RxQZUsBkBt5mFUDWUAByVgcYD9NZiGeyf1suDiW6Gk9zvqz2snjm5x3mL
 HReenvVZxv/rtA49fHvfmllv1GSNLSJhU27glf6pp76T3488ASGzNTMjWSisUJAuMHnj
 wXATQ3DJNCSP2T/CI9QVOE3D/zI3JrmGshxCm5HFyCNujN43ojjS3mRhhQlg/RvKpY3O
 TtRA==
X-Gm-Message-State: APjAAAVh+tnezk2T34KwX05reSYi/jgDGqr1n36XSJWM1+Lcr5ozvXXv
 YxocCzllVm/9BIUWo7uyzXoYIiVAnlY=
X-Google-Smtp-Source: APXvYqyjLk7uyddIrHUkMkjSjAPyo2NP2H2fzqZM9LT+ryBrDoMflJcGpW9m+zSisPDgbIz7mQia6A==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr23351406wru.220.1581604954486; 
 Thu, 13 Feb 2020 06:42:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/46] hw/arm/raspi: Set default RAM size to size encoded in
 board revision
Date: Thu, 13 Feb 2020 14:41:41 +0000
Message-Id: <20200213144145.818-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

We added a helper to extract the RAM size from the board
revision, and made board_rev a field of RaspiMachineClass.
The class_init() can now use the helper to extract from the
board revision the board-specific amount of RAM.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-11-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1628b0dda7c..f0dcffbc2ef 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -296,7 +296,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
     mc->ignore_memory_transaction_failures = true;
 };
 
@@ -317,7 +317,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
 }
 #endif
 
-- 
2.20.1


