Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D4C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B512464E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U+KOl5qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B512464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icsSA-0003VJ-Cf
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsQm-0002h9-MK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsQk-0003dg-Sj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:48:36 -0500
Received: from mail-eopbgr00133.outbound.protection.outlook.com
 ([40.107.0.133]:1075 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsQk-0003Sk-3h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:48:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC0qQ4rAcyj0AguJgIe9DYwe7mWocH49l2B7mPSaGHBUSqqMrd5+ioxlzs8YPL/B0iDCYfGWkb//G1Q25zQe++E+e+BOiupZAezeY9LIo85arGa2U65VlRdr7Yvg5bB6Ya2uFUZCsckXjcje9fUz3J54lzjX4USasyif4gj8UewhX77Z0HGMerfb4wrzZJxqg8lPppWkBOr34AYgyh9qZ9aCdlC+fqmscWeGxa05bVpV+RD0nAH0Mjr919iMMA7eJZR+q+aurfX1sMwsXC6uuKn1uJnsBjMzB094NLSxIwbmeQEagKaaznIZwh1rEP0x3oXQeAYu2V8dRQmaUi2mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwOn3J8tesFrwX5NMCJmA8uwoOiI+MGgY/txhD0BlfA=;
 b=D3uUNSigQ7OqN3/oV83DQ+SK2gUwiDFVsBmNUBeNUFY774MZ+ybSnjJ0Hl5n3KsCZWGohEF+mStPVXwPaJWO4dSPzF3xNrB6sY9ZxqGtAOPDq3IKwJEqJmEkZSMdwS0QXtuIdPt93Yj21wYEsDx6K7uTYmVg4ePS5O7QjDfHtwAFzcrw1Oyq9tJJ7G1+3JT55KWlNSKErtCy1MDuDnHLWfGQn2JvrB6SeaKxLsyOzP1iMYPINvAZXwgN5DphZ2CdkrSaS681jJtIkUDICXlMJBQoYKiShpdGBO2KKAei3DRt7vxIF7i1ccZxIxvOI37lSktxKEDSioVmRvnuix9Tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwOn3J8tesFrwX5NMCJmA8uwoOiI+MGgY/txhD0BlfA=;
 b=U+KOl5qY6WLYbU3XjOz9PhF/DdfBPP6TnJ6gSTSuWHIpg5X3062+RhpGjBbB4neZpjFa3TJJoIsvva8jBePwlIz6zVAXwZZG6+HCZBqkKpyI+D+jvAYN/VTy5Og+vRNwLgfBH+Axi36anSkK4W1IXDn/tlfqcFyPKlBq1U8r0sc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3894.eurprd08.prod.outlook.com (20.178.91.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 14:48:30 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:48:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] hw/core/qdev: cleanup Error ** variables
Thread-Topic: [PATCH v6] hw/core/qdev: cleanup Error ** variables
Thread-Index: AQHVpVe7pnSor+Sb0UamqfMrQoQReqehq/bJgAn/dgA=
Date: Thu, 5 Dec 2019 14:48:30 +0000
Message-ID: <6d311ad1-528c-5787-64d0-779d6dcbadef@virtuozzo.com>
References: <20191127192025.21594-1-vsementsov@virtuozzo.com>
 <87a78fz045.fsf@dusky.pond.sub.org>
In-Reply-To: <87a78fz045.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0045.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::34)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205174828437
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1971a2-2c0b-4cc4-22a2-08d7799231b2
x-ms-traffictypediagnostic: AM6PR08MB3894:
x-microsoft-antispam-prvs: <AM6PR08MB3894D5C7AF235D92843C34D0C15C0@AM6PR08MB3894.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39850400004)(199004)(189003)(31686004)(478600001)(71200400001)(4326008)(36756003)(71190400001)(6512007)(52116002)(81166006)(11346002)(14454004)(2906002)(99286004)(229853002)(305945005)(26005)(64756008)(6506007)(66476007)(66946007)(76176011)(6486002)(102836004)(54906003)(2616005)(66556008)(66446008)(8936002)(186003)(6916009)(14444005)(316002)(86362001)(81156014)(25786009)(8676002)(31696002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3894;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8bkOSVmr/Y/2S+kpQmJInetMbWJYvSUkZyJ5fM+ofokmMajNvhzI5cl64gLEHh1ycIV840y0ugkxlcxzL+Hm95u8nPFWgqfiZfsaAvL9kFLdiHS3bnpqnax0cNe5LFie59veKjO1tFEsnD5SPtpvXhp34Rl2mNBSW2RfN/KU2clKyhYMNGyWrigB9h0/ccMzkogqlao4NAWY1AM/qY7Ha+0UQWUSyoOkvGf7lPtgT8gTnyqZCqh/UbUTqixxR+VBpqi2aDH99JDASf4d6bzv9m64JbgExjEqLtXWb4G2+/TvX7dZh0tJp21HNZ6M+4By/wntMA1/eL5U/mWo4sLCJnseJQX24dqpox7tEkeyVMsVzQoSaQtSCezqHx9Aat3A/ZTeajCJmPGN+deMDtH7MXXQaW7iTmKbRcz39Pkp6q6aqYxfuKBQ5kD0hUXxZs7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB00A338F925F419A0808CF0EB3806B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1971a2-2c0b-4cc4-22a2-08d7799231b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:48:30.3877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnLQi1Uv0AbzxfIsm+5UyYs76HVJyimhpc20VTmHt1lxbyWqIXvcvieP181A/F7egEiF8seV87PM0lFQ6EMPrURRvcJIL85IQg+A8YpiE9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.133
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSA5OjA3LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+IA0K
Pj4gUmVuYW1lIEVycm9yICoqIHBhcmFtZXRlciBpbiBjaGVja19vbmx5X21pZ3JhdGFibGUgdG8g
Y29tbW9uIGVycnAuDQo+Pg0KPj4gSW4gZGV2aWNlX3NldF9yZWFsaXplZDoNCj4+DQo+PiAgIC0g
TW92ZSAiaWYgKGxvY2FsX2VyciAhPSBOVUxMKSIgY2xvc2VyIHRvIGVycm9yIHNldHRlcnMuDQo+
Pg0KPj4gICAtIERyb3AgJ0Vycm9yICoqbG9jYWxfZXJycCc6IGl0IGRvZXNuJ3Qgc2F2ZSBhbnkg
TG9DcywgYnV0IGl0J3MgdmVyeQ0KPj4gICAgIHVudXN1YWwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4gUmV2
aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29t
Pg0KPj4gLS0tDQo+Pg0KPj4gdjY6IGVuaGFuY2UgZ3JhbW1hciBpbiBjb21tZW50IFtFcmljXQ0K
Pj4gICAgICBhZGQgci1iIGJ5IEVyaWMgYW5kIE1hcmMtQW5kcsOpDQo+Pg0KPj4gICBody9jb3Jl
L3FkZXYuYyB8IDI4ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ody9jb3JlL3FkZXYuYyBiL2h3L2NvcmUvcWRldi5jDQo+PiBpbmRleCBjZjFiYTI4ZmUz
Li44MmQzZWU1OTBhIDEwMDY0NA0KPj4gLS0tIGEvaHcvY29yZS9xZGV2LmMNCj4+ICsrKyBiL2h3
L2NvcmUvcWRldi5jDQo+PiBAQCAtODIwLDEyICs4MjAsMTIgQEAgc3RhdGljIGJvb2wgZGV2aWNl
X2dldF9yZWFsaXplZChPYmplY3QgKm9iaiwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgcmV0dXJu
IGRldi0+cmVhbGl6ZWQ7DQo+PiAgIH0NCj4+ICAgDQo+PiAtc3RhdGljIGJvb2wgY2hlY2tfb25s
eV9taWdyYXRhYmxlKE9iamVjdCAqb2JqLCBFcnJvciAqKmVycikNCj4+ICtzdGF0aWMgYm9vbCBj
aGVja19vbmx5X21pZ3JhdGFibGUoT2JqZWN0ICpvYmosIEVycm9yICoqZXJycCkNCj4+ICAgew0K
Pj4gICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0dFVF9DTEFTUyhvYmopOw0KPj4gICAN
Cj4+ICAgICAgIGlmICghdm1zdGF0ZV9jaGVja19vbmx5X21pZ3JhdGFibGUoZGMtPnZtc2QpKSB7
DQo+PiAtICAgICAgICBlcnJvcl9zZXRnKGVyciwgIkRldmljZSAlcyBpcyBub3QgbWlncmF0YWJs
ZSwgYnV0ICINCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkRldmljZSAlcyBpcyBub3Qg
bWlncmF0YWJsZSwgYnV0ICINCj4+ICAgICAgICAgICAgICAgICAgICAgICItLW9ubHktbWlncmF0
YWJsZSB3YXMgc3BlY2lmaWVkIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgIG9iamVjdF9nZXRf
dHlwZW5hbWUob2JqKSk7DQo+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gQEAgLTg3NCwx
MCArODc0LDkgQEAgc3RhdGljIHZvaWQgZGV2aWNlX3NldF9yZWFsaXplZChPYmplY3QgKm9iaiwg
Ym9vbCB2YWx1ZSwgRXJyb3IgKiplcnJwKQ0KPj4gICANCj4+ICAgICAgICAgICBpZiAoZGMtPnJl
YWxpemUpIHsNCj4+ICAgICAgICAgICAgICAgZGMtPnJlYWxpemUoZGV2LCAmbG9jYWxfZXJyKTsN
Cj4+IC0gICAgICAgIH0NCj4+IC0NCj4+IC0gICAgICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkg
ew0KPj4gLSAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4+ICsgICAgICAgICAgICBpZiAobG9jYWxf
ZXJyICE9IE5VTEwpIHsNCj4+ICsgICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPj4gKyAgICAg
ICAgICAgIH0NCj4+ICAgICAgICAgICB9DQo+IA0KPiBZZXMsIHRoaXMgaXMgdGhlIG1vcmUgY29u
dmVudGlvbmFsIHVzYWdlLg0KPiANCj4+ICAgDQo+PiAgICAgICAgICAgREVWSUNFX0xJU1RFTkVS
X0NBTEwocmVhbGl6ZSwgRm9yd2FyZCwgZGV2KTsNCj4+IEBAIC05MTgsMjcgKzkxNywyNiBAQCBz
dGF0aWMgdm9pZCBkZXZpY2Vfc2V0X3JlYWxpemVkKE9iamVjdCAqb2JqLCBib29sIHZhbHVlLCBF
cnJvciAqKmVycnApDQo+PiAgICAgICAgICB9DQo+PiAgIA0KPj4gICAgICAgfSBlbHNlIGlmICgh
dmFsdWUgJiYgZGV2LT5yZWFsaXplZCkgew0KPj4gLSAgICAgICAgRXJyb3IgKipsb2NhbF9lcnJw
ID0gTlVMTDsNCj4+ICsgICAgICAgIC8qIFdlIHdhbnQgbG9jYWxfZXJyIHRvIHRyYWNrIG9ubHkg
dGhlIGZpcnN0IGVycm9yICovDQo+PiAgICAgICAgICAgUUxJU1RfRk9SRUFDSChidXMsICZkZXYt
PmNoaWxkX2J1cywgc2libGluZykgew0KPj4gLSAgICAgICAgICAgIGxvY2FsX2VycnAgPSBsb2Nh
bF9lcnIgPyBOVUxMIDogJmxvY2FsX2VycjsNCj4+ICAgICAgICAgICAgICAgb2JqZWN0X3Byb3Bl
cnR5X3NldF9ib29sKE9CSkVDVChidXMpLCBmYWxzZSwgInJlYWxpemVkIiwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZXJycCk7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2FsX2VyciA/IE5VTEwgOiAmbG9jYWxfZXJy
KTsNCj4+ICAgICAgICAgICB9DQo+IA0KPiBUaGlzIGlzIGEgcmF0aGVyIHVudXN1YWwgd2F5IHRv
IGtlZXAgdGhlIGZpcnN0IGVycm9yIG9mIHNldmVyYWwuDQo+IHFhcGkvZXJyb3IuaCBhZHZpc2Vz
Og0KPiANCj4gICAqIFJlY2VpdmUgYW5kIGFjY3VtdWxhdGUgbXVsdGlwbGUgZXJyb3JzIChmaXJz
dCBvbmUgd2lucyk6DQo+ICAgKiAgICAgRXJyb3IgKmVyciA9IE5VTEwsICpsb2NhbF9lcnIgPSBO
VUxMOw0KPiAgICogICAgIGZvbyhhcmcsICZlcnIpOw0KPiAgICogICAgIGJhcihhcmcsICZsb2Nh
bF9lcnIpOw0KPiAgICogICAgIGVycm9yX3Byb3BhZ2F0ZSgmZXJyLCBsb2NhbF9lcnIpOw0KPiAg
ICogICAgIGlmIChlcnIpIHsNCj4gICAqICAgICAgICAgaGFuZGxlIHRoZSBlcnJvci4uLg0KPiAg
ICogICAgIH0NCg0KSG1tLCBob25lc3RseSwgSSBsaWtlIG1vcmUgd2hhdCBJJ3ZlIHdyaXR0ZW46
DQoNCjEuIGxlc3MgY29kZQ0KMi4gbG9naWMgaXMgbW9yZSBjbGVhbjogd2Ugc3RvcmUgZmlyc3Qg
ZXJyb3IgdG8gbG9jYWxfZXJyLCBhbmQgYWZ0ZXIgZmlyc3QgZXJyb3INCiAgICBwYXNzIE5VTEwg
YXMgYSBwYXJhbWV0ZXIuIE5vIHByb3BhZ2F0aW9uIG9yIGV4dHJhIGVycm9yIHZhcmlhYmxlcy4N
CjMuIG1vcmUgZWZmaWNpZW50IChubyBwcm9wYWdhdGlvbiwgbm8gZXh0cmEgYWxsb2NhdGlvbiBm
b3IgZXJyb3JzIHdoaWNoIHdlJ2xsIGRyb3ANCiAgICBhbnl3YXkpIChJIHVuZGVyc3RhbmQgdGhh
dCBlZmZpY2llbmN5IG9mIGVycm9yIHBhdGggaXMgbm90IHRoaW5nIHRvIGNhcmUgYWJvdXQsDQog
ICAgc28gaXQncyBhdCB0aGlyZCBwbGFjZSkNCg0KQWxzbywgcHJvcGFnYXRpb24gd2hpY2ggeW91
IHByb3Bvc2UgaXMgYWxzbyB1bnVzdWFsIHRoaW5nIChpdCBwcm9wb3NlZCBpbiBjb21tZW50LA0K
YnV0IHdobyByZWFkcyBpdCA6KS4gSSd2ZSBuZXZlciBzZWVuIGl0IGJlZm9yZSwgYW5kIEkndmUg
dG8gZ28gYW5kIGNoZWNrIHRoYXQNCmVycm9yX3Byb3BhZ2F0ZSB3b3JrcyBjb3JyZWN0bHkgd2hl
biBmaXJzdCBhcmd1bWVudCBpcyBhbHJlYWR5IHNldC4NCg0KU28sIEknZCBwcmVmZXIgdG8ga2Vl
cCBub3cgdGhpcyBwYXRjaCBhcyBpcywgYW5kIHRvIGNvbnZlcnQgbGF0ZXIgaWYgd2UgcmVhbGx5
IG5lZWQgaXQuDQoNCj4gDQo+IElmIHJlcGxhY2luZyB0aGlzIGJ5IHRoZSB1c3VhbCB3YXkgaXMg
dG9vIHRyb3VibGVzb21lIG5vdywgd2UgY2FuIGRvIGl0DQo+IGFmdGVyIHRoZSBFUlJQX0FVVE9f
UFJPUEFHQVRFKCkgY29udmVyc2lvbi4gIFlvdXIgY2hvaWNlLg0KPiANCj4+ICAgICAgICAgICBp
ZiAocWRldl9nZXRfdm1zZChkZXYpKSB7DQo+PiAgICAgICAgICAgICAgIHZtc3RhdGVfdW5yZWdp
c3RlcihkZXYsIHFkZXZfZ2V0X3Ztc2QoZGV2KSwgZGV2KTsNCj4+ICAgICAgICAgICB9DQo+PiAg
ICAgICAgICAgaWYgKGRjLT51bnJlYWxpemUpIHsNCj4+IC0gICAgICAgICAgICBsb2NhbF9lcnJw
ID0gbG9jYWxfZXJyID8gTlVMTCA6ICZsb2NhbF9lcnI7DQo+PiAtICAgICAgICAgICAgZGMtPnVu
cmVhbGl6ZShkZXYsIGxvY2FsX2VycnApOw0KPj4gKyAgICAgICAgICAgIGRjLT51bnJlYWxpemUo
ZGV2LCBsb2NhbF9lcnIgPyBOVUxMIDogJmxvY2FsX2Vycik7DQo+PiAgICAgICAgICAgfQ0KPj4g
ICAgICAgICAgIGRldi0+cGVuZGluZ19kZWxldGVkX2V2ZW50ID0gdHJ1ZTsNCj4+ICAgICAgICAg
ICBERVZJQ0VfTElTVEVORVJfQ0FMTCh1bnJlYWxpemUsIFJldmVyc2UsIGRldik7DQo+PiAtICAg
IH0NCj4+ICAgDQo+PiAtICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkgew0KPj4gLSAgICAgICAg
Z290byBmYWlsOw0KPj4gKyAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+PiArICAg
ICAgICAgICAgZ290byBmYWlsOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4gICANCj4+
ICsgICAgYXNzZXJ0KGxvY2FsX2VyciA9PSBOVUxMKTsNCj4gDQo+IE5vdCBzdXJlIHRoaXMgb25l
J3Mgd29ydGggaXQncyBrZWVwIHdpdGggdGhlIHVzYWdlIG9mIGxvY2FsX2VyciBjbGVhbmVkDQo+
IHVwLg0KPiANCj4+ICAgICAgIGRldi0+cmVhbGl6ZWQgPSB2YWx1ZTsNCj4+ICAgICAgIHJldHVy
bjsNCj4+ICAgDQo+PiBAQCAtOTc2LDcgKzk3NCw3IEBAIHN0YXRpYyBib29sIGRldmljZV9nZXRf
aG90cGx1Z2dhYmxlKE9iamVjdCAqb2JqLCBFcnJvciAqKmVycnApDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcWJ1c19pc19ob3RwbHVnZ2FibGUoZGV2LT5wYXJlbnRfYnVz
KSk7DQo+PiAgIH0NCj4+ICAgDQo+PiAtc3RhdGljIGJvb2wgZGV2aWNlX2dldF9ob3RwbHVnZ2Vk
KE9iamVjdCAqb2JqLCBFcnJvciAqKmVycikNCj4+ICtzdGF0aWMgYm9vbCBkZXZpY2VfZ2V0X2hv
dHBsdWdnZWQoT2JqZWN0ICpvYmosIEVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gICAgICAgRGV2
aWNlU3RhdGUgKmRldiA9IERFVklDRShvYmopOw0KPiANCj4gSW4gY2FzZSB5b3Ugd2FudCB0byBj
bGVhbiB1cCBhZnRlcndhcmRzIHJhdGhlciB0aGFuIG5vdzoNCj4gUmV2aWV3ZWQtYnk6IE1hcmt1
cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gDQoNClRoYW5rcyENCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

