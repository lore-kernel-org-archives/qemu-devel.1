Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8CACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD421872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNGMZ-000372-2L
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iNGKG-0001Ik-KJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iNGKE-0000Je-U1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:05:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iNGKE-0000EV-Ko
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:05:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9ND42C6009878
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:05:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vtpvx1gm5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:05:08 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 23 Oct 2019 14:05:05 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 14:05:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ND51En47054936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 13:05:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D166E4C046;
 Wed, 23 Oct 2019 13:05:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C52C04C05A;
 Wed, 23 Oct 2019 13:05:01 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2019 13:05:01 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-76-221.uk.ibm.com [9.145.76.221])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 20B6A2201D3;
 Wed, 23 Oct 2019 15:05:01 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] hw/gpio: Fix property accessors of the AST2600 GPIO 1.8V
 model
Date: Wed, 23 Oct 2019 15:04:54 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023130455.1347-1-clg@kaod.org>
References: <20191023130455.1347-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102313-0008-0000-0000-000003261D00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102313-0009-0000-0000-00004A454C7F
Message-Id: <20191023130455.1347-2-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=826 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230134
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9ND42C6009878
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, rashmica.g@gmail.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The property names of AST2600 GPIO 1.8V model are one character bigger
than the names of the other ASPEED GPIO model. Increase the string
buffer size by one and be more strict on the expected pattern of the
property name.

This fixes the QOM test of the ast2600-evb machine under :

  Apple LLVM version 10.0.0 (clang-1000.10.44.4)
  Target: x86_64-apple-darwin17.7.0
  Thread model: posix
  InstalledDir: /Library/Developer/CommandLineTools/usr/bin

Cc: Rashmica Gupta <rashmica.g@gmail.com>
Fixes: 36d737ee82b2 ("hw/gpio: Add in AST2600 specific implementation")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/gpio/aspeed_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 196e47c26284..7acc5fa8e29a 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -733,13 +733,13 @@ static void aspeed_gpio_get_pin(Object *obj, Visito=
r *v, const char *name,
 {
     int pin =3D 0xfff;
     bool level =3D true;
-    char group[3];
+    char group[4];
     AspeedGPIOState *s =3D ASPEED_GPIO(obj);
     int set_idx, group_idx =3D 0;
=20
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) !=3D 2) {
         /* 1.8V gpio */
-        if (sscanf(name, "gpio%3s%1d", group, &pin) !=3D 2) {
+        if (sscanf(name, "gpio%3[18A-E]%1d", group, &pin) !=3D 2) {
             error_setg(errp, "%s: error reading %s", __func__, name);
             return;
         }
@@ -760,7 +760,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor =
*v, const char *name,
     Error *local_err =3D NULL;
     bool level;
     int pin =3D 0xfff;
-    char group[3];
+    char group[4];
     AspeedGPIOState *s =3D ASPEED_GPIO(obj);
     int set_idx, group_idx =3D 0;
=20
@@ -771,7 +771,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor =
*v, const char *name,
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) !=3D 2) {
         /* 1.8V gpio */
-        if (sscanf(name, "gpio%3s%1d", group, &pin) !=3D 2) {
+        if (sscanf(name, "gpio%3[18A-E]%1d", group, &pin) !=3D 2) {
             error_setg(errp, "%s: error reading %s", __func__, name);
             return;
         }
--=20
2.21.0


