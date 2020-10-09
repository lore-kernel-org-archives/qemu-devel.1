Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02EC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5CE2225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThpUSC5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5CE2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvnO-0006vi-Em
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJM-0000LR-7U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJJ-0005A9-Ta
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id n6so10635913wrm.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0dekJyMhyeb+pZDMdujnt332y1YtHIKVKhKPCl8YUr0=;
 b=ThpUSC5g/UYZBA9aIWZ2c2dA2jB8sIDbuAfmzIjUku3dklqnGsYlyGHdxjkmqli05X
 weew9/1TPwu0uJhoaHfJRz+jdxUFWKpUzHIDAOP/2yd+vNFLkcdzYnEwY7OTphytUx+5
 gH6jdOgPFXEu17eJzdVsGYHDmrCSHCrmeYLl+rmdOrToYCwem4Wtvr5aNNUrMpoAl3PJ
 JiWPtfnWFvF7fu22CJL5OaJd6hf7JjZFCjFQzWHONc5/qDdn9486vSmi8juOzt+OYw6R
 VBARdsCiR4CjTcvY4F5Y2gwH6o2n8mJ3NcSJuPUfb7EoAuutQMsibIzrrab/8DD5gYof
 8P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0dekJyMhyeb+pZDMdujnt332y1YtHIKVKhKPCl8YUr0=;
 b=p1+oj2t6lCVVbN09seZeWbIfD34h+GEXkCU9tW/extWpIoEjHcwYUC5jHys4YuzdRG
 r7qqTfoN0bHtb4+CpYK+0kl7XEinMkhwGji320J4pfU98oTeWCAAvRfMdOZxsikYwmFT
 HihvoYVTQ5As1VoOwXeRijc6sYSuidC2DFAWg/vdguHNk2M1ARiqcdICmvUJOfwjPi1N
 lRK0baZir98qlha4Utw4kINh9LCnqiLdTI78MPVv9rq6pMDjBBhWDy4YQ8cNbNNz4+y8
 XmBG6AF6/cizOPUZd+gapjDPK94rw6gkfuNYbzUsL4nr5Vhess4zkK+1o6KgoeQ/VlA6
 TrpA==
X-Gm-Message-State: AOAM5321WOk7c2azZV6atyyQlHDnbdyye4YG/vT84em6op3wfEapijal
 G+oeOt1N8VwtP4HpfoGsQP1zcA==
X-Google-Smtp-Source: ABdhPJx6U1XoZz/zB4zkeSdVUxgdRVQVX691onkVIWrxflf5ZNrL+UdJsac/6VlG1iS8z2Xi4PiEOw==
X-Received: by 2002:adf:dccd:: with SMTP id x13mr17020229wrm.403.1602261120360; 
 Fri, 09 Oct 2020 09:32:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i126sm12529139wmi.0.2020.10.09.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DDB91FF90;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/22] cirrus: Fixing and speedup the msys2/mingw CI
Date: Fri,  9 Oct 2020 17:31:29 +0100
Message-Id: <20201009163147.28512-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
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

[AJB: renamed printenv_script to setup_script]

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201007145300.1197-2-luoyonggang@gmail.com>
Message-Id: <20201007160038.26953-5-alex.bennee@linaro.org>

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


