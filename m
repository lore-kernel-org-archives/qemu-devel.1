Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F292C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440DA205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A40VzTOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440DA205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gqw-0003pd-Cf
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHn-0005o8-Ce
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHl-0006IJ-E9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id f1so15277527wro.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uhqRQfxgZKwJ96ol0mbenRayAvfbDPlr1SxB4DAAIBo=;
 b=A40VzTOQYLbyjaSvMWyTsc7kh7qGpKau+iZfS6s41N6h1M7JENGsYhhm6aYIy/3OHI
 2GKoD7lfIk7ml2CuYEHKWczB43HCnd9snBCgKCjpPo27AgSivfXiYF4Q3qeQgCVzstNt
 EH1kTkGCi0QULtohC5SjrUOVqbAn4pOCMoNk8HIVv2n9URWc9bHF/9cvEgqRnmu9Y499
 QGCPb1VFCmsQtST0+W19B0ufe/idO3/ZGLLwtFH2BzrS8QMiJXwyAWnuwor0UQjpcwy6
 /3zm4Fr44xAGPbpW1VXzvo6xgyCdpORl9FkdztjCKjbhtFhVunyf4tWtWlNQBocnlFn0
 GEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uhqRQfxgZKwJ96ol0mbenRayAvfbDPlr1SxB4DAAIBo=;
 b=P8/5c4ZlSpoebJyBS7I/WqphMLFfeDlvWlU6ERJC7p+z6FHpfrOSPfOp1hsOZgiC1B
 MAyjL6ogcKaPjwGt8tF5lHf2fqap3oMBby9O4Z8IDKDZJsSNBzqsVSIrVvH7wnobRI1l
 kIsT0VQr1slLwYnVPkfDNKQVOOqVwYBI7mI41xOMsVLFpLki9I0Zm+kEKrMcUyYSAE1S
 XloTSgwANrOrTrgziRqqcepa/2jQaNkdfxGvRhyaJ3o53XxhIwKzavRSmc/X5JgSXL6D
 2hIkdYDP09MwSJGBW7/8U2inqCFkkBj4KwDi6HvQGK0F9Oe2G3KrzuJxcMMp+vGSe8Vx
 14Iw==
X-Gm-Message-State: AOAM5328dxyb2U9x+TVa+Z+DPbaBaTLA/uuPI1hmjNLtw1TyegSMv2x4
 HHT91jiWlO+PJtEjHBqPy/oaxgJ1mKk=
X-Google-Smtp-Source: ABdhPJyIYGFbDFYK4emxkzrjkwz2qq56MBnmwHDJv9T78/O3OL/m+rweKiZz9tFSPSNFb6QoXUMHng==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr16080777wrv.317.1597675131907; 
 Mon, 17 Aug 2020 07:38:51 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.51 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 087/150] meson: convert hw/nubus
Date: Mon, 17 Aug 2020 16:36:20 +0200
Message-Id: <20200817143723.343284-88-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       | 1 -
 hw/meson.build         | 1 +
 hw/nubus/Makefile.objs | 4 ----
 hw/nubus/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 5 deletions(-)
 delete mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6a7ca0fcfe..86bc201a55 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index 66a2f6cddd..03ef30212e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
 subdir('core')
+subdir('nubus')
 subdir('semihosting')
 subdir('xen')
diff --git a/hw/nubus/Makefile.objs b/hw/nubus/Makefile.objs
deleted file mode 100644
index 135ba7878d..0000000000
--- a/hw/nubus/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-y += nubus-device.o
-common-obj-y += nubus-bus.o
-common-obj-y += nubus-bridge.o
-common-obj-$(CONFIG_Q800) += mac-nubus-bridge.o
diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
new file mode 100644
index 0000000000..9287c633aa
--- /dev/null
+++ b/hw/nubus/meson.build
@@ -0,0 +1,7 @@
+nubus_ss = ss.source_set()
+nubus_ss.add(files('nubus-device.c'))
+nubus_ss.add(files('nubus-bus.c'))
+nubus_ss.add(files('nubus-bridge.c'))
+nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
-- 
2.26.2



