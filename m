Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DCA2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC/E6i7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DCA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOki-0007uP-33
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNys-0004Jc-Sm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyr-0007mO-Nj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:10 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyr-0007kg-Di
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:09 -0500
Received: by mail-wr1-x436.google.com with SMTP id b6so2661504wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3l9D/wa5LzkwNOYWyU/pU6VHkPV0wMYqTq2JxoBeQXg=;
 b=WC/E6i7tLfb5kQEJif57R+98ZRpCvLZ1QkUfpHl6A/3/Voe46aiSbPbSasTgmPehri
 yb/qh914JIEg79U1fDNpDC+JO9rts2P8+Kcg/oqS7Tz6NApyv+5hZnRCjQmP/kZVf5vO
 dFsKpmD0iN8qGJwnhCxdKEKnnvPYRfpyUM0ENZl/ffWdbX8ADFy/+Oq9s9wDlLgRaFkW
 AhhrHTcEkFzolbwnEoBpV8kSUg5h09QIPv+8GsC0p6aTtWOawpz0iFjcVDMFgVdPeol2
 brm2qSw8N7oB9x+9OHH1HGLYjzUYYrm21oy76lW1OmLgb3hthN53D6zwBA/Jl6ZskcF5
 kdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3l9D/wa5LzkwNOYWyU/pU6VHkPV0wMYqTq2JxoBeQXg=;
 b=Fe2fPqic4XyRJY2cqj4MTn9V3ktRA5s6SODaRG61KNG4/NJ5Om04qlwV7WvnvPpUOB
 IRLbpVTrWPNqXS9CgUfhB1SFmWYcevddOTus45PpgTtpiCX7vJYU2hg8vbo8LYcJ9uaM
 tjGZ/lN2vLD0o/od7Stcd507dCIkTOT6vsxxXIDdfGJK/Hvu+rcBx8RiPPfhSu13xnro
 p1dMC/OYDEJusTzNLHTg3VcYhCqSt1cgkGkVd5n+FHjRyVIzirU1dEbeSpgnGYoKeiaw
 yTp3z0trjMQIIQeIhXsoLesnpjtUjs1J3yAd4YB6SO5QyHoSq58S1UTSVmzcOdmyiwOc
 VRdg==
X-Gm-Message-State: APjAAAWsO5ZszeYJDHE34oL8Zv7qvXSBe0xj4OcyX7WF/11vlfN0JOC/
 G8qRQ1WWYg85MSpLXK94STJQqpM8
X-Google-Smtp-Source: APXvYqzlbRhFv9m5ZKFTTWTstXLU9fSg0zb8ZHUBlClXVeTImFgSDtw9HXtURVK9Bf2y/X77ryAYJQ==
X-Received: by 2002:adf:f288:: with SMTP id k8mr6540116wro.301.1576155248199; 
 Thu, 12 Dec 2019 04:54:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 070/132] meson: convert hw/vfio
Date: Thu, 12 Dec 2019 13:51:54 +0100
Message-Id: <1576155176-2464-71-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/vfio/Makefile.objs |  7 -------
 hw/vfio/meson.build   | 17 +++++++++++++++++
 4 files changed, 18 insertions(+), 8 deletions(-)
 delete mode 100644 hw/vfio/Makefile.objs
 create mode 100644 hw/vfio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3f528b5..d0c817b 100644
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
index a8e9acd..16c0abd 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
deleted file mode 100644
index abad8b8..0000000
--- a/hw/vfio/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-obj-y += common.o spapr.o
-obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
-obj-$(CONFIG_VFIO_CCW) += ccw.o
-obj-$(CONFIG_VFIO_PLATFORM) += platform.o
-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
-obj-$(CONFIG_VFIO_AP) += ap.o
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
new file mode 100644
index 0000000..b9a31ca
--- /dev/null
+++ b/hw/vfio/meson.build
@@ -0,0 +1,17 @@
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
+
+specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
-- 
1.8.3.1



