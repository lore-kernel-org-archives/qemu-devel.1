Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A53C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068572084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068572084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQoAm-0002Z8-6o
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 03:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQo9I-0001SA-PQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQnxP-0005J5-6L
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hQnxP-0005G5-0s; Wed, 15 May 2019 03:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02D913001C3D;
	Wed, 15 May 2019 07:04:06 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-225.brq.redhat.com [10.40.204.225])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E45C60BE5;
	Wed, 15 May 2019 07:04:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 09:03:57 +0200
Message-Id: <20190515070357.882-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 15 May 2019 07:04:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] docs/devel/build-system: Update an example
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default-configs/ example added in 717171bd2025 is no
more accurate since fa212a2b8b60 (and various further other
commits).

The Kconfig build system is now in place.
Use the aarch64-softmmu config as example.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 docs/devel/build-system.txt | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index addd274eebd..79a85bfba06 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -415,16 +415,11 @@ context.
 The files under default-configs/ control what emulated hardware is built
 into each QEMU system and userspace emulator targets. They merely
 contain a long list of config variable definitions. For example,
-default-configs/x86_64-softmmu.mak has:
-
-  include sound.mak
-  include usb.mak
-  CONFIG_QXL=3D$(CONFIG_SPICE)
-  CONFIG_VGA_ISA=3Dy
-  CONFIG_VGA_CIRRUS=3Dy
-  CONFIG_VMWARE_VGA=3Dy
-  CONFIG_VIRTIO_VGA=3Dy
-  ...snip...
+default-configs/aarch64-softmmu.mak has:
+
+  include arm-softmmu.mak
+  CONFIG_XLNX_ZYNQMP_ARM=3Dy
+  CONFIG_XLNX_VERSAL=3Dy
=20
 These files rarely need changing unless new devices / hardware need to
 be enabled for a particular system/userspace emulation target
--=20
2.20.1


