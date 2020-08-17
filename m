Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD6DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B4F205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxxoLB7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B4F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gpa-0000aR-8B
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHh-0005a7-Qf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHg-0006H4-2E
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id 3so14106729wmi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8fIsegobaRhgd+yQyDQqInGxwcNnUvqAp6ZKG3liY6M=;
 b=SxxoLB7ikf/4CsiMiupXqRWsTmURTFECIxC+jCiN9M9KAEIxgsyjUkrspUcccLj/8G
 RBk9UBeWvk76YppOiIDEQ9kCYeDNDB4ZkMrqMxTWh2JrcvMem6DQviaAYgiW+JLVM8u2
 cBn+Ft7Z4kECd0B5KazsGtIXmEqLOewy5Ac3Aw7CETA4g4npNvHs3XOvXHvAFMmGp4AJ
 kFwjfEp52vr3qISDfdPu31Pqm9UrVzwGihRyFNTyF8oQ5HVj9j8qZVBcSV1yE1kWudz3
 tfG7G5qRQjho3ehroWEX8aQpa4OeXhHfgm8vtC7cSGrrmNQ7v6rCTX5hcMya8db8GEqz
 BONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8fIsegobaRhgd+yQyDQqInGxwcNnUvqAp6ZKG3liY6M=;
 b=iRvRUwRQYZ4fR0iDGYhJrRdlo3VfuKb7NyQa6CqrOyIAA/l8y9oMQkyDYiO538qsMP
 s5xg9GCoUze9ITSmp2hQTjLtZI+ajaQpekx6zbIEM/g+VaECT9SDCnk4y5mpH3cEj6eV
 CM2oLeMjwL4bshK2+ZQQGNGg85dgmGqkRygaXW1IPLDzbegQSFTdPn9yurCL6spXVq30
 2S+vnyiOg1Zt9Cz+WztfN271WFUSCWtyl9M3Oua/Ql9mwETzPQTbyjxb8ul5YrOFUubt
 OLJfzw5xlwAiJ15F5eOs0rx2H2NFAuWlO2Gg7bfujspaH/SgkI5svwWHAn2yWERJHEVm
 +qWw==
X-Gm-Message-State: AOAM532m37USvofVIpNaM+y3fMeGV7XwbnAc+Ad5/dk+8U2dXqv4MOri
 YIJSYDobfBj325XUpM+3DSzg7aq11H0=
X-Google-Smtp-Source: ABdhPJy20eQ79QvWxy9G5xAyh2cKIvEq+kpmgcPyuGm8Kom9D/RGXiNauYk+8eEc3CBmpgWHqAL2Qg==
X-Received: by 2002:a1c:bd04:: with SMTP id n4mr15737872wmf.83.1597675126474; 
 Mon, 17 Aug 2020 07:38:46 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 081/150] meson: convert fsdev/
Date: Mon, 17 Aug 2020 16:36:14 +0200
Message-Id: <20200817143723.343284-82-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x330.google.com
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
 Makefile.objs       |  4 +---
 configure           |  1 -
 fsdev/Makefile.objs | 12 ------------
 fsdev/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 16 deletions(-)
 delete mode 100644 fsdev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index c00851a0cd..7158031c0c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -39,9 +39,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-$(CONFIG_LINUX) = fsdev/
-
-common-obj-y += accel/
+common-obj-y = accel/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/configure b/configure
index ad58d67863..b037d175ea 100755
--- a/configure
+++ b/configure
@@ -3702,7 +3702,6 @@ int main(void)
 EOF
   if compile_prog "" "$cap_libs" ; then
     cap_ng=yes
-    libs_tools="$cap_libs $libs_tools"
   else
     if test "$cap_ng" = "yes" ; then
       feature_not_found "cap_ng" "Install libcap-ng devel"
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
deleted file mode 100644
index 42cd70c367..0000000000
--- a/fsdev/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-# Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
-# only pull in the actual 9p backend if we also enabled virtio or xen.
-ifeq ($(CONFIG_FSDEV_9P),y)
-common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y = qemu-fsdev-dummy.o
-endif
-common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
-
-# Toplevel always builds this; targets without virtio will put it in
-# common-obj-y
-common-obj-$(CONFIG_ALL) += qemu-fsdev-dummy.o
diff --git a/fsdev/meson.build b/fsdev/meson.build
index 30e2319960..7dd1cc9bfb 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -1,3 +1,13 @@
+fsdev_ss = ss.source_set()
+fsdev_ss.add(files('qemu-fsdev-opts.c', 'qemu-fsdev-throttle.c'))
+fsdev_ss.add(when: 'CONFIG_ALL', if_true: files('qemu-fsdev-dummy.c'))
+fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
+  '9p-iov-marshal.c',
+  '9p-marshal.c',
+  'qemu-fsdev.c',
+), if_false: files('qemu-fsdev-dummy.c'))
+softmmu_ss.add_all(when: 'CONFIG_LINUX', if_true: fsdev_ss)
+
 have_virtfs_proxy_helper = have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
 if have_virtfs_proxy_helper
   executable('virtfs-proxy-helper',
-- 
2.26.2



