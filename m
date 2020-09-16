Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A40C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3C522210
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG5d9RWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3C522210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWHG-0005DS-Gu
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVv8-0007TW-Eu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVv6-0008DI-Gy
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv/yOb/SN2uqPy61RGF0jsphnBom+eGfuJ+sgwlLPs8=;
 b=BG5d9RWM3P7VgXkKof1o7L4nswDvWsqKL8y/I9gMPRq1eYBbbBX1oLMAH4pqT89NmQMgmI
 SvPT2KXIVChSQd7BN4waHcBhAzS1L4mbcgKwvnsvAIyVfQauqEoX7B7IUH2z9BGySlmtuF
 KCkZiTRBbBM32xZvo6CrsVKRVjlKt5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-ZZUAYVbGO96PhGH2A3gWgw-1; Wed, 16 Sep 2020 07:48:11 -0400
X-MC-Unique: ZZUAYVbGO96PhGH2A3gWgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13D271007474;
 Wed, 16 Sep 2020 11:48:10 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 154DD5DA71;
 Wed, 16 Sep 2020 11:48:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/24] ci: Enable msys2 ci in cirrus
Date: Wed, 16 Sep 2020 13:47:30 +0200
Message-Id: <20200916114731.102080-24-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Install msys2 in a proper way refer to:
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699
The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.
There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then
we don't need the --cross-prefix, besides we use environment variable settings:
    MSYS: winsymlinks:nativestrict
    MSYSTEM: MINGW64
    CHERE_INVOKING: 1
to opening mingw64 native shell.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200915121318.247-25-luoyonggang@gmail.com>
[thuth: Add --target-list-exclude to speed it up a little bit, and
        add capstone package to avoid build failure with internal capstone]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 3dd9fcff7f..e5feb53b54 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -63,3 +63,66 @@ macos_xcode_task:
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
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        base-devel
+        git
+        mingw-w64-x86_64-python
+        mingw-w64-x86_64-python-setuptools
+        mingw-w64-x86_64-toolchain
+        mingw-w64-x86_64-capstone
+        mingw-w64-x86_64-SDL2
+        mingw-w64-x86_64-SDL2_image
+        mingw-w64-x86_64-gtk3
+        mingw-w64-x86_64-glib2
+        mingw-w64-x86_64-ninja
+        mingw-w64-x86_64-make
+        mingw-w64-x86_64-lzo2
+        mingw-w64-x86_64-zstd
+        mingw-w64-x86_64-libjpeg-turbo
+        mingw-w64-x86_64-pixman
+        mingw-w64-x86_64-libgcrypt
+        mingw-w64-x86_64-libpng
+        mingw-w64-x86_64-libssh
+        mingw-w64-x86_64-libxml2
+        mingw-w64-x86_64-snappy
+        mingw-w64-x86_64-libusb
+        mingw-w64-x86_64-usbredir
+        mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-nettle
+        mingw-w64-x86_64-cyrus-sasl
+        mingw-w64-x86_64-curl
+        mingw-w64-x86_64-gnutls
+        mingw-w64-x86_64-zstd"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
+      --python=python3 --ninja=ninja
+      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+  test_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.18.2


