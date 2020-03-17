Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93643C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61372205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k5dWZuU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61372205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE975-0002oK-Hz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95X-0000kD-6e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95V-0001BZ-Gy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:43 -0400
Received: from ozlabs.org ([203.11.71.1]:60245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95U-0000Qk-VC; Tue, 17 Mar 2020 06:04:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKv4q2Kz9sRf; Tue, 17 Mar 2020 21:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439475;
 bh=uz03V/ru9X630/rRDbbXvWwKAd0CRMRYWvPqvXbXi8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k5dWZuU5jjvwnvN2Tbe2yr+UY6YRmWlkzyMAHmg5kCteGxfq+OOoZcrzOEfxfmMPW
 8r6+9ncCqrIHz4219ioGUh+5uUy6sOZwuTfxgyJV5juN/fGfEDsCHrSIEL/BGR4+ZO
 i2d2y0xYV0fVMVJRx3JQoWocYl/62g75LHLaJi4Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/45] ppc: Officially deprecate the CPU "compat" property
Date: Tue, 17 Mar 2020 21:03:41 +1100
Message-Id: <20200317100423.622643-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Server class POWER CPUs have a "compat" property, which was obsoleted
by commit 7843c0d60d and replaced by a "max-cpu-compat" property on the
pseries machine type. A hack was introduced so that passing "compat" to
-cpu would still produce the desired effect, for the sake of backward
compatibility : it strips the "compat" option from the CPU properties
and applies internally it to the pseries machine. The accessors of the
"compat" property were updated to do nothing but warn the user about the
deprecated status when doing something like:

$ qemu-system-ppc64 -global POWER9-family-powerpc64-cpu.compat=3Dpower9
qemu-system-ppc64: warning: CPU 'compat' property is deprecated and has n=
o
 effect; use max-cpu-compat machine property instead

This was merged during the QEMU 2.10 timeframe, a few weeks before we
formalized our deprecation process. As a consequence, the "compat"
property fell through the cracks and was never listed in the officialy
deprecated features.

We are now eight QEMU versions later, it is largely time to mention it
in qemu-deprecated.texi. Also, since -global XXX-powerpc64-cpu.compat=3D
has been emitting warnings since QEMU 2.10 and the usual way of setting
CPU properties is with -cpu, completely remove the "compat" property.
Keep the hack so that -cpu XXX,compat=3D stays functional some more time,
as required by our deprecation process.

The now empty powerpc_servercpu_properties[] list which was introduced
for "compat" and never had any other use is removed on the way. We can
re-add it in the future if the need for a server class POWER CPU specific
property arises again.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158274357799.140275.12263135811731647490.stgit@bahia.lan>
[dwg: Convert from .texi to .rst to match upstream change]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/system/deprecated.rst      |  7 ++++++
 target/ppc/translate_init.inc.c | 44 ++-------------------------------
 2 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0838338d8f..412b1b166d 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -289,6 +289,13 @@ The RISC-V no MMU cpus have been depcreated. The two=
 CPUs: ``rv32imacu-nommu`` a
 ``rv64imacu-nommu`` should no longer be used. Instead the MMU status can=
 be specified
 via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
=20
+``compat`` property of server class POWER CPUs (since 5.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``compat`` property used to set backwards compatibility modes for
+the processor has been deprecated. The ``max-cpu-compat`` property of
+the ``pseries`` machine type should be used instead.
+
 System emulator devices
 -----------------------
=20
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 53995f62ea..2f7125c51f 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8492,44 +8492,6 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *dat=
a)
     pcc->l1_icache_size =3D 0x10000;
 }
=20
-/*
- * The CPU used to have a "compat" property which set the
- * compatibility mode PVR.  However, this was conceptually broken - it
- * only makes sense on the pseries machine type (otherwise the guest
- * owns the PCR and can control the compatibility mode itself).  It's
- * been replaced with the 'max-cpu-compat' property on the pseries
- * machine type.  For backwards compatibility, pseries specially
- * parses the -cpu parameter and converts old compat=3D parameters into
- * the appropriate machine parameters.  This stub implementation of
- * the parameter catches any uses on explicitly created CPUs.
- */
-static void getset_compat_deprecated(Object *obj, Visitor *v, const char=
 *name,
-                                     void *opaque, Error **errp)
-{
-    QNull *null =3D NULL;
-
-    if (!qtest_enabled()) {
-        warn_report("CPU 'compat' property is deprecated and has no effe=
ct; "
-                    "use max-cpu-compat machine property instead");
-    }
-    visit_type_null(v, name, &null, NULL);
-    qobject_unref(null);
-}
-
-static const PropertyInfo ppc_compat_deprecated_propinfo =3D {
-    .name =3D "str",
-    .description =3D "compatibility mode (deprecated)",
-    .get =3D getset_compat_deprecated,
-    .set =3D getset_compat_deprecated,
-};
-static Property powerpc_servercpu_properties[] =3D {
-    {
-        .name =3D "compat",
-        .info =3D &ppc_compat_deprecated_propinfo,
-    },
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void init_proc_POWER7(CPUPPCState *env)
 {
     /* Common Registers */
@@ -8611,7 +8573,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
=20
     dc->fw_name =3D "PowerPC,POWER7";
     dc->desc =3D "POWER7";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match =3D ppc_pvr_match_power7;
     pcc->pcr_mask =3D PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported =3D PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -8776,7 +8737,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
=20
     dc->fw_name =3D "PowerPC,POWER8";
     dc->desc =3D "POWER8";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match =3D ppc_pvr_match_power8;
     pcc->pcr_mask =3D PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported =3D PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPA=
T_2_05;
@@ -8988,7 +8948,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
=20
     dc->fw_name =3D "PowerPC,POWER9";
     dc->desc =3D "POWER9";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match =3D ppc_pvr_match_power9;
     pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7;
     pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPA=
T_2_06 |
@@ -9198,7 +9157,6 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
=20
     dc->fw_name =3D "PowerPC,POWER10";
     dc->desc =3D "POWER10";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match =3D ppc_pvr_match_power10;
     pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7 |
                     PCR_COMPAT_3_00;
@@ -10486,6 +10444,8 @@ static void ppc_cpu_parse_featurestr(const char *=
type, char *features,
         *s =3D '\0';
         for (i =3D 0; inpieces[i]; i++) {
             if (g_str_has_prefix(inpieces[i], "compat=3D")) {
+                warn_report_once("CPU 'compat' property is deprecated; "
+                    "use max-cpu-compat machine property instead");
                 compat_str =3D inpieces[i];
                 continue;
             }
--=20
2.24.1


