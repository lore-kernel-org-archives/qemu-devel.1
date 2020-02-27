Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27162C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04D824688
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="f4CAzA/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04D824688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KmY-0007p3-4E
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7Klu-0007HS-0f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7Kls-0006Mb-VT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:08:17 -0500
Received: from mail-eopbgr1280100.outbound.protection.outlook.com
 ([40.107.128.100]:51527 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1j7Klq-0006D8-3G; Thu, 27 Feb 2020 10:08:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ/0tzUuOWKdP+INqTfEi/dJava8LsvaB0q21ARam84YCG3LJiiHP0rcoE4bKfEo8ivP3FzVLwA9urtWpJTp4fxI47YOOJsQ5LyiJvriWfHT0F8mDWAgzgP2rOsb2/Iur3BpRQXeauuOWzJk77hfYtGUdA3+0Ia+k3MCF4TZO7tz0khD1Qy2hrYnau49DhrppsReQAvqbaE0NRiJCJdO8OY7EFslnKorsYy4jz6Fsv8kBQauJQSIjS23+CMitGM1Sb71uIOR13c+hC/DS9NenNSYirfK1xHfJpA1P3bSBSkcDjU9z7V3DOcTChheAg1U+MJnI/dGD8AD0eQBLpyMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFcC8PYHes/XJgSfNQjDipS1POXIWjrLr+6Kroh2ZZg=;
 b=QqYi2La+Yj9Zt5epzPHkvG4duHO3Ij4dQJdUzIJ8zGVsyyrD/uzPr5jME5r6CfwPJhqEKnGTC/Xcalluu8JScB4nXVd1XlRg3JnRLgPr8Je/UbYUIYABVg5sTP1j9eZ8Bj16CwH+s3ukKbMy8U5sB3a6vNJjI+QNjyHGxpepQmUkIe6PtnGyzGmsLWCgs9uY3Ba9yH5kz5H3qW4W9lzkN0Of9GeaPBPkLKOhxG5XgTFWj/iQjDKp1BFXTAK3nJ0b5cZDYux+YXxnwpy/oPMzH8WKs8d2LdHwSuZZ8Ps9l0nOeqhIh8rZWW+EmlriILLAtfAnpR7DD5eNyYdJQa4aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFcC8PYHes/XJgSfNQjDipS1POXIWjrLr+6Kroh2ZZg=;
 b=f4CAzA/01lBJ/9fd8Ro0zn9MejGICj5UBl+5jcK1lOy6reHfl1SjdKgBp5Cx2iXiDbXgZxstjvh6Ukirde39RkcOWsm0vMAtPoEExxtZQgyZFcvx0li7O+e2vOyif8+iFsSezNSK2Xd1fEJ19vvIW6GipDUFmk/icrbVV9vF52o=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0112.KORP216.PROD.OUTLOOK.COM (10.174.39.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 15:08:09 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 15:08:09 +0000
From: Stephanos Ioannidis <root@stephanos.io>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
Thread-Topic: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
Thread-Index: AQHV7WDamNGXYjwsUEm9K1g4p+T2pKgu8+SAgAAW84CAAAZ6QA==
Date: Thu, 27 Feb 2020 15:08:09 +0000
Message-ID: <SLXP216MB0285F1E97DBA3FDED2ED72D2BDEB0@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
References: <20200227112617.66044-1-root@stephanos.io>
 <20200227112617.66044-2-root@stephanos.io>
 <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
 <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
In-Reply-To: <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-originating-ip: [59.151.229.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50e1f440-ef12-4d6a-52f0-08d7bb96db6a
x-ms-traffictypediagnostic: SLXP216MB0112:
x-microsoft-antispam-prvs: <SLXP216MB01125DCC248FFBEC0F49D9A2BDEB0@SLXP216MB0112.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(54906003)(52536014)(2906002)(76116006)(66556008)(66446008)(64756008)(66476007)(81156014)(110136005)(66946007)(53546011)(26005)(8676002)(8936002)(81166006)(33656002)(4326008)(71200400001)(316002)(5660300002)(186003)(9686003)(966005)(7696005)(6506007)(86362001)(508600001)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0112;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lc3XlKA2IwGALA25qKvB7SQ6WmWqEnwLE4nEVh5BNOMBDrpZBx3qR4xUJxRaZ+wiAor+QBXcgr1lyLSR3g08/bTyORGB5Oo36Qcj/QSFjuRLR8WxIV7wBAxqNqN8YbYk8hFdfp6/rxcyZ9VZH/h81MXwkrr9wELE1QiFZNSd1sc/+X6yMzUY45xy7TBOiWmo2O4kANIiidrkN/HkAox/8NM9q9q07dxZHtDqsokLiCX8d00zKN12ptaM1TS9FHzbRkkHnx3Av4k7ACak7eI+mVH4u2dUv+d8RHGiWkeCd8N9flwKDmddWoGvRw+xyllsjnMDM4xpiqSklfspun28Q4UxSUvRoWyDW7ZpXDk8v0yoFbChQPEfisCHYqfoq8vSW2qAmppf5kywfBZtthGzn0OL2FRWjrjZWAeyo/kuTpSRRvMVzitXxhOA3FG4CSjruO4pdTzhXEaCqfpTEnaDGx9oeNdKm8hI2aHM4o3DHY24OqwFXsmBrj/F8PSBYHKW/XAKYft4lb8f3Zjsxdgcfw==
x-ms-exchange-antispam-messagedata: Y5vf9zb67g5ZZyTOfl/v1ttKbspOGIW/JT+ZqwC6Rb933499IxakDB4lP2Jp7Gq7RymKmHyZq622HrLJH78gtzwbJyhLLGeRaBTyFgaUrZxgbfWMfArAfV8V+LBsdywfr8Y/3YyUi67DBTk/HeNPbA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e1f440-ef12-4d6a-52f0-08d7bb96db6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 15:08:09.5891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHYIPMzCBgwpeSU/3HERpD6E1wJgnromOFUKIXGGeyEtEoTI5HE7uJJu0GNg62XRvdig+ShbCeK/2ucSY4C5sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0112
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.100
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
Cc: Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIgYW5kIFBoaWxpcCwNCg0KVGhhbmtzIGZvciB5b3VyIGluc2lnaHQgb24gdGhpcyBt
YXR0ZXIuDQoNCkkgYW0gb2theSBhcyBsb25nIGFzIHRoaXMgaXNzdWUgaXMgZ29pbmcgdG8gYmUg
ZXZlbnR1YWxseSBmaXhlZCBpbiBvbmUgd2F5IG9yIGFub3RoZXI7IHRoZSB0aHJlZS1waGFzZSBy
ZXNldCBzY2hlbWUgeW91IG1lbnRpb25lZCBkb2VzIHNvdW5kIGxpa2UgYSBtb3JlIG1hbmFnZWFi
bGUgYXBwcm9hY2ggZm9yIHRoaXMgcHVycG9zZTsgdGhvdWdoLCBJIHN0aWxsIGJlbGlldmUgaGF2
aW5nIHRoZSBvcHRpb24gdG8gc3BlY2lmeSB0aGUgaW52b2NhdGlvbiBwcmlvcml0eSBmb3IgcmVz
ZXQgaGFuZGxlcnMgd291bGQgY29tZSBpbiBoYW5keSBpbiB0aGUgZnV0dXJlIGZvciB2YXJpb3Vz
IHB1cnBvc2VzLg0KDQpPbiAyLzI3LzIwIDEwOjMxIFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gSSB0aGluayBBbGlzdGFpciBhbmQgbXlzZWxmIHVzZSB0aGUgJ2xvYWRlcicg
ZGV2aWNlIHdpdGggQ29ydGV4LU0gYm9hcmRzIGFuZCBuZXZlciBoaXQgdGhpcyBwcm9ibGVtLg0K
DQpJIHRyaWVkIGJvdGggYC1rZXJuZWwgW0VMRiBJTUFHRV1gIGFuZCBgLWRldmljZSBsb2FkZXIs
ZmlsZT1bRUxGIElNQUdFXWAgd2l0aG91dCBhbnkgc3VjY2VzczsgaW4gYm90aCBjYXNlcywgd2l0
aG91dCB0aGlzIHBhdGNoLCBRRU1VIGhhcmQtZmF1bHRzIGR1cmluZyBzdGFydC11cCBkdWUgdG8g
dGhlIHVuYXZhaWxhYmlsaXR5IG9mIHRoZSB2ZWN0b3IgdGFibGUgY29udGVudCBhdCB0aGUgdGlt
ZSBvZiBDUFUgcmVzZXQuDQoNCk1heWJlIHlvdXIgZmlybXdhcmUgaW1hZ2UgaGFzIGEgbG9hZCBh
ZGRyZXNzIG9mIDB4MCBpbnN0ZWFkIG9mIDB4ODAwMDAwMD8NCg0KVGhlIGZvbGxvd2luZyBpcyB0
aGUgTUFQIGZpbGUgZm9yIHRoZSBmaXJtd2FyZSBpbWFnZSBJIGFtIHRlc3Rpbmcgd2l0aDoNCmh0
dHBzOi8vZ2lzdC5naXRodWIuY29tL3N0ZXBoYW5vc2lvLzk3ZDFmNDdmOTYyODQ0NDc5YTc2ZTBl
OTA5YTNiOGNmDQoNClJlZ2FyZHMsDQoNClN0ZXBoYW5vcyANCg==

