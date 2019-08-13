Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142AA20673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PBxL02RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142AA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxT23-000362-5B
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxT0v-0001z7-G7
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxT0u-00006T-76
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:22:45 -0400
Received: from mail-ve1eur02on0729.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::729]:14854
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxT0t-0008V4-HK; Tue, 13 Aug 2019 05:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa7wwSnNOJNZYv4m3XAYKuDsAIkvOZOqUFsVkjBdspcDNx0WUVKyCTLwlp5dTPdvyvUjkHcSVov2sL9GK9sXOQ0bcmGtIEk/8hMlfXiQvdaLhuc3vyqE9DHAjIip3T+eQJgs+7dOk5stCUJFXP60BY7qVkqR/JRzf8mv01lT5JIjG3Lac7ap7Np/En8x5gNp5OKiLcpp/3wvy2V3O4m/9idVUtHLOteu5wp9MBhtqQaLs5PGAAJS9ZdZZeCXspMgUhi3Fhkc8OAeVyjErMVfkBXJS9zYlXhI9ZWosXILQ+HizrkgWxgzxYpjtfY9JFwUdfMV0ZVzg/R6D7Mpn3ZiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvBU10H9JyrxOyTjoy7c+4HZEVFt+buU5p+J4I4Mq7k=;
 b=k916INppU2GD0b1iBCMgTQQq1Yhuwpp9gCgD4lu8VqP5MQdwBkHK7PFWbOuCAa7EaoxlsI9Rv7Rn6GjT5yMfY2H7yQzu3uO9HYFTEGbEIDxIAV0OluK8ExsDl9Trlj0d2EGbdStmUazb20MBGvm+V8YyKXeZrm99puMJ6p7RJIlk2POq7tlRrVMotD8VIUEBbQhemoDGXemfQuFjPX6p+0fzJuf1PyE4qN15wkWRkFIA5twEOQ6H8abKHAr4lh0DvScU/NjwxXSm73dxP2NhIb0zlgU+0p9wm9LiztZbLiu0HFc2GH3hugPBgM6KXXy8itLxjHcSGMWEBdMxGgU+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvBU10H9JyrxOyTjoy7c+4HZEVFt+buU5p+J4I4Mq7k=;
 b=PBxL02RN0CNnJMAIJDi4IElogwYti2tfZpwi3cxJCp50GoQ4ObbobPtoivtQzg9Xl9gsxZUoQM+QaIBDC9TCeMGwN2W2lvzvEOQrhXR7p018G+L01jjBTqbzDfdg/3YyAQ2TxA9Ce9ekdSKYqPav5ZBa+GymNy2yrWVjzkQXQQU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4969.eurprd08.prod.outlook.com (10.255.16.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 09:22:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:22:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 2/2] iotests: test mirroring qcow2 under raw format
Thread-Index: AQHVUTlssKkaNw/PF0iVlsBh06isVab4y4KAgAADVAA=
Date: Tue, 13 Aug 2019 09:22:38 +0000
Message-ID: <62c1749a-1114-6269-9ed7-5999cca4e6ad@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-3-vsementsov@virtuozzo.com>
 <20190813091041.GA4663@localhost.localdomain>
In-Reply-To: <20190813091041.GA4663@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:7:29::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813122236014
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee91f4ad-3aca-4fb8-1056-08d71fcfc8d9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4969; 
x-ms-traffictypediagnostic: DB8PR08MB4969:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4969132C0A8D58858692241DC1D20@DB8PR08MB4969.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(39840400004)(136003)(366004)(189003)(199004)(256004)(66476007)(14444005)(8936002)(66556008)(6116002)(64756008)(6246003)(478600001)(3846002)(66446008)(8676002)(81156014)(81166006)(53936002)(66946007)(4326008)(25786009)(107886003)(54906003)(99286004)(66066001)(36756003)(316002)(31686004)(476003)(186003)(446003)(14454004)(486006)(7736002)(76176011)(102836004)(305945005)(86362001)(386003)(31696002)(52116002)(26005)(6506007)(6916009)(5660300002)(229853002)(2616005)(6512007)(6306002)(2906002)(11346002)(6486002)(6436002)(71200400001)(71190400001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4969;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KEWYhNJ+QMWVzI0z++T/gssNAtMyqUEydNaaxtpb0Ujkdc5ae+++geqj9rNtB4lTy4ixak1z0s2xpdh0rHF06KqtbWBDkDBfZ5ukw7AJ5/w1Dq8pyDZqa2+veWYjkBP+Gfs6/WuyapULTQpk8p5fuJPe8G2K7nMZhW2eUgozKK95xvoY5yXb4YwJmh7KhCbVfLJdxrfrlqO3yII642j5si6PRu/I7VMJ+ilwdzlG8Qxy0e1m9+xv+VbYmqIOwpERaV3bQoxD2k+Fbz/ZQCT7nZIAbTSoa4eIEaue+OkcJtKDOZUVf3eEJvEXcJXO5PR4hX4Gl0YyJCgonv+EmS8ggHgmzP80iija5xmMJ8joKZkQNwk06eqerOS8+tWQ1TXM8mK8ArGkHnkibfAAIaW3OH1+GyxDQsiNITF0CRBCcHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A82E7827241D4844ABD9871EE6C21D31@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee91f4ad-3aca-4fb8-1056-08d71fcfc8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 09:22:38.5995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHM1ovzrctiw+dYxwJif+QJ6Hrf8WBPgTkdNpaqg1Oj9/xRCi/YSsipeWHCtuqQY5kyGY8dEWme64EInmmrBHgTJnv6OC+/Ew7joLlwpK+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4969
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::729
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test mirroring qcow2 under
 raw format
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxMjoxMCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTIuMDguMjAxOSB1bSAy
MDoxMSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IENo
ZWNrIHRoYXQgaXQgaXMgZml4ZWQgYnkgcHJldmlvdXMgY29tbWl0DQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4gLS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMgICAgIHwgNDYgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI2My5vdXQgfCAxMiArKysrKysrKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAg
IHwgIDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMub3V0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8yNjMgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjYzDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDc1NQ0KPj4gaW5kZXggMDAwMDAwMDAwMC4uZGJlMzhlNmM2Yw0KPj4gLS0tIC9k
ZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2Mw0KPj4gQEAgLTAsMCArMSw0
NiBAQA0KPj4gKyMhL3Vzci9iaW4vZW52IHB5dGhvbg0KPj4gKyMNCj4+ICsjIFRlc3QgbWlycm9y
aW5nIHFjb3cyIHVuZGVyIHJhdy1mb3JtYXQNCj4+ICsjDQo+PiArIyBDb3B5cmlnaHQgKGMpIDIw
MTkgVmlydHVvenpvIEludGVybmF0aW9uYWwgR21iSC4NCj4+ICsjDQo+PiArIyBUaGlzIHByb2dy
YW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlm
eQ0KPj4gKyMgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkNCj4+ICsjIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247
IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yDQo+PiArIyAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPj4gKyMNCj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0
cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPj4gKyMgYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YN
Cj4+ICsjIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUNCj4+ICsjIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRl
dGFpbHMuDQo+PiArIw0KPj4gKyMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UNCj4+ICsjIGFsb25nIHdpdGggdGhpcyBwcm9n
cmFtLiAgSWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPj4gKyMN
Cj4+ICsNCj4+ICtpbXBvcnQgaW90ZXN0cw0KPj4gK2Zyb20gaW90ZXN0cyBpbXBvcnQgcWVtdV9p
bWdfY3JlYXRlLCBxZW11X2lvLCBmaWx0ZXJfcWVtdV9pbywgZmlsZV9wYXRoLCBsb2cNCj4+ICsN
Cj4+ICtpb3Rlc3RzLnZlcmlmeV9pbWFnZV9mb3JtYXQoc3VwcG9ydGVkX2ZtdHM9WydxY293Midd
KQ0KPj4gKw0KPj4gK2Jhc2UsIHRvcCwgdGFyZ2V0ID0gZmlsZV9wYXRoKCdiYXNlJywgJ3RvcCcs
ICd0YXJnZXQnKQ0KPj4gK3NpemUgPSAxMDI0ICogMTAyNA0KPj4gKw0KPj4gK3FlbXVfaW1nX2Ny
ZWF0ZSgnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgYmFzZSwgc3RyKHNpemUpKQ0KPj4gK2xvZyhmaWx0
ZXJfcWVtdV9pbyhxZW11X2lvKCctZicsIGlvdGVzdHMuaW1nZm10LA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICctYycsICd3cml0ZSAtUCAxIDAgMU0nLCBiYXNlKSkpDQo+PiArcWVt
dV9pbWdfY3JlYXRlKCctZicsIGlvdGVzdHMuaW1nZm10LCAnLWInLCBiYXNlLCB0b3AsIHN0cihz
aXplKSkNCj4gDQo+IFdobyBkZWxldGVzIHRoZXNlIGZpbGVzIGF0IHRoZSBlbmQgb2YgdGhlIHRl
c3Q/IChUaGVyZSdzIGEgcmVhc29uIHdoeQ0KPiBhbGwgdGhlIG90aGVyIHRlc3QgY2FzZXMgdXNl
cyAnd2l0aCBGaWxlUGF0aCguLi4pJy4pDQo+IA0KDQpmaWxlX3BhdGggc2V0cyBjb3JyZXNwb25k
aW5nIGhhbmRsaW5nLCBpdCdzIGFsdGVybmF0aXZlIHRvIEZpbGVQYXRoDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

