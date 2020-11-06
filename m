Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD901C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38251208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="T7qCuhtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38251208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayEn-00014v-5I
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com>)
 id 1kayCg-00078H-FF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:42 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:55521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com>)
 id 1kayCe-0007Ka-Nk
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-Id:Content-ID:
 Content-Description; bh=9O9qnIXKsiM/2WWp2zKQN9RJK3qY86a6TuCkInAuTWo=; b=T7qCu
 htJN7dVxwtglFtppc1UKv34HDSdNB84EfMswzNq8fNulOmwU+/z0S0a+d0aEDhLD2eq6c5MIx/eO5
 BeLc+moqDFWsedJS1OdN15c9c3Ih3CYBMWLmWQv11WbJcy6TjbRRqiXpcSvQjf0B30NMqujxabtXZ
 60gQ7HCwXlbUMPmi8Umky2kJQ5iRnMV2Wo7i00Zm4hcjjjMiqQRfbtZu8D06oNilRSHdkAOIBSMEe
 ScsetUePlAljuq2NvbLlaFU9Z7nOqQgQIrsefaL+5jsQ/ySGrSkcQ2glIwLRq0LfploRhRM7zE3kF
 ZggVV5nf4O4SVekmkYdPESQh0CjqA==;
Message-Id: <e6b99460b14469e0b83febc8d5a501947d1d5c7c.1604653990.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604653990.git.qemu_oss@crudebyte.com>
References: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 06 Nov 2020 10:13:10 +0100
Subject: [PULL 4/4] hw/9pfs: Fix Kconfig dependency problem between 9pfs and
 Xen
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Philippe Mathieu-Daudé <philmd@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:36:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
CONFIG_9PFS (probably a wrong conflict resolution). This config is
not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
depends on CONFIG_VIRTFS.

Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
fix the './configure --without-default-devices --enable-xen' build:

  /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
  hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
  collect2: error: ld returned 1 exit status

Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20201104115706.3101190-3-philmd@redhat.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/Kconfig     | 4 ----
 hw/9pfs/meson.build | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index d3ebd73730..3ae5749661 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,12 +2,8 @@ config FSDEV_9P
     bool
     depends on VIRTFS
 
-config 9PFS
-    bool
-
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
     select FSDEV_9P
-    select 9PFS
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index cc09426212..99be5d9119 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -15,6 +15,6 @@ fs_ss.add(files(
   'coxattr.c',
 ))
 fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
-softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
+softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
 
 specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
-- 
2.20.1


