Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15383C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C182E21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sxs22gbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C182E21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyWx-0004d5-J8
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAyVS-0002m2-Uc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAyVQ-0000OY-Qo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:38:06 -0400
Received: from mail-eopbgr50122.outbound.protection.outlook.com
 ([40.107.5.122]:47278 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAyVD-00007f-9T; Thu, 19 Sep 2019 11:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvU/LhSrC2CQJ2IizKFb2QtsOwSX+fxSDsaRFrS5ylOrR7NVBe0kOnjHzPRxomqh8AdBn1xD9f/f33QW7+v3FQqNcXL/A1N4XH7OAdv1JcoOvx0wzC6L1VjkqwSHy1Wt7N0k4oDts+RXOuJ0bGf7DzlEoleDUxewtFlz7s/Wpxg4I8LDh+DQL0JLZNxaektqzgHz4TEIvQqxuqrwtZfruXh+Y9IQdV1HDo5kizmjAF2kYFixeJ6REa/299R9za8Gs/6cz9qLVvYjYYljyVB/5Ey9QAWu4hIIkWSVpgdZLP6MwHb0CRhPeGNt7KKVPpsnOPQy9XuC3mvRRsHmyYZoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TkhocU2grvCzMuM5RHrxdDCDSrpiYNHRdqZuJhKhPA=;
 b=ZjIZaXBxl/c4UZ3JREsl48HYkBVwBPFuuo5/rcgOUlVSDQymo9ZgzMuhEIH8P5QTGKTeCv+w3fcx2+99Uv+b1dqWyAC3ROjuFZ7l5p0WdeY2EVhTxX3ORaOYiy60DD/Sor6llY5hKdE//Gb3G21/REq4wZsd/hCVM41t5NwiGChNuh7dm2BCxLY8hkM8dBWhPWBg8M8sPlvcK0r7ugMdkQYn7znJXCT6+7wuaVbxXz6lGrH9Lgqt7ETDiPOnPwamMBEEAyP5EcLwxla5H8XU9QuzZdPKOjx9O7ZLPWXqmaFYXpgHhbriJkkpugWDS8G9pKWEMpr3ae06Xb9iJ1F/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TkhocU2grvCzMuM5RHrxdDCDSrpiYNHRdqZuJhKhPA=;
 b=Sxs22gbjq815/XOomT5hhgoZU0hfbtxLCkquHiquWX3Avu7Zm5sazCyynTTHFeh2GEO7TTYIMEZGQZ0ZbH43E2eFia7hEK0c3sqyuq9i04vW2BlFnKKkdKPzwmKmP2OVqaAaCztxhCBMaGLGDGEEu64YwZtsF92lbIgCkosjDuw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5002.eurprd08.prod.outlook.com (10.255.17.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 15:37:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 15:37:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Subject: Re: [RFC] error: auto propagated local_err
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAEmpAIAACO4AgAAE0QCAAAPuAIAAAY4AgAAJpgCAAAO9gA==
Date: Thu, 19 Sep 2019 15:37:47 +0000
Message-ID: <4f1ce916-7b5f-d3f0-829b-e7889caece57@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
 <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
 <696673be-95c8-3f75-551c-26fccd230eb1@virtuozzo.com>
 <152afb5b-8efb-d968-d595-94f58ad02a04@redhat.com>
 <20190919144948.GR20217@redhat.com>
 <b5128e58-8b90-233d-6bb1-cc9009852d8d@redhat.com>
In-Reply-To: <b5128e58-8b90-233d-6bb1-cc9009852d8d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0069.eurprd07.prod.outlook.com
 (2603:10a6:3:64::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919183743389
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa91ac74-256c-4024-cc53-08d73d175289
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5002; 
x-ms-traffictypediagnostic: DB8PR08MB5002:
x-microsoft-antispam-prvs: <DB8PR08MB5002D7ACAF9CBA62600D014CC1890@DB8PR08MB5002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(6512007)(36756003)(229853002)(66066001)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(86362001)(31686004)(31696002)(6436002)(6486002)(4326008)(6246003)(14444005)(256004)(14454004)(110136005)(52116002)(99286004)(316002)(486006)(54906003)(8936002)(2616005)(6116002)(8676002)(305945005)(186003)(7736002)(476003)(76176011)(3846002)(386003)(6506007)(26005)(2906002)(446003)(102836004)(11346002)(53546011)(7416002)(81166006)(25786009)(478600001)(81156014)(7406005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5002;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: olouYB1pN9RStr9BpY3WIy7w8Cu6i6nuOTssjvLRJFBRJYwlGcTwn9S5bLORbOekQAPgiBM60Q6kFzKLtdTsm+sloBMGzWbNRH7uP3jBgSG/oKqTHqbuY3htjj9g9K1qwa3eU10UfJGnpkEfvrMjU9ERHlTHoJaIqJwLpqCOpaGT8p9Jcf7M1yyjcVbykDmTkE1cFSMpgnP7V0zRJXbG3bP39jRNpnvFCcf/P8+oGbEnzXpUyBdHQF2e8oMesrfgvkAy3z9qk9h780bQ2QBjwXZQ6NrR4z3ZCEicxnXb+yYEKFSaP2q6O4E8AVz4ZjFgZttzsyDsCRi39CbUC23W1KxQEqPsRFEHuigXgk1RbJ9LjtvutqI7dj/gii5IDkn5lrIaWG03XqbBO8kCBNDAhmBAV6UoiFFxv5J1NzrAqQM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AE28D1A69D21B4C9B7F85565D77279B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa91ac74-256c-4024-cc53-08d73d175289
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 15:37:47.5800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaHfVgc87xvlIltwgP1H1SWUivFSC/YnZEo41yeswoYPrQObWO811M0SN2P1XH6AlgGHNaG9tlaPQ8oZJOKx5LwarbKRncpmU1r4S31TIi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5002
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxODoyNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xOS8xOSA5OjQ5IEFN
LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiANCj4+PiBBTFdBWVMgdXNpbmcgTUFLRV9F
UlJQX1NBRkUoKSBvbiBlbnRyeSB0byBhbnkgZnVuY3Rpb24gdGhhdCBoYXMgYW4gRXJyb3INCj4+
PiAqKmVycnAgcGFyYW1ldGVyIGlzIGRpcnQtc2ltcGxlIHRvIGV4cGxhaW4uICBJdCBoYXMgbm8g
cGVyZm9ybWFuY2UNCj4+PiBwZW5hbHR5IGlmIHRoZSB1c2VyIHBhc3NlZCBpbiBhIG5vcm1hbCBl
cnJvciBvciBlcnJvcl9hYm9ydCAodGhlIGNvc3Qgb2YNCj4+PiBhbiAnaWYnIGhpZGRlbiBpbiB0
aGUgbWFjcm8gaXMgcHJvYmFibHkgbmVnbGlnaWJsZSBjb21wYXJlZCB0bw0KPj4+IGV2ZXJ5dGhp
bmcgZWxzZSB3ZSBkbyksIGFuZCBoYXMgbm8gc2VtYW50aWMgcGVuYWx0eSBpZiB0aGUgdXNlciBw
YXNzZWQNCj4+PiBpbiBOVUxMIG9yIGVycm9yX2ZhdGFsICh3ZSBub3cgZ2V0IHRoZSBiZWhhdmlv
ciB3ZSB3YW50IHdpdGggbGVzcw0KPj4+IGJvaWxlcnBsYXRlKS4NCj4+Pg0KPj4+IEhhdmluZyB0
byB0aGluayAnZG9lcyB0aGlzIG1ldGhvZCByZXF1aXJlIG1lIHRvIHVzZSBNQUtFX0VSUlBfU0FG
RSwgb3INCj4+PiBjYW4gSSBvbWl0IGl0PycgZG9lcyBub3QgcHJvdmlkZSB0aGUgc2FtZSBzaW1w
bGljaXR5Lg0KPj4NCj4+IFRoZSBmbGlwc2lkZSBpcyB0aGF0IE1BS0VfRVJSUF9TQUZFIGhpZGVz
IGEgYnVuY2ggb2YgbG9naWMsIHNvIHlvdSBkb24ndA0KPj4gcmVhbGx5IGtub3cgd2hhdCBpdHMg
ZG9pbmcgd2l0aG91dCBsb29raW5nIGF0IGl0LCBhbmQgdGhpcyBpcyBRRU1VDQo+PiBjdXN0b20g
Y29uY2VwdCBzbyBvbmUgbW9yZSB0aGluZyB0byBsZWFybiBmb3IgbmV3IGNvbnRyaWJ1dG9ycy4N
Cj4+DQo+PiBXaGlsZSBJIHRoaW5rIGl0IGlzIGEgbmljZSB0cmljaywgcGVyc29uYWxseSBJIHRo
aW5rIHdlIHdvdWxkIGJlIGJldHRlcg0KPj4gb2ZmIGlmIHdlIHNpbXBseSB1c2VkIGEgY29kZSBw
YXR0ZXJuIHdoaWNoIGRvZXMgbm90IHJlcXVpcmUgZGUtcmVmZXJlbmNpbmcNCj4+ICdlcnJwJyBh
dCBhbGwsIGFzaWRlIGZyb20gZXhjZXB0aW9uYWwgY2FzZXMuIElPVywgbm8gYWRkZWQgbWFjcm8g
aW4gOTUlDQo+PiBvZiBhbGwgb3VyIG1ldGhvZHMgdXNpbmcgRXJyb3IgKiplcnJwLg0KPiANCj4g
SWYgMTAwJSBvZiBvdXIgY2FsbHNpdGVzIHVzZSB0aGUgbWFjcm8sIHRoZW4gbmV3IGNvbnRyaWJ1
dG9ycyB3aWxsDQo+IHF1aWNrbHkgbGVhcm4gYnkgb2JzZXJ2YXRpb24gYWxvbmUgdGhhdCB0aGUg
bWFjcm8gdXNhZ2UgbXVzdCBiZQ0KPiBpbXBvcnRhbnQgb24gYW55IG5ldyBmdW5jdGlvbiB0YWtp
bmcgRXJyb3IgKiplcnJwLCB3aGV0aGVyIG9yIG5vdCB0aGV5DQo+IGFjdHVhbGx5IHJlYWQgdGhl
IG1hY3JvIHRvIHNlZSB3aGF0IGl0IGRvZXMuICBJZiBvbmx5IDUlIG9mIG91cg0KPiBjYWxsc2l0
ZXMgdXNlIHRoZSBtYWNybywgaXQncyBoYXJkZXIgdG8gYXJndWUgdGhhdCBhIG5ldyB1c2VyIHdp
bGwgcGljaw0KPiB1cCBvbiB0aGUgbnVhbmNlcyBieSBvYnNlcnZhdGlvbiBhbG9uZSAocHJlc3Vt
YWJseSwgb3VyIGRvY3Mgd291bGQgYWxzbw0KPiBzcGVsbCBpdCBvdXQsIGJ1dCB3ZSBrbm93IHRo
YXQgbm90IGV2ZXJ5b25lIHJlYWRzIHRob3NlLi4uKS4NCg0KV2hlbiBJIHdhcyBhIG5ldyBjb250
cmlidXRvciwgaXQgd2FzIG5vdCBzaW1wbGUgdG8gdW5kZXJzdGFuZCwgd2hlbiBhbmQgd2h5IHdl
DQpuZWVkIHRvIHVzZSBsb2NhbF9lcnIsIGtlZXBpbmcgaW4gbWluZCB0aGF0ICh0aGlzIGlzIG5v
dCBvbmx5IHJlYXNvbiwgYnV0IGFsc28NCmEgY29uc2VxdWVuY2UpIHdlIGhhdmUgcGxhY2VzIHdo
ZXJlIGxvY2FsX2VyciBpcyB1c2VkIGZvciBubyByZWFzb24uDQoNCj4gDQo+IEhvd2V2ZXIsIGlm
IHdlIGNhbiBhdXRvbWF0ZSBzeW50YXggY2hlY2tzIHRvIHJlYWNoIGEgbmVhci0xMDAlIGFjY3Vy
YWN5LA0KPiB3ZSBkb24ndCBIQVZFIHRvIHdvcnJ5IGFib3V0IHdoZXRoZXIgYSBuZXcgcHJvZ3Jh
bW1lciBwaWNrcyB1cCBvbiB0aGUNCj4gbnVhbmNlcyBieSBvYnNlcnZhdGlvbiwgYmVjYXVzZSB0
aGV5IHdpbGwgaW5zdGVhZCBwaWNrIHVwIHRoZSBudWFuY2VzIGJ5DQo+IENJIHJlamVjdGlvbiBt
ZXNzYWdlcy4gIFRoaXMgaXMgdHJ1ZSBmb3IgX2VpdGhlcl8gc3R5bGU6DQo+IA0KPiAxMDAlIHVz
ZSBvZiB0aGUgbWFjcm86IENJIG1lc3NhZ2Ugd291bGQgYmUgInlvdSBhZGRlZCBhIG1ldGhvZCB3
aXRoIGENCj4gcGFyYW1ldGVyICdFcnJvciAqKmVycnAnIGJ1dCBmb3Jnb3QgdG8gdXNlIE1BS0Vf
RVJSUF9TQUZFIg0KPiANCj4gdXNlIG9mIHRoZSBtYWNybyBvbmx5IHdoZXJlIG5lY2Vzc2FyeSAo
bmFtZWx5LCBmdW5jdGlvbnMgdGhhdCBjb250YWluDQo+ICcqZXJycCcgYW5kL29yICdlcnJvcl9h
cHBlbmRfaGludCcpOiBDSSBtZXNzYWdlIHdvdWxkIGVpdGhlciBiZSAieW91cg0KPiBmdW5jdGlv
biBib2R5IHJlcXVpcmVzIE1BS0VfRVJSUF9TQUZFIGJ1dCB5b3UgZm9yZ290IGl0IiBvciAieW91
cg0KPiBmdW5jdGlvbiBib2R5IGRvZXMgbm90IHJlcXVpcmUgTUFLRV9FUlJQX1NBRkUgYnV0IHlv
dSBmb3Jnb3QgdG8gcmVtb3ZlDQo+IGl0Ii4gIEFuZCB0aGlzIHdvdWxkIHdvcmsgZXZlbiBmb3Ig
ZXhwZXJpZW5jZWQgY29tbWl0dGVycyBlZGl0aW5nDQo+IGV4aXN0aW5nIGZ1bmN0aW9ucyAoc3Vj
aCBhcyBvbmdvaW5nIHdvcmsgdG8gY29udmVydCBhd2F5IGZyb20gJ3ZvaWQNCj4gY2hpbGQoZXJy
cCk7IGlmICgqZXJycCknIGFuZCB0b3dhcmRzICdpZiAoaW50IGNoaWxkKGVycnApIDwgMCknKS4N
Cj4gDQo+IFdyaXRpbmcgdGhlIENJIGVuZ2luZSBmb3IgdGhlIGZpcnN0IGNhc2UgaXMgZWFzeSwg
d3JpdGluZyBpdCBmb3IgdGhlDQo+IHNlY29uZCBpcyBhIGJpdCBoYXJkZXIsIGJ1dCBzdGlsbCBz
ZWVtcyB0cmFjdGFibGUgKHNpbmNlLCBmb3IgYW55DQo+IGZ1bmN0aW9uIHdpdGggYW4gJ0Vycm9y
ICoqZXJycCcgcGFyYW1ldGVyLCBpdCBzaG91bGQgYmUgZWFzeSB0byBzY2FuIHRoZQ0KPiBmdW5j
dGlvbiBib2R5IGZvciBpbnN0YW5jZXMgb2YgJyplcnJwJyBvciAnZXJyb3JfYXBwZW5kX2hpbnQn
LCBhcyB3ZWxsDQo+IGFzIHRvIHNjYW4gd2hldGhlciBNQUtFX0VSUlBfU0FGRSB3YXMgcHJlc2Vu
dCBvciBhYnNlbnQgYWNjb3JkaW5nbHkpLg0KPiANCj4+IFRoZXJlIGFyZSBsb3RzIG9mIG5lYXQg
dGhpbmdzIHdlIGNvdWxkIGRvIHdpdGggYXV0by1jbGVhbnVwIGZ1bmN0aW9ucyB3ZQ0KPj4gSSB0
aGluayB3ZSBuZWVkIHRvIGJlIHdhcnkgb2YgaGlkaW5nIHRvbyBtdWNoIGNsZXZlcm5lc3MgYmVo
aW5kIG1hY3Jvcw0KPj4gd2hlbiBkb2luZyBzbyBvdmVyYWxsLg0KPiANCj4gVGhlIGJlbmVmaXQg
b2YgZ2V0dGluZyByaWQgb2YgdGhlICdFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsgLi4uDQo+IGVy
cm9yX3Byb3BhZ2F0ZSgpJyBib2lsZXJwbGF0ZSBpcyB3b3J0aCB0aGUgY2xldmVybmVzcywgaW4g
bXkgb3BpbmlvbiwNCj4gYnV0IGVzcGVjaWFsbHkgaWYgYWxzbyBhY2NvbXBhbmllZCBieSBDSSBj
b3ZlcmFnZSB0aGF0IHdlIGFiaWRlIGJ5IG91cg0KPiBuZXcgcnVsZXMuDQo+IA0KPiBJJ2QgcmVh
bGx5IGxpa2UgdG8gaGVhciBNYXJrdXMnIG9waW5pb24gb24gdGhlIG1hdHRlciwgYXMgRXJyb3Ig
bWFpbnRhaW5lci4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

