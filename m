Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F342C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3B72067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izzkcj8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3B72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gqR-0002ZY-HE
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHm-0005lj-Fp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHk-0006I0-Ix
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id p14so13426164wmg.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iCxXfpTM81EsDq1JksQIVS4Yaq4rtllmbbY1pIXiot0=;
 b=izzkcj8+k/ebG7ZeSzqk7VRm4zccQEGl1FLJeM4bGqk/PK/6H/GOCTGVcn4IWlsWus
 H5tHpJRcGWiCgGbJurFoXMkxQ2GsnH0TIX2uHHbfbgqQUYx46lDoG6tqOXJQnxIxGrUI
 fjitOnX4H8aJK56KSvYi0YpAPPKKqO0ak8a+gfKc57PWZoQHsJRuEY2Wz5oUdxDcGUAS
 3jBiBolbpkgrRvCfRFiQTH+yci1MosIqph3zQd1xHjnIjmGp06po5x4vHhyL2EcAWrr+
 bQZoalFEFd5WjBRR59PwkKhOwmqlpzI+AM1iqFW+bZdeMxvphWy2ahCR0eViB6H7fcwz
 Dk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iCxXfpTM81EsDq1JksQIVS4Yaq4rtllmbbY1pIXiot0=;
 b=kL+PytMuN5cw26jPI74rNPeSc8c17cSSbKoB7QdmzYPDPsI3I3aYJghEjENQYb0pra
 CMWXbaLEk5VURmZbdcJS3KNrUPhF0BbJ+Wyi8OeCe/KZDpzyNj6cKpSh8YYxkv8RH/mA
 XlEVw0CZKoRZV9J0uOVZosbYZWBTWzp77gYMarll/kAgErejKXL9du3JFfUUzNsUhddw
 3UQI3ZU9ikaIo3F10StzpyGPwFfSV8Yx03d1slJkbRUKFNYSUulJZ95FfBg/BhUkYEgZ
 NIUk+AAhreKMxj/Uf43r3MnWwyXwecWRzG7OPGC4NDtrSnrttFJlCWqkEp819d/wGeRq
 rRgA==
X-Gm-Message-State: AOAM530RWLGBok9leIp55mGaoyK+qIpgRnL+tgckreTxyQbNz4W07XRz
 Rfq4EWlc+rMrd+p0SJbkVYxNjSAHL58=
X-Google-Smtp-Source: ABdhPJxFfGZyEy29vCz9YWuhOks/CF+JviQKlMKiIRNsWctGG3B/MmtrM2pRF7cuqXndIBDWcq1ufQ==
X-Received: by 2002:a1c:a1c7:: with SMTP id k190mr14171897wme.1.1597675131015; 
 Mon, 17 Aug 2020 07:38:51 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 086/150] meson: convert hw/semihosting
Date: Mon, 17 Aug 2020 16:36:19 +0200
Message-Id: <20200817143723.343284-87-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x341.google.com
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
 hw/Makefile.objs             | 1 -
 hw/meson.build               | 1 +
 hw/semihosting/Makefile.objs | 2 --
 hw/semihosting/meson.build   | 4 ++++
 4 files changed, 5 insertions(+), 3 deletions(-)
 delete mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index bdf8bdf256..6a7ca0fcfe 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -36,7 +36,6 @@ devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
-devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index fe7c466460..66a2f6cddd 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('core')
+subdir('semihosting')
 subdir('xen')
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
deleted file mode 100644
index 4ad47c05c0..0000000000
--- a/hw/semihosting/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_SEMIHOSTING) += config.o
-obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
new file mode 100644
index 0000000000..f40ac574c4
--- /dev/null
+++ b/hw/semihosting/meson.build
@@ -0,0 +1,4 @@
+specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
+  'config.c',
+  'console.c',
+))
-- 
2.26.2



