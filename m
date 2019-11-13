Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FB8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EF6206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dKhk5wQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EF6206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1dk-0000Es-OL
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-000843-4t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007cc-FO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007aZ-9p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGN2Mo0ClBRAxYQhmYqUIFHz481bsMExvnto0DPBMe47/9+8GUB+5OtaXGK3sKX/fy6IlNm3HmP3GvGKcTze4RZpjSsjHs375rsJBIEOlvvDoBWYZI9Zd3Rkd+LscDlVXAuELQw8lCibLDGn8qjZRouEpi6lGAedqy2kqGIlkRLWw7+RbjX6/BXXKeAo2FkyEAWJ/yqjnxRuYcyt45gQKpLsq3OgzBihfnD9/lYNrb+IkcTStUKNrWhJMvIeZ5az73K8DAOcXFGimxeVI9H54/D17aHiczZbZ7IwiGKGevSEa5eXLBq9KFCfWor+gPdgeYBEmFVyJxgSDrvjel2MbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg6bsFmb0bzDC/DwCpZEdhtgXcsPjmuqoaoCCJEJlIA=;
 b=UuOJFUUj31LPou4iKDXTa9UbCdiJp6dvIebNkIHlFT0+tI5FMYv1xi6MNAGjgYFKNVCxLvbp2LFy2YApw2q/Oo8QuJQ/1hNCJWv85UOuGYVKi5K5OJ0hYCmU/Gtic5eXeoB0cx557rd27UF9mS9ZexFVhMX4SRdQbvdmadwZoWClp8U1snpjQ2RKRTqthXFTvU1YnqeY/33D6axQOYUeASkyx3870xxOkL1xebwBEYPi35vI/eIbe8OGKviyS1v//rSjHqDZBokqfzMm6lEm5GRXIB93opYW/Ysj0mOzNetlkXMnttYZd459W4qdDyB9WahSno7WVt/SHnepI8w+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg6bsFmb0bzDC/DwCpZEdhtgXcsPjmuqoaoCCJEJlIA=;
 b=dKhk5wQw5wO904l/zGrKd0bxrk//cGM68gLWQhRA1blXoKMP4z9AofjUK7Phn5HIGrkPfQ0+mlOt97z6Erm+eg2ejvEBjYQjHkE0SjbTuKrNUbOCueb+9373OQbrYQjlQ5I8Y/KBhzOYx3g/DyfRm04gmnrvsnomtjE1PEbVeTE=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:43 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:43 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 02/20] libqos: Rename i2c_send and i2c_recv
Thread-Topic: [PATCH v5 02/20] libqos: Rename i2c_send and i2c_recv
Thread-Index: AQHVmnTHmGTqbqpNPkOerbpYJbMzKQ==
Date: Wed, 13 Nov 2019 22:50:43 +0000
Message-ID: <20191113225030.17023-3-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f80198-1028-4696-7d62-08d7688be9a5
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024D4DA9AE7A0C7332D8AAEBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7LKeAfrZDvcp0MMeDY1SgrZF/kbWpBn1vO8MSck90t5N3TyFKAJcY1s9E9SQLOXDaEJxyXbvb7dyT3hWlAAsI15tbXJNuNTQRaPYqDdTEOjgNxx8c+nxPZ+b/3LJ0GdtD/K7Q9b5KBb8YI36EipX/n8FxCTsIe1quF8JZ1c6KI2RjyBuBBT57d8haU5dFIzZ3ovBwWm1hg1+7ejJ7Yf0yYZv/5ywYjqgPOtee1r+QVilfX4p95wz9TgHIHp2KBFiBDKVkGnk1WoXB1lPLYwetfo/sg+5UIzxeTx6FWAgXnuxTyg+8QCvoBPuXcXYoArMNuspGMIUa/wKz3vSbUfgVs+DttNld5oyCjhD0T8NeWLqWzaHTJRFSZr5MRSULTMZz78ZGtxgpUWPPlTkPftEjCaGygYmkAS6uixYbZauNubGgnqXXaXl5PmIQFVf6um
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f80198-1028-4696-7d62-08d7688be9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:43.1131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hnccm+bbJ/FY+m9WzR05+Ivcx5KB7H1xzVn6JDZ3KYeivYe3wilU/Wir7s1LK9Qh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The names i2c_send and i2c_recv collide with functions defined in
hw/i2c/core.c. This causes an error when linking against libqos and
softmmu simultaneously (for example when using qtest inproc). Rename the
libqos functions to avoid this.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/libqos/i2c.c   | 10 +++++-----
 tests/libqos/i2c.h   |  4 ++--
 tests/pca9552-test.c | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
index 156114e745..38f800dbab 100644
--- a/tests/libqos/i2c.c
+++ b/tests/libqos/i2c.c
@@ -10,12 +10,12 @@
 #include "libqos/i2c.h"
 #include "libqtest.h"
=20
-void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
+void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
 }
=20
-void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
+void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
 }
@@ -23,8 +23,8 @@ void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t =
len)
 void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
                     uint8_t *buf, uint16_t len)
 {
-    i2c_send(i2cdev, &reg, 1);
-    i2c_recv(i2cdev, buf, len);
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, buf, len);
 }
=20
 void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
@@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
     uint8_t *cmd =3D g_malloc(len + 1);
     cmd[0] =3D reg;
     memcpy(&cmd[1], buf, len);
-    i2c_send(i2cdev, cmd, len + 1);
+    qi2c_send(i2cdev, cmd, len + 1);
     g_free(cmd);
 }
=20
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 945b65b34c..c65f087834 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -47,8 +47,8 @@ struct QI2CDevice {
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)=
;
 void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
=20
-void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
-void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
+void qi2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
+void qi2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
=20
 void i2c_read_block(QI2CDevice *dev, uint8_t reg,
                     uint8_t *buf, uint16_t len);
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 4b800d3c3e..d80ed93cd3 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGue=
stAllocator *alloc)
=20
     pca9552_init(i2cdev);
=20
-    i2c_send(i2cdev, &reg, 1);
+    qi2c_send(i2cdev, &reg, 1);
=20
     /* PCA9552_LS0 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
=20
     /* PCA9552_LS1 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS2 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS3 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
 }
=20
--=20
2.23.0


