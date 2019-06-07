Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5283C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B16E207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B16E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIZO-0007zu-QA
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzz-0003Yu-T7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGwT-0000xS-9L
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGwR-0000lW-4l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21F5E30C34C2;
 Fri,  7 Jun 2019 15:37:53 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0506018417;
 Fri,  7 Jun 2019 15:37:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:00 +0200
Message-Id: <20190607153725.18055-5-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 15:37:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 04/29] !fixup target/rx: CPU definition
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/rx/cpu.c | 22 ++++++++++++++--------
 target/rx/cpu.h | 12 ++++++------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 4b96f2e463..3c43467534 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -153,7 +153,7 @@ static void rx_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
=20
-static void rxcpu_class_init(ObjectClass *klass, void *data)
+static void rx_cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     CPUClass *cc =3D CPU_CLASS(klass);
@@ -181,22 +181,28 @@ static void rxcpu_class_init(ObjectClass *klass, vo=
id *data)
     cc->gdb_num_core_regs =3D 26;
 }
=20
-static const TypeInfo rxcpu_info =3D {
-    .name =3D TYPE_RXCPU,
+static const TypeInfo rx_cpu_info =3D {
+    .name =3D TYPE_RX_CPU,
     .parent =3D TYPE_CPU,
     .instance_size =3D sizeof(RXCPU),
     .instance_init =3D rx_cpu_init,
-    .abstract =3D false,
+    .abstract =3D true,
     .class_size =3D sizeof(RXCPUClass),
-    .class_init =3D rxcpu_class_init,
+    .class_init =3D rx_cpu_class_init,
 };
=20
-static void rxcpu_register_types(void)
+static const TypeInfo rx62n_rx_cpu_info =3D {
+    .name =3D RX_CPU_TYPE_NAME("rx62n"),
+    .parent =3D TYPE_RX_CPU,
+};
+
+static void rx_cpu_register_types(void)
 {
-    type_register_static(&rxcpu_info);
+    type_register_static(&rx_cpu_info);
+    type_register_static(&rx62n_rx_cpu_info);
 }
=20
-type_init(rxcpu_register_types)
+type_init(rx_cpu_register_types)
=20
 static uint32_t extable[32];
=20
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 8c1a4e448d..a0b6975963 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,14 +24,14 @@
 #include "hw/registerfields.h"
 #include "qom/cpu.h"
=20
-#define TYPE_RXCPU "rxcpu"
+#define TYPE_RX_CPU "rx-cpu"
=20
 #define RXCPU_CLASS(klass)                                     \
-    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RXCPU)
+    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
 #define RXCPU(obj) \
-    OBJECT_CHECK(RXCPU, (obj), TYPE_RXCPU)
+    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
 #define RXCPU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RXCPU)
+    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
=20
 /*
  * RXCPUClass:
@@ -164,9 +164,9 @@ static inline RXCPU *rx_env_get_cpu(CPURXState *env)
=20
 #define ENV_OFFSET offsetof(RXCPU, env)
=20
-#define RX_CPU_TYPE_SUFFIX "-" TYPE_RXCPU
+#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
 #define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_RXCPU
+#define CPU_RESOLVING_TYPE TYPE_RX_CPU
=20
 extern const char rx_crname[][6];
=20
--=20
2.20.1


