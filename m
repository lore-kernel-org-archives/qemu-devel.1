Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EC7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F46B22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ1GX/VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F46B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOSv-0000kc-Rs
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyg-00040L-8q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyf-0007O7-1y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNye-0007N4-Qu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p17so2376997wmi.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sG12uHUoLcPjHAXyZN9GXqx+8ivdl+v+g5PNNph6V8U=;
 b=HZ1GX/VKefFTz+4rpYXaAuCYWU+509Tzrkz6gcRqLdkQXyWy6S9uTo9s6WZNrXmvOt
 /z+4cOPlGh6BzIRmD6DkPCjwhF4Z6Tvkhhy0yk1lmFcjRNe5Fqrrxu17QrTzENU/t7w3
 1WZvNX7j9okfTs893yQatO8icr3cOchlsEFGu/DleWP75sO9K0QJelPXzMisZOno8TLh
 opdADTrF5j1SiVTLSLEzuKbicAEy/qZCGpry7nDqDXlqpthoRyhC5HK5a6GbaoEALk3Y
 iDHGN1k05uXjGzT9quhW+dOT0ZGu/u9PhIM3OmfjsWTipYDAEuRPAMB6aldaDk4RuVSi
 NsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sG12uHUoLcPjHAXyZN9GXqx+8ivdl+v+g5PNNph6V8U=;
 b=pZtkigXzRd/+1DuEWWYEYbEc2eo34329p3FLvvabnTwWMdxitr0WaZxfhDk8ITzso3
 QFhlbqFHVPm43AK+p8bqcuQqc/Z6KWTCLmUQ4g8hWXyw9UoVceQ0aw2S3S4IP3Dwsp+0
 ccXTzDoODmCkhygEN1XMNSkDNbDGGjkaB8iqLuCpkdcw4xrosycQ7hzUe1fIPX2wzkoa
 ULsXJdMdL6ktPbZ7joTWrkW5kGv58Hp+Sd3J3nlbctlYDTbMW2NBchncfr1oUNJND/8S
 nKbgtNvPpKARTI22Rq0n1vheGGmu2KtKJIeHtiFOUm8l3Ns8W//2UhkcWCY28SkcwnNw
 1nGw==
X-Gm-Message-State: APjAAAViliTbyNxR5TlYKKycJQEB74QjhhH8Vkf09YhLtAdWbIo1L3Z+
 f93hzzxBrNo9xYFI+TClQ8ncobKS
X-Google-Smtp-Source: APXvYqyt41EjOD7beE7OErwtCMlXNLZaJER4jhc8lQneGt43ByYS8ir7bKbjFuVUzjS4BpvEQVFXnA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr6853975wmj.104.1576155235662; 
 Thu, 12 Dec 2019 04:53:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 057/132] meson: build softmmu-specific migration/ram.c
Date: Thu, 12 Dec 2019 13:51:41 +0100
Message-Id: <1576155176-2464-58-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
---
 Makefile.target       | 1 -
 configure             | 2 ++
 meson.build           | 5 +++++
 migration/meson.build | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index 8628e25..cc0c038 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,7 +157,6 @@ obj-y += hw/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
-obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/configure b/configure
index 8e55f3a..fc57ec5 100755
--- a/configure
+++ b/configure
@@ -7250,6 +7250,8 @@ fi
 
 if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
+  echo "LIBPMEM_LIBS=$libpmem_libs" >> $config_host_mak
+  echo "LIBPMEM_CFLAGS=$libpmem_cflags" >> $config_host_mak
 fi
 
 if test "$bochs" = "yes" ; then
diff --git a/meson.build b/meson.build
index 74837ff..2961c44 100644
--- a/meson.build
+++ b/meson.build
@@ -277,6 +277,11 @@ rdma = declare_dependency()
 if 'CONFIG_RDMA' in config_host
   rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
 endif
+libpmem = declare_dependency()
+if 'CONFIG_LIBPMEM' in config_host
+  libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
+                               link_args: config_host['LIBPMEM_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
diff --git a/migration/meson.build b/migration/meson.build
index ee5a713..1231e43 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -22,3 +22,5 @@ softmmu_ss.add(files(
 
 softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
 softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('ram.c'), libpmem])
-- 
1.8.3.1



