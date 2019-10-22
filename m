Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94568CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628AF2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pu4HPBHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628AF2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuLb-0008VN-5D
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGM-0002Aj-NG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGL-00019r-D7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGL-00019b-6s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id q13so7247837wmj.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=y6cZwi7KnbEYaso3vcojBuwQDGlT+TuR2VSfnVl/yHw=;
 b=Pu4HPBHE6wh6yIGgJmQGtkbOOqdp+absTXqhV56SuiWz64OmSCLI+dovTvV8nZuYQG
 i0UV1f+YQKz9DvGq+AuWw7ozk3579dnR6Jg2m67mDOr//czPGLoZXeZhGCzQDYdME5I+
 7oS1AHHYlKeSsbWu0jm+0DYWmnQeNgxJSemSsClYMyssA1R4ApjX+NiOmL9vCcunkfB+
 kvrfhtcu7SNKwgRadzQfhghNQ9QymPGaRJp3WOTTbcCwDp2gw+dq3Xd9GcHK8SpjpRZO
 U2m20DNs0K15w0FH+Urd+F0N16zcYf/zKgxDsukrrVfu7zu1P+D1kvq8bBv0+qa3cifB
 lixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y6cZwi7KnbEYaso3vcojBuwQDGlT+TuR2VSfnVl/yHw=;
 b=k/l5fZCDs/j8aI8SFXJFLunU9me+e4MLSz+eEAoP2UZ03gFrTGEi/zYjSegXndTb+8
 PBL6dJG7kNmEhlxd/mQcINP9udv2f6ZM7rrIGstul0qnM5EViLEbGEAwyXLm3TQWjC0P
 r26wDkyTEZAeV0vQ4U4kNviwH2pCYZmCGXObbFHCD+17B33/uX/87NZ70ZhYKMnNwkf4
 qhTk+ClEQLOyxQFjInUzM8XlLJpoGWpws5aDxm02jLJqv4HCOmSJC9bLMy3ufbEHnkNk
 8X9ASO3hTeVOuBBrmCxjodgsBOXhXVsH82CYtSzHcvnX+2C1owRoMDIIKE4EkDZI4t8k
 j5ww==
X-Gm-Message-State: APjAAAUDX43a3csm8gq5a0eahWBmHQdDdP+vKhQU3BRlXz8lkM+lMGGN
 SPgK8yjqWAOdnzNUdLbzUf+Y7pf6abQ=
X-Google-Smtp-Source: APXvYqzQ6Rt26WlSYDjAViSo0SR6oe8n7E+5iRRdvfiQZ+glSiTd0bp9OBSafWZtW1TVB93aGQanwA==
X-Received: by 2002:a1c:234c:: with SMTP id j73mr3290812wmj.51.1571751107457; 
 Tue, 22 Oct 2019 06:31:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] hw/timer/exynos4210_mct: Initialize ptimer before
 starting it
Date: Tue, 22 Oct 2019 14:30:56 +0100
Message-Id: <20191022133134.14487-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

When booting a recent Linux kernel, the qemu message "Timer with delta
zero, disabling" is seen, apparently because a ptimer is started before
being initialized.  Fix the problem by initializing the offending ptimer
before starting it.

The bug is effectively harmless in the old QEMUBH setup
because the sequence of events is:
 * the delta zero means the timer expires immediately
 * ptimer_reload() arranges for exynos4210_gfrc_event() to be called
 * ptimer_reload() notices the zero delta and disables the timer
 * later, the QEMUBH runs, and exynos4210_gfrc_event() correctly
   configures the timer and restarts it

In the new transaction based API the bug is still harmless,
but differences of when the callback function runs mean the
message is not printed any more:
 * ptimer_run() does nothing as it's inside a transaction block
 * ptimer_transaction_commit() sees it has work to do and
   calls ptimer_reload()
 * the zero delta means the timer expires immediately
 * ptimer_reload() calls exynos4210_gfrc_event() directly
 * exynos4210_gfrc_event() configures the timer
 * the delta is no longer zero so ptimer_reload() doesn't complain
   (the zero-delta test is after the trigger-callback in
   the ptimer_reload() function)

Regardless, the behaviour here was not intentional, and we should
just program the ptimer correctly to start with.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20191018143149.9216-1-peter.maydell@linaro.org
[PMM: Expansion/clarification of the commit message:
 the message is about a zero delta, not a zero period;
 added detail to the commit message of the analysis of what
 is happening and why the kernel boots even with the message;
 added note that the message goes away with the new ptimer API]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 72257584145..944120aea59 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1254,7 +1254,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         /* Start FRC if transition from disabled to enabled */
         if ((value & G_TCON_TIMER_ENABLE) > (old_val &
                 G_TCON_TIMER_ENABLE)) {
-            exynos4210_gfrc_start(&s->g_timer);
+            exynos4210_gfrc_restart(s);
         }
         if ((value & G_TCON_TIMER_ENABLE) < (old_val &
                 G_TCON_TIMER_ENABLE)) {
-- 
2.20.1


