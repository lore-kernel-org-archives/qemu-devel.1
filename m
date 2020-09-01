Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A8C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587E820684
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx2LYNRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6uT-0005xP-Eg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tb-0004Ao-TA; Tue, 01 Sep 2020 10:04:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tW-0002ms-1o; Tue, 01 Sep 2020 10:04:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so1665950wrl.12;
 Tue, 01 Sep 2020 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t2knO10CUldXHrGS1mVbE8WYMZ+tYlhkgjwBqXs9AEE=;
 b=Wx2LYNRzQ3tNXOzmat5fEMKtdFqNTTMd1mmaRXzY9udP4qSD/KxVn/fxGmVHpIztjq
 Vu4rloG7GVMl4JwqYVkgq5xHrqrBy/EMmoTTz1YftIerMIsN7OYjFQXKgNI17tDwDkUg
 8TC5+RtaQVyR1BKkLLBjfUt0NZPo8771h6OKCUN6IHiw4c+89eVrAmlCs0Af5K7667yk
 vbMyPGHrWsRjAienPdPvlM4f77bJFa3v44lZk8LFn5ISYS38v30DNbNaoXLkZRIkjeTa
 kOsdSzrm7tJ2nEVmVSs5iVSyhCoALPr0N4Lm782JTSkS99xEeW+ItxU+AcPzIdpvZrcX
 obgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t2knO10CUldXHrGS1mVbE8WYMZ+tYlhkgjwBqXs9AEE=;
 b=jzVNB5aadjhJpEhcJ53XQrRvy6SXP+An8XOsMSzPzTgLxIzDa9G5LdONeVI/lVsbCi
 o6fUCam3fhxBLTxxN5F2GM0ofHUvbClCVAfO4PPa7e1bCEOQtU8tX8GKIXI/4VjIi5rv
 hSqB1m/18ZyRkzzl+Hr4u5DJOj6/iTxUPMo1rl+BX6KHuL7Lrwkcyi07b+Tzgj7MMGZl
 WMVjxpl7L8AhqrONW4BwxOX81H5qFYFDiHh4/9amw6nZqmAF+QvrId+fBt8nU1hDfbjx
 FHWloOBIf1uJ16YhiWPMN+bkxbUeUA1HUDhwKNo6P5CVrQs8WQfWV6cw7obVNTEePK6Q
 71kw==
X-Gm-Message-State: AOAM531R/mj67hlTde3i8nsn24AbGOy/nmchRfHGCXAkYieyD0JAM5fp
 V/isvRQuywe6swb8bPKOojHfVB/TEcs=
X-Google-Smtp-Source: ABdhPJzqmYrDvOq3yuM8DK/tLkD/qOsHtbvB5LPp0DBdZuLWPKCuOSW41reNg+A96QPqm6j6eWUb2g==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr2198853wrr.27.1598969056198;
 Tue, 01 Sep 2020 07:04:16 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p22sm1872505wmc.38.2020.09.01.07.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:04:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/sd/sdhci: Document the datasheet used
Date: Tue,  1 Sep 2020 16:04:10 +0200
Message-Id: <20200901140411.112150-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140411.112150-1-f4bug@amsat.org>
References: <20200901140411.112150-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add datasheet name in the file header.

We can not add the direct download link since there is a disclaimers
to agree first on the SD Association website (www.sdcard.org).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e2ef288052e..60f083b84c1 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1,6 +1,8 @@
 /*
  * SD Association Host Standard Specification v2.0 controller emulation
  *
+ * Datasheet: PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf
+ *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  * Mitsyanko Igor <i.mitsyanko@samsung.com>
  * Peter A.G. Crosthwaite <peter.crosthwaite@petalogix.com>
-- 
2.26.2


