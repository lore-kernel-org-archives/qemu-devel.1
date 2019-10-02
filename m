Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B6CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE2A21783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cpo58WnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE2A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFf2q-0001Ts-Us
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFf25-0000xY-0d
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFf23-0003BK-BC
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:51:08 -0400
Received: from mail-eopbgr20123.outbound.protection.outlook.com
 ([40.107.2.123]:2531 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFf22-00038j-Jl; Wed, 02 Oct 2019 09:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghIfwgSfllL8koaO9TdspMHiJ9Td4pbeZyJsqrNM/ooiyzXuODwfG1axFJoCZW90SdsdfRhnjz3K2Q3yy2Ih6lgfO7ekXV+LPPZR9ZzZ8GZvChewQ36G2kT/RyX0pZT4Z6LBdhufC+imeKMWAzUb1Aqzu1zqTlFUJaVtPJmQlWN2c+Z2QU46ZlgXuIZ0n+CIm/FsVxJ/eXmztqIj2sq45f7PhvnTgLlAQecUk0CWVRjK6tZ0LsLPANI++DAm0xEmnh9jK7Ps1RYRdULAKSPuDTd1agrEKIIBxC5vUn2nl4ML9vVubW9noLscHJmQ1ISTQNHuVNsHloHE5bsPlfI+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMPQnyZD1yNIhgMhsJdK/jHqH3ufrITizV3i7dV/gqU=;
 b=BMbxYTTuh7BOLIgQvztYgEoxqtRvRjJRgOr7PQ6H2NDdCzu8E60fzxnUw556TXEk9mEuGaeHO/FWDupurnqeJP/1EZsi9ll1jIDUp4cu1uD9D10F0zV0poR4Y1YI9dL0I4HZAohYwvU+IIORQIbWoFG5AFjuL5qKgCCfSbAB+1X71Nkbh7Aqjv+8MadqTQVfMkM/Bb4hVrwzK4OZRQgHaWuHdDp1+BXlAB5CfSAKp/ZROrfwgA7qrc45HFprMIIdqrJEwHYgIzcscJEKrEUzyGErNgCGFDXfIoho8TAVuOyTsPIcKzxmA7dK9iYfFD0ElVjPTZHA7382gjHyAQihXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMPQnyZD1yNIhgMhsJdK/jHqH3ufrITizV3i7dV/gqU=;
 b=cpo58WnDoJPwXaw19d3HodXvidpjvBKUcBvxlNzdQrP8QNedZ6TnNNIHO3gIQlFbY/X1JcfprOqyz65w4x6hhD7ZBcL8y9ZfCqRMZFtHUYqZHGIv7dPm09IsWlFdiLA6GHDQbDaxpqkEkETAM6SyudNbYfFOWq4/MkZhFEa0MS4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3996.eurprd08.prod.outlook.com (20.179.9.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 13:51:01 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:51:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 17/22] iotests: Add VM.assert_block_path()
Thread-Topic: [PATCH 17/22] iotests: Add VM.assert_block_path()
Thread-Index: AQHVb8qng16jD1DLk0mMEq10srCWrqc+B8EAgAlVwICAABO/AA==
Date: Wed, 2 Oct 2019 13:51:00 +0000
Message-ID: <b564a2f1-e0cf-7e10-ec84-665f5b246643@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-18-mreitz@redhat.com>
 <de0a9fe2-ea84-7be9-6911-b806f032cfff@virtuozzo.com>
 <b977e9f8-53f0-290e-5eb5-73c02469779b@redhat.com>
In-Reply-To: <b977e9f8-53f0-290e-5eb5-73c02469779b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0024.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002165058313
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5177c3a-9006-4cf9-9841-08d7473f8f3c
x-ms-traffictypediagnostic: DB8PR08MB3996:
x-microsoft-antispam-prvs: <DB8PR08MB39969C42364B31C15A8FAC69C19C0@DB8PR08MB3996.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(39850400004)(376002)(199004)(189003)(54906003)(102836004)(2501003)(6246003)(6512007)(66946007)(486006)(66446008)(229853002)(26005)(36756003)(71190400001)(71200400001)(66066001)(25786009)(446003)(476003)(2616005)(478600001)(4326008)(11346002)(86362001)(3846002)(52116002)(186003)(76176011)(6116002)(305945005)(31696002)(8676002)(316002)(14454004)(7736002)(2906002)(110136005)(81166006)(81156014)(386003)(6486002)(66556008)(66476007)(64756008)(6436002)(6506007)(53546011)(256004)(14444005)(31686004)(99286004)(5660300002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3996;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dOacOzRRgJ7UcKX+l5Ywx3iWJ5JNBcZrQU8DLzgA34I1BgWvAGKxWnqnBQN615I80xZ8zrDiAw4qIsgFRVAE51DL/f/Ovrdwv5pEPBk9oUVICWHFZs+mGdApKvqMbfHk/11rPjPH1N5QorCWdFldGtEmo6FK9TJ/ZGQU6seyY9zjCYTtLyL3dI+DFwdAahLxHYfPvZVnkvnJOO1R0I7vIcbrAZFb90G2FxeqF0SjwHQ9puv8RZFmUi0bl6hG4j1z5+U+L3EA46fS/UTRyHcCu0qVj/m3qdy/mGKslootK+ib93FVWhWGfMusfGTgcp9Us234xTm+CSpCydsCW3kpy1U17A1dFvIHwpstjYtA6BmgmWjARe2jAGv57lbzZLyU5/jTErQ+12TUb1WYggLfmwK0zYBz1eGbLgQB64NLDVg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <162BDACF0A7E694F93EB12EEF2388F8B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5177c3a-9006-4cf9-9841-08d7473f8f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:51:00.9600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ltm3bToHMeX8XgbZsy1+T5+M8rjfIVMFxs+xUX5ICHQ5pHTegqQDEmoSN97fjSeaTpKKIXwpYlAs5S2VFkEwbS8I37yYzEvXSKuWlOdnn94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3996
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.123
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

MDIuMTAuMjAxOSAxNTo0MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOS4xOSAxNjowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIwLjA5LjIwMTkgMTg6Mjcs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekBy
ZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5
IHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy9pb3Rlc3RzLnB5IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+
PiBpbmRleCBkYWVkNGVlMDEzLi5lNmZiNDYyODdkIDEwMDY0NA0KPj4+IC0tLSBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVz
dHMucHkNCj4+PiBAQCAtNjcwLDYgKzY3MCw1NCBAQCBjbGFzcyBWTShxdGVzdC5RRU1VUXRlc3RN
YWNoaW5lKToNCj4+PiAgICANCj4+PiAgICAgICAgICAgIHJldHVybiBmaWVsZHMuaXRlbXMoKSA8
PSByZXQuaXRlbXMoKQ0KPj4+ICAgIA0KPj4+ICsgICAgJycnDQo+Pj4gKyAgICBAcGF0aCBpcyBh
IHN0cmluZyB3aG9zZSBjb21wb25lbnRzIGFyZSBzZXBhcmF0ZWQgYnkgc2xhc2hlcy4NCj4+PiAr
ICAgIFRoZSBmaXJzdCBjb21wb25lbnQgaXMgYSBub2RlIG5hbWUsIHRoZSByZXN0IGFyZSBjaGls
ZCBuYW1lcy4NCj4+PiArICAgIEV4YW1wbGVzOg0KPj4+ICsgICAgICAtICJxY293Mi1ub2RlL2Jh
Y2tpbmcvZmlsZSINCj4+PiArICAgICAgLSAicXVvcnVtLW5vZGUvY2hpbGRyZW4uMi9maWxlIg0K
Pj4NCj4+IFBvc3NpYmx5LCBzZXBhcnRpbmcgbm9kZS1uYW1lIHRvIGZpcnN0IHBhcmFtZXRlciBh
bmQga2VlcGluZyBjaGlsZC1wYXRoIGFzDQo+PiBhIHNlY29uZCB3aWxsIHNpbXBsaWZ5IGNvZGUg
YSBiaXQsIGFuZCBiZSBtb3JlIHVzZWZ1bCBmb3IgY2FzZXMgd2hlbiBvbiBjYWxsZXINCj4+IHBh
cnQgbm9kZS1uYW1lIGlzIGluIHZhcmlhYmxlLg0KPiANCj4gU291bmRzIGdvb2QuDQo+IA0KPj4+
ICsNCj4+PiArICAgIEBleHBlY3RlZF9ub2RlIG1heSBiZSBOb25lLg0KPj4+ICsNCj4+PiArICAg
IEBncmFwaCBtYXkgYmUgTm9uZSBvciB0aGUgcmVzdWx0IG9mIGFuIHgtZGVidWctcXVlcnktYmxv
Y2stZ3JhcGgNCj4+PiArICAgIGNhbGwgdGhhdCBoYXMgYWxyZWFkeSBiZWVuIHBlcmZvcm1lZC4N
Cj4+PiArICAgICcnJw0KPj4+ICsgICAgZGVmIGFzc2VydF9ibG9ja19wYXRoKHNlbGYsIHBhdGgs
IGV4cGVjdGVkX25vZGUsIGdyYXBoPU5vbmUpOg0KPj4+ICsgICAgICAgIGlmIGdyYXBoIGlzIE5v
bmU6DQo+Pj4gKyAgICAgICAgICAgIGdyYXBoID0gc2VsZi5xbXAoJ3gtZGVidWctcXVlcnktYmxv
Y2stZ3JhcGgnKVsncmV0dXJuJ10NCj4+DQo+PiBZYXkhIEknbSBoYXBweSB0byBzZWUgdGhhdCBp
dCdzIHVzZWZ1bC4NCj4gDQo+IDotKQ0KPiANCj4gSXTigJlzIHByb2JhYmx5IHRoZSBiZXN0IHF1
ZXJ5IGZ1bmN0aW9uIHdlIGhhdmUuDQo+IA0KPj4+ICsNCj4+PiArICAgICAgICBpdGVyX3BhdGgg
PSBpdGVyKHBhdGguc3BsaXQoJy8nKSkNCj4+PiArICAgICAgICByb290ID0gbmV4dChpdGVyX3Bh
dGgpDQo+Pj4gKyAgICAgICAgdHJ5Og0KPj4+ICsgICAgICAgICAgICBub2RlID0gbmV4dChub2Rl
IGZvciBub2RlIGluIGdyYXBoWydub2RlcyddIGlmIG5vZGVbJ25hbWUnXSA9PSByb290KQ0KPj4+
ICsgICAgICAgIGV4Y2VwdCBTdG9wSXRlcmF0aW9uOg0KPj4+ICsgICAgICAgICAgICBub2RlID0g
Tm9uZQ0KPj4NCj4+IGZvciBzdWNoIHVzYWdlIG5leHQgaGFzIHNlY29uZCBvcHRpb25hbCBhcmd1
bWVudDogbmV4dChpdGVyYXRvclssIGRlZmF1bHRdKQ0KPiANCj4gR3JlYXQhDQo+IA0KPj4gKGRv
bid0IHRoaW5rIEkgdGVhY2ggeW91IFB5dGhvbiwgYWN0dWFsbHkgeW91IHRlYWNoIG1lLCBhcyBi
ZWZvcmUgSSBkaWRuJ3Qga25vdw0KPj4gY29ycmVjdCB3YXkgdG8gc2VhcmNoIGZpcnN0IGVsZW1l
bnQgd2l0aCBjb25kaXRpb24pDQo+IA0KPiBXZSBsZWFybiBmcm9tIG9uZSBhbm90aGVyLCB3aGlj
aCBpcyB0aGUgYmVzdCBjYXNlLg0KPiANCj4+PiArDQo+Pj4gKyAgICAgICAgZm9yIHBhdGhfbm9k
ZSBpbiBpdGVyX3BhdGg6DQo+Pj4gKyAgICAgICAgICAgIGFzc2VydCBub2RlIGlzIG5vdCBOb25l
LCAnQ2Fubm90IGZvbGxvdyBwYXRoICVzJyAlIHBhdGgNCj4+PiArDQo+Pj4gKyAgICAgICAgICAg
IHRyeToNCj4+PiArICAgICAgICAgICAgICAgIG5vZGVfaWQgPSBuZXh0KGVkZ2VbJ2NoaWxkJ10g
Zm9yIGVkZ2UgaW4gZ3JhcGhbJ2VkZ2VzJ10gXA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiBlZGdlWydwYXJlbnQnXSA9PSBub2RlWydpZCddIGFu
ZA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
ZGdlWyduYW1lJ10gPT0gcGF0aF9ub2RlKQ0KPj4NCj4+IEhtbSBoZXJlIHlvdSBhbGxvdyBkZWZh
dWx0IFN0b3BJdGVyYXRpb24gZXhjZXB0aW9uIFsxXQ0KDQpicnIsIEkganVzdCBtaXN0YWtlbiBo
ZXJlOiB3ZSBhcmUgaW4gc2FtZSB0cnktZXhjZXB0IGFzIHRoZSBmb2xsb3dpbmcgbGluZSwgYW5k
IHdlJ2xsDQpjYXRjaCBpdCBvZiBjb3Vyc2UNCg0KPj4NCj4+DQo+Pj4gKw0KPj4+ICsgICAgICAg
ICAgICAgICAgbm9kZSA9IG5leHQobm9kZSBmb3Igbm9kZSBpbiBncmFwaFsnbm9kZXMnXSBcDQo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIG5vZGVbJ2lkJ10gPT0gbm9k
ZV9pZCkNCj4+PiArICAgICAgICAgICAgZXhjZXB0IFN0b3BJdGVyYXRpb246DQo+Pj4gKyAgICAg
ICAgICAgICAgICBub2RlID0gTm9uZQ0KPj4NCj4+IGFjdHVhbGx5LCBJIHRoaW5rIHRoaXMgd2ls
bCBuZXZlciBoYXBwZW4sIHNvIHdlIG1heSBzaW1wbGlmeSBjb2RlIGFuZCBhbGxvdyBpdCB0bw0K
Pj4gdGhyb3cgU3RvcEl0ZXJhdGlvbiBleGNlcHRpb24gaW4gdGhpcyBpbXBvc3NpYmxlIGNhc2Uu
Lg0KPiANCj4gVGhpcyBpcyBmb3IgYSB1c2UgY2FzZSB3aGVyZSB0aGUgbmV4dCBjaGlsZCBzaW1w
bHkgZG9lc27igJl0IGV4aXN0LCBzbyB5b3UNCj4gY2FuIGRvOg0KPiANCj4gYXNzZXJ0X2Jsb2Nr
X3BhdGgoJ3Fjb3cyLW5vZGUvYmFja2luZycsIE5vbmUpDQo+IA0KPiBUbyB2ZXJpZnkgdGhhdCB0
aGUgcWNvdzIgbm9kZSBoYXMgbm8gYmFja2luZyBmaWxlLg0KPiANCj4+PiArDQo+Pj4gKyAgICAg
ICAgYXNzZXJ0IG5vZGUgaXMgbm90IE5vbmUgb3IgZXhwZWN0ZWRfbm9kZSBpcyBOb25lLCBcDQo+
Pj4gKyAgICAgICAgICAgICAgICdObyBub2RlIGZvdW5kIHVuZGVyICVzIChidXQgZXhwZWN0ZWQg
JXMpJyAlIFwNCj4+PiArICAgICAgICAgICAgICAgKHBhdGgsIGV4cGVjdGVkX25vZGUpDQo+Pg0K
Pj4gbm9kZSBtYXkgYmUgTm9uZSBoZXJlIG9ubHkgZnJvbSBsYXN0IGl0ZXJhdGlvbiwgYnV0IGl0
IGNhbid0IGhhcHBlbjogaWYgd2UgaGF2ZSBlZGdlDQo+PiB3aXRoIGNoaWxkLCB3ZSdsbCBmb3Ig
c3VyZSBoYXZlIG5vZGUgd2l0aCBzdWNoIG5vZGUtbmFtZSBpbiBncmFwaA0KPiANCj4gbm9kZSB3
aWxsIGFsd2F5cyBiZSBzZXQgYnkgdGhlIHRyeS1leGNlcHQgYmxvY2ssIHdvbuKAmXQgaXQ/DQo+
IA0KPj4+ICsNCj4+PiArICAgICAgICBhc3NlcnQgZXhwZWN0ZWRfbm9kZSBpcyBub3QgTm9uZSBv
ciBub2RlIGlzIE5vbmUsIFwNCj4+PiArICAgICAgICAgICAgICAgJ0ZvdW5kIG5vZGUgJXMgdW5k
ZXIgJXMgKGJ1dCBleHBlY3RlZCBub25lKScgJSBcDQo+Pj4gKyAgICAgICAgICAgICAgIChub2Rl
WyduYW1lJ10sIHBhdGgpDQo+Pg0KPj4gaG1tLCBzbyBleHBlY3RlZF9ub2RlPU5vbmUgbWVhbnMg
d2Ugd2FudCB0byBwcm92ZSB0aGF0IHRoZXJlIGlzIG5vIHN1Y2ggbm9kZT8gSXQgc2hvdWxkDQo+
PiBiZSBtZW50aW9uZWQgaW4gY29tbWVudCBhYm92ZSB0aGUgZnVuY3Rpb24uIEJ1dCB0aGlzIGRv
bid0IHdvcmsgZHVlIHRvIFsxXQ0KPiANCj4gSG0sIEkgc2VlbSB0byByZW1lbWJlciBJIHRlc3Rl
ZCBhbGwgY2FzZXMgbG9jYWxseSBhbmQgdGhleSBhbGwgd29ya2VkLg0KPiANCj4gTWF4DQo+IA0K
Pj4+ICsNCj4+PiArICAgICAgICBpZiBub2RlIGlzIG5vdCBOb25lIGFuZCBleHBlY3RlZF9ub2Rl
IGlzIG5vdCBOb25lOg0KPj4+ICsgICAgICAgICAgICBhc3NlcnQgbm9kZVsnbmFtZSddID09IGV4
cGVjdGVkX25vZGUsIFwNCj4+PiArICAgICAgICAgICAgICAgICAgICdGb3VuZCBub2RlICVzIHVu
ZGVyICVzIChidXQgZXhwZWN0ZWQgJXMpJyAlIFwNCj4+PiArICAgICAgICAgICAgICAgICAgIChu
b2RlWyduYW1lJ10sIHBhdGgsIGV4cGVjdGVkX25vZGUpDQo+Pj4gICAgDQo+Pj4gICAgaW5kZXhf
cmUgPSByZS5jb21waWxlKHInKFteXFtdKylcWyhbXlxdXSspXF0nKQ0KPj4+ICAgIA0KPj4+DQo+
Pg0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

