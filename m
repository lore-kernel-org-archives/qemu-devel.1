Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF7D207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le+pnGOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF7D207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDF9-00018i-69
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7U-0002mf-LK; Tue, 30 Jun 2020 06:04:05 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7S-0004jD-Cr; Tue, 30 Jun 2020 06:04:04 -0400
Received: by mail-ej1-x643.google.com with SMTP id ga4so19869853ejb.11;
 Tue, 30 Jun 2020 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCA/b5P4oEFejWJMVskzw5rnEpDdc0VO+NTpGDzUdqY=;
 b=le+pnGOKUuda9x8XTM54HzMlggBHV3uuwCOWiv7DfWp8jAxUF58n1jRgM5x2wffuxa
 MChv+3X66zJnTIvSEU8wbGAJro7dQEREHIlfwm1BUjPn62PGT0n5o66V7t5SRneFj0f8
 Mq4geFZDlt4WOnINIjOaFvZBNhYJ9NBU8n0aGkoYXUjieUf5mWZpE88gh2OzMBfIsJdU
 FlqKadidSPTkHH3qnPYKt8/fPBKj4Vejb2qE+9fI4qRsMXx1m2myIB3A4b/4YAyYfxTY
 Xi4dMWLN0hX0hI9mYZZ6cy3+BJ7Ftv6QIOt2w7iVG1fUX5GBHCn5TPNOSgF5wZO0qPRs
 UEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GCA/b5P4oEFejWJMVskzw5rnEpDdc0VO+NTpGDzUdqY=;
 b=NgPcrDz+eNgWPuS1XP/Vq/4q847/YiasUjl8X7PGpHYMMsNnbScF/XVl/6I5vYORX6
 u7SXQiQyBkpKbeiNRQ6YiJDkaXn2AX6uJPd/+5upI/TGo9hi6y1BDZ5NcTg1UwALW69+
 YNqdZZOwgADpneVn2hz5AZLZXfzTlcv+IzJKqONsiz4SZbKJMpxBkBbFz8ovfG16ISjZ
 //vHIrZ0tCWAoqKbNJyiZ2129wUECc9QTV0P1YMJ0XnG8ktJQ8LYTTllsWaAq4VN3zaD
 p5IUiHVZYuNlswd/dKzFV+BnaUASul2/KWEqhqalPTxfgGLp+EXG2ErljDrWHQHCvJ2N
 WIAg==
X-Gm-Message-State: AOAM533mUX8gTlRm5WRCrZ50rl1YDNLqYYLvODWA/7hMovRueTiW5ci2
 hn7GI68rqUF+JmK6Z0pR8kHDRSK+2Co=
X-Google-Smtp-Source: ABdhPJx/UXPmJKCrRFL+o2iujK1iaTo1kszTE9L6mS7CAVDQ9Uw2wFeqJM598jkHGqKu3b4F5L2/ow==
X-Received: by 2002:a17:906:1414:: with SMTP id
 p20mr17184146ejc.247.1593511440624; 
 Tue, 30 Jun 2020 03:04:00 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:04:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/15] hw/sd/sdcard: Simplify realize() a bit
Date: Tue, 30 Jun 2020 12:03:42 +0200
Message-Id: <20200630100342.27625-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
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

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7f973f6763..e1bba887b2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2140,12 +2140,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sd->blk && blk_is_read_only(sd->blk)) {
-        error_setg(errp, "Cannot use read-only drive as SD card");
-        return;
-    }
-
     if (sd->blk) {
+        if (blk_is_read_only(sd->blk)) {
+            error_setg(errp, "Cannot use read-only drive as SD card");
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3


