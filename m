Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861E1204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7jUs2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861E1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7glb-00016Q-O2
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHa-0005HD-In
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHY-0006FI-Nq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id 88so15284118wrh.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RBMoXnf+y3Js1gL23HwqA1CCjiUwc+RJFGNpxIwTuW0=;
 b=Rn7jUs2hIFsv9NnJPGAD1CopgTHNx6iRIETNqrDtO5f+SI6qugxpw7S8s6M+nX3O6c
 iqm95CSuVy3532bgxzHDtmpLNgCrBMQO+tokyBWQX5L7SqyiBx6FupzQQnXewduhBbu1
 0L9hZHJ4STvdxZdXgn0FdtzpVLkS51dJa689B1j38XeUxaPm8rvW25qyICPAKgyLSRil
 0e8l+egmDXJ8vGh+rBPYi2raYfbaj/ry1soFK+KANwgoUrh1/3dyFK+EFU1Xf7kKf/SY
 6gpFFADGNm2we7CIHRE1E4IN5bWi2sAjN2o8okc1XvfTmwMJhKNwzVy2pV/6QYOpy5hV
 Xr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RBMoXnf+y3Js1gL23HwqA1CCjiUwc+RJFGNpxIwTuW0=;
 b=VoaMb90zYAq2XA41W55Fu62qzXnuAZ9mb64g96hM9//Vns6BxrfiAqXlXed0Pmwpl9
 tdGMqI8OnQ57iGRML6/Sq/affoxgDQr85kHDNzC8XAm7tDUU3ZO3uvvGPBynBwG3jFMu
 GCnTINcnp52f/DSdeRYa1UAwqmsijcel0/bnDulbBnoIJyAlATQ97K85Kk192WI85HXY
 ExqyeBZh1nm386zZfm48j00IW2LeE2w66r7qF9i3HpNWPeB2xLHMTtwmD9VtMOn7ERTR
 H6uWxhz4KV2Xaf642/nuUpr6t2GE7UkqBuzbvgQ/q4oEyPE5ksvw5VcQ7Adx024A9VmP
 HJBA==
X-Gm-Message-State: AOAM532FYCo44lproVGQYgvEzO6JFFwisVuPmBnwJzMcyPivBnFGJX4Z
 7XhDPX3mGxFHe8dLMFXAZgZ3Uo5IRdk=
X-Google-Smtp-Source: ABdhPJyQLWSFBZedYNu47xbC1nMetu4eZLslt+EWs+lwe2KfeOj9IufxAulSDie6sCYNlJfP1lhnCQ==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr16892188wru.201.1597675119144; 
 Mon, 17 Aug 2020 07:38:39 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 074/150] meson: convert dump/
Date: Mon, 17 Aug 2020 16:36:07 +0200
Message-Id: <20200817143723.343284-75-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
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
 Makefile.objs      | 3 +--
 Makefile.target    | 1 -
 configure          | 4 ++++
 dump/Makefile.objs | 3 ---
 dump/meson.build   | 4 ++++
 meson.build        | 9 +++++++++
 6 files changed, 18 insertions(+), 6 deletions(-)
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index ec15ebc4b4..6657a6cce3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -48,8 +48,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = dump/
-common-obj-y += monitor/
+common-obj-y = monitor/
 common-obj-y += net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
diff --git a/Makefile.target b/Makefile.target
index 5f926e5bfa..c8f7a6c04b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,7 +156,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
-obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
diff --git a/configure b/configure
index 8711e33f21..dd1f039554 100755
--- a/configure
+++ b/configure
@@ -2571,6 +2571,7 @@ int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
         libs_softmmu="$libs_softmmu -llzo2"
+        lzo_libs="-llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
@@ -2590,6 +2591,7 @@ int main(void) { snappy_max_compressed_length(4096); return 0; }
 EOF
     if compile_prog "" "-lsnappy" ; then
         libs_softmmu="$libs_softmmu -lsnappy"
+        snappy_libs='-lsnappy'
         snappy="yes"
     else
         if test "$snappy" = "yes"; then
@@ -7419,10 +7421,12 @@ fi
 
 if test "$lzo" = "yes" ; then
   echo "CONFIG_LZO=y" >> $config_host_mak
+  echo "LZO_LIBS=$lzo_libs" >> $config_host_mak
 fi
 
 if test "$snappy" = "yes" ; then
   echo "CONFIG_SNAPPY=y" >> $config_host_mak
+  echo "SNAPPY_LIBS=$snappy_libs" >> $config_host_mak
 fi
 
 if test "$bzip2" = "yes" ; then
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
deleted file mode 100644
index d2a5db3b81..0000000000
--- a/dump/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += dump.o
-common-obj-y += dump-hmp-cmds.o
-obj-$(TARGET_X86_64) += win_dump.o
diff --git a/dump/meson.build b/dump/meson.build
new file mode 100644
index 0000000000..2eff29c3ea
--- /dev/null
+++ b/dump/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(files('dump-hmp-cmds.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('dump.c'), snappy, lzo])
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'TARGET_X86_64'], if_true: files('win_dump.c'))
diff --git a/meson.build b/meson.build
index 9169e9d880..e28937dee2 100644
--- a/meson.build
+++ b/meson.build
@@ -296,6 +296,14 @@ if 'CONFIG_FDT' in config_host
   fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
                            link_args: config_host['FDT_LIBS'].split())
 endif
+snappy = not_found
+if 'CONFIG_SNAPPY' in config_host
+  snappy = declare_dependency(link_args: config_host['SNAPPY_LIBS'].split())
+endif
+lzo = not_found
+if 'CONFIG_LZO' in config_host
+  lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -603,6 +611,7 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 subdir('target')
+subdir('dump')
 
 block_ss.add(files(
   'block.c',
-- 
2.26.2



