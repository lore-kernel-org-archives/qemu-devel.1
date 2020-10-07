Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E0C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414BB20853
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCSQEndQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414BB20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPzR9-0001m0-6L
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 22:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzP0-00006P-Ph; Tue, 06 Oct 2020 22:42:02 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzOy-00058b-OM; Tue, 06 Oct 2020 22:42:02 -0400
Received: by mail-pg1-x530.google.com with SMTP id x16so459269pgj.3;
 Tue, 06 Oct 2020 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yzyoT3EWoqbgFq5cOVihC5y3N/yquB50UxHbVSa/z7s=;
 b=uCSQEndQ2UX5mqgFc5MRpH/s3SMpi7g/8RVDOYizk6R0vrO1MZ7f8Q3kpgzMgOeF/t
 +yfq7feAq1iEV/Ljj6o5MIH95lE3YZQDMovENQo3Ez/3FqEKpqXvip6PGIh0WqTZsFoo
 mLx8C7cp3eF0V3oQTg8dxnUAyqc2m8JI8fz9KGCrf1MGndffwggo4FPU/LwjMiLkhJWX
 p2ccVwWyscBTbgD/GulgTu0h58WNkbwXhjp/n7LzD3W30UsF/V6eMxi7fd+JS9F6Boxk
 8YBTWG5AewC590Fv/CSHwZ5ZSx3xK8lMKRKmHxzwW+U/ibv2jsNys+0L84qO8DdLIq8E
 Hfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yzyoT3EWoqbgFq5cOVihC5y3N/yquB50UxHbVSa/z7s=;
 b=Mj953KUBiyAtyJUKaJoAwrbnxwVp6iKl8q1G3j1uvCNp84aDL3eqVjgJ7kwp/PTEfz
 6Ht/hR0t+hVtOG3RUhKSa/j3ovaNDvkF5M6hkowx020UHH2DdvJWRRA7IeDzDK5a9Z2L
 VVSeHawOMQnPksgBoRQJpPzLQ0I09u1yhhFxRiBXbVR1g/ZuJZuEscIOXQ1Y3ECcNAqx
 Swo9FuUvK8WsojLgvMc/T6WgXrLGOtcikVYXqMzinIVFMZFn5qwMrYEPOUCdNW48DxTP
 1CVWq+i4yaifBMIWX+7FmgxIzypS5cvTrdyUO5SMUoec1EKk8toZXTfQZlzipXJcH9Uy
 dy+A==
X-Gm-Message-State: AOAM533uq8+S/4XjlmcKLYPnCmsARr0xf+Ne39YgOOqkecoxyt+89FVm
 kpJ7Zs5SgXfntWvEzyIQk1zE1Yd1o52kwA==
X-Google-Smtp-Source: ABdhPJzvVHSWvv02aX1y8pKfjmwqaQMc147olJEG2mSzN/J6KtYavbgz6l1+RwiFu8qg6+fpVuo4Pw==
X-Received: by 2002:a63:1061:: with SMTP id 33mr1132660pgq.204.1602038518405; 
 Tue, 06 Oct 2020 19:41:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u27sm583913pgm.60.2020.10.06.19.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 19:41:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] cirrus: Fixing and speedup the msys2/mingw CI
Date: Wed,  7 Oct 2020 10:41:35 +0800
Message-Id: <20201007024135.1885-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007024135.1885-1-luoyonggang@gmail.com>
References: <20201007024135.1885-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x530.google.com
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
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a prepared https://github.com/lygstate/qemu/releases/download/v5.1.0/msys2-x86_64.tar.xz
for speed up the msys2/mingw prepare speed on the cirrus CI.
This file are generated by the msys2.docker

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 60 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 5363142373..1c2a05abd4 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -47,59 +47,31 @@ macos_xcode_task:
 
 windows_msys2_task:
   windows_container:
-    image: cirrusci/windowsservercore:cmake
+    image: cirrusci/windowsservercore:2019
     os_version: 2019
     cpu: 8
     memory: 8G
   env:
+    CIRRUS_SHELL: powershell
     MSYS: winsymlinks:nativestrict
     MSYSTEM: MINGW64
     CHERE_INVOKING: 1
-  printenv_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
   install_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
+    - |
+      Write-Output $env:PATH
+      md C:\tools
+      $start_time = Get-Date
+      bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/lygstate/qemu/releases/download/v5.1.0/msys2-x86_64.tar.xz C:\tools\msys2-x86_64.tar.xz
+      Write-Output "Download time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
+      $start_time = Get-Date
+      cd C:\tools
+      choco install -y --no-progress 7zip
+      cmd /C "7z x msys2-x86_64.tar.xz -so | 7z x -aoa -simsys2-x86_64.tar -ttar -omsys64"
+      Write-Output "Extract time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
     - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
-        bash pacman pacman-mirrors msys2-runtime"
-    - taskkill /F /IM gpg-agent.exe
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
-        base-devel
-        git
-        mingw-w64-x86_64-python
-        mingw-w64-x86_64-python-setuptools
-        mingw-w64-x86_64-toolchain
-        mingw-w64-x86_64-capstone
-        mingw-w64-x86_64-SDL2
-        mingw-w64-x86_64-SDL2_image
-        mingw-w64-x86_64-gtk3
-        mingw-w64-x86_64-glib2
-        mingw-w64-x86_64-ninja
-        mingw-w64-x86_64-make
-        mingw-w64-x86_64-lzo2
-        mingw-w64-x86_64-zstd
-        mingw-w64-x86_64-libjpeg-turbo
-        mingw-w64-x86_64-pixman
-        mingw-w64-x86_64-libgcrypt
-        mingw-w64-x86_64-libpng
-        mingw-w64-x86_64-libssh
-        mingw-w64-x86_64-libxml2
-        mingw-w64-x86_64-snappy
-        mingw-w64-x86_64-libusb
-        mingw-w64-x86_64-usbredir
-        mingw-w64-x86_64-libtasn1
-        mingw-w64-x86_64-libnfs
-        mingw-w64-x86_64-nettle
-        mingw-w64-x86_64-cyrus-sasl
-        mingw-w64-x86_64-curl
-        mingw-w64-x86_64-gnutls
-        mingw-w64-x86_64-zstd"
+      mingw-w64-x86_64-python-sphinx
+      mingw-w64-x86_64-libnfs"
+
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
-- 
2.28.0.windows.1


