Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911CEC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F409720874
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAhO50io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F409720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK1dw-0001rZ-1C
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK1c2-0000oO-Rh; Sun, 20 Sep 2020 11:50:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK1bz-0004Zg-Fa; Sun, 20 Sep 2020 11:50:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id l9so10138115wme.3;
 Sun, 20 Sep 2020 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KFR5/we5s3WUe2uUz6ZQg87dvvCvdsvvEg6rFlfDXY0=;
 b=oAhO50iot3jODr1jJW9HHeW1Y7yGoKeG/t5sCjoocdQq5FFfEQYANxovRon8RkSeYz
 /5hx6oIRVEIwZIT5+AfV9PknS47dkGUMfBsTPZsREYmaQGMHrwODxEfPavVg4RFoFwg7
 5kehnqINwJS3iV0aKULm9KgHPAp1fPMNiSAL1HDqYLhYuQJgg+wRIZWd8jP7QX4VPCHi
 PaOtFNqmtmwQ0cw9Y9TsRf9WDFx5DQZLC2rBZxlm9xJxlR9tNqUwe2PpPy7uyvzE20mp
 mtwQ89RVaHUAh4ipX6ER/KM31HD/DVcxB4PfmiRRUUil0y4fEWPV+KD/+jeD/pZNWZjo
 r2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KFR5/we5s3WUe2uUz6ZQg87dvvCvdsvvEg6rFlfDXY0=;
 b=PLH/eENYEFTcZS2UCM7MVT6PEQJGejuM+rrPGsdRh2oWiEx0lylZ+pkyN0/dnUR8bO
 wWgOd9Iu9Og2Qh/OSaauFb2D/fpC8ZGvl3t4iViCROMVZCoaR4aQgVNP9WmIBJbugnLK
 gGtinVPfwICsTAfZuIxo+aNC+6gY14FY9S2ljVJf1TNYsMeZCekYN7ZYY6ylGjNJmheq
 I+OKAnfhYMYbo2YA1aXzRVgGpx74Gp9c9Qmzz0i4LYzCUxOPXbZHRBA/bcD2QRQkHKoV
 BBTXI6iNvXg2Eot33pXiozfwMSDKLKF0+PMUxPJ5SljsoQ5dshTcMsxwJu2q6bGbWb4a
 rgOQ==
X-Gm-Message-State: AOAM531JTMAwR3LXVjd8z8Qd+VZr4FvcdEdpyvr8vNEJqAQ/b74H2shm
 mTvOk5H0PfUDlh17polHGl9Nu6XyIvA=
X-Google-Smtp-Source: ABdhPJyPQqunJZQJTPmDVBI8c/Bts92c5AzzXWGJT9NPtW7TrM71Ak5bwt37Q0Mw/QIctosobwxwGQ==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr27641965wmg.91.1600617043966; 
 Sun, 20 Sep 2020 08:50:43 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h17sm16676179wro.27.2020.09.20.08.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 08:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] timer: Fix timer_mod_anticipate() documentation
Date: Sun, 20 Sep 2020 17:50:42 +0200
Message-Id: <20200920155042.400737-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

timer_mod_anticipate() will be scaled to the timer unit,
which is not always nanosecond. Fix the documentation.

Fixes: add40e9777d ("timer: add timer_mod_anticipate*")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 6a8b48b5a9d..1dc880e94e7 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -679,7 +679,7 @@ void timer_mod(QEMUTimer *ts, int64_t expire_timer);
 /**
  * timer_mod_anticipate:
  * @ts: the timer
- * @expire_time: the expiry time in nanoseconds
+ * @expire_time: the expire time in the units associated with the timer
  *
  * Modify a timer to expire at @expire_time or the current time, whichever
  * comes earlier, taking into account the scale associated with the timer.
-- 
2.26.2


