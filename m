Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808CC4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCC120578
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCC120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71vB-0003SD-11
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 14:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j71uR-0002w4-HF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j71uP-0007e6-4s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:59:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j71uO-0007bF-Sw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:59:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QIoqoJ038384
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 13:59:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydq6wh07n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 13:59:46 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 26 Feb 2020 18:59:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 18:59:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QIxftw48824424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 18:59:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 020624C044;
 Wed, 26 Feb 2020 18:59:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71DAB4C04A;
 Wed, 26 Feb 2020 18:59:40 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.89.213])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 18:59:40 +0000 (GMT)
Subject: [PATCH] ppc: Officially deprecate the CPU "compat" property
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Feb 2020 19:59:38 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022618-0020-0000-0000-000003ADDDEF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022618-0021-0000-0000-00002205F9FC
Message-Id: <158274357799.140275.12263135811731647490.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_07:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1034 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002260118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Server class POWER CPUs have a "compat" property, which was obsoleted
by commit 7843c0d60d and replaced by a "max-cpu-compat" property on the
pseries machine type. A hack was introduced so that passing "compat" to
-cpu would still produce the desired effect, for the sake of backward
compatibility : it strips the "compat" option from the CPU properties
and applies internally it to the pseries machine. The accessors of the
"compat" property were updated to do nothing but warn the user about the
deprecated status when doing something like:

$ qemu-system-ppc64 -global POWER9-family-powerpc64-cpu.compat=power9
qemu-system-ppc64: warning: CPU 'compat' property is deprecated and has no
 effect; use max-cpu-compat machine property instead

This was merged during the QEMU 2.10 timeframe, a few weeks before we
formalized our deprecation process. As a consequence, the "compat"
property fell through the cracks and was never listed in the officialy
deprecated features.

We are now eight QEMU versions later, it is largely time to mention it
in qemu-deprecated.texi. Also, since -global XXX-powerpc64-cpu.compat=
has been emitting warnings since QEMU 2.10 and the usual way of setting
CPU properties is with -cpu, completely remove the "compat" property.
Keep the hack so that -cpu XXX,compat= stays functional some more time,
as required by our deprecation process.

The now empty powerpc_servercpu_properties[] list which was introduced
for "compat" and never had any other use is removed on the way. We can
re-add it in the future if the need for a server class POWER CPU specific
property arises again.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 qemu-deprecated.texi            |    6 +++++
 target/ppc/translate_init.inc.c |   44 ++-------------------------------------
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 66eca3a1dede..56a69400c14a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -242,6 +242,12 @@ The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` a
 ``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
 via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
 
+@subsection ``compat`` property of server class POWER CPUs (since 5.0)
+
+The ``compat`` property used to set backwards compatibility modes for
+the processor has been deprecated. The ``max-cpu-compat`` property of
+the ``pseries`` machine type should be used instead.
+
 @section System emulator devices
 
 @subsection ide-drive (since 4.2)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 53995f62eab2..2f7125c51f35 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8492,44 +8492,6 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x10000;
 }
 
-/*
- * The CPU used to have a "compat" property which set the
- * compatibility mode PVR.  However, this was conceptually broken - it
- * only makes sense on the pseries machine type (otherwise the guest
- * owns the PCR and can control the compatibility mode itself).  It's
- * been replaced with the 'max-cpu-compat' property on the pseries
- * machine type.  For backwards compatibility, pseries specially
- * parses the -cpu parameter and converts old compat= parameters into
- * the appropriate machine parameters.  This stub implementation of
- * the parameter catches any uses on explicitly created CPUs.
- */
-static void getset_compat_deprecated(Object *obj, Visitor *v, const char *name,
-                                     void *opaque, Error **errp)
-{
-    QNull *null = NULL;
-
-    if (!qtest_enabled()) {
-        warn_report("CPU 'compat' property is deprecated and has no effect; "
-                    "use max-cpu-compat machine property instead");
-    }
-    visit_type_null(v, name, &null, NULL);
-    qobject_unref(null);
-}
-
-static const PropertyInfo ppc_compat_deprecated_propinfo = {
-    .name = "str",
-    .description = "compatibility mode (deprecated)",
-    .get = getset_compat_deprecated,
-    .set = getset_compat_deprecated,
-};
-static Property powerpc_servercpu_properties[] = {
-    {
-        .name = "compat",
-        .info = &ppc_compat_deprecated_propinfo,
-    },
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void init_proc_POWER7(CPUPPCState *env)
 {
     /* Common Registers */
@@ -8611,7 +8573,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER7";
     dc->desc = "POWER7";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power7;
     pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -8776,7 +8737,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER8";
     dc->desc = "POWER8";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power8;
     pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -8988,7 +8948,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
     pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
@@ -9198,7 +9157,6 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
-    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power10;
     pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
                     PCR_COMPAT_3_00;
@@ -10486,6 +10444,8 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
         *s = '\0';
         for (i = 0; inpieces[i]; i++) {
             if (g_str_has_prefix(inpieces[i], "compat=")) {
+                warn_report_once("CPU 'compat' property is deprecated; "
+                    "use max-cpu-compat machine property instead");
                 compat_str = inpieces[i];
                 continue;
             }


