Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FDC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D705D20716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3YCxBFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D705D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVWr-0004MG-Vn
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV65-0001BJ-PT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV62-00040n-GW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:19 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV62-0003vr-72
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:18 -0500
Received: by mail-wm1-x32b.google.com with SMTP id s144so2320499wme.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sJfjvf9vIvBvBrGJ9qOxJje3Qx6YncarmbBUcfJN1nM=;
 b=B3YCxBFeUf0jWwuxa+k0P87xNEiXp8V+um/l3dTQblYWCoyFZZJjsJGwPJXLm+nnhw
 LkqJJztsPS6JQW0DWn8Ipuj20O8CGeO80CHoQ+QhqkjlZxjTse6JFMecH13Yb2bJXrjA
 vq8yhOWxvNu9RkC6tNpgDsn9nXDNAbNAdrtHOWb5Yosze969g0M6vISq1ss4bOxBObZZ
 6AnjOt66030KQ3Fc8ml1Y1BnRD7teHUdsYdNW0ChISo8Xj5Hdve+0uc/zY/mFycQZzff
 HchvMPJlAjuxwi6F9PHepLUmmVpQM0yJRsX/yxxfCqFZEAziRkoOyZFrprI2WkmJ5MJ5
 6PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sJfjvf9vIvBvBrGJ9qOxJje3Qx6YncarmbBUcfJN1nM=;
 b=Wvpt5uv3ElSO+6sbcw3cCq6h8yGmoDhavIOI6pZslQ2zu/xXP+346WkSiMWNpLpxK7
 qR1XG1ezhcWtZpJXyvXfNyRsseYENrk7eFz0w16xlziyDDVt/0a+PU77LF0Wo8iZNvCv
 3FkS/Stnhjb+je6JdBH6FI6Xqh2H6DBtAx1xRDzrSfPaV5M7yTQDgkGX9pc9G4CooUq2
 MoAl0OocaKcLgQ7SUR+bAdIYyOmZDh3PzHjr6kYv+3NfbeHmEgsd1p44FCB7ShyAjs+U
 QAijyMdHKesVMwwFgwZSrMEY4p5floQFSb/Zl/NdqwxDYRBsR9zYjZyMErmMkpGmzc9r
 D4ng==
X-Gm-Message-State: APjAAAXw2PHlX3uiZVJ6XGrydOPrXGpGtP1/KG5gUAil82N2E2ULE1I4
 O3pBXGZKxk9KvemlffXHLTARK2zv
X-Google-Smtp-Source: APXvYqyG0aHs2TvdS7psft1r0EsZH+C7IFGSHGRqzb6NQTMLSyN/dFYYHuW0P/n6oGRwTxVAwrbWRQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr5933933wmf.184.1580234176015; 
 Tue, 28 Jan 2020 09:56:16 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 062/142] meson: convert migration directory to Meson
Date: Tue, 28 Jan 2020 18:52:22 +0100
Message-Id: <20200128175342.9066-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Makefile.objs           |  1 -
 meson.build             |  5 +++++
 migration/Makefile.objs | 15 ---------------
 migration/meson.build   | 24 ++++++++++++++++++++++++
 4 files changed, 29 insertions(+), 16 deletions(-)
 delete mode 100644 migration/Makefile.objs
 create mode 100644 migration/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 7b6985b4fb..fc2868f1bf 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -39,7 +39,6 @@ common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
-common-obj-y += migration/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/meson.build b/meson.build
index d72edea6a8..4472d0b311 100644
--- a/meson.build
+++ b/meson.build
@@ -272,6 +272,10 @@ lzo = declare_dependency()
 if 'CONFIG_LZO' in config_host
   lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
 endif
+rdma = declare_dependency()
+if 'CONFIG_RDMA' in config_host
+  rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -600,6 +604,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('migration')
 subdir('monitor')
 subdir('replay')
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
deleted file mode 100644
index a4f3bafd86..0000000000
--- a/migration/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-common-obj-y += migration.o socket.o fd.o exec.o
-common-obj-y += tls.o channel.o savevm.o
-common-obj-y += colo.o colo-failover.o
-common-obj-y += vmstate.o vmstate-types.o page_cache.o
-common-obj-y += qemu-file.o global_state.o
-common-obj-y += qemu-file-channel.o
-common-obj-y += xbzrle.o postcopy-ram.o
-common-obj-y += qjson.o
-common-obj-y += block-dirty-bitmap.o
-
-common-obj-$(CONFIG_RDMA) += rdma.o
-
-common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
-
-rdma.o-libs := $(RDMA_LIBS)
diff --git a/migration/meson.build b/migration/meson.build
new file mode 100644
index 0000000000..ee5a713069
--- /dev/null
+++ b/migration/meson.build
@@ -0,0 +1,24 @@
+softmmu_ss.add(files(
+  'block-dirty-bitmap.c',
+  'channel.c',
+  'colo-failover.c',
+  'colo.c',
+  'exec.c',
+  'fd.c',
+  'global_state.c',
+  'migration.c',
+  'page_cache.c',
+  'postcopy-ram.c',
+  'qemu-file-channel.c',
+  'qemu-file.c',
+  'qjson.c',
+  'savevm.c',
+  'socket.c',
+  'tls.c',
+  'vmstate-types.c',
+  'vmstate.c',
+  'xbzrle.c',
+))
+
+softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
+softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
-- 
2.21.0



