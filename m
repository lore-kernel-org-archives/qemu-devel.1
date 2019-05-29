Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC351C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B632023430
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B632023430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55081 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzEE-0002gg-Ud
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:06:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVzCu-00021o-7w
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVzCt-00063T-6r
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hVzCt-0005pN-1M; Wed, 29 May 2019 10:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E359C0AD292;
	Wed, 29 May 2019 14:05:10 +0000 (UTC)
Received: from x1w.bcn.redhat.com (unknown [10.32.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DC1611AD;
	Wed, 29 May 2019 14:05:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 16:05:04 +0200
Message-Id: <20190529140504.21580-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 29 May 2019 14:05:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] docs/devel/build-system: Update an example
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: rephrased the sentence using Thomas suggestion
---
 docs/devel/build-system.txt | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index addd274eeb..41bd08ea3a 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -413,18 +413,13 @@ context.
 - default-configs/*.mak
=20
 The files under default-configs/ control what emulated hardware is built
-into each QEMU system and userspace emulator targets. They merely
-contain a long list of config variable definitions. For example,
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
+into each QEMU system and userspace emulator targets. They merely contai=
n
+a list of config variable definitions like the machines that should be
+included. For example, default-configs/aarch64-softmmu.mak has:
+
+  include arm-softmmu.mak
+  CONFIG_XLNX_ZYNQMP_ARM=3Dy
+  CONFIG_XLNX_VERSAL=3Dy
=20
 These files rarely need changing unless new devices / hardware need to
 be enabled for a particular system/userspace emulation target
--=20
2.20.1


