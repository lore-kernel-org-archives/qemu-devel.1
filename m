Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C012072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxH4PEqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C012072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8vk-0007LC-19
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uH-0005Xx-Qd; Wed, 10 Jun 2020 18:09:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42105)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uH-0008HH-0a; Wed, 10 Jun 2020 18:09:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id p5so4027806wrw.9;
 Wed, 10 Jun 2020 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=glZSnPSWCwkSvVM3ma665cDxo7SDncXcyzuKz71VnhE=;
 b=UxH4PEqKRrafPacWdAKMpaLiO0SwUcsd1q7A1VzmNuE7lMK2b26fiVbbxXVlY6ZUHB
 w3yV+icPaSq44diNZXFAR8kE3+/CDo0vYY8HAuUXPS13lGTy5huBELPlpDkUAWFeFSBK
 lFk8JsRhEwIe3J5M3G2INPL+b+9rQTg5C7kAAlM5KVdp/sVQ8i3v6xY2avI2gShswH0s
 oy5Pv3+xOBJVKqVMf2Y6/A5tLJLqKBJyRs1HECd9uIehlvbH/qkhGPGgSJ4Wui9jZdIv
 l+hWuJplEMAIeEsphkLBAXIBcZ3a4SaGGB+wo5IyXazVdYS0vgUXrteA7phgAsfZRU9C
 qWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=glZSnPSWCwkSvVM3ma665cDxo7SDncXcyzuKz71VnhE=;
 b=m9rPj2KwN+eHbW9eWeAgVslE8X8IT1MizZdiVdIBywhLc3kAnTRhWbdevrxQS2aSOO
 2vdW2oWzu8Oh0IU6UoK+jGOnMjLbrbAwMYTOuTMB/dC3eMcu0eQvjk98nI5r91jTBlS1
 WoXVjE8LqZUeRj0EK3uMFFaCuq9xzRK2Jx8rnRfofBxQP1+FpaT2UPMCwBY/w6OCPGFf
 E8VpoJtV1/nTBsXpZI6tqQ1ulnpPjsiEPNkAXMR+vP/AAvuZYXjBK8KRe4jVeYc8bg1j
 DU+BGFltvGT0FfnXudkgcXM/bX+LVZiL0L3dBAq/k7yzMZZilr1tmT3fOZ+Kp/typMVT
 csMA==
X-Gm-Message-State: AOAM533maKBSrshSFDMzzZwX8GiGMTDlbeYbUNuEFIDyKkHzlxRaffkm
 Ds4e+K6v/Ai0rnaz3pRBRcylIvC+
X-Google-Smtp-Source: ABdhPJyUU9aLOGNptAe3TQo4ViKs9P79ITAlYsj3sIOwLlyn37z9ARrSpbz1c3iZ6v0ibRN8JkCKLA==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr5619037wrj.333.1591826938733; 
 Wed, 10 Jun 2020 15:08:58 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:08:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/11] MAINTAINERS: Mark SH4 based Shix machine orphan
Date: Thu, 11 Jun 2020 00:08:44 +0200
Message-Id: <20200610220853.8558-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Magnus Damm doesn't have time to keep maintaining the Shix
machine [*]. Mark it orphan, so volunteers can step in to
maintain it.

    Orphan:      No current maintainer [but maybe you could
                 take the role as you write your new code].

Many thanks to Magnus for introducing this SH4 machine!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg710319.html

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 129517cfb4..e1d1b0f62d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1257,8 +1257,7 @@ F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
 
 Shix
-M: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
+S: Orphan
 F: hw/sh4/shix.c
 
 SPARC Machines
-- 
2.21.3


