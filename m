Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A56C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94E22074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SW2TU4GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94E22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEVa-00056Y-1f
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhEUO-0003Cb-NL; Fri, 05 Jun 2020 11:42:36 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
 ([40.107.3.121]:22798 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhEUM-00038Y-5g; Fri, 05 Jun 2020 11:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fidUbRrTbeyg2RY26z+oHitIMRFuY1oUUWp5K2svbAnaEznUdlzw3hWroAiil+9Ud91rcYBUCatEcOEg1p+TEsfBV4mya9qp8riYmj2oDkjbHzdgxXjgK7m5yDueXEXYKgnF9oz0myPorCrhIG8Y3tBYx4NE7gaV29Py5aAHnjXw3lIFYk1My57LVEfnzgTWk29cO4urbVcZo2P0i4ZZTYhwdAB6eAXik1ZwRPGGFhI+O9DD4LIwH3+BZgZYzjwiIM5EgxqhQA+EJc85mSyga/2uLec9VJDlggFCTve85KbOyBZPQ6l3AE7letEDXVCVGD9yqfzGurZUL70mJe3bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJCHOzC2m1GKtprTdqtYNQtv7unkTIfYoKYeTMtYJyA=;
 b=TT1seqmvrfI50A1LaYqiB4RVpkK0GdzZ/SKWaRI6JdLCYeYIjtTWqtrkGPjI5svJsCT5tUViFphQab8GYichU/EusuP/OjmMJhsKxzJf/4l9zQh8vPaPE2TA5/ow+yc6HLcx8vQ8ph6YLfOTaj/HEC1W9uSiO1NWjwVh7iFSX0iqZK9RrZ75WvnzIskuJuJAlAnP9gWotf+4F/pJ4rv2S84Cp3UTiPUkR8rFEqd65GXIC5rQ8Q4t3YppQ3Qu/rW/D/SUnTbVrELygAeN285htOqttQNuazVUkMt1FRhAaTQz0H5D7BEEfvH0ZIuaFX/AKIRQHEmK12XjOkMB5OnO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJCHOzC2m1GKtprTdqtYNQtv7unkTIfYoKYeTMtYJyA=;
 b=SW2TU4GX6oachkzhaJHC/9sokqJmL+FV3m/EUmcGNyjshvRzT2FIqwljcNmrbKVwHWrqrTfZUiQDPxXSgfnzF5VI6sYjXF8wNhpxdqpeQRXxIxK7KKeIC148t4tsrr3RQXwj4rhbp1VxCLq1/pHxeV6Q0uAJyb2dzPnHZTP3r/Q=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4900.eurprd08.prod.outlook.com (2603:10a6:20b:cc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 15:42:31 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 15:42:31 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Topic: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Index: AQHWOpdy6/Wb86tljUm8ajfBu7uJMajKKjq6
Date: Fri, 5 Jun 2020 15:42:31 +0000
Message-ID: <AM6PR08MB4070C8B17B9929366548E98AF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-12-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-12-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 833a6338-90a6-41b0-4400-08d809670f12
x-ms-traffictypediagnostic: AM6PR08MB4900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB49007BDF5547A1D4FB8C592FF4860@AM6PR08MB4900.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYaH95O5YtvXHVLpNGBMRzbSg+rEk4jxY9pfXXyzpn5Vc+18di0avky1+qAYQrDKGJiUBZxb2/gxo359KAp9zW5zGkZ1soCljtUQIBHsvprmqdAYIAJY1aCCvkYIcHctTZCCU/NV6/klRbazBVz7wFizgRvuJh5dqrub8ocDini3GlOAelkXc6/bfOG/phA5+OXhaUntrtQfIr5gUi/3BBhlU7UlT5j5t35Q9D48OqX65yeOw86g9Oc7l50kxSJhpIJNBujkNZJNLdCcl3G+9m1F2Sc+x0Hg2Hqsa6KaczrN5lgatFip/M9gpR4zwkMsl+EWPWqStC7ddj6IeSSz9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(8676002)(6506007)(33656002)(4326008)(86362001)(7696005)(66476007)(76116006)(53546011)(55016002)(316002)(64756008)(71200400001)(8936002)(52536014)(66946007)(5660300002)(66556008)(91956017)(66446008)(186003)(2906002)(54906003)(478600001)(44832011)(110136005)(26005)(83380400001)(107886003)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OxtHomS7Gi8Q58HYx2KxoRO7B71f6NfZpRazlJE6L67JDzyK3X5MagEzjHcmqHpcKz0747EArTw0cK7ZDCeEa6rQ1r6ZZa/eKlwwtzumgoKrhCiDOaWTm/5QCR0unXBqyMf8cIapBAJv4KHMb5mPGrHQotw7Df6tU0YSVcEOgOlCBV7u5HgaqpwpQxYMP/p59z1sASvl9BgBUQyy1vKFYyZ0f+EJLd8dw1Mpd4LoiXSCQ9ftl3Dm13x16iV+85hkJ700H/FJhlphoi+alJUEO/6Ul/SpTs0vTQCplUZgykQsz3HGK4IFA7h5nit0G0xYb7FtcaIxwx2Rp0HLhTpQwuk0CbRgOT/egwxHJ4/YFdcQZfcwsBjWHyOk4EAXc5trO+N+gQEUTn2WehVu4+e2vK1yEGwTDkEMXitzFHw2p4zYy8nPoP7RU9XmIBFLXkDetdeo6yDjgtKvwGgItK9kxhvWYc5n/UY+FJ8IxCNNuXNJT+tc/MMwqIMhSlt56aFT
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070C8B17B9929366548E98AF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833a6338-90a6-41b0-4400-08d809670f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 15:42:31.0782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy/cCsmo/rc5lqRN5trsrYV4i8zw+XPzKHZZViieaPtA7t8fyr/4P3lfUtjsrYpaVtj4hq6p69edzOpoWr8X010ZvA7d31C0pBP217Rpkmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4900
Received-SPF: pass client-ip=40.107.3.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 11:42:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB4070C8B17B9929366548E98AF4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

s/0xE2792ACA/0xe2792aca/
(as suggested by Eric)

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Thursday, June 4, 2020 8:41 PM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Vladimir Sementsov-Ogievsk=
iy <vsementsov@virtuozzo.com>; Andrey Shinkevich <andrey.shinkevich@virtuoz=
zo.com>
Subject: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for extens=
ion magics

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 5a4beda6a2..e0225f4247 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -53,7 +53,7 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -81,12 +81,12 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0xe2792aca
+magic                     3799591626 (Backing format)
 length                    11
 data                      'host_device'

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -116,12 +116,12 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -149,12 +149,12 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -182,17 +182,17 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0xe2792aca
+magic                     3799591626 (Backing format)
 length                    11
 data                      'host_device'

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'

diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf60e..6cf892123a 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -25,7 +25,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -37,7 +37,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a51ad1b5ba..7afd2be9d9 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -83,7 +83,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -139,7 +139,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -194,7 +194,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -263,7 +263,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -325,7 +325,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

@@ -354,7 +354,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py
index 4683b1e436..caa190f7b1 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -21,6 +21,12 @@ class Flags64(Qcow2Field):
         return str(bits)


+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value} ({self.mapping.get(self.value, "<unknown>")}=
)'
+
+
 class Qcow2StructMeta(type):

     # Mapping from c types to python struct format
@@ -75,8 +81,17 @@ class Qcow2Struct(metaclass=3DQcow2StructMeta):

 class QcowHeaderExtension(Qcow2Struct):

+    class Magic(Enum):
+        mapping =3D {
+            0xE2792ACA: 'Backing format',
+            0x6803f857: 'Feature table',
+            0x0537be77: 'Crypto header',
+            0x23852875: 'Bitmaps',
+            0x44415441: 'Data file'
+        }
+
     fields =3D (
-        ('u32', '{:#x}', 'magic'),
+        ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
         # length bytes of data follows
         # then padding to next multiply of 8
--
2.21.0


--_000_AM6PR08MB4070C8B17B9929366548E98AF4860AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>s/<span style=3D"font-family: &quot;Segoe UI WestEuropean&quot;, &quot=
;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-size: 14.6667px; font-s=
tyle: normal; font-variant-ligatures: normal; font-variant-caps: normal; fo=
nt-weight: 400;">0xE2792ACA/</span><span style=3D"font-family: &quot;Segoe =
UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; =
font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; f=
ont-variant-caps: normal; font-weight: 400;">0xe2792aca/</span></div>
<div><span style=3D"font-family: &quot;Segoe UI WestEuropean&quot;, &quot;S=
egoe UI&quot;, Helvetica, Arial, sans-serif; font-size: 14.6667px; font-sty=
le: normal; font-variant-ligatures: normal; font-variant-caps: normal; font=
-weight: 400;">(as suggested by Eric)</span></div>
<div><br>
</div>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.67px; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400;">Reviewed-by: Andrey
 Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;</span><br>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Thursday, June 4, 2020 8:41 PM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;;
 Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for=
 extension magics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Suggested-by: Andrey Shinkevich &lt;andrey.shinkev=
ich@virtuozzo.com&gt;<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/031.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 22 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
--<br>
&nbsp;tests/qemu-iotests/036.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;tests/qemu-iotests/061.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 17 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;4 files changed, 36 insertions(&#43;), 21 deletions(-)<br>
<br>
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out<br>
index 5a4beda6a2..e0225f4247 100644<br>
--- a/tests/qemu-iotests/031.out<br>
&#43;&#43;&#43; b/tests/qemu-iotests/031.out<br>
@@ -25,7 &#43;25,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 72<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
@@ -53,7 &#43;53,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 72<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
@@ -81,12 &#43;81,12 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 72<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xe2792aca<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3799591626 (Backing=
 format)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'host_device'=
<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
@@ -116,12 &#43;116,12 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
@@ -149,12 &#43;149,12 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
@@ -182,17 &#43;182,17 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xe2792aca<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3799591626 (Backing=
 format)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'host_device'=
<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x12345678<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 305419896 (&lt;unkn=
own&gt;)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'This is a te=
st header extension'<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out<br>
index e409acf60e..6cf892123a 100644<br>
--- a/tests/qemu-iotests/036.out<br>
&#43;&#43;&#43; b/tests/qemu-iotests/036.out<br>
@@ -25,7 &#43;25,7 @@ incompatible_features&nbsp;&nbsp;&nbsp;&nbsp; []<br>
&nbsp;compatible_features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; []<br>
&nbsp;autoclear_features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [63]<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -37,7 &#43;37,7 @@ incompatible_features&nbsp;&nbsp;&nbsp;&nbsp; []<br>
&nbsp;compatible_features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; []<br>
&nbsp;autoclear_features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; []<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out<br>
index a51ad1b5ba..7afd2be9d9 100644<br>
--- a/tests/qemu-iotests/061.out<br>
&#43;&#43;&#43; b/tests/qemu-iotests/061.out<br>
@@ -25,7 &#43;25,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -83,7 &#43;83,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -139,7 &#43;139,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -194,7 &#43;194,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -263,7 &#43;263,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -325,7 &#43;325,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
@@ -354,7 &#43;354,7 @@ refcount_order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;header_length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 112<br>
&nbsp;<br>
&nbsp;Header extension:<br>
-magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6803f857<br>
&#43;magic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1745090647 (Feature=
 table)<br>
&nbsp;length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 336<br>
&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;binary&gt=
;<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py<br>
index 4683b1e436..caa190f7b1 100644<br>
--- a/tests/qemu-iotests/qcow2_format.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2_format.py<br>
@@ -21,6 &#43;21,12 @@ class Flags64(Qcow2Field):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return str(bits)<br>
&nbsp;<br>
&nbsp;<br>
&#43;class Enum(Qcow2Field):<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; def __str__(self):<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return f'{self.value} ({sel=
f.mapping.get(self.value, &quot;&lt;unknown&gt;&quot;)})'<br>
&#43;<br>
&#43;<br>
&nbsp;class Qcow2StructMeta(type):<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; # Mapping from c types to python struct format<br>
@@ -75,8 &#43;81,17 @@ class Qcow2Struct(metaclass=3DQcow2StructMeta):<br>
&nbsp;<br>
&nbsp;class QcowHeaderExtension(Qcow2Struct):<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp; class Magic(Enum):<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xE=
2792ACA: 'Backing format',<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6=
803f857: 'Feature table',<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
537be77: 'Crypto header',<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2=
3852875: 'Bitmaps',<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4=
4415441: 'Data file'<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; fields =3D (<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ('u32', '{:#x}', 'magic'),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ('u32', Magic, 'magic'),<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ('u32', '{}', 'length')<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # length bytes of data fol=
lows<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # then padding to next mul=
tiply of 8<br>
-- <br>
2.21.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070C8B17B9929366548E98AF4860AM6PR08MB4070eurp_--

