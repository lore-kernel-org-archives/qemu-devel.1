Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62D8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC362256C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTeQmvNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC362256C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO5P-000783-Ok
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1H-000118-7f
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1F-0006o8-Sw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so7248118wmo.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=USDD8NOVLweac+qCIHNujkkaOORfMs3XF+U9+ULZXQQ=;
 b=GTeQmvNMice48YiDfyZ5I6vSw7EuqVKGFG46Zw4wr4/3XIc20ISFaDy8vjTsj0wgax
 vdZVhNl7GH+Rj6oe87kH++F9WvnK63adKOD1Ws40256sUAyswyXsDoxnn+e6Jqaf/SuU
 5Vm/mxFbE8EC9EIg5UBP+25s9J6mwkqvCPnjkpfDV7Hi8lrpFA5URGfY2ewx92doaPjj
 C/yDeT+tcAxQNwLUbrgnFKNKam++epLCVdo4rI+ptkeCOHGSIV2B8F05FmUCFkNGFdLn
 G3Td2G1ueR5ENYMIXX7uEsk6stIfi5WA1t02QK6oRP5y3UPqgPc2f3PIwbJeHWKXnA+0
 3vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=USDD8NOVLweac+qCIHNujkkaOORfMs3XF+U9+ULZXQQ=;
 b=IIS9BMdVPH+7hoV5Busd8dBO4GjJs4wA9v+xT2qXy+jLu6v6swj9qlDyvWq6AVIsla
 BDdkajJ33TOsP68dgOgRE942RPZCAzBDof3rl9sUqEWYCS589bJNnH3ZdWPN+QdvRA7z
 dKb73X418A0p0eiQG29gehz73F3Tud5OnazW0kb0xFZKU+WWOfVXZwCchkcIV4oTIJMI
 L0mZfLPfvd11dwTiugvAKWctPutor6gCn9lKSvozmdvuNmWEhHpcm5kyQRUR9/Sm3Yy8
 5oD2jJqaIpcNfJUqa5ZNub+Ku1k+ghQNO7KmCrTBNvcbcpV4zKNJqmjhezJhwNhKpGtk
 wSvg==
X-Gm-Message-State: AOAM533oJevdT3debbJ4QxWMhcG54j2TQcQTb0LV5DfSFRnNG8xk3BAn
 STbXoDCmDQyq8hdbF2uK4BHA3cxGrZg=
X-Google-Smtp-Source: ABdhPJzQb10S5gPbzhQ0qqKIiyliGgYiJTbsDBSp8cDmzho8mRbmypuNhkXpwbBeBu13AECJ/oKFGA==
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr4997864wml.13.1594744980334; 
 Tue, 14 Jul 2020 09:43:00 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm6474380wmb.1.2020.07.14.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:42:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 1/4] qemu/osdep: Document os_find_datadir() return
 value
Date: Tue, 14 Jul 2020 18:42:54 +0200
Message-Id: <20200714164257.23330-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714164257.23330-1-f4bug@amsat.org>
References: <20200714164257.23330-1-f4bug@amsat.org>
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document os_find_datadir() returned data must be freed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


