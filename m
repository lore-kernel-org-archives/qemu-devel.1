Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E74020747
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMKUz4sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E74020747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrRwN-0006kp-Ph
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrRvl-00062W-P4; Fri, 03 Jul 2020 16:05:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrRvj-00077n-BG; Fri, 03 Jul 2020 16:05:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so33086074wmj.0;
 Fri, 03 Jul 2020 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8wz3IctNIHsUu0EIQ+MgNQzx01ISFfU09JOuJQ+u8ec=;
 b=tMKUz4sQq5G27/nboMK9ff7nsvxIVaTRlektc1qVEpLLdZmPVIYUB71fMyOEuL1vQa
 QU0AzDRYBJJ20QAN6hUtRHKVBmzlW9lzzQOLMRTbwj5stBTrntLeu92WZJ12junyudtv
 oAihSmnXgFtyN/U5ODTgT00JDjnp4WlAH8mZRkFDxJ0Aby+9ngqDXb3oOtGVwavmqmJ0
 OP8LN97Vnj37vQ3TBdoE65321V+Rb38W0T6JEhNPZNSMoE/0IdenycCMxTNX+y1A/tIm
 tjKRMeUeLL74V2WyEEIHb1PlpNZe3hNwbq3rtBtmiL2Q2kmHk8dQnMtTW4P0YDgBxOcx
 iRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8wz3IctNIHsUu0EIQ+MgNQzx01ISFfU09JOuJQ+u8ec=;
 b=r+uKhTDtiD5JjaH2TqWj+IC3dsuJqVMSar/f/2f4Iqwi0iGyrmmxMkIjQ5iOKxoINX
 mPRujwvi9oa1VzUvNjtvAG2IzR83F96j7W4Juttes7OGXqpyypCaN1/7+HCeOUgHllIH
 Od9hpAQMsMcc7M/5PM8B9Ncnxh/Pacl6OYDoZ0YBmhssahFchAAwr0ymE7/+TjQxlgCE
 RsUVEn+c5jfNnLqobbd84fOF2BQX1dw+Rou5AfUm5AX7rSut9pKxEFMBoWEazc+2GgCj
 GNW/5EU0QJmwFqvPrTOExKqXuPA0s0BRn0d3y+iN0FrYBar1yczl+Fq0bgGd8qcamFjW
 KOkg==
X-Gm-Message-State: AOAM530CX96ICqF7QXWcEd93Ftsi6/FUNoK4g2vXKL0IMZMRvVujJxEd
 wezNVbYpwrwkg3Ml22QnoPPv+HdMAe0=
X-Google-Smtp-Source: ABdhPJxF3B4LE9NB6HUvNr9SEr/ERw0orY9rzuvMRQ5Jl3/iCeuNS+sqaLgLL6xrufQpaEhaJz/f7A==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr40236226wmc.140.1593806701190; 
 Fri, 03 Jul 2020 13:05:01 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 92sm15963706wrr.96.2020.07.03.13.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:05:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/bcm2836: Remove unused 'cpu_type' field
Date: Fri,  3 Jul 2020 22:04:58 +0200
Message-Id: <20200703200459.23294-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'cpu_type' has been moved from BCM283XState to BCM283XClass
in commit 210f47840d, but we forgot to remove the old variable.
Do it now.

Fixes: 210f47840d ("hw/arm/bcm2836: Hardcode correct CPU type")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 024af8aae4..79dfff9d73 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -33,7 +33,6 @@ typedef struct BCM283XState {
     DeviceState parent_obj;
     /*< public >*/
 
-    char *cpu_type;
     uint32_t enabled_cpus;
 
     struct {
-- 
2.21.3


