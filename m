Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3273C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5742082E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42501 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR12q-0007cZ-R6
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:02:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rw-0006O2-Pz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rt-0001aE-Qz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rm-0001WL-JG
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29E4983F44
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:07 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63F685C557;
	Wed, 15 May 2019 20:51:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:26 +0200
Message-Id: <1557953433-19663-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 15 May 2019 20:51:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/21] trace: only include trace-event-subdirs
 when they are needed
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

Some directories are built only for softmmu targets,
and the related trace-event-subdirs must do the same

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190401141222.30034-2-lvivier@redhat.com>
---
 Makefile.objs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index cf065de..dda5bbc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -127,11 +127,12 @@ rdmacm-mux-obj-y = contrib/rdmacm-mux/
 trace-events-subdirs =
 trace-events-subdirs += accel/kvm
 trace-events-subdirs += accel/tcg
-trace-events-subdirs += audio
 trace-events-subdirs += authz
 trace-events-subdirs += block
 trace-events-subdirs += chardev
 trace-events-subdirs += crypto
+ifeq ($(CONFIG_SOFTMMU),y)
+trace-events-subdirs += audio
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/alpha
@@ -140,7 +141,6 @@ trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/block
 trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
-trace-events-subdirs += hw/display
 trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/hppa
 trace-events-subdirs += hw/i2c
@@ -173,11 +173,14 @@ trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/watchdog
 trace-events-subdirs += hw/xen
 trace-events-subdirs += hw/gpio
+trace-events-subdirs += migration
+trace-events-subdirs += net
+trace-events-subdirs += ui
+endif
+trace-events-subdirs += hw/display
 trace-events-subdirs += io
 trace-events-subdirs += linux-user
-trace-events-subdirs += migration
 trace-events-subdirs += nbd
-trace-events-subdirs += net
 trace-events-subdirs += qapi
 trace-events-subdirs += qom
 trace-events-subdirs += scsi
@@ -189,7 +192,6 @@ trace-events-subdirs += target/ppc
 trace-events-subdirs += target/riscv
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/sparc
-trace-events-subdirs += ui
 trace-events-subdirs += util
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
-- 
1.8.3.1



