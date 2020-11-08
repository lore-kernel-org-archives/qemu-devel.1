Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC17EC4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466EC206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAWB74L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466EC206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuMi-0004BL-D9
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKq-0002TN-Tn
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:43:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKp-0002FA-8t
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:43:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id v5so6439277wmh.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZ7rBipTKKb/oioa2rrfZq9jThonQF//eO/4l0XoKyI=;
 b=TAWB74L0iPa1+/0eZO3xVYo4Ak2YBrRNlxxjJeeAQF9q3e0TvAO2t5Zhia5UjxKtPo
 2CL/b9nHG+wyqEjpv5norwzGWYYmi+AE7fExHc/0M/k8wW0ewjJkAe624Nx4GQg4N4S8
 vDv3pVwFtAPFXluckxZy7LiSmhz+c1Ry0VR4WszDWngUzuZgwKGuxgV1Vh2/BWZ1PvV5
 XVSbaeTI2DM3+EFjsXuzPMUAEm20fllwNvu/dpXDtnKzRhar5u8Dn0vLbUmQzqvnAtM3
 qPFcs95yYKrDPRr0GxZuLeZObyCjaLqXWXdssCTqstvFFMadHEGCVW8XvrQTJ1cSV/Kx
 xHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pZ7rBipTKKb/oioa2rrfZq9jThonQF//eO/4l0XoKyI=;
 b=fxWzrubc6nzCy3IOSE42jWU51wlT1x9DiSXQxUzZyOx4wO6C31YuYq1xjad0cR3fkC
 2GaM3sGfHB0t3uP8Iw9iKmUWSqbz5MCKSLKP5UgUSggrl2k2pnbfrpp9PppTiKY0PTev
 Gl6h/W9q1FFfbNQWCrYUO8OUX+JyxgnALhl99eAkZGjgX7+LxMLufC/mfCwU29FfdMlG
 xIfX+oQSHvg0mxwc7ITyEtyBOjHYCYnAcFma7eF5Pj34AZeYti/WXhrY2R80NvOMwuDD
 jkYet8UISJL0EPIYiUGO1QBkqDM3JR7DsothdJE4vGBC1ZlqR1r3vitGHcMlKJ5k+pUU
 oQiw==
X-Gm-Message-State: AOAM530n4UN3LV/Q5th/mhFHOG+Jsn8zFDZkDZ962aAz92VlmfZh3R+t
 wrx3qqXLcQ8b/Ia0VVQgtLrcY5p/wu4=
X-Google-Smtp-Source: ABdhPJxHHmCXqtltdovTPDMCeJbKlBppRVSYDARDsf2gPmzuZ1H5zmVkXLEkjGwCD2HHYK8FYPnHDQ==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr11409605wmb.39.1604878977356; 
 Sun, 08 Nov 2020 15:42:57 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id q2sm5431060wru.76.2020.11.08.15.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:42:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] hw/mips/boston: Fix memory leak in boston_fdt_filter()
 error-handling paths
Date: Mon,  9 Nov 2020 00:42:34 +0100
Message-Id: <20201108234234.2389789-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108234234.2389789-1-f4bug@amsat.org>
References: <20201108234234.2389789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that the error-handling paths in the
boston_fdt_filter() function don't free the fdt that was allocated.
Fix the leak by using g_autofree.

Fixes: Coverity CID 1432275

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201106175823.1650-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 3356d7a6814..3d40867dc4c 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -349,11 +349,9 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
     MachineState *machine = s->mach;
     const char *cmdline;
     int err;
-    void *fdt;
-    size_t fdt_sz, ram_low_sz, ram_high_sz;
-
-    fdt_sz = fdt_totalsize(fdt_orig) * 2;
-    fdt = g_malloc0(fdt_sz);
+    size_t ram_low_sz, ram_high_sz;
+    size_t fdt_sz = fdt_totalsize(fdt_orig) * 2;
+    g_autofree void *fdt = g_malloc0(fdt_sz);
 
     err = fdt_open_into(fdt_orig, fdt, fdt_sz);
     if (err) {
@@ -380,7 +378,7 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
 
     s->fdt_base = *load_addr;
 
-    return fdt;
+    return g_steal_pointer(&fdt);
 }
 
 static const void *boston_kernel_filter(void *opaque, const void *kernel,
-- 
2.26.2


