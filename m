Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A78C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AAC2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5majDoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AAC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWO6-0002ss-GU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7j-0003Up-LV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7h-0007yB-FY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7h-0007wF-34
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id z7so17071971wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=piG9fnu8CqJWz4rBnn4CXq8uYJkBwt1Za50SBLzi8lQ=;
 b=Z5majDoRYe6nu6RotpelZO/5x5aYLmTmBTy88P3fUvXd5VyS7WGOThv3O10xMpHtdu
 YEu/NMMH1WF3gYPZDFCxwi2vt5jwW2223UD+vQCvkZbJP7z7tl8WuYQ0RJEC3V12WhiV
 DmqL65IWp4zWXvOan5NE8DPrJS832OkjlqPu4ncxluNd09Eto9r85nDkt7b/UIAJ4+SH
 cqL3JpoTsMmRAyNBaYyJK39vEvbEhA+uBOjpxjw9+BKaGYzsd1AtT68F7jwROsQJziAz
 wZnu21fSsRSGybEQ7r+ky3KFeV7+jVmBPbvYlfzyHinl8W3C8Ruab6G8cnO+416K41j9
 LZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=piG9fnu8CqJWz4rBnn4CXq8uYJkBwt1Za50SBLzi8lQ=;
 b=jvFQOfYM+ZV/iFNe1iKzT3Zi/smOYlEoYMCevdGKasY2a9EErlZmc8w2UQ6c0z3Vkz
 dSN2jzcxU5NGp+R9Dlm/tE41FaSkVthLPK4PF0b9N3cKp0KsMoZisTA+ykuAHoIWUmmO
 7ezWhixG/6bzh1aEVSNNDlRF8ibMl/oy0REjb3DQNe8GB/UHDEJsUrdtzZfu6diBGJ+V
 vhm1VwbpB8G+fcoXfXepc/nfGKQ1myES5E645i4bipHOHpPRn9SdjZcJYqbj6tf2I+/j
 tvMNMZaiOmuqv2EqIu4KIuytxT9LZnguwLqsXRcCxXToiSGQTmHGzG198YRvgt2Q3wU1
 BAYg==
X-Gm-Message-State: APjAAAV7nIANJ/KviqM5YdvsHgSBmUVRZQMEMk57jh7LxITeKEihglTm
 v8Mdt7JQ17srvLnC0scDwsOJDnQq
X-Google-Smtp-Source: APXvYqyc8oSE3MjPZvohsC3oZp5RvhWXTwTiWN2LUQsv4HrGLEUPaBMeole1kf5w3R7XQ3AJHCIn1g==
X-Received: by 2002:adf:c145:: with SMTP id w5mr30561116wre.205.1580234279938; 
 Tue, 28 Jan 2020 09:57:59 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 107/142] meson: convert hw/audio
Date: Tue, 28 Jan 2020 18:53:07 +0100
Message-Id: <20200128175342.9066-108-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
---
 hw/Makefile.objs       |  1 -
 hw/audio/Makefile.objs | 18 ------------------
 hw/audio/meson.build   | 14 ++++++++++++++
 hw/meson.build         |  1 +
 4 files changed, 15 insertions(+), 19 deletions(-)
 delete mode 100644 hw/audio/Makefile.objs
 create mode 100644 hw/audio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 0c92a04856..c69c3aa4c5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -2,7 +2,6 @@ ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
 devices-dirs-y += adc/
-devices-dirs-y += audio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
deleted file mode 100644
index 63db383709..0000000000
--- a/hw/audio/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-# Sound
-common-obj-$(CONFIG_SB16) += sb16.o
-common-obj-$(CONFIG_ES1370) += es1370.o
-common-obj-$(CONFIG_AC97) += ac97.o
-common-obj-$(CONFIG_ADLIB) += fmopl.o adlib.o
-common-obj-$(CONFIG_GUS) += gus.o gusemu_hal.o gusemu_mixer.o
-common-obj-$(CONFIG_CS4231A) += cs4231a.o
-common-obj-$(CONFIG_HDA) += intel-hda.o hda-codec.o
-
-common-obj-$(CONFIG_PCSPK) += pcspk.o
-common-obj-$(CONFIG_WM8750) += wm8750.o
-common-obj-$(CONFIG_PL041) += pl041.o lm4549.o
-
-common-obj-$(CONFIG_CS4231) += cs4231.o
-common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
-
-common-obj-y += soundhw.o
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
new file mode 100644
index 0000000000..549e9a0396
--- /dev/null
+++ b/hw/audio/meson.build
@@ -0,0 +1,14 @@
+softmmu_ss.add(files('soundhw.c'))
+softmmu_ss.add(when: 'CONFIG_AC97', if_true: files('ac97.c'))
+softmmu_ss.add(when: 'CONFIG_ADLIB', if_true: files('fmopl.c', 'adlib.c'))
+softmmu_ss.add(when: 'CONFIG_CS4231', if_true: files('cs4231.c'))
+softmmu_ss.add(when: 'CONFIG_CS4231A', if_true: files('cs4231a.c'))
+softmmu_ss.add(when: 'CONFIG_ES1370', if_true: files('es1370.c'))
+softmmu_ss.add(when: 'CONFIG_GUS', if_true: files('gus.c', 'gusemu_hal.c', 'gusemu_mixer.c'))
+softmmu_ss.add(when: 'CONFIG_HDA', if_true: files('intel-hda.c', 'hda-codec.c'))
+softmmu_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('marvell_88w8618.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-ac97.c'))
+softmmu_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
+softmmu_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
+softmmu_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
+softmmu_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
diff --git a/hw/meson.build b/hw/meson.build
index f968aa8374..624335be90 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('audio')
 subdir('block')
 subdir('char')
 subdir('core')
-- 
2.21.0



