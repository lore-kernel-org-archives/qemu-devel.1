Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08863C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919D124681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msn0uEf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919D124681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWAt-0005Zq-JY
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7y-00044u-Hi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7w-0008RW-O2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7w-0008La-Dy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:16 -0500
Received: by mail-wm1-x331.google.com with SMTP id s144so2324240wme.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xOLcc7vySa6212sQson5/jRLaAfT4+4UeV400SoBqZE=;
 b=Msn0uEf9jmw1bBKNGOB+whouMj925Aq/OSwqLcfd95yayO5PehfrpgqXMdgGXF90ff
 y+I/IMWw+q1jtdO1NMzGzVOyVs+o+6TrTNs7zK4YI4rem6El/g4NkJcNdu6tBq3PFZgK
 kOhXL9wrjPEErTT+6GCknEbc/+scsmkNckqFbmd6lum3YKB0iMfKyK8+c1plvFySyJZN
 PlkzygzjfIAUfs9GCfD6EmLPS2JVqJsCsQEDlQTkLZkB+lVv17tMmkZRjd7DcbLvabLh
 bhsVfKRJDgQX4Ax2ylHz7EqrKflMOC7vGm4+Ea9mVRCpL3ytbMnEWscXZShr3h34o8Wu
 do7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xOLcc7vySa6212sQson5/jRLaAfT4+4UeV400SoBqZE=;
 b=CqrnHN9hI7fuQyQOBRiGPbuu5d3VDlyf/5BVwJcm0CHYP/3NlPQ9YQOxU4XyM/Tb95
 j895MZqVA0yq07IIQ9MIw6AfRsGqYK8eCdv7HU29d8lHQoEoMgUpaiiIAv7n99puNzXF
 1bJOZe5rKrqV3R0yh5aY7qFuFIpST5C2O+25Ngd8yK4wMnJauGxIRplPJO48a0msyFPk
 AAgF0U2zFUspN4Y9p58X6GHqbCYwP8REjjFsmPaWTjU2ZUil9HPZbneTxyFm4ASKPzmy
 4R2GyfIWVkcWaiz+ZFIEY6CROQj05613D19rgqB46OCrlauoZWecMd0ok1zEez/cZfS1
 awPQ==
X-Gm-Message-State: APjAAAU5SM5rbuOQj6xFUPTDdJ7jZqxjTSgWxYUzd7DPRq/kJRksjztv
 visfUgXBLAL+vblIvzdPF6Zdtk+y
X-Google-Smtp-Source: APXvYqzPcSTXdn+A2YhUxDoYUF+jwXOkiCPX8I2AaRZfsvTkB0Kv4lgvmZMTt45KtUVtSMr+YzJ4uw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6365689wmj.170.1580234294264; 
 Tue, 28 Jan 2020 09:58:14 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 113/142] meson: accel
Date: Tue, 28 Jan 2020 18:53:13 +0100
Message-Id: <20200128175342.9066-114-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 Makefile.objs             |  2 --
 Makefile.target           |  1 -
 accel/Makefile.objs       |  5 -----
 accel/kvm/Makefile.objs   |  2 --
 accel/kvm/meson.build     |  5 +++++
 accel/meson.build         |  6 ++++++
 accel/stubs/Makefile.objs |  5 -----
 accel/stubs/meson.build   |  5 +++++
 accel/tcg/Makefile.objs   |  9 ---------
 accel/tcg/meson.build     | 15 +++++++++++++++
 meson.build               |  1 +
 11 files changed, 32 insertions(+), 24 deletions(-)
 delete mode 100644 accel/Makefile.objs
 delete mode 100644 accel/kvm/Makefile.objs
 create mode 100644 accel/kvm/meson.build
 create mode 100644 accel/meson.build
 delete mode 100644 accel/stubs/Makefile.objs
 create mode 100644 accel/stubs/meson.build
 delete mode 100644 accel/tcg/Makefile.objs
 create mode 100644 accel/tcg/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 9006b282bd..76326e9d22 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,6 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y += accel/
-
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
diff --git a/Makefile.target b/Makefile.target
index 675c23acc8..3aec144e82 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -110,7 +110,6 @@ obj-y += trace/
 #########################################################
 # cpu emulator library
 obj-y += exec.o exec-vary.o
-obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
deleted file mode 100644
index 17e5ac6061..0000000000
--- a/accel/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-common-obj-$(CONFIG_SOFTMMU) += accel.o
-obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
-obj-$(CONFIG_KVM) += kvm/
-obj-$(CONFIG_TCG) += tcg/
-obj-y += stubs/
diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
deleted file mode 100644
index fdfa481578..0000000000
--- a/accel/kvm/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += kvm-all.o
-obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/accel/kvm/meson.build b/accel/kvm/meson.build
new file mode 100644
index 0000000000..4db2388e2f
--- /dev/null
+++ b/accel/kvm/meson.build
@@ -0,0 +1,5 @@
+kvm_ss = ss.source_set()
+kvm_ss.add(files('kvm-all.c'))
+kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
+
+specific_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
diff --git a/accel/meson.build b/accel/meson.build
new file mode 100644
index 0000000000..95184667ff
--- /dev/null
+++ b/accel/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('accel.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: files('qtest.c'))
+
+subdir('kvm')
+subdir('tcg')
+subdir('stubs')
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
deleted file mode 100644
index 3894caf95d..0000000000
--- a/accel/stubs/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
-obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
-obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
-obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
-obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
new file mode 100644
index 0000000000..8456de4d69
--- /dev/null
+++ b/accel/stubs/meson.build
@@ -0,0 +1,5 @@
+specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
+specific_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+specific_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
deleted file mode 100644
index a92f2c454b..0000000000
--- a/accel/tcg/Makefile.objs
+++ /dev/null
@@ -1,9 +0,0 @@
-obj-$(CONFIG_SOFTMMU) += tcg-all.o
-obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += tcg-runtime.o tcg-runtime-gvec.o
-obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
-obj-y += translator.o
-
-obj-$(CONFIG_USER_ONLY) += user-exec.o
-obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
-obj-$(CONFIG_PLUGIN) += plugin-gen.o
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
new file mode 100644
index 0000000000..2a335b50f2
--- /dev/null
+++ b/accel/tcg/meson.build
@@ -0,0 +1,15 @@
+tcg_ss = ss.source_set()
+tcg_ss.add(files(
+  'cpu-exec-common.c',
+  'cpu-exec.c',
+  'tcg-runtime-gvec.c',
+  'tcg-runtime.c',
+  'translate-all.c',
+  'translator.c',
+))
+tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+tcg_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('user-exec-stub.c'))
+tcg_ss.add(when: 'CONFIG_PLUGIN', if_true: files('plugin-gen.c'))
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: files('tcg-all.c', 'cputlb.c'))
diff --git a/meson.build b/meson.build
index e24f927f37..bd0067ba5b 100644
--- a/meson.build
+++ b/meson.build
@@ -654,6 +654,7 @@ subdir('monitor')
 subdir('net')
 subdir('replay')
 subdir('hw')
+subdir('accel')
 
 mods = []
 block_mods = []
-- 
2.21.0



