Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94ACE221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VergHMkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ACE221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43VW-0006qj-PT
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Ud-0005rq-Jw
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Uc-00069Z-6S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so1927873wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qYJVq9iqYG8FmVwk9pWFnsLfEQSRo4FWwadk2ySPfM0=;
 b=VergHMkJhw8Q8FRPggxHaPq75DzHjxSNLEjzFopnlBuInZtVVCKB7N4i/8lZrd/MB1
 JT6nf70zlx5NMHOEbn4Jo9dyevXghpNMPwThjn2uaFMYR+zuqSjbwgjXJFP0LyCnCdPY
 rvw2XKjW8htS69WBGXwObo6LWQbhq2yq9SOm5cEX8ZqqFYhKt+jhnDr9iNitQ+at6HTX
 6C9gRAfvmaarU00VrOb5iNd48EIGwh6zah16gfyUnSiXkE+2AQlbl3ZwgFq54GfGxilo
 Os79XOvUKOtQmrahMYTT2sP1jyHv+9zvU2F1IlmnWGUyDEyg1Gbk4Jpto9binCkMfnCX
 rBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qYJVq9iqYG8FmVwk9pWFnsLfEQSRo4FWwadk2ySPfM0=;
 b=DQ4xgrbKMPNI/YDIWeniM20rBJOkeANUWgALC/Q3+otYBhXP8MKzTq+D5xt6ZsjmI7
 /I+s2jxK2KTgRhqsEaj/S/iJhEMV5lSt9DpctOGkBA3rRx0YZuIGTuoC/rGT0X6M5JmI
 F9utgY2HRqx8YalLAkyrEJ7j/0NeFTdiTFhZCzYd8jcHZvemv2MOZeNEwWMoEiyNuPwZ
 aJ7nfqZj3zDzMsv/DrGmHhqBJI0Kp7VrbGGVwqna/0aYy2eUbAaABlLlWk4H4IUhYkil
 dkRPT+GCYRsmTHQhTG5ThFZ0ICVPxToHiCU+Sg/QyZvZACDVegmeE0BORN3QVhrFn1l/
 WoEA==
X-Gm-Message-State: AOAM531M+42lfcEiUTn3IwvybKq0gcFXBRp6knAPYHhS33wS+ZHtAZ5w
 w9k4MTafJgghWOq0BfkF87EwfGkm
X-Google-Smtp-Source: ABdhPJwGdoaDyeHOAz/El3M6oL0XggfntXu3GXkZzmAG9aqUNq7d0Hd89Vay8+/IZCWN1VdIwd11xA==
X-Received: by 2002:a1c:6604:: with SMTP id a4mr12694632wmc.81.1596811028284; 
 Fri, 07 Aug 2020 07:37:08 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm11033302wmb.24.2020.08.07.07.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 07:37:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/3] hw/misc/unimp: Display value after offset
Date: Fri,  7 Aug 2020 16:37:03 +0200
Message-Id: <20200807143705.30066-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200807143705.30066-1-f4bug@amsat.org>
References: <20200807143705.30066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To better align the read/write accesses, display the value after
the offset (read accesses only display the offset).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/unimp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index bc4084d344..ee2e536c8b 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -22,7 +22,7 @@ static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
 {
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
-    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read  "
                   "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                   s->name, size, offset);
     return 0;
@@ -34,9 +34,9 @@ static void unimp_write(void *opaque, hwaddr offset,
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, value 0x%" PRIx64
-                  ", offset 0x%" HWADDR_PRIx ")\n",
-                  s->name, size, value, offset);
+                  "(size %d, offset 0x%" HWADDR_PRIx
+                  ", value 0x%" PRIx64 ")\n",
+                  s->name, size, offset, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
-- 
2.21.3


