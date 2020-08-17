Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED5FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A3E20789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ghMj+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A3E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gRn-0007E2-O0
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGt-00046E-AM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGr-00065Y-FG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so15257484wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3/A25iqRX1oTupID8UYDeviy1ajt4ku4RSauqaDT1hc=;
 b=i4ghMj+UrispXtZnQStHGlQJL4ZffzlEQ0wTwiHrHmMO6inlp7xHKs8k1VZz7VBy1o
 1H0k28YbDdCuGIcDY1CWdJJLjztM6V8BlhAmQsBEN5mOTHQybVSP7T0DhYV+ly4TXRKb
 5HTLwimwlnPDfHf4b/9Ch0ST+Zv9Gt23mHYZ1M9Dwz+V+ECyqC0i72xWQ3wVaXEHk3OM
 NdGBNkugiI06NUDDusvYTNm8Qg7S7Tm7f3k4cTbkvsffvna3t5UWgHFdNnwAmDEyMhbd
 yOYsR2SiKNIKJ5lLaIRNxO3rTiUbhZ/I+ogWasPOrhZFP4KxRHPFeze11hRS/jhYMqK8
 yDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3/A25iqRX1oTupID8UYDeviy1ajt4ku4RSauqaDT1hc=;
 b=NISXysUd29wFc8C3KG1WEhYtWaPs6MW3Fr4Bex4FfPKa89WzzSlzrzeQ2tfwcLUBcD
 LLnD24bxKtp1DDyVWsOX/kJaZGx9uDN60MFTrfAsAua6nqFXV7NxynbOETTsLoLJ4R4L
 2yceCPHCxgtC8ONh+gNG67gFrYfao7QDizmfV0LuqBh3DfZWH1EE6AjeAtxGU48F16Kw
 Ch80Qb/pkjnzj3tKSn23PQTELDjpKavI0KEPtt8ow1r2pSq3IVmxCBLcvZrwY4f29LGN
 Y/5VfRNtqGvBCcIWazcGAGQTLKQTSnnyun1RZwTbPKymqJyz6BRY3Debbxj//BckCPcy
 4nUA==
X-Gm-Message-State: AOAM533mZ9t5WN1u4boIbWOm+e6RDXxGvnzpdGVSuUF7nUDllsJX+Tnx
 PcjTKRveRHtVm6OK05zwZEQ1GpM3wb8=
X-Google-Smtp-Source: ABdhPJzdDto2HhT8UE8WOoxOa9thaHvXAlbEeO3mEZVD29Il3rHY5nTyn1h+bt0i6N3Zdan7/nORWw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr16717452wrp.182.1597675075901; 
 Mon, 17 Aug 2020 07:37:55 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.54 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 029/150] contrib/vhost-user-blk: convert to Meson
Date: Mon, 17 Aug 2020 16:35:22 +0200
Message-Id: <20200817143723.343284-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GLib pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                             | 3 ---
 Makefile.objs                        | 1 -
 contrib/vhost-user-blk/Makefile.objs | 1 -
 contrib/vhost-user-blk/meson.build   | 5 +++++
 meson.build                          | 1 +
 5 files changed, 6 insertions(+), 5 deletions(-)
 delete mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/meson.build

diff --git a/Makefile b/Makefile
index 3bb2cd7c73..f09d8ff553 100644
--- a/Makefile
+++ b/Makefile
@@ -302,7 +302,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
-                vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -525,8 +524,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index fee0f71372..f69736c10c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,7 +109,6 @@ ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
-vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-blk/Makefile.objs b/contrib/vhost-user-blk/Makefile.objs
deleted file mode 100644
index 72e2cdc3ad..0000000000
--- a/contrib/vhost-user-blk/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-blk-obj-y = vhost-user-blk.o
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
new file mode 100644
index 0000000000..05cbf816d2
--- /dev/null
+++ b/contrib/vhost-user-blk/meson.build
@@ -0,0 +1,5 @@
+executable('vhost-user-blk', files('vhost-user-blk.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index d56cd0dd27..90c20d8f35 100644
--- a/meson.build
+++ b/meson.build
@@ -253,6 +253,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
+    subdir('contrib/vhost-user-blk')
   endif
 endif
 
-- 
2.26.2



