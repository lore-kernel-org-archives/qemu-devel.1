Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86693C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A27D20825
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRt859ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A27D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gwg-00077g-Fc
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHt-00064Z-Qc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:39:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHs-0006KU-5j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:39:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so15231392wrs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n8upm3BapCkLlRkXboJxxZ9NvS70YwkGjkzhPIn1foE=;
 b=qRt859zehxDr7mdTRuSsV8ilBal9bsJUUQDHe7cn06iZ7RFDS7EFrZjIEg8k/Ghetl
 TFbJXCUegK4cP77rQvKkfkVE1ZFZrGZz1Ml2r57Q3tWGLmLQCp3XUKEWN3qjZPAPe7rE
 u/w6yqSCd9CYO3Uy0fpNnmMQOEFvcJUgRA1kW/qW6DoD9MGnrZVrKBdiSULUy61eglDp
 N7PsJJZt0z6zGXHPcw2mXSbcvDFUvMwo0VYS2TacDHbrUeTrC5xwcHwOYPP5nLhTl6An
 qnKSdsyez3v0F9X2rRwW9OFnCgsaX36E8VrkSOohDKvXbiWPeVkM1psCjKBDkoYljfVp
 ypXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n8upm3BapCkLlRkXboJxxZ9NvS70YwkGjkzhPIn1foE=;
 b=G6HmnNyY5uzMk7bvsgogSJ8GtBsaX2qEguUnK+U50AUHhLGK+8AAHKApH5VLgw6JiL
 7HRN2VN9CP+BSFFlUwoMrZ6JE/2OlELF66W1Txe8L4gDVQN4HwXPIgLukJ3o0YiwZZzL
 HlJQUyw0tU+DJtpor7xe9iYLH/CPL5QztchV83yGKY9tXBFhuDBh+KP2x8RgBgt3kmvj
 lPPQfOkdifUj0QNpmc8Df2Qqz8sVrx8s5Oik71NmYzgMZYnI8+2Jb4zW/huFATbokJcP
 cQLocJhyt32Hi+ghAwvrnlIuuNrogBlRoqwjVHWapp6VAFVjRhEuXQYurpDRSihEy8ue
 mXpQ==
X-Gm-Message-State: AOAM532b83OzIswZygen4uXOWuoMvTNOLSE6bsS++O/wmlT9Fk6spsHp
 RST3Ho1dSRSZH9VKyuQ9lXqt4nEpDcI=
X-Google-Smtp-Source: ABdhPJyTNW9ocNGii1oJ+CiAMotg1I9hqY8NNVwib7fdjM2NRM9uyDLSDCFjK7ROupwn6qBiBxFokQ==
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr15675342wrf.171.1597675138662; 
 Mon, 17 Aug 2020 07:38:58 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 094/150] meson: convert hw/tpm
Date: Mon, 17 Aug 2020 16:36:27 +0200
Message-Id: <20200817143723.343284-95-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/meson.build       | 1 +
 hw/tpm/Makefile.objs | 6 ------
 hw/tpm/meson.build   | 8 ++++++++
 4 files changed, 9 insertions(+), 7 deletions(-)
 delete mode 100644 hw/tpm/Makefile.objs
 create mode 100644 hw/tpm/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c2619bbb50..f0e5728d13 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -29,7 +29,6 @@ devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
 devices-dirs-y += timer/
-devices-dirs-$(CONFIG_TPM) += tpm/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 89bd6adb70..2ddf6bad33 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('tpm')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
deleted file mode 100644
index 6fc05be67c..0000000000
--- a/hw/tpm/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
-common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
-common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
-common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
-common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
new file mode 100644
index 0000000000..1c68d81d6a
--- /dev/null
+++ b/hw/tpm/meson.build
@@ -0,0 +1,8 @@
+softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_TIS'], if_true: files('tpm_ppi.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_CRB'], if_true: files('tpm_ppi.c'))
+specific_ss.add(when: 'CONFIG_TPM_SPAPR', if_true: files('tpm_spapr.c'))
-- 
2.26.2



