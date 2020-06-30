Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE854C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3F520675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dm+Zqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3F520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGaQ-0004Do-PS
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTy-0001Hv-HS; Tue, 30 Jun 2020 09:39:30 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTx-0006Kb-2M; Tue, 30 Jun 2020 09:39:30 -0400
Received: by mail-ed1-x541.google.com with SMTP id b15so16234116edy.7;
 Tue, 30 Jun 2020 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7oWhhwBqOvLGS6HnYqHl1FI0efPvaFKdOE8O2MKYuLA=;
 b=L0dm+ZqgiTie6OqdRv2fFH6DqA8j4GmsGBHeZe2v+H0MklGV+lbtTAimlVC3HMiq4w
 5MfNxG7MMXXilmRB8FQJsiB7feNbmNrrR3a++y27YKSGNksbLGmNIhBt7eMS5N+BPk69
 CtjVXTf1ZP+imlarsz1MrpP0bEaSg3jdA8MrmXOxx6EErgT4DIRZv1lkgT4CHJ7zXEnk
 VFgPj9eEECTarvHeUNonolmo6LV/ycslhrlU4q6bP3P0FdUWj62TC9FVcT+B/FX28gkR
 Fm0nVizy+P3HJHmSs3QoGzxcAiTagqwgk0+9gOr9fzs9tYaGos0cGC6TtksMuvFByS4L
 C7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7oWhhwBqOvLGS6HnYqHl1FI0efPvaFKdOE8O2MKYuLA=;
 b=qVTteFwfZSNVJ2eGA2PRSTAYqkelZwijDQbWlho8tI1ygvVL+0BR7fRzXcVunJDfPq
 +41ZJv2ZbVssHp8iMwT3yWpBa12jFiZ2Yur+Rebe5AVKWsIk69D9zum2VsKNjQxpBhvo
 RLoSp/O07PGeDNvTMeQMHfrQiBqazvg9RLOKBeZ9e6FevaPKk4v13Kxa7jkX5X5Px8RG
 ZEEvHIkejnqISdi6p6cqWmD1QFBahZZ/ZeYcVDp/Cke7mNITF7W8EhybGUsTyjGEPKoK
 uwJ+mGQCvbhs2N9l+19MiEDR36DCZWV/CCENEA/HDjgGNcE6DYyanpdfozalGJM+kQUS
 4u3g==
X-Gm-Message-State: AOAM5328+oIyaVauxXHrpo7kDWwW1y/YivxssIuGALKX/EU/DFkW3605
 T3zlD/L0+aGVdeID27Z1Cc6pBDc3q1Y=
X-Google-Smtp-Source: ABdhPJwZ7/Rz1K65mRo7TyScy1OmrO0JiOvkn+aoPtLYMsS18Y2iZNioQkqB8INEQ3oksb0VmaMPIw==
X-Received: by 2002:a50:fd84:: with SMTP id o4mr4229758edt.117.1593524367335; 
 Tue, 30 Jun 2020 06:39:27 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/17] hw/sd/sdcard: Simplify cmd_valid_while_locked()
Date: Tue, 30 Jun 2020 15:39:06 +0200
Message-Id: <20200630133912.9428-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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

cmd_valid_while_locked() only needs to read SDRequest->cmd,
pass it directly and make it const.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 723e66bbf2..2946fe3040 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1678,7 +1678,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1689,13 +1689,12 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
      * Anything else provokes an "illegal command" response.
      */
     if (sd->expecting_acmd) {
-        return req->cmd == 41 || req->cmd == 42;
+        return cmd == 41 || cmd == 42;
     }
-    if (req->cmd == 16 || req->cmd == 55) {
+    if (cmd == 16 || cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd] == 0
-            || sd_cmd_class[req->cmd] == 7;
+    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1721,7 +1720,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
     }
 
     if (sd->card_status & CARD_IS_LOCKED) {
-        if (!cmd_valid_while_locked(sd, req)) {
+        if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
             sd->expecting_acmd = false;
             qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
-- 
2.21.3


