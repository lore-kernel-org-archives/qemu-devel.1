Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73827C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF39222CF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cRaiQt23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF39222CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDlW-0005Ea-IE
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBDiy-00031E-5T
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBDiw-0000uh-O1
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:53:04 -0400
Received: from mail-eopbgr140108.outbound.protection.outlook.com
 ([40.107.14.108]:59886 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBDis-0000sx-Jp; Fri, 20 Sep 2019 03:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4c9JglCK5djSyOKy/XCI0GQ/7Qit8BOBfMx8176jbxjyZ+6sNzJbCKm74VaXQS4o7rRiEDA2Vcjeq00SYa42CuxfgiTVmnj2Q5uVA8EC+rCnZIqRrx4CZyeCnkTf8aQ2qJyDY4895nc9kCEvSMvpuYHpVgnZtQGX2/jp/g2dUY+f5HJliHsFWWZeVjmco2i5M22v+6HeqaLDK9mY5b5l9Glc+HVbyvadWvS39Te+iZ3+XYjMbbFTxFQ5/03THM+uNfZeY8Z4lcdaUP+Ty7RuFRBrZ4fdKf6U1DR2weHc0jI14Zj3Ffvyk1laYW7wV7cUeSzVjtX43nP3sQjthbmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxmJB1iSYX4e9zOFC8l4Wed4skfNRpq3BBzpx4O03f8=;
 b=JhKOI2oXShRpwaHDX8g8kQFnDy3tw3C0qa6Kxa+UoTFw+ddv7A34H3mSI1ja+5ezwjIzN8lIqpX17r5ETbr3RjVbRkkU3aF6rbHyrmdDThLIWNt0bQrzf/qTVIXuovv0b67gnLyxp5jS4wLzV82r0DblxD+mByaxgceIGm/oCoEqQy7G8CHcQw//2edYAVU5VX/LqLy+tSwLpO/54sPqy+1RB1DJFQa3OPBkAhzaMATfVyAznRsNyxMZNoI3lt2JWd+6T9YCeDb37SPCsxNwfNbr6iwVwZ5b+jJLPhCv01L26n06eEO93e+AvVxC/3p5gwrfA92iEHj1AmdMhrh/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxmJB1iSYX4e9zOFC8l4Wed4skfNRpq3BBzpx4O03f8=;
 b=cRaiQt23qcoOSHFP0+9p8WRmRb10VyIHFltm9LFIIhDGnKRmSICYKRCusaitszaNXsIjcLIMZ9JfMasQ90jFnn2tENyOwrZ4EeW0ERP8c1w6nk+2frVbtFCkQnXi3Lg3Knqk8cHukQ07V/jY2TaBDKJ0i3GPXEsc8BwF9tGAsNk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5417.eurprd08.prod.outlook.com (52.133.241.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 20 Sep 2019 07:52:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 07:52:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
Thread-Topic: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
Thread-Index: AQHVbXIGXsS3qVTuXkS042Ce+aUetqcx27qAgAC2W4CAATQ4gIAAb5+A
Date: Fri, 20 Sep 2019 07:52:55 +0000
Message-ID: <cdac6db0-8530-b431-5205-e22ec15d75c1@virtuozzo.com>
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
 <20190917160731.10895-2-vsementsov@virtuozzo.com>
 <4122264a-f7db-8b76-6930-87e2287c49b8@redhat.com>
 <c1e597ab-5a27-c484-36f8-43734f54bc80@virtuozzo.com>
 <79e21dc0-ad26-e085-d7d9-89cfa66e7123@redhat.com>
In-Reply-To: <79e21dc0-ad26-e085-d7d9-89cfa66e7123@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:7:67::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920105253467
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c27fed2-a9bf-4d5d-382d-08d73d9f8c32
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5417; 
x-ms-traffictypediagnostic: DB8PR08MB5417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54177CE0495DCB42DD2D4084C1880@DB8PR08MB5417.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(189003)(199004)(5660300002)(99286004)(476003)(11346002)(66446008)(66556008)(66476007)(2616005)(486006)(6116002)(31686004)(446003)(8676002)(76176011)(81156014)(81166006)(8936002)(6506007)(3846002)(186003)(102836004)(64756008)(52116002)(386003)(25786009)(53546011)(26005)(54906003)(110136005)(316002)(305945005)(6246003)(4326008)(478600001)(107886003)(256004)(66946007)(229853002)(6436002)(6512007)(2501003)(71200400001)(71190400001)(7736002)(2906002)(14454004)(31696002)(36756003)(66066001)(86362001)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5417;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g278MFkL4eOcfA3yi1dCY4iDIbhkFV8sqCttDdaZ5JQWyXtn1OjvGQHOD69lO40wpoS0d8FFIUSlNHMTHFe3yQM1tErbiWprXsptsvkKp2xNHWUvrJRPpVyoDaci3SZzkNZC2vKXKtd/zUmuzxpH0UdK4W+LWdTQRgNADVoT9wTr6e+bAWuN8Ck5XbBvwgP5e0CWDAgZA4ITdFGk5pH98WQ4X2dq3tOInU2SMfFJg6S65WKp4bWsyNYJKWwcuxROycuhZ1x8PDyQswRV7TjPHQd1uPt/+P7WQG/TdZdxWtio42Thv0y95WxJskk2TssaWLQmztvdyWd9kka8ye/rzzLTg2ZoEo7Hxh/iYbWJM204ApbXoG16orfuhPVy8DIzPPG0VxJ/U+vgY1jZm545s54sNHwiFSd56dO0LTnY+zE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3385F6C1F0914A9C22746807FAFB4E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c27fed2-a9bf-4d5d-382d-08d73d9f8c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 07:52:56.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ihRx5t9TGv0++Y1uybICEd6PBHImbSaDVhUqHO49TR6Wf6vB/hTCi6L0We3BRKXYAx3eh2PtMBRPvi35SVTc5l8V72u49coYIXjlzeX/LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5417
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.108
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSA0OjEzLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8xOS8xOSAy
OjUwIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTguMDkuMjAx
OSAyMjo1NywgSm9obiBTbm93IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA5LzE3LzE5IDEyOjA3
IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+PiBPZiBjb3Vyc2Us
IFFFTVVfQUxJR05fVVAgaXMgYSB0eXBvLCBpdCBzaG91bGQgYmUgUUVNVV9BTElHTl9ET1dOLCBh
cyB3ZQ0KPj4+PiBhcmUgdHJ5aW5nIHRvIGZpbmQgYWxpZ25lZCBzaXplIHdoaWNoIHNhdGlzZnkg
Ym90aCBzb3VyY2UgYW5kIHRhcmdldC4NCj4+Pj4gQWxzbywgZG9uJ3QgaWdub3JlIHRvbyBzbWFs
bCBtYXhfdHJhbnNmZXIuIEluIHRoaXMgY2FzZSBzZWVtcyBzYWZlciB0bw0KPj4+PiBkaXNhYmxl
IGNvcHlfcmFuZ2UuDQo+Pj4+DQo+Pj4+IEZpeGVzOiA5ZGVkNGEwMTE0OTY4ZQ0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgwqAgYmxvY2svYmFja3VwLmMgfCAxMiArKysrKysr
Ky0tLS0NCj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2Jh
Y2t1cC5jDQo+Pj4+IGluZGV4IDc2M2YwZDdmZjYuLmQ4ZmRiZmFkZmUgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+IEBAIC03
NDEsMTIgKzc0MSwxNiBAQCBCbG9ja0pvYiAqYmFja3VwX2pvYl9jcmVhdGUoY29uc3QgY2hhciAq
am9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4gIMKgwqDCoMKgwqAgam9iLT5jbHVz
dGVyX3NpemUgPSBjbHVzdGVyX3NpemU7DQo+Pj4+ICDCoMKgwqDCoMKgIGpvYi0+Y29weV9iaXRt
YXAgPSBjb3B5X2JpdG1hcDsNCj4+Pj4gIMKgwqDCoMKgwqAgY29weV9iaXRtYXAgPSBOVUxMOw0K
Pj4+PiAtwqDCoMKgIGpvYi0+dXNlX2NvcHlfcmFuZ2UgPSAhY29tcHJlc3M7IC8qIGNvbXByZXNz
aW9uIGlzbid0IHN1cHBvcnRlZCBmb3IgaXQgKi8NCj4+Pj4gIMKgwqDCoMKgwqAgam9iLT5jb3B5
X3JhbmdlX3NpemUgPSBNSU5fTk9OX1pFUk8oYmxrX2dldF9tYXhfdHJhbnNmZXIoam9iLT5jb21t
b24uYmxrKSwNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX2dldF9tYXhfdHJh
bnNmZXIoam9iLT50YXJnZXQpKTsNCj4+Pj4gLcKgwqDCoCBqb2ItPmNvcHlfcmFuZ2Vfc2l6ZSA9
IE1BWChqb2ItPmNsdXN0ZXJfc2l6ZSwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBRRU1VX0FMSUdOX1VQKGpvYi0+Y29w
eV9yYW5nZV9zaXplLA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBqb2It
PmNsdXN0ZXJfc2l6ZSkpOw0KPj4+PiArwqDCoMKgIGpvYi0+Y29weV9yYW5nZV9zaXplID0gUUVN
VV9BTElHTl9ET1dOKGpvYi0+Y29weV9yYW5nZV9zaXplLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4gK8KgwqDCoCAvKg0KPj4+PiAr
wqDCoMKgwqAgKiBDb21wcmVzc2lvbiBpcyBub3Qgc3VwcG9ydGVkIGZvciBjb3B5X3JhbmdlLiBB
bHNvLCB3ZSBkb24ndCB3YW50IHRvDQo+Pj4+ICvCoMKgwqDCoCAqIGhhbmRsZSBzbWFsbCBtYXhf
dHJhbnNmZXIgZm9yIGNvcHlfcmFuZ2UgKHdoaWNoIGN1cnJlbnRseSBkb24ndA0KPj4+PiArwqDC
oMKgwqAgKiBoYW5kbGUgbWF4X3RyYW5zZmVyIGF0IGFsbCkuDQo+Pj4+ICvCoMKgwqDCoCAqLw0K
Pj4+PiArwqDCoMKgIGpvYi0+dXNlX2NvcHlfcmFuZ2UgPSAhY29tcHJlc3MgJiYgam9iLT5jb3B5
X3JhbmdlX3NpemUgPiAwOw0KPj4+PiAgwqDCoMKgwqDCoCAvKiBSZXF1aXJlZCBwZXJtaXNzaW9u
cyBhcmUgYWxyZWFkeSB0YWtlbiB3aXRoIHRhcmdldCdzIGJsa19uZXcoKSAqLw0KPj4+PiAgwqDC
oMKgwqDCoCBibG9ja19qb2JfYWRkX2JkcnYoJmpvYi0+Y29tbW9uLCAidGFyZ2V0IiwgdGFyZ2V0
LCAwLCBCTEtfUEVSTV9BTEwsDQo+Pj4+DQo+Pj4NCj4+PiBJJ20gY2xlYXIgb24gdGhlIGFsaWdu
bWVudCBmaXgsIEknbSBub3QgY2xlYXIgb24gdGhlIGNvbW1lbnQgYWJvdXQgbWF4X3RyYW5zZmVy
IGFuZCBob3cgaXQgcmVsYXRlcyB0byBjb3B5X3JhbmdlX3NpemUgYmVpbmcgbm9uLXplcm8uDQo+
Pj4NCj4+PiAic21hbGwgbWF4IHRyYW5zZmVyIiAtLSB3aGF0IGhhcHBlbnMgd2hlbiBpdCdzIHpl
cm8/IHdlJ3JlIGFwcGFyZW50bHkgT0sgd2l0aCBhIHNpbmdsZSBjbHVzdGVyLCBidXQgd2hlbiBp
dCdzIHplcm8sIHdoYXQgaGFwcGVucz8NCj4+DQo+PiBpZiBpdCB6ZXJvIGl0IG1lYW5zIHRoYXQg
c291cmNlIG9yIHRhcmdldCByZXF1aXJlcyBtYXhfdHJhbnNmZXIgbGVzcyB0aGFuIGNsdXN0ZXJf
c2l6ZS4gSXQgc2VlbXMgbm90IHZhbGlkIHRvIGNhbGwgY29weV9yYW5nZSBpbiB0aGlzIGNhc2Uu
DQo+PiBTdGlsbCBpdCdzIE9LIHRvIHVzZSBub3JtYWwgcmVhZC93cml0ZSwgYXMgdGhleSBoYW5k
bGUgbWF4X3RyYW5zZmVyIGludGVybmFsbHkgaW4gYSBsb29wIChjb3B5X3JhbmdlIGRvZXNuJ3Qg
ZG8gaXQpLg0KPj4NCj4gDQo+IG9oLCBJJ20gLi4uIHNvcnJ5LCBJIGp1c3QgZGlkbid0IHF1aXRl
IHVuZGVyc3RhbmQgdGhlIGNvbW1lbnQuDQo+IA0KPiBZb3UncmUganVzdCBtYWtpbmcgc3VyZSBj
b3B5X3JhbmdlIGFmdGVyIGFsbCBvZiBvdXIgY2hlY2tzIGlzIG5vbi16ZXJvLA0KPiBwbGFpbiBh
bmQgc2ltcGxlLiBJZiBtYXhfdHJhbnNmZXIgd2FzICpzbWFsbGVyIHRoYW4gYSBqb2IgY2x1c3Rl
ciosIHdlDQo+IG1pZ2h0IGVuZCB1cCB3aXRoIGEgY29weV9yYW5nZSBzaXplIHRoYXQncyB6ZXJv
LCB3aGljaCBpcyBvYnZpb3VzbHkuLi4NCj4gbm90IHVzZWZ1bC4NCj4gDQo+IFNvLCBJIG1pZ2h0
IHBocmFzZSAiQWxzbywgd2UgZG9uJ3Qgd2FudCB0by4uLiIgYXM6DQo+IA0KPiAiY29weV9yYW5n
ZSBkb2VzIG5vdCByZXNwZWN0IG1heF90cmFuc2Zlciwgc28gd2UgZmFjdG9yIHRoYXQgaW4gaGVy
ZS4gSWYNCj4gaXQncyBzbWFsbGVyIHRoYW4gdGhlIGpvYi0+Y2x1c3Rlcl9zaXplLCB3ZSBhcmUg
dW5hYmxlIHRvIHVzZSBjb3B5X3JhbmdlLiINCg0KDQpXZSBhY3R1YWxseSBhYmxlIHRvOiBqdXN0
IHVzaW5nIGEgbG9vcCBhbmQgY2FsbGluZyBjb3B5X3JhbmdlIHNldmVyYWwgdGltZXMuIE1heSBi
ZSBqdXN0Og0KDQpjb3B5X3JhbmdlIGRvZXMgbm90IHJlc3BlY3QgbWF4X3RyYW5zZmVyLCBzbyB3
ZSBmYWN0b3IgdGhhdCBpbiBoZXJlLiBJZg0KaXQncyBzbWFsbGVyIHRoYW4gdGhlIGpvYi0+Y2x1
c3Rlcl9zaXplLCB3ZSBkbyBub3QgdXNlIGNvcHlfcmFuZ2UuDQoNCj4gDQo+IEp1c3QgYSBzdWdn
ZXN0aW9uLCB0aG91Z2gsIHNvOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEpvaG4gU25vdyA8anNub3dA
cmVkaGF0LmNvbT4NCj4gDQo+IA0KPiAoU0hPVUxEIGNvcHlfcmFuZ2UgcmVzcGVjdCBtYXhfdHJh
bnNmZXI/IEkgZ3Vlc3MgaXQgd291bGQgYmUgcXVpdGUNCj4gZGlmZmVyZW50IC0tIGl0IHdvdWxk
IG9ubHkgY291bnQgdGhpbmdzIGl0IGhhZCB0byBmYWxsIGJhY2sgYW5kIGFjdHVhbGx5DQo+ICp0
cmFuc2ZlciosIHJpZ2h0PyBJIHN1cHBvc2UgdGhhdCBiZWNhdXNlIGl0IGNhbiBoYXZlIHRoYXQg
ZmFsbGJhY2sgd2UNCj4gbmVlZCB0byBhY2NvbW1vZGF0ZSBpdCBoZXJlIGluIGJhY2t1cC5jLCBo
ZW5jZSB0aGlzIHdvcmthcm91bmQgY2xhbXAuKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

