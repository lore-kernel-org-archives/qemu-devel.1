Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5BBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E9020760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWiXplJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E9020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDJ4-0006YS-No
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7S-0002kL-3Z; Tue, 30 Jun 2020 06:04:02 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7Q-0004iW-Ht; Tue, 30 Jun 2020 06:04:01 -0400
Received: by mail-ed1-x543.google.com with SMTP id a8so14393323edy.1;
 Tue, 30 Jun 2020 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z/EZxVt2E3A6jt6L/KxP/rTE9weJvxlOwG4iw6dyfbk=;
 b=QWiXplJbI/URaKRP9pw689O73qPEwYUGPfAMXoorVNbDHe6LogbMgQKGEd6n2/zhQf
 adw6jFT6dsSORXyJgAkxKVFzAqEK9pxPUXC4eX9PIon8qlBnwsLknBu/Gj/hKwNjfySl
 F2HV6quoAgXKnXlmmLwTAQdpAAgtNeHHe1/IbQJBSO30ZVbXcYbSw24EWDaQdd4ZoeYz
 Q6BxPDsLdtN9HmDsNIF//MNdDXbWlFwfpZ5WKv2pXvZ2j261REr51zHmOFCT7vNEc4Pp
 Nw53tYjBgYy6PtZo2/x+KDu5Wh9J4tRhwcRkvU81rhqGypJyoWBDKornMUVrFL6vC4bp
 lojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Z/EZxVt2E3A6jt6L/KxP/rTE9weJvxlOwG4iw6dyfbk=;
 b=FbIm7C1EnjqiEvekqrXc+8WT15MhoSCwS/Gr7swfIcOpYB2y89zFCW25LO6C7nxvrK
 jmgCZQ0kSkEWnAXeJVDcqoiDgJdADqfXUwfB2FdGsDzEtxO02rgStIYa2hO8d1tFEoQK
 n/GkFDDhGs4FT07Xl6iOt449Cg19DeXm8Bvee55u28lPK4lkQyyxI9IbPsRgWsljAh6B
 qimeaqi9AHAhqIJer87avL472+R53kw9qSvb2jiZyWcqrGyZaEBJAZVGoxwNhpq6cBxU
 uZL4jNLZgLWYybAWoO4oUja3B4my8UVi4PhkFwm6Yx39v0TxsIb5sg7wcwTD4SkUmHOM
 b5QA==
X-Gm-Message-State: AOAM531js5unr9qSqNX+zJKx4LJJOePZXBdFx2ztstUjXS8kb+3sDYtK
 ZyPK+iTrVzj1ZB+pieZYGVlRZrxqeHk=
X-Google-Smtp-Source: ABdhPJzVmMIxh8hIO0/AJBnb8fF4vHAWlEcO0TpZSx9IJvmFmFFAE75BNE9ZonaLMMObgsxKNpBOgA==
X-Received: by 2002:a50:ee07:: with SMTP id g7mr6485568eds.320.1593511438592; 
 Tue, 30 Jun 2020 03:03:58 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/15] hw/sd/sdcard: Correctly display the command name in
 trace events
Date: Tue, 30 Jun 2020 12:03:40 +0200
Message-Id: <20200630100342.27625-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
index 504228198e..de194841a7 100644
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
@@ -1704,6 +1705,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
                       req->cmd);
         req->cmd &= 0x3f;
     }
+    sd->current_cmd = req->cmd;
+    sd->current_cmd_is_acmd = sd->expecting_acmd;
 
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req->cmd)) {
@@ -1731,7 +1734,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status &= ~CURRENT_STATE;
         sd->card_status |= (last_state << 9);
     }
@@ -1792,6 +1794,15 @@ send_response:
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
@@ -1830,7 +1841,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd->proto_name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd_current_cmd_name(sd),
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
@@ -1984,7 +1995,7 @@ uint8_t sd_read_data(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? HWBLOCK_SIZE : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd_current_cmd_name(sd),
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-- 
2.21.3


