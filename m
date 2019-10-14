Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07CECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF48B22468
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF48B22468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1VA-0005fn-Bh
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iK1OA-0005it-J2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iK1O9-0002jm-DA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iK1O1-0002ev-1h; Mon, 14 Oct 2019 10:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F7D63086211;
 Mon, 14 Oct 2019 14:31:48 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5E7600CD;
 Mon, 14 Oct 2019 14:31:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 18/20] hw/i386: Include "hw/mem/nvdimm.h"
Date: Mon, 14 Oct 2019 16:22:44 +0200
Message-Id: <20191014142246.4538-19-philmd@redhat.com>
In-Reply-To: <20191014142246.4538-1-philmd@redhat.com>
References: <20191014142246.4538-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 14 Oct 2019 14:31:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All this files use methods/definitions declared in the NVDIMM
device header. Include it.

This fixes (when modifying unrelated headers):

  hw/i386/acpi-build.c:2733:9: error: implicit declaration of function 'n=
vdimm_build_acpi' is invalid in C99 [-Werror,-Wimplicit-function-declarat=
ion]
        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
        ^
  hw/i386/pc.c:1996:61: error: use of undeclared identifier 'TYPE_NVDIMM'
    const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM=
);
                                                            ^
  hw/i386/pc.c:2032:55: error: use of undeclared identifier 'TYPE_NVDIMM'
    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
                                                      ^
  hw/i386/pc.c:2040:9: error: implicit declaration of function 'nvdimm_pl=
ug' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2040:9: error: this function declaration is not a prototyp=
e [-Werror,-Wstrict-prototypes]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2065:42: error: use of undeclared identifier 'TYPE_NVDIMM'
    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
                                         ^
  hw/i386/pc_i440fx.c:307:9: error: implicit declaration of function 'nvd=
imm_init_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-decla=
ration]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^
  hw/i386/pc_q35.c:332:9: error: implicit declaration of function 'nvdimm=
_init_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-declarat=
ion]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4e0f9f425a..ac46936f63 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -48,6 +48,7 @@
 #include "hw/timer/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bcda50efcc..cff330802d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,6 +73,7 @@
 #include "hw/boards.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6824b72124..8651b6e2ec 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -58,6 +58,7 @@
 #include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
=20
 #define MAX_IDE_BUS 2
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f314..91ba231ef1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
=20
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
--=20
2.21.0


