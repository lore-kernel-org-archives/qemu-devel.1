Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7B7207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKnfV8+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7B7207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDDF-0005nL-7e
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7P-0002gM-3m; Tue, 30 Jun 2020 06:03:59 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7N-0004gU-EF; Tue, 30 Jun 2020 06:03:58 -0400
Received: by mail-ej1-x642.google.com with SMTP id ga4so19869627ejb.11;
 Tue, 30 Jun 2020 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5BbtvGD2VAo4vjG/OjaYJ77oxZC/MsecoszC1tkb0IQ=;
 b=WKnfV8+3mRCd2Gu4XnCP2w7VTk9bpG3KH9sVXMOF+jfdPdsF0FxgS9t/cQ0HFkk+JQ
 uWBW5hVIwP3J6giqUK2XqRsFb2Q29FY9LwKEXaNAjqOaDvkRpLgF0EtSGa6FpUxVYlS+
 Ks/sIBqO6DGVqU4YW2qiQxmWskr7pyCashP0bO5aAWyiuXt4yda3jlV77bwJldlXPmSw
 mxJ99wew8K9QE6GqrPZzFZG/7gtzxPo7mnPEqOMkJDsAyHUfK8jnHemouRo6pITRDzaM
 i0WfejivHHkRy7+f0GtkNwHciuvWPGgXYrX++hbBweSSuNwDIeFxDJ+GizkoyavaCelj
 orCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5BbtvGD2VAo4vjG/OjaYJ77oxZC/MsecoszC1tkb0IQ=;
 b=X/r/p5Y9IRDVEr/REGHnLOnZfzt49mCx9bdekXp2kbIHdoWLxJDfvcau0GoSp9cWrJ
 a1py11xuBh4TWMeE40Nfcmlc1PigzVx5YSWAN/ia7mP94+cNC2RA6Ew0InHzAXHKQ/Sb
 PNQTmpdEWDZNN6/dGO+V9+1Z0U6yiub1qZ56TwYxlejNIIftjtpoZM5dnnZPzZlFU0S/
 Es3W2IWMShtVPfwiOrAx5hJeIp9hqg1oCxYfuvAemL7oQDFoZ9OLFXhGrAitkXUxnP4J
 9JXENRegvtgSPTCR8WgO/J3x1coso3Fq/fljX+wDlCw1uqiCzJ4znLSLniMsPUpqGjtb
 xu7g==
X-Gm-Message-State: AOAM533dXe9vq3WR8xGDhq4o55/TaFDgT1yS78/vvquk+BY6wqxcxWTO
 jEdu8gmnS13B4r9eACljHPbKFYoHSxo=
X-Google-Smtp-Source: ABdhPJxm5jefmGCwCTMkLgvWvM5VlzyeHYQNqQ2dNqih4Bnf9Az6UKZyLB/by9Q0jAmEGGs8BMWf6Q==
X-Received: by 2002:a17:906:3945:: with SMTP id
 g5mr18695912eje.549.1593511435443; 
 Tue, 30 Jun 2020 03:03:55 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/15] hw/sd/sdcard: Simplify cmd_valid_while_locked()
Date: Tue, 30 Jun 2020 12:03:37 +0200
Message-Id: <20200630100342.27625-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
index ba4d0e0597..0fd672357c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1664,7 +1664,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1675,13 +1675,12 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
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
@@ -1707,7 +1706,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
     }
 
     if (sd->card_status & CARD_IS_LOCKED) {
-        if (!cmd_valid_while_locked(sd, req)) {
+        if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
             sd->expecting_acmd = false;
             qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
-- 
2.21.3


