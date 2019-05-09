Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FCD21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FCD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51335 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfQG-0007sD-C9
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:33:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOfOl-0007GI-Hr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOfOk-0004kd-LF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOfOk-0004k2-Em
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:31:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DD5F8124A
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 09:31:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB49F6D2;
	Thu,  9 May 2019 09:31:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id CF42DA1E4; Thu,  9 May 2019 11:31:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 11:31:21 +0200
Message-Id: <20190509093121.25974-2-kraxel@redhat.com>
In-Reply-To: <20190509093121.25974-1-kraxel@redhat.com>
References: <20190509093121.25974-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 09 May 2019 09:31:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] virtio-input: fix Kconfig dependency and
 Makefile
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make VIRTIO_INPUT_HOST depend on VIRTIO_INPUT.
Use CONFIG_VIRTIO_INPUT_HOST in Makefile.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/Kconfig       | 2 +-
 hw/input/Makefile.objs | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 50e55e353847..889363d8aef1 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -27,7 +27,7 @@ config VIRTIO_INPUT
 config VIRTIO_INPUT_HOST
     bool
     default y
-    depends on VIRTIO && LINUX
+    depends on VIRTIO_INPUT && LINUX
 
 config VHOST_USER_INPUT
     bool
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index 3eddf00f2bba..d1de30770854 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -9,9 +9,7 @@ common-obj-$(CONFIG_TSC2005) += tsc2005.o
 
 common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input.o
 common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
-ifeq ($(CONFIG_LINUX),y)
-common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-host.o
-endif
+common-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host.o
 common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
 
 obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
-- 
2.18.1


