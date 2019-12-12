Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B37C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DBE214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6piUDOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DBE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifObl-0003w3-4B
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyf-0003yo-3v
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyd-0007MT-Uf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:56 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyd-0007Ks-N8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b11so2237149wmj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YWa94VRNvdkdV9UdlmRb+gJmNrhRT3sbXNM7zUaP/FU=;
 b=j6piUDOqLjGdHp4Xhcmj14a2xCargHShx2VwH6unqHPVICKce5ovHw/yMZLaZmoy6L
 cVvbXiN5B6PQbpukz7T7fuQWLDiSi7rJ1vEXl7q9zIX4APZZbYryZFoJg3AzQ0iPyiRj
 pKp7ocQLqaysl+PR0HL4Sr1NRQsHcx+5YlJas0UwR1ZfGRBY2Ogqi/YX+wjj+O+aFCVC
 3rMRYBn9v4ibjXvULh/o+h3Ktlaj/YnkO5/je9k7bJ3P0R9v9glS8DGgWtuXREW5TEEo
 NQE5NeYryce2FDANNJDJrkBnm5/37aC/qfjW/tEDnUjyxucxs69DmTSp0MSar/QPEKjr
 4whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YWa94VRNvdkdV9UdlmRb+gJmNrhRT3sbXNM7zUaP/FU=;
 b=OWQEXU8h8ylMFce8c1XxshCsAsOGIdIPvrBo4uAwEqBw1LmoD65RIf12pv5AWZfdM5
 TAKUVc9CEd5LltzVPp5A6+PHULnyCDyCEQlV2I8xmEA0t9SmqUWZzjFW/SGFIHqTfln9
 DRWihbQXEV5sojmcwvxLScT33v1ZgxP/nkLTO3rILlFsKk7L3Fyyb+/AhDJnEso8LXou
 nnm0+fB+XxeBKytEKDF+0i+8YocKrTf89M7Ctsw4NG/EHISXHQt4D4CVJpT2ZWYfGd7w
 ry7dHopEe2+Hd25JVnHoj/72gwjrinOygFILxm3bgN+cBiDFOey4yZ3KQvHj8limYfJF
 QB2g==
X-Gm-Message-State: APjAAAXV7FBqRT6UtQ894pOEBjthLZe8sKyS1xw3pAEprA1eV6lQcrZ4
 Ywl2DTbSNEEf3f7bxegdDXg1oFxJ
X-Google-Smtp-Source: APXvYqxAUrFE/Shxp2LqEb1SvfH8WovIAD0aSQOcjbNBaL6nn3uqsCf4SJJc3unJYdudViYb8AePFA==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr6460054wmi.104.1576155234571; 
 Thu, 12 Dec 2019 04:53:54 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 056/132] meson: convert migration directory to Meson
Date: Thu, 12 Dec 2019 13:51:40 +0100
Message-Id: <1576155176-2464-57-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 Makefile.objs           |  1 -
 meson.build             |  5 +++++
 migration/Makefile.objs | 15 ---------------
 migration/meson.build   | 24 ++++++++++++++++++++++++
 4 files changed, 29 insertions(+), 16 deletions(-)
 delete mode 100644 migration/Makefile.objs
 create mode 100644 migration/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 542d8e8..5f2a644 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -37,7 +37,6 @@ qom-obj-y = qom/libqom.fa
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
-common-obj-y += migration/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/meson.build b/meson.build
index 29c68cd..74837ff 100644
--- a/meson.build
+++ b/meson.build
@@ -273,6 +273,10 @@ lzo = declare_dependency()
 if 'CONFIG_LZO' in config_host
   lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
 endif
+rdma = declare_dependency()
+if 'CONFIG_RDMA' in config_host
+  rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -590,6 +594,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('migration')
 subdir('monitor')
 subdir('replay')
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
deleted file mode 100644
index a4f3baf..0000000
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
index 0000000..ee5a713
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
1.8.3.1



