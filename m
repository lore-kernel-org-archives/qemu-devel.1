Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF15CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3239F20665
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gxCoLn0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3239F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFUl-0007Nv-Ko
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBFTG-0006WK-6l
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBFTE-000794-7A
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:44:57 -0400
Received: from mail-eopbgr50122.outbound.protection.outlook.com
 ([40.107.5.122]:36132 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBFTD-00078e-Jg; Fri, 20 Sep 2019 05:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX9N/zfVewp88f8d+kvR8i7mpmVCI3nzFsviYIlXxRM6+TlAoqHh1NNZOdkSVBRwk1d7obdvvZjaVZusF0XtPRqSm6SJTPyg1zESjfJ+1ASyVrMrY/zdxyLN1nZE5yMpfaqQhH3o/nIaVmfSHO4AuWJf3/+HnItWFTeDe1dWYFZKnRuDOk0rgb6o/TPg3rOkQMsrMTcXIHkww+YTFtrhqSRUslFQfFR2HVTETNBhF4p7ePSDz9x6QH+CtMbB9lnitRC6Kd2PU6KgBd+WoNbzEbB21+7Ev4GzXxAzyWlu8q6FqGLNwenbfmGXNBhDcR+AzUKhIb5udfRBMuZFO2CzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHu8a/P+pNs+84ZbibzcqdvN4i7NMeDOIJQvAZDOfl4=;
 b=EFGHPTdwaUgQAy2c56d75PBKZ+YuVgwasTdYvAPuLVza6l73aoe79fr6zPHcsTy791ULVk77Ti+UNgrsNF+BgyKksgpL3LQ/Yb0SAxezhN19JDxmYjdZnL8QOVTRRXLVRkiMf3fwQdQsuEa74YPBmx4onf2Pe7uyZwPNzb/6C7oM0ueqsTAP7F5pZehQ6FwP5NIKk7vT2PqCpAI3BrhYODR7Gvr6bSdU9gf8MYK1bUKVmlw2Ir46nVR3qClOOa1O2QtORMYCa36RZP2vDMEYYajgA3af0nQUaZonPJh6F/p3JS7gWnh6V9VmsZh/2rtqzamSPd2YuCoQTFzF9zQALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHu8a/P+pNs+84ZbibzcqdvN4i7NMeDOIJQvAZDOfl4=;
 b=gxCoLn0WeuqMO6hxevRFBgrTOl1nxwltCyPoK3+OW/PEtzVxH5cDvYwoFJBYEwWtylh9UziqUkYhioEjx1RtwT+r8QwvOFYm2FxjAKAyX2u+uHRER3XqiaEUAEG9q2oUpkUyst4qLFh4F2JUduuz6mhnNGlciNElBTCbHmAxUl8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4203.eurprd08.prod.outlook.com (20.179.11.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Fri, 20 Sep 2019 09:44:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 09:44:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 1/2] iotests: Require Python 3.6 or later
Thread-Topic: [PATCH v2 1/2] iotests: Require Python 3.6 or later
Thread-Index: AQHVbwgAcItFOgHuMUm6UeC6gwu0i6c0QBwAgAANEoCAAATYgA==
Date: Fri, 20 Sep 2019 09:44:52 +0000
Message-ID: <bca4d1c9-05a8-14e1-e55c-fc25de0cadfd@virtuozzo.com>
References: <20190919162905.21830-1-kwolf@redhat.com>
 <20190919162905.21830-2-kwolf@redhat.com>
 <5f0e3c27-1c33-0f9b-485b-c3e4a6700138@virtuozzo.com>
 <20190920092729.GC5458@localhost.localdomain>
In-Reply-To: <20190920092729.GC5458@localhost.localdomain>
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
x-tagtoolbar-keys: D20190920124449626
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85bc6602-cb97-4e0a-a41d-08d73daf2f5b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4203; 
x-ms-traffictypediagnostic: DB8PR08MB4203:
x-microsoft-antispam-prvs: <DB8PR08MB4203B897C02BB27F35BECBB8C1880@DB8PR08MB4203.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(346002)(396003)(376002)(199004)(189003)(186003)(5660300002)(446003)(36756003)(71190400001)(478600001)(4326008)(476003)(25786009)(2616005)(7736002)(6916009)(305945005)(11346002)(71200400001)(3846002)(6116002)(14444005)(52116002)(256004)(64756008)(86362001)(66946007)(6486002)(6246003)(76176011)(14454004)(6512007)(6506007)(386003)(229853002)(31696002)(31686004)(102836004)(26005)(66476007)(316002)(6436002)(99286004)(66066001)(8936002)(8676002)(486006)(54906003)(2906002)(81156014)(66446008)(81166006)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4203;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bVndJGH1CWr/1Ii0WpIsvH6mEPNaJ4DVCBbhyuckguDZRXwuLh4AplCihx71oIPOvi7Q1uKCm5oiMcueLD4gTE7soCWYeuihkw7lJLBSyCrh+JhmvlFJBIpbCeyDLbxxkxiPjlrchR9Gt3Fy/CUTIkPStLdrxTZ3XEex67ZbPMwtSDgzHde9CAe9a3ZVsG8ZRPsca6D5/xRUAE+ZEXR7zm2Vj4jh45vBqa06RQk8o/mggyH1NGcjzCM7rpiIMqRzJ4TFLYpvLR/jEW2IeQPB/7QZDO7EwZqFwHoSEXcCi7DRd+L1dQTklu+tem74EGUaeSRLwnuLBH1tZadY9qQ3FjM+NU71sLfMLpCFcV2rNExyHAbEch+OE1UwKgKvJXMpsCQjT4y4uysyUlRcm4zvRPIB3LQVaiTGiX4pJaqZjw0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5D723D94E34F940B948B78A4AA44086@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc6602-cb97-4e0a-a41d-08d73daf2f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 09:44:52.1112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sf4ETuOhyS8i6uEUvwDzDQe0O2qyI9pXRcZQwCcRMeA8/5/sq7Xs7YBKLLqCclJGoVLZFfsMH7v7MQYPjcI8RSXKMsuAlkU5QIiZ7+ZpL2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4203
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.122
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxMjoyNywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjAuMDkuMjAxOSB1bSAx
MDo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDE5
LjA5LjIwMTkgMTk6MjksIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gUnVubmluZyBpb3Rlc3RzIGlz
IG5vdCByZXF1aXJlZCB0byBidWlsZCBRRU1VLCBzbyB3ZSBjYW4gaGF2ZSBzdHJpY3Rlcg0KPj4+
IHZlcnNpb24gcmVxdWlyZW1lbnRzIGZvciBQeXRob24gaGVyZSBhbmQgY2FuIG1ha2UgdXNlIG9m
IG5ldyBmZWF0dXJlcw0KPj4+IGFuZCBkcm9wIGNvbXBhdGliaWxpdHkgY29kZSBlYXJsaWVyLg0K
Pj4+DQo+Pj4gVGhpcyBtYWtlcyBxZW11LWlvdGVzdHMgc2tpcCBhbGwgUHl0aG9uIHRlc3RzIGlm
IGEgUHl0aG9uIHZlcnNpb24gYmVmb3JlDQo+Pj4gMy42IGlzIHVzZWQgZm9yIHRoZSBidWlsZC4N
Cj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQu
Y29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+
Pj4gLS0tDQo+Pj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2NoZWNrIHwgMTMgKysrKysrKysrKysr
LQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2NoZWNrIGIvdGVzdHMv
cWVtdS1pb3Rlc3RzL2NoZWNrDQo+Pj4gaW5kZXggODc1Mzk5ZDc5Zi4uNTg4YzQ1M2E5NCAxMDA3
NTUNCj4+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvY2hlY2sNCj4+PiArKysgYi90ZXN0cy9x
ZW11LWlvdGVzdHMvY2hlY2sNCj4+PiBAQCAtNjMzLDYgKzYzMywxMiBAQCB0aGVuDQo+Pj4gICAg
ICAgIGV4cG9ydCBTT0NLRVRfU0NNX0hFTFBFUj0iJGJ1aWxkX2lvdGVzdHMvc29ja2V0X3NjbV9o
ZWxwZXIiDQo+Pj4gICAgZmkNCj4+PiAgICANCj4+PiArcHl0aG9uX3VzYWJsZT1mYWxzZQ0KPj4+
ICtpZiAkUFlUSE9OIC1jICdpbXBvcnQgc3lzOyBzeXMuZXhpdCgwIGlmIHN5cy52ZXJzaW9uX2lu
Zm8gPj0gKDMsNikgZWxzZSAxKScNCj4+PiArdGhlbg0KPj4+ICsgICAgcHl0aG9uX3VzYWJsZT10
cnVlDQo+Pj4gK2ZpDQoNCmRvbid0IHdlIHdhbnQNCmVsc2UNCiAgICBQWVRIT049ImZhbHNlIg0K
ZmkNCg0KdG8gcHJldmVudCBzb21lIG9jY2FzaW9uYWwgdW5jaGVja2VkIGNhbGwgYmVsb3c/DQoN
Cg0KPj4+ICsNCj4+PiAgICBkZWZhdWx0X21hY2hpbmU9JCgkUUVNVV9QUk9HIC1tYWNoaW5lIGhl
bHAgfCBzZWQgLW4gJy8oZGVmYXVsdCkvIHMvIC4qLy9wJykNCj4+PiAgICBkZWZhdWx0X2FsaWFz
X21hY2hpbmU9JCgkUUVNVV9QUk9HIC1tYWNoaW5lIGhlbHAgfCBcDQo+Pj4gICAgICAgc2VkIC1u
ICIvKGFsaWFzIG9mICRkZWZhdWx0X21hY2hpbmUpLyB7IHMvIC4qLy9wOyBxOyB9IikNCj4+PiBA
QCAtODA5LDcgKzgxNSwxMiBAQCBkbw0KPj4+ICAgICAgICAgICAgc3RhcnQ9JChfd2FsbGNsb2Nr
KQ0KPj4+ICAgIA0KPj4+ICAgICAgICAgICAgaWYgWyAiJChoZWFkIC1uIDEgIiRzb3VyY2VfaW90
ZXN0cy8kc2VxIikiID09ICIjIS91c3IvYmluL2VudiBweXRob24iIF07IHRoZW4NCj4+PiAtICAg
ICAgICAgICAgcnVuX2NvbW1hbmQ9IiRQWVRIT04gJHNlcSINCj4+PiArICAgICAgICAgICAgaWYg
JHB5dGhvbl91c2FibGU7IHRoZW4NCj4+DQo+PiBobW0gSSB3YW50ZWQgdG8gc2F5IHRoYXQgdGhp
cyBzaG91bGQgbm90IHdvcmssIGFzIHB5dGhvbl91c2FibGUgaXMgYQ0KPj4gc3RyaW5nLiBCdXQg
SSBjaGVja2VkIGFuZCBzZWUgLSBpdCdzIHdvcmsuIFdvdy4gR29vZ2xlZC4gQW5kIG5vdyBJDQo+
PiB1bmRlcnN0YW5kIHRoYXQgaGVyZSAiZmFsc2UiIG9yICJ0cnVlIiBjb21tYW5kIGlzIGNhbGxl
ZCwgdG8gb2J0YWluDQo+PiBpdCdzIHJldHVybiB2YWx1ZS4uIEkgZG9uJ3QgbGlrZSBiYXNoIGFu
ZCBkb24ndCBrbm93IGl0cyBiZXN0DQo+PiBwcmFjdGljZSwgYnV0IEknZCBwcmVmZXIgcHl0aG9u
X3VzYWJsZSB0byBiZSBqdXN0IHJldHVybiB2YWx1ZSBvZiB5b3VyDQo+PiBweXRob24gY29tbWFu
ZCwgbGlrZQ0KPj4NCj4+IGFib3ZlOg0KPj4NCj4+ICAgICAkUFlUSE9OIC1jICdpbXBvcnQgc3lz
OyBzeXMuZXhpdCgwIGlmIHN5cy52ZXJzaW9uX2luZm8gPj0gKDMsNikgZWxzZSAxKScNCj4+ICAg
ICBweXRob25fdXNhYmxlPSQ/DQo+Pg0KPj4gYW5kIGhlcmU6DQo+Pg0KPj4gICAgIGlmIFsgJHB5
dGhvbl91c2FibGUgLWVxIDAgXTsgdGhlbg0KPiANCj4gSSdtIGp1c3QgdHJ5aW5nIHRvIGJlIGNv
bnNpc3RlbnQgd2l0aCBvdGhlciB2YXJpYWJsZXMgdXNlZCBpbiB0aGUNCj4gJ2NoZWNrJyBzY3Jp
cHQuIEl0IGhhcyBtYW55IGJvb2xlYW4gdmFyaWFibGVzIGFuZCB0aGV5IGFsbCBlbmQgdXANCj4g
Y2FsbGluZyB0aGUgdHJ1ZS9mYWxzZSBjb21tYW5kcy4NCg0KTWlzc2VkIHRoaXMsIHNvcnJ5LiBU
aGVuIE9LLCBvZiBjb3Vyc2UuLg0KDQpzdGlsbCwNCiAgICBlY2hvICJVbnN1cHBvcnRlZCBQeXRo
b24gdmVyc2lvbiAobXVzdCBiZSA+PSAzLjYpIiA+ICRzZXEubm90cnVuDQptYXkgYmUgYSBiaXQg
bW9yZSB1c2VmdWwsIGlmIHNvbWVvbmUgc2VlIGl0Lg0KDQoNCldpdGggb3Igd2l0aG91dCBhbnkg
b2Ygc3VnZ2VzdGlvbnM6DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

