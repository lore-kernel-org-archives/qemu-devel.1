Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE6CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B3620856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="tn5PJcPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B3620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpRc-00025z-AT
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0004z9-Pf
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007G8-DG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
Received: from mail-eopbgr800133.outbound.protection.outlook.com
 ([40.107.80.133]:23904 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIL-00079I-GW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdQRAugi9BWauQuqTMa630JbhazlYNDtOIutEUCBiUlOrup1nyXkGJEOv5wCa9pOXPDlHiiX6aQ8MVyChIztkfdRl/yhI/P78vArvKDUuUweEodw8kJzDqiYSU2BqYyZMzgxqiXX5nZiWEw65/syZV86AoIk7maXpES3ZkDevkw/0d/S9dHprL2Usc+S5Sd93tmC/WZMmKUmjQJCLfrs0CfGx8z/uf3b0BFMQYuKciPJYyxgKFalyhj5cG0RvZJBqw9iDXpUkiP3HdWM48RuAQccPDnQDQOJus7xjr4xP4VqtEY69IMvsJjga0LIZWnbLYLKjpImCwrng26r3xcNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpESagooz8Rx7YOjPk5Zy9ZiVnAxx4OSyKaptouZ02k=;
 b=PB7j+ExEsHv5dinxih2+yojWxnLwRzbosypX/74w1gDQrikZiMIIfUzyW/4nImuXFTR/x4OOXhSE06bcflCe/p0lLL25XsqZG1U1v9XZCf9OOiHIPBPpABF4rDz4ZUeGDme1r607RpG71v6ib9SPGheQHNFpRfKySa/B2npNBeef3mGSAD6Y4ZaNsUrGrZR9UT/Al4Djwtsr4kO7+/t1AwRe/amXHAV+64ICWUGE9V5Uk+5XePRD8dBM3nbZaw+NtLvBmvOaBipPpRbgveJQgPsS4ddadRV7O6kWnJabvfTBFV9lC/cj1r/OEkLjslOzGvUeYAx0aD7Kw9XdAtHMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpESagooz8Rx7YOjPk5Zy9ZiVnAxx4OSyKaptouZ02k=;
 b=tn5PJcPV7di0sGdcEqqKihTrKIPWlol4UxSvT2+eSsLRiHo12uDNUHBLqridHe0i7Q6ENDYpL/OfADlB7KsAEC5Ip45WCFpX7FpEd100nExG4x/yt8z4W3fyIud/vBllJVSV6dU6v6bZtuhiB9hZ7C+4uP/JMT9JA8cJ2gnhH7E=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:49 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:49 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 02/20] libqos: Rename i2c_send and i2c_recv
Thread-Topic: [PATCH v4 02/20] libqos: Rename i2c_send and i2c_recv
Thread-Index: AQHVjzFHKtTntWy9IE2rN5j43JMd3w==
Date: Wed, 30 Oct 2019 14:49:49 +0000
Message-ID: <20191030144926.11873-3-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45b378fc-c008-4b1a-dc53-08d75d4869e1
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB505432ECA2CF8BDA44CE53C5BA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(54906003)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Xf3N7l3iLAm+Go5xFpOmGBjVe+Z1eF8GODP68scW/n3MPAtkcIsC/ZHnBiUzWr3G+gZOc68KVK7+HiTZfc/Zn9tIqmTAR7LocwkH+qxHGN9rfALuR4Ij1OJAIzYTiLLlAElm8cuIOpPyXxhDaeiqpsE3g3vgx2YkLrTxhflXhgOBAhHrz8wpD1v+Ul6rd6x9s/q0ZGpA2VSGRrRQtqj88EyB+Z758DI0cIqQkSgjR5Bbt6YNgVumGpiSr297j2+VZ2RlpHtc+vbfkH9nhbg9cPpXOAQYeVXAAaXQ2uIAjYMGrbgf6S899Y03Qy5PNRjEq4EA++SbjHA81lkqXq5xnfnuovPsq7NN8TXGhe/e7LXKiBA6y34eIcll7ymeY2CY37GatBLc5zr0gmBc6m7zhQQWvejL/3F/FSKyplKoQXiWpiCkaya79qMq6HkE/kY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b378fc-c008-4b1a-dc53-08d75d4869e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:49.3731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Zqa5ZTHyFyVB40JSb5Rx3/l86hJUaMq20+cSeuo7uFLH5BgiBYKLoYxpzeLYjYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.133
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

The names i2c_send and i2c_recv collide with functions defined in
hw/i2c/core.c. This causes an error when linking against libqos and
softmmu simultaneously (for example when using qtest inproc). Rename the
libqos functions to avoid this.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqos/i2c-imx.c  |  8 ++++----
 tests/libqos/i2c-omap.c |  8 ++++----
 tests/libqos/i2c.c      | 10 +++++-----
 tests/libqos/i2c.h      |  4 ++--
 tests/pca9552-test.c    | 10 +++++-----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index f33ece55a3..42ebf8ba3a 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -37,7 +37,7 @@ static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t add=
r,
                  (addr << 1) | (direction =3D=3D IMX_I2C_READ ? 1 : 0));
 }
=20
-static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
+static void qimx_i2c_send(I2CAdapter *i2c, uint8_t addr,
                          const uint8_t *buf, uint16_t len)
 {
     IMXI2C *s =3D container_of(i2c, IMXI2C, parent);
@@ -97,7 +97,7 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
     g_assert((status & I2SR_IBB) =3D=3D 0);
 }
=20
-static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
+static void qimx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
                          uint8_t *buf, uint16_t len)
 {
     IMXI2C *s =3D container_of(i2c, IMXI2C, parent);
@@ -202,8 +202,8 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t =
addr)
=20
     s->obj.get_driver =3D imx_i2c_get_driver;
=20
-    s->parent.send =3D imx_i2c_send;
-    s->parent.recv =3D imx_i2c_recv;
+    s->parent.send =3D qimx_i2c_send;
+    s->parent.recv =3D qimx_i2c_recv;
     s->parent.qts =3D qts;
 }
=20
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index 9ae8214fa8..5f4d79f87c 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -50,7 +50,7 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t a=
ddr)
     g_assert_cmphex(data, =3D=3D, addr);
 }
=20
-static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
+static void qomap_i2c_send(I2CAdapter *i2c, uint8_t addr,
                           const uint8_t *buf, uint16_t len)
 {
     OMAPI2C *s =3D container_of(i2c, OMAPI2C, parent);
@@ -94,7 +94,7 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
     g_assert((data & OMAP_I2C_CON_STP) =3D=3D 0);
 }
=20
-static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
+static void qomap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
                           uint8_t *buf, uint16_t len)
 {
     OMAPI2C *s =3D container_of(i2c, OMAPI2C, parent);
@@ -182,8 +182,8 @@ void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_=
t addr)
     s->obj.get_driver =3D omap_i2c_get_driver;
     s->obj.start_hw =3D omap_i2c_start_hw;
=20
-    s->parent.send =3D omap_i2c_send;
-    s->parent.recv =3D omap_i2c_recv;
+    s->parent.send =3D qomap_i2c_send;
+    s->parent.recv =3D qomap_i2c_recv;
     s->parent.qts =3D qts;
 }
=20
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


