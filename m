Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF89C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3984422269
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBgVwGlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3984422269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqKS-0007jx-1F
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqGA-0003As-Uf; Fri, 09 Oct 2020 07:08:26 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:40925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqG8-0007ze-R0; Fri, 09 Oct 2020 07:08:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id w21so6573954pfc.7;
 Fri, 09 Oct 2020 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7SLaojD6nPx1Ab15Mm0PQZhp0vssO9QPF0B/GdQmMBs=;
 b=lBgVwGlHS1mQdQVpiVruu8RfeSwEwRs9jybYRjyrUQrh1CEx91I7ZAEIUClg8sLUT/
 qpf5VYK8jxvCiHrJOizmwKR8Nx0KaOAsub/99cNWJfMrLQf6Isjve+ufSYMUpAMeYBoy
 hcyMzeqFq9WvmX7i1vrYmIF+G7m+FZT+d1XvIkidGPxeubT/XEtK1ggoddJSKU8C0DdT
 6H4/982UZHTvWlhxomzLBbJezCVoT5qJGk72wUCimpdQjsWeBnRUjFeWw4op9F8ayp2+
 rkVLx0/jSmeHm06JnsMIMNH+HAxmcin9KGsMl3gcRUlpw6lxQ50MOPQMLD8uF4sQP9Mo
 ilfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7SLaojD6nPx1Ab15Mm0PQZhp0vssO9QPF0B/GdQmMBs=;
 b=ef3pkzCdYUQiAiNtC+wWo+Z8RRDtATv+0KmKauDSLdv3D2l7cdbyE5cpF82X7KQtGz
 SySm4ZlfCq3Cb4MEspJuaDJIedZTEbtRaM+DtByclZ1S2ArIKts5GAJMRd3/4pLbUv2k
 9QtdjxX6e9GzSlcz3uJ4KiIJp/evwMtZliU6ZzO564CcdA5PgOO+djw6ZZZQ9xCwjo/h
 ukcNEhPQ3pVUpPqVjv+yr78G99CO8SHIBhHQ9cGlpUQQAfSFdmF0u+JmRuIIDsvxSne0
 k78vGhfUnMGbnMzeKnwQiTriIFGS0+Qatad5mYMzPMeBCgS7tkxLgSFSZTZN4yN58VqT
 t7Jw==
X-Gm-Message-State: AOAM5300gLehAqiEAlSkC59xdwFsOAH/MKd5av4faVLH9qWakXeEJwDv
 WqXF9Bn/EYr/D42vQrDSQFmSYPHBPc4FTBmd
X-Google-Smtp-Source: ABdhPJzsl7TBnH98EnkyjFLDn+H8zJpSGcBYWvcASwC8XlHLjK4ib5CR+PFkShsWoKf8jj3Uc1ts/Q==
X-Received: by 2002:a62:1613:0:b029:152:743c:355c with SMTP id
 19-20020a6216130000b0290152743c355cmr11733675pfw.15.1602241699817; 
 Fri, 09 Oct 2020 04:08:19 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v1sm2619462pjt.2.2020.10.09.04.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 04:08:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/4] cirrus: Fixing and speedup the msys2/mingw CI
Date: Fri,  9 Oct 2020 19:07:57 +0800
Message-Id: <20201009110800.432-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201009110800.432-1-luoyonggang@gmail.com>
References: <20201009110800.432-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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
 .cirrus.yml | 111 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 45 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..ed3db10e45 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -46,64 +46,85 @@ macos_xcode_task:
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


