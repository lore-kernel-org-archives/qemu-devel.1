Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DEBECE588
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F20221835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F20221835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKf5v-0002k9-NR
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iKf1B-0005dL-5X
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iKf19-0004kf-Pp
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60100
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iKf19-0004kF-KI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9G8lUYC089452
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vnxjhufd4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:50 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 16 Oct 2019 09:50:48 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Oct 2019 09:50:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9G8oi0T46924094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2019 08:50:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B5B54C04A;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FBD74C044;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-54-117.uk.ibm.com [9.145.54.117])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 64D4E2201F3;
 Wed, 16 Oct 2019 10:50:43 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/5] aspeed: Add a DRAM memory region at the SoC level
Date: Wed, 16 Oct 2019 10:50:33 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016085035.12136-1-clg@kaod.org>
References: <20191016085035.12136-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19101608-4275-0000-0000-0000037285EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101608-4276-0000-0000-000038859A8E
Message-Id: <20191016085035.12136-4-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160079
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x9G8lUYC089452
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, we link the DRAM memory region to the FMC model (for DMAs)
through a property alias at the SoC level. The I2C model will need a
similar region for DMA support, add a DRAM region property at the SoC
level for both model to use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast2600.c     | 7 +++++--
 hw/arm/aspeed_soc.c         | 9 +++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cccb684a19bb..3375ef91607f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSoCState {
     ARMCPU cpu[ASPEED_CPUS_NUM];
     uint32_t num_cpus;
     A15MPPrivState     a7mpcore;
+    MemoryRegion *dram_mr;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931887ac681f..a403c2aae067 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -158,8 +158,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
                           typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
-    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
-                              &error_abort);
=20
     for (i =3D 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, s=
ocname);
@@ -362,6 +360,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
     }
=20
     /* FMC, The number of CS is set at the board level */
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram"=
, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index f4fe243458fd..dd1ee0e3336d 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -175,8 +175,6 @@ static void aspeed_soc_init(Object *obj)
                           typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
-    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
-                              &error_abort);
=20
     for (i =3D 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, s=
ocname);
@@ -323,6 +321,11 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
                        aspeed_soc_get_irq(s, ASPEED_I2C));
=20
     /* FMC, The number of CS is set at the board level */
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram"=
, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
@@ -429,6 +432,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
 }
 static Property aspeed_soc_properties[] =3D {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
+    DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION=
,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.21.0


