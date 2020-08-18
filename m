Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A57C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8EF2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlixrDm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8EF2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82p8-0006Em-CV
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kv-0004Q6-1H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Ks-0007Sx-6q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfl9wwIwJn47HGlc35S4t8C+71z6QGPOfSyKg2MPp+A=;
 b=WlixrDm4IjDeEeaQt1UjAm9mSWPkX9KDNq/m+s7NhQtGT+HbBwFaDIXlr4TWWlBjDE4LSd
 ypmkzQehkS4ehml1OUn422tYL1ApvabYlxuUXHVp1yWci4ZfE/9ZMeOiF6GjpK8zbhqRat
 CYkf656clVCsUoppYnRXdSluOYT0TfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-CqDstFXbOYGBdJ7YrkXeww-1; Tue, 18 Aug 2020 10:11:29 -0400
X-MC-Unique: CqDstFXbOYGBdJ7YrkXeww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 062961007381
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB07F5D757;
 Tue, 18 Aug 2020 14:11:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 065/150] meson: qemu-{img,io,nbd}
Date: Tue, 18 Aug 2020 10:09:00 -0400
Message-Id: <20200818141025.21608-66-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile    |  5 -----
 configure   |  3 +--
 meson.build | 14 ++++++++++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4abc29cd59..e67fe52ed3 100644
--- a/Makefile
+++ b/Makefile
@@ -280,11 +280,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-img.o: qemu-img-cmds.h
-
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
diff --git a/configure b/configure
index e15e038813..013ee3bda4 100755
--- a/configure
+++ b/configure
@@ -6670,9 +6670,8 @@ fi
 tools=""
 helpers=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
-    tools="qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
+    tools="qemu-storage-daemon\$(EXESUF) $tools"
   fi
 fi
 if test "$softmmu" = yes ; then
diff --git a/meson.build b/meson.build
index 299313beca..a6d4057e0d 100644
--- a/meson.build
+++ b/meson.build
@@ -347,7 +347,7 @@ if have_system
   ]
 endif
 foreach d : hx_headers
-  custom_target(d[1],
+  hxdep += custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -556,7 +556,8 @@ libblock = static_library('block', block_ss.sources(),
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
-                           link_args: '@block.syms')
+                           link_args: '@block.syms',
+                           dependencies: [crypto, io])
 
 foreach m : block_mods + softmmu_mods
   shared_module(m.name(),
@@ -634,6 +635,15 @@ if 'CONFIG_GUEST_AGENT' in config_host
 endif
 
 if have_tools
+  qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+             dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+  qemu_io = executable('qemu-io', files('qemu-io.c'),
+             dependencies: [block, qemuutil], install: true)
+  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
+    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+               dependencies: [block, qemuutil], install: true)
+  endif
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-- 
2.26.2



