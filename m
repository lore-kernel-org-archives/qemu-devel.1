Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E3C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A182465E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOj5nklj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A182465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0ZQ-0004yb-JQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0I0-0008Lv-8f; Mon, 26 Oct 2020 07:03:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hx-0002ht-AR; Mon, 26 Oct 2020 07:03:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id t9so11879429wrq.11;
 Mon, 26 Oct 2020 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5U8VWtvmcB+mOzFUXcILRLEPHX5B//Lhi6i5VjZPllk=;
 b=UOj5nkljlDKhYh9w621rfwoxMHKbnxCtTvOi7lU7FI8flRBUzf+nAAxVssUzllX74M
 PrCAc78J5684apPjU6UYhL/KuhuqY71UuKKAmwdwasNwnpmi2JJmnl13dCB7XcPNolFx
 6mXVG1h5iHavMb7U0Y+fe1SIPZvB+a6MjUuDLLrocZXZVKZbaCDMCG9jxyhM+u7eTzGM
 JMMgD/clOYZ9B0CvxBUSnMZpCh5Hbwt4bWfrDCTDgQ/zP5UArL/awQw9T+ug6dNFp0np
 0gvos3DU+wxUabBMgH770AGviFtwxcmGng2NjgVv2S8kReNsACBy+W/d5LhxvmuFpeIZ
 pKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5U8VWtvmcB+mOzFUXcILRLEPHX5B//Lhi6i5VjZPllk=;
 b=sOR/s4UUTuzMJS5V36bu+eu57EoAmHccpVEazBKxarrUenJ+5JslYmdlBhVmHO1nE4
 7t5xA+qW7/O3KBBGlGGxBmtavw4oAOjy8E31ZySzl2b6pnuVKHiI4Mucjd3fyPbEeR2C
 gRNO5D0nYT3jJXrdye/FNeUmKWJVKPn/GgAAML5uLcF0CGF9sQck4P6cZx0j8ggT9amH
 eW9bnrhttORUYCGbr9x54CDKbNsHeJDgNnO/aXl26XauSlLlpGl1h9lhdS956yjI4Ecw
 W0Ew7Wwfy0YRsVnXPt/Ou8emQPeK0FxzqBuWKjV+ZI6Urcg9o2J8dqko8AKU+weoaWGY
 0/xQ==
X-Gm-Message-State: AOAM533cu+uSuUxD3shpipgml/MZzTkpJAhXLMd3RK8hGm0PZ+s926ih
 MScN69kPk8+EYRy37VB5v/Tjc10hJCU=
X-Google-Smtp-Source: ABdhPJwIJMSkzJ9ZdoIAXXHOUZikvdrmcf4UsVi4o8MR3oHqi50bixMugLvnZ1sXYwCqLf/R1z5AIg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr17252423wrv.266.1603710222066; 
 Mon, 26 Oct 2020 04:03:42 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k18sm21141582wrx.96.2020.10.26.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 04:03:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] hw/sd/sdcard: Zero out function selection fields before
 being populated
Date: Mon, 26 Oct 2020 12:03:15 +0100
Message-Id: <20201026110315.4026183-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026110315.4026183-1-f4bug@amsat.org>
References: <20201026110315.4026183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

The function selection fields (399:376) should be zeroed out to
prevent leftover from being or'ed into the switch function status
data structure.

This fixes the boot failure as seen in the acceptance testing on
the orangepi target.

Fixes: b638627c723a ("hw/sd: Fix incorrect populated function switch status data structure")
Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201024014954.21330-1-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fcbc1fd9d6e..30913826145 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -827,6 +827,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     sd->data[12] = 0x80;	/* Supported group 1 functions */
     sd->data[13] = 0x03;
 
+    memset(&sd->data[14], 0, 3);
     for (i = 0; i < 6; i ++) {
         new_func = (arg >> (i * 4)) & 0x0f;
         if (mode && new_func != 0x0f)
-- 
2.26.2


