Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EEBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFA9214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy6wLx+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFA9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOXW-0007hR-3u
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyi-00043c-9x
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyg-0007Rr-Vw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyg-0007QP-Oh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id b6so2660949wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KOERxOLlOz1AOeLYqss79EJLgVTJV4U6Tu8Gg25M3E4=;
 b=Hy6wLx+tjYJpuBvO/g9dNVOX6kF6HJe66OxWa7TP8iTI3XZSAEZ8URNlR4HwkbYkgX
 pmjUeOBsJ0q+ay8yKf1AjrDn8JGuYacjxR7oObIaLczNPHkQfH+YB1TunO7/YxzyLyad
 wwzuhcWU/STO6halcfMhwr1wjnO2un1aDVX9Oj+WOxcrATfkPA9oLLOg+ngUnqZTiGq/
 aA3yQQAIrBw5tuj0qQP528RQI2LfpTsqeHg+oEo+pWXCjwQYNhkWCONP52ehkUyxEFCx
 sJgGbXUy9Gq8n87aQPiSLGrsh30icCIr3DFtkGOafU6dnH0h8flvJDMxtxAZQJTleUC4
 Sn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KOERxOLlOz1AOeLYqss79EJLgVTJV4U6Tu8Gg25M3E4=;
 b=Jd20g0YtU6OP1gGfhfacHj4iOcX5VRgnKBSCxzbZ+IHvoweiWc2aqMSAwfJqUPmwEK
 SLPxMHC4hd5kKn4AcjZTmIBdKtL60SgSlhw4OPGy/kwl/vj1MolDPPN/M9P2lsifXJfu
 4oSLHwr/ONQpgeIDTfWP5DhYWpTkIhsZP87tL9qDMQbd8ts8TFSEU496AERAnoQl5LeU
 HlTfoWEOtWFGgjTvP1n68W+7WB5Sxhl5d0DodTmrOLRpcDYUQJflRXEEQQpWwC0uzBgF
 bbhlNPi/dLLzDRZcIh1una3y33G0K+7jRE9UM6pPxCC8WxxL6ENerTdaXfntpDYueZ7/
 Pk4g==
X-Gm-Message-State: APjAAAWoPGr4crOFACGSS0MIIl6qmOdFeW1Nu0XAgGMx8LF3JlSSKbSM
 CI8WlHWdHd+JvsTvXMQEVMPWOfP8
X-Google-Smtp-Source: APXvYqwJ3WKvj6oNFzEB7UkJaeqFuUWT/bF+Fdj5RIQXU3BEWL8rQ2UYBccJ2euwk1BlU9iSI2PSwg==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr6191345wrr.116.1576155237601; 
 Thu, 12 Dec 2019 04:53:57 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 059/132] meson: convert backends directory to Meson
Date: Thu, 12 Dec 2019 13:51:43 +0100
Message-Id: <1576155176-2464-60-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs          |  1 -
 backends/Makefile.objs | 19 -------------------
 backends/meson.build   | 16 ++++++++++++++++
 configure              |  2 ++
 meson.build            |  5 +++++
 5 files changed, 23 insertions(+), 20 deletions(-)
 delete mode 100644 backends/Makefile.objs
 create mode 100644 backends/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index e316e96..12d0a78 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -58,7 +58,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-common-obj-y += backends/
 endif
 
 #######################################################################
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
deleted file mode 100644
index 981e8e1..0000000
--- a/backends/Makefile.objs
+++ /dev/null
@@ -1,19 +0,0 @@
-common-obj-y += rng.o rng-egd.o
-common-obj-$(CONFIG_POSIX) += rng-random.o
-
-common-obj-$(CONFIG_TPM) += tpm.o
-
-common-obj-y += hostmem.o hostmem-ram.o
-common-obj-$(CONFIG_POSIX) += hostmem-file.o
-
-common-obj-y += cryptodev.o
-common-obj-y += cryptodev-builtin.o
-
-ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
-common-obj-y += cryptodev-vhost.o
-common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
-endif
-
-common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) += vhost-user.o
-
-common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
diff --git a/backends/meson.build b/backends/meson.build
new file mode 100644
index 0000000..b47864f
--- /dev/null
+++ b/backends/meson.build
@@ -0,0 +1,16 @@
+softmmu_ss.add([files(
+  'cryptodev-builtin.c',
+  'cryptodev.c',
+  'hostmem-ram.c',
+  'hostmem.c',
+  'rng-egd.c',
+  'rng.c',
+), numa])
+
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('rng-random.c'))
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('hostmem-file.c'))
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('hostmem-memfd.c'))
+softmmu_ss.add(when: ['CONFIG_VHOST_USER', 'CONFIG_VIRTIO'], if_true: files('vhost-user.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+softmmu_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VHOST_CRYPTO'], if_true: files('cryptodev-vhost-user.c'))
diff --git a/configure b/configure
index fc57ec5..28746c1 100755
--- a/configure
+++ b/configure
@@ -4317,6 +4317,7 @@ EOF
   if compile_prog "" "-lnuma" ; then
     numa=yes
     libs_softmmu="-lnuma $libs_softmmu"
+    numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
       feature_not_found "numa" "install numactl devel"
@@ -7798,6 +7799,7 @@ fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
+  echo "NUMA_LIBS=$numa_libs" >> $config_host_mak
 fi
 
 if test "$ccache_cpp2" = "yes"; then
diff --git a/meson.build b/meson.build
index 2333a87..94bc696 100644
--- a/meson.build
+++ b/meson.build
@@ -291,6 +291,10 @@ if 'CONFIG_LIBPMEM' in config_host
   libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
                                link_args: config_host['LIBPMEM_LIBS'].split())
 endif
+numa = declare_dependency()
+if 'CONFIG_NUMA' in config_host
+  numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -608,6 +612,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('backends')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
1.8.3.1



