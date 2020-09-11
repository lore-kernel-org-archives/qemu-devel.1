Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A896C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD5C22272
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA/3vz+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD5C22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjMN-0002Yy-89
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJp-0007e5-UO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:25 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJn-0002ly-FW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:25 -0400
Received: by mail-ej1-x642.google.com with SMTP id z23so13819062ejr.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qgjd5IoBDklcBr4dzvOP83PbUpl1nXQnUvNpMJ7K9tY=;
 b=eA/3vz+G0S8GGD6b0OMRQx6G8Thu2ey/R/wyucsPQJds7Wl5EigXLZP/uQ56nkITSz
 yiizmZvWwzMvLP8Q+4uBafIT+jfZrZjozw7FtYKAD/b7wQJjafLPmKgsAOwvsdNfGPNE
 FE4e21pmX6fn+zCxjx7rIATbX8/HfkRzGONhM8kd2n9ZRZso19pPrxIBpsN/q5EtgUE2
 50ePZoH1gr2CzJWFP+AQhCBdZZF7IYHypG3tqJWPWhO8ChiOYnaCWkW/WSWmyKfcwPV8
 Tadx9Dl8+1zXhItZQjRycf4nSfzahY1+Qm6AHqw6WxBIhH2cdQto904t6w3a2hDchR9s
 fRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Qgjd5IoBDklcBr4dzvOP83PbUpl1nXQnUvNpMJ7K9tY=;
 b=P8jY9QpdDFJyMiPsohc+GYpA4NDnZZwkUDOdDaAeBp/tIYNbuSx/uPBmWmwb6kkwpY
 z4c1TSJfnp/sw1pUqiFrH8nTa6qTbNnAy8NinTiYUpZjTP28xeo0na3QVq6XGWnyV+Zs
 Rd+7ndGOzi49cc8Efxfmvj2n+QG6efUQKgdFy2eYJ2nTYWjmyqZvIIrYCosMrhqixs5Y
 QF7NKmX2ZphpaFCggD0CSt5TPKtvaaTXfXiqrPGJdpGjZoJag9Zm7JKBJJpJcNBRsjdt
 T4r0IWUlgzL9PsSN8ktmS3Gm6uwgQ7jXnUySSkF5zx+kVfHcQTcAOKBnHHv/RoT/2kPw
 7vhw==
X-Gm-Message-State: AOAM530Wj5iVJeDIg7rKs1/Bifzm76GOM97NBTsFjk48ycZPc7wMPX8p
 DBp3i7zfsr5BXb4mThAnmKGRtbhnKyQ=
X-Google-Smtp-Source: ABdhPJyVa10YdRzO1aRORaCNMVyEm+W7EWVZNzOFep16J9KfOo+ufvENbxJ6fYaK9yIEGZ86CwrgtA==
X-Received: by 2002:a17:907:118c:: with SMTP id
 uz12mr2068486ejb.321.1599831741400; 
 Fri, 11 Sep 2020 06:42:21 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id i35sm1757165edi.41.2020.09.11.06.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 06:42:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: clean up build_by_default
Date: Fri, 11 Sep 2020 15:42:19 +0200
Message-Id: <20200911134221.46636-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build all executables by default except for the known-broken ones.

This also allows running qemu-iotests without manually building
socket_scm_helper.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst    | 5 +++++
 tests/fp/meson.build           | 2 --
 tests/meson.build              | 3 +--
 tests/qemu-iotests/meson.build | 3 +--
 trace/meson.build              | 1 -
 ui/shader/meson.build          | 1 -
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 08e85c69e1..2ee368fad6 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -193,6 +193,11 @@ compilation as possible. The Meson "sourceset" functionality is used
 to list the files and their dependency on various configuration  
 symbols.
 
+All executables are built by default, except for some `contrib/`
+binaries that are known to fail to build on some platforms (for example
+32-bit or big-endian platforms).  Tests are also built by default,
+though that might change in the future.
+
 Various subsystems that are common to both tools and emulators have
 their own sourceset, for example `block_ss` for the block device subsystem,
 `chardev_ss` for the character device subsystem, etc.  These sourcesets
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 8779a17aab..24739ad421 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -541,7 +541,6 @@ fpcflags += [
 fptest = executable(
   'fp-test',
   ['fp-test.c', tfdir / 'slowfloat.c', '../../fpu/softfloat.c'],
-  build_by_default: false,
   link_with: [libtestfloat, libsoftfloat],
   dependencies: [qemuutil],
   include_directories: [sfinc, include_directories(tfdir)],
@@ -628,7 +627,6 @@ test('fp-test:mulAdd', fptest,
 fpbench = executable(
   'fp-bench',
   ['fp-bench.c', '../../fpu/softfloat.c'],
-  build_by_default: false,
   link_with: [libtestfloat, libsoftfloat],
   dependencies: [qemuutil],
   include_directories: [sfinc, include_directories(tfdir)],
diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f9..3683512dca 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -246,8 +246,7 @@ if have_tools and 'CONFIG_VHOST_USER' in config_host
   executable('vhost-user-bridge',
              sources: files('vhost-user-bridge.c'),
              link_with: [libvhost_user],
-             dependencies: [qemuutil],
-             build_by_default: false)
+             dependencies: [qemuutil])
 endif
 
 if have_system and 'CONFIG_POSIX' in config_host
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 60470936b4..67aed1e492 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -1,6 +1,5 @@
 if 'CONFIG_LINUX' in config_host
-    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c',
-                                    build_by_default: false)
+    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c')
 else
     socket_scm_helper = []
 endif
diff --git a/trace/meson.build b/trace/meson.build
index b36937d3a6..d5fc45c628 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -70,7 +70,6 @@ foreach d : [
                 output: d[0],
                 input: meson.source_root() / 'trace-events',
                 command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
-                build_by_default: true, # to be removed when added to a target
                 capture: true)
   specific_ss.add(gen)
 endforeach
diff --git a/ui/shader/meson.build b/ui/shader/meson.build
index f69e44ed89..592bf596b9 100644
--- a/ui/shader/meson.build
+++ b/ui/shader/meson.build
@@ -9,7 +9,6 @@ foreach e : shaders
   genh += custom_target(output,
                 output: output,
                 capture: true,
-                build_by_default: true, # to be removed when added to a target
                 input: files('@0@.@1@'.format(e[0], e[1])),
                 command: [shaderinclude, '@INPUT0@'])
 endforeach
-- 
2.26.2


