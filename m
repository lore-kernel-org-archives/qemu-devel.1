Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2AB206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdGKM/ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2AB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WLk-0005s3-Q6
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vn6-0006Fr-JY
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51808
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vn1-0002yp-Il
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifq9ujheXgzOEHwO3UkzWysUaXjM6+X4zOLflsirKZg=;
 b=MdGKM/ZEDDDVYT2hVA26GWBgi6ZfCYbB76iumzqZZLZQZGB3EKxXVdgkTYvuW/+974pszW
 YAkNOFKks0HtxWPw2HWx2vq99DAIsE/MtmLgas7I4dbQw41Ndbv0dTsw4B9TOn6fIrkCTu
 RJCPjylnuc2iTBcD23OA1EZp6/Ku/58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-DMk73MxKPfqnlrsRfdt4pg-1; Fri, 14 Aug 2020 05:14:16 -0400
X-MC-Unique: DMk73MxKPfqnlrsRfdt4pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E31B81853DAD
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 950055D9D2;
 Fri, 14 Aug 2020 09:14:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 066/150] meson: qemu-pr-helper
Date: Fri, 14 Aug 2020 05:12:02 -0400
Message-Id: <20200814091326.16173-67-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile    |  7 +------
 configure   |  3 ---
 meson.build | 10 ++++++++++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index e67fe52ed3..414c631aee 100644
--- a/Makefile
+++ b/Makefile
@@ -129,7 +129,7 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y = $(HELPERS)
+HELPERS-y =
 
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
@@ -282,11 +282,6 @@ COMMON_LDADDS = libqemuutil.a
 
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-ifdef CONFIG_MPATH
-scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
-endif
-
 clean: recurse-clean ninja-clean clean-ctlist
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
 # avoid old build problems by removing potentially incorrect old files
diff --git a/configure b/configure
index cc5a44d7e0..1dd0c693f3 100755
--- a/configure
+++ b/configure
@@ -6668,7 +6668,6 @@ if [ "$eventfd" = "yes" ]; then
 fi
 
 tools=""
-helpers=""
 if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-storage-daemon\$(EXESUF) $tools"
@@ -6692,7 +6691,6 @@ if test "$softmmu" = yes ; then
       fi
       mpath=no
     fi
-    helpers="$helpers scsi/qemu-pr-helper\$(EXESUF)"
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
@@ -7770,7 +7768,6 @@ else
   QEMU_INCLUDES="-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"
 fi
 
-echo "HELPERS=$helpers" >> $config_host_mak
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
diff --git a/meson.build b/meson.build
index f19b18077c..8aff811b9b 100644
--- a/meson.build
+++ b/meson.build
@@ -144,6 +144,10 @@ if 'CONFIG_XKBCOMMON' in config_host
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
 rt = cc.find_library('rt', required: false)
+libmpathpersist = not_found
+if config_host.has_key('CONFIG_MPATH')
+  libmpathpersist = cc.find_library('mpathpersist')
+endif
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -629,6 +633,7 @@ foreach target : target_dirs
 endforeach
 
 # Other build targets
+
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -670,6 +675,11 @@ if have_tools
                dependencies: [qemuutil, libcap_ng],
                install: true,
                install_dir: get_option('libexecdir'))
+
+    executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
+               dependencies: [authz, crypto, io, qom, qemuutil,
+                              libcap_ng, libudev, libmpathpersist],
+               install: true)
   endif
 
   if 'CONFIG_IVSHMEM' in config_host
-- 
2.26.2



