Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA6620675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amx+bG5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA6620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGVn-0003qX-MY
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTt-00019o-9X; Tue, 30 Jun 2020 09:39:25 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTr-0006J3-Mx; Tue, 30 Jun 2020 09:39:24 -0400
Received: by mail-ej1-x643.google.com with SMTP id i14so20647699ejr.9;
 Tue, 30 Jun 2020 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+lTrHlDODPJpVtiU5OSZTdaw0jvk522ED9AiYmpwBdo=;
 b=Amx+bG5IOb19PFGlatNgqyoTpsPxQdKJ9xNkHVrIWxuCXan9PQgwJcP7S/yzcIFUE7
 VQ8x1gQzFn/de21TbiIUd26uNey+ybBOAr8dZ54UwZpJycyQal2C5XtD6Q4vDCjpuGTM
 pQxGg/kn6tzbKmZkFSEEAWGVvSfEcsB3S+BQ8+NOXJ114vSglrlGsFqHALxhQggh/mu5
 E/aV58HghfMugC1bH5wSpX66SmgsNuUYayDPG2fCzE2lJcuhnvmJxtwjjNzTtCnh7SMR
 9P2gK2M40rN8bUtumOXeOItLLkG4ycxDsnQkAY0pfGvayHpukI4yHDtrCIAcJ4fQA3C/
 8RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+lTrHlDODPJpVtiU5OSZTdaw0jvk522ED9AiYmpwBdo=;
 b=hdwKk6HvknrPjLhSwwdJG3/7vlvHOdrM5WqUSSjwgc2K4BtqdeUdxIdwzenZo3uIqM
 c9DC3B9M9kLnCs5P2nOM9/Ic5cjTppI6E2uinD1eeDWqyb5wbpzvkSHTOii0woouSXfi
 cSb8LZUkYwGW7gJThxPFbqdoNZvSAgQgaJJbU1CLXPqVn6AJp2WBElLcYTBh73zHFtsx
 V7R8hju9LRjrT0+EOWOn666JOz8xKITyjiBPL4JdPfhoiP4tJsm7UFxkXrQmjX3R3B7L
 Ad+oBF/8pvPCmnOeQPGD+44+FehD4jpt+ZNbyaI4fK9MDLabawNVOppvggrp6EQmpKb3
 5dQQ==
X-Gm-Message-State: AOAM5333AhKNy+3kJlu3QQ0EeOLl70y4SmvAgCFWuY74Q1SyGFWPTLIw
 1/0okNyXYauEQhtscI9nN3rEiOjDYOE=
X-Google-Smtp-Source: ABdhPJxAF7cCd1uIHgOnnfaFMLvVJ/8HUZI2UXvzdwvUsq21TylrJsTovPjBPhA8f7CKv0ex0G9TBQ==
X-Received: by 2002:a17:906:7ac9:: with SMTP id
 k9mr17639635ejo.489.1593524361714; 
 Tue, 30 Jun 2020 06:39:21 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/17] hw/sd/sdcard: Move sd->size initialization
Date: Tue, 30 Jun 2020 15:39:01 +0200
Message-Id: <20200630133912.9428-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move sd->size initialization earlier to make the following
patches easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 871c30a67f..078b0e81ee 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -558,12 +558,13 @@ static void sd_reset(DeviceState *dev)
 
     sect = sd_addr_to_wpnum(size) + 1;
 
+    sd->size = size;
     sd->state = sd_idle_state;
     sd->rca = 0x0000;
     sd_set_ocr(sd);
     sd_set_scr(sd);
     sd_set_cid(sd);
-    sd_set_csd(sd, size);
+    sd_set_csd(sd, sd->size);
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
@@ -574,7 +575,6 @@ static void sd_reset(DeviceState *dev)
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = 0;
     sd->erase_end = 0;
-    sd->size = size;
     sd->blk_len = HWBLOCK_SIZE;
     sd->pwd_len = 0;
     sd->expecting_acmd = false;
-- 
2.21.3


