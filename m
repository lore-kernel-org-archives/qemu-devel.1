Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC65214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnnV2bQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC65214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6s6-00016U-Gg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qt-00085A-Sm; Tue, 01 Sep 2020 10:01:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qs-0002Un-B7; Tue, 01 Sep 2020 10:01:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so1179328wrs.5;
 Tue, 01 Sep 2020 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t2knO10CUldXHrGS1mVbE8WYMZ+tYlhkgjwBqXs9AEE=;
 b=AnnV2bQSRlO1dEkWrLLBKFGQlOtr2qJgaa839YT05XvcsgspoxgweUS8qsl8TvX99w
 zd/wj9O8WdOdqgtdcx4Eiko/3FrWvTdr7ThDkQorZfiQmghN4KwNSIgaZ0/L+F2v35yh
 rngGW7GrXXa7s2BcyKKaV6zQ/d5wyMuGM8rOLgKDIbDkiIPjHvNAmwDgBTlzsO61qufY
 0Tq32mbwsP+ScvSFcXXuQKGgzC/nHCmOJZbkSRfpUQBHYMmi9PB/3KeL5i7o4xVc/Nfv
 cB19NLi8pIbwGJqkHOQ8OlbzIfSjWtEh7kaKb4vMK7zpmMJ0S7IVJC6cFEQjo71Gk4pz
 XhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t2knO10CUldXHrGS1mVbE8WYMZ+tYlhkgjwBqXs9AEE=;
 b=UWkHFyELCzeF5ZnCHLBEUzn3Ayzi6apoNjvK9RtdXXQt50iP/dk77VcBoVzVV5fGQ4
 WOadk7DBIM7th51eTAxv3T/3OvmnQxBD+egLgiuNf9QpxhaUXdPZDRvzwiHGdhWDkOxh
 DPDwst8lYyS02pHQ68Ac5IWroOC82pqUFG6FODNA14drFUIZI9bfXl/ycV29zS8HiRKk
 Y/oPZjbUXzQgqH0tWm0z6bTmtxeYaNJRK0E9qB1GGpdIJhQ4ilBKQqD4Q9QFGqi+C78I
 e75SlxxvK7KiHXuRWnn15vLrmGzIZxieHyB8nDuRUKWH/R1uhXbYmES/SgOESg1j+cxR
 YUNA==
X-Gm-Message-State: AOAM531b9EX08zyoBXP0GisCBz6AD2kQb2rYubfQF+jaoaXw3SRMEHwh
 vOJ5NqbsCyMQ3S+wf7RYsItr2OBUcAQ=
X-Google-Smtp-Source: ABdhPJykHUDf5GLSst8bHYDfOu2sqFN0R4o1/KQr68rnIPspH06Cnxv9Rn+gpj4T6m/+5POxUHronQ==
X-Received: by 2002:adf:de08:: with SMTP id b8mr2012655wrm.4.1598968892210;
 Tue, 01 Sep 2020 07:01:32 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id m13sm1492107wrr.74.2020.09.01.07.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:01:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/sd/sdhci: Document the datasheet used
Date: Tue,  1 Sep 2020 16:01:26 +0200
Message-Id: <20200901140127.111454-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140127.111454-1-f4bug@amsat.org>
References: <20200901140127.111454-1-f4bug@amsat.org>
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


