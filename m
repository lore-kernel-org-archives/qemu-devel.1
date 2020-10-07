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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB516C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC2C20797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWpMFq8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC2C20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAwT-0003Jf-Ay
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAp1-0004fV-UP; Wed, 07 Oct 2020 10:53:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAoy-0006lZ-Ly; Wed, 07 Oct 2020 10:53:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id p11so1126042pld.5;
 Wed, 07 Oct 2020 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4EhuIFWcSXqaq37DHgU+dh3VvW13F3UtBmL3PUs1z00=;
 b=vWpMFq8Dy0FarbZP/er6Wen77xPDlPKALhTjKgtbDGubJaAIVBz8IWEItiyeEGqZoG
 Jr0CR/JnfL6/7M9Uw4yBsutPVyuWe2WDMcGwegRc3JahlvoGtOw77M9xoHqVg12G0vid
 LIWNCHp/AA1/8RqMUJbS7NwoMC1hIPT9Zmwfy/Y5mVeNr3fEGxjpWJbkDLLQdjnirenY
 zbeqzn/GVy8zBpchHsMXk4fTvAmnEo9WiZu7LJr065LvuM2ed/uigxUD9sL/u+S+ZqPO
 1vZun9yMTI21KEV2SRYqjEoOMGI1jGXkiZPqjQC7Ojkz2OTyrlxmhICc3WMscWwu1nFr
 mWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4EhuIFWcSXqaq37DHgU+dh3VvW13F3UtBmL3PUs1z00=;
 b=ZyOtCwerZosBiVmkpTLYlPlxaCzj5C+eu0Fdxs6DOyJpjpPSZ0Vyhse3vNY/kjq4rK
 hhvaBQ7EXFwtBPIiQtOMUPrAz3kg0UlR++MdhwPjSHDCTkJwLQOnKRELyOD+IPuvfjuj
 1aee5xFIkgrmAhqEafsMu8zrT3F8cOKtX95/XLhrXTw/ZO+oahEydKnKwEd+f7nCvQ5t
 J/sIwjKDsIhJA89QuHDuqav1i5q1uXmc6adzrfBPg+Ohe5A/qWEzDu5O6hWmYsNbOtKK
 N9wG10kUJREF7SOpm2f2VOelRJaitC9JI4APszNuKA92z2JKPXVJTX/+1+m/SCT9SWZZ
 k5tw==
X-Gm-Message-State: AOAM532q6mF+t82wOJehMfxQAa3O+kMT0tTD1DRdVpyHPuDrCFTEA4PB
 DUDcy0UGYb8YAb/n19KDxZ6XwJZF4SuOOA==
X-Google-Smtp-Source: ABdhPJyI5HXd18OJTak6L9bwNgBEKkUzLJtxEiAzTcMA3pfrAkauhO/DMZyU0pwpKtPYBvDX4VSNSg==
X-Received: by 2002:a17:902:b949:b029:d2:8abd:c8ed with SMTP id
 h9-20020a170902b949b02900d28abdc8edmr3275910pls.63.1602082405942; 
 Wed, 07 Oct 2020 07:53:25 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u14sm3301514pfm.80.2020.10.07.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 07:53:25 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] cirrus: Fixing and speedup the msys2/mingw CI
Date: Wed,  7 Oct 2020 22:52:59 +0800
Message-Id: <20201007145300.1197-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007145300.1197-1-luoyonggang@gmail.com>
References: <20201007145300.1197-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x629.google.com
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

Use cache of cirrus caching msys2
The install of msys2 are refer to https://github.com/msys2/setup-msys2
The first time install msys2 would be time consuming, so increase timeout_in to 90m
according to https://cirrus-ci.org/faq/#instance-timed-out

Apply patch of https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 110 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 44 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..a1145d0366 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -46,64 +46,86 @@ macos_xcode_task:
     - gmake check
 
 windows_msys2_task:
+  timeout_in: 90m
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
   printenv_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+    - choco install -y --no-progress 7zip
+    - Write-Output $env:PATH
+  msys2_cache:
+    folder: C:\tools\archive
+    reupload_on_changes: false
+    fingerprint_script: cat .cirrus.yml
+    populate_script:
+      - |
+        md C:\tools
+        md C:\tools\archive
+        $start_time = Get-Date
+        cd C:\tools
+        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
+        Write-Output "Download time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
+        C:\tools\base.exe -y
+        ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
+        C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
+        C:\tools\msys64\usr\bin\bash.exe -lc "export"
+        C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
+        C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
+        echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
+        taskkill /F /FI "MODULES eq msys-2.0.dll"
+        tasklist
+        C:\tools\msys64\usr\bin\bash.exe -lc "mv -f /etc/pacman.conf.pacnew /etc/pacman.conf || true"
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Suu --overwrite=*"
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed \
+          diffutils git grep make pkg-config sed \
+          mingw-w64-x86_64-python \
+          mingw-w64-x86_64-python-setuptools \
+          mingw-w64-x86_64-toolchain \
+          mingw-w64-x86_64-SDL2 \
+          mingw-w64-x86_64-SDL2_image \
+          mingw-w64-x86_64-gtk3 \
+          mingw-w64-x86_64-glib2 \
+          mingw-w64-x86_64-ninja \
+          mingw-w64-x86_64-jemalloc \
+          mingw-w64-x86_64-lzo2 \
+          mingw-w64-x86_64-zstd \
+          mingw-w64-x86_64-libjpeg-turbo \
+          mingw-w64-x86_64-pixman \
+          mingw-w64-x86_64-libgcrypt \
+          mingw-w64-x86_64-libpng \
+          mingw-w64-x86_64-libssh \
+          mingw-w64-x86_64-libxml2 \
+          mingw-w64-x86_64-snappy \
+          mingw-w64-x86_64-libusb \
+          mingw-w64-x86_64-usbredir \
+          mingw-w64-x86_64-libtasn1 \
+          mingw-w64-x86_64-nettle \
+          mingw-w64-x86_64-cyrus-sasl \
+          mingw-w64-x86_64-curl \
+          mingw-w64-x86_64-gnutls \
+          "
+        C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
+        cd C:\tools\msys64
+        echo "Start archive"
+        cmd /C "7z a -ttar . -so | 7z a -txz -simsys2-x86_64.tar C:\tools\archive\msys2-x86_64.tar.xz"
   install_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
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
-        mingw-w64-x86_64-nettle
-        mingw-w64-x86_64-cyrus-sasl
-        mingw-w64-x86_64-curl
-        mingw-w64-x86_64-gnutls
-        mingw-w64-x86_64-zstd"
+    - |
+      cd C:\tools
+      cmd /C "7z x C:\tools\archive\msys2-x86_64.tar.xz -so | 7z x -aoa -simsys2-x86_64.tar -ttar -omsys64"
+      C:\tools\msys64\usr\bin\bash.exe -lc "export"
+
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
       --python=python3 --ninja=ninja
       --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


