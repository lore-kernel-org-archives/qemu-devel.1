Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B12C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA482080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iUHJwWAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA482080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV5k-0001wG-Bl
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxP-0002UJ-No
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxO-0002bb-2r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:39 -0500
Received: from ozlabs.org ([203.11.71.1]:33671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxN-0002Uv-MW; Mon, 03 Feb 2020 01:11:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBn57ZKz9sST; Mon,  3 Feb 2020 17:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710289;
 bh=0PDGeHNNFly2LX5qs4wnsyQKICr3TyHxGxrkZ3zjoiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iUHJwWAplNOHRDyFgaEdUtgWIG6MOeCbIK097pVRNARsxI02MJg9THsLAkKWjkUGh
 +xgs0V14S9EX9ILaEMde3cgFm9KQXDkEldJjOtnkzraeMju8XbpW1hYlqnpeR4gSba
 E+vk5rWW5Q1LhLUVZQFRydzBZ1sm8DGPM34ywgJ0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/35] ppc/pnv: remove useless "core-pir" property alias.
Date: Mon,  3 Feb 2020 17:10:59 +1100
Message-Id: <20200203061123.59150-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Commit 158e17a65e1a ("ppc/pnv: Link "chip" property to PnvCore::chip
pointer") introduced some cleanups of the PnvCore realize handler.
Let's continue by reworking a bit the interface of the PnvCore
handlers for the CPU threads. These changes make the "core-pir"
property alias unused. Remove it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200127144154.10170-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8ca5fbd1a9..5fe3f21e12 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -40,11 +40,11 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
     return cpu_type;
 }
=20
-static void pnv_core_cpu_reset(PowerPCCPU *cpu, PnvChip *chip)
+static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(pc->chip);
=20
     cpu_reset(cs);
=20
@@ -56,7 +56,7 @@ static void pnv_core_cpu_reset(PowerPCCPU *cpu, PnvChip=
 *chip)
     env->nip =3D 0x10;
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
=20
-    pcc->intc_reset(chip, cpu);
+    pcc->intc_reset(pc->chip, cpu);
 }
=20
 /*
@@ -162,14 +162,14 @@ static const MemoryRegionOps pnv_core_power9_xscom_=
ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_cpu_realize(PowerPCCPU *cpu, PnvChip *chip, Error *=
*errp)
+static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **e=
rrp)
 {
     CPUPPCState *env =3D &cpu->env;
     int core_pir;
     int thread_index =3D 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
     Error *local_err =3D NULL;
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(pc->chip);
=20
     object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
     if (local_err) {
@@ -177,13 +177,13 @@ static void pnv_core_cpu_realize(PowerPCCPU *cpu, P=
nvChip *chip, Error **errp)
         return;
     }
=20
-    pcc->intc_create(chip, cpu, &local_err);
+    pcc->intc_create(pc->chip, cpu, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
+    core_pir =3D object_property_get_uint(OBJECT(pc), "pir", &error_abor=
t);
=20
     /*
      * The PIR of a thread is the core PIR + the thread index. We will
@@ -203,7 +203,7 @@ static void pnv_core_reset(void *dev)
     int i;
=20
     for (i =3D 0; i < cc->nr_threads; i++) {
-        pnv_core_cpu_reset(pc->threads[i], pc->chip);
+        pnv_core_cpu_reset(pc, pc->threads[i]);
     }
 }
=20
@@ -231,8 +231,6 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
=20
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj, &error_abort);
-        object_property_add_alias(obj, "core-pir", OBJECT(pc),
-                                  "pir", &error_abort);
=20
         cpu->machine_data =3D g_new0(PnvCPUState, 1);
=20
@@ -240,7 +238,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        pnv_core_cpu_realize(pc->threads[j], pc->chip, &local_err);
+        pnv_core_cpu_realize(pc, pc->threads[j], &local_err);
         if (local_err) {
             goto err;
         }
@@ -263,12 +261,12 @@ err:
     error_propagate(errp, local_err);
 }
=20
-static void pnv_core_cpu_unrealize(PowerPCCPU *cpu, PnvChip *chip)
+static void pnv_core_cpu_unrealize(PnvCore *pc, PowerPCCPU *cpu)
 {
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(pc->chip);
=20
-    pcc->intc_destroy(chip, cpu);
+    pcc->intc_destroy(pc->chip, cpu);
     cpu_remove_sync(CPU(cpu));
     cpu->machine_data =3D NULL;
     g_free(pnv_cpu);
@@ -284,7 +282,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
     qemu_unregister_reset(pnv_core_reset, pc);
=20
     for (i =3D 0; i < cc->nr_threads; i++) {
-        pnv_core_cpu_unrealize(pc->threads[i], pc->chip);
+        pnv_core_cpu_unrealize(pc, pc->threads[i]);
     }
     g_free(pc->threads);
 }
--=20
2.24.1


