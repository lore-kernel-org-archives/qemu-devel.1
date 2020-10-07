Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93956C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DE520789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/OzeKau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DE520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQC4K-00078B-M1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs4-0005EB-Mj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBrz-0000tN-7X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so2795429wru.12
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qV/3JEXdswCCkH9Pi3CZ05jxPlz/Vt1p10XE1V4Oo4g=;
 b=P/OzeKauKWWSMZEFDqLDwPk+smPLe6XRtUJai32+Dbp8isrcJU48UDNU0QO1cbYYgP
 DNAQSk3knUko+A53g8e9TkSFbIU/0wmIfS6leOd8BJrCxPvbehcVLEppaw9b+jOfjtGv
 RVEY+DhaSERqHsMwkKPTVNbamYDA6/shYc8mCsxE949EUMzwjqMAPBol98mYplKXAn9+
 SLkOa1DC91MVWHprjQdsf4B3+PAWXGg9DqJak+i5Umn4VluuU3s1Phz3ze1ffYwh9fDE
 MMPAwejOLHWMLiYT04CfKscnggLJvPabNyyHLWjPJ3VB3KK+E5weDMGqqe0leKtr9wrf
 k2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qV/3JEXdswCCkH9Pi3CZ05jxPlz/Vt1p10XE1V4Oo4g=;
 b=bE0aPB5L0+Leixh6+BXShzkQTT4Rm3VgUKtiuNHBlhzPWqhi4tO27kRlAyIGt80bTq
 dLckFr1dfaFjY6Nb7fJO69ZFAyDF7E8+6j2RGMAb9bHvJnRPSaifbjd0P8bPbofdzwFE
 ofKL3TiYj4y6vEGli8A4NqP+wKcs4o3NyCyYXmxS/ose6kkDMl0XzRGDeAB078I8HzuN
 Xo9Dc9S0MZpLjK99fhkLiUhssoD73Yl2L9Eu0eeGmHMj9QuJ+adJ9WUW9uHTGJfNwSh0
 5TnDberiDFRkHF2/Z3haCfyl/VDXMyqVK4H00m8cv2XDoG8x2kr92gGvhHY2peadd2ix
 C2dw==
X-Gm-Message-State: AOAM533U3MsWcHfVU/10HZq2llcANt3zHMOdPPU1Zx51ef2z76wh/7qN
 pRZU32x9V0u9+wxED3Lvr7RhTw==
X-Google-Smtp-Source: ABdhPJzTV+tdn1ju/5TFh2TAX5fRzhsYEnp3uh06Wgu9FnQ9eiSdBUdbkASuWeXinQ0amJFcrk6bcw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr4150572wrp.332.1602086445373; 
 Wed, 07 Oct 2020 09:00:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm3540691wrb.21.2020.10.07.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D0241FF90;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 04/22] cirrus: Fixing and speedup the msys2/mingw CI
Date: Wed,  7 Oct 2020 17:00:20 +0100
Message-Id: <20201007160038.26953-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Ed Maste <emaste@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Use cache of cirrus caching msys2
The install of msys2 are refer to https://github.com/msys2/setup-msys2
The first time install msys2 would be time consuming, so increase timeout_in to 90m
according to https://cirrus-ci.org/faq/#instance-timed-out

Apply patch of https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201007145300.1197-2-luoyonggang@gmail.com>
[AJB: renamed printenv_script to setup_script]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 112 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..eb768fa260 100644
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
-  printenv_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  setup_script:
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
2.20.1


