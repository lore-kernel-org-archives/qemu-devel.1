Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB3C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CB822453
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im8TggUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB822453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIEj-0007x2-Fj
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1V-0003uj-Ld
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1T-0006HO-TC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id k18so3474189wmj.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DwXydEAJFsxr67ybFIbW+LVmbJToV8/GLo4Xc+I23PM=;
 b=Im8TggUkWiRcnUmFDECAQ8iBDKaO0Y1v1N/nxp6jAzi9IadnyocqH1CIsG3k0dMuQE
 RNt5EBQsI9wtTUO2QZUaPGtHNRRK1JMG22mOM6rOiWS/lGX4gSE2SDoiL4XodjOgiWtT
 oXP/nY77WZNbbAtft37sij41KwtLF0lOfhWhPgptQduCH7DxzoLHa2cFqqGFeEotD6yb
 HI4ytohulQI0b72ljb7T1YeGO96jbmGNEJI1wpaSKMtKy4PtV+4xuUtmcSbqKV4DibEq
 o8ckljxrjsd+n1yWCFNYBmoMC3TSgXpfnnv2n0Omq28LKfK/Vfff5iMOjJ8IJrprVeXm
 WYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DwXydEAJFsxr67ybFIbW+LVmbJToV8/GLo4Xc+I23PM=;
 b=Pi/tmAEd7AXBhby1M1jFtBbPvneZWFsLb0x2K6WFDHuSUnsv1P6Bv+iQ1rp6B7tJVz
 SdHkfUyDKvRmHoBktv+owI4PXwpe3oLQaACozX3CGSSozQxEOzdOIlOCaChwMbUZooNf
 irv4BHjE6l31jWfKWBqK4y+QSXiwJ64xtc12Qjaoe8EaQV4XVUaCD1Fq02qUqFV81PiN
 4yJpXLp6iu3DzDq0QsMFQsMCITa9sP44T237Nhs1kRK7EjVD36v+HzbOg397++CVb3Im
 rAy8+InaMuYEOHc4AU7p2hk1MyraYxKQm8AjqTuoQP5lJhpg1oU94h3iAkCthBT+W/fp
 ekqg==
X-Gm-Message-State: AOAM533RAry9Cg8grgu3RxGaQ0aADEhLuYZJjtC5r8cjVXSadlCgcYyH
 zl5iVOGoXn4/4oXVpCf1dmszzI1vPXM=
X-Google-Smtp-Source: ABdhPJwI6VnW4GRKD8pxDcALl9ybnwvYcPXmbCXGchSks8gAyUXet8NBK4az6hVVm7ZlcXiacyBvwA==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr2673961wmb.73.1603301738435; 
 Wed, 21 Oct 2020 10:35:38 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y14sm4274650wma.48.2020.10.21.10.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
Date: Wed, 21 Oct 2020 19:34:47 +0200
Message-Id: <20201021173450.2616910-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is legal to WRITE/ERASE the address/block 0,
change the value of this definition to an illegal
address: UINT32_MAX.

Unfortunately this break the migration stream, so
bump the VMState version number. This affects some
ARM boards and the SDHCI_PCI device (which is only
used for testing).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-4-f4bug@amsat.org>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 30ae435d669..4c05152f189 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -53,7 +53,7 @@
 
 #define SDSC_MAX_CAPACITY   (2 * GiB)
 
-#define INVALID_ADDRESS     0
+#define INVALID_ADDRESS     UINT32_MAX
 
 typedef enum {
     sd_r0 = 0,    /* no response */
@@ -666,8 +666,8 @@ static int sd_vmstate_pre_load(void *opaque)
 
 static const VMStateDescription sd_vmstate = {
     .name = "sd-card",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(mode, SDState),
-- 
2.26.2


