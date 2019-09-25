Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3204C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8DA2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YfGOY8Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8DA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9qh-0000Da-SW
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD9oM-00066O-QY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD9oL-0007Pf-KX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:06:38 -0400
Received: from mail-eopbgr130139.outbound.protection.outlook.com
 ([40.107.13.139]:46082 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD9o3-0007KC-M3; Wed, 25 Sep 2019 12:06:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG4eC5EOQltsDkx5Z5b16mxbBYSgLDTr9pz1Zy420JJknHmpJI0nErLp1XBMUtMK32YBZk5djULxLR+zwEQAZDdnGvsfMmZjF7NnUjrtWzc2FxR/IRO8FuBh/f9Ac1BdcKyFvWk+YYMLCegK6Lqke8vLBzTF/xlEeW/yqZFNdMQrpbScq0YMBRVum5GUAhC1PT9IEZ/GjvEv04PrC3BuF8VBS+LLBu3txOKZcqJP0djV5vKUpG1cdHJMCMWQQqkFhnBq4N6o0hBFMGPsH678mjpplKwUTl5iti98b7MeQQfGf6FSW7g25hZC+M7vNXIT3RsGa09/mZjpcXl7pyQueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6tF2hLeyEmX6zbUff87B7nJ6I8yv+Yhl1KIr1mU2s4=;
 b=ewvg66PD3hX6E78HX5JnB/Txs56LTAcAWuaecxcl2t8Qa2ibuPYLBg8ZdCEYDyQPqgBze2BxuMOOJgXyLOAwqBCYmZFCESNAChpFh7iMv9wxfUynPLURXWzlXsqOrT4vlSaOokdhrqYmcHV0IrnpB9lxKLuocn+rbvqetyYqAmJ6GcdWgAabqSh86uIA89/8jGNLDw2vk8pG/xgoVmstKBx6FYpH2ncu+0pUaM7vlOnHsvWEqbTATnH6j/8GIenSRGKNxwvNQg704Ufr+9gKCtgAYIDIoCVU5Xn3mKZ621LyVLluL/qbCZdgri/PvVEInTrfHNH1s9z/aOUH/N+4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6tF2hLeyEmX6zbUff87B7nJ6I8yv+Yhl1KIr1mU2s4=;
 b=YfGOY8LckUW8GjBcB8fr305CKjApmdA96rUkoCY8gsd6Piq+CfsxeUmLXMbGVtSn5+C+mOsf9YtlhF+/HukQx+S5xLCdW89Djry1kaOfAJ0dzYu2l86GqcQhbhSCuRomumewbNOYiQ+cl5F7yVP2ImUSx3zy7dRqoagJz0ncbVo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5179.eurprd08.prod.outlook.com (10.255.17.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 16:06:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 16:06:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 05/25] scripts: add coccinelle script to fix
 error_append_hint usage
Thread-Topic: [PATCH v3 05/25] scripts: add coccinelle script to fix
 error_append_hint usage
Thread-Index: AQHVcxQFCyGqMJ4u0UKUYIVC3mwAFqc7TMUAgAFDXQA=
Date: Wed, 25 Sep 2019 16:06:15 +0000
Message-ID: <d9223010-dfca-ac52-3224-47bb28b3e74e@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-6-vsementsov@virtuozzo.com>
 <1626833c-a19a-bba1-7194-932b873bc490@redhat.com>
In-Reply-To: <1626833c-a19a-bba1-7194-932b873bc490@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0081.eurprd04.prod.outlook.com
 (2603:10a6:3:19::49) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925190610128
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4172b38b-b0e5-4295-b6a5-08d741d24b34
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5179; 
x-ms-traffictypediagnostic: DB8PR08MB5179:
x-microsoft-antispam-prvs: <DB8PR08MB5179C4032491F3602FAAD1CDC1870@DB8PR08MB5179.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(39850400004)(376002)(189003)(199004)(6486002)(31696002)(25786009)(2906002)(229853002)(64756008)(66476007)(305945005)(86362001)(66446008)(7736002)(14454004)(256004)(478600001)(6116002)(5660300002)(110136005)(66946007)(66066001)(31686004)(476003)(71190400001)(486006)(54906003)(2616005)(316002)(11346002)(4326008)(99286004)(6512007)(71200400001)(53546011)(3846002)(36756003)(52116002)(66556008)(7406005)(7416002)(6246003)(2501003)(8936002)(81166006)(386003)(186003)(446003)(102836004)(81156014)(6436002)(26005)(76176011)(8676002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5179;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FiTxUnojLMBdMYUIh5exQIr1jsCPgcFu73JU5k85xOT7ZuBviblY3+XYhRy/E3rENMcwYzupI4t4yvLrlurUhR57UieG6i86grAw8U3SShTyJKhysAukU3TWICEqZGo4we19F7b/mWQkFz8cPXZgPfZJF8ZyGm6tqLUJ3SZohaev77IUA9sxtlHi5dSxlWLQXIJS48ugs2wbdPH5LYU/+2KBuYSPllV+vGcfxteSDN1jPFPOaa9inS5Hd++rNN8hx8ETCeCAi4grVL3oz8t4FbLhSd38d4LaY6JsOo+1y+adH6+kl02SmNhtkuVPZ0ZIassfxMSRFOe3kmkGwcBjPznr8BuRQDDtD/KB63ZD5nJC8mCq6GiXQolosoksuXgtnvSY1CDP7Nz0HJ3LiTTo1xv0nubA2yDhKdSxxq/Xg/Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC8F2E77171DFD4994B17BD2B8F16CC3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172b38b-b0e5-4295-b6a5-08d741d24b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 16:06:15.8429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+XzOq+7ZRA5+eLS6wUOvEi+WMdl/FrCKPehYJxwR0+X8alCDG2v6W8IrQwwf2HAs7zevs7PtnomMWdYJBNtRAmzN3a/zdet+veBd8YFt/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.139
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
Cc: Fam Zheng <fam@euphon.net>, Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjQuMDkuMjAxOSAyMzo0OCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8yNC8xOSAzOjA4IFBN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gZXJyb3JfYXBwZW5kX2hp
bnQgd2lsbCBub3Qgd29yaywgaWYgZXJycCA9PSAmZmF0YWxfZXJyb3IsIGFzIHByb2dyYW0NCj4+
IHdpbGwgZXhpdCBiZWZvcmUgZXJyb3JfYXBwZW5kX2hpbnQgY2FsbC4gRml4IHRoaXMgYnkgdXNl
IG9mIHNwZWNpYWwNCj4+IG1hY3JvIEVSUlBfRlVOQ1RJT05fQkVHSU4uDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KPj4gLS0tDQo+IA0KPiBXaXRoIHRoZSBhcHByb2FjaCBvZiBhIHBhcnRpYWwgY2xl
YW51cCAocmF0aGVyIHRoYW4gZ2xvYmFsbHkgZW5mb3JjaW5nDQo+IGl0IGZvciBhbGwgZnVuY3Rp
b25zIHdpdGggZXJycCBwYXJhbWV0ZXIpLCB3ZSdsbCBwcm9iYWJseSBiZSByZXJ1bm5pbmcNCj4g
dGhpcyBDb2NjaW5lbGxlIHNjcmlwdCByZWd1bGFybHksIHRvIHRyYWNrIGRvd24gYW55IHJlZ3Jl
c3Npb25zLg0KPiANCj4gDQo+PiArKysgYi9zY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yX2Fw
cGVuZF9oaW50LXVzYWdlLmNvY2NpDQo+PiBAQCAtMCwwICsxLDI1IEBADQo+PiArQHJ1bGUwQA0K
Pj4gKy8vIEFkZCBpbnZvY2F0aW9uIHRvIGVycnAtZnVuY3Rpb25zDQo+PiAraWRlbnRpZmllciBm
bjsNCj4+ICtAQA0KPj4gKw0KPj4gKyBmbiguLi4sIEVycm9yICoqZXJycCwgLi4uKQ0KPj4gKyB7
DQo+PiArKyAgIEVSUlBfRlVOQ1RJT05fQkVHSU4oKTsNCj4+ICsgICAgPCsuLi4NCj4+ICsgICAg
ZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgLi4uKTsNCj4+ICsgICAgLi4uKz4NCj4+ICsgfQ0KPiAN
Cj4gRG9lcyBub3QgY2F0Y2ggdGhlIGNhc2UgdGhhdCB3ZSB3YW50IHRvIGFsc28gdXNlIHRoZSBt
YWNybyBmb3IgYW55IHVzZQ0KPiBvZiAqZXJycCwgYnV0IHdlIGNhbiBhdWdtZW50IHRoYXQgbGF0
ZXIuDQoNCkkgZG9uJ3Qgd2FudCB0byBpbmNsdWRlICplcnJwIGhlcmUsIGFzIGFjdHVhbGx5IGEg
bG90IG9mICplcnJwIGludm9jYXRpb25zIGluDQpjb2RlIGFyZSBjb3JyZWN0OiB0aGV5IGRvIGl0
IGlmIGVycnAgaXMgbm90IE5VTEwuIFNvLCBpdCdzIG5vdCByZWxhdGVkIHRvIHBsYW4gQi4NCg0K
U3RpbGwsIEkgdGhpbmsgd2UgZm9yZ2V0IGFib3V0IGVycm9yX3ByZXBlbmQgOikpKQ0KDQpJJ3Zl
IGNoZWNrZWQsIGlmIEkgaW5jbHVkZSBlcnJvcl9wcmVwZW5kIGhlcmUsIHNlcmllcyBiZWNvbWVz
IDMwIHBhdGNoZXMsIHdoaWNoIGlzDQpub3Qgc2lnbmlmaWNhbnRseSBsYXJnZXIuIFNvIEkgdGhp
bmssIEknbGwgY292ZXIgZXJyb3JfcHJlcGVuZCBpbiB2NC4NCg0KPiANCj4+ICsNCj4+ICtAQA0K
Pj4gKy8vIERyb3AgZG91YmxlZCBpbnZvY2F0aW9uDQo+PiAraWRlbnRpZmllciBydWxlMC5mbjsN
Cj4+ICtAQA0KPj4gKw0KPj4gKyBmbiguLi4pDQo+PiArew0KPj4gKyAgICBFUlJQX0ZVTkNUSU9O
X0JFR0lOKCk7DQo+PiArLSAgIEVSUlBfRlVOQ1RJT05fQkVHSU4oKTsNCj4+ICsgICAgLi4uDQo+
PiArfQ0KPiANCj4gVGhpcyBpcyBzbWFsbGVyIHRoYW4gdGhlIHNjcmlwdCB5b3UgcG9zdGVkIGlu
IHYyLCBhbmQgdGh1cyBJJ20gYSBiaXQNCj4gbW9yZSBjb25maWRlbnQgaW4gc3RhdGluZyB0aGF0
IGl0IGxvb2tzIGNvcnJlY3QgYW5kIGlkZW1wb3RlbnQuDQo+IA0KPiBSZXZpZXdlZC1ieTogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

