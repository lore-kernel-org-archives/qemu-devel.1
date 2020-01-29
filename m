Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1EC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E0420716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LqZ4Zy/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E0420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjPu-0005Ae-KV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwjOW-00046s-4d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwjOT-0005aZ-Va
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:12:19 -0500
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:50913 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iwjOT-0005P1-4m; Wed, 29 Jan 2020 04:12:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeWAzujATi+Xku+xvDg93YmbkOAp3sh3N6YrfjDgmJLLB2s8a3CmKt4gvjDoVkc5KZcKNd2TlKUexeLLUlbN1cJk4qAMK7Gul7da7CFcKmo/6c5ub0/8jwZsw8wzYWKCNqN5xpznbVdDpfPuJYxMLpH7jN6eDc0BvGvhLLywVhxUOd1Gu7mfL+bWgqk+QjYx6QXO0ABcMnkg5k23fseuLXv7NYuhxYS9sCLdJL9irywoe5Rzb1+/VbXm8LpibAPVU5EVaQQqEiTlBe8qoBW/QbBCQd/afF8bfE8Uu/Sqw+71lhajVYK5fMg+nC5R8i81K94TEUsiYmR6C0sdYTFjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Komgbo692XWh3+JZCe8TFOLDFaLhXyO+DC+ClhQLb0I=;
 b=oW/R3LMbTF8269V+8qK0g+Qq8O3feQyRf/u/yJLIiU10Ye6g4YpN7s0V6Je60viCQF7tyz2T0KcGbt5nkYGXPHueEL5OjT5hCUR+PXHsHFkhE+S2UjGvtwQFUM+XZaXH6Orti5OHmO8SKm5Y77mtDlm3aVN2/ytCwgf2cZIfRG4JNbX1giu5oHbFmAVf+OOGy+XnZI2ZfgzuvUGX89w83h1aUGXBfV1LxyYVPOS5s5bhnwjwjAXY711yUX5yQ0j2Cs3Gh3lNs3UKMTlcJ5v3uK73W5RluGw4OkupazH5eGfncLS3V7EevCWNsv0Yo6fu+1mxOBzLepZCMcSY2KoBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Komgbo692XWh3+JZCe8TFOLDFaLhXyO+DC+ClhQLb0I=;
 b=LqZ4Zy/vTydCtUtVLRrbra238M4YvbXqMVRQSJuxnMymLE7qsqQha6IRfexkykIFdnSFWYVPxoLZ+UxrU+dOuosO6eOAvnOaF9JADkyjM4LoO8nMIxXd6DmgmeJnbhi67vAlyeAM7RCKZL/9j+tPutDQWr44ypja82VapQxUFm0=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3174.eurprd08.prod.outlook.com (52.135.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 09:12:15 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 09:12:15 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0402CA0018.eurprd04.prod.outlook.com (2603:10a6:3:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 09:12:14 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/7] block/block-copy: use block_status
Thread-Topic: [PATCH v2 2/7] block/block-copy: use block_status
Thread-Index: AQHVpVAlEH39OxhoSk6EdBYJC5arDKgBvcEA
Date: Wed, 29 Jan 2020 09:12:14 +0000
Message-ID: <a6d10b80-b5d9-7fa8-2312-8e9c5eec7fc6@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-3-vsementsov@virtuozzo.com>
In-Reply-To: <20191127180840.11937-3-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0018.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::28) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e558391b-2fec-4444-05fd-08d7a49b54de
x-ms-traffictypediagnostic: AM6PR08MB3174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB317439A51B2F0B8ABDADD913F4050@AM6PR08MB3174.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:158;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(39850400004)(366004)(346002)(189003)(199004)(53546011)(36756003)(110136005)(6486002)(5660300002)(186003)(52116002)(16526019)(16576012)(71200400001)(86362001)(54906003)(316002)(66946007)(64756008)(66556008)(66476007)(66446008)(478600001)(2906002)(81166006)(31686004)(4326008)(26005)(8676002)(8936002)(956004)(44832011)(2616005)(31696002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3174;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUFPJIjUuSBhMVGsKQv7Eb4idsnBHTJYCt8jY+cjzWayW7ouXBo5M/K8dwVBMJ73G/XixovD3Xo30oQm7EYwuhgswgrpfvqfgbB0O+hCCyDsBtlooYmSqGTWZXWQrzT5lg+bHXd75693OptVMCuGtxQ9e1feNNNZkSyp3Hxf0yEGXH5NsosHaC87TEYbe0nKzWkEwrtqtD+1WO0lbR4jURgmI5M/1Jz7H+GcD2OFBB+UD5SQ7dswOMA3tNjItFvFgz+D3a8AtnpjQcw7SLtJr/ThIc0E2jNa8528yIDwebxv+I56s2eKjfQXwxkKNe7/sQZIFyVtMf4qLEX/iifgKld49YNVGi1lp9RrNkbxC1fMxhb2vWbX9pt13ZUw21MGgmEjnO8zES0njyOusdTyJ1Qajmm+gvWqa0weGZPqyli96UeSoVdl2KqC8RXrEipW
x-ms-exchange-antispam-messagedata: 5nGiMP3gbq1r3Cy1Iizzv/NLMn3NPDaGDDIrd6qTz9fiUvYxXLEcqzOR3s+gNXxMA94RbdXgVWnBX0Bm1WJP/CX+ue/xO8Xo41zWZtp9FOfS0t9vwzQ0lYEEpDf0JRSgrmDFKdDLOV38cIslW59PWw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E92B76118FC4E41B283440202C9BBEC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e558391b-2fec-4444-05fd-08d7a49b54de
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 09:12:14.8296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJvKtC3yEGUTqoajFo9a2eRJlE20116b8lym9vAwZBQwQU7h25en7n1CVFFd5+yao72Y3M04CnLiwYN9HqULdqTO8U9P8fDHP9VJ/bk1qXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3174
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.137
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzExLzIwMTkgMjE6MDgsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IFVzZSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZSB0byBjaG9zZSBlZmZlY3RpdmUgY2h1
bmsgc2l6ZSBhbmQgdG8gaGFuZGxlDQo+IHplcm9lcyBlZmZlY3RpdmVseS4NCj4gDQo+IFRoaXMg
c3Vic3RpdHV0ZXMgY2hlY2tpbmcgZm9yIGp1c3QgYmVpbmcgYWxsb2NhdGVkIG9yIG5vdCwgYW5k
IGRyb3BzDQo+IG9sZCBjb2RlIHBhdGggZm9yIGl0LiBBc3Npc3RhbmNlIGJ5IGJhY2t1cCBqb2Ig
aXMgZHJvcHBlZCB0b28sIGFzDQo+IGNhY2hpbmcgYmxvY2stc3RhdHVzIGluZm9ybWF0aW9uIGlz
IG1vcmUgZGlmZmljdWx0IHRoYW4ganVzdCBjYWNoaW5nDQo+IGlzLWFsbG9jYXRlZCBpbmZvcm1h
dGlvbiBpbiBvdXIgZGlydHkgYml0bWFwLCBhbmQgYmFja3VwIGpvYiBpcyBub3QNCj4gZ29vZCBw
bGFjZSBmb3IgdGhpcyBjYWNoaW5nIGFueXdheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gLS0t
DQo+ICAgYmxvY2svYmxvY2stY29weS5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIGJsb2NrL3RyYWNlLWV2ZW50cyB8ICAxICsNCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsb2NrLWNvcHkuYyBiL2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPiBp
bmRleCA4NjAyZTJjYWU3Li43NDI5NWQ5M2Q1IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibG9jay1j
b3B5LmMNCj4gKysrIGIvYmxvY2svYmxvY2stY29weS5jDQo+IEBAIC0xNTIsNyArMTUyLDcgQEAg
dm9pZCBibG9ja19jb3B5X3NldF9jYWxsYmFja3MoDQo+ICAgICovDQo+ICAgc3RhdGljIGludCBj
b3JvdXRpbmVfZm4gYmxvY2tfY29weV9kb19jb3B5KEJsb2NrQ29weVN0YXRlICpzLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IHN0YXJ0LCBp
bnQ2NF90IGVuZCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib29sICplcnJvcl9pc19yZWFkKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJvb2wgemVyb2VzLCBib29sICplcnJvcl9pc19yZWFkKQ0KPiAgIHsNCj4g
ICAgICAgaW50IHJldDsNCj4gICAgICAgaW50IG5ieXRlcyA9IE1JTihlbmQsIHMtPmxlbikgLSBz
dGFydDsNCj4gQEAgLTE2Miw2ICsxNjIsMTggQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmxv
Y2tfY29weV9kb19jb3B5KEJsb2NrQ29weVN0YXRlICpzLA0KPiAgICAgICBhc3NlcnQoUUVNVV9J
U19BTElHTkVEKGVuZCwgcy0+Y2x1c3Rlcl9zaXplKSk7DQo+ICAgICAgIGFzc2VydChlbmQgPCBz
LT5sZW4gfHwgZW5kID09IFFFTVVfQUxJR05fVVAocy0+bGVuLCBzLT5jbHVzdGVyX3NpemUpKTsN
Cj4gICANCj4gKyAgICBpZiAoemVyb2VzKSB7DQo+ICsgICAgICAgIHJldCA9IGJkcnZfY29fcHdy
aXRlX3plcm9lcyhzLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsIHMtPndyaXRlX2ZsYWdzICYNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5CRFJWX1JFUV9XUklURV9DT01Q
UkVTU0VEKTsNCj4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAgICAgICAgIHRyYWNl
X2Jsb2NrX2NvcHlfd3JpdGVfemVyb2VzX2ZhaWwocywgc3RhcnQsIHJldCk7DQo+ICsgICAgICAg
ICAgICBpZiAoZXJyb3JfaXNfcmVhZCkgew0KPiArICAgICAgICAgICAgICAgICplcnJvcl9pc19y
ZWFkID0gZmFsc2U7DQo+ICsgICAgICAgICAgICB9DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAg
cmV0dXJuIHJldDsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKHMtPnVzZV9jb3B5X3Jhbmdl
KSB7DQo+ICAgICAgICAgICByZXQgPSBiZHJ2X2NvX2NvcHlfcmFuZ2Uocy0+c291cmNlLCBzdGFy
dCwgcy0+dGFyZ2V0LCBzdGFydCwgbmJ5dGVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDAsIHMtPndyaXRlX2ZsYWdzKTsNCj4gQEAgLTIyNSw2ICsyMzcsMzQgQEAgb3V0
Og0KPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQgYmxvY2tf
Y29weV9ibG9ja19zdGF0dXMoQmxvY2tDb3B5U3RhdGUgKnMsIGludDY0X3Qgb2Zmc2V0LA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IGJ5dGVzLCBpbnQ2NF90
ICpwbnVtKQ0KPiArew0KPiArICAgIGludDY0X3QgbnVtOw0KPiArICAgIEJsb2NrRHJpdmVyU3Rh
dGUgKmJhc2U7DQo+ICsgICAgaW50IHJldDsNCj4gKw0KPiArICAgIGlmIChzLT5za2lwX3VuYWxs
b2NhdGVkICYmIHMtPnNvdXJjZS0+YnMtPmJhY2tpbmcpIHsNCj4gKyAgICAgICAgYmFzZSA9IHMt
PnNvdXJjZS0+YnMtPmJhY2tpbmctPmJzOw0KPiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIGJh
c2UgPSBOVUxMOw0KPiArICAgIH0NCj4gKw0KPiArICAgIHJldCA9IGJkcnZfYmxvY2tfc3RhdHVz
X2Fib3ZlKHMtPnNvdXJjZS0+YnMsIGJhc2UsIG9mZnNldCwgYnl0ZXMsICZudW0sDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCk7DQo+ICsgICAgaWYgKHJl
dCA8IDAgfHwgbnVtIDwgcy0+Y2x1c3Rlcl9zaXplKSB7DQo+ICsgICAgICAgIG51bSA9IHMtPmNs
dXN0ZXJfc2l6ZTsNCg0KLyogTGV0IHRoZSBjbHVzdGVyIGJlIGNvcGllZCBpbiBjYXNlIG9mIGVy
cm9yIHRvbyAqLw0KPiArICAgICAgICByZXQgPSBCRFJWX0JMT0NLX0FMTE9DQVRFRCB8IEJEUlZf
QkxPQ0tfREFUQTsNCj4gKyAgICB9IGVsc2UgaWYgKG9mZnNldCArIG51bSA9PSBzLT5sZW4pIHsN
Cj4gKyAgICAgICAgbnVtID0gUUVNVV9BTElHTl9VUChudW0sIHMtPmNsdXN0ZXJfc2l6ZSk7DQo+
ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgbnVtID0gUUVNVV9BTElHTl9ET1dOKG51bSwgcy0+
Y2x1c3Rlcl9zaXplKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICAqcG51bSA9IG51bTsNCj4gKyAg
ICByZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBDaGVjayBpZiB0aGUgY2x1
c3RlciBzdGFydGluZyBhdCBvZmZzZXQgaXMgYWxsb2NhdGVkIG9yIG5vdC4NCj4gICAgKiByZXR1
cm4gdmlhIHBudW0gdGhlIG51bWJlciBvZiBjb250aWd1b3VzIGNsdXN0ZXJzIHNoYXJpbmcgdGhp
cyBhbGxvY2F0aW9uLg0KPiBAQCAtMzAxLDcgKzM0MSw2IEBAIGludCBjb3JvdXRpbmVfZm4gYmxv
Y2tfY29weShCbG9ja0NvcHlTdGF0ZSAqcywNCj4gICB7DQo+ICAgICAgIGludCByZXQgPSAwOw0K
PiAgICAgICBpbnQ2NF90IGVuZCA9IGJ5dGVzICsgc3RhcnQ7IC8qIGJ5dGVzICovDQo+IC0gICAg
aW50NjRfdCBzdGF0dXNfYnl0ZXM7DQo+ICAgICAgIEJsb2NrQ29weUluRmxpZ2h0UmVxIHJlcTsN
Cj4gICANCj4gICAgICAgLyoNCj4gQEAgLTMxOCw3ICszNTcsNyBAQCBpbnQgY29yb3V0aW5lX2Zu
IGJsb2NrX2NvcHkoQmxvY2tDb3B5U3RhdGUgKnMsDQo+ICAgICAgIGJsb2NrX2NvcHlfaW5mbGln
aHRfcmVxX2JlZ2luKHMsICZyZXEsIHN0YXJ0LCBlbmQpOw0KPiAgIA0KPiAgICAgICB3aGlsZSAo
c3RhcnQgPCBlbmQpIHsNCj4gLSAgICAgICAgaW50NjRfdCBuZXh0X3plcm8sIGNodW5rX2VuZDsN
Cj4gKyAgICAgICAgaW50NjRfdCBuZXh0X3plcm8sIGNodW5rX2VuZCwgc3RhdHVzX2J5dGVzOw0K
PiAgIA0KPiAgICAgICAgICAgaWYgKCFiZHJ2X2RpcnR5X2JpdG1hcF9nZXQocy0+Y29weV9iaXRt
YXAsIHN0YXJ0KSkgew0KPiAgICAgICAgICAgICAgIHRyYWNlX2Jsb2NrX2NvcHlfc2tpcChzLCBz
dGFydCk7DQo+IEBAIC0zMzYsMjMgKzM3NSwyNSBAQCBpbnQgY29yb3V0aW5lX2ZuIGJsb2NrX2Nv
cHkoQmxvY2tDb3B5U3RhdGUgKnMsDQo+ICAgICAgICAgICAgICAgY2h1bmtfZW5kID0gbmV4dF96
ZXJvOw0KPiAgICAgICAgICAgfQ0KPiAgIA0KPiAtICAgICAgICBpZiAocy0+c2tpcF91bmFsbG9j
YXRlZCkgew0KPiAtICAgICAgICAgICAgcmV0ID0gYmxvY2tfY29weV9yZXNldF91bmFsbG9jYXRl
ZChzLCBzdGFydCwgJnN0YXR1c19ieXRlcyk7DQo+IC0gICAgICAgICAgICBpZiAocmV0ID09IDAp
IHsNCj4gLSAgICAgICAgICAgICAgICB0cmFjZV9ibG9ja19jb3B5X3NraXBfcmFuZ2Uocywgc3Rh
cnQsIHN0YXR1c19ieXRlcyk7DQo+IC0gICAgICAgICAgICAgICAgc3RhcnQgKz0gc3RhdHVzX2J5
dGVzOw0KPiAtICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAtICAgICAgICAgICAgfQ0KPiAt
ICAgICAgICAgICAgLyogQ2xhbXAgdG8ga25vd24gYWxsb2NhdGVkIHJlZ2lvbiAqLw0KPiAtICAg
ICAgICAgICAgY2h1bmtfZW5kID0gTUlOKGNodW5rX2VuZCwgc3RhcnQgKyBzdGF0dXNfYnl0ZXMp
Ow0KPiArICAgICAgICByZXQgPSBibG9ja19jb3B5X2Jsb2NrX3N0YXR1cyhzLCBzdGFydCwgY2h1
bmtfZW5kIC0gc3RhcnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZzdGF0dXNfYnl0ZXMpOw0KPiArICAgICAgICBpZiAocy0+c2tpcF91bmFsbG9jYXRlZCAmJiAh
KHJldCAmIEJEUlZfQkxPQ0tfQUxMT0NBVEVEKSkgew0KPiArICAgICAgICAgICAgYmRydl9yZXNl
dF9kaXJ0eV9iaXRtYXAocy0+Y29weV9iaXRtYXAsIHN0YXJ0LCBzdGF0dXNfYnl0ZXMpOw0KPiAr
ICAgICAgICAgICAgcy0+cHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2socy0+cHJvZ3Jlc3Nfb3BhcXVl
KTsNCj4gKyAgICAgICAgICAgIHRyYWNlX2Jsb2NrX2NvcHlfc2tpcF9yYW5nZShzLCBzdGFydCwg
c3RhdHVzX2J5dGVzKTsNCj4gKyAgICAgICAgICAgIHN0YXJ0ICs9IHN0YXR1c19ieXRlczsNCj4g
KyAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgfQ0KPiAgIA0KPiArICAgICAgICBj
aHVua19lbmQgPSBNSU4oY2h1bmtfZW5kLCBzdGFydCArIHN0YXR1c19ieXRlcyk7DQo+ICsNCj4g
ICAgICAgICAgIHRyYWNlX2Jsb2NrX2NvcHlfcHJvY2VzcyhzLCBzdGFydCk7DQo+ICAgDQo+ICAg
ICAgICAgICBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChzLT5jb3B5X2JpdG1hcCwgc3RhcnQsIGNo
dW5rX2VuZCAtIHN0YXJ0KTsNCj4gICANCj4gICAgICAgICAgIGNvX2dldF9mcm9tX3NocmVzKHMt
Pm1lbSwgY2h1bmtfZW5kIC0gc3RhcnQpOw0KPiAtICAgICAgICByZXQgPSBibG9ja19jb3B5X2Rv
X2NvcHkocywgc3RhcnQsIGNodW5rX2VuZCwgZXJyb3JfaXNfcmVhZCk7DQo+ICsgICAgICAgIHJl
dCA9IGJsb2NrX2NvcHlfZG9fY29weShzLCBzdGFydCwgY2h1bmtfZW5kLCByZXQgJiBCRFJWX0JM
T0NLX1pFUk8sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9pc19y
ZWFkKTsNCj4gICAgICAgICAgIGNvX3B1dF90b19zaHJlcyhzLT5tZW0sIGNodW5rX2VuZCAtIHN0
YXJ0KTsNCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgYmRydl9z
ZXRfZGlydHlfYml0bWFwKHMtPmNvcHlfYml0bWFwLCBzdGFydCwgY2h1bmtfZW5kIC0gc3RhcnQp
Ow0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svdHJhY2UtZXZlbnRzIGIvYmxvY2svdHJhY2UtZXZlbnRz
DQo+IGluZGV4IDZiYTg2ZGVjY2EuLjM0NjUzN2ExZDIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Ry
YWNlLWV2ZW50cw0KPiArKysgYi9ibG9jay90cmFjZS1ldmVudHMNCj4gQEAgLTQ4LDYgKzQ4LDcg
QEAgYmxvY2tfY29weV9wcm9jZXNzKHZvaWQgKmJjcywgaW50NjRfdCBzdGFydCkgImJjcyAlcCBz
dGFydCAlIlBSSWQ2NA0KPiAgIGJsb2NrX2NvcHlfY29weV9yYW5nZV9mYWlsKHZvaWQgKmJjcywg
aW50NjRfdCBzdGFydCwgaW50IHJldCkgImJjcyAlcCBzdGFydCAlIlBSSWQ2NCIgcmV0ICVkIg0K
PiAgIGJsb2NrX2NvcHlfcmVhZF9mYWlsKHZvaWQgKmJjcywgaW50NjRfdCBzdGFydCwgaW50IHJl
dCkgImJjcyAlcCBzdGFydCAlIlBSSWQ2NCIgcmV0ICVkIg0KPiAgIGJsb2NrX2NvcHlfd3JpdGVf
ZmFpbCh2b2lkICpiY3MsIGludDY0X3Qgc3RhcnQsIGludCByZXQpICJiY3MgJXAgc3RhcnQgJSJQ
UklkNjQiIHJldCAlZCINCj4gK2Jsb2NrX2NvcHlfd3JpdGVfemVyb2VzX2ZhaWwodm9pZCAqYmNz
LCBpbnQ2NF90IHN0YXJ0LCBpbnQgcmV0KSAiYmNzICVwIHN0YXJ0ICUiUFJJZDY0IiByZXQgJWQi
DQo+ICAgDQo+ICAgIyAuLi9ibG9ja2Rldi5jDQo+ICAgcW1wX2Jsb2NrX2pvYl9jYW5jZWwodm9p
ZCAqam9iKSAiam9iICVwIg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxh
bmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2Fy
ZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

