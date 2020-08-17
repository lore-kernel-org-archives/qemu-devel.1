Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E761C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4829F205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0d6Jrk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gah-00036L-HN
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH8-0004SK-9X
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH6-0006AC-JP
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id z18so15242015wrm.12
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i6Q1BtQ7dt7i4vV9/lhWTeE6ygoU1bX5vJNmganoOBk=;
 b=f0d6Jrk7Xjv8TqV88uvjOGvaZbR+82AfdBMMABrf4KcIAKGcVw3y5BJdjsgaPfz7zB
 XNfas1gYDcQpYYbmRfxJR8WkNewjRvJhkhHbhkVYJjzf0sWkSyJA1mWXVm7hw+bcnWAZ
 snvtAEJMWVhBsE9NE1cvtWk5m1Ahiacb6kyvUtoPpvhbpitSoaFUBNQAFIbe166NLgVS
 yDYwMPTUv/SMOYSzx5lAbB/iQUErTAKNsSebpeALLg4WrGQykshbVrXSWiV64KeYdA9W
 9yDPidREYap3LVRaFY6ORw78Y30uKILVL8zXpXl/IyJr/8QPaPORujTtPADBVx0ngojR
 so7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i6Q1BtQ7dt7i4vV9/lhWTeE6ygoU1bX5vJNmganoOBk=;
 b=icBQEkhhxwErFnNlOeQhGWS7WqrYuvYM96j884cZcZvJIH3w4C+MchtqEDihzM4p2h
 w5Z2PsIcJFSYOrJjipKtmk8Y+gdoREnd25X4ANqK9ggdnTaFvqXsEgKWm7jX0FJl3R/X
 cS1fdSzv21PgcPMqFYl+GVxc0egFWO6niuQsnADY38EwhGdXeuMSuvUmGXe963TuJeWx
 ediWzAtv/d6l2oR9WDFOdCKhl569/Rjff2rKhwF37MJj4nACGSxC1Ss6XPm+bcq0wLqe
 Xrvzuylym6i4uNaDZtsd+vsSe3MRtvJlaAmLnTDqyBx6pW7W1QPxTchuD2APJDxvpCj9
 qB0Q==
X-Gm-Message-State: AOAM533xdJbw2WIrqMu7dhFK9GU7+cJdpjypcEOcn3/YpNYPKDcVODZl
 ahjzZBWWzmoQKceE9p+g5rd8gCI62Bs=
X-Google-Smtp-Source: ABdhPJx6J0dHXpQ9cZKq6xiJLkeNlU4J8LAAJNzhFffaDurn16llkHKiApHEenpgy8Lu7OaDQ+Rf8w==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr15502873wrq.422.1597675091004; 
 Mon, 17 Aug 2020 07:38:11 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 046/150] meson: add virtfs-proxy-helper
Date: Mon, 17 Aug 2020 16:35:39 +0200
Message-Id: <20200817143723.343284-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x430.google.com
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
 Makefile          | 2 --
 configure         | 7 +++++--
 fsdev/meson.build | 8 ++++++++
 meson.build       | 6 ++++++
 4 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 fsdev/meson.build

diff --git a/Makefile b/Makefile
index 35ea574503..2cd3f5862d 100644
--- a/Makefile
+++ b/Makefile
@@ -418,8 +418,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
-
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
diff --git a/configure b/configure
index 2b55fba922..642f2a8f88 100755
--- a/configure
+++ b/configure
@@ -4339,6 +4339,7 @@ fi
 ##########################################
 # attr probe
 
+libattr_libs=
 if test "$attr" != "no" ; then
   cat > $TMPC <<EOF
 #include <stdio.h>
@@ -4355,7 +4356,8 @@ EOF
   # Older distros have <attr/xattr.h>, and need -lattr:
   elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
     attr=yes
-    LIBS="-lattr $LIBS"
+    libattr_libs="-lattr"
+    LIBS="$libattr_libs $LIBS"
     libattr=yes
   else
     if test "$attr" = "yes" ; then
@@ -6667,6 +6669,7 @@ if [ "$eventfd" = "yes" ]; then
 fi
 
 tools=""
+helpers=""
 if test "$want_tools" = "yes" ; then
   tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
@@ -6677,7 +6680,6 @@ if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
       virtfs=yes
-      helpers="$helpers fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
         error_exit "VirtFS requires libcap-ng devel and libattr devel"
@@ -7259,6 +7261,7 @@ if test "$linux_io_uring" = "yes" ; then
 fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
+  echo "LIBATTR_LIBS=$libattr_libs" >> $config_host_mak
 fi
 if test "$libattr" = "yes" ; then
   echo "CONFIG_LIBATTR=y" >> $config_host_mak
diff --git a/fsdev/meson.build b/fsdev/meson.build
new file mode 100644
index 0000000000..30e2319960
--- /dev/null
+++ b/fsdev/meson.build
@@ -0,0 +1,8 @@
+have_virtfs_proxy_helper = have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
+if have_virtfs_proxy_helper
+  executable('virtfs-proxy-helper',
+             files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
+             dependencies: [qemuutil, libattr, libcap_ng],
+             install: true,
+             install_dir: get_option('libexecdir'))
+endif
diff --git a/meson.build b/meson.build
index d336812c2a..8319d03730 100644
--- a/meson.build
+++ b/meson.build
@@ -98,6 +98,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+libattr = not_found
+if 'CONFIG_ATTR' in config_host
+  libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
+endif
 seccomp = not_found
 if 'CONFIG_SECCOMP' in config_host
   seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
@@ -297,6 +301,8 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('fsdev')
+
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
-- 
2.26.2



