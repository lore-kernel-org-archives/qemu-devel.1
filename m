Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E2C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A082073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gi+vMe08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A082073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQBC-0000Q2-Vq
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1V-0006zz-KY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1U-0006Mi-A3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:53 -0500
Received: from mail-bn7nam10on2105.outbound.protection.outlook.com
 ([40.107.92.105]:16480 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1U-0006MQ-69
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2v28xZbeNaSNijRlxv8eX9Ne5nVDvhxWSUMS90n/FtNjq0xcEmh1qNX17vEhp2DsMJYwAoSRW84VQjxm3LHcWF7qA+QCkEsz/wlE8fA8OlBrgMlX2ax4Dkc9YSP2HbR3h1mq6TRVgeLvXprXWm3nlEthN+U/UF56NO8XL+/mkBQi0VkhgUkd5/dFEZrztfhnTlqmDuLkPHCnHlCoHQ78FJhaoGacnjCDQ9xalMai95P+ECR1iAHz1yg8JTdTasyeo7BxyUTcXtTJvtngZ5usvzs1vouLXYadG6bJN4BDsxXEKQoKjsUvIzKj+CdLMY+mrNM1zaMjbkejN3N4vRWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5mnk3e1ZGtlIjME4MaJ9YJ8gCqwJraw8SK866ibAro=;
 b=HRlyq/wiota1IOHHRq37YK1RRJ6WIMLroMgwHfBwX3agu85fUMdw0Z6KemHN6VMyApz19uDm13AM+oui2aELMP0dk0BN9tLWb0yAmGDXFu2voJrRaw74Mh06hKjHBNVzFf2GgHKbTc9rGTbjSRlaqet8dOLxYo0zONe3AlTOuA3k0ZdZzGHwx6O0xAFXJODHaZMWFngnZiYhnnTAmUWE2hmtUPxdwfIRGQWfiN+AWi6BfSdn6gDh3eqslL7QBXthclDzNFbqkELXdh9tByxaw7Al0CdCFXl/5rabDrrLxEPdk0wzEuXOUpRJrgZb/qf/s6OzVMmvdwEIlDSAU/7iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5mnk3e1ZGtlIjME4MaJ9YJ8gCqwJraw8SK866ibAro=;
 b=gi+vMe08OEhskVyptrkxQ3/QwXRXqp5RtKVMHvHQPpHxF8N/ian6i7ZE0QIXEkyX2yvvUG+HqvunXj4ONiy90B+fAkMXtoCYoOhNIYCJ873woX7gM2/YkNSTVWvV7fsTBQXr5XozWM5SzSiwB1oIKKmu1HWXwUBzeZp+BmNcYn4=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:51 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:51 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:49 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 08/20] libqos: rename i2c_send and i2c_recv
Thread-Topic: [PATCH v7 08/20] libqos: rename i2c_send and i2c_recv
Thread-Index: AQHVz1YgwLFsz+oGWUCMZttkvWf3qQ==
Date: Mon, 20 Jan 2020 05:54:50 +0000
Message-ID: <20200120055410.22322-11-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f07b84-d7fe-4aee-3505-08d79d6d434d
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399960870B924726CDC2277BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(6666004)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LI6ntX0QcwPzgPCSAAxMX0ZTeKHUt2hsN5Syexe+V/ijVEh69QvGdFEssAh1TB8ldjn72TNCkGI4zPDW56gd5TaA1KC9reP2CKYXlZlHNOIcAvS/VpnINqyp1gNN7rZ6ak3sKiSXn3dRCjY2I5i8F1ijixOfWz1JlEkVRoswCRefmOt804BhTfYmaq8rhOmJvEjWZRWqiEUp4NO7yobeCxIzerHldM11Q+5dfFAZxRr3/ALHJaCLJ/euJ8ELot0TFS6SO8PS02pbPzsPcE4yRZEzKcrfReid7ITWN9iZb15fBnFZTubmHyRpCntO7TB9CC7J+F3Lyr6Ztb6gf7vVHbgUBFEmTmhkUOTEqIYTpGQuiyowpLeythi4c8B3idHDmCF/rjKZnxi97nfyDFr9AualtQS5zVvjmjiyJEd5TsjY7w4WA16TpICKrFWCjlo3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f07b84-d7fe-4aee-3505-08d79d6d434d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:50.8910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zDRVTUcgUsFwZo1D+6NZ95LqmMkoI2f3futoUzcBYHihpYU6PsyBwOS83FtHgX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.105
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
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
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
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/libqos/i2c.c   | 10 +++++-----
 tests/qtest/libqos/i2c.h   |  4 ++--
 tests/qtest/pca9552-test.c | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
index 156114e745..38f800dbab 100644
--- a/tests/qtest/libqos/i2c.c
+++ b/tests/qtest/libqos/i2c.c
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
diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
index 945b65b34c..c65f087834 100644
--- a/tests/qtest/libqos/i2c.h
+++ b/tests/qtest/libqos/i2c.h
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
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index 4b800d3c3e..d80ed93cd3 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
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


