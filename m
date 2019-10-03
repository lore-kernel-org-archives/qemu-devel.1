Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B53221848
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WwwxIlsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2d2-0003MG-0a
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2Z5-0001Ad-Tg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2Z3-0005SO-Qq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:58:47 -0400
Received: from mail-eopbgr150107.outbound.protection.outlook.com
 ([40.107.15.107]:61102 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2Yy-0005QI-Lb; Thu, 03 Oct 2019 10:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buPesB32xlS9m5lwydW+byJqkb6zsi+clpNgkSlnApa495A3kcm37O1+UkfvARmiDdUteFcJ3F+mJ3hhh1gJAr5aIwgU8Iy3PQN+PnSj/YrnsaczywDZ9x9sUxUI5qpMxxzUIVc9xa8+gt7jjElldBopvKUj1fkx8erWsE998d8uXvyeX0YSUXxcBWk76ofsNGiVTZOoRq10bJxE0mFj6C3IjnBskx6QVLmi8qH8YygICsXvF8ZxRS41mSYE48WaRSdMyibbv2SDDXPP+SbMU3ldifixv3OV6G7zytfee2yCMiBBiWwTxlVBvhnuQ2pV8bM6iW2OVW0A+QNQJRbLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVQE0xgueQfE5ntdiMxVsh8Hvcszl+0P/Lo7nNiguC4=;
 b=jMW5SwpXQyU1nDap5cSsTPfL0tFYJ8eLNYTZAL9q5jirag2tN5wJLmlXYnxOsD5rOlT8W2D0n9JJ1MFRIkj+ogEyZKkHOKwT1JJXLA1MxiYJwSCt5XKCLpdVXckgzDX/1MB6y97lFeEKrwUFWqTFc9s7ETc7TGcsICEOICwCC/LOed+tmHsTzzSlh9USGRAs1Dtlh4qwd/NC7/TkUwC4d4YIRXrbIqOJnSt4YHA5qSNKqg5jMAJolmHF8SI5ZKRiuY4vvcAi31+0cYiq28jnF+hBqKWUIsbe3iUDAN83B+yh7ECJq+iv+kC9Dkht34gwp3Ho2uxvbqNF+TUJQEQhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVQE0xgueQfE5ntdiMxVsh8Hvcszl+0P/Lo7nNiguC4=;
 b=WwwxIlsuI4gXd/kYchi8TYK2aj0QFLNRKI1d1xU3boxi7Ftj6fxPgLphIumfQx5EwVmnjjafs9/e9ohOdZgZp/lh/DDoQCRS08qqx0ckkcs5PdfOLsCzwpIw70HizlTHw+tbGyClLTa4BxhiW3pVtXh0ePZ2dLGYOKDdoGx3jrM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4201.eurprd08.prod.outlook.com (20.179.8.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 14:58:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 14:58:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] tests/qemu-iotests: add case for block-stream
 compress
Thread-Topic: [PATCH v2 6/6] tests/qemu-iotests: add case for block-stream
 compress
Thread-Index: AQHVeSzn9zwDDpbZD0eyQm3UDv8WUKdJA7WA
Date: Thu, 3 Oct 2019 14:58:37 +0000
Message-ID: <ad9631b0-2145-c6c8-881c-b9f016ba82b1@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-7-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1570026166-748566-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003175835150
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bce2e143-1852-4766-ff10-08d748122b98
x-ms-traffictypediagnostic: DB8PR08MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4201D1BE05B0CFA1EDB1AE0CC19F0@DB8PR08MB4201.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(376002)(366004)(396003)(136003)(189003)(199004)(64756008)(66946007)(66556008)(7416002)(5660300002)(81166006)(8676002)(6116002)(3846002)(81156014)(8936002)(86362001)(102836004)(386003)(6506007)(26005)(2201001)(186003)(14454004)(99286004)(6512007)(66476007)(66446008)(52116002)(2501003)(6246003)(76176011)(31696002)(4326008)(2616005)(11346002)(446003)(476003)(25786009)(486006)(229853002)(6436002)(6486002)(2906002)(107886003)(66066001)(36756003)(110136005)(54906003)(305945005)(316002)(31686004)(478600001)(256004)(71190400001)(71200400001)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4201;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONxfts/s9KKVN6189lDmcYjohkNLu5IIdXgB0cEE52lVYdt4uouic7B70z2PzfrnV7TqHPQtQl8yZwXCeHxxHUTMlS3UWXD/lwemK6gcUed2zj/zgL4JYvowr0m5+h6H8GUaei5Gh+DCQi4RBL9uiFArOws2zTYgkcfcfrh65zjsL25ZmenF3enCWPsZOk9D1ZtbtvnyWz0IenuRTDiz9E972j4v+Pf0vUnDC9TDwTwTcgHaKBK1QjrOhM1k5dc9yctsBMQHH6YJGkmRw0659Vp6C4f+jwfOz7nLieU7OL30R1+Mck1ufTsbvKERUejU4qPHE1zcNdRh7O8OhgnYwML+bORiFr+4+FPYYjZQC18mvgeLGWmukylCqlF+9FhnlfYGKNAnayALHs5pZIT/wTPF63DJZfDvEraBZ/fnKP8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E4756DB46BA1409EFAB037E1B8DBEF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce2e143-1852-4766-ff10-08d748122b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 14:58:37.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rbi82bpFw7OSHNRHyNyCDSFMNGGkDMgoxVXSxfn0vcKhxhjIkXoKJzkadIFA5hiWT9tJ0YLdA5+Z69e/++7Tv3OM28S+KfBFUhlHjDv9LMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4201
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.107
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
 Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNzoyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEFkZCBhIHRlc3Qg
Y2FzZSB0byB0aGUgaW90ZXN0ICMwMzAgdGhhdCBjaGVja3MgJ2NvbXByZXNzJyBvcHRpb24gZm9y
IGENCj4gYmxvY2stc3RyZWFtIGpvYi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlu
a2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMDMwICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDMwLm91dCB8ICA0ICsr
LS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMCBiL3Rlc3RzL3FlbXUt
aW90ZXN0cy8wMzANCj4gaW5kZXggZjM3NjZmMi4uMTNmZTVhMiAxMDA3NTUNCj4gLS0tIGEvdGVz
dHMvcWVtdS1pb3Rlc3RzLzAzMA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDMwDQo+IEBA
IC0yMSw3ICsyMSw4IEBADQo+ICAgaW1wb3J0IHRpbWUNCj4gICBpbXBvcnQgb3MNCj4gICBpbXBv
cnQgaW90ZXN0cw0KPiAtZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2ltZywgcWVtdV9pbw0KPiAr
ZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2ltZywgcWVtdV9pbywgcWVtdV9pbWdfcGlwZQ0KPiAr
aW1wb3J0IGpzb24NCj4gICANCj4gICBiYWNraW5nX2ltZyA9IG9zLnBhdGguam9pbihpb3Rlc3Rz
LnRlc3RfZGlyLCAnYmFja2luZy5pbWcnKQ0KPiAgIG1pZF9pbWcgPSBvcy5wYXRoLmpvaW4oaW90
ZXN0cy50ZXN0X2RpciwgJ21pZC5pbWcnKQ0KPiBAQCAtOTU2LDYgKzk1Nyw1MiBAQCBjbGFzcyBU
ZXN0U2V0U3BlZWQoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgDQo+ICAgICAgICAgICBzZWxm
LmNhbmNlbF9hbmRfd2FpdChyZXN1bWU9VHJ1ZSkNCj4gICANCj4gK2NsYXNzIFRlc3RDb21wcmVz
c2VkKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiArDQo+ICsgICAgZGVmIHNldFVwKHNlbGYpOg0K
PiArICAgICAgICBxZW11X2ltZygnY3JlYXRlJywgJy1mJywgaW90ZXN0cy5pbWdmbXQsIGJhY2tp
bmdfaW1nLCAnMU0nKQ0KPiArICAgICAgICBxZW11X2ltZygnY3JlYXRlJywgJy1mJywgaW90ZXN0
cy5pbWdmbXQsICctbycsDQo+ICsgICAgICAgICAgICAgICAgICdiYWNraW5nX2ZpbGU9JXMnICUg
YmFja2luZ19pbWcsIG1pZF9pbWcpDQo+ICsgICAgICAgIHFlbXVfaW1nKCdjcmVhdGUnLCAnLWYn
LCBpb3Rlc3RzLmltZ2ZtdCwgJy1vJywNCj4gKyAgICAgICAgICAgICAgICAgJ2JhY2tpbmdfZmls
ZT0lcycgJSBtaWRfaW1nLCB0ZXN0X2ltZykNCj4gKyAgICAgICAgcWVtdV9pbygnLWMnLCAnd3Jp
dGUgLVAgMHgxIDAgNTEyaycsIGJhY2tpbmdfaW1nKQ0KPiArICAgICAgICBzZWxmLnZtID0gaW90
ZXN0cy5WTSgpLmFkZF9kcml2ZSh0ZXN0X2ltZywgImJhY2tpbmcubm9kZS1uYW1lPW1pZCwiICsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImJhY2tpbmcuYmFj
a2luZy5ub2RlLW5hbWU9YmFzZSIpDQo+ICsgICAgICAgIHNlbGYudm0ubGF1bmNoKCkNCg0KV2h5
IHlvdSBjYW4ndCBqdXN0IGFkZCBhIHRlc3QtY2FzZSB0byBUZXN0U2luZ2xlRHJpdmUgY2xhc3M/
DQoNCj4gKw0KPiArICAgIGRlZiB0ZWFyRG93bihzZWxmKToNCj4gKyAgICAgICAgc2VsZi52bS5z
aHV0ZG93bigpDQo+ICsgICAgICAgIG9zLnJlbW92ZSh0ZXN0X2ltZykNCj4gKyAgICAgICAgb3Mu
cmVtb3ZlKG1pZF9pbWcpDQo+ICsgICAgICAgIG9zLnJlbW92ZShiYWNraW5nX2ltZykNCj4gKw0K
PiArICAgIGRlZiB0ZXN0X3N0cmVhbV9jb21wcmVzcyhzZWxmKToNCj4gKyAgICAgICAgc2VsZi5h
c3NlcnRfbm9fYWN0aXZlX2Jsb2NrX2pvYnMoKQ0KPiArDQo+ICsgICAgICAgIHJlc3VsdCA9IHNl
bGYudm0ucW1wKCdibG9jay1zdHJlYW0nLCBkZXZpY2U9J21pZCcsIGpvYl9pZD0nc3RyZWFtLW1p
ZCcpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4g
Kw0KPiArICAgICAgICBzZWxmLndhaXRfdW50aWxfY29tcGxldGVkKGRyaXZlPSdzdHJlYW0tbWlk
JykNCj4gKyAgICAgICAgZm9yIGV2ZW50IGluIHNlbGYudm0uZ2V0X3FtcF9ldmVudHMod2FpdD1U
cnVlKToNCj4gKyAgICAgICAgICAgIGlmIGV2ZW50WydldmVudCddID09ICdCTE9DS19KT0JfQ09N
UExFVEVEJzoNCj4gKyAgICAgICAgICAgICAgICBzZWxmLmRpY3RwYXRoKGV2ZW50LCAnZGF0YS9k
ZXZpY2UnKQ0KPiArICAgICAgICAgICAgICAgIHNlbGYuYXNzZXJ0X3FtcF9hYnNlbnQoZXZlbnQs
ICdkYXRhL2Vycm9yJykNCg0KQ09NUExFVEVEIGV2ZW50IGlzIGZvciBzdXJlIGFscmVhZHkgd2Fp
dGVkIGJ5IHdhaXRfdW50aWxfY29tcGxldGVkDQoNCj4gKw0KPiArICAgICAgICByZXN1bHQgPSBz
ZWxmLnZtLnFtcCgnYmxvY2stc3RyZWFtJywgZGV2aWNlPSdkcml2ZTAnLCBiYXNlPW1pZF9pbWcs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGpvYl9pZD0nc3RyZWFtLXRvcCcsIGNv
bXByZXNzPVRydWUpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4n
LCB7fSkNCj4gKw0KPiArICAgICAgICBzZWxmLndhaXRfdW50aWxfY29tcGxldGVkKGRyaXZlPSdz
dHJlYW0tdG9wJykNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRfbm9fYWN0aXZlX2Jsb2NrX2pvYnMo
KQ0KDQp0aGlzIGFzc2VydGlvbiBpcyBkb25lIGluIHdhaXRfdW50aWxfY29tcGxldGVkDQoNCj4g
KyAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQo+ICsNCj4gKyAgICAgICAgdG9wID0ganNvbi5s
b2FkcyhxZW11X2ltZ19waXBlKCdpbmZvJywgJy0tb3V0cHV0PWpzb24nLCB0ZXN0X2ltZykpDQo+
ICsgICAgICAgIG1pZCA9IGpzb24ubG9hZHMocWVtdV9pbWdfcGlwZSgnaW5mbycsICctLW91dHB1
dD1qc29uJywgbWlkX2ltZykpDQo+ICsgICAgICAgIGJhc2UgPSBqc29uLmxvYWRzKHFlbXVfaW1n
X3BpcGUoJ2luZm8nLCAnLS1vdXRwdXQ9anNvbicsIGJhY2tpbmdfaW1nKSkNCj4gKw0KPiArICAg
ICAgICBzZWxmLmFzc2VydEVxdWFsKG1pZFsnYWN0dWFsLXNpemUnXSwgYmFzZVsnYWN0dWFsLXNp
emUnXSkNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRMZXNzKHRvcFsnYWN0dWFsLXNpemUnXSwgbWlk
WydhY3R1YWwtc2l6ZSddKQ0KPiArDQo+ICAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4g
ICAgICAgaW90ZXN0cy5tYWluKHN1cHBvcnRlZF9mbXRzPVsncWNvdzInLCAncWVkJ10sDQo+ICAg
ICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRfcHJvdG9jb2xzPVsnZmlsZSddKQ0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDMw
Lm91dA0KPiBpbmRleCA2ZDliZWUxLi5hZjhkYWMxIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11
LWlvdGVzdHMvMDMwLm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDMwLm91dA0KPiBA
QCAtMSw1ICsxLDUgQEANCj4gLS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KPiArLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLVJhbiAyNyB0ZXN0
cw0KPiArUmFuIDI4IHRlc3RzDQo+ICAgDQo+ICAgT0sNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

