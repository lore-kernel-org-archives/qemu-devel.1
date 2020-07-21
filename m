Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A0C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F6520717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ShT0T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F6520717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwbg-0002BW-EF
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 14:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaG-0000Ye-Bp
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaE-0003uU-3v
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so22049378wrs.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nGbAj6ZH6l89XvGft/14MftdLsK17sbLjcwJZB02Jko=;
 b=N3ShT0T37HLVJc1Xdac6puxQ96VnF5eAL36yhz3QwMY6muqZ2JMcXjhbcC1e7c92XX
 LfMyMiLrPk6mHE4y0JzkNX3vo8R86x1V4jES/byfUpA6ffEqJijnXHgS70wY1nOrf+ha
 L4Ly6+vrpKQiTJFfCmJeBz24Fw4fSsd/Mq9+NssEsdmDItrzByEPzo7p8UkQLGljZrQv
 /JL6xy5QfDujr1GG6lfOO9qLrztejIVQEu311evjN/2JTy4wrHaJaMQtffoJRjhtgaWk
 KjCzxlYoKjzIU462f2j9MSEnHNLLE6SaJjWqSolUI5OyAFQM+1kwrL2nCDIoyF5VfzWx
 EBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nGbAj6ZH6l89XvGft/14MftdLsK17sbLjcwJZB02Jko=;
 b=C64vg3p++kGSyGE1iwmyuCKG8kZTo9SogNfE33341xQE91r12e3Mao93xy8QINnHK1
 cBI5NlT8nVvZv7EmovLR+800LqEk0hg91tzacBU1HATSICS9TNYv6y17BB/+weA+UkMy
 WZU7o2lMXLwx3jMlsgFPafqM6bv3YfKHyuOqSeL4LRIrkDbqEprrAKjrBJYcWIGYKPXX
 USUWqQtSomFtCjnvLySglvjzpSOWuvAX2DEV91Fyl2778P4rLgpw+ODlG2nH2qQ/CHDN
 dKhyCCZQwFphhEUi2WmYtyDxY3Rt+FjXrcyfAs6Y15eG9L8JEHOmmXI19Mmk0+fCuoDg
 ZH1Q==
X-Gm-Message-State: AOAM533lRNcnMsq3dM7OAyqLR0AAkdzTyOtuZ6egSOvtRtdI8lS7tsJz
 tQQbFNd/mumBY8E4c9DQXglOyZmLdKU=
X-Google-Smtp-Source: ABdhPJyELdELKH3uS2biIJU1tQW79RVDGA9j1e3h5T6enYWhc3T7M6OqH/Rp90e1tgOlGnyhXZ0JSg==
X-Received: by 2002:adf:9463:: with SMTP id 90mr7337931wrq.223.1595354500319; 
 Tue, 21 Jul 2020 11:01:40 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t2sm3557249wmb.25.2020.07.21.11.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:01:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] qemu/osdep: Document os_find_datadir() return value
Date: Tue, 21 Jul 2020 20:01:34 +0200
Message-Id: <20200721180137.11136-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721180137.11136-1-f4bug@amsat.org>
References: <20200721180137.11136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document os_find_datadir() returned data must be freed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200714164257.23330-2-f4bug@amsat.org>
---
 os-posix.c | 3 +++
 os-win32.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index b674b20b1b..3572db3f44 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -84,6 +84,9 @@ void os_setup_signal_handling(void)
  * Find a likely location for support files using the location of the binary.
  * When running from the build tree this will be "$bindir/../pc-bios".
  * Otherwise, this is CONFIG_QEMU_DATADIR.
+ *
+ * The caller must use g_free() to free the returned data when it is
+ * no longer required.
  */
 char *os_find_datadir(void)
 {
diff --git a/os-win32.c b/os-win32.c
index 6b86e022f0..c9c3afe648 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -57,7 +57,12 @@ void os_setup_early_signal_handling(void)
     atexit(os_undo_timer_resolution);
 }
 
-/* Look for support files in the same directory as the executable.  */
+/*
+ * Look for support files in the same directory as the executable.
+ *
+ * The caller must use g_free() to free the returned data when it is
+ * no longer required.
+ */
 char *os_find_datadir(void)
 {
     return qemu_get_exec_dir();
-- 
2.21.3


