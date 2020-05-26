Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D305C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1A520776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzU7afDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1A520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT4w-000760-3J
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzU-0006oO-8q; Tue, 26 May 2020 02:23:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzT-0002Ty-Hn; Tue, 26 May 2020 02:23:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so10795364wrn.11;
 Mon, 25 May 2020 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xkslp0bcUbSqRBvOaVQSgMmVi3d4Gn9gVFXVfSGdOCE=;
 b=CzU7afDn/BrEvMaSH98TXT4W9PACIV1YcfWxyjMs55LUiGmtUnIaOqeajwVGl2zpef
 nc9Rhv5za0ebqaE7h3wljCBH96II3Gl92jyogxwZpkJUXbFlsCzXX4janDF5wDb9ZpGO
 M75cQNfpQlu2h0auJIT6hkuiYSQ4pa3X5eAb/2fS3PBGlZoGhRuazjq4405v8AFtCRUm
 gO0kTyONHKFNikVUAl2YUYWRi/FmOpmjni5h6T6NRN4LAPSueSw9yfoJddd/QjIysGBZ
 iQBE3tQJusFJ4/gh2EhD80u2XX56H8/QGwYCX/RlPMTJpaeUE2se1UdwkpEhBDbH/9Zn
 2dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Xkslp0bcUbSqRBvOaVQSgMmVi3d4Gn9gVFXVfSGdOCE=;
 b=HswH8pgK3cA0RPuAqo0QS9aMtkfDyiyweqBadp9nZ+h8dBK+4TyS0SjCAnIQrPfWax
 KJ4ZWMrkjP8uPbZ/ZRXoNTUBuTrypY+TtRMWnFFKt79XZ2av1Ua7R1h0qh/O3xliBVQf
 VO4ose4l6DCjqr6ZH7fDux8/xupjqH+RjffiWlr+oisQy7i3FlKFMwRQlwGj50cx3Ekb
 9newMWNJojb00+1xUHUq85jF44sngmxD+uzeQfSyBmOCXfaQBzDKCK9mNm98S3eWSw6+
 9SBreGqIeQpx/o9yA8ZhVk3iUjXApzhGcEDoohyIBFSNskbHg75YeIq6fFbbCeSva7yW
 Fyyw==
X-Gm-Message-State: AOAM5300SljZft/gEQiAtzXGpK1rinWQ6zlOYUYiTcQYyF1ql6aRPXsl
 pgxgOTfzygkAJtaMLLxaJNiCUmuHEyM=
X-Google-Smtp-Source: ABdhPJy7XOuIvuPd87YUcyvN9PZYOFHqfmyIpeRi6JHHiJCZ7llcN4A6zFOZagd33VrieZQPGQ5QxA==
X-Received: by 2002:adf:e682:: with SMTP id r2mr17707267wrm.378.1590474185418; 
 Mon, 25 May 2020 23:23:05 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 07/14] hw/display/dpcd: Fix memory region size
Date: Tue, 26 May 2020 08:22:45 +0200
Message-Id: <20200526062252.19852-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory region size is 512K.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 170545c605..0c1b7b35fb 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -1,5 +1,5 @@
 /*
- * dpcd.c
+ * Xilinx Display Port Control Data
  *
  *  Copyright (C) 2015 : GreenSocs Ltd
  *      http://www.greensocs.com/ , email: info@greensocs.com
@@ -137,7 +137,7 @@ static void dpcd_init(Object *obj)
 {
     DPCDState *s = DPCD(obj);
 
-    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x7FFFF);
+    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x80000);
     aux_init_mmio(AUX_SLAVE(obj), &s->iomem);
 }
 
-- 
2.21.3


