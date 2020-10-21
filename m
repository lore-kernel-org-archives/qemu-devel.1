Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC3C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758D22224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZlfdIDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758D22224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI6h-0008Ff-TB
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0u-0002uc-R9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0t-00062Z-Bw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id n6so3918711wrm.13
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=stHBs8t1SdzbGJ1mjGKIp/i5L6krBUedXaMQsIqK+Xk=;
 b=CZlfdIDVWJE+WicDutKs0fe97832DbicIN5v0uHVioOSSxbYs7Hc+Rle1EnDruFM4A
 TrdAktW48y08obRLppBLHpPM0k6MhK2PR48Cd3WK0PzRdDQocH7YAUr3hJMbVKKRzCZj
 WfCHQYMyfWmzsczlRmud92PQBloWA3wlwGKqqSBbOrcUhYjs8ZkHZl5XW1g441pWFIrj
 GHNHpx2qlUkbQivQ6bjEvg+BGJmNA5s8B2afH//9aD03U3UgvUsW9QJReSeKvEicwyK3
 v5UYUk8O2YRA5Z1bzUlMNU3DuZdVv0G2Wdlq1F847WzU/94VolcBlqEeVBeY4JYNYYrj
 J61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=stHBs8t1SdzbGJ1mjGKIp/i5L6krBUedXaMQsIqK+Xk=;
 b=YI7R87MFns+p/TkI9zrJialIgruheSDHGMGQeVW7OArYbLPBfJL5rgyCij9RsKwB8Z
 jFRZv/g4TxD4eyQOB5OA4f9ULqZiwyIrdHvsDKPX3p2ys6lHq+Cgtgj8RlHaDXm717iz
 LRXf9pk+/l6THVjph3mMZI+Z4Azt2D4RP1oUV7JU9hy1vhoeVJFqr08oDjKTD1mwno+P
 9OhVvxxb7daTuKI8kY6/3tIrD+4TF64CeDD7aB1sgFRUBOB7129MevlKznofLVF1Ojiw
 pLmx1+r22ilJp1yGb+SXl4onO17hfP/VHdq8jlpLUeiI35CWFKNyOEQO2AKItquidqMk
 O3iw==
X-Gm-Message-State: AOAM531bMtYJhOiQ+lONqToIj62NuDGk89JTm2dxl/Xmr5pMOj5fDq9B
 fXEcVU1/gAzyliLIRAspmoaN4hLU+Y8=
X-Google-Smtp-Source: ABdhPJxYq64l9aFQQCwVRNijMNgW76q9BdpDf96cjI9Mxf2A0X7HxcaV+PivV7veNtOE2r/lpOkUFw==
X-Received: by 2002:adf:9c19:: with SMTP id f25mr5981425wrc.366.1603301701831; 
 Wed, 21 Oct 2020 10:35:01 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u15sm4411740wml.21.2020.10.21.10.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] hw/sd/sdhci: Document the datasheet used
Date: Wed, 21 Oct 2020 19:34:39 +0200
Message-Id: <20201021173450.2616910-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add datasheet name in the file header.

We can not add the direct download link since there is a disclaimers
to agree first on the SD Association website (www.sdcard.org).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200901140411.112150-3-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6d4603f5b19..ed717ab549b 100644
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


