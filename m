Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E247C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AB622B40
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi7YQVO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AB622B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gwz-0007ur-4q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHr-0005zr-VR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:39:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHq-0006Ja-9y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l2so15252463wrc.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3C/7hgOHspBfIxBONsfiAWNW93qZIpPhApRZy9KVThY=;
 b=Pi7YQVO4jxzoAaWRhm/qCl5IDSHvNMrG5klVB2CCN3CmUw6cjzp55W2kLvndKjAPyE
 BkWM//RB5aHT8Ts1Jes8Jm89X+Id0ReKxtbCtenOAt84GhkoYFrvwf1+nRo4OBXn63gA
 pgAFyEpKga7rC1kmR3dOmXBOwaCm5DZcP35i0igbnUOqJvR3DgnB3TKCR/jdU/60tK3b
 0hC4ncXme9CF7RjAW+riJ7FsYhWv4tY19/MRhGbfoyG9EMfiD+IvvnAwZlrXlrnq2nym
 PmbcDEPPcEvgwSm75yiYVjcqKGOq6eN7WUk0sWW/cUY25QrDhTmWwrEO5fiCFTfaIg/7
 2ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3C/7hgOHspBfIxBONsfiAWNW93qZIpPhApRZy9KVThY=;
 b=biF1DdDwGLH5s9zbg7HZCJyaT6KANTeisyRxvBGpYuZRld1NL2yoX9X3l3pfyrUnYY
 ITBg0ZmtsAumH4GkM8nMW6/5ZO2NSvojSe6xy0PYng6FUrMfjEzO+Hgmy7ixiobErdkm
 VZ4TnGvwwGRT6tsEDXE534BPOy9pSN9gLkpOnugd1uMM2AkW+TCuj8NrfhiW4g2xpQai
 wIHZKfCfspK5fWY0nsfv4veD397QvWqMlDpZOQyVcGcKhjip61bbPRzXRmQNZM0sNH9a
 KOoN2tSV4yPgaRsLBSSo31t0ZsGS5wATaAyMF7wO14EoiNug6923wYdnSY/nOMx4U6B5
 idcQ==
X-Gm-Message-State: AOAM530xTLIfAoeLzj9gqls0w8epIxRlem8YoEyG8DAPGZb2mF2s/9uI
 IqSQ3ruqhS18ereFzd9yFqVuZcYWD4A=
X-Google-Smtp-Source: ABdhPJwQLvbbwyNFV49FrETW8Ao20tqm0iSftw46YNbVWso7mAn8cwpP7nOb5MJgm+4Y5tzISSAEnw==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr15506103wrq.422.1597675136611; 
 Mon, 17 Aug 2020 07:38:56 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 092/150] meson: convert hw/vfio
Date: Mon, 17 Aug 2020 16:36:25 +0200
Message-Id: <20200817143723.343284-93-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42a.google.com
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/vfio/Makefile.objs |  8 --------
 hw/vfio/meson.build   | 18 ++++++++++++++++++
 4 files changed, 19 insertions(+), 9 deletions(-)
 delete mode 100644 hw/vfio/Makefile.objs
 create mode 100644 hw/vfio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a1cfb99334..f6e08f6660 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -31,7 +31,6 @@ devices-dirs-y += ssi/
 devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
-devices-dirs-$(CONFIG_VFIO) += vfio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 8338fc4408..4dafc8a08e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
deleted file mode 100644
index 9bb1c09e84..0000000000
--- a/hw/vfio/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y += common.o spapr.o
-obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
-obj-$(CONFIG_VFIO_CCW) += ccw.o
-obj-$(CONFIG_VFIO_PLATFORM) += platform.o
-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
-obj-$(CONFIG_VFIO_AP) += ap.o
-obj-$(CONFIG_VFIO_IGD) += igd.o
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
new file mode 100644
index 0000000000..37efa74018
--- /dev/null
+++ b/hw/vfio/meson.build
@@ -0,0 +1,18 @@
+vfio_ss = ss.source_set()
+vfio_ss.add(files(
+  'common.c',
+  'spapr.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+  'pci-quirks.c',
+  'pci.c',
+))
+vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
+
+specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
-- 
2.26.2



