Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D816C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF587207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsGsFqPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF587207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorJG-0006ST-82
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDO-0005bR-9k; Fri, 26 Jun 2020 12:28:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDM-0003Ld-N4; Fri, 26 Jun 2020 12:28:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so10024964wrj.13;
 Fri, 26 Jun 2020 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fu1NrcnhOVIQHNzxBvKJM9PlZWrYYL+8zyKDr6GNREk=;
 b=UsGsFqPff4byO+Q81uVb6SiuKiI3wvz0W87LcZfET3165RbmBZj3VGkD4hS4BK5ab0
 szHuEoNsROADkrk1bJL5T0NfyEW6j8S++4WsnMFTaTAMYhAE+++/kLgefbgcAGofBOkX
 JU3pfeQ2JPrOjOPTVsfTbgPg2jHz32izJNsJ5miChXiBsUFp0zcDBlZVu9iOL10xKL5G
 7O8G9NybwwAmpExFN1g5grooDMJYFLy+ajgmyBtit3iB/DUyg2OD4k8v+Pq/FM+4sfeF
 VLebxsAh7W288lASPaBGfN0mDx2fPKhypxi1f6i/XTim2lVs5mfzw29H9v89fKZUZK6d
 C3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Fu1NrcnhOVIQHNzxBvKJM9PlZWrYYL+8zyKDr6GNREk=;
 b=HdjK6qb/pj4tIkpEdoCkk3rEgrMN+VmwAncyauN4MOTA4NIUJpunc5dOsYP9L4ZMCB
 fOTA+HuYH0of/uTnXnGor+NGLc4X3BzkJurc+5n5/vHzmMSRhdEYV9ldNeqZrY4FjQ1+
 vVijnynD+f4HL3vo5POFMnyEgPzjxYRD+SMvPKvKkJT+Mh0LeWp4oR9RKQJcj2pXNTAh
 zOQh8/XfdnpwU34cU0aTQbkNZq1CjzfRuwmvZy4RbUk7+4kv9uAo18qN2fPUcRGtGi2i
 51bucswxqcKGsfmijjJK45T3VyDJ9nnd6Mbssj4roktSxJYi6lT1n6WfF9SmD6HZsR9m
 9sQg==
X-Gm-Message-State: AOAM531ShpFSkU9SYnPK2kdhI4jrGUhf6Hnvz+OwhxY++JVEzh61H17O
 7lEX2BUNgXVljeis+al31j5Vt6mc
X-Google-Smtp-Source: ABdhPJx38FVdo2pvzuXGnx9jLVtqX6DL79DTMHn/pAB3Lad5+p+Vlua2ElK+H0nwY45qQMh9GaE9oA==
X-Received: by 2002:adf:e901:: with SMTP id f1mr4608999wrm.80.1593188910851;
 Fri, 26 Jun 2020 09:28:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/14] hw/sd/sdcard: Simplify cmd_valid_while_locked()
Date: Fri, 26 Jun 2020 18:28:13 +0200
Message-Id: <20200626162818.25840-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
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
index 7d20f344bf..b887dce0e1 100644
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


