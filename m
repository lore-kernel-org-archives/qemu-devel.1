Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F56CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8672054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0d2tAZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8672054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gpx-0001Aj-9W
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHR-000576-Bp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHP-0006DF-HG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id a15so15235365wrh.10
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UvepImufTOkKXGEhsXevW6x6eLEJ38fEauCGd02DUaM=;
 b=N0d2tAZgdgTuXVjGWr2e5VxcpoF1FcNHehzxODm5kgsk8YZhFiEuFXF3d7ur3MCVZ8
 SRCMN+xkAGCEhyMOZ95vbkor0YY4vHfx2FmjzYSjoq6zT9c7Hgw6DOiXpvchs2GzutNS
 08DdUPqGxoT5UNkN9SlEKJJtRBUTqoULYyA4LRPDnWmAFAuHFVxfpGWTeNhf6MAzlSvs
 CDTGjm3oIj4yeQJ8nHU6bvBNVpayaKwOAt+FpmWtcLT5kDoSfotD0cJzFusJXNg5G+gv
 t1ujrzvGMsUMk9Pu9xDYSuKuZxZQQSiHHU45VnNjNnxkn5kV60BtV+HpfRtC2+kEQ9x1
 JwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UvepImufTOkKXGEhsXevW6x6eLEJ38fEauCGd02DUaM=;
 b=FbgvjlOFpw5exKz7r3fxvxSznbdiw9KN6+bretBI/yEqm/6jeEA95rLIcqsm7AmSo+
 cahBtq2V+ip0gngdSTn5CPNsABZjsnNstXITEcexbIk3C/CVUTzW4otj/jLY43d6zPwL
 ldKQtSdns5QOUZi7XLY8V9eFOPBVE8rOkJ1XpLg1VEce1B0zcsxjbwMAdzozTBIKVxDl
 ih1dqFsHhodSRh3gDxZYQuKaErZz73+461VcUlH0tVbx199MM4p8BrbjV56CeZHjzpmE
 G7QZU5lcKeQp+gj1xoh18kUv6Hh9ZRaiRgEPgXNFY6/UlhVPOR365rRVlonxtdkb3xCG
 IQXg==
X-Gm-Message-State: AOAM533ZQhDs+UJAK2xaXYcyUryIHX1bdboTfa3fOgL6Fk7mg4dm060o
 tsFBqNgygual10vNJTP+3Lpg+1WWWeo=
X-Google-Smtp-Source: ABdhPJzoKuuL5gTQW5kdxgGwjTTHcwXfKAUUi7uUpTMwDoz3imlikanXtS5JOfRSYwiGpSxSj3iUOw==
X-Received: by 2002:adf:9125:: with SMTP id j34mr17456203wrj.157.1597675109941; 
 Mon, 17 Aug 2020 07:38:29 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 065/150] meson: qemu-pr-helper
Date: Mon, 17 Aug 2020 16:35:58 +0200
Message-Id: <20200817143723.343284-66-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
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
 Makefile    |  7 +------
 configure   |  3 ---
 meson.build | 10 ++++++++++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index e2f64b9c8b..cd8d9a0b02 100644
--- a/Makefile
+++ b/Makefile
@@ -127,7 +127,7 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y = $(HELPERS)
+HELPERS-y =
 
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
@@ -280,11 +280,6 @@ COMMON_LDADDS = libqemuutil.a
 
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
index 961436ea41..0262b7b661 100755
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
index b8f6cc49fb..92f2da51e5 100644
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



