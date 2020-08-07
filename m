Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86198C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35065221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idPBQodh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35065221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43Wz-0000pZ-9M
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Ue-0005s8-WC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Ud-00069f-IR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12so1872079wru.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0wMfrCT6ICupFYB6Pos8s5yLI4ofoqo+iwhJlvbtj4=;
 b=idPBQodhD7PTF3dOKJPs1ZuGd4LSQz268k1BxFidGWTj2EuePUc8J/t7KGXHYJs/pS
 UtuR/757OBNYM4TmL36jEd9fkJCiOeDrA0RnO941gxD0HghlWRe3SDIIWCaq+bvwCDKX
 +NS5pDnuHURlDG38MM+U2bGB67qi3EUl6fOMx6STJbfNm8d65GGrT7y/gpt6c2vcuK+1
 Kodhq6bcDDrdX3L9VVLQvd/8b0IbJF+wlhhG7Z+7ctC/ebO+8KdYgoKUbfe/q3j7CpC4
 tFT1mOw/TOA0mOO0niFehZd16yuZHzOp/thVmlp6ssoZmZKDZpuwDPHp9LvWfJWexBjd
 FwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g0wMfrCT6ICupFYB6Pos8s5yLI4ofoqo+iwhJlvbtj4=;
 b=afZIm/LuGFzVgmT/b+gcxbFG2aqk0aCAO+kbVQVu3OwCeRryK0F+piH9j8csucYWgk
 PlCB9b91uqmIcG3VrUs/R9+po0U8LPYnZ8EsNY4EegE6C3OMHF3iq/PYvWur+lOJyuJp
 krMm/skMDszPeXho8OnF7ZwukKA7HKF+a5+LE/WI3SvyEVY5bfGyEKMnKJOPLV6AY97B
 oEFA19STRg/ndI84kiErf5cT42lO316xrNaPochdQzGQjTzXTzDYKwbo0w2gCcq+MDg5
 ET5VfMgXPL+xEpKDk2RkPVCFUTbFoHEL27zFTu964p/rCjpgq3A4qHAPjLrR6i4f3Tcn
 pGbg==
X-Gm-Message-State: AOAM532EIDMie0A3JwjrH/mvE9enZSl1E/OKpBgXyrL3MTjx/VAc6/5f
 1R6KLgEU96dOzH/1eIavXbFLPwCq
X-Google-Smtp-Source: ABdhPJwh+TBiH5oEMMpbC+CoTiadwgs4iOSnsnfR7pquLlSXZoyy6O6BVag+hLAUh5g7cmdC+Z3YOQ==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr13173750wrs.410.1596811029763; 
 Fri, 07 Aug 2020 07:37:09 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm11033302wmb.24.2020.08.07.07.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 07:37:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/3] hw/misc/unimp: Display the value with width of
 the access size
Date: Fri,  7 Aug 2020 16:37:04 +0200
Message-Id: <20200807143705.30066-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200807143705.30066-1-f4bug@amsat.org>
References: <20200807143705.30066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To quickly notice the access size, display the value with the
width of the access (i.e. 16-bit access is displayed 0x0000,
while 8-bit access 0x00).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/unimp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index ee2e536c8b..b4b318db1c 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -35,8 +35,8 @@ static void unimp_write(void *opaque, hwaddr offset,
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                   "(size %d, offset 0x%" HWADDR_PRIx
-                  ", value 0x%" PRIx64 ")\n",
-                  s->name, size, offset, value);
+                  ", value 0x%0*" PRIx64 ")\n",
+                  s->name, size, offset, size << 1, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
-- 
2.21.3


