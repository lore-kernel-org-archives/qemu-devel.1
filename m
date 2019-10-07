Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBFC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E823206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pQuG0v/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E823206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWZ8-0004Uh-MO
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHWWw-00032J-Oy
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHWWv-0006Um-AY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:10:42 -0400
Received: from mail-vi1eur04on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::709]:10049
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHWWu-0006Tf-FE; Mon, 07 Oct 2019 13:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwBwtdC0Zi1ZCNh0krIqwGM6OulJDrs2x7K8mQmkzJ84tsiJ+P2vo0Y3U3ZWMe2BUQU5ubvC6pg0/sUrnsOQ3Ywu1JO5BaRnAxez0Fvgr0YWyFAGc7oOF569PO6aHcFsIeXMUL0nAPVbWlyWGeTDeiMA80g4Ovcp1tNE+D2HKXCXTUno+sERwzDHaHV/j0DRdVB1IMgvLS/GgODaS1M9/OYrwZGsVbXsRi6RPspaE1eu5ZXXENGcTPV/3hX6kEMZGoK6c7+gJCtGZBcw9e83nLxn4guZ3irzZtVr5jLIggl0jJt/6cwyZ8Kt43Jkmh0C1lWIrNb1kkmRQV3sxHtTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsKeXw9flGPF4nXVvyfIt80qTCxXWrTWKuv8CJrhOyA=;
 b=kNvtqE6ITQYbWXi9Yg0GGEplfiMFojfXvCbghEyaaPUkx5uPNb2zKoJD1YL4hB2XXXlhSj/WiBd5US7EfxKVzVN+rky2kXI65iqWUoNmbWgUYemxRhR6Q8fmEWvCw25rjAol6AI0N4eaSs/9td1L6vRMwWg4DrLCjCmutoHn2APimwdgTiJk3rwudbXh9PEAMBFccsJQ+ro+6qwpn8jSOU9LiM7RNAPfy34iGwSVB8oQflre/o7M7j+vK0ANpsNThjHjH+0lNqyh1mXwVI14WZdt1lygMvi1lqu07A4+f4pqsq9z3Za+FVfEVAJr6PklR6tb9fjNjUSol4zbhN+nbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsKeXw9flGPF4nXVvyfIt80qTCxXWrTWKuv8CJrhOyA=;
 b=pQuG0v/0o1iLLFtGR5nRQVyFlyaE45H1SZl+e3HISzbA6NyxPcabrniUC1GeAyWKJ40Z2F+OtLZdR7sTNplmOW0dtBiDshCK0XT6JGEZqcbsiI28IehQTFA2BpNndSFiJNOWvqlQ9nEUUp6o+XGXOXbZT2JOD/2aj/pOK4Bf56E=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4044.eurprd08.prod.outlook.com (20.179.10.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 17:10:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 17:10:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 5/6] block/block-copy: add memory limit
Thread-Topic: [PATCH 5/6] block/block-copy: add memory limit
Thread-Index: AQHVeg4yoh/rEPB1r0SkNCk9cwC6DKdPU0UAgAAc4QA=
Date: Mon, 7 Oct 2019 17:10:37 +0000
Message-ID: <49b99621-2d8a-f4a8-d31a-e64a727952a9@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-6-vsementsov@virtuozzo.com>
 <8aa011d7-3f11-2df5-d77e-5c5176ab63ed@redhat.com>
In-Reply-To: <8aa011d7-3f11-2df5-d77e-5c5176ab63ed@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0044.eurprd09.prod.outlook.com
 (2603:10a6:7:15::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007201034748
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b987287f-4b60-49d7-e799-08d74b4945c4
x-ms-traffictypediagnostic: DB8PR08MB4044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4044226FAFE1686251AF111EC19B0@DB8PR08MB4044.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:55;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(396003)(39840400004)(136003)(199004)(189003)(71200400001)(229853002)(2501003)(14444005)(256004)(110136005)(305945005)(107886003)(316002)(3846002)(31686004)(2906002)(6246003)(4326008)(6116002)(7736002)(6436002)(54906003)(6486002)(71190400001)(6512007)(25786009)(66446008)(11346002)(76176011)(81166006)(81156014)(8676002)(99286004)(5660300002)(8936002)(52116002)(102836004)(386003)(6506007)(53546011)(478600001)(66556008)(31696002)(86362001)(14454004)(36756003)(446003)(64756008)(26005)(66946007)(486006)(186003)(66066001)(66476007)(476003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4044;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vweP/sSp1MAtMI1DYipae3/3PDhYJ3w1vk57JfBUn2tOGNEeElGiaF7LLGlJZi0wy8PUUv/cu1baMPKFb9tKlQM/kYyBuoFpmDBqz9K12R1esAs9/rTfMOYpet76Z9P0n1gApfVdlk/EFNHpb3YTvtzw/bMfGWfrmY/CVCYaoO7HMNtejCf3t/5lFveg9fCSObtKilTO2qtEaWIRmi9WVUQe9X2GGJLu/8C6n61hE2J1wQX0OhYOy9vr4CtDFosQ/423FKLjDeJTTgdSTL7bulUZHmK8zSLPRgAZcm2rH3qqFKPp30Tx+p27m9LGVIXliX0lsD8uC6rnRb4oh1tt/nznG3YuZ93FCmVAULApWz+v3ySqyaQYF1TOdwO+CeVpj2DllHJfZrwI58lSyVLKdxbrVYYSSguhnFlWuMPqMo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F89A084EEE2141B9444135C09E72B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b987287f-4b60-49d7-e799-08d74b4945c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 17:10:37.3253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fWVTvrjURQF9X2UG87mTmm6tS0cibZ41DOoWFeoqwOkQ9/3mM/Rk4AUsMFLrLdFlDKDxoMLmZEanFMzwjsm93veXy3ohoNSJLvMXP/2FGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4044
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::709
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMy4xMC4xOSAxOToxNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEN1cnJlbnRseSB0b3RhbCBh
bGxvY2F0aW9uIGZvciBwYXJhbGxlbCByZXF1ZXN0cyB0byBibG9jay1jb3B5IGluc3RhbmNlDQo+
PiBpcyB1bmxpbWl0ZWQuIExldCdzIGxpbWl0IGl0IHRvIDEyOCBNaUIuDQo+Pg0KPj4gRm9yIG5v
dyBibG9jay1jb3B5IGlzIHVzZWQgb25seSBpbiBiYWNrdXAsIHNvIGFjdHVhbGx5IHdlIGxpbWl0
IHRvdGFsDQo+PiBhbGxvY2F0aW9uIGZvciBiYWNrdXAgam9iLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLWNvcHkuaCB8IDMgKysrDQo+PiAg
IGJsb2NrL2Jsb2NrLWNvcHkuYyAgICAgICAgIHwgNSArKysrKw0KPj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Js
b2NrLWNvcHkuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2stY29weS5oDQo+PiBpbmRleCBlMmUxMzVm
ZjFiLi5iYjY2NmU3MDY4IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5
LmgNCj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2stY29weS5oDQo+PiBAQCAtMTYsNiArMTYs
NyBAQA0KPj4gICAjZGVmaW5lIEJMT0NLX0NPUFlfSA0KPj4gICANCj4+ICAgI2luY2x1ZGUgImJs
b2NrL2Jsb2NrLmgiDQo+PiArI2luY2x1ZGUgInFlbXUvY28tc2hhcmVkLWFtb3VudC5oIg0KPj4g
ICANCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgQmxvY2tDb3B5SW5GbGlnaHRSZXEgew0KPj4gICAgICAg
aW50NjRfdCBzdGFydF9ieXRlOw0KPj4gQEAgLTY5LDYgKzcwLDggQEAgdHlwZWRlZiBzdHJ1Y3Qg
QmxvY2tDb3B5U3RhdGUgew0KPj4gICAgICAgICovDQo+PiAgICAgICBQcm9ncmVzc1Jlc2V0Q2Fs
bGJhY2tGdW5jIHByb2dyZXNzX3Jlc2V0X2NhbGxiYWNrOw0KPj4gICAgICAgdm9pZCAqcHJvZ3Jl
c3Nfb3BhcXVlOw0KPj4gKw0KPj4gKyAgICBRZW11Q29TaGFyZWRBbW91bnQgKm1lbTsNCj4+ICAg
fSBCbG9ja0NvcHlTdGF0ZTsNCj4+ICAgDQo+PiAgIEJsb2NrQ29weVN0YXRlICpibG9ja19jb3B5
X3N0YXRlX25ldyhCZHJ2Q2hpbGQgKnNvdXJjZSwgQmRydkNoaWxkICp0YXJnZXQsDQo+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svYmxvY2stY29weS5jIGIvYmxvY2svYmxvY2stY29weS5jDQo+PiBpbmRl
eCBjYzQ5ZDIzNDVkLi5lNzAwYzIwZDBmIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svYmxvY2stY29w
eS5jDQo+PiArKysgYi9ibG9jay9ibG9jay1jb3B5LmMNCj4+IEBAIC0yMSw2ICsyMSw3IEBADQo+
PiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+PiAgIA0KPj4gICAjZGVmaW5lIEJMT0NLX0NP
UFlfTUFYX0NPUFlfUkFOR0UgKDE2ICogTWlCKQ0KPj4gKyNkZWZpbmUgQkxPQ0tfQ09QWV9NQVhf
TUVNICgxMjggKiBNaUIpDQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gYmxv
Y2tfY29weV93YWl0X2luZmxpZ2h0X3JlcXMoQmxvY2tDb3B5U3RhdGUgKnMsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90
IHN0YXJ0LA0KPj4gQEAgLTY0LDYgKzY1LDcgQEAgdm9pZCBibG9ja19jb3B5X3N0YXRlX2ZyZWUo
QmxvY2tDb3B5U3RhdGUgKnMpDQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICAgICAgYmRydl9yZWxl
YXNlX2RpcnR5X2JpdG1hcChzLT5zb3VyY2UtPmJzLCBzLT5jb3B5X2JpdG1hcCk7DQo+PiArICAg
IHFlbXVfY29fc2hhcmVkX2Ftb3VudF9mcmVlKHMtPm1lbSk7DQo+PiAgICAgICBnX2ZyZWUocyk7
DQo+PiAgIH0NCj4+ICAgDQo+PiBAQCAtOTUsNiArOTcsNyBAQCBCbG9ja0NvcHlTdGF0ZSAqYmxv
Y2tfY29weV9zdGF0ZV9uZXcoQmRydkNoaWxkICpzb3VyY2UsIEJkcnZDaGlsZCAqdGFyZ2V0LA0K
Pj4gICAgICAgICAgIC5jbHVzdGVyX3NpemUgPSBjbHVzdGVyX3NpemUsDQo+PiAgICAgICAgICAg
LmxlbiA9IGJkcnZfZGlydHlfYml0bWFwX3NpemUoY29weV9iaXRtYXApLA0KPj4gICAgICAgICAg
IC53cml0ZV9mbGFncyA9IHdyaXRlX2ZsYWdzLA0KPj4gKyAgICAgICAgLm1lbSA9IHFlbXVfY29f
c2hhcmVkX2Ftb3VudF9uZXcoQkxPQ0tfQ09QWV9NQVhfTUVNKSwNCj4+ICAgICAgIH07DQo+PiAg
IA0KPj4gICAgICAgcy0+Y29weV9yYW5nZV9zaXplID0gUUVNVV9BTElHTl9ET1dOKG1heF90cmFu
c2ZlciwgY2x1c3Rlcl9zaXplKSwNCj4+IEBAIC0zMTYsNyArMzE5LDkgQEAgaW50IGNvcm91dGlu
ZV9mbiBibG9ja19jb3B5KEJsb2NrQ29weVN0YXRlICpzLA0KPj4gICANCj4+ICAgICAgICAgICBi
ZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChzLT5jb3B5X2JpdG1hcCwgc3RhcnQsIGNodW5rX2VuZCAt
IHN0YXJ0KTsNCj4+ICAgDQo+PiArICAgICAgICBxZW11X2NvX2dldF9hbW91bnQocy0+bWVtLCBj
aHVua19lbmQgLSBzdGFydCk7DQo+IA0KPiBOb3cgdGhhdCBJIHNlZSBpdCBsaWtlIHRoaXMsIG1h
eWJlIHRoZSBuYW1lIGlzIHRvbyBzaG9ydC4gIFRoaXMgc291bmRzDQo+IGxpa2UgaXQgd2FzIHRy
eWluZyB0byBnZXQgc29tZSBhbW91bnQgb2YgY29yb3V0aW5lcy4NCj4gDQo+IFdvdWxkIOKAnHFl
bXVfY29fZ2V0X2Zyb21fc2hhcmVkX2Ftb3VudOKAnSBiZSB0b28gbG9uZz8gIChTb21ldGhpbmcg
bGlrZQ0KPiBxZW11X2NvX3NoYW1fYWxsb2MoKSB3b3VsZCBiZSBmdW5ueSwgYnV0IG1heWJlIG5v
dC4gIDotKSAgT3IgbWF5YmUNCj4gZXhhY3RseSBiZWNhdXNlIGl04oCdcyBmdW5ueS4pDQo+IA0K
DQpobW0gc2hhbSBtYXkgYmUgaW50ZXJwcmV0ZWQgYXMgc2hhcmVkIG1lbW9yeSwgbm90IG9ubHkg
bGlrZSBzaGFtZS4uDQoNCkFuZCBpZiB3ZSBjYWxsIGl0IF9hbGxvYywgdGhlIG9wcG9zaXRlIHNo
b3VsZCBiZSBfZnJlZSwgYnV0IGhvdyB0bw0KZGlzdGluZ3Vpc2ggaXQgZnJvbSBmcmVlaW5nIHRo
ZSB3aG9sZSBvYmplY3Q/IEhtbSwgdXNlIGNyZWF0ZS9kZXN0cm95IGZvcg0KdGhlIHdob2xlIG9i
amVjdCBtYXliZS4NCg0KTWF5IGJlLCBkcm9wICJxZW11XyIgPyBJdCdzIG5vdCB2ZXJ5IGluZm9y
bWF0aXZlLiBPciBtYXkgYmUgZHJvcCAiY29fIj8uDQoNCkkgZG9uJ3QgbGlrZSBzaGFtaW5nIG15
IHNoYXJlZCBhbW91bnQgOikNCg0KTWF5IGJlLCB3ZSBzaG91bGQgaW1hZ2luZSwgd2hhdCBhcmUg
d2UgYWxsb2NhdGluZz8gTWF5IGJlIGJhbGxzPw0KDQpzdHJ1Y3QgQmFsbEFsbG9jYXRvcg0KDQpi
YWxsX2FsbG9jYXRvcl9jcmVhdGUNCmJhbGxfYWxsb2NhdG9yX2Rlc3Ryb3kNCg0KY29fdHJ5X2Fs
bG9jX2JhbGxzDQpjb19hbGxvY19iYWxscw0KY29fZnJlZV9iYWxscw0KDQpPciBiYXJzPyBPciB3
aGljaCB0aGluZyBtYXkgYmUgdXNlZCBmb3IgZnVubnkgbmFtaW5nIGFuZCB0byBub3QgaW50ZXJz
ZWN0DQp3aXRoIGV4aXN0aW5nIGNvbmNlcHRzIGxpa2UgbWVtb3J5Pw0KDQo+IA0KPj4gICAgICAg
ICAgIHJldCA9IGJsb2NrX2NvcHlfZG9fY29weShzLCBzdGFydCwgY2h1bmtfZW5kLCBlcnJvcl9p
c19yZWFkKTsNCj4+ICsgICAgICAgIHFlbXVfY29fcHV0X2Ftb3VudChzLT5tZW0sIGNodW5rX2Vu
ZCAtIHN0YXJ0KTsNCj4+ICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gICAgICAgICAgICAg
ICBiZHJ2X3NldF9kaXJ0eV9iaXRtYXAocy0+Y29weV9iaXRtYXAsIHN0YXJ0LCBjaHVua19lbmQg
LSBzdGFydCk7DQo+PiAgICAgICAgICAgICAgIGJyZWFrOw0KPj4NCj4gDQo+IA0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

