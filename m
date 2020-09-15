Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE45C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94338206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKybfE1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94338206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIA3Y-0006sv-LW
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qa-0000eb-3P; Tue, 15 Sep 2020 08:14:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qT-0008As-UX; Tue, 15 Sep 2020 08:14:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id z19so1808920pfn.8;
 Tue, 15 Sep 2020 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fONA64XSdMINk4Pb3HJvl02BkTmqUfaoSQk6W/tx2aE=;
 b=jKybfE1zI6d5pOXCnoptelswEFg9Q5NF1fHohETbbhb93vmuXRaCXzf/kRf1IKvm6+
 Sj/bxo8VcYK9d1BrJMYf9LYG3S9o467Pf2rwLNWvcKgABcs+WT4bqOg9PMWhIplwrXIz
 e+UazDFtbp1POsEGzmKcBEEqOmBaxl65JKLai9W6jnUpWZX+39k/4i6tNGG3oufcfX8N
 H0fVliMM/nB+z28+Az/vylvXtgpNFaPJaUvNwiDuceMr6auAySYd6bZDC38aXWptBly7
 iIpqntLv0mkfpP1JMYg8wSYfQUG3MkUdreXRc4wQAJy7DAHzQR78YP0Ewox+K9NLM2m6
 QDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fONA64XSdMINk4Pb3HJvl02BkTmqUfaoSQk6W/tx2aE=;
 b=tIJHEUYkWSOn29LE5F4hvCOejHzykJICy7hKbpzb4GsAl9C+qI868rO3JUKXBCd1ks
 Vm1z/tvmXf6akMIsGtDSb6udRLWpSZJsZ3ab8S2piBU0V+gNkr0A9WFUInHtkCveYma3
 L62zGUEI0Q9Jd492vKvD/W+UVmP35FrrlO7ggZHk+l7vnmMjKwHWOOOX9PscJu48bFLI
 J07qrJVAHGJoRVibNadPfcDgBcDciISTFXzyU36DGPJJcZIEoFq/jSbVIe+oZWOeWO3e
 tl6Uclw39pZwMYLhNswlxJVIIilOUN7WcG1RkMVCcFYhrVKhpt9szlYQaiZAWwL5wMSu
 Etsw==
X-Gm-Message-State: AOAM533q2iR1CYT/IsfKEUuDytd2rZI4Y4ZeNm1RKXPqoB4xMJImTqJL
 JUPJL+0C8c3ckLkWEqZJi54dS8jRid46xhiuszE=
X-Google-Smtp-Source: ABdhPJzdzT8iRWgMQKzs4bB23T80Qz2ezB5i1OtrNNoyDM7v6I/09rK2+HxMa0JMwAKcimsPgsy1yg==
X-Received: by 2002:a63:34d:: with SMTP id 74mr15263390pgd.364.1600172039676; 
 Tue, 15 Sep 2020 05:13:59 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:13:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/26] curses: Fixes curses compiling errors.
Date: Tue, 15 Sep 2020 20:12:57 +0800
Message-Id: <20200915121318.247-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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


