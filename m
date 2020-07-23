Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16F6206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0e8UqC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16F6206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfMx-0003SV-TW
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJT-00061L-Bj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJR-0004Er-Bu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuN2A5nVv8qvcFglG8w7xF0+KQS4lEX4mWOf4HwsCvo=;
 b=Q0e8UqC1k7Qbv2ZA5ZatGxI+ZEwgdolnTZDcJMMybyInaSWWwg+8l/dR9ggF8sjemZUzcK
 H5bvvjLRU/1mR1SqPFj1xstzKW+CAWeN4RkTab9x4OnzwoXMm67hINvjkrDo6yfBogHSbn
 VBimd1xdxLQogXQkH5PWLfj4SbzyxDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-maXPm4E5NV2dFEmUye3rgw-1; Thu, 23 Jul 2020 13:47:12 -0400
X-MC-Unique: maXPm4E5NV2dFEmUye3rgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A64106B204;
 Thu, 23 Jul 2020 17:47:11 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF39769327;
 Thu, 23 Jul 2020 17:47:03 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH 6/7] build: Add SPICE_CFLAGS and SPICE_LIBS to relevant files
Date: Thu, 23 Jul 2020 19:46:14 +0200
Message-Id: <20200723174615.2370096-7-dinechin@redhat.com>
In-Reply-To: <20200723174615.2370096-1-dinechin@redhat.com>
References: <20200723174615.2370096-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of adding the spice build flags to the top-level build
options, add them where they are necessary. This is a step to move the
burden of linking with spice libraries away from the top-level qemu.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 configure                | 4 ++--
 hw/display/Makefile.objs | 1 +
 hw/i386/pc.c             | 1 -
 monitor/Makefile.objs    | 3 +++
 softmmu/Makefile.objs    | 2 +-
 ui/Makefile.objs         | 4 ++--
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 054aab31be..86fc03699a 100755
--- a/configure
+++ b/configure
@@ -5223,8 +5223,6 @@ EOF
      $pkg_config --atleast-version=0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice="yes"
-    libs_softmmu="$libs_softmmu $spice_libs"
-    QEMU_CFLAGS="$QEMU_CFLAGS $spice_cflags"
     spice_protocol_version=$($pkg_config --modversion spice-protocol)
     spice_server_version=$($pkg_config --modversion spice-server)
   else
@@ -7535,6 +7533,8 @@ fi
 
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=m" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index d619594ad4..3963fd1dcd 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -47,6 +47,7 @@ obj-$(CONFIG_VGA) += vga.o
 ifeq ($(CONFIG_QXL),y)
 common-obj-m += qxl.mo
 qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
+qxl.mo-cflags += $(SPICE_CFLAGS)
 endif
 
 common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..9f28a91df9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -64,7 +64,6 @@
 #include "kvm_i386.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/start_info.h"
-#include "ui/qemu-spice.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "sysemu/arch_init.h"
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index a8533c9dd7..fd58d80195 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -2,5 +2,8 @@ obj-y += misc.o
 common-obj-y += monitor.o qmp.o hmp.o
 common-obj-y += qmp-cmds.o qmp-cmds-control.o
 common-obj-y += hmp-cmds.o
+qmp-cmds.o-cflags += $(SPICE_CFLAGS)
+hmp-cmds.o-cflags += $(SPICE_CFLAGS)
+misc.o-cflags += $(SPICE_CFLAGS)
 
 storage-daemon-obj-y += monitor.o qmp.o qmp-cmds-control.o
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a414a74c50..4e36ff47a2 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -11,4 +11,4 @@ obj-y += memory_mapping.o
 obj-y += qtest.o
 
 obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SPICE_CFLAGS)
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 1ab515e23d..6a6fda2f06 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -57,8 +57,8 @@ spice-app.mo-objs += spice-core.o spice-input.o spice-display.o
 ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),ym)
 spice-app.mo-objs += spice-app.o
 endif
-spice-app.mo-cflags := $(GIO_CFLAGS)
-spice-app.mo-libs := $(GIO_LIBS)
+spice-app.mo-cflags := $(GIO_CFLAGS) $(SPICE_CFLAGS)
+spice-app.mo-libs := $(GIO_LIBS) $(SPICE_LIBS)
 
 common-obj-$(CONFIG_OPENGL) += shader.o
 common-obj-$(CONFIG_OPENGL) += console-gl.o
-- 
2.26.2


