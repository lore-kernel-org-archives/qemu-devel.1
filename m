Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C4C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E722120786
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdYC3ist"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gvF-0004PH-5g
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHq-0005ui-2I
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHo-0006J8-Bh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id a14so15276467wra.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+WDdT7Yf8vTezEDuWurk22ER4j+BIDWuWinVB2Aw+DA=;
 b=cdYC3istWTOOExZxKzmAS8y9xn0vFq7O6YIcEGTiOww7yu8SqpBJEedkMUcVigeDQG
 nB52e6ffEtSRqu9CaWp1E0v2+ln7QP/pHoQR8Jy8i1lUrDZI+YGWohDt4rvC6wdXwRbU
 8M36HiuEuoxkD2neJJBY/WkRGNbPqQBRmNs8AcSNz65ap8mXRsdHrmId2UE4KMdA50cU
 0VZjCupyrTsRjxuNmxPU1zcrIvlLmFVCrRVyfJ9owK9ZNfqHQsXjucJ8AieTU6PYw58Q
 MhQuYVNWdE5x0OoybYdVvoMGlRv+6EqvslNeNKt/LJjjOik3wA2q0Ma/Bw1khq0IEQz8
 HbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+WDdT7Yf8vTezEDuWurk22ER4j+BIDWuWinVB2Aw+DA=;
 b=RxVPfitwTFH1tjUVyISJuiiiItqQybdSdmozHgIJq+ymdJyrzllB/M3VXwrZQORAiT
 +VMsA4dKOW8d0EyHCjG4gbVdZdpl15KxG62aHODI5Uja1v0xXAmI2EtkxIAasu5X+KGI
 AsT0cZrVznVVs9D0GalUSJ9HROkDfVFIx9Aq2BjZUQl7c1ltOKiF+ipIoXrfZmKUEjND
 FEAfNt861uR9FaHZEoAhiA5yle13NA4skZyDAmF3sVPZdNToozQiNxIgWnWrHLOoSqs+
 qcAqrErWtI1HHThgx39JA+9Y+bEl4Y15w1Qi7mrJuxgkjnCrXO88oCM/NvdlDMOcLS3Q
 BsmQ==
X-Gm-Message-State: AOAM530f6x44aYJoi5wASS8CDw6Xp57Xo8T+WzvR1HIAG0fJgkcfbnt+
 uyapkV7Q/XI3NTWm9oQkhq7s7eC9GIE=
X-Google-Smtp-Source: ABdhPJx3J+YyQmWgL/weOe0M74KV0Gu8YpeMRvixWtkMq8poa+3rkKJXy+JR8D69cisJajaeJEuqag==
X-Received: by 2002:adf:e647:: with SMTP id b7mr16947275wrn.220.1597675134664; 
 Mon, 17 Aug 2020 07:38:54 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 090/150] meson: convert hw/watchdog
Date: Mon, 17 Aug 2020 16:36:23 +0200
Message-Id: <20200817143723.343284-91-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
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
 hw/Makefile.objs          | 1 -
 hw/meson.build            | 1 +
 hw/watchdog/Makefile.objs | 7 -------
 hw/watchdog/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 8 deletions(-)
 delete mode 100644 hw/watchdog/Makefile.objs
 create mode 100644 hw/watchdog/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index df72b25a64..9ebd13d7cd 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,6 @@ devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
-devices-dirs-y += watchdog/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 542d675618..f2209d900c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,4 +3,5 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('watchdog')
 subdir('xen')
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
deleted file mode 100644
index 631b711d86..0000000000
--- a/hw/watchdog/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-common-obj-y += watchdog.o
-common-obj-$(CONFIG_CMSDK_APB_WATCHDOG) += cmsdk-apb-watchdog.o
-common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
-common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
-common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
-common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
-common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
new file mode 100644
index 0000000000..9b8725e642
--- /dev/null
+++ b/hw/watchdog/meson.build
@@ -0,0 +1,7 @@
+softmmu_ss.add(files('watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_WATCHDOG', if_true: files('cmsdk-apb-watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB6300ESB', if_true: files('wdt_i6300esb.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
-- 
2.26.2



