Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F25C4CED0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40288218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Jfmc51CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40288218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjGh-0002Bt-Vd
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEU-0000EH-Gk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjET-0002Sz-1h
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:34 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
 ([40.107.71.132]:6167 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjES-0002SZ-Qx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPXFaLuNygN6D90VdJwygU1lCtkka+tBJH8bPCeGeIC2JTGjZDLj8kI8+hENlrFDfHWYYE8kSjy5FHMfNtoOm1/JWCQDpxZyt3eRTwjEDhdHcsFsdDn8ZciI1ZpGWhs8CjFgoDZGEfHuXKDDEcK4tYPdlmqvFEToxM6CYkfjj9YGzq8wMHT5N3iLbFc7vMj4lEltlfV/R5xpKgNKpigIBPZ8onNqnvsxNCsjrQ56Gqp0F0AW4Kz7lDVGF6J59GtEwg2Rs9vADjChR7aPipKEjq/s0fsxAo4Jsm9LVNvMU5pWKXaICOHlmmdz6/s6E2zS/9D/Q86S95z3TK2XsJuc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl6Xg8KiK7uFnKscaFCU1OMZ+semD7ioC/jr93Z9oxI=;
 b=nnc3gno1byPOXL8KeoSpzp5y9WhmWixOKIXjw1YOgbO93NMoZANIsQI9wUcK7tbghvc1eOzt05Ag20wKP+FLT9ii9HLnIqic3+VHk39VzurI63jhzcmrYahvJwwY6spJEIn2DDlLFwubheiKLPPjeGTo2sQ12fbM2tznhwtgexmhzKnqbwKojKK7DvKh4OenBtEjZhw5Mn+dsnb1cF55CiUKbQiZ2M9mGjAT31TDFxZxqkcJlCNLBcenDrQW99iOypFvKf0ML3iksKdHvnp4Fh1KXnpsA2fYIH/wzxdPTZXGK7hfQQAOEjAuCQqevT58+4RwXzUFm8+Zsmf4GBmRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl6Xg8KiK7uFnKscaFCU1OMZ+semD7ioC/jr93Z9oxI=;
 b=Jfmc51CAQBGEa0lSrBv40hAwI+2gDUgxl7QoxDLCjtwDqRraFr85sPEWF0SrFBSliLNr/S6aQ4Gam7YQKoIP9sdeGyPvvfxLEHWemnmEvWOkafW99Fh3gfekg0mlz30KsXhIReKkBC4CW2C1STmkYmAFNxONX58qIPSG1ptg7bY=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:29 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:29 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 02/22] libqos: Rename i2c_send and i2c_recv
Thread-Index: AQHVbneFFU4BDIDh4Ea8xDc1OfLEzA==
Date: Wed, 18 Sep 2019 23:19:29 +0000
Message-ID: <20190918231846.22538-3-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2e1845-4e67-4268-e6d5-08d73c8ea7b8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30166BEDAEB4931D3C34D70ABA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L4cOTt4pbalqapFCPhPxedE2eVXGupmQ1kL7KziHv/YQjH1r61JVv9XDy0g/B+j3PJ2cCNNBuK6mpo5bL0E2gLatAQmSnPybxn6J0jNWVPEoygy+kFowVOOyxz1xcxh2ISB/x6PIgFAqDOdrWnRLHhyiveT+SVqFmSsojT5SN7Sc/Z6tQbwun+TxnlFog9uOmH/Sfs6W8e9NyqZAAYe9I8SpXnJL/qsoEyU2cDVASgiebVCc5e6oVIZq4+YNZqFCzqnQ95gWv4vBO51RZq4LdmjiAVESNgKjroltuLX7lF6LkEhaDnyoPIdWTkA2jk81Ft8/XMlei4/dKdZeg+S+FjYHz/K95bZ93OCC/8fDGMhjfw8WvnPMVDTd2Ot5XzitjvOhodjAbkiRmoBjgfkDB7kSXOgHgCyQQantrzVMyTA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2e1845-4e67-4268-e6d5-08d73c8ea7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:29.6718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR/fT+0ZAvV7YRVmcrd2xo56cWm1T1aCS/ESkU3DlMfELeajQ1br9fWsR4+qsQ5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.132
Subject: [Qemu-devel] [PATCH v3 02/22] libqos: Rename i2c_send and i2c_recv
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqos/i2c-imx.c  |  8 ++++----
 tests/libqos/i2c-omap.c |  8 ++++----
 tests/libqos/i2c.c      | 10 +++++-----
 tests/libqos/i2c.h      |  4 ++--
 tests/pca9552-test.c    | 10 +++++-----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index f33ece55a3..c1dcc9fb1d 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -37,7 +37,7 @@ static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t add=
r,
                  (addr << 1) | (direction =3D=3D IMX_I2C_READ ? 1 : 0));
 }
=20
-static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
+static void imx_i2c_test_send(I2CAdapter *i2c, uint8_t addr,
                          const uint8_t *buf, uint16_t len)
 {
     IMXI2C *s =3D container_of(i2c, IMXI2C, parent);
@@ -97,7 +97,7 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
     g_assert((status & I2SR_IBB) =3D=3D 0);
 }
=20
-static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
+static void imx_i2c_test_recv(I2CAdapter *i2c, uint8_t addr,
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
+    s->parent.send =3D imx_i2c_test_send;
+    s->parent.recv =3D imx_i2c_test_recv;
     s->parent.qts =3D qts;
 }
=20
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index 9ae8214fa8..284f765a3b 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -50,7 +50,7 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t a=
ddr)
     g_assert_cmphex(data, =3D=3D, addr);
 }
=20
-static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
+static void omap_i2c_test_send(I2CAdapter *i2c, uint8_t addr,
                           const uint8_t *buf, uint16_t len)
 {
     OMAPI2C *s =3D container_of(i2c, OMAPI2C, parent);
@@ -94,7 +94,7 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
     g_assert((data & OMAP_I2C_CON_STP) =3D=3D 0);
 }
=20
-static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
+static void omap_i2c_test_recv(I2CAdapter *i2c, uint8_t addr,
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
+    s->parent.send =3D omap_i2c_test_send;
+    s->parent.recv =3D omap_i2c_test_recv;
     s->parent.qts =3D qts;
 }
=20
diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
index 156114e745..b96a37b69b 100644
--- a/tests/libqos/i2c.c
+++ b/tests/libqos/i2c.c
@@ -10,12 +10,12 @@
 #include "libqos/i2c.h"
 #include "libqtest.h"
=20
-void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
+void i2c_test_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
 }
=20
-void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
+void i2c_test_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
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
+    i2c_test_send(i2cdev, &reg, 1);
+    i2c_test_recv(i2cdev, buf, len);
 }
=20
 void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
@@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
     uint8_t *cmd =3D g_malloc(len + 1);
     cmd[0] =3D reg;
     memcpy(&cmd[1], buf, len);
-    i2c_send(i2cdev, cmd, len + 1);
+    i2c_test_send(i2cdev, cmd, len + 1);
     g_free(cmd);
 }
=20
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 945b65b34c..9a4d6579a2 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -47,8 +47,8 @@ struct QI2CDevice {
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)=
;
 void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
=20
-void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
-void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
+void i2c_test_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
+void i2c_test_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
=20
 void i2c_read_block(QI2CDevice *dev, uint8_t reg,
                     uint8_t *buf, uint16_t len);
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 4b800d3c3e..9844177d79 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGue=
stAllocator *alloc)
=20
     pca9552_init(i2cdev);
=20
-    i2c_send(i2cdev, &reg, 1);
+    i2c_test_send(i2cdev, &reg, 1);
=20
     /* PCA9552_LS0 */
-    i2c_recv(i2cdev, &resp, 1);
+    i2c_test_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
=20
     /* PCA9552_LS1 */
-    i2c_recv(i2cdev, &resp, 1);
+    i2c_test_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS2 */
-    i2c_recv(i2cdev, &resp, 1);
+    i2c_test_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS3 */
-    i2c_recv(i2cdev, &resp, 1);
+    i2c_test_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
 }
=20
--=20
2.23.0


