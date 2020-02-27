Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67CC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795272468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="a0n4WBtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795272468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hif-0005qz-LJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7HhU-0004YX-Si
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7HhT-0002gn-6R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:51:32 -0500
Received: from mail-eopbgr1280119.outbound.protection.outlook.com
 ([40.107.128.119]:30380 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>) id 1j7HhS-0002Xq-Q3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:51:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlhFk6F3Yg8H7L5XE9+TY9j9p/bU4A3ZiS2khubMk8CCioyRDOiOeE8HZJiz3A4FiooaMQrJO1Z4BhotHnhOC92+5xV59/P8EdVFPVxwftg2Z1YrBkQtRT4F5LNk1XNBCDS8zcp8Bosn+zzcc+zNqsAhfjioAropjF/zlJZ5vTDkdlIUMu+DET0fM90KYqWF+hNsdhsUWF5zSZ2yvXvpA/y4HE44yLGosN5CG9kdDTdhyBf7VFu9Kx1vGp7Cra6B8bzajP+c1TxbJW5mYP7STWJYBFCURuaeTglyVbPkoAp0uAgUvZaxRjGnwXlnVAPL7pefjE9AnZGpXjLZZRiZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5HvCc0r/MNF4aiw65zs50xkNsdQHf63wlQ0XqU2IEk=;
 b=LujefiId2qE4meLohXI345ANW3ig/N/n7co88CZ6gy9POZq8BTAfLYiNYYlg/0gZNRa9Gi42R6XxIt2RQu4OsWvoNNNc42WmS4r69GjX6EClKXNQu+90B+1wko6WkSkcQaviWUibfg7RsvggF3Z1Cye9RuTQ0wyhu1/Hl5+UWwVzR4X7Efi3NNZ24T1KJl6zSFJtsJ4cRqbF72MpmckFjG9iB7y0i116y/BYz3E5IrgJVcT3FC6ZKczfQyDcj/p5RBLms9bmnfCz0b7eIobbStxmRjVrPBZU19C7/R7QzDCECzJvksYF2/sJkD0AmlvxysiK2l9zcqyJrDvkft2eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5HvCc0r/MNF4aiw65zs50xkNsdQHf63wlQ0XqU2IEk=;
 b=a0n4WBtpXTaVdYZ1eEEYMH+/bAhgoim+7iffobXblEqdpLhKT9zItkT9QQrqK3zS59NlV+JdnR6W2W6MW2eDNocBG8H7rZ/yTkYVTfc8ocTyaFnBwk+ssuBa+hTdbn2JYiPoT5F4QXYiczBXEf0E4wx7x1mVlG8Ml6cEk+VP3Kg=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0351.KORP216.PROD.OUTLOOK.COM (10.174.41.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 11:51:26 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:51:25 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 11:51:24 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH v2 1/2] hw/core: Support device reset handler priority
Thread-Topic: [PATCH v2 1/2] hw/core: Support device reset handler priority
Thread-Index: AQHV7WQ98J8teEqi+0udzomYEWjImQ==
Date: Thu, 27 Feb 2020 11:51:25 +0000
Message-ID: <20200227115005.66349-2-root@stephanos.io>
References: <20200227115005.66349-1-root@stephanos.io>
In-Reply-To: <20200227115005.66349-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50956d2d-a1de-4efe-017f-08d7bb7b5fb4
x-ms-traffictypediagnostic: SLXP216MB0351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB0351A2A04A7607938A162DA5BDEB0@SLXP216MB0351.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(26005)(316002)(54906003)(956004)(4326008)(2616005)(36756003)(109986005)(2906002)(478600001)(16526019)(186003)(6486002)(81166006)(8676002)(81156014)(71200400001)(8936002)(1076003)(5660300002)(86362001)(52116002)(6506007)(66946007)(6512007)(66476007)(66556008)(64756008)(66446008)(36456003)(42976004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0351;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjbIqX5goeE2tH7EsNYLZz0JpIbZyYLiWrDSGV2/AcDLOBpbnse48NxxvoTriG5aNdEMbY8JaALO2eHIFFm1ogDXhv/OdJoyc6YjwLxsf9fpKDYhxeC+x+sxhZ6n0kfd91P79BR+0DTu6q8kAFlFuy10LU8Rf6Lmwi66eVPbJ+MDsvoXE7lDkskHVqCvYAa44HGTKFe0SdGmT97dUiidZCk9+IMaeJSZPznLHe8UvJEU5cnXw5xLD743qvfTDEFuQFkbBIHPodYaJkgLY6fAoGp3k+VBmltU0SSUcu8Xo3uQ5aY+A2ksxrOM10HwYG/iotIF2afC81GQGlShm8tv4de+b8ZSVqcvICoGMV/SmGqyDdZeAIg90P/GsYSs5fOfUsfwmBrqGddZJbQaJOxHq6ub6AAQEaL3W5WaaNuEV4rTN6qYI1xdRoTvW4UtcSGQtcqY+y37dNvcmbbNFvWj9RWZ2yYGwXKjMTBQjPIifkQgA0YkhnmNfUquVKa2jUgPOog6BO1xkJ4DU7nn+NEpBw==
x-ms-exchange-antispam-messagedata: A1E3j0/pRd2tCVsHEDNwM+KFwCWM4L/vGH3pzFesaJX5Xsxz1uxj3NzL14N9y7UqFYuw/N83iEgUk1jBPPn4XaS5+tn+OjpFIymRatEDsTB7xm3mrmtfzHPZrphp+xjdVWsn24qKiQpDdMB4OtLfJw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 50956d2d-a1de-4efe-017f-08d7bb7b5fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:51:25.9477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A/Q+ZwYAYq+G3FJwpipVEPD0/fwj9sSFMdkK0HMavrq3zOn6KBgnVlQuOLL8nSYnEoCsPYY6lYGjsC6B87AOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0351
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.119
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


