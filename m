Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE55CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C487921D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C487921D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45269 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKXD-0005DD-0h
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3G-0000yX-IP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3F-0008LQ-8I
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK3E-0008K4-Ur; Mon, 09 Mar 2020 11:10:41 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MmU9X-1jcAWf2W4v-00iV3H; Mon, 09 Mar 2020 16:09:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] hw/i386: Include "hw/mem/nvdimm.h"
Date: Mon,  9 Mar 2020 16:08:27 +0100
Message-Id: <20200309150837.3193387-24-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TeOo2QGtI6FU3p+t4iCnFPucQ9S2/xdWEQWUVjy9s/wGECS+B4n
 eir1zyf2Xl0ARL5I4ecMB5821XyXYnTfAdcoKGaHe2zX0I3dT7d2jnvt2EQijlPWAkWeCwO
 sha01a66gJdVsEL0PLk85CYyKKBQ2qVNBZeAzo3afuMDAUPJ6qoSufpqHH2Uka8ZxGzzGgM
 QxoffWr4TuEDYEYJJVcIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d50JJqTWXEY=:RapBcy9gldB8S7HBVp4kNA
 apk4Jry21kxu/kda90alx98CECOsZPUyr2xise488MFPhcYnEhFvEKTPcIxP3eZnNlDsilw6E
 Yfy4Dx25nGDDZJwgYab1Z2h1mMK+PgSCUr/jFnQsz/iN3PXiamUNH88QKfuqRjNCLpLECN+K0
 33Uqf8lHAXdPv8vsnK95dJUBLxtl2PIwc5zk5yLmoSiAVA8LJ4f3N5hR8OzCYlx1TJfqOnq8Y
 460osTJwYwiBidEL2apuIU8shSaFFPh1ujaDLPI2XyIxLik5d2wlnpjt2o6S43o6bdSooZcH1
 VcNe0GES9qyGlgF091C4phv+Mfrf5zB2m4bEK4ahj5ureJYf2F1X4HKaVG2yb3gCjiqBFBeLr
 6C22GLKr0jJyzIfBC3hcAgjzKDkcJhQkpS6Ep/TOW0HhJKo3IlAPuxv78cCR449dutHLI/jFQ
 6s3h7dYps7vxGU29hnpK2RKc5tH8TCD5ZNCHva3zSRWp4idmsiC6sgYkaEWh2qh62NnJSCusY
 M+Ym7qWDyvWP+PfL2X64EPBDDmDYnxs+X5BlyBkRLUMpLiRff/Y4wMUEm2S9++oDF4UliGwzw
 GbJkwciQDE29d7Jx5YmDP+vMOJxhAxLf3iMMck7a4szjh0L8wl4ZT/Yf045Jr/K2X+NKhTk7r
 cAAGNjXShBk/uRy4UU+vkm6qq+gKzB0dKxeyxIMPFN286Zww72HyZo1tqZVsSfTVYqJp4UgjS
 6/eC0p9yl6Qv5gRKdfg5HeL/W/bAK5NWyhCwDwd/SRilnS4FeXhC/+HkKhCdSnDEuBrv2I4Vh
 SvWbdZ4/MRb0MypasSzA7XMD6Cu4wQRt6JXRiuD+/0a3gzasat1gdAcHrJgTlMqA2ML0S1S
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All this files use methods/definitions declared in the NVDIMM
device header. Include it.

This fixes (when modifying unrelated headers):

  hw/i386/acpi-build.c:2733:9: error: implicit declaration of function 'nvdimm_build_acpi' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
        ^
  hw/i386/pc.c:1996:61: error: use of undeclared identifier 'TYPE_NVDIMM'
    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
                                                            ^
  hw/i386/pc.c:2032:55: error: use of undeclared identifier 'TYPE_NVDIMM'
    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
                                                      ^
  hw/i386/pc.c:2040:9: error: implicit declaration of function 'nvdimm_plug' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2040:9: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2065:42: error: use of undeclared identifier 'TYPE_NVDIMM'
    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
                                         ^
  hw/i386/pc_i440fx.c:307:9: error: implicit declaration of function 'nvdimm_init_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^
  hw/i386/pc_q35.c:332:9: error: implicit declaration of function 'nvdimm_init_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-17-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/acpi-build.c | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 26777f882844..9a19c14e661b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -47,6 +47,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6ab4acb0c62e..362eb2a180ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -76,6 +76,7 @@
 #include "hw/boards.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9088db8fb601..e2d98243bc64 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -60,6 +60,7 @@
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
 
 #define MAX_IDE_BUS 2
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 84cf925cf43a..d37c425e2236 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
-- 
2.24.1


