Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9519C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1536C21D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Fl8MIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8IX-0005Tu-N2
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8BC-0008GA-Tq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:38 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:45162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8BA-0004nD-GQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id y14so16107643pgf.12
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GMFUUawRaQBbY91Y4UXpQaHmWWpu/P1MsSjv1nTQRvk=;
 b=n9Fl8MIttTAkPMnVx+8EJtpoekhKSYyI9CyaZYspLnoC5b0nNKmA6kQjB5FnP8Tts8
 EJaC1aRN9xD7BpY1DMo4z7EagaJF8lAdL4GLL461RKn3ms+u8sjjN9ahdoEf69WDBZJf
 oee1XsAD2b+jnrSTPGQUfU59gtkNILihJ1mKxyg/jWI4QtsEy3iGB+ppCHICTb25GlRr
 pAKIA9fXUMKurjV4+efsghBgMQlABVCikAnMsasQzG6gjFCmQ6kJom0OrGK1cdBMbQ+p
 bTiTi8wG42G+T5/pyz3IFG5mqfBNVa+orxQBcylD7Kz3Rbswn57s+ZRLGmgz7btWO3Vf
 gHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GMFUUawRaQBbY91Y4UXpQaHmWWpu/P1MsSjv1nTQRvk=;
 b=YrcNqHHLjLVAbw8fI7TAclW5AcJBzSo/y8vPjMedwSpu3aRpUCuTpv0ze4HtVH17zv
 0odhwYtyEc8554uYwavztl5mlsxo/rk3Lfl4gq//KKNTfOyNfq8Ha3ANokN4nLnKo05K
 F3SwCwKTmW5h6ECNepBi57q9QLCfxTk+JEnhycR3OFtNGSU5CDUDV3tP284SrHbAFAvD
 +z1SsVJg/QheH7sHb9KxkgfGfLEn09dwxdOmyUoyKUVGkqCjqLsxWBU0OmNmM3H1Xwwi
 tWC7CCrjoqju/W0chcxUfXUAGEoPSqo4NshPAa8XV9HhwjFSGOrnrXooXHWDv+CoDdqa
 thOQ==
X-Gm-Message-State: AOAM533PobFvkF7qhGhI+dUP93Ba1ijvDZtL1APHJCMD4Nt0kJDEqf/U
 0J7S4cwXV/7XtTXJWKdeFtmt/c8OZWJD8Q==
X-Google-Smtp-Source: ABdhPJxhLWDP4qZ8mDa5TuV4GgZjle/RN6USrpbWnwyxtXNep7gz6NkymZC7dy5Z1K4LdjcdAqjL0A==
X-Received: by 2002:a17:90a:c28d:: with SMTP id
 f13mr21968261pjt.145.1602548914807; 
 Mon, 12 Oct 2020 17:28:34 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id y5sm22565925pge.62.2020.10.12.17.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:28:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/5] cirrus: Enable plugins in cirrus for windows
Date: Tue, 13 Oct 2020 08:28:06 +0800
Message-Id: <20201013002806.1447-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013002806.1447-1-luoyonggang@gmail.com>
References: <20201013002806.1447-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 2c6bf45e6d..56ccb25bec 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -129,6 +129,7 @@ windows_msys2_task:
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
+      --enable-plugins
       --python=python3 --ninja=ninja"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
-- 
2.28.0.windows.1


