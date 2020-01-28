Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F51C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE99620716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp9Y+UpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVZa-00084P-4s
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4n-0007XA-Ut
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4l-000121-LP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4l-00010d-EU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id f129so3577052wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UsuPxgPVJIh9FtR830VABN8hknsWVe9jdzcI2a69WiI=;
 b=bp9Y+UpD2A8bzd26f5wCb2FCR6rXE5LSwi39EVbqjx+bNylAX6e/9qCS9Q4al9sxQz
 NO+TayutpzSIPJ1zpqBKkTCD7WOMQlacq8RV+XXUJpyCZJICuhmDInfkwJ1rXSi19emp
 c2V2HYzjMOQilKJ8PqD3qDg1H4TmaCsnkLqWzp+ws78ZLI5oN1iUj+EgDKS/C58usPM3
 eNDJNh7MDxkkekk5AxeMaTztVsuSW+/N0szlb3V27j/5HXPiA/eAZ95tuI+kjPC/Tu7J
 dynRaUAKjD4ttYZDRzowQQH/Lls/ucsis1naBNmQYifsQQXGm9rk+nNoiXVxyIXKkGHX
 Wurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UsuPxgPVJIh9FtR830VABN8hknsWVe9jdzcI2a69WiI=;
 b=sxQHFd3VK2chaopBhZYAv4mP8i22orzEqVEauiNJEfTVkoH1WYaT1T+t2YFGnZzNsa
 PutaxpYaPxP2qw54u75jxrhBjbgCOQ+dH3qcck6X7K3MmnOtWvb9HkE6IZk+T1paxp40
 4pg0egyIowDoJGa78CWVuVR9EC/7MU72BGFmTfleJfGOpvuXRJY3i3I/ndMvp9Cbvwpb
 ZLXkPhQ+pbAIe2bQVv2iOJMzY4JsWCdsEBPzd9d7HCdeVt7nIbZKoFSwcqJffMdCfT4V
 ahs6GiZFa14qC27Q1MAMZAgS6rqyO1OIA74tHeXJVTZInhjpWukKzjx2bOylXofixEmz
 uTcg==
X-Gm-Message-State: APjAAAUinuhqHAyDgRhNEMVjtcyOKk7UCnbZO9cyi7JOrCwWt+F28oBv
 bateM3kOHBsNK5oeqoQsKxC+KShX
X-Google-Smtp-Source: APXvYqxSHrLkjoP3xsNeV5y+KdpYgHd+fTM4eDCrj7h0QaPuEbL9Hq1lYlDQ1Evn49fz3GHAWQeq8g==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr6236819wmd.69.1580234098290; 
 Tue, 28 Jan 2020 09:54:58 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 029/142] meson: add qemu-keymap
Date: Tue, 28 Jan 2020 18:51:49 +0100
Message-Id: <20200128175342.9066-30-pbonzini@redhat.com>
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
 Makefile    |  5 -----
 configure   |  4 +---
 meson.build | 10 ++++++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 69105cdfac..ae9f1157d8 100644
--- a/Makefile
+++ b/Makefile
@@ -401,8 +401,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
-
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
@@ -415,9 +413,6 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
-qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/configure b/configure
index 5a78782c25..0b8b31aedb 100755
--- a/configure
+++ b/configure
@@ -6237,9 +6237,6 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-  if test "$xkbcommon" = "yes"; then
-    tools="qemu-keymap\$(EXESUF) $tools"
-  fi
 fi
 
 # Probe for guest agent support/options
@@ -6792,6 +6789,7 @@ if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
 if test "$xkbcommon" = "yes" ; then
+  echo "CONFIG_XKBCOMMON=y" >> $config_host_mak
   echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
   echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 79919df761..b8707f25d2 100644
--- a/meson.build
+++ b/meson.build
@@ -60,6 +60,11 @@ libcap_ng = declare_dependency()
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+xkbcommon = declare_dependency()
+if 'CONFIG_XKBCOMMON' in config_host
+  xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
+                                 link_args: config_host['XKBCOMMON_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
@@ -240,6 +245,11 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
+  if 'CONFIG_XKBCOMMON' in config_host
+    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+               dependencies: [qemuutil, xkbcommon], install: true)
+  endif
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.21.0



