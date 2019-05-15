Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98922070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98922070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR19Y-0004LE-P1
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:09:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s4-0006Wz-Pa
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s2-0001fJ-Lk
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0s0-0001Xu-Ik
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64819307D98F
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:11 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3F45C5B0;
	Wed, 15 May 2019 20:51:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:29 +0200
Message-Id: <1557953433-19663-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 15 May 2019 20:51:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/21] build: chardev is only needed for softmmu
 targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Move the dependency from SUBDIR_RULES to SOFTMMU_SUBDIR_RULES

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190401141222.30034-5-lvivier@redhat.com>
---
 Makefile      | 3 ++-
 Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d9a3040..1851f8c 100644
--- a/Makefile
+++ b/Makefile
@@ -444,6 +444,7 @@ SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
+$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
 $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
@@ -480,7 +481,7 @@ subdir-capstone: .git-submodule-status
 subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
diff --git a/Makefile.objs b/Makefile.objs
index dda5bbc..43c9e45 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -129,9 +129,9 @@ trace-events-subdirs += accel/kvm
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += authz
 trace-events-subdirs += block
-trace-events-subdirs += chardev
 trace-events-subdirs += crypto
 ifeq ($(CONFIG_SOFTMMU),y)
+trace-events-subdirs += chardev
 trace-events-subdirs += audio
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/acpi
-- 
1.8.3.1



