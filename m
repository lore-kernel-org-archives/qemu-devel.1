Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E20C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB9120868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIh1-00052Y-9N
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZH0Q-0003Yj-Ae
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZGls-0000ad-MY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZGlr-0008Vt-NJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C0663179B4B
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F7977FEAD
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AB37113861C; Fri,  7 Jun 2019 17:26:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 17:26:39 +0200
Message-Id: <20190607152646.4822-6-armbru@redhat.com>
In-Reply-To: <20190607152646.4822-1-armbru@redhat.com>
References: <20190607152646.4822-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 07 Jun 2019 15:26:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/12] Normalize position of header guard
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

This is the common header guard idiom:

    /*
     * File comment
     */

    #ifndef GUARD_SYMBOL_H
    #define GUARD_SYMBOL_H

    ... actual contents ...

    #endif

A few of our headers have some #include before the guard.
target/tilegx/spr_def_64.h has #ifndef __DOXYGEN__ outside the guard.
A few more have the #define elsewhere.

Change them to match the common idiom.  For spr_def_64.h, that means
dropping #ifndef __DOXYGEN__.  While there, rename guard symbols to
make scripts/clean-header-guards.pl happy.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190604181618.19980-2-armbru@redhat.com>
[Rebased with conflicts resolved automatically]
---
 crypto/ivgen-essiv.h              |  9 ++++-----
 crypto/ivgen-plain.h              |  5 ++---
 crypto/ivgen-plain64.h            |  9 ++++-----
 include/hw/arm/allwinner-a10.h    |  4 ++--
 include/hw/arm/omap.h             |  8 +++++---
 include/hw/arm/xlnx-zynqmp.h      |  2 +-
 include/hw/char/cadence_uart.h    |  2 +-
 include/hw/display/xlnx_dp.h      |  9 ++++-----
 include/hw/dma/xlnx-zynq-devcfg.h |  2 +-
 include/hw/net/cadence_gem.h      |  2 +-
 target/i386/whp-dispatch.h        |  7 +++----
 target/tilegx/spr_def_64.h        | 10 +++-------
 tests/io-channel-helpers.h        |  9 ++++-----
 13 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/crypto/ivgen-essiv.h b/crypto/ivgen-essiv.h
index f34dbab57b..6c35c0b5ab 100644
--- a/crypto/ivgen-essiv.h
+++ b/crypto/ivgen-essiv.h
@@ -15,14 +15,13 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
+#ifndef QCRYPTO_IVGEN_ESSIV_H
+#define QCRYPTO_IVGEN_ESSIV_H
+
 #include "ivgenpriv.h"
=20
-#ifndef QCRYPTO_IVGEN_ESSIV_H__
-#define QCRYPTO_IVGEN_ESSIV_H__
-
 extern struct QCryptoIVGenDriver qcrypto_ivgen_essiv;
=20
-#endif /* QCRYPTO_IVGEN_ESSIV_H__ */
+#endif /* QCRYPTO_IVGEN_ESSIV_H */
diff --git a/crypto/ivgen-plain.h b/crypto/ivgen-plain.h
index 16e1ae5b27..395501f693 100644
--- a/crypto/ivgen-plain.h
+++ b/crypto/ivgen-plain.h
@@ -15,14 +15,13 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
-#include "ivgenpriv.h"
-
 #ifndef QCRYPTO_IVGEN_PLAIN_H__
 #define QCRYPTO_IVGEN_PLAIN_H__
=20
+#include "ivgenpriv.h"
+
 extern struct QCryptoIVGenDriver qcrypto_ivgen_plain;
=20
 #endif /* QCRYPTO_IVGEN_PLAIN_H__ */
diff --git a/crypto/ivgen-plain64.h b/crypto/ivgen-plain64.h
index f8611bd705..0a20fd1fd8 100644
--- a/crypto/ivgen-plain64.h
+++ b/crypto/ivgen-plain64.h
@@ -15,14 +15,13 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
+#ifndef QCRYPTO_IVGEN_PLAIN64_H
+#define QCRYPTO_IVGEN_PLAIN64_H
+
 #include "ivgenpriv.h"
=20
-#ifndef QCRYPTO_IVGEN_PLAIN64_H__
-#define QCRYPTO_IVGEN_PLAIN64_H__
-
 extern struct QCryptoIVGenDriver qcrypto_ivgen_plain64;
=20
-#endif /* QCRYPTO_IVGEN_PLAIN64_H__ */
+#endif /* QCRYPTO_IVGEN_PLAIN64_H */
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index bbfbaf01c7..e99fe2ea2e 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,4 +1,5 @@
-#ifndef ALLWINNER_H_
+#ifndef HW_ARM_ALLWINNER_A10_H
+#define HW_ARM_ALLWINNER_A10_H
=20
 #include "qemu/error-report.h"
 #include "hw/char/serial.h"
@@ -37,5 +38,4 @@ typedef struct AwA10State {
     MemoryRegion sram_a;
 } AwA10State;
=20
-#define ALLWINNER_H_
 #endif
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 9de867daa4..d21e418242 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -16,9 +16,11 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef hw_omap_h
+
+#ifndef HW_ARM_OMAP_H
+#define HW_ARM_OMAP_H
+
 #include "exec/memory.h"
-# define hw_omap_h		"omap.h"
 #include "hw/irq.h"
 #include "hw/input/tsc2xxx.h"
 #include "target/arm/cpu-qom.h"
@@ -991,4 +993,4 @@ enum {
=20
 # define OMAP_MPUI_REG_MASK		0x000007ff
=20
-#endif /* hw_omap_h */
+#endif
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 1b17f13b0b..35804ea80a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -16,6 +16,7 @@
  */
=20
 #ifndef XLNX_ZYNQMP_H
+#define XLNX_ZYNQMP_H
=20
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gic.h"
@@ -113,5 +114,4 @@ typedef struct XlnxZynqMPState {
     bool has_rpu;
 }  XlnxZynqMPState;
=20
-#define XLNX_ZYNQMP_H
 #endif
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index 118e3f10de..e1cf33e94c 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -17,6 +17,7 @@
  */
=20
 #ifndef CADENCE_UART_H
+#define CADENCE_UART_H
=20
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
@@ -66,5 +67,4 @@ static inline DeviceState *cadence_uart_create(hwaddr a=
ddr,
     return dev;
 }
=20
-#define CADENCE_UART_H
 #endif
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index 45a805033a..ab0dd250cc 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -19,9 +19,11 @@
  *
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+#ifndef XLNX_DP_H
+#define XLNX_DP_H
+
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "hw/misc/auxbus.h"
@@ -33,9 +35,6 @@
 #include "hw/dma/xlnx_dpdma.h"
 #include "audio/audio.h"
=20
-#ifndef XLNX_DP_H
-#define XLNX_DP_H
-
 #define AUD_CHBUF_MAX_DEPTH                 (32 * KiB)
 #define MAX_QEMU_BUFFER_SIZE                (4 * KiB)
=20
@@ -107,4 +106,4 @@ typedef struct XlnxDPState {
 #define TYPE_XLNX_DP "xlnx.v-dp"
 #define XLNX_DP(obj) OBJECT_CHECK(XlnxDPState, (obj), TYPE_XLNX_DP)
=20
-#endif /* !XLNX_DP_H */
+#endif
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq=
-devcfg.h
index 9f5119a89a..1d3969d91f 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -25,6 +25,7 @@
  */
=20
 #ifndef XLNX_ZYNQ_DEVCFG_H
+#define XLNX_ZYNQ_DEVCFG_H
=20
 #include "hw/register.h"
 #include "hw/sysbus.h"
@@ -58,5 +59,4 @@ typedef struct XlnxZynqDevcfg {
     RegisterInfo regs_info[XLNX_ZYNQ_DEVCFG_R_MAX];
 } XlnxZynqDevcfg;
=20
-#define XLNX_ZYNQ_DEVCFG_H
 #endif
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 5426961d91..5c83036ade 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -23,6 +23,7 @@
  */
=20
 #ifndef CADENCE_GEM_H
+#define CADENCE_GEM_H
=20
 #define TYPE_CADENCE_GEM "cadence_gem"
 #define CADENCE_GEM(obj) OBJECT_CHECK(CadenceGEMState, (obj), TYPE_CADEN=
CE_GEM)
@@ -84,5 +85,4 @@ typedef struct CadenceGEMState {
     bool sar_active[4];
 } CadenceGEMState;
=20
-#define CADENCE_GEM_H
 #endif
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index a23fb33a29..23791fbb47 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -1,12 +1,11 @@
+#ifndef WHP_DISPATCH_H
+#define WHP_DISPATCH_H
+
 #include <windows.h>
=20
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
=20
-#ifndef WHP_DISPATCH_H
-#define WHP_DISPATCH_H
-
-
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID=
* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSi=
zeInBytes)) \
   X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
diff --git a/target/tilegx/spr_def_64.h b/target/tilegx/spr_def_64.h
index 67a6c1751e..d3c0cc26d8 100644
--- a/target/tilegx/spr_def_64.h
+++ b/target/tilegx/spr_def_64.h
@@ -12,10 +12,8 @@
  *   more details.
  */
=20
-#ifndef __DOXYGEN__
-
-#ifndef __ARCH_SPR_DEF_64_H__
-#define __ARCH_SPR_DEF_64_H__
+#ifndef ARCH_SPR_DEF_64_H
+#define ARCH_SPR_DEF_64_H
=20
 #define SPR_AUX_PERF_COUNT_0 0x2105
 #define SPR_AUX_PERF_COUNT_1 0x2106
@@ -211,6 +209,4 @@
 #define SPR_WATCH_MASK 0x200a
 #define SPR_WATCH_VAL 0x200b
=20
-#endif /* !defined(__ARCH_SPR_DEF_64_H__) */
-
-#endif /* !defined(__DOXYGEN__) */
+#endif
diff --git a/tests/io-channel-helpers.h b/tests/io-channel-helpers.h
index fedc64fd5a..bb2de6fbb9 100644
--- a/tests/io-channel-helpers.h
+++ b/tests/io-channel-helpers.h
@@ -15,14 +15,13 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
+#ifndef TEST_IO_CHANNEL_HELPERS_H
+#define TEST_IO_CHANNEL_HELPERS_H
+
 #include "io/channel.h"
=20
-#ifndef TEST_IO_CHANNEL_HELPERS
-#define TEST_IO_CHANNEL_HELPERS
-
 typedef struct QIOChannelTest QIOChannelTest;
=20
 QIOChannelTest *qio_channel_test_new(void);
@@ -39,4 +38,4 @@ void qio_channel_test_run_reader(QIOChannelTest *test,
=20
 void qio_channel_test_validate(QIOChannelTest *test);
=20
-#endif /* TEST_IO_CHANNEL_HELPERS */
+#endif /* TEST_IO_CHANNEL_HELPERS_H */
--=20
2.21.0


