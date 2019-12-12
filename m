Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63596C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6922077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB55BewK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6922077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOmj-0001IN-KD
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyu-0004Mj-NP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyt-0007q6-K3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:12 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyt-0007oW-CZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so2604557wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gkCOZ6HfKG25xVzS1LaU0MoLpk2e6Hmi4aWBpccGyI=;
 b=bB55BewKBun8y+zeAX+9qkn2U5gaOxA2JisV4rFFpUHQHXdOXUosmotfQeCM+nGVIi
 T9UL6ZI2vLCyel1vdhYENDxdEA8WQBm0ew8okOhliSVMK2Rt9Rj6PZsbzOP5Dv0eO9Sl
 HZ7TpkSTg7IzyOhxNsfKCn6c+AUzwnqtMga9nLserLL+hL/jQ6h0DMWWUYbMgJnKUrqD
 W8nwPijm00xmksn/Z3h3uEhQSD07Gm5CA5e32OIJQnyzUW+IPpygEt+/pxzNrVBUM4OH
 C1xYV3JYTtQoEJn+oyuoEIsEOURfayJqlIbu5Klhddoh4Jwhn9LFXIADqIOVRZzR9MPT
 twmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7gkCOZ6HfKG25xVzS1LaU0MoLpk2e6Hmi4aWBpccGyI=;
 b=VzCoBYphIkA9KifG47j6CRuOvxqt/Tc0HkEJhXnQjGx2kLeqY0C7Nb5mERsf1F3voU
 yl39WO5/+Lb3WTvh6lRxbBKLq4n4jk2EllT4RBsmqQ157bHRglNvWZg4AHaDjLdLBTvO
 mSBEFzG/n0oOOmstiJQdAIHKDnuRsKGfYQeEZHIPpxVr+u1Z5cLl7cUSS1Tg0aPJ0Pr2
 B4+cUHOf6wYt/RvVURZWfOpSO8Tqx0t1x1kMRpzNMmH5vxu7h65ILjMPHefRCan6k2/H
 jVmJxVW+Nx6YP2RuY7OufCoVxlfyHijY1CBPmuxP8NRZB0XJN27M1Yse8hzskCvgzRRi
 ybQQ==
X-Gm-Message-State: APjAAAVrCJK9cUlc9QUQx1mB85i1oN/b1FIiqfEa7n1FQyiiqvw/A+0U
 NX8Kb0Eh88oGst2PYc+ShS08N3tw
X-Google-Smtp-Source: APXvYqxqMSwgukkJIGoHY96VHDPDOLK6iBrXWgznnIXx169zwgP3B/lKlXrU2nfRbQtyTK946HEgZA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr5704526wrm.139.1576155250082; 
 Thu, 12 Dec 2019 04:54:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 072/132] meson: convert hw/tpm
Date: Thu, 12 Dec 2019 13:51:56 +0100
Message-Id: <1576155176-2464-73-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/meson.build       | 1 +
 hw/tpm/Makefile.objs | 6 ------
 hw/tpm/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 7 deletions(-)
 delete mode 100644 hw/tpm/Makefile.objs
 create mode 100644 hw/tpm/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index df804a0..6529617 100644
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
index 43797f9..4e918d0 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('tpm')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
deleted file mode 100644
index de0b85d..0000000
--- a/hw/tpm/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-common-obj-$(CONFIG_TPM) += tpm_util.o
-obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
-common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
-common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
new file mode 100644
index 0000000..9ab7cd7
--- /dev/null
+++ b/hw/tpm/meson.build
@@ -0,0 +1,7 @@
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm_util.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true: files('tpm_passthrough.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPMDEV'], if_true: files('tpm_ppi.c'))
-- 
1.8.3.1



