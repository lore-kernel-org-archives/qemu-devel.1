Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADE1C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421524691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="ptj3cbR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421524691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HLH-0005jU-R2
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7HK0-0004Bq-VI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7HJz-00026z-IR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:27:16 -0500
Received: from mail-eopbgr1280101.outbound.protection.outlook.com
 ([40.107.128.101]:30592 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>) id 1j7HJz-0001zN-62
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:27:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFxzwLSRU7tFBrpwpyfj6axwSRJ2utbB4+gKz9yQBQj3xx2/y6G4kAr5xbAaGrTvVW3XjSGphGs7/297sdtLBrK5qW6Sy8DxvvDQ6x9Htrav7bqdoW7ZVuXlIUzdbSvpCpS+6XOuUk5Pj+CONmWpTbZ59m53zOs0+J89SDqNw1DYIV/y3/F6kHsQMPGmBfUpd1YaFsMWoF9lfg2Kfv2IREU6OOn1Fs8MJjCgLw1Hs06e0LregmzOvSZnOjiZ5Y5qq0CCMrIYBLOMbJ0WmGelub+v347qYET9iE64/Aw583tbqj8WLVQ2vYCChARCKycyNPbFMERSs9tQivgYk/9Fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5HvCc0r/MNF4aiw65zs50xkNsdQHf63wlQ0XqU2IEk=;
 b=l/eThMmJ469dw0xzOByuv1WhBtrMsXs1YmVcaRJa2TmAHAPDfxYIAHdEC+QwF6utXxej71My73l45sAtEDzUl332hVkUj6ezZ4TT/kttHWXN5Sm7gFGli5T8vgRCuSwIaqhO3ToMEuq94AKvnqDSt8iFyycrRl1AwLCdA2pE8tATe/QrgkgZ+0HWr+gARKf8VLAoA9cD5z6VsFXG9GNxA+usxiWt31dNFLlcZKWLA4KyNxwGLnlwrBJxtWlhB95rWfYUzn2gBWS0rXEykc+G2uVzuWoDqCFyDXCM3s/4LgPq1J9FIsEM3otk2LH3Etcw5iAWS5wO0WWzuLK6vdVgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5HvCc0r/MNF4aiw65zs50xkNsdQHf63wlQ0XqU2IEk=;
 b=ptj3cbR6oqlg1mhDGCbKd/GBy/fcXYKTtMlxPemRINp9QoYIYIVdFe8n8dsXTL4w78a3zi/XZfP270z/v1YKvjShYYO1ajEP5h5GYrTbEuZNFCueM041h93TOv4ekk8grGuqcwW9VpC5yiz+WFvdwD7urDrlkyjGwuSXwbEXKf0=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0031.KORP216.PROD.OUTLOOK.COM (10.174.39.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 11:27:09 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:27:09 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.11 via Frontend Transport; Thu, 27 Feb 2020 11:27:08 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH 1/2] hw/core: Support device reset handler priority
Thread-Topic: [PATCH 1/2] hw/core: Support device reset handler priority
Thread-Index: AQHV7WDZEcMZm77PzkaHlNOHvOwUHQ==
Date: Thu, 27 Feb 2020 11:27:09 +0000
Message-ID: <20200227112617.66044-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a392ea-191b-42f5-29bb-08d7bb77fb98
x-ms-traffictypediagnostic: SLXP216MB0031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB00319FB45B7DB5AF22217867BDEB0@SLXP216MB0031.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39830400003)(376002)(396003)(189003)(199004)(478600001)(16526019)(4326008)(64756008)(66556008)(6506007)(109986005)(86362001)(54906003)(2906002)(66446008)(26005)(1076003)(186003)(66476007)(66946007)(316002)(2616005)(81166006)(71200400001)(956004)(5660300002)(52116002)(8676002)(36756003)(81156014)(6486002)(6512007)(8936002)(36456003)(42976004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0031;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kus5FkFfCEF1AtYiB8qiN0V0XPg0Q87ajbwc1NC0p77hsqhUkMxG8vvKu/mczR8DXc1kGZCAOWywyoU26i796DvO6SlbQaoIU4JSiDFtDwt2fZneeGT+tq07lAWehWbveqSw9lx1V2NXC9SG/Tq/I8X0ugvyfdpGHY94vf0eTyCHAC8DeKmhJ8//tqAbkYY9mh8DpAkxuhfR2zedk0orvPEs7qaZnqrlcOoW/3zjwz1HgawkfWUXzFE0R+Z0Rj3DZpoSj/8S/EFDc2dTT51uimH6gSt6g4JwV2fFaYqW6KaQtovSSqNnsXO5OFqIdy9ZAsfx9D2KmykSrJMuDwiuShmGGJKp5s8176owbdacSlyPQsaMCx56r3xGu1oNfOff39plxKiVfDwcVAUamNx8fI9hUFYjiCJ9NcdLm8MJw2jkW6wS5Hga1492tetBws7urDi2/z0/gdz2zMtHpYh4PbE6iyawLQXEhP3GjfKhSjbL9tAw2Cm5XY3Xv8rIsYS0dIXkzb3yIebdDlA2WO/phg==
x-ms-exchange-antispam-messagedata: 9tc3LAQwVSmCVXgtPchhfBze7nYKKglgnbUXcvuvDsASqFm+oFuziflepJjDi3kRAttd3tJgbqy35wxM05FhS8s4D7zx6TmMiTljTU6xHgVZL5G5gJo6UY3Mnj3oHb3GQCBM/mjl0AaxoNvygzOuOg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a392ea-191b-42f5-29bb-08d7bb77fb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:27:09.5179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SlF5LQbHz4hN2EHCul8zG2Yza8EgrJ+SN5x5qtT4B9tnB380xJDnoGfIwrgzJSzYSKJ5Yfz/t5sw6pDTSs/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0031
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.101
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
Cc: Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device reset handler invocation order is currently dependent on
the order of handler registration, and this is less than ideal because
there may exist dependencies among the handlers that require them to
be invoked in a specific order.

This commit adds the `priority` field to the reset entry struct and
introduces the `qemu_register_reset_with_priority` function that
implements descending-order insertion into the reset handler list based
on the priority value, in order to allow the reset handler invocation
order to be specified by the caller.

Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
---
 hw/core/reset.c        | 32 ++++++++++++++++++++++++++++++--
 include/sysemu/reset.h | 24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/hw/core/reset.c b/hw/core/reset.c
index 9c477f2bf5..74f3677d96 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -31,6 +31,7 @@
=20
 typedef struct QEMUResetEntry {
     QTAILQ_ENTRY(QEMUResetEntry) entry;
+    uint16_t priority;
     QEMUResetHandler *func;
     void *opaque;
 } QEMUResetEntry;
@@ -38,13 +39,40 @@ typedef struct QEMUResetEntry {
 static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =3D
     QTAILQ_HEAD_INITIALIZER(reset_handlers);
=20
-void qemu_register_reset(QEMUResetHandler *func, void *opaque)
+void qemu_register_reset_with_priority(uint16_t priority,
+    QEMUResetHandler *func, void *opaque)
 {
+    /* Initialise reset entry */
     QEMUResetEntry *re =3D g_malloc0(sizeof(QEMUResetEntry));
=20
+    re->priority =3D priority;
     re->func =3D func;
     re->opaque =3D opaque;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+
+    /* Insert sorted by priority into the reset entry list */
+    if (QTAILQ_EMPTY(&reset_handlers) ||
+        QTAILQ_LAST(&reset_handlers)->priority >=3D priority)
+    {
+        QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+    }
+    else
+    {
+        QEMUResetEntry *cur =3D QTAILQ_LAST(&reset_handlers);
+
+        while (QTAILQ_PREV(cur, entry) !=3D NULL &&
+               QTAILQ_PREV(cur, entry)->priority < priority)
+        {
+            cur =3D QTAILQ_PREV(cur, entry);
+        }
+
+        QTAILQ_INSERT_BEFORE(cur, re, entry);
+    }
+}
+
+void qemu_register_reset(QEMUResetHandler *func, void *opaque)
+{
+    qemu_register_reset_with_priority(
+        QEMU_RESET_PRIORITY_DEFAULT, func, opaque);
 }
=20
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 0b0d6d7598..39a0fe55f0 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -1,8 +1,32 @@
 #ifndef QEMU_SYSEMU_RESET_H
 #define QEMU_SYSEMU_RESET_H
=20
+/*
+ * The device reset handlers are executed in descending order of their pri=
ority
+ * values (i.e. the reset handler with the greatest numerical priority val=
ue
+ * will be executed first).
+ */
+#define QEMU_RESET_PRIORITY_DEFAULT     (0x8000)
+
+/*
+ * The priority level can range from -8 to +7, where the reset handler wit=
h the
+ * highest priority level is executed first.
+ */
+#define QEMU_RESET_PRIORITY_LEVEL(l) \
+    (QEMU_RESET_PRIORITY_DEFAULT + (l * 0x1000))
+
+/*
+ * Each priority level may be further divided into a maximum of 4096 sub-l=
evels
+ * (0 to 4095).
+ */
+#define QEMU_RESET_PRIORITY_SUBLEVEL(l, s) \
+    (QEMU_RESET_PRIORITY_DEFAULT + (l * 0x1000) + s)
+
 typedef void QEMUResetHandler(void *opaque);
=20
+void qemu_register_reset_with_priority(uint16_t priority,
+    QEMUResetHandler *func, void *opaque);
+
 void qemu_register_reset(QEMUResetHandler *func, void *opaque);
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
 void qemu_devices_reset(void);
--=20
2.17.1


