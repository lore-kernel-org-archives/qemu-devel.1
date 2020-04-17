Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992DC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EDA20776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmtq9j21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EDA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPT5A-0001mb-Pq
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPT4C-0000K8-VZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPT48-0001GH-H3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:38:08 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPT48-0001Fj-9a; Fri, 17 Apr 2020 11:38:04 -0400
Received: by mail-lj1-x244.google.com with SMTP id u15so2508554ljd.3;
 Fri, 17 Apr 2020 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xyfhAq09jUqei4My7pEXi9fSF/rSRpbKjj4941MXkj8=;
 b=Kmtq9j21V0Mjpr1sxe3pMW4jlqyyT4IwwYRPSZ1mZJnh7gvesamX6xuJQsSMJ5fFzR
 oKNvhlMotKPJ4b+bPxf42C4cLNfpp4Zuj7jEu6KyDgsg49sAaIFq1ohlKw3rwAKQkMxs
 aKd+R1NcCLCk1lYbbQZhDItjWXrJtAutsxAx3OjE1mg/P8yFBbNHG4QA5QA0DKqqJ4u8
 NGtmNIWDzIaH6dOYGtctP9GdYY3x8JqhSpjK/06a8WyR5jr8pd1adXN3Gm0td95O02ec
 aXMcNQieX4GMye3BGLpYbgFxbmBE5vAifEbJFl207scgho+bK7iroBIFxg1IDaYZ56ql
 OqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xyfhAq09jUqei4My7pEXi9fSF/rSRpbKjj4941MXkj8=;
 b=NkGP46fy9PErrToJUd8Ykkt4sJUXRz3uwgRxbFDgboahh52rRaKgu4XUG/eNvvoCEV
 uJti/wbgjANqfGOaRlaeU9fxOY7Km4HMms9viU8EYmTBoLm/7DVa6BV8ncyHP2LZ5Sae
 UaQlUaw4fmjR9i9/u7nEhwFA9ghVmbx40C4PBR4BnpliCLlz3TJsYH7me9BAjRwyzGol
 FTCh3EVDfJfLEl053Bvy6krbrS8cK1I4zF0glT/KRUtJ/MvLKyMR5EAR5Niqd4lc6yzh
 l0B1aZ7eBXsc4IJidPMEZhAglCDXaode0SqW3XRjJYbtG0qUzHrrpDPzwD5zplpJfCtK
 6F5w==
X-Gm-Message-State: AGi0Pubr2mszy6iXzR7yoTjBcsZs+8jPlVlhNp6A0pkR/X4rNLIryxpu
 W93ggZoK5eGmFiL/uAWgtgdoOljUf5w3Vw==
X-Google-Smtp-Source: APiQypJZZ7jsiY7M3xiM/vh2qMonhesRDcEFs1eFuLccdiote1zbTCqDcUFi1F9FEQoYQIOEoGjJWQ==
X-Received: by 2002:a05:651c:8c:: with SMTP id 12mr2538206ljq.34.1587137882682; 
 Fri, 17 Apr 2020 08:38:02 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y8sm4137575ljh.83.2020.04.17.08.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 08:38:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] hw/arm: versal: Setup the ADMA with 128bit bus-width
Date: Fri, 17 Apr 2020 17:38:00 +0200
Message-Id: <20200417153800.27399-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417153800.27399-1-edgar.iglesias@gmail.com>
References: <20200417153800.27399-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Setup the ADMA with 128bit bus-width. This matters when
FIXED BURST mode is used.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index cb0122a3a6..94460f2343 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -205,6 +205,8 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
 
         dev = qdev_create(NULL, "xlnx.zdma");
         s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
+        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
+                                &error_abort);
         object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
         qdev_init_nofail(dev);
 
-- 
2.20.1


