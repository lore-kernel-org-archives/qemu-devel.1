Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8584DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF392077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYibp1iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF392077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO3d-0001O5-Be
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxy-0002rQ-4P
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxw-0005wF-U1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxw-0005uW-MY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:12 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so2643568wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=/vMZP16atX8dkxZHpqjBZSlvs6YBh8+nwakOK3x617U=;
 b=rYibp1iqvle/0P6GazFC+nz8t6Xn2R3s1XRO307rAUiI1MHRI9oJa6HflmzHZaq6ED
 K/MGs9lgst4DHhC+rMIR7ZbXt9F0hnJ7PocdWGf5AHmOIRT0/0OZ/ybRPe39f2v7oDRn
 zZ3x4CVPw7DNX6rftX1EIvcLTapYlPaOpUKh+5zSYMQYlEOnAoxOM8BudIKoRVTklGk4
 1KnRwiYgBou+xHsuKvV2I5uz0qPfHIKUElNQurL6MUkYsOYWb6Me7JTAn4PsOATCDfgp
 NGvQtEHii88JwSOvN/R7JC5tRPOaD//v8o7EBhvw0e504DJxaZzIpei6ZLM7iR1UM79F
 7wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=/vMZP16atX8dkxZHpqjBZSlvs6YBh8+nwakOK3x617U=;
 b=HWD0j/CBB4C2U2j3Mfyf0jY2d89SVSeYlJV/MplH5n91h26EZ/8uOsydVu6Zw+IWh7
 oAGHizJzlu7RWgYmbmtkXwGzKGXRhO5YcygN4/IF1P19x6ohSsTtf1FyEhrisVu8gJPn
 UsaVQb/P32Wgh8fkb2sBKv4MSYsV4Rn7yOKimEVS6mAwWHN6lRCU7EmIa/y57S5AwDCR
 EDGClvTlzbMcZQrkUYKfXbGoGBqZGPZAOlGJsHgxS7rwbW2lIOSlZHSMiUDjFuRjbVbe
 9P6MC7Gv8u91vmxRGHcAPTOcHPrtWBbIf9i3Fb4h+7quU9gif+93MoDGOpfS0dHc9vD0
 x26A==
X-Gm-Message-State: APjAAAUPXtZBt/aB09f15i+mXpIATrK7pq3hm+Xbpb4LlVQc5e8hcrCl
 r6OoEqUxkYHixBCWbNOKRQJmMomG
X-Google-Smtp-Source: APXvYqzOjRJGFXsUMcY4UqsB3UlMixnoMbb4Pe4HHkK1cIG5wvOo5yzE04ocdIaF5/muXv2Fq8L+ag==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr6062128wrx.393.1576155191152; 
 Thu, 12 Dec 2019 04:53:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 013/132] contrib/vhost-user-blk: convert to Meson
Date: Thu, 12 Dec 2019 13:50:57 +0100
Message-Id: <1576155176-2464-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

The GLib pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                           | 3 ---
 Makefile.objs                      | 1 -
 contrib/vhost-user-blk/meson.build | 3 +++
 meson.build                        | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 contrib/vhost-user-blk/meson.build

diff --git a/Makefile b/Makefile
index 27e9ea3..f15c097 100644
--- a/Makefile
+++ b/Makefile
@@ -268,7 +268,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
-                vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -467,8 +466,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 3142dbb..ba422dd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -112,7 +112,6 @@ ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
-vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
new file mode 100644
index 0000000..3856a9a
--- /dev/null
+++ b/contrib/vhost-user-blk/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-blk', files('vhost-user-blk.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil)
diff --git a/meson.build b/meson.build
index 6b9636d..4f2fc33 100644
--- a/meson.build
+++ b/meson.build
@@ -191,5 +191,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
+    subdir('contrib/vhost-user-blk')
   endif
 endif
-- 
1.8.3.1



