Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C563BC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326432078B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJlJQYeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326432078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Cp-0002Js-91
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53k-0000Ls-AT; Wed, 09 Sep 2020 14:43:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53d-0007ny-SW; Wed, 09 Sep 2020 14:43:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so2692456pgd.12;
 Wed, 09 Sep 2020 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wvwUANr59f9uuudazEg+hKm+epX9PoFUd8dpqevdGUY=;
 b=NJlJQYegoy6xhrpRgGp96KhIHzCj0TDN2M9Jtu0lmeM/Z4Z7xEeDGpfBJCHc4DVntk
 ZGXhTkXWCAuJqhEHgU5OCexH/8I852NNvVFhOAQNOXGFAIheLlC8yaWGBSpH/M7LR6h9
 XZSlhLNpOQDSp/jPEEr9m7jk8GyKGM820HrfAiyN6ISGJ14wq8GzZ4v/hNK5xaVpypTG
 09r22LRKWjpsrNHgxTLHN5mIB+Xs42lxijftBZ3tHQGSigXeKqakGofy/NBgF+eWdijs
 1LmqdBLCe1+zGiipJQqR1v9S28GrQ+eLsnvb6RoaEGIgR2MYo+18zFF8fU5KXmlvBl0O
 v7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wvwUANr59f9uuudazEg+hKm+epX9PoFUd8dpqevdGUY=;
 b=uoWS9nDpRH/184VL/9z/oC6dpr/Y2AUaiQZ/u9Y0Sd9VgV5b17WlGJrbSOn7DtP4iD
 sgyi6MQJkQTMOhWJ++COepXzAd7tdzzjqzWMolk6pmU4fCna7jYGaITGMPZ5ybEJzTL0
 8zLBN51yO+EyaVXu2zivRhJ0FhauTRt6he3rrEJGqfYCt8+1XKSRIomJKyrXIcNVhM4g
 OPOPgAg8mmPaQ69vm0UCWGQZvTTuCtiLDgv54riNpE7ALH6CzeWLR4O/ZmB6zyjhhgzI
 ndvepxRld8uDD7nXwrbxxq07IuJRrIX+hVSud2j+p8ZuSXbDEdnmkQ04Sh2p26weCH0s
 gWSA==
X-Gm-Message-State: AOAM532C3kDcrR5eeNm6VKNTsOKBvJ+rNypl7JP+BQAmi+FyWDks1YBE
 m7yCzjnnoAafe6FtRQIc5pjhLuOk0ktvhvcx
X-Google-Smtp-Source: ABdhPJw/wJIc0S1WARZ9G0FkPcSG6IL9Zxoq00AC8U116Y76CFh1+1bLud3/Q8lmxF6sZvJX7a9/Hw==
X-Received: by 2002:a63:5966:: with SMTP id j38mr1567003pgm.187.1599676979453; 
 Wed, 09 Sep 2020 11:42:59 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 63sm3521673pfw.42.2020.09.09.11.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 11:42:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 24/25] ci: Enable msys2 ci in cirrus
Date: Thu, 10 Sep 2020 02:42:36 +0800
Message-Id: <20200909184237.765-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909184237.765-1-luoyonggang@gmail.com>
References: <20200909184237.765-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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

Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus-ci-docs/issues/699
The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.
There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then we don't
need the --cross-prefix, besides we using environment variable settings:
    MSYS: winsymlinks:nativestrict
    MSYSTEM: MINGW64
    CHERE_INVOKING: 1
to opening mingw64 native shell.
We now running tests with make -i check to skip tests errors.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .cirrus.yml | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index a18971aac4..fa6edf1d5c 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -44,3 +44,63 @@ macos_xcode_task:
                    --enable-werror --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
+
+windows_msys2_task:
+  windows_container:
+    image: cirrusci/windowsservercore:cmake
+    os_version: 2019
+    cpu: 8
+    memory: 8G
+  env:
+    MSYS: winsymlinks:nativestrict
+    MSYSTEM: MINGW64
+    CHERE_INVOKING: 1
+  printenv_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  install_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        base-devel
+        git
+        mingw-w64-x86_64-python
+        mingw-w64-x86_64-python-setuptools
+        mingw-w64-x86_64-toolchain
+        mingw-w64-x86_64-SDL2
+        mingw-w64-x86_64-SDL2_image
+        mingw-w64-x86_64-gtk3
+        mingw-w64-x86_64-glib2
+        mingw-w64-x86_64-ninja
+        mingw-w64-x86_64-make
+        mingw-w64-x86_64-jemalloc
+        mingw-w64-x86_64-lzo2
+        mingw-w64-x86_64-zstd
+        mingw-w64-x86_64-libjpeg-turbo
+        mingw-w64-x86_64-pixman
+        mingw-w64-x86_64-libgcrypt
+        mingw-w64-x86_64-capstone
+        mingw-w64-x86_64-libpng
+        mingw-w64-x86_64-libssh
+        mingw-w64-x86_64-libxml2
+        mingw-w64-x86_64-snappy
+        mingw-w64-x86_64-libusb
+        mingw-w64-x86_64-usbredir
+        mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-libnfs
+        mingw-w64-x86_64-nettle
+        mingw-w64-x86_64-cyrus-sasl
+        mingw-w64-x86_64-curl
+        mingw-w64-x86_64-gnutls
+        mingw-w64-x86_64-zstd"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3 --ninja=ninja"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+  test_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
+
-- 
2.28.0.windows.1


