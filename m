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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72205C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3519208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5dk88Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3519208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0X0-0004iU-1h
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0V7-0003AI-TI; Tue, 06 Oct 2020 23:52:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:36864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0V3-0001zq-Ig; Tue, 06 Oct 2020 23:52:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id 144so569014pfb.4;
 Tue, 06 Oct 2020 20:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grAjwWPlIxcQ9G5jUZTuwOm75bHgIjMki0QLYHogn+A=;
 b=l5dk88Dz8+dsTTT2S9m95GIeLkyBdCjqnY4q1IVLQ+CAEKQe8tTyVjnE2iyASdup5K
 WpbOMR1wQ5o01QEFlu6jMmvVI+JrfGx83/l1pE3zs0JoZw56HYOrRN7jE0zyjQSYB7El
 a031zwHta/7QIQsTn8L5zXFSC3HRey+anAlktEWCf+h1M9nqWZJ+TchDZQZ+rcbs+2zm
 +iJ4CDgWcn0to5b+RICxJvwEh3GiD3i9+d3UbN8of+0VLVO1JBSdx8wzCt4LG6cXghiD
 cjNkOFQ7tXTDOSGv+Tg/r+haZ1t4p8Uo/I0lxMEFLsE8yYfXSLmElZvaDNbKxf/H7AKa
 EBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=grAjwWPlIxcQ9G5jUZTuwOm75bHgIjMki0QLYHogn+A=;
 b=g/tEpwUUhuxIdxiUEwGeSTtFKKVubYrxI2oQ/KQPxH+BJVTSUp9hak8zSNBa86gI/v
 vFPh95YQl5IWJLFi+jnPMGftrLdW0WCDyZBGy2pDItGPbMXMd9CY5UkwnV5Qib3qOxgX
 pj5gsuckfK7OqpHgeEKftePlxJUwo6GtYFRNmQX+WHMaUDdueMBcqmdGFcuZ/zlWRcXs
 nOg2nIME1+bykEuCFvXHiNHQpR4bxWWfYPO2Dm21jb65WtW0A3oEwsIcQVkuPDmYzAyk
 pei3ncs8kLnnIG+hW4mA1ZtDFMyj5OQJxTg6LSbX4FHRHYEcynjyhjcspXgws3tJIer6
 NceQ==
X-Gm-Message-State: AOAM532SO/TC9N7AENPmv0xUUaxHneF0CqSK6qapxdM7p7je89H+Nt3I
 h24nx8VqARiwX8K/gNpl568RyGMt/KqWIw==
X-Google-Smtp-Source: ABdhPJzXGLElUzEDN7ZOfKiNOWcB7lEJmrKShizVryRRCFIRPwvIC08TcprATS/9LdOCJGTCE5fZTw==
X-Received: by 2002:a05:6a00:23cc:b029:142:2501:35cf with SMTP id
 g12-20020a056a0023ccb0290142250135cfmr1216143pfc.47.1602042739193; 
 Tue, 06 Oct 2020 20:52:19 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v10sm497031pjf.34.2020.10.06.20.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 20:52:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] cirrus: Fixing and speedup the msys2/mingw CI
Date: Wed,  7 Oct 2020 11:51:53 +0800
Message-Id: <20201007035154.109-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007035154.109-1-luoyonggang@gmail.com>
References: <20201007035154.109-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x431.google.com
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
 1 file changed, 15 insertions(+), 45 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..bf5a0990ec 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -47,63 +47,33 @@ macos_xcode_task:
 
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


