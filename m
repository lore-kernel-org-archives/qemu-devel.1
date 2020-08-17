Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA534204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sga27fK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA534204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gcv-0008HG-Mp
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHR-000574-5v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHP-0006D1-Di
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id a5so15259423wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCZEu26+ZlByYj6flD+0i+PBWz9jBredaJ3O6s3/97U=;
 b=Sga27fK8he4uy+8BEMxPBiTsSLHid1Dsc92aSCdQTPoDSf4Zvimt0KcWKZO3WdCtzf
 lr12Nq1Q8xMbScersuUJx3svt/srTkV8mQa7FCulvlVmG5sohQINUiedqO9/qheRGmPa
 Rkk1ggSxBpY6b8dgAda+pwFC9nLpoyOOLc95ThC3UKSMYgax3DMBc00mH7ZN8FDez/uR
 2NExttJEbLahMCW1oW80Uzi/M2nTaBZw3vNnmdPu5071JHU7+L9aWRBqTa/skrRe+nlh
 OvNG+jWleZI3tI36I1ZGjzuZAG7TASw2gUcrgDSsbNOsVTG/4GG2OSzNRfrz1J99sWi0
 bO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GCZEu26+ZlByYj6flD+0i+PBWz9jBredaJ3O6s3/97U=;
 b=MA1bcY+r1hRYacNMKZURs+DgLFT46V8Q3hHBFlr0TSsTfPl3XpmnZdum/1P94iEitN
 j3DvM8P2HC1foDur8ArKq6yIxn7eI99VW8iZmdidUknsmSIhftx2/cM3UdSdZJ9S7D6/
 sS0IXjqq7XGagvnobyIAssidNO4E9WjlSWFyNz9YrqiLzlJyOC+jmcYulSPYREmV5XoP
 DWvVLyOe/8xzebX/q4SKZUWY3u2GsKbl2gXHVIr1KFcskQu84yCWIKOVUzr5Y3AkGTZl
 ojHrbuaL1MzLXqW41QZOm0R8ORLFKNgS/VR9OcUByatkKfHh5I3nXWNCAqBSg4lsoqs0
 5IIQ==
X-Gm-Message-State: AOAM532IfJjEv8K35lyFZD+IQTAxug2avg3jXnzFzS0LpljqMbE4nLNO
 kEnzOHGRcu74ZMoPvnYz33STDH80P84=
X-Google-Smtp-Source: ABdhPJxWEL2xpFl0gmkAu8JK8EfGWXvNx8iKjp/TKOQjaOFCL2oQLv+CSnvuyuOVzc4tBuyuP63Yrw==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr17130507wrn.56.1597675108943; 
 Mon, 17 Aug 2020 07:38:28 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 064/150] meson: qemu-{img,io,nbd}
Date: Mon, 17 Aug 2020 16:35:57 +0200
Message-Id: <20200817143723.343284-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
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
 Makefile    |  5 -----
 configure   |  3 +--
 meson.build | 14 ++++++++++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 22247cb376..e2f64b9c8b 100644
--- a/Makefile
+++ b/Makefile
@@ -278,11 +278,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-img.o: qemu-img-cmds.h
-
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
diff --git a/configure b/configure
index bc17695581..961436ea41 100755
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
index e01ff4b119..b8f6cc49fb 100644
--- a/meson.build
+++ b/meson.build
@@ -346,7 +346,7 @@ if have_system
   ]
 endif
 foreach d : hx_headers
-  custom_target(d[1],
+  hxdep += custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -555,7 +555,8 @@ libblock = static_library('block', block_ss.sources(),
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
-                           link_args: '@block.syms')
+                           link_args: '@block.syms',
+                           dependencies: [crypto, io])
 
 foreach m : block_mods + softmmu_mods
   shared_module(m.name(),
@@ -633,6 +634,15 @@ if 'CONFIG_GUEST_AGENT' in config_host
 endif
 
 if have_tools
+  qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+             dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+  qemu_io = executable('qemu-io', files('qemu-io.c'),
+             dependencies: [block, qemuutil], install: true)
+  if host_machine.system() == 'linux' or host_machine.system() == 'sunos' or host_machine.system().endswith('bsd')
+    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+               dependencies: [block, qemuutil], install: true)
+  endif
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-- 
2.26.2



