Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB40C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0D32223C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCo+P/Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D32223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0WP-0000aQ-Kc
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hm-0008HU-6y; Mon, 26 Oct 2020 07:03:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hk-0002fE-P9; Mon, 26 Oct 2020 07:03:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id w23so10068518wmi.4;
 Mon, 26 Oct 2020 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yet6HVLB8K+LmlUq3G4sMPBL+CDXC+2uR7gzK1ybwmo=;
 b=UCo+P/KimaEH9WytkmPvQ/gRniaWbuuX5EwVTO78FshBUt9XvuxdcqKUYg2HRl2/HF
 uujgy62NrA307zdeDZagBpPrb/WBbmK6ejwOmopfjlJxceDfmhznY5D7Z3JCk8g0Smnu
 JhLVbOk/kmZrBxfpz8OR6d2BsVM3r8NABNpEu/WudgZe9NI7uvPKSQFuP6dkEJzV2pGG
 sYxzpmWo68kYWQpX7fY4ep45ReiTDtXAClQkBrLYwm+hcrdFgdiWvjWtkUJyoMbIBst+
 CVgSTIlAIZcGZX+rez0oJ/N/ZAo7trHBDrT+PNwt5jBUx+yH4JEBaWVqqMxfvNUIp10M
 mKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yet6HVLB8K+LmlUq3G4sMPBL+CDXC+2uR7gzK1ybwmo=;
 b=Wi2hOUSgIEG10H3Cqkhl6jLFIer7UWe4v4EslMSxoZJl8x1po0GIcpGf2f9xKkdr2O
 PkQIu1Sd7JJXlLm0u3NHQWCmNxIwx41TMb2KgQJQvpSh6km67q67GG9tKavw2OkNYIbX
 OJOArpd/eZe7wdTHA9RGToSSd+ifxTgCCaMSOcbNKzPGp4fVIW1xbscVxxnftMIKnf84
 6GcwxbWnBNUqGSknadTlNuQ2aQgjMphLJi69APz+D0zFKHbh7ftSHH/Y1tYCwhnKhwI4
 0WJfTuPIT/0O69rJT61TEe4pjfOcznqmC0H7vFkDsGNBmxLBxYzBOYMNIpGhBlhPdItH
 H5yQ==
X-Gm-Message-State: AOAM532KkxmwbLTJLJY50rIuBB9q2Pz4Sc1MDYlZYrSHUa7KmI0dgPT/
 K6TNai8KPyJNxtmWno18H3iqDB6abi4=
X-Google-Smtp-Source: ABdhPJySLdeCrCbVanjmhMuFWvOBkSLtLEZCareuAGPGAtFaAqKlTzrurMZUBBK7Bia6aOfWyrjV6w==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr15250854wmz.15.1603710207286; 
 Mon, 26 Oct 2020 04:03:27 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d142sm3477530wmd.11.2020.10.26.04.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 04:03:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] hw/sd/sdcard: Simplify cmd_valid_while_locked()
Date: Mon, 26 Oct 2020 12:03:12 +0100
Message-Id: <20201026110315.4026183-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026110315.4026183-1-f4bug@amsat.org>
References: <20201026110315.4026183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cmd_valid_while_locked() only needs to read SDRequest->cmd,
pass it directly and make it const.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-13-f4bug@amsat.org>
---
 hw/sd/sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9b53053527e..5510a64401b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1679,7 +1679,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1690,13 +1690,12 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
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
@@ -1722,7 +1721,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
     }
 
     if (sd->card_status & CARD_IS_LOCKED) {
-        if (!cmd_valid_while_locked(sd, req)) {
+        if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
             sd->expecting_acmd = false;
             qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
-- 
2.26.2


