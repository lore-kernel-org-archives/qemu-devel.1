Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838D52418C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838D52418C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXu0f-0007a5-P0
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 16:56:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anoo@linux.ibm.com>) id 1hXsML-0005cm-2i
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anoo@linux.ibm.com>) id 1hXsMK-0001QT-0p
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:11:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anoo@linux.ibm.com>) id 1hXsMJ-0001N6-Ri
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:11:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x53J7vi0104711
	for <qemu-devel@nongnu.org>; Mon, 3 Jun 2019 15:11:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sw82b3p5y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 15:11:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <anoo@linux.ibm.com>;
	Mon, 3 Jun 2019 20:11:00 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 3 Jun 2019 20:10:58 +0100
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x53JAvgM25756064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 3 Jun 2019 19:10:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D7FE7805F;
	Mon,  3 Jun 2019 19:10:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 264817805C;
	Mon,  3 Jun 2019 19:10:57 +0000 (GMT)
Received: from habcap11p1.aus.stglabs.ibm.com (unknown [9.41.164.53])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2019 19:10:56 +0000 (GMT)
From: Adriana Kobylak <anoo@linux.ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
	qemu-arm@nongnu.org
Date: Mon,  3 Jun 2019 14:10:55 -0500
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19060319-0036-0000-0000-00000AC65D99
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011209; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01212763; UDB=6.00637359;
	IPR=6.00993823; 
	MB=3.00027167; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-03 19:11:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060319-0037-0000-0000-00004C0E0A8E
Message-Id: <1559589055-71202-1-git-send-email-anoo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-03_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906030129
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0b-001b2d01.pphosted.com id x53J7vi0104711
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Mon, 03 Jun 2019 16:56:01 -0400
Subject: [Qemu-devel] [PATCH qemu] aspeed: Add support for the swift-bmc
 board
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
Cc: Adriana Kobylak <anoo@us.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Adriana Kobylak <anoo@us.ibm.com>

The Swift board is an OpenPOWER system hosting POWER processors.
Add support for their BMC including the I2C devices as found on HW.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 33070a6..cd95b3c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -73,6 +73,9 @@ struct AspeedBoardState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              =
\
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
=20
+/* TODO: Swift hardware value: ? (use romulus definition for now) */
+#define SWIFT_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
+
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
=20
@@ -287,6 +290,35 @@ static void romulus_bmc_i2c_init(AspeedBoardState *b=
mc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
 }
=20
+static void swift_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc =3D &bmc->soc;
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552"=
, 0x60);
+
+    /* The swift board expects a TMP275 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x48);
+    /* The swift board expects a pca9551 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca9552"=
, 0x60);
+
+    /* The swift board expects an Epson RX8900 RTC but a ds1338 is compa=
tible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338",=
 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552"=
, 0x60);
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423",=
 0x4c);
+    /* The swift board expects a pca9539 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca9552"=
, 0x74);
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp423"=
, 0x4c);
+    /* The swift board expects a pca9539 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca9552=
",
+                     0x74);
+
+    /* The swift board expects a TMP275 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105"=
, 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105"=
, 0x4a);
+}
+
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -378,6 +410,16 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .i2c_init  =3D romulus_bmc_i2c_init,
         .ram       =3D 512 * MiB,
     }, {
+        .name      =3D MACHINE_TYPE_NAME("swift-bmc"),
+        .desc      =3D "OpenPOWER Swift BMC (ARM1176)",
+        .soc_name  =3D "ast2500-a1",
+        .hw_strap1 =3D SWIFT_BMC_HW_STRAP1,
+        .fmc_model =3D "mx66l1g45g",
+        .spi_model =3D "mx66l1g45g",
+        .num_cs    =3D 2,
+        .i2c_init  =3D swift_bmc_i2c_init,
+        .ram       =3D 512 * MiB,
+    }, {
         .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
         .soc_name  =3D "ast2500-a1",
--=20
1.8.3.1


