Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6549C22519
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EEazWiII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549C22519
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXP6z-0000Ht-JX
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXP5c-0007wg-FA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXP5X-00086s-Ds
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:28:08 -0500
Received: from mail-eopbgr140135.outbound.protection.outlook.com
 ([40.107.14.135]:32484 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXP5S-0007y2-TB; Wed, 20 Nov 2019 07:27:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keQ/3FOgerpNJf1oFGY3fTVBFvHv/d3I3duLxTbzAiOBaemBz1L0RLdxSNorb0/F/PUPIukmst4aVFw2i61TglfVWAFSNWk+iaIV8JzhVoqUt5KHBHH5fUDegUZJF204temL681TdTJc6GXJiiTvQQ0QZAIuPZRp2TcekKD6w+lXFgc/6C9KafWxgwuvfPS9ZIn3TbgMhsG1cFrb394yYOqWktQ5Jk5YXkEuUo+9+SlCtHUUnuS8BBbox9wYOHlcLxgijhhUeUOl+jQYVLmQ3DJt1IwF8x/5ixtT3/lV+g3xmp5vxAXDXCCg5hBec1Mrs0J3Upy+OHchuvfp0xY5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqGRUD4ENtmZb0DcIyK3HSXSUQOpNThTcILn3ltEA8k=;
 b=Naq7A7hIfIqGOTDW+lq9Ju97NeqyvEFt6K5Dm+MDRmB2fdDVovkbBlSe9RQyOtIncVxxGlQUPwwsp6M5IqFEWJ9NdW6Spj0JbA39iC9rhypmgQ7cNVMxhJYlICSMGCITcuh0ms5siF1PS8EZbc/CuxAcu1zGXO04TCBWE0sceITx/KKg5VujDbzejQVajpV6R0jpvaRy8mtz+HU0WqhOFnGcvFSJSAPr5dUwtpmihi1EHTjm6HCVga/CNOgkramq1e/OtF/nb/5XhQ0uDuOmSPNK7FiI3JsMn49jwsLR/qwMeg+rvW9ApZpeXprfeSkVsWY7kc+rZnd4ej63cy1oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqGRUD4ENtmZb0DcIyK3HSXSUQOpNThTcILn3ltEA8k=;
 b=EEazWiIIAVJLVvLUZFrsD2LS34V6djKzc7koyq26ZCngI7oZ1BAUyu6LodQMb6A4ULsaM0Be8uFtslaLBnFUEsbdE9Rf41n1P99+pCVMiirefFJwjcE/ee6ff1/RbZNhWsG36EcljMEJLwM2tbqjO2GG/pkpOKd/tsyjpm5y8EU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3638.eurprd08.prod.outlook.com (20.177.114.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:27:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 12:27:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: qcow2 preallocation and backing files
Thread-Topic: qcow2 preallocation and backing files
Thread-Index: AQHVn5wABMjtyQWeikidTGAJT/kh76eT/KGA
Date: Wed, 20 Nov 2019 12:27:53 +0000
Message-ID: <a1575e90-3fe4-e843-518c-714db4b621bc@virtuozzo.com>
References: <20191120120625.GA25497@igalia.com>
In-Reply-To: <20191120120625.GA25497@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120152751711
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d74c81c5-4c55-4e47-472c-08d76db510e5
x-ms-traffictypediagnostic: AM6PR08MB3638:
x-microsoft-antispam-prvs: <AM6PR08MB363860F23619172138E97845C14F0@AM6PR08MB3638.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(136003)(396003)(346002)(189003)(199004)(476003)(4326008)(25786009)(64756008)(66476007)(76176011)(66946007)(36756003)(486006)(66066001)(66556008)(66446008)(6116002)(3846002)(305945005)(7736002)(52116002)(31696002)(71190400001)(14444005)(256004)(71200400001)(86362001)(5660300002)(2906002)(6246003)(186003)(81166006)(6436002)(6486002)(8936002)(81156014)(8676002)(6506007)(102836004)(446003)(110136005)(11346002)(99286004)(229853002)(2616005)(386003)(6512007)(31686004)(14454004)(54906003)(2501003)(316002)(26005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3638;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SanPzVm/xuAM2+QGpxb6krOad7uhaIXDA/L/1iizZ7Uh8QkC+mTGmTGtYpNRBPMfLKbhPVtMqkOqhycMoI/6IuAvZkM9YOG+dUEPZ0EthAQVijr4+Mn4NhT8QQ61NVssrnravMFX1HAbgGRiSSAsC3/ZpfUCRqMCsdXP5SfC1pnqP7t60pYY8iMoHOjWwNTCjoxDCiAw25rlLO+Hu3gE96oBxRHCZanuFhLLOF/FPbsOWEljRx9NpBV+y7LfpdVdhDsgvULi6Kjk/g3pyyn19pxOIOgsGyg5d+qLGtkTUzbInPl+XXYGZlB0EtfRzXZdrccZVFm2D+gFgOc5DIBdEk5mcheOKUm3S+KlqF7yxiSMseSvqHiFNBbfW5wZ0uWQIx4k6q+LDgHqloBqnQYXF+X1d21sqkBxhGFUnDGPOxUY5QMHsamlvIBtHTHExalk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DEC2F9BE6415418A508950E2A6B9C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c81c5-4c55-4e47-472c-08d76db510e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 12:27:53.8013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl02/Ols5SX1Eqm6RAJAL7zKqfvAjTvFgK/4SXjPu0xdy9Uzp9n3Yl/hENrgaDgpRXYdJid/gqJjGCWqC66H+1n3bAMk3+Uf17YWe3auXOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3638
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.135
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMTEuMjAxOSAxNTowNiwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IEhpLA0KPiANCj4gYXMg
d2UgZGlzY3Vzc2VkIHllc3RlcmRheSBvbiBJUkMgdGhlcmUncyBhbiBpbmNvbnNpc3RlbmN5IGlu
IHRoZSB3YXkNCj4gcWNvdzIgcHJlYWxsb2NhdGlvbiB3b3Jrcy4NCj4gDQo+IExldCdzIGNyZWF0
ZSBhbiBpbWFnZSBhbmQgZmlsbCBpdCB3aXRoIGRhdGE6DQo+IA0KPiAgICAgJCBxZW11LWltZyBj
cmVhdGUgLWYgcmF3IGJhc2UuaW1nIDFNDQo+ICAgICAkIHFlbXUtaW8gLWYgcmF3IC1jICd3cml0
ZSAtUCAweEZGIDAgMU0nIGJhc2UuaW1nDQo+IA0KPiBOb3cgUUVNVSB3b24ndCBsZXQgdXMgY3Jl
YXRlIGEgbmV3IGltYWdlIGJhY2tlZCBieSBiYXNlLmltZyB1c2luZw0KPiBwcmVhbGxvY2F0aW9u
Og0KPiANCj4gICAgICQgcWVtdS1pbWcgY3JlYXRlIC1mIHFjb3cyIC1iIGJhc2UuaW1nIC1vIHBy
ZWFsbG9jYXRpb249bWV0YWRhdGEgYWN0aXZlLmltZw0KPiAgICAgcWVtdS1pbWc6IGFjdGl2ZS5p
bWc6IEJhY2tpbmcgZmlsZSBhbmQgcHJlYWxsb2NhdGlvbiBjYW5ub3QgYmUgdXNlZCBhdCB0aGUg
c2FtZSB0aW1lDQo+IA0KPiBUaGUgcmVhc29uIGlzIHRoYXQgb25jZSBhIGNsdXN0ZXIgaXMgcHJl
YWxsb2NhdGVkIChpLmUuIGl0IGhhcyBhIHZhbGlkDQo+IEwyIGVudHJ5IHBvaW50aW5nIHRvIGEg
aG9zdCBvZmZzZXQpIHRoZSBndWVzdCB3b24ndCBzZWUgdGhlIGNvbnRlbnRzDQo+IG9mIHRoZSBi
YWNraW5nIGZpbGUsIHNvIHRob3NlIG9wdGlvbnMgY29uZmxpY3Qgd2l0aCBlYWNoIG90aGVyLg0K
PiANCj4gSXQgaXMgcG9zc2libGUgaG93ZXZlciB0byBjcmVhdGUgYW4gaW1hZ2UgdGhhdCBpcyBz
bWFsbGVyIHRoYW4NCj4gdGhlIGJhY2tpbmcgZmlsZSBhbmQgdGhlbiByZXNpemUgaXQgdXNpbmcg
cHJlYWxsb2NhdGlvbi4gSW4gdGhpcw0KPiBjYXNlIHFlbXUtaW1nIHdpbGwgaGFwcGlseSBhY2Nl
cHQgYW55IC0tcHJlYWxsb2NhdGlvbiBvcHRpb24sIHdpdGgNCj4gZGlmZmVyZW50IHJlc3VsdHMg
ZnJvbSB0aGUgZ3Vlc3QncyBwb2ludCBvZiB2aWV3Og0KPiANCj4gICAgICMgVGhpcyByZWFkcyBh
cyAweEZGICh0aGUgZGF0YSBjb21lcyBmcm9tIGJhc2UuaW1nKQ0KPiAgICAgJCBxZW11LWltZyBj
cmVhdGUgLWYgcWNvdzIgLWIgYmFzZS5pbWcgYWN0aXZlLmltZyA1MTJLDQo+IA0KPiAgICAgIyBU
aGUgc2Vjb25kIGhhbGYgb2YgdGhlIGltYWdlIGFsc28gcmVhZHMgYXMgMHhGRg0KPiAgICAgJCBx
ZW11LWltZyByZXNpemUgLS1wcmVhbGxvY2F0aW9uPW9mZiBhY3RpdmUuaW1nIDFNDQo+IA0KPiAg
ICAgIyBIZXJlIHRoZSBzZWNvbmQgaGFsZiByZWFkcyBhcyB6ZXJvZXMNCj4gICAgICQgcWVtdS1p
bWcgcmVzaXplIC0tcHJlYWxsb2NhdGlvbj1tZXRhZGF0YSBhY3RpdmUuaW1nIDFNDQo+IA0KPiBB
cGFydCBmcm9tICJxZW11LWltZyByZXNpemUiLCB0aGUgUU1QIGJsb2NrLXJlc2l6ZSBjb21tYW5k
IGNhbiBhbHNvDQo+IGV4dGVuZCBhbiBpbWFnZSBsaWtlIHRoaXMsIGFsdGhvdWdoIGl0IGFsd2F5
cyB1c2VzIFBSRUFMTE9DX01PREVfT0ZGDQo+IGFuZCB0aGUgdXNlciBjYW5ub3QgY2hhbmdlIHRo
YXQuDQo+IA0KPiBJdCBkb2VzIG5vdCBzZWVtIHJpZ2h0IHRoYXQgdGhlIGd1ZXN0LXZpc2libGUg
ZGF0YSBjaGFuZ2VzIGRlcGVuZGluZw0KPiBvbiB0aGUgcHJlYWxsb2NhdGlvbiBtb2RlLiBUaGlz
IGNvdWxkIGJlIHNvbHZlZCBieSByZXR1cm5pbmcgYW4gZXJyb3INCj4gd2hlbiAoYmFja2luZ19i
cyhibGtfYnMoYmxrKSkgJiYgcHJlYWxsb2MgIT0gUFJFQUxMT0NfTU9ERV9PRkYpIG9uDQo+IGlt
Z19yZXNpemUoKS4NCj4gDQo+IFRoZSBpbXBvcnRhbnQgcXVlc3Rpb24gaXMgaG93ZXZlcjogd2hh
dCBiZWhhdmlvciBpcyB0aGUgcmlnaHQgb25lPw0KPiBTaG91bGQgZ3Jvd2luZyBhbiBpbWFnZSB0
aGF0IHdhcyBzbWFsbGVyIHRoYW4gdGhlIGJhY2tpbmcgZmlsZSByZXR1cm4NCj4gemVyb2VzLCBv
ciBkYXRhIGZyb20gdGhlIGJhY2tpbmcgZmlsZT8gSSB3b3VsZCBvcHQgZm9yIHRoZSBsYXR0ZXIs
IGZvcg0KPiBzaW1wbGljaXR5IGFuZCBjb25zaXN0ZW5jeSB3aXRoIHRoZSBjdXJyZW50IGJlaGF2
aW9yIG9mIGJsb2NrLXJlc2l6ZSwNCj4gYWx0aG91Z2ggaXQgd2FzIHBvaW50ZWQgb3V0IHRoYXQg
dGhpcyBjb3VsZCBiZSBhIHNlY3VyaXR5IHByb2JsZW0gKEknbQ0KPiBub3Qgc3VyZSB0aGF0IEkg
YWdyZWUgd2l0aCB0aGF0LCBidXQgd2UgY2FuIGRpc2N1c3MgaXQpLg0KDQpJJ20gZm9yIHplcm9z
IHdheS4NCg0KMS4gSSdtIHN1cmUgdGhhdCBpZiBndWVzdCBhZnRlciBzb21lIG9wZXJhdGlvbiBt
YXkgZ2V0IGFjY2VzcyB0byB0aGF0IGRhdGENCndoaWNoIGl0IHNob3VsZCBub3Qgc2VlLCBpdCdz
IGEgc2VjdXJpdHkgcHJvYmxlbS4NCg0KMi4gU2VpbmcgYmFja2luZyBmaWxlIHRocm91Z2ggbmV3
IGNsdXN0ZXJzIGlzIGluY29uc2lzdGVudCB3aXRoIGhvdyByZWFkIHdvcmtzOg0KcmVhZCB3aWxs
IHJldHVybiB6ZXJvZXMsIG5vdCBkYXRhIGZyb20gYmFja2luZy4gQ29uc2lkZXIgdGhlIGZvbGxv
d2luZyBleGFtcGxlOg0KDQogICAgICAwICAgICAgICAgeCAgICAgeQ0KdG9wOiBbLS0tLS0tLS0t
LS0tLS0tXQ0KbWlkOiBbLS0tLS0tLS0tXQ0KYmFzZTpbMTExMTExMTExMTExMTExXQ0KDQpyZWFk
aW5nIGZyb20gW3gseV0gZnJvbSB0b3Agd2lsbCByZXR1cm4gemVyb2VzLCBub3Qgb25lcy4NCg0K
U28sIGlmIHdlIGNvbnNpZGVyIGRhdGEgYWZ0ZXIgRU9GIGFzIHplcm9lcyAobm90IFVOQUxMT0NB
VEVEIGNsdXN0ZXJzKSwgd2Ugc2hvdWxkDQpub3QgbWFrZSB0aGVzZSBjbHVzdGVycyBVTkFMTE9D
QVRFRCBhZnRlciB0cnVuY2F0aW9uLg0KDQozLiBBbHNvLCB0aGUgbGF0dGVyIHdheSBpcyBpbmNv
bnNpc3RlbnQgd2l0aCBkaXNjYXJkLiBEaXNjYXJkZWQgcmVnaW9ucyByZXR1cm5zDQp6ZXJvZXMs
IG5vdCBjbHVzdGVycyBmcm9tIGJhY2tpbmcuIEkgdGhpbmsgZGlzY2FyZCBhbmQgdHJ1bmNhdGUg
c2hvdWxkIGJlaGF2ZQ0KaW4gdGhlIHNhbWUgc2FmZSB6ZXJvIHdheS4NCg0KPiANCj4gVGhpcyBh
bHNvIGhhcyBhIGNvbnNlcXVlbmNlIG9uIGhvdyBwcmVhbGxvY2F0aW9uIHNob3VsZCBiZSBpbXBs
ZW1lbnRlZA0KPiBmb3IgaW1hZ2VzIHdpdGggc3ViY2x1c3RlcnMuIEV4dGVuZGVkIEwyIGVudHJp
ZXMgYWxsb3cgdXMgdG8gYWxsb2NhdGUNCj4gYSBjbHVzdGVyIGJ1dCBsZWF2ZSBlYWNoIG9uZSBv
ZiBpdHMgc3ViY2x1c3RlcnMgdW5hbGxvY2F0ZWQuIFRoYXQNCj4gd291bGQgYWxsb3cgdXMgdG8g
aGF2ZSBhIGNsdXN0ZXIgdGhhdCBpcyBzaW11bHRhbmVvdXNseSBhbGxvY2F0ZWQgYnV0DQo+IHdo
b3NlIGRhdGEgaXMgcmVhZCBmcm9tIHRoZSBiYWNraW5nIGZpbGUuIEJ1dCBpdCdzIHVwIHRvIHVz
IHRvIGRlY2lkZQ0KPiBpZiB0aGF0J3Mgd2hhdCB3ZSBzaG91bGQgZG8gd2hlbiByZXNpemluZyBh
biBpbWFnZS4NCj4gDQo+IEJlcnRvDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

