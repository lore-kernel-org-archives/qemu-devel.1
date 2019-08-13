Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0571C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F020206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KUJCfBjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F020206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTox-0001CP-T4
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxTnd-0000PU-Ic
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxTnc-0005IL-Bo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:13:05 -0400
Received: from mail-am5eur02on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::714]:37636
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hxTnZ-0005EO-7l; Tue, 13 Aug 2019 06:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZybPTrQogBuk+Z63dthmHHKaWci052T1fBLsMt+pbHrMquM8hOtHphWigAG+aJu7oRA2Px8IY2s0p6355CaL0MCeKeoO+InY08lXJvMAXKVz8uYDDY/gNA+VuXzZcQt3XluxjEixM1oIhidWceHjgEqYo3GwOtIbssuy1keQoGOoG1dtNZFk8fQk6uovab6lzQ9yhJUGoXN4ohdA9pmyxEQ5dnlIHiKLLyqB1wq9uiKmf6OBw8TAe3yXdqRk11hYeHHh3Mwqwx+omwa6eJGUNlzChsSp3PebemEDWz0Hyx7MD6b/w7TegpWdJzzMf1xgiOLi4SgGlnYp/uoehxy2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h9oYFDWzC/TcD2i29Gg9UkCaBHbOUaBDBw6rplcW4A=;
 b=Izu7+BjNSTzmymNZKIsJm37eHgUKrZiAMctHCzDuaAgNZUgIUpdZk5Sc8buiHQLIRaEOVHKs0/xSmaVLR7cMgEG8X1qVExic2QgSAdYfv2y5swIriQP1+yrt4iQxGWburTUYDEm159dTy0NoMNoint20zxQcwpRKs6AZ3B8URi6saQPFrU1qkdGTt62046lzON794b34zY0gECEIZbn+rAivXh8x67MpvV0cbiXPDiPIUya6wKdf/b+GurajdQcs+tOQ2WHoszinkfLJyTLPO2KlkCSvk+F2Jt982U+TFCoMAsPSJYcV2MlLz+uWev16LIWLZvYBJjyYJOjkVRXXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h9oYFDWzC/TcD2i29Gg9UkCaBHbOUaBDBw6rplcW4A=;
 b=KUJCfBjqife2yo081+Oi7Tv9Sxuy6ZGHM5rfmlrmA8+YgK7v/mwnC3M8CpQ4HtlqSQQKV0W23HS1wcRX2PfB6KvR0gPoGUwX+6NGbMtXN8MsmLoEXD7dm2sXRI9CUIZqWHRIpastWPT5AyPqotTfbXURaSPGMsS+EY14DUDGHZE=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3743.eurprd08.prod.outlook.com (20.178.15.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Tue, 13 Aug 2019 10:12:57 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 10:12:56 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] tests: Set read-zeroes on for null-co driver
Thread-Index: AQHVRgulae/lr4xz6EGdKpGPDO9mvKbjHyuAgAAB24CAADkLgIAVgQEAgAAYLgA=
Date: Tue, 13 Aug 2019 10:12:56 +0000
Message-ID: <2a94e0ad-b66f-5f4e-94a7-639ff601cb92@virtuozzo.com>
References: <1564404360-733987-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <13985217-0967-e7b6-db62-43c865d49141@redhat.com>
 <aff46d02-5876-091a-c0f6-8214231f2bc9@redhat.com>
 <b3d6196e-36e1-6d13-015c-c631ab09cc04@virtuozzo.com>
 <a2be1222-07f4-919b-7191-e6ec78c41bad@redhat.com>
In-Reply-To: <a2be1222-07f4-919b-7191-e6ec78c41bad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0048.eurprd09.prod.outlook.com
 (2603:10a6:3:45::16) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4880c37e-8b89-4601-a9ce-08d71fd6cfcd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3743; 
x-ms-traffictypediagnostic: VI1PR08MB3743:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB3743EB92DD8A359B3760D46FF4D20@VI1PR08MB3743.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(366004)(39840400004)(136003)(189003)(199004)(386003)(6506007)(31686004)(102836004)(6246003)(71200400001)(71190400001)(4326008)(53936002)(7416002)(5660300002)(2906002)(256004)(966005)(3846002)(7736002)(81156014)(81166006)(8676002)(305945005)(6116002)(6306002)(6512007)(53546011)(52116002)(26005)(76176011)(110136005)(229853002)(25786009)(186003)(54906003)(478600001)(6436002)(66066001)(6486002)(86362001)(31696002)(2501003)(476003)(2616005)(66556008)(66476007)(66946007)(2201001)(486006)(44832011)(11346002)(316002)(14454004)(8936002)(36756003)(446003)(99286004)(66446008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3743;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VumL2xW+dUYJ6jY1hM6AgUdPALry1VCtVFz3D0lRZKjYUw6vOmx4jyr1QXouKzN1T7nZa3VcGFPLgfvpClDCFJu5yMqeb1QdZtwwOr0gWJA/+os1i4sJnpDDHauiMxwEwzfqMa+xaK7Hqv/GZhaZ/RnGNGFRklVQSD+icQZ+WQsMAUAkj1SjIVVKC54nOBnjQWaD3NtSd9xMU17OzFktSUD7/zOBqc61P63GhUtHpNvWu0N9RxfAIqIET9YokqwulDCmobupkeETOOrZDfDtoivE+zUOa6Kiax/cuVHGbsELsy5UwJJMtfVbaZeDhKW6n9u5dZ2QHPdDeWTG870O3dFwA/14ODRkp5RcUvzI5J4vcyD+5XtoSMpeUcRaeTtl+i51aTmUNpusBOFGmyZ3mmZfebNSfTS3rDtkV7+Kl/k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D71CED10675649AB3362070E4EE81C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4880c37e-8b89-4601-a9ce-08d71fd6cfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 10:12:56.7927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+q7dvPDHo5yUG8bAXrd4HFwh54BqtMQCW97dWrE9+1/uomGuY6DTTEu06kFhPjr29df03gnDLDX41CEdjHJDQ2/5m6yH68pYkybllflrHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3743
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::714
Subject: Re: [Qemu-devel] [PATCH] tests: Set read-zeroes on for null-co
 driver
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
 "lvivier@redhat.com" <lvivier@redhat.com>, "hare@suse.com" <hare@suse.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net" <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEzLzA4LzIwMTkgMTE6NDYsIFRob21hcyBIdXRoIHdyb3RlOg0KPiBPbiA3LzMwLzE5
IDM6MjMgUE0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAzMC8wNy8y
MDE5IDE1OjU5LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+PiBPbiAzMC8wNy8yMDE5IDE0LjUyLCBU
aG9tYXMgSHV0aCB3cm90ZToNCj4+Pj4gT24gMjkvMDcvMjAxOSAxNC40NiwgQW5kcmV5IFNoaW5r
ZXZpY2ggd3JvdGU6DQo+Pj4+PiBUaGlzIHBhdGNoIGlzIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9m
IFZhbGdyaW5kIHJlcG9ydCBtZXNzYWdlcyBhYm91dA0KPj4+Pj4gdXNpbmcgdW5pbml0aWFsaXpl
ZCBtZW1vcnkgd2l0aCB0aGUgbnVsbC1jbyBkcml2ZXIuIEl0IGhlbHBzIHRvIGZpbHRlcg0KPj4+
Pj4gcmVhbCBtZW1vcnkgaXNzdWVzIGFuZCBpcyB0aGUgc2FtZSB3b3JrIGRvbmUgZm9yIHRoZSBp
b3Rlc3RzIHdpdGggdGhlDQo+Pj4+PiBjb21taXQgSUQgYTY4NjI0MThmZWM0MDcyLg0KPj4+Pj4N
Cj4+Pj4+IFN1Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KPj4+Pj4gLS0tDQo+Pj4+IFsuLi5dDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvdGVz
dHMvdGVzdC1ibG9ja2pvYi10eG4uYyBiL3Rlc3RzL3Rlc3QtYmxvY2tqb2ItdHhuLmMNCj4+Pj4+
IGluZGV4IDg2NjA2ZjkuLjdkYTkyMTYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS90ZXN0cy90ZXN0LWJs
b2Nram9iLXR4bi5jDQo+Pj4+PiArKysgYi90ZXN0cy90ZXN0LWJsb2Nram9iLXR4bi5jDQo+Pj4+
PiBAQCAtMTUsNiArMTUsNyBAQA0KPj4+Pj4gICAgI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgi
DQo+Pj4+PiAgICAjaW5jbHVkZSAiYmxvY2svYmxvY2tqb2JfaW50LmgiDQo+Pj4+PiAgICAjaW5j
bHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCINCj4+Pj4+ICsjaW5jbHVkZSAicWFwaS9xbXAv
cWRpY3QuaCINCj4+Pj4+ICAgIA0KPj4+Pj4gICAgdHlwZWRlZiBzdHJ1Y3Qgew0KPj4+Pj4gICAg
ICAgIEJsb2NrSm9iIGNvbW1vbjsNCj4+Pj4+IEBAIC05Niw3ICs5Nyw5IEBAIHN0YXRpYyBCbG9j
a0pvYiAqdGVzdF9ibG9ja19qb2Jfc3RhcnQodW5zaWduZWQgaW50IGl0ZXJhdGlvbnMsDQo+Pj4+
PiAgICANCj4+Pj4+ICAgICAgICBkYXRhID0gZ19uZXcwKFRlc3RCbG9ja0pvYkNCRGF0YSwgMSk7
DQo+Pj4+PiAgICANCj4+Pj4+IC0gICAgYnMgPSBiZHJ2X29wZW4oIm51bGwtY286Ly8iLCBOVUxM
LCBOVUxMLCAwLCAmZXJyb3JfYWJvcnQpOw0KPj4+Pj4gKyAgICBRRGljdCAqb3B0ID0gcWRpY3Rf
bmV3KCk7DQo+Pj4+PiArICAgIHFkaWN0X3B1dF9zdHIob3B0LCAiZmlsZS5yZWFkLXplcm9lcyIs
ICJvbiIpOw0KPj4+Pj4gKyAgICBicyA9IGJkcnZfb3BlbigibnVsbC1jbzovLyIsIE5VTEwsIG9w
dCwgMCwgJmVycm9yX2Fib3J0KTsNCj4+Pj4+ICAgICAgICBnX2Fzc2VydF9ub25udWxsKGJzKTsN
Cj4+Pj4NCj4+Pj4gTm90IHN1cmUsIGJ1dCBkb24ndCB5b3UgbmVlZCB0byBhbHNvIHFkaWN0X2Rl
c3Ryb3lfb2JqKG9wdCkgYXQgdGhlIGVuZA0KPj4+PiB0byBhdm9pZCBsZWFraW5nIG1lbW9yeT8g
KEFsc28gaW4gdGhlIG90aGVyIHNwb3RzIHdoZXJlIHlvdSB1c2UNCj4+Pj4gcWRpY3RfbmV3KCkg
Li4uKQ0KPj4+DQo+Pj4gTmV2ZXIgbWluZCwgc2VlbXMgbGlrZSBiZHJ2X29wZW4oKSBpcyBkb2lu
ZyBhbiBxb2JqZWN0X3VucmVmKCkgb24gdGhlDQo+Pj4gb3B0aW9ucyBhdCB0aGUgZW5kLCBzbyBJ
IGd1ZXNzIHRoaXMgc2hvdWxkIGJlIGZpbmUuLi4NCj4+Pg0KPj4+IFNvIGluIHRoYXQgY2FzZToN
Cj4+Pg0KPj4+IEFja2VkLWJ5OiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCj4+Pg0K
Pj4+IChJIGFzc3VtZSB0aGlzIHdpbGwgYmUgdGFrZW4gdGhyb3VnaCB0aGUgYmxvY2sgdHJlZT8g
TGV0IG1lIGtub3cgaWYgeW91DQo+Pj4gcHJlZmVyIHRoZSBxdGVzdCB0cmVlIGluc3RlYWQpDQo+
Pg0KPj4gVGhhbmtzLCBUaG9tYXMhDQo+PiBJIGhhdmUgcnVuIHRoZSBwYXRjaGVkIHByb2dyYW0g
dW5kZXIgdGhlIFZhbGdyaW5kIHRvIGRvdWJsZSBjaGVjayBmb3INCj4+IG1lbW9yeSBpc3N1ZXMg
LSBubyBsZWFrIHJlcG9ydGVkLg0KPj4gQXMgZm9yIHRoZSBicmFuY2gsIEkgd291bGQgYmUgaGFw
cHkgd2l0aCBlaXRoZXIuDQo+IA0KPiBPaywgRllJLCBJJ3ZlIHF1ZXVlZCB0aGlzIHBhdGNoIG5v
dyBpbiB0aGUgcXRlc3QgYnJhbmNoOg0KPiANCj4gICBodHRwczovL2dpdGxhYi5jb20vaHV0aC9x
ZW11L2NvbW1pdHMvcXRlc3QtbmV4dA0KPiANCj4gICBUaG9tYXMNCj4gDQoNClRoYW5rIHlvdSBU
aG9tYXMsDQpJIGFwcHJlY2lhdGUuDQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2Fy
ZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

