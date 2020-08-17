Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307BC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7222B205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaW8+Rqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7222B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gtV-00011D-Ks
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHp-0005sO-4q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHn-0006Iu-Gr
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id p20so15286319wrf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EqxqYSBV7uEMenTXBSHXyP24ul4XVhFr0o+0x9l/sqA=;
 b=HaW8+Rqv9UgL2E1Lii0pa2zb99aua6U8bbg/VXRiVqa1rvYWT/yBq7C6ouXzFBXSSY
 2aCXyNNNEB9dwPMcfjEeg6YpUme7/OGE1rvGuyoIUW1wwCgWYmkRcEhQQkLonbABp1KC
 JYdDfryY9JRFgYraseicwX/2128AOubNEgoBGcbvVwzU/YYx3JTDnJk86+wMXZPSQRMd
 4RaLAfiDxg6jjwFDzk/Mx3c7ZMHtejJdF3uJyH7u7pYCj7CUDUetyF2Or9VQfn6eR5CK
 SjQYEbiHf8+BwPE9vCUM6rinL38mNrT4tXvicFJyQfRVgyoEtGtGndBMJ/i8c688LZ8S
 a2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EqxqYSBV7uEMenTXBSHXyP24ul4XVhFr0o+0x9l/sqA=;
 b=GN09eXYUCIvuInVGRD2dj5P3ngy28odWRTVn9x442px+xZTdIH4j5RGRakP/EIhmzf
 K0OZYEkmAdwha3BkzRcHREk6SKQFGbRWU/uZTUaSB8pzUhYDYtXNjvkv2lsg4QfVNZGn
 ML4w+l2b4K+0HVNCaKCn0aqiRsdI0hlxAYYoheYTn6lBMJtrw/1GpJh5mYCcop/Sfkxr
 KIDaPy+Dk23uQdIvQt5qqZUwSqjt6H7Xau8x4Jw/TEjXiuQx8vTJXk60d/i5YXbuRJG2
 DEPOHqe7jv+BEAWS0fTSFXawNim7XSTwTDQ8kGg9fid1ioeyW/jwUBliaxsbSxwrgaw7
 kkKw==
X-Gm-Message-State: AOAM531IyWMav5rXhMpCfKaB17XhfD3qx+pbFMqFXOXw4p+7evoSCj1B
 ElUtIp7jPsdVC9tI/PoHTBO7wE4FPSI=
X-Google-Smtp-Source: ABdhPJy49dAjWZK2xEe6eA+Ocs7xYaXGe3LuBlPI/QwbXOGvE26seMyuGxfsH1yIWmIYsJFFVG0sKQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr16845136wrs.124.1597675133941; 
 Mon, 17 Aug 2020 07:38:53 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 089/150] meson: convert hw/mem
Date: Mon, 17 Aug 2020 16:36:22 +0200
Message-Id: <20200817143723.343284-90-pbonzini@redhat.com>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/mem/Kconfig       | 1 +
 hw/mem/Makefile.objs | 3 ---
 hw/mem/meson.build   | 6 ++++++
 hw/meson.build       | 1 +
 5 files changed, 8 insertions(+), 4 deletions(-)
 delete mode 100644 hw/mem/Makefile.objs
 create mode 100644 hw/mem/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 73c49ddd3b..df72b25a64 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -34,7 +34,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index c27844900d..a0ef2cf648 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -9,3 +9,4 @@ config NVDIMM
     bool
     default y
     depends on (PC || PSERIES || ARM_VIRT)
+    select MEM_DEVICE
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
deleted file mode 100644
index 56345befd0..0000000000
--- a/hw/mem/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-common-obj-$(CONFIG_DIMM) += pc-dimm.o
-common-obj-y += memory-device.o
-common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
new file mode 100644
index 0000000000..ba424622bb
--- /dev/null
+++ b/hw/mem/meson.build
@@ -0,0 +1,6 @@
+mem_ss = ss.source_set()
+mem_ss.add(files('memory-device.c'))
+mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/hw/meson.build b/hw/meson.build
index dccc2d19a6..542d675618 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
-- 
2.26.2



