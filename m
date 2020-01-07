Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B7C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3822087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1KZadoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3822087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouL9-00088D-5y
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iouEL-0005yI-P1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iouEH-00009T-U5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iouDo-0008EH-0s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcxozyIexC4gXIzb1NYerEzPIzto2BCpVKOWg2GEmrs=;
 b=A1KZadoJPOpxtNSX+Khd9jl4IMESQCKHOPZRfHpAfjU5S2s6hNDeEcawcGBHbXBg9Blvxx
 b1AusESHKQ+z/pdguJYFMhBA5pVwNAt+OxNzzSzFR4naN/T1KgxYYi1J5gFo1BkhQfotbs
 Y+MJLm0cwRer5yVt5xxUDTm5AsGC3oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-EltzAJYxMxCCPq0nflEKFg-1; Tue, 07 Jan 2020 14:08:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A188C8045FF;
 Tue,  7 Jan 2020 19:08:52 +0000 (UTC)
Received: from thuth.com (ovpn-116-83.ams2.redhat.com [10.36.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9A16CE40;
 Tue,  7 Jan 2020 19:08:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/8] tests/libqos: Move the libqos files under tests/qtest/
Date: Tue,  7 Jan 2020 20:08:01 +0100
Message-Id: <20200107190802.2257-8-thuth@redhat.com>
In-Reply-To: <20200107190802.2257-1-thuth@redhat.com>
References: <20200107190802.2257-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EltzAJYxMxCCPq0nflEKFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qos stuff belongs to qtest, so move it into that directory, too.

Message-Id: <20191218103059.11729-8-thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  9 +--
 configure                                     |  4 +-
 tests/Makefile.include                        |  2 +-
 tests/qtest/Makefile.include                  | 80 +++++++++----------
 .../libqos/aarch64-xlnx-zcu102-machine.c      |  0
 tests/{ =3D> qtest}/libqos/ahci.c               |  0
 tests/{ =3D> qtest}/libqos/ahci.h               |  0
 .../libqos/arm-imx25-pdk-machine.c            |  0
 tests/{ =3D> qtest}/libqos/arm-n800-machine.c   |  0
 tests/{ =3D> qtest}/libqos/arm-raspi2-machine.c |  0
 .../libqos/arm-sabrelite-machine.c            |  0
 .../{ =3D> qtest}/libqos/arm-smdkc210-machine.c |  0
 tests/{ =3D> qtest}/libqos/arm-virt-machine.c   |  0
 .../libqos/arm-xilinx-zynq-a9-machine.c       |  0
 tests/{ =3D> qtest}/libqos/e1000e.c             |  0
 tests/{ =3D> qtest}/libqos/e1000e.h             |  0
 tests/{ =3D> qtest}/libqos/fw_cfg.c             |  0
 tests/{ =3D> qtest}/libqos/fw_cfg.h             |  0
 tests/{ =3D> qtest}/libqos/i2c-imx.c            |  0
 tests/{ =3D> qtest}/libqos/i2c-omap.c           |  0
 tests/{ =3D> qtest}/libqos/i2c.c                |  0
 tests/{ =3D> qtest}/libqos/i2c.h                |  0
 tests/{ =3D> qtest}/libqos/libqos-pc.c          |  0
 tests/{ =3D> qtest}/libqos/libqos-pc.h          |  0
 tests/{ =3D> qtest}/libqos/libqos-spapr.c       |  0
 tests/{ =3D> qtest}/libqos/libqos-spapr.h       |  0
 tests/{ =3D> qtest}/libqos/libqos.c             |  0
 tests/{ =3D> qtest}/libqos/libqos.h             |  0
 tests/{ =3D> qtest}/libqos/malloc-pc.c          |  0
 tests/{ =3D> qtest}/libqos/malloc-pc.h          |  0
 tests/{ =3D> qtest}/libqos/malloc-spapr.c       |  0
 tests/{ =3D> qtest}/libqos/malloc-spapr.h       |  0
 tests/{ =3D> qtest}/libqos/malloc.c             |  0
 tests/{ =3D> qtest}/libqos/malloc.h             |  0
 tests/{ =3D> qtest}/libqos/pci-pc.c             |  0
 tests/{ =3D> qtest}/libqos/pci-pc.h             |  0
 tests/{ =3D> qtest}/libqos/pci-spapr.c          |  0
 tests/{ =3D> qtest}/libqos/pci-spapr.h          |  0
 tests/{ =3D> qtest}/libqos/pci.c                |  0
 tests/{ =3D> qtest}/libqos/pci.h                |  0
 .../libqos/ppc64_pseries-machine.c            |  0
 tests/{ =3D> qtest}/libqos/qgraph.c             |  0
 tests/{ =3D> qtest}/libqos/qgraph.h             |  0
 tests/{ =3D> qtest}/libqos/qgraph_internal.h    |  0
 tests/{ =3D> qtest}/libqos/rtas.c               |  0
 tests/{ =3D> qtest}/libqos/rtas.h               |  0
 tests/{ =3D> qtest}/libqos/sdhci.c              |  0
 tests/{ =3D> qtest}/libqos/sdhci.h              |  0
 tests/{ =3D> qtest}/libqos/tpci200.c            |  0
 tests/{ =3D> qtest}/libqos/usb.c                |  0
 tests/{ =3D> qtest}/libqos/usb.h                |  0
 tests/{ =3D> qtest}/libqos/virtio-9p.c          |  0
 tests/{ =3D> qtest}/libqos/virtio-9p.h          |  0
 tests/{ =3D> qtest}/libqos/virtio-balloon.c     |  0
 tests/{ =3D> qtest}/libqos/virtio-balloon.h     |  0
 tests/{ =3D> qtest}/libqos/virtio-blk.c         |  0
 tests/{ =3D> qtest}/libqos/virtio-blk.h         |  0
 tests/{ =3D> qtest}/libqos/virtio-mmio.c        |  0
 tests/{ =3D> qtest}/libqos/virtio-mmio.h        |  0
 tests/{ =3D> qtest}/libqos/virtio-net.c         |  0
 tests/{ =3D> qtest}/libqos/virtio-net.h         |  0
 tests/{ =3D> qtest}/libqos/virtio-pci-modern.c  |  0
 tests/{ =3D> qtest}/libqos/virtio-pci-modern.h  |  0
 tests/{ =3D> qtest}/libqos/virtio-pci.c         |  0
 tests/{ =3D> qtest}/libqos/virtio-pci.h         |  0
 tests/{ =3D> qtest}/libqos/virtio-rng.c         |  0
 tests/{ =3D> qtest}/libqos/virtio-rng.h         |  0
 tests/{ =3D> qtest}/libqos/virtio-scsi.c        |  0
 tests/{ =3D> qtest}/libqos/virtio-scsi.h        |  0
 tests/{ =3D> qtest}/libqos/virtio-serial.c      |  0
 tests/{ =3D> qtest}/libqos/virtio-serial.h      |  0
 tests/{ =3D> qtest}/libqos/virtio.c             |  0
 tests/{ =3D> qtest}/libqos/virtio.h             |  0
 tests/{ =3D> qtest}/libqos/x86_64_pc-machine.c  |  0
 74 files changed, 47 insertions(+), 48 deletions(-)
 rename tests/{ =3D> qtest}/libqos/aarch64-xlnx-zcu102-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/ahci.c (100%)
 rename tests/{ =3D> qtest}/libqos/ahci.h (100%)
 rename tests/{ =3D> qtest}/libqos/arm-imx25-pdk-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-n800-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-raspi2-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-sabrelite-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-smdkc210-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-virt-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/arm-xilinx-zynq-a9-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/e1000e.c (100%)
 rename tests/{ =3D> qtest}/libqos/e1000e.h (100%)
 rename tests/{ =3D> qtest}/libqos/fw_cfg.c (100%)
 rename tests/{ =3D> qtest}/libqos/fw_cfg.h (100%)
 rename tests/{ =3D> qtest}/libqos/i2c-imx.c (100%)
 rename tests/{ =3D> qtest}/libqos/i2c-omap.c (100%)
 rename tests/{ =3D> qtest}/libqos/i2c.c (100%)
 rename tests/{ =3D> qtest}/libqos/i2c.h (100%)
 rename tests/{ =3D> qtest}/libqos/libqos-pc.c (100%)
 rename tests/{ =3D> qtest}/libqos/libqos-pc.h (100%)
 rename tests/{ =3D> qtest}/libqos/libqos-spapr.c (100%)
 rename tests/{ =3D> qtest}/libqos/libqos-spapr.h (100%)
 rename tests/{ =3D> qtest}/libqos/libqos.c (100%)
 rename tests/{ =3D> qtest}/libqos/libqos.h (100%)
 rename tests/{ =3D> qtest}/libqos/malloc-pc.c (100%)
 rename tests/{ =3D> qtest}/libqos/malloc-pc.h (100%)
 rename tests/{ =3D> qtest}/libqos/malloc-spapr.c (100%)
 rename tests/{ =3D> qtest}/libqos/malloc-spapr.h (100%)
 rename tests/{ =3D> qtest}/libqos/malloc.c (100%)
 rename tests/{ =3D> qtest}/libqos/malloc.h (100%)
 rename tests/{ =3D> qtest}/libqos/pci-pc.c (100%)
 rename tests/{ =3D> qtest}/libqos/pci-pc.h (100%)
 rename tests/{ =3D> qtest}/libqos/pci-spapr.c (100%)
 rename tests/{ =3D> qtest}/libqos/pci-spapr.h (100%)
 rename tests/{ =3D> qtest}/libqos/pci.c (100%)
 rename tests/{ =3D> qtest}/libqos/pci.h (100%)
 rename tests/{ =3D> qtest}/libqos/ppc64_pseries-machine.c (100%)
 rename tests/{ =3D> qtest}/libqos/qgraph.c (100%)
 rename tests/{ =3D> qtest}/libqos/qgraph.h (100%)
 rename tests/{ =3D> qtest}/libqos/qgraph_internal.h (100%)
 rename tests/{ =3D> qtest}/libqos/rtas.c (100%)
 rename tests/{ =3D> qtest}/libqos/rtas.h (100%)
 rename tests/{ =3D> qtest}/libqos/sdhci.c (100%)
 rename tests/{ =3D> qtest}/libqos/sdhci.h (100%)
 rename tests/{ =3D> qtest}/libqos/tpci200.c (100%)
 rename tests/{ =3D> qtest}/libqos/usb.c (100%)
 rename tests/{ =3D> qtest}/libqos/usb.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-9p.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-9p.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-balloon.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-balloon.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-blk.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-blk.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-mmio.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-mmio.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-net.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-net.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-pci-modern.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-pci-modern.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-pci.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-pci.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-rng.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-rng.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-scsi.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-scsi.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-serial.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio-serial.h (100%)
 rename tests/{ =3D> qtest}/libqos/virtio.c (100%)
 rename tests/{ =3D> qtest}/libqos/virtio.h (100%)
 rename tests/{ =3D> qtest}/libqos/x86_64_pc-machine.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43732c27d8..5998c9a0aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1102,9 +1102,9 @@ F: pc-bios/slof.bin
 F: docs/specs/ppc-spapr-hcalls.txt
 F: docs/specs/ppc-spapr-hotplug.txt
 F: tests/qtest/spapr*
-F: tests/libqos/*spapr*
+F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
-F: tests/libqos/rtas*
+F: tests/qtest/libqos/rtas*
=20
 PowerNV (Non-Virtualized)
 M: C=C3=A9dric Le Goater <clg@kaod.org>
@@ -1363,7 +1363,7 @@ F: hw/block/hd-geometry.c
 F: tests/qtest/ide-test.c
 F: tests/qtest/ahci-test.c
 F: tests/qtest/cdrom-test.c
-F: tests/libqos/ahci*
+F: tests/qtest/libqos/ahci*
 T: git https://github.com/jnsnow/qemu.git ide
=20
 IPMI
@@ -1776,7 +1776,7 @@ F: hw/nvram/fw_cfg.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
-F: tests/libqos/fw_cfg.c
+F: tests/qtest/libqos/fw_cfg.c
 F: tests/qtest/fw_cfg-test.c
 T: git https://github.com/philmd/qemu.git fw_cfg-next
=20
@@ -2137,7 +2137,6 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: qtest.c
 F: accel/qtest.c
-F: tests/libqos/
 F: tests/qtest/
=20
 Register API
diff --git a/configure b/configure
index e690b05666..fdc5408c5b 100755
--- a/configure
+++ b/configure
@@ -7953,8 +7953,8 @@ fi
 # so the build tree will be missing the link back to the new file, and
 # tests might fail. Prefer to keep the relevant files in their own
 # directory and symlink the directory instead.
-DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema test=
s/qtest"
-DIRS=3D"$DIRS tests/qemu-iotests tests/vm tests/fp tests/qgraph"
+DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/qapi-schema tests/qtest/libqo=
s"
+DIRS=3D"$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgrap=
h"
 DIRS=3D"$DIRS docs docs/interop fsdev scsi"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 575e6e0850..4776ec4c8d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -897,6 +897,6 @@ all: $(QEMU_IOTESTS_HELPERS-y)
=20
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/qtest/*.d)
--include $(wildcard tests/libqos/*.d)
+-include $(wildcard tests/qtest/qos/*.d)
=20
 endif
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index d92d391fb8..dad836d311 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -148,52 +148,52 @@ check-qtest-s390x-y +=3D cpu-plug-test
 check-qtest-s390x-y +=3D migration-test
=20
 # libqos / qgraph :
-libqgraph-obj-y =3D tests/libqos/qgraph.o
-
-libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg=
.o
-libqos-obj-y +=3D tests/libqos/malloc.o
-libqos-obj-y +=3D tests/libqos/libqos.o
-libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
-libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
-libqos-spapr-obj-y +=3D tests/libqos/rtas.o
-libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
-libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
-libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
-libqos-pc-obj-y +=3D tests/libqos/ahci.o
-libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
+libqgraph-obj-y =3D tests/qtest/libqos/qgraph.o
+
+libqos-obj-y =3D $(libqgraph-obj-y) tests/qtest/libqos/pci.o tests/qtest/l=
ibqos/fw_cfg.o
+libqos-obj-y +=3D tests/qtest/libqos/malloc.o
+libqos-obj-y +=3D tests/qtest/libqos/libqos.o
+libqos-spapr-obj-y =3D $(libqos-obj-y) tests/qtest/libqos/malloc-spapr.o
+libqos-spapr-obj-y +=3D tests/qtest/libqos/libqos-spapr.o
+libqos-spapr-obj-y +=3D tests/qtest/libqos/rtas.o
+libqos-spapr-obj-y +=3D tests/qtest/libqos/pci-spapr.o
+libqos-pc-obj-y =3D $(libqos-obj-y) tests/qtest/libqos/pci-pc.o
+libqos-pc-obj-y +=3D tests/qtest/libqos/malloc-pc.o tests/qtest/libqos/lib=
qos-pc.o
+libqos-pc-obj-y +=3D tests/qtest/libqos/ahci.o
+libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/qtest/=
libqos/usb.o
=20
 # qos devices:
 qos-test-obj-y =3D tests/qtest/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y +=3D tests/libqos/e1000e.o
-qos-test-obj-y +=3D tests/libqos/i2c.o
-qos-test-obj-y +=3D tests/libqos/i2c-imx.o
-qos-test-obj-y +=3D tests/libqos/i2c-omap.o
-qos-test-obj-y +=3D tests/libqos/sdhci.o
-qos-test-obj-y +=3D tests/libqos/tpci200.o
-qos-test-obj-y +=3D tests/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
-qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
-qos-test-obj-y +=3D tests/libqos/virtio-blk.o
-qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
-qos-test-obj-y +=3D tests/libqos/virtio-net.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
-qos-test-obj-y +=3D tests/libqos/virtio-rng.o
-qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
-qos-test-obj-y +=3D tests/libqos/virtio-serial.o
+qos-test-obj-y +=3D tests/qtest/libqos/e1000e.o
+qos-test-obj-y +=3D tests/qtest/libqos/i2c.o
+qos-test-obj-y +=3D tests/qtest/libqos/i2c-imx.o
+qos-test-obj-y +=3D tests/qtest/libqos/i2c-omap.o
+qos-test-obj-y +=3D tests/qtest/libqos/sdhci.o
+qos-test-obj-y +=3D tests/qtest/libqos/tpci200.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio.o
+qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/libqos/virtio-9p.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-balloon.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-blk.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-mmio.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-net.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-pci.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-pci-modern.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-rng.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-scsi.o
+qos-test-obj-y +=3D tests/qtest/libqos/virtio-serial.o
=20
 # qos machines:
-qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
-qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-imx25-pdk-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-n800-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-raspi2-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-sabrelite-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-smdkc210-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-virt-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/ppc64_pseries-machine.o
+qos-test-obj-y +=3D tests/qtest/libqos/x86_64_pc-machine.o
=20
 # qos tests:
 qos-test-obj-y +=3D tests/qtest/ac97-test.o
diff --git a/tests/libqos/aarch64-xlnx-zcu102-machine.c b/tests/qtest/libqo=
s/aarch64-xlnx-zcu102-machine.c
similarity index 100%
rename from tests/libqos/aarch64-xlnx-zcu102-machine.c
rename to tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
diff --git a/tests/libqos/ahci.c b/tests/qtest/libqos/ahci.c
similarity index 100%
rename from tests/libqos/ahci.c
rename to tests/qtest/libqos/ahci.c
diff --git a/tests/libqos/ahci.h b/tests/qtest/libqos/ahci.h
similarity index 100%
rename from tests/libqos/ahci.h
rename to tests/qtest/libqos/ahci.h
diff --git a/tests/libqos/arm-imx25-pdk-machine.c b/tests/qtest/libqos/arm-=
imx25-pdk-machine.c
similarity index 100%
rename from tests/libqos/arm-imx25-pdk-machine.c
rename to tests/qtest/libqos/arm-imx25-pdk-machine.c
diff --git a/tests/libqos/arm-n800-machine.c b/tests/qtest/libqos/arm-n800-=
machine.c
similarity index 100%
rename from tests/libqos/arm-n800-machine.c
rename to tests/qtest/libqos/arm-n800-machine.c
diff --git a/tests/libqos/arm-raspi2-machine.c b/tests/qtest/libqos/arm-ras=
pi2-machine.c
similarity index 100%
rename from tests/libqos/arm-raspi2-machine.c
rename to tests/qtest/libqos/arm-raspi2-machine.c
diff --git a/tests/libqos/arm-sabrelite-machine.c b/tests/qtest/libqos/arm-=
sabrelite-machine.c
similarity index 100%
rename from tests/libqos/arm-sabrelite-machine.c
rename to tests/qtest/libqos/arm-sabrelite-machine.c
diff --git a/tests/libqos/arm-smdkc210-machine.c b/tests/qtest/libqos/arm-s=
mdkc210-machine.c
similarity index 100%
rename from tests/libqos/arm-smdkc210-machine.c
rename to tests/qtest/libqos/arm-smdkc210-machine.c
diff --git a/tests/libqos/arm-virt-machine.c b/tests/qtest/libqos/arm-virt-=
machine.c
similarity index 100%
rename from tests/libqos/arm-virt-machine.c
rename to tests/qtest/libqos/arm-virt-machine.c
diff --git a/tests/libqos/arm-xilinx-zynq-a9-machine.c b/tests/qtest/libqos=
/arm-xilinx-zynq-a9-machine.c
similarity index 100%
rename from tests/libqos/arm-xilinx-zynq-a9-machine.c
rename to tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
diff --git a/tests/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
similarity index 100%
rename from tests/libqos/e1000e.c
rename to tests/qtest/libqos/e1000e.c
diff --git a/tests/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
similarity index 100%
rename from tests/libqos/e1000e.h
rename to tests/qtest/libqos/e1000e.h
diff --git a/tests/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
similarity index 100%
rename from tests/libqos/fw_cfg.c
rename to tests/qtest/libqos/fw_cfg.c
diff --git a/tests/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
similarity index 100%
rename from tests/libqos/fw_cfg.h
rename to tests/qtest/libqos/fw_cfg.h
diff --git a/tests/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx.c
similarity index 100%
rename from tests/libqos/i2c-imx.c
rename to tests/qtest/libqos/i2c-imx.c
diff --git a/tests/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.c
similarity index 100%
rename from tests/libqos/i2c-omap.c
rename to tests/qtest/libqos/i2c-omap.c
diff --git a/tests/libqos/i2c.c b/tests/qtest/libqos/i2c.c
similarity index 100%
rename from tests/libqos/i2c.c
rename to tests/qtest/libqos/i2c.c
diff --git a/tests/libqos/i2c.h b/tests/qtest/libqos/i2c.h
similarity index 100%
rename from tests/libqos/i2c.h
rename to tests/qtest/libqos/i2c.h
diff --git a/tests/libqos/libqos-pc.c b/tests/qtest/libqos/libqos-pc.c
similarity index 100%
rename from tests/libqos/libqos-pc.c
rename to tests/qtest/libqos/libqos-pc.c
diff --git a/tests/libqos/libqos-pc.h b/tests/qtest/libqos/libqos-pc.h
similarity index 100%
rename from tests/libqos/libqos-pc.h
rename to tests/qtest/libqos/libqos-pc.h
diff --git a/tests/libqos/libqos-spapr.c b/tests/qtest/libqos/libqos-spapr.=
c
similarity index 100%
rename from tests/libqos/libqos-spapr.c
rename to tests/qtest/libqos/libqos-spapr.c
diff --git a/tests/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.=
h
similarity index 100%
rename from tests/libqos/libqos-spapr.h
rename to tests/qtest/libqos/libqos-spapr.h
diff --git a/tests/libqos/libqos.c b/tests/qtest/libqos/libqos.c
similarity index 100%
rename from tests/libqos/libqos.c
rename to tests/qtest/libqos/libqos.c
diff --git a/tests/libqos/libqos.h b/tests/qtest/libqos/libqos.h
similarity index 100%
rename from tests/libqos/libqos.h
rename to tests/qtest/libqos/libqos.h
diff --git a/tests/libqos/malloc-pc.c b/tests/qtest/libqos/malloc-pc.c
similarity index 100%
rename from tests/libqos/malloc-pc.c
rename to tests/qtest/libqos/malloc-pc.c
diff --git a/tests/libqos/malloc-pc.h b/tests/qtest/libqos/malloc-pc.h
similarity index 100%
rename from tests/libqos/malloc-pc.h
rename to tests/qtest/libqos/malloc-pc.h
diff --git a/tests/libqos/malloc-spapr.c b/tests/qtest/libqos/malloc-spapr.=
c
similarity index 100%
rename from tests/libqos/malloc-spapr.c
rename to tests/qtest/libqos/malloc-spapr.c
diff --git a/tests/libqos/malloc-spapr.h b/tests/qtest/libqos/malloc-spapr.=
h
similarity index 100%
rename from tests/libqos/malloc-spapr.h
rename to tests/qtest/libqos/malloc-spapr.h
diff --git a/tests/libqos/malloc.c b/tests/qtest/libqos/malloc.c
similarity index 100%
rename from tests/libqos/malloc.c
rename to tests/qtest/libqos/malloc.c
diff --git a/tests/libqos/malloc.h b/tests/qtest/libqos/malloc.h
similarity index 100%
rename from tests/libqos/malloc.h
rename to tests/qtest/libqos/malloc.h
diff --git a/tests/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
similarity index 100%
rename from tests/libqos/pci-pc.c
rename to tests/qtest/libqos/pci-pc.c
diff --git a/tests/libqos/pci-pc.h b/tests/qtest/libqos/pci-pc.h
similarity index 100%
rename from tests/libqos/pci-pc.h
rename to tests/qtest/libqos/pci-pc.h
diff --git a/tests/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
similarity index 100%
rename from tests/libqos/pci-spapr.c
rename to tests/qtest/libqos/pci-spapr.c
diff --git a/tests/libqos/pci-spapr.h b/tests/qtest/libqos/pci-spapr.h
similarity index 100%
rename from tests/libqos/pci-spapr.h
rename to tests/qtest/libqos/pci-spapr.h
diff --git a/tests/libqos/pci.c b/tests/qtest/libqos/pci.c
similarity index 100%
rename from tests/libqos/pci.c
rename to tests/qtest/libqos/pci.c
diff --git a/tests/libqos/pci.h b/tests/qtest/libqos/pci.h
similarity index 100%
rename from tests/libqos/pci.h
rename to tests/qtest/libqos/pci.h
diff --git a/tests/libqos/ppc64_pseries-machine.c b/tests/qtest/libqos/ppc6=
4_pseries-machine.c
similarity index 100%
rename from tests/libqos/ppc64_pseries-machine.c
rename to tests/qtest/libqos/ppc64_pseries-machine.c
diff --git a/tests/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
similarity index 100%
rename from tests/libqos/qgraph.c
rename to tests/qtest/libqos/qgraph.c
diff --git a/tests/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
similarity index 100%
rename from tests/libqos/qgraph.h
rename to tests/qtest/libqos/qgraph.h
diff --git a/tests/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_int=
ernal.h
similarity index 100%
rename from tests/libqos/qgraph_internal.h
rename to tests/qtest/libqos/qgraph_internal.h
diff --git a/tests/libqos/rtas.c b/tests/qtest/libqos/rtas.c
similarity index 100%
rename from tests/libqos/rtas.c
rename to tests/qtest/libqos/rtas.c
diff --git a/tests/libqos/rtas.h b/tests/qtest/libqos/rtas.h
similarity index 100%
rename from tests/libqos/rtas.h
rename to tests/qtest/libqos/rtas.h
diff --git a/tests/libqos/sdhci.c b/tests/qtest/libqos/sdhci.c
similarity index 100%
rename from tests/libqos/sdhci.c
rename to tests/qtest/libqos/sdhci.c
diff --git a/tests/libqos/sdhci.h b/tests/qtest/libqos/sdhci.h
similarity index 100%
rename from tests/libqos/sdhci.h
rename to tests/qtest/libqos/sdhci.h
diff --git a/tests/libqos/tpci200.c b/tests/qtest/libqos/tpci200.c
similarity index 100%
rename from tests/libqos/tpci200.c
rename to tests/qtest/libqos/tpci200.c
diff --git a/tests/libqos/usb.c b/tests/qtest/libqos/usb.c
similarity index 100%
rename from tests/libqos/usb.c
rename to tests/qtest/libqos/usb.c
diff --git a/tests/libqos/usb.h b/tests/qtest/libqos/usb.h
similarity index 100%
rename from tests/libqos/usb.h
rename to tests/qtest/libqos/usb.h
diff --git a/tests/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
similarity index 100%
rename from tests/libqos/virtio-9p.c
rename to tests/qtest/libqos/virtio-9p.c
diff --git a/tests/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
similarity index 100%
rename from tests/libqos/virtio-9p.h
rename to tests/qtest/libqos/virtio-9p.h
diff --git a/tests/libqos/virtio-balloon.c b/tests/qtest/libqos/virtio-ball=
oon.c
similarity index 100%
rename from tests/libqos/virtio-balloon.c
rename to tests/qtest/libqos/virtio-balloon.c
diff --git a/tests/libqos/virtio-balloon.h b/tests/qtest/libqos/virtio-ball=
oon.h
similarity index 100%
rename from tests/libqos/virtio-balloon.h
rename to tests/qtest/libqos/virtio-balloon.h
diff --git a/tests/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
similarity index 100%
rename from tests/libqos/virtio-blk.c
rename to tests/qtest/libqos/virtio-blk.c
diff --git a/tests/libqos/virtio-blk.h b/tests/qtest/libqos/virtio-blk.h
similarity index 100%
rename from tests/libqos/virtio-blk.h
rename to tests/qtest/libqos/virtio-blk.h
diff --git a/tests/libqos/virtio-mmio.c b/tests/qtest/libqos/virtio-mmio.c
similarity index 100%
rename from tests/libqos/virtio-mmio.c
rename to tests/qtest/libqos/virtio-mmio.c
diff --git a/tests/libqos/virtio-mmio.h b/tests/qtest/libqos/virtio-mmio.h
similarity index 100%
rename from tests/libqos/virtio-mmio.h
rename to tests/qtest/libqos/virtio-mmio.h
diff --git a/tests/libqos/virtio-net.c b/tests/qtest/libqos/virtio-net.c
similarity index 100%
rename from tests/libqos/virtio-net.c
rename to tests/qtest/libqos/virtio-net.c
diff --git a/tests/libqos/virtio-net.h b/tests/qtest/libqos/virtio-net.h
similarity index 100%
rename from tests/libqos/virtio-net.h
rename to tests/qtest/libqos/virtio-net.h
diff --git a/tests/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-p=
ci-modern.c
similarity index 100%
rename from tests/libqos/virtio-pci-modern.c
rename to tests/qtest/libqos/virtio-pci-modern.c
diff --git a/tests/libqos/virtio-pci-modern.h b/tests/qtest/libqos/virtio-p=
ci-modern.h
similarity index 100%
rename from tests/libqos/virtio-pci-modern.h
rename to tests/qtest/libqos/virtio-pci-modern.h
diff --git a/tests/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
similarity index 100%
rename from tests/libqos/virtio-pci.c
rename to tests/qtest/libqos/virtio-pci.c
diff --git a/tests/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
similarity index 100%
rename from tests/libqos/virtio-pci.h
rename to tests/qtest/libqos/virtio-pci.h
diff --git a/tests/libqos/virtio-rng.c b/tests/qtest/libqos/virtio-rng.c
similarity index 100%
rename from tests/libqos/virtio-rng.c
rename to tests/qtest/libqos/virtio-rng.c
diff --git a/tests/libqos/virtio-rng.h b/tests/qtest/libqos/virtio-rng.h
similarity index 100%
rename from tests/libqos/virtio-rng.h
rename to tests/qtest/libqos/virtio-rng.h
diff --git a/tests/libqos/virtio-scsi.c b/tests/qtest/libqos/virtio-scsi.c
similarity index 100%
rename from tests/libqos/virtio-scsi.c
rename to tests/qtest/libqos/virtio-scsi.c
diff --git a/tests/libqos/virtio-scsi.h b/tests/qtest/libqos/virtio-scsi.h
similarity index 100%
rename from tests/libqos/virtio-scsi.h
rename to tests/qtest/libqos/virtio-scsi.h
diff --git a/tests/libqos/virtio-serial.c b/tests/qtest/libqos/virtio-seria=
l.c
similarity index 100%
rename from tests/libqos/virtio-serial.c
rename to tests/qtest/libqos/virtio-serial.c
diff --git a/tests/libqos/virtio-serial.h b/tests/qtest/libqos/virtio-seria=
l.h
similarity index 100%
rename from tests/libqos/virtio-serial.h
rename to tests/qtest/libqos/virtio-serial.h
diff --git a/tests/libqos/virtio.c b/tests/qtest/libqos/virtio.c
similarity index 100%
rename from tests/libqos/virtio.c
rename to tests/qtest/libqos/virtio.c
diff --git a/tests/libqos/virtio.h b/tests/qtest/libqos/virtio.h
similarity index 100%
rename from tests/libqos/virtio.h
rename to tests/qtest/libqos/virtio.h
diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/qtest/libqos/x86_64_p=
c-machine.c
similarity index 100%
rename from tests/libqos/x86_64_pc-machine.c
rename to tests/qtest/libqos/x86_64_pc-machine.c
--=20
2.18.1


