Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F002C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8947204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJsZhHIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8947204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ggC-0004yg-Gb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHJ-0004xl-JA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHH-0006C1-UV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id g8so13424427wmk.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2gAEVfLwds7d2Tav/gcydNw8MTDXwaqdfdKjcmTKtiE=;
 b=ZJsZhHIiJ6Wg1r7IT8dULIyCJpL4mHCcc3kUrAl3PaWpPN21BTXhrw82hoJXXn9dC9
 XiTBG+TKoQOaRNFKJwxN1UNTDvP40pXVUrWZ4+FBTgXVBbi4u/n4vqEJSJECqEJA6nMZ
 qlGchNINFRYQlP+kkG3m9RZDeo9ltDtduDpZobKCyJJCvoxAeiU39lf15ITuhtRsvtjK
 /Mk0xqxc+Lh2QXPL3khBhylDDXkozVBrnELk0N7k+wi+Rny5hFZdz6PLqjTKqWPSdZXL
 asHVjpPwkxRk1WOCCCWPKJa3uM9S34DWXS/6TQ99VcybA8rE4BUF8zrsHFWbPjogMmsv
 0Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2gAEVfLwds7d2Tav/gcydNw8MTDXwaqdfdKjcmTKtiE=;
 b=K55JPNV4eYx8I1ApjpPVOE2XKVbQ3+Ir51izIwYdLs2FyHj3fx30EXYaZgnJKJycZy
 tdJsK/k/v+rp0sb91XMi/yebBP0eVRvDjovZk18tDv/vM1bEhWzLWe0TAB3/fMaoJ/Ec
 Mu6HITF64CXhz9cMC5ZhFfZxP7AZhsGArXL13TOmkMc3JFY+zALnHuXgcF8VeSeaNMdq
 0hOh87PnryNyHc2syqmHJfEKB8RDyVi0GG5JTxwpsW7rP/nTnd/pEl85aTuVmHyKTBfK
 5f0erXgG040mOYukv5VSc5XG+xmSn2l15VNT6zeKBGbderUgns909h5HuFNCLD+BEzyt
 6ufw==
X-Gm-Message-State: AOAM530COD1cphC48nzllUt+LqhBy+VZ6gAuX7oNkFBWRl2/8PZtXjJS
 zl3Bz62iWwyjy6q2a/BtZUuHBl5ML3k=
X-Google-Smtp-Source: ABdhPJybxciPZff4aziRz2ZyCP2kqRjqiQZDJ+UTsb6K97LtKGTxAKN1q6awhqOL58V6kULvB4YsUw==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr15821893wmb.151.1597675102302; 
 Mon, 17 Aug 2020 07:38:22 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 058/150] meson: convert io directory to Meson
Date: Mon, 17 Aug 2020 16:35:51 +0200
Message-Id: <20200817143723.343284-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile         |  1 -
 Makefile.objs    |  2 +-
 Makefile.target  |  2 +-
 io/Makefile.objs | 12 ------------
 io/meson.build   | 25 +++++++++++++++++++++++++
 meson.build      |  1 +
 6 files changed, 28 insertions(+), 15 deletions(-)
 delete mode 100644 io/Makefile.objs
 create mode 100644 io/meson.build

diff --git a/Makefile b/Makefile
index 6995661e40..25eca25d63 100644
--- a/Makefile
+++ b/Makefile
@@ -235,7 +235,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-m \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
-                io-obj-y \
                 common-obj-y \
                 common-obj-m)
 
diff --git a/Makefile.objs b/Makefile.objs
index 018338d2db..0920cdb40c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,7 +21,7 @@ block-obj-m = block/
 
 crypto-obj-y = crypto/libcrypto.fa
 
-io-obj-y = io/
+io-obj-y = io/libio.fa
 
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 
diff --git a/Makefile.target b/Makefile.target
index b213955a81..f6b7a86390 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -194,12 +194,12 @@ include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
               crypto-obj-y \
+              io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               io-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/io/Makefile.objs b/io/Makefile.objs
deleted file mode 100644
index 9a20fce4ed..0000000000
--- a/io/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-io-obj-y = channel.o
-io-obj-y += channel-buffer.o
-io-obj-y += channel-command.o
-io-obj-y += channel-file.o
-io-obj-y += channel-socket.o
-io-obj-y += channel-tls.o
-io-obj-y += channel-watch.o
-io-obj-y += channel-websock.o
-io-obj-y += channel-util.o
-io-obj-y += dns-resolver.o
-io-obj-y += net-listener.o
-io-obj-y += task.o
diff --git a/io/meson.build b/io/meson.build
new file mode 100644
index 0000000000..062e011bf0
--- /dev/null
+++ b/io/meson.build
@@ -0,0 +1,25 @@
+io_ss = ss.source_set()
+io_ss.add(genh)
+io_ss.add(files(
+  'channel-buffer.c',
+  'channel-command.c',
+  'channel-file.c',
+  'channel-socket.c',
+  'channel-tls.c',
+  'channel-util.c',
+  'channel-watch.c',
+  'channel-websock.c',
+  'channel.c',
+  'dns-resolver.c',
+  'net-listener.c',
+  'task.c',
+))
+
+io_ss = io_ss.apply(config_host, strict: false)
+libio = static_library('io', io_ss.sources(),
+                       dependencies: [io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
diff --git a/meson.build b/meson.build
index 6b046f43aa..3e7d3e6b0e 100644
--- a/meson.build
+++ b/meson.build
@@ -342,6 +342,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('io')
 subdir('fsdev')
 
 # Other build targets
-- 
2.26.2



