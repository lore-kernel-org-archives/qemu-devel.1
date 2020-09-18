Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2FC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC7206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4zQlAPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIwP-0007vI-Ec
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr2-0001Og-2O; Fri, 18 Sep 2020 12:03:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr0-00020t-BZ; Fri, 18 Sep 2020 12:03:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so3712978pgd.12;
 Fri, 18 Sep 2020 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fONA64XSdMINk4Pb3HJvl02BkTmqUfaoSQk6W/tx2aE=;
 b=q4zQlAPvzmnCy/j+JfpvVec+NkCSjngziD1domsA2YXZ9C2mPSHG9wcbGMRxm5EZ95
 6LFlQ2MrD3rqE/Noaw7Zmr1Ffp1aLc4Ii50rNOnV07Bf/E2115OY3jmgdiOn7igwV8V3
 mZvbDbvebf/btejF+vqx6Mlvy5RI2NlgoA6DYxWUtIatb1U2vYLhoDWBbjL3r0fBBByY
 Gl0Iaozkwx7pfhrhxKD01SBQIg3EaKv9iPMKomh50iNpAEHDV9TmFFqOWH/v5KMm+AEI
 mj5mVMjCwdYJDltvaj5zHb9AcV1uMMq7hCqavf2w6eApCj8Ha4OxhrUrpyxMMALDO6kv
 8akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fONA64XSdMINk4Pb3HJvl02BkTmqUfaoSQk6W/tx2aE=;
 b=K2sOTOM9jQ7Je5Gu2OV53PZfyS7KCurM34JmMml07ZxpSscGPDqmC0IqXw+6kv3MsM
 VBJf8fjZvn2DU0MkK2SVHCoZE9caaJo9KuJDGZocwTKtsSncDkk2dBdlVnRKjXE8jmzP
 QjWG++3XwdQNaRxl0C+MpMZ9Hl0w7qFKrq7Pa2Z+RtFd3pRoKNIM/bbVjryDgg7GYVFI
 aN+ypDEKmZkb61SOCaBv2EYQ5bmAHX6CSbuALXFGkruG85ZX62nROL8O3+VbNMrCv4of
 JFBSJGXEiGsreFNERBjs5SsQy2iyABcB0c0KwPqdI14fPFTLullGMFxL6g7HMJgMj6j0
 kJHA==
X-Gm-Message-State: AOAM530Ia5HgCOaKhRJtGjggru6ILjQTClFql9P8OznvUhoXT/wrqH2C
 +WABHXEjzzYuWFHJl200J5LsVvD87J4gOA==
X-Google-Smtp-Source: ABdhPJy65ZplwHo5cDKNDYnSxr/Z8n3sQzglvcDGc3rS8cXHlVeRAXYvUN5fSg2GE34W/gz4kdUi/A==
X-Received: by 2002:aa7:96eb:0:b029:142:2501:397b with SMTP id
 i11-20020aa796eb0000b02901422501397bmr16971433pfq.64.1600444996165; 
 Fri, 18 Sep 2020 09:03:16 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z22sm16889012pjq.2.2020.09.18.09.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:03:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/4] curses: Fixes curses compiling errors.
Date: Sat, 19 Sep 2020 00:02:48 +0800
Message-Id: <20200918160250.1141-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200918160250.1141-1-luoyonggang@gmail.com>
References: <20200918160250.1141-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the compiling error:
../ui/curses.c: In function 'curses_refresh':
../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
      |     ^~~~~~~~~~
../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
  302 |             enum maybe_keycode next_maybe_keycode;
      |                                ^~~~~~~~~~~~~~~~~~
../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
      |     ^~~~~~~~~~
../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
  265 |     enum maybe_keycode maybe_keycode;
      |                        ^~~~~~~~~~~~~
cc1.exe: all warnings being treated as errors

gcc version 10.2.0 (Rev1, Built by MSYS2 project)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/curses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 12bc682cf9..e4f9588c3e 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -262,7 +262,7 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
 static void curses_refresh(DisplayChangeListener *dcl)
 {
     int chr, keysym, keycode, keycode_alt;
-    enum maybe_keycode maybe_keycode;
+    enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
 
     curses_winch_check();
 
@@ -299,7 +299,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
 
         /* alt or esc key */
         if (keycode == 1) {
-            enum maybe_keycode next_maybe_keycode;
+            enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
             int nextchr = console_getch(&next_maybe_keycode);
 
             if (nextchr != -1) {
-- 
2.28.0.windows.1


