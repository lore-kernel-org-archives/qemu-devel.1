Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6482F2184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TqVrjwob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6482F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2c80-0002Sh-KV
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2c5Z-00087u-8T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2c5Y-0006GO-3p
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:04:49 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com
 ([40.107.7.130]:7811 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2c5K-0006Ab-9v; Tue, 27 Aug 2019 10:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XONoqz7aMHmy7+nJ/VoPWKCroCAJYbkRHP1dpBfk4q3bZ5faISoDKklJzhGVK7JfCvh+iQ4tM/sA8aru3r64S7JZNaSzGg5mtaIksmIbCW7WJ21XcE0NKLmNpIzvORFeDgOYzIUgF2JyInL4eqTGOEmD17jWrjNALpF5Buid31oFVAEWlJueFJ17w/0DFLBaZDVhnsaGi7qIQWHHRziRLalWomDUynlHu6bcZ+9JOKkxhMHUAHOx+3v8pe9WwYkBGJEl0DIDUjuOYbo/ycc6l8/2psJOIhloOB9xODxfH9n84FCLCtWuSeiy5EpZQVCWwy7cSejIXYYV5hO+eM01Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSZzlSUi6fivwhOVvPhA8gHauMn+woX3ejVfGfKkezg=;
 b=DXnkd9EU7lFnGoz7NS7u1c8SM/epjvA5oCE4iEM8HTU/x5s3YZ44O2dFgqe8g1TdQi267hpAvOqnraKoZTj/8ku8slL7LB44Ov2Z9PwFsBjU9+Bd+HQuMgDcd1q7a6YO1lKyfLNmPiaa8lnTInUOi9Rf7rzUVuY2TfXCjFtBzPQEZ8MW+lK9lzHQD7Q7P09+xxaXzNxDw8B4jexvzRA/FDH+8oYnH/wIkWsv11tPeWTOhmzAkDz9TtA3Tg97yuadF2RvbyPrwE0tiRcc0R1ItzYE2/Fv0OFfKCCpTKKks1uh9uSQrdDC11HtbyGfngu2sWpBvwTcHA+m0qDF3GaDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSZzlSUi6fivwhOVvPhA8gHauMn+woX3ejVfGfKkezg=;
 b=TqVrjwobGwhcO05OlslVGS6Rhn3iQqwHYLoAJYHLQdaYYgTWUUEdO9IDybbuNsHLfsN7XRvWbsfJxbCBC4Dbm5UQFhFt3rZHDl/1yfu0iozme5Tob6j0JcAS5ooWxt5aVms/5pzXbtNNc164hN8DtQwFDfGfqsEmWo0Or55/jBk=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3806.eurprd08.prod.outlook.com (20.178.14.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 14:04:30 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 14:04:30 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] block: workaround for unaligned byte range in
 fallocate()
Thread-Index: AQHVXN6/9zhncFLxI0q6RGEW621xhKcPBHWAgAACewA=
Date: Tue, 27 Aug 2019 14:04:30 +0000
Message-ID: <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>
References: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
In-Reply-To: <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0029.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::15) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a59070-67f4-4f66-ecdf-08d72af77ad3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3806; 
x-ms-traffictypediagnostic: VI1PR08MB3806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB3806B96599E20A6739B32D26F4A00@VI1PR08MB3806.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(376002)(366004)(396003)(199004)(189003)(478600001)(2906002)(6116002)(31696002)(66066001)(2201001)(110136005)(229853002)(7736002)(36756003)(6246003)(44832011)(305945005)(256004)(11346002)(2616005)(476003)(486006)(446003)(316002)(53936002)(86362001)(31686004)(107886003)(3846002)(2501003)(71190400001)(81156014)(81166006)(71200400001)(8676002)(6512007)(99286004)(64756008)(76176011)(66556008)(386003)(6506007)(53546011)(66946007)(5660300002)(66446008)(52116002)(66476007)(186003)(26005)(6486002)(102836004)(25786009)(8936002)(6436002)(14444005)(4744005)(4326008)(14454004)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3806;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gsvqg4mss+klJRzfTIQLV7++W2Vd7EkqQ0ZRSwt09zD/w/xhgcslhY/sedb5wc0YdKEl4k4obnE/KXdaN2YywTkIBVO8vybNWX4z2GRtinzdYh1fa83IBl+IDfbUPYJ3gO17RZenkJSx+YUsF/Kj547r1BaIfY6m4xnrCuziSqGv0X6lzvozRvjIleLiPV71M6znFzIYtiX+VCGm7RdGztk63BxpAV6IN4QXg34g7nutWkBY86RWDBBVLTFKckM8I5WPBgunNTyRzct0N2yxAoytkEbFh4pntzJEAZTeo5AYu8qnTG4bcBVdVILXOpVnXMtrfW2w4dRP+MKMbCeFxmzPNL0dtV7ujn7oWDjuk0bKLOCnaQ2nzMWUEVu4TvpX84PbRLflazvN6z4NzbAZOMs9o7MswT7Jg4AtJcxOqTo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93A719D3F59F6F42889E8056E463071F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a59070-67f4-4f66-ecdf-08d72af77ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 14:04:30.4191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihBaOJymPaMXX0g/dLoiCO3Xleo8hGtg8nURjQ6GlsdgdivxgmAR7kGzeknf5jE6BwjzciawTcMM8k9knQGcudAA2SSQ0nLWTrOVjNG3ZFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3806
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.130
Subject: Re: [Qemu-devel] [PATCH v2] block: workaround for unaligned byte
 range in fallocate()
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA4LzIwMTkgMTY6NTUsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjcvMTkg
ODo1MiBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBSZXZlcnQgdGhlIGNvbW1pdCAx
MThmOTk0NDJkICdibG9jay9pby5jOiBmaXggZm9yIHRoZSBhbGxvY2F0aW9uIGZhaWx1cmUnDQo+
PiBhbmQgdXNlIGJldHRlciBlcnJvciBoYW5kbGluZyBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQgZG8g
bm90IHN1cHBvcnQNCj4+IGZhbGxvY2F0ZSgpIGZvciBhbiB1bmFsaWduZWQgYnl0ZSByYW5nZS4g
QWxsb3cgZmFsbGluZyBiYWNrIHRvIHB3cml0ZQ0KPj4gaW4gY2FzZSBmYWxsb2NhdGUoKSByZXR1
cm5zIEVJTlZBTC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhh
dC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZp
cnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5j
b20+DQo+PiAtLS0NCj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNyArKysrKysrDQo+PiAgIGJs
b2NrL2lvLmMgICAgICAgICB8IDIgKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IFF1ZXVpbmcgdGhpcyBpbiBteSBOQkQgdHJlZSAo
YXMgSSBwZXJmb3JtZWQgdGVzdGluZyBvbiB0b3Agb2YgaXQgd2hlbg0KPiB3b3JraW5nIG9uIE5C
RCBmYXN0LXplcm8pLg0KPiANCkVyaWMsDQpJJ20gc29ycnkgYWJvdXQgbWlzc2luZyB5b3VyIG1l
c3NhZ2UgaW4gdGhlIHByZXZpb3VzIGVtYWlsIHRocmVhZCAtIGp1c3QgDQpmZXcgbWludXRlIGRp
ZmZlcmVuY2UuIFBsZWFzZSBhZGQNClJldmlld2VkLWJ5OiBEZW5pcyBWLiBMdW5ldiA8ZGVuQG9w
ZW52ei5vcmc+DQpiZWNhdXNlIEkgdXNlZCB0aGUgc3RhbGUgY29tbWl0IElEIGZyb20gYmFzaCBo
aXN0b3J5IGFuZCB0aGF0IGxpbmUgDQpkaWRuJ3QgZ28gdG8gdGhlIHYyIHBhdGNoICgoKA0KDQpU
aGFuayB5b3UuDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNo
aW5rZXZpY2gNCg==

