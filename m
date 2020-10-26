Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E71C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EEB206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIW7W8qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EEB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBxy-00054Y-0o
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwE-00038h-6h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:07 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:40995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBw9-0000H1-Vv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:04 -0400
Received: by mail-ej1-x62a.google.com with SMTP id s15so11930615ejf.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2OjR/wUfEEBugepvrkgMq+mri256jiLmUAh08vclpww=;
 b=bIW7W8qmw+I/hh1l0NKHHt88h0LKNmG1nWv8jbPk/BlX3yFIeVyaP3k6FnhhM59K1w
 7BbUMwMCNQUrFlXYfq+G72Rtx69AFlvfv6W3P8mGhfP9UwzOhAxN/kyHDIjGrkTbtFfc
 caun4lWhNcXLOUmZZd7f4+q5BrrlOj3y7VvE2yLoAvSxkqnb3p9WweQPkOWQjcUudwaN
 9DaCeMV8Qj6cNGqKGemQwTopNAH88ez5OUnWWyR3BZCqZbnKEx6qrH91AVSB+GyqlV7V
 amVKbCIcgqGWvrVX0/3HGTCM81MVLwmhO9hCRhnXvKkabcJ+4gGtrbiQ5dp725luku38
 LIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2OjR/wUfEEBugepvrkgMq+mri256jiLmUAh08vclpww=;
 b=aOoAFcrBmW0busG236DPUH/IkrY+L5d36WLSJGuvGOti+M4diRoz/UZjsWqGK02x9Y
 DJGfc6CKeJNGfdGgEQWi170rLqH0JeBbxbGf94gpMLmKBq9qwqQ6/wQvlsS7g/IgrG9n
 ddbtTtwFUQo3h5USKBdla2Q1y0mJrRhYJjyrqdh8ml+4O/W/CDhKQGudYuRAxnxd8nad
 9Bl3qpTuTQNqyQFBHANWpvpptIkEYo3Q2oZmkqAmvewayhPEycvuoAi9Wk/ihWvGKD7b
 18Wevp13yk3ifDY87YlNQT4DoJEUze9AyMsDOcUrvGURv6NBLxVTHiy6ca+CLwiWn80S
 8PPw==
X-Gm-Message-State: AOAM530NSSTv1X22MQvvd14eBc90dkIzJgvxRIN5nI0gAQq8PDJNKZjH
 y+Dc9T8zIn8LbTSxVOzKdIuXFkV9XkU=
X-Google-Smtp-Source: ABdhPJxnD0XrshsqAsbiYsU2dfkGZR59jox1zaGn5TYf4myTczI15Kve6jh4wb/d/oTcBm9nte9C/w==
X-Received: by 2002:a17:906:1107:: with SMTP id
 h7mr17808599eja.481.1603754999863; 
 Mon, 26 Oct 2020 16:29:59 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n22sm5969260edr.11.2020.10.26.16.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:29:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] hw/timer/sh_timer: Remove superfluous "break" statements
Date: Tue, 27 Oct 2020 00:29:31 +0100
Message-Id: <20201026232935.92777-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62a.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

hw_error() is marked as QEMU_NORETURN, so the "break" statements
after this function are just dead code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201020153935.54315-4-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 934daaa7dcc..58af1a1edbd 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -125,7 +125,6 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved TPSC value\n");
-            break;
         }
         switch ((value & TIMER_TCR_CKEG) >> 3) {
         case 0:
@@ -139,7 +138,6 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved CKEG value\n");
-            break;
         }
         switch ((value & TIMER_TCR_ICPE) >> 6) {
         case 0:
@@ -152,7 +150,6 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             /* fallthrough */
         default:
             hw_error("sh_timer_write: Reserved ICPE value\n");
-            break;
         }
         if ((value & TIMER_TCR_UNF) == 0) {
             s->int_level = 0;
-- 
2.26.2


