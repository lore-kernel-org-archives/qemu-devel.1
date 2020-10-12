Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3D42080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l07/psuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3D42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Yp-0001ro-EI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0K8-0006ev-37
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0K4-0002Tu-OM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so19820555wrq.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uLGa7c8sQ4OAbnxSGPTof1KyN/ZmObCcCUQxZg5+wno=;
 b=l07/psuPCjesdFBMYZT13MUgXL/3AjPetHlLap6dPGzgYcljjGBJMyEitsZcaMra+p
 xFu5IswDk8ET0rCkuEMHKrb5sd6y3Fg37DaOpAsRU3K4XaEdh4b1U2vCw+HtY9d8SmLL
 lIz8kOJw7iaZI4k9Y12zxGUFou12xpMZ1evSDexSH8a6PsOO3gQti68uOTP/3AvqZwj/
 qFh/UErDCCJzxRxFe1pZ/JuvhDkqeaaoMatNGaMsbz8P3URl+Iwj8hpGlRNPNOX1LXTd
 6tuNSb7CBaigDSPSJFBghaqBItUbPqocwY5AYRlhQeyU23vypsvpeLSjIkv1lDZ83W1w
 z5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uLGa7c8sQ4OAbnxSGPTof1KyN/ZmObCcCUQxZg5+wno=;
 b=RjvRV4i3FUbra4gL8ESrrg1CHd4gMy6N0abg5vOyTdu7Nc067+2U3SGfZPY3/+0T2I
 QUJZGcH1OpLYqh9OSprcnLsh2ord1624DLbsGoq3CAJR78IFnnV3cPt9yoFBSMRNN7ug
 3vfuhxBuoldSjv8Jc+Lg4LlCUtOG81fkzTIwfozgxFvCEnVOVqQFtzJru22ZnK8DEJA+
 4L9NJexOlAOxk/jpKiUbv+sYfP5/t4f2lrfgv85dNbiBI6ZyG3XC7mt17ePqjnaLG+HJ
 lCIocbDaiY8IYb78Bl6mHwJRhBzlnlGVzaTX0IS1vvkTcchJcgwbOkH6kRSvpn0PbUqy
 uogA==
X-Gm-Message-State: AOAM533ImER0JZ8vKF03Mx1BM4eLLpWbmrBMh3uFbAikmJbSdO3M3lRF
 j3PMtQWPdXnrwnwgEZ1HekUO7b8f9Xk=
X-Google-Smtp-Source: ABdhPJwXIK7uYJUEEOqAyh9n/API8eQbioMd3Sa0afblMRVgQtw2T3wa8FBse+CJOAfnxpp+ckTAMg==
X-Received: by 2002:a5d:410a:: with SMTP id l10mr28117681wrp.274.1602518714466; 
 Mon, 12 Oct 2020 09:05:14 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z17sm12422412wrr.93.2020.10.12.09.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 09:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/mips/malta: Use clearer qdev style
Date: Mon, 12 Oct 2020 18:05:03 +0200
Message-Id: <20201012160503.3472140-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012160503.3472140-1-f4bug@amsat.org>
References: <20201012160503.3472140-1-f4bug@amsat.org>
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to be consistent with the other code base uses,
rewrite slightly how the MIPS_MALTA object is created.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index fe8f6f7ef51..6c447d159e3 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1231,11 +1231,11 @@ void mips_malta_init(MachineState *machine)
     DriveInfo *dinfo;
     int fl_idx = 0;
     int be;
+    MaltaState *s;
+    DeviceState *dev;
 
-    DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
-    MaltaState *s = MIPS_MALTA(dev);
-
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    s = MIPS_MALTA(qdev_new(TYPE_MIPS_MALTA));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
-- 
2.26.2


