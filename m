Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5838521D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L+0I8saD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838521D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD83C-0006IT-Ds
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD82H-0005gs-8P
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD82F-0005Gb-KP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:12:52 -0400
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112]:61763 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD82E-0005Fv-Q3; Wed, 25 Sep 2019 10:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRO+IgSXfgB8F87HB3zosX3MK16PKMQh9lw8c3cR1pFxxfdFbWVZfFJIlhp8+Dx12dj5P6arXCZIeB7CY1A6aFwUrjytsX/7mLkffNpFgl+Kz1U3xx8aZVSdZWdiZbqoU7EWyTrbEZNB2LNxzqeRYm8PV5adisXsuynTDT/VqiFISrjk7P+XwVdy0Z48BUgN6qMDdprbnRIXFCUWmfC3AIRsVwH1ZaSKthsVXdh9pd/ZnZSEUGdFVIEclC0LORV1YUge6r4nwBq6uNAo9ULrxwW36tjsmL3AOwojDvgaSetA85IBNlsfoq35hZESGLryDjH86jGSqtpkzIsqsA7xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGRMSe07pdvgW+xpjCQ5i64wXQ6m7rE5l7L+j2n0RA=;
 b=IUW3fLHlMd9xygXpmcR2nKXvHq6Fpx9HD+2+sdK5fzlN9OfunhzeFyuoaL2D5MRdpWz6VRkueJb0Zoyh1mqlOBceT/cecrtNVPwfjll+WclCeVISLT9BianTnIyZkKRMKPWXcEHKBZSxeg/8wLeX51BENpOXeHbgb1RDB6rzS09eusUXcnxxVDN1e3VYRG081gSexxv4N12RAkEMoYdF7WR5smweQ646ERXGFS3S0sYwgRu4SaMy4qed/JG/m1Qqe6vkUNcOaLcAOCOps9Ojj30ozRaK80fg4Pgg+tQdcwTQk44yWPSZF6+O6ZiOJLz6jtyI0pDmDpW/fLkYlitDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGRMSe07pdvgW+xpjCQ5i64wXQ6m7rE5l7L+j2n0RA=;
 b=L+0I8saDABdJlPYjWmgNEphNGoH5BWpwRurUNNmLOKqrsTpnaKowRgyGnIu0FBErqpror0jfEvYBC3MKe/YHpKesfCjUYAgT3aL+DDiE+vxncDJgt1752pVbepUV9AS1x5fIGFyXAdqeyMkgo8zNRzFpYZxfObn186ctjulNylI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5148.eurprd08.prod.outlook.com (10.255.17.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 14:12:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:12:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Topic: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Index: AQHVb8x5FMRz3/odLkqUJ37f4pTVWac8dwGA
Date: Wed, 25 Sep 2019 14:12:47 +0000
Message-ID: <78926514-59db-f108-1ace-356a0bca8097@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-11-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925171245601
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786727f1-6025-4ca3-c657-08d741c27138
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5148; 
x-ms-traffictypediagnostic: DB8PR08MB5148:
x-microsoft-antispam-prvs: <DB8PR08MB514861F7A1E2F976A0FE3F23C1870@DB8PR08MB5148.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(36756003)(229853002)(2501003)(54906003)(110136005)(316002)(8676002)(8936002)(81156014)(81166006)(305945005)(7736002)(3846002)(6116002)(386003)(102836004)(256004)(66446008)(14454004)(6506007)(26005)(2906002)(76176011)(52116002)(99286004)(11346002)(446003)(64756008)(31686004)(486006)(476003)(2616005)(66556008)(66476007)(25786009)(71200400001)(71190400001)(478600001)(31696002)(86362001)(186003)(66946007)(5660300002)(4326008)(6246003)(6512007)(6486002)(66066001)(6436002)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5148;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uePhsosHnjbb5i6RZQWbeFflIEDX8ppwGY5RttbOEeKoGbYKDLz0ld9ZLZccirv5YzmXP9QQJt1NTdgYWtpjivFLrEk6GleRpY7zcLaAmjF1LnmYLlciDW76z7lEUDdwjh8xw7vQId8q1VIiZolfMLATrEIEz2Rci23clTIe69hIBemGhATt3F7fhgjSeCmTE0kgRcrTAG4gSIAxN9TlwN6N70jmPKpykuQeMXnZs9FvINpMO5KIAVxQn8zOuGFA3bRhNBs/VBKz09mEae10/1AgDJtrja61WDs04A1jlojZ05wUurDqzRGD/DrFfVQms4ADjfbfYVUZjqqqHXnEe+gFs+l3MsCdcnk5myDaG+vzvL4xlHNLUYMzj9YxWXPQ4UBwibNrrrHWeFzTdEdEcPnzTu2nZECzZ7OtXs2yGE8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA770E43DB521544AB40E4FE6BED21AF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786727f1-6025-4ca3-c657-08d741c27138
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:12:47.6492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl1JOXbuw8gWzOsyxxpfacsbtf830lEkJNjgwmxfpDywes2gvAz1vbHe8SUIZE85Z6X5OQ78pf3nNCihHZs4zAywnHhrK28f5/cssHFIyjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5148
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.112
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9xdW9ydW0uYyB8IDYy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9j
ay9xdW9ydW0uYyBiL2Jsb2NrL3F1b3J1bS5jDQo+IGluZGV4IDIwNzA1NGE2NGUuLjgxYjU3ZGJh
ZTIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3F1b3J1bS5jDQo+ICsrKyBiL2Jsb2NrL3F1b3J1bS5j
DQo+IEBAIC04MjUsNiArODI1LDY3IEBAIHN0YXRpYyBib29sIHF1b3J1bV9yZWN1cnNlX2lzX2Zp
cnN0X25vbl9maWx0ZXIoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBxdW9ydW1fcmVjdXJzZV9jYW5fcmVwbGFj
ZShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKnRvX3JlcGxhY2UpDQo+ICt7DQo+ICsgICAgQkRS
VlF1b3J1bVN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKyAgICBpbnQgaTsNCj4gKw0KPiArICAg
IGZvciAoaSA9IDA7IGkgPCBzLT5udW1fY2hpbGRyZW47IGkrKykgew0KPiArICAgICAgICAvKg0K
PiArICAgICAgICAgKiBXZSBoYXZlIG5vIGlkZWEgd2hldGhlciBvdXIgY2hpbGRyZW4gc2hvdyB0
aGUgc2FtZSBkYXRhIGFzDQo+ICsgICAgICAgICAqIHRoaXMgbm9kZSAoQGJzKS4gIEl0IGlzIGFj
dHVhbGx5IGhpZ2hseSBsaWtlbHkgdGhhdA0KPiArICAgICAgICAgKiBAdG9fcmVwbGFjZSBkb2Vz
IG5vdCwgYmVjYXVzZSByZXBsYWNpbmcgYSBicm9rZW4gY2hpbGQgaXMNCj4gKyAgICAgICAgICog
b25lIG9mIHRoZSBtYWluIHVzZSBjYXNlcyBoZXJlLg0KPiArICAgICAgICAgKg0KPiArICAgICAg
ICAgKiBXZSBkbyBrbm93IHRoYXQgdGhlIG5ldyBCRFMgd2lsbCBtYXRjaCBAYnMsIHNvIHJlcGxh
Y2luZw0KPiArICAgICAgICAgKiBhbnkgb2Ygb3VyIGNoaWxkcmVuIGJ5IGl0IHdpbGwgYmUgc2Fm
ZS4gIEl0IGNhbm5vdCBjaGFuZ2UNCj4gKyAgICAgICAgICogdGhlIGRhdGEgdGhpcyBxdW9ydW0g
bm9kZSBwcmVzZW50cyB0byBpdHMgcGFyZW50cy4NCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAg
ICogSG93ZXZlciwgcmVwbGFjaW5nIEB0b19yZXBsYWNlIGJ5IEBicyBpbiBhbnkgb2Ygb3VyDQo+
ICsgICAgICAgICAqIGNoaWxkcmVuJ3MgY2hhaW5zIG1heSBjaGFuZ2UgdmlzaWJsZSBkYXRhIHNv
bWV3aGVyZSBpbg0KPiArICAgICAgICAgKiB0aGVyZS4gIFdlIHRoZXJlZm9yZSBjYW5ub3QgcmVj
dXJzZSBkb3duIHRob3NlIGNoYWlucyB3aXRoDQo+ICsgICAgICAgICAqIGJkcnZfcmVjdXJzZV9j
YW5fcmVwbGFjZSgpLg0KPiArICAgICAgICAgKiAoTW9yZSBmb3JtYWxseSwgYmRydl9yZWN1cnNl
X2Nhbl9yZXBsYWNlKCkgcmVxdWlyZXMgdGhhdA0KPiArICAgICAgICAgKiBAdG9fcmVwbGFjZSB3
aWxsIGJlIHJlcGxhY2VkIGJ5IHNvbWV0aGluZyBtYXRjaGluZyB0aGUgQGJzDQo+ICsgICAgICAg
ICAqIHBhc3NlZCB0byBpdC4gIFdlIGNhbm5vdCBndWFyYW50ZWUgdGhhdC4pDQo+ICsgICAgICAg
ICAqDQo+ICsgICAgICAgICAqIFRodXMsIHdlIGNhbiBvbmx5IGNoZWNrIHdoZXRoZXIgYW55IG9m
IG91ciBpbW1lZGlhdGUNCj4gKyAgICAgICAgICogY2hpbGRyZW4gbWF0Y2hlcyBAdG9fcmVwbGFj
ZS4NCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAgICogKEluIHRoZSBmdXR1cmUsIHdlIG1pZ2h0
IGFkZCBhIGZ1bmN0aW9uIHRvIHJlY3Vyc2UgZG93biBhDQo+ICsgICAgICAgICAqIGNoYWluIHRo
YXQgY2hlY2tzIHRoYXQgbm90aGluZyB0aGVyZSBjYXJlcyBhYm91dCBhIGNoYW5nZQ0KPiArICAg
ICAgICAgKiBpbiBkYXRhIGZyb20gdGhlIHJlc3BlY3RpdmUgY2hpbGQgaW4gcXVlc3Rpb24uICBG
b3INCj4gKyAgICAgICAgICogZXhhbXBsZSwgbW9zdCBmaWx0ZXJzIGRvIG5vdCBjYXJlIHdoZW4g
dGhlaXIgY2hpbGQncyBkYXRhDQo+ICsgICAgICAgICAqIHN1ZGRlbmx5IGNoYW5nZXMsIGFzIGxv
bmcgYXMgdGhlaXIgcGFyZW50cyBkbyBub3QgY2FyZS4pDQo+ICsgICAgICAgICAqLw0KPiArICAg
ICAgICBpZiAocy0+Y2hpbGRyZW5baV0uY2hpbGQtPmJzID09IHRvX3JlcGxhY2UpIHsNCj4gKyAg
ICAgICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiArDQo+ICsgICAgICAgICAgICAv
Kg0KPiArICAgICAgICAgICAgICogV2Ugbm93IGhhdmUgdG8gZW5zdXJlIHRoYXQgdGhlcmUgaXMg
bm8gb3RoZXIgcGFyZW50DQo+ICsgICAgICAgICAgICAgKiB0aGF0IGNhcmVzIGFib3V0IHJlcGxh
Y2luZyB0aGlzIGNoaWxkIGJ5IGEgbm9kZSB3aXRoDQo+ICsgICAgICAgICAgICAgKiBwb3RlbnRp
YWxseSBkaWZmZXJlbnQgZGF0YS4NCj4gKyAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAg
cy0+Y2hpbGRyZW5baV0udG9fYmVfcmVwbGFjZWQgPSB0cnVlOw0KPiArICAgICAgICAgICAgYmRy
dl9jaGlsZF9yZWZyZXNoX3Blcm1zKGJzLCBzLT5jaGlsZHJlbltpXS5jaGlsZCwgJmxvY2FsX2Vy
cik7DQo+ICsNCg0KU28gd2UgYXJlIHRyeWluZyB0byBhbnN3ZXIgb24gYSBxdWVzdGlvbiAiaXMg
aXQgb2sgdG8gcmVwbGFjZSIgaXQsIGJ5IGNoZWF0aW5nIG9uDQpwZXJtaXNzaW9uIHN5c3RlbS4u
LiBQb3NzaWJseSwgaXQncyBhIHByb2JsZW0gb2YgZ2VuZXJhbCBkZXNpZ24sIGFuZCBpbnN0ZWFk
IG9mDQogIGV4YW1pbmluZyBvbmUgc3VidHJlZSwgd2Ugc2hvdWxkIGFzayBhbGwgcGFyZW50cyBv
ZiB0b19yZXBsYWNlIG5vZGUsIGFyZSB0aGV5DQpPSyB3aXRoIHN1Y2ggcmVwbGFjZW1lbnQuLg0K
DQpBbm90aGVyIGlkZWEgaXMgdGhhdCBpdCdzIHN0cmFuZ2UgdG8gY2hlY2sgcGVybWlzc2lvbnMg
c29tZXdoZXJlIGVsc2UgdGhhbiBpbiBnZW5lcmljDQpwZXJtaXNzaW9uIGNoZWNrIGZ1bmN0aW9u
cy4gQnV0IEkndmUgbm8gaWRlYSBob3cgdG8gaGFuZGxlIGl0IGluIHBlcm1pc3Npb24gc3lzdGVt
Lg0KDQpPciBpbiBvdGhlciB3b3JkczogSSBkb24ndCBsaWtlIGl0IGFsbCwgYnV0IEkgYXQgbGVh
c3QgZm9sbG93IGhvdyBpdCB3b3Jrcy4gQW5kIHRoaXMNCmxvb2tzIGJldHRlciB0aGFuIGl0IHdh
cyBhbmQgZml4ZXMgc29tZSBidWdzLg0KDQo+ICsgICAgICAgICAgICAvKiBSZXZlcnQgcGVybWlz
c2lvbnMgKi8NCj4gKyAgICAgICAgICAgIHMtPmNoaWxkcmVuW2ldLnRvX2JlX3JlcGxhY2VkID0g
ZmFsc2U7DQo+ICsgICAgICAgICAgICBiZHJ2X2NoaWxkX3JlZnJlc2hfcGVybXMoYnMsIHMtPmNo
aWxkcmVuW2ldLmNoaWxkLCAmZXJyb3JfYWJvcnQpOw0KPiArDQo+ICsgICAgICAgICAgICBpZiAo
bG9jYWxfZXJyKSB7DQo+ICsgICAgICAgICAgICAgICAgZXJyb3JfZnJlZShsb2NhbF9lcnIpOw0K
PiArICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICAgICAgICAgIH0NCj4gKw0K
PiArICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICsN
Cj4gKyAgICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IHF1b3J1bV92
YWxpZF90aHJlc2hvbGQoaW50IHRocmVzaG9sZCwgaW50IG51bV9jaGlsZHJlbiwgRXJyb3IgKipl
cnJwKQ0KPiAgIHsNCj4gICANCj4gQEAgLTExOTUsNiArMTI1Niw3IEBAIHN0YXRpYyBCbG9ja0Ry
aXZlciBiZHJ2X3F1b3J1bSA9IHsNCj4gICANCj4gICAgICAgLmlzX2ZpbHRlciAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSB0cnVlLA0KPiAgICAgICAuYmRydl9yZWN1cnNlX2lzX2ZpcnN0X25v
bl9maWx0ZXIgICA9IHF1b3J1bV9yZWN1cnNlX2lzX2ZpcnN0X25vbl9maWx0ZXIsDQo+ICsgICAg
LmJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZSAgICAgICAgICAgPSBxdW9ydW1fcmVjdXJzZV9jYW5f
cmVwbGFjZSwNCj4gICANCj4gICAgICAgLnN0cm9uZ19ydW50aW1lX29wdHMgICAgICAgICAgICAg
ICAgPSBxdW9ydW1fc3Ryb25nX3J1bnRpbWVfb3B0cywNCj4gICB9Ow0KPiANCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

