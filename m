Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D4BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB62B2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE7/TY/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB62B2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7SJ-000764-07
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OT-0003E1-GN; Mon, 12 Oct 2020 19:38:17 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OR-00073j-GR; Mon, 12 Oct 2020 19:38:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id k8so15257998pfk.2;
 Mon, 12 Oct 2020 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=sE7/TY/n5hiWsrAJNYROeuQhOA9+ZqydruPmZMXVWoPdUP7BR/CIuqgkjGc0PBbt4e
 xI2uuGKWn5++0HywN0l+wp7K5IWv8k2vLpBfoopY/gUDgP+Wf6K3gD7jWBcAVS05YsYw
 O1Zpvurjn6QILiLIFsT2e0tCHU5uyojowwZRsAKGopmn2jEJRbXWlY+5LoL47lBQRRGP
 kwVrNK/CUPUnD35N2Fu6Ylai94PcTkJRBthKfwEDJqJ6cl3ulQxAXLqYm45SHTRo1p0I
 jDCewjIJ4mpZGBY8sodqdTncA+z3o6mBsTRUhYxpboybTk2ws6tVSNO/oPwcsgwEWnnH
 muBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S+jw+88sOrD1wBdO71U4c/3Vn26m+fCHMRsX5Ywl9XU=;
 b=hxaALV4IWcKSbgpZUyhtuIDKWD7tIvcEhwn9khvKIO9LTPZblUho6f+4RP0yyp/XCb
 bbMkxuDWqKNLJ4QYegSzPvYw3cLXiCsOaNiobolKQsx7ZaW+eOUMRgdhhATpa2K6PhCT
 Zs61e5uTigt0dGg3rmfaVd4j7cqok5BT2C5PqtxHf5ol1WSHOrEmwbNL+yJeQRuA/xXd
 xolMVORkswVb8KQCBlwCpES9ffa8BsUJkaVmeltTOz1UYTexkhXkw4BmbgZis4E+aIyK
 2CHOE0rdPwi/z9CWFS9JfLTCc2NQ7DnYk7EgMaNJGFC53rEdqMvexIxCqb7F9/CcBxy5
 2zcA==
X-Gm-Message-State: AOAM5304C9sp5xQHIEqHBZahyrPKWEA86oJm7nSh4sK6DR1/bUbHW+eg
 7blldSPLnYvNrGrL3DZMSePp4Dm4MMWTYQ==
X-Google-Smtp-Source: ABdhPJz0d10AETOleY0sdY6elfz5CDdu3KEENDEnVNRWT6j8NL2fCcFD62mB14Or0jo9bg1E4diBpQ==
X-Received: by 2002:a62:644c:0:b029:155:fdf4:52ed with SMTP id
 y73-20020a62644c0000b0290155fdf452edmr8099527pfb.9.1602545893196; 
 Mon, 12 Oct 2020 16:38:13 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 x12sm21975783pfr.156.2020.10.12.16.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:38:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/4] cirrus: Enable doc build on msys2/mingw
Date: Tue, 13 Oct 2020 07:37:40 +0800
Message-Id: <20201012233740.190-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201012233740.190-1-luoyonggang@gmail.com>
References: <20201012233740.190-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently rST depends on old version sphinx-2.x.
Install it by downloading it.
Remove the need of university mirror, the main repo are recovered.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 99d118239c..f42ccb956a 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -76,7 +76,6 @@ windows_msys2_task:
         ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
         C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
         C:\tools\msys64\usr\bin\bash.exe -lc "export"
-        C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
         C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
         echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
         taskkill /F /FI "MODULES eq msys-2.0.dll"
@@ -111,6 +110,11 @@ windows_msys2_task:
           mingw-w64-x86_64-curl \
           mingw-w64-x86_64-gnutls \
           "
+        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
+          https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
+          C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -U /c/tools/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz"
+        del C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
         C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
         cd C:\tools\msys64
         echo "Start archive"
-- 
2.28.0.windows.1


