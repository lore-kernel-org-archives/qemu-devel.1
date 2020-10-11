Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4678C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1C42074F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQxADvQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1C42074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhYJ-00071p-7K
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhWz-0006PR-ET; Sun, 11 Oct 2020 16:01:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhWx-0001oL-Lv; Sun, 11 Oct 2020 16:01:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id b127so2573553wmb.3;
 Sun, 11 Oct 2020 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rtigXnUA5mLNlaDE2SoGG3FoQ3kUlMHtI0Gcr6lFObY=;
 b=TQxADvQyvYWtmLzUMbQhcYPQvjij3SxxWbkYc1+LYjsZ2j1hLOjmjLXrer62+XH+p6
 UlQ5xxwIdtsIGaAAi9xmC53NfTaVQmcXAkoX0YsRXIAT9gY6nZHteLtKC2zZ/+9X6wkd
 rJwpGVmkPyaF3oewcztiLZGHHKOa0zxWdvXWILmQ1D9VKl+WS8v6ObASL5PCyrzJhzaO
 9UQnwsLDMq+0xrrVHrdWx/MrNvVDeq+qObKkXDEPyG/oTNPREg/togBbI0hLWOfztECU
 goCBoebJ3rIrCHj6drs3Sv99OEtFx7DbMMsOuKnC33wvE1lTsMqU3nRz18jwA1wUJ+LD
 Lcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=rtigXnUA5mLNlaDE2SoGG3FoQ3kUlMHtI0Gcr6lFObY=;
 b=IuNyphqEdV0t+lFshXvsZ/c3byr1/yvqhobrcx6PpO0231Kk8rgVrImKGHgcFYwt0b
 feNT25KY/diw5Bav8JDlIQl8H4uyGULGcxkbJeCat/fwwc4xP5LSsibWg/1eMRle8s/B
 aGHClVXSK9EgFPDmGZ3SiF0kBqWWssrR773R6beeWRduHpZMXiNCyl3JryByTHbMjtv9
 EhmTETXRc/mPY3GswUtG3bFPlQyFdKt/anhQXP0sBpKKyzR130QMPJ/MV4r/ChcdlMWd
 uhKmAWao10SQON3C0hun7d6/0XsnoOfl11DKih6ctLa7AeVHL7shBVgzWApN8UR88Ivb
 tNrw==
X-Gm-Message-State: AOAM532VPVICkXVh+IUsxyPh6ay7oYN1puBQ98+yovgHyBREgovY5Xg4
 NAnYO0XhCN8+hvQiR6Il2Xsy0aeXY2Q=
X-Google-Smtp-Source: ABdhPJxsTY9YqOEC/mry96dOBi0DKumFWLiFn4mDyifEiPRK51/NDM143dggb1BhtmykInMcPQegMg==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr7762340wme.188.1602446474071; 
 Sun, 11 Oct 2020 13:01:14 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d2sm11826680wrq.34.2020.10.11.13.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 13:01:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/sparc/int32_helper: Remove duplicated 'Tag Overflow'
 entry
Date: Sun, 11 Oct 2020 22:01:12 +0200
Message-Id: <20201011200112.3222822-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 0b09be2b2f ("Nicer debug output for exceptions") added
twice the same "Tag Overflow" entry, remove the extra one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sparc/int32_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1abd87..ba63c739c1e 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -50,7 +50,6 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xd] = "External Interrupt 13",
     [TT_EXTINT | 0xe] = "External Interrupt 14",
     [TT_EXTINT | 0xf] = "External Interrupt 15",
-    [TT_TOVF] = "Tag Overflow",
     [TT_CODE_ACCESS] = "Instruction Access Error",
     [TT_DATA_ACCESS] = "Data Access Error",
     [TT_DIV_ZERO] = "Division By Zero",
-- 
2.26.2


