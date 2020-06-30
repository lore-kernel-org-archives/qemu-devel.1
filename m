Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98EC206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG1lPzVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98EC206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGgz-0007eh-2a
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGU2-0001Ly-8d; Tue, 30 Jun 2020 09:39:34 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGU0-0006LX-GN; Tue, 30 Jun 2020 09:39:33 -0400
Received: by mail-ej1-x644.google.com with SMTP id dp18so20648044ejc.8;
 Tue, 30 Jun 2020 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q/J0Q8HRfbG27Ye3g4wwIvBclHiw8k1nTV85awsZwW4=;
 b=NG1lPzVcx1qi5mzWzP26qpnLVHTJsZ1UzMnobEnp9qoo4T5eVTrkBgjgm89CTeZ9WH
 r5WOdEJkNrgVQd0g5p/nr8bVisv5yC9L+tgWVTK/qBvy7OKfVTScwXSHbR37jRJwzxOn
 ojLT68pprbZ+RKBDZbfL84SToYX/deBIkKHOQAsBz/3HqUAvMOA7pj3/6vMhPXWOoVhm
 ++DYpPZ713sGSomFKoSS29BrJbDBao6vTGf1CS3sD1rvhc8Kc6+RxxQ0WSrXisCOkZO6
 RsjdqBQoyfKkJ5YIavpi7aWz/CFGTzDZ/AlKqVXP1fiw18CDBz7CWIFJmOWRa4XYVfv1
 97Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q/J0Q8HRfbG27Ye3g4wwIvBclHiw8k1nTV85awsZwW4=;
 b=WnrhrNz7xbbGAmbKAqJAliS26s65/AezlQBGuFDKRe+64Y8bj2Pjks64hPXDyUCYNU
 u7qCCNEHviJ+dJCXRa7f3yXxTk/nkdgaINYC8cgWT2bJvY9p9b7qFM16InQoQa1vc5RZ
 5i3MoMoifmmZ8LOJskyykPB7vEf3RhqrDRrsvvxBUSfQboGE/3CE7kre60zCs2l2SmUV
 xwJBKJzE15ptq1Ee4MyH/iRj0lBLlIBmBDmzMRe7mGUgLYD2pivEl5ghB40vuMF6Rnd3
 mYQYi7hKbvPuJBxSj+eUXTzfTD5Hw0Pico2UPe59vmhGG+Aiqp+qWXTqop6RK9lSqukb
 YBJA==
X-Gm-Message-State: AOAM532ZMZJD+XkcB+y44nATzeJkOX44CvJveVND+azil17X5h7NbFMx
 A/oBWFQvDBOvHvHSHa7nxsHzYNTUDps=
X-Google-Smtp-Source: ABdhPJz4CNgwE4fuM8AZTyW7lrVaRSUsZxJwoZYtmlSsEC2Zi8BmWqpQdYrI2Why77sI9Uu6JUUuDA==
X-Received: by 2002:a17:906:c102:: with SMTP id
 do2mr17807190ejc.126.1593524370687; 
 Tue, 30 Jun 2020 06:39:30 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/17] hw/sd/sdcard: Correctly display the command name in
 trace events
Date: Tue, 30 Jun 2020 15:39:09 +0200
Message-Id: <20200630133912.9428-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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

Some ACMD were incorrectly displayed. Fix by remembering if we
are processing a ACMD (with current_cmd_is_acmd) and add the
sd_current_cmd_name() helper, which display to correct name
regardless it is a CMD or ACMD.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3e9faa8add..eb549a52e1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -125,6 +125,7 @@ struct SDState {
     uint8_t pwd[16];
     uint32_t pwd_len;
     uint8_t function_group[6];
+    bool current_cmd_is_acmd;
     uint8_t current_cmd;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
@@ -1718,6 +1719,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
                       req->cmd);
         req->cmd &= 0x3f;
     }
+    sd->current_cmd = req->cmd;
+    sd->current_cmd_is_acmd = sd->expecting_acmd;
 
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req->cmd)) {
@@ -1745,7 +1748,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status &= ~CURRENT_STATE;
         sd->card_status |= (last_state << 9);
     }
@@ -1806,6 +1808,15 @@ send_response:
     return rsplen;
 }
 
+static const char *sd_current_cmd_name(SDState *sd)
+{
+    if (sd->current_cmd_is_acmd) {
+        return sd_acmd_name(sd->current_cmd);
+    } else {
+        return sd_cmd_name(sd->current_cmd);
+    }
+}
+
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
@@ -1844,7 +1855,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd->proto_name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd_current_cmd_name(sd),
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
@@ -1998,7 +2009,7 @@ uint8_t sd_read_data(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? HWBLOCK_SIZE : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd_current_cmd_name(sd),
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-- 
2.21.3


