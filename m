Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA0C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64C82186A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vk0YKFwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64C82186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNKd-000087-53
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:48:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hCNDI-0002No-Tz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hCND8-0007Mk-Uj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:45 -0400
Received: from mail-eopbgr30136.outbound.protection.outlook.com
	([40.107.3.136]:43778
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hCND3-0006rC-8T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zP8T+W3hBu3D7bFK+NzGAqcN7JWQoNc+3GO4+/QsdUc=;
	b=Vk0YKFwFlMYl6l+YW/tB0e0qFiwsqroS3MQzL74Dq6dZfscdbk4arh1xjjr9+YNu1xyCd9RrP1+gmg88+X3HlCSnqp2sPgBqxqWNglkN4REWSceqWg5T9vErG1JqmPIuGyjMj7xuA41kxKK9pLMzDHH4VD19suJuiArfPqhL/9g=
Received: from AM0PR08MB3186.eurprd08.prod.outlook.com (52.134.93.155) by
	AM0PR08MB2995.eurprd08.prod.outlook.com (52.134.94.138) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1750.15; Fri, 5 Apr 2019 11:40:29 +0000
Received: from AM0PR08MB3186.eurprd08.prod.outlook.com
	([fe80::cec:2e17:5e84:43de]) by AM0PR08MB3186.eurprd08.prod.outlook.com
	([fe80::cec:2e17:5e84:43de%3]) with mapi id 15.20.1750.021;
	Fri, 5 Apr 2019 11:40:29 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com"
	<quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>
Thread-Topic: [PINGl] [PATCH 0/3] migration: add sztd compression
Thread-Index: AQHU66Re4ZMNHRzi+0GEU8xu+4oBXw==
Date: Fri, 5 Apr 2019 11:40:29 +0000
Message-ID: <084a53dc-642c-0219-3cc5-3cbe783db37b@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
	<8ef4ffa2-6c59-a6dd-e2bd-97b6fea7a5d1@virtuozzo.com>
	<7abd40bc-963b-cf61-14e8-4c4187813c5c@virtuozzo.com>
	<5c342066-30b6-e492-e23a-cb5accbfb11a@virtuozzo.com>
	<53b5c677-870e-56a0-402d-7fdc985ec3f5@virtuozzo.com>
In-Reply-To: <53b5c677-870e-56a0-402d-7fdc985ec3f5@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24)
	To AM0PR08MB3186.eurprd08.prod.outlook.com
	(2603:10a6:208:5d::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecfad32c-c3d1-4ea5-e470-08d6b9bb80aa
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB2995; 
x-ms-traffictypediagnostic: AM0PR08MB2995:
x-microsoft-antispam-prvs: <AM0PR08MB2995A09BE8B34B4FB71D000ACF510@AM0PR08MB2995.eurprd08.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(66066001)(68736007)(8936002)(110136005)(53936002)(8676002)(386003)(316002)(446003)(54906003)(305945005)(6486002)(26005)(99286004)(6506007)(36756003)(53546011)(11346002)(186003)(105586002)(486006)(106356001)(76176011)(2616005)(102836004)(52116002)(4326008)(478600001)(93886005)(81156014)(14454004)(7736002)(31686004)(476003)(25786009)(3846002)(6436002)(2906002)(6116002)(6512007)(97736004)(86362001)(31696002)(256004)(81166006)(5660300002)(2201001)(71190400001)(71200400001)(2501003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2995;
	H:AM0PR08MB3186.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FyIthZjXgSogZNRZD/hwiW82dfIyIWgItLj5BOQOhgoQYjBbmt+n18ycjUYLGY/PZG5SKfN5rgeNbmjVgwcyP5ZWj8TTFcJa84pAVMuFkosgxU3mHonCX5uiGW7RjI9w1HEH+MWg6m2kUidvJHxqY/ERHStcBr6ojIaqkc6XGugz04vUEzBqB0Uq+4Ldw+ajwBjnGFiLMQzut2uwRBPdkav+cOZsWQTVKeuu400xfUuht+QvT9FAJDL7ii4Q7JNf3YbV6JUxRWNENPZs/+GzgoxrASM72hr7bpWGa0mmOcPyPwoFQnmm2j97UWgNljQT/0C2LeBCkwR3NziSm3wbxeDnIiLfUHExUmgXNNgZzw9lq/S8dXuyUIYqtshTZmv/a582714Q9uOFpfLJEn7FNO3/7+rnTgXR5WFguYbvEnU=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <AB8DCA3B755443499A337B08DC87BF56@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfad32c-c3d1-4ea5-e470-08d6b9bb80aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 11:40:29.7416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2995
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.136
Subject: [Qemu-devel] [PINGl] [PATCH 0/3] migration: add sztd compression
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405114029.N5i1Sk0jSxcCkr3yUitqyawQGKUvoEtviA1aIsSMzM8@z>

cGluZyENCg0KT24gMjYuMDMuMjAxOSAxODo1MSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBw
aW5nIHBpbmcgcGluZyBwaW5nIHBpbmchDQo+IA0KPiBPbiAxOC4wMy4yMDE5IDEwOjUzLCBEZW5p
cyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBwaW5nIHBpbmcgcGluZyBwaW5nIQ0KPj4NCj4+IE9uIDEx
LjAzLjIwMTkgMTE6MjAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+PiBwaW5nIHBpbmcgcGlu
ZyENCj4+Pg0KPj4+IE9uIDA0LjAzLjIwMTkgMTg6MTAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToN
Cj4+Pj4gcGluZyENCj4+Pj4NCj4+Pj4gT24gMjYuMDIuMjAxOSAxNjoxNSwgRGVuaXMgUGxvdG5p
a292IHdyb3RlOg0KPj4+Pj4genN0ZCBkYXRlIGNvbXByZXNzaW9uIGFsZ29yaXRobSBzaG93cyBi
ZXR0ZXIgcGVyZm9ybWFuY2Ugb24gZGF0YSBjb21wcmVzc2lvbi4NCj4+Pj4+IEl0IG1pZ2h0IGJl
IHVzZWZ1bCB0byBlbXBsb3kgdGhlIGFsZ29yaXRobSBpbiBWTSBtaWdyYXRpb24gdG8gcmVkdWNl
IENQVSB1c2FnZS4NCj4+Pj4+IEEgdXNlciB3aWxsIGJlIGFibGUgdG8gY2hvb3NlIGJldHdlZW4g
dGhvc2UgYWxnb3JpdGhtcywgdGhlcmVmb3IgY29tcHJlc3MtdHlwZQ0KPj4+Pj4gbWlncmF0aW9u
IHBhcmFtZXRlciBpcyBhZGRlZC4NCj4+Pj4+DQo+Pj4+PiBIZXJlIGFyZSBzb21lIHJlc3VsdHMg
b2YgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiB6c3RkIHZzIGd6aXA6DQo+Pj4+Pg0KPj4+Pj4gaG9z
dDogaTctNDc5MCA4eENQVSBAIDMuNjBHSHosIDE2RyBSQU0NCj4+Pj4+IG1pZ3JhdGlvbiB0byB0
aGUgc2FtZSBob3N0DQo+Pj4+PiBWTTogMnhWQ1BVLCA4RyBSQU0gdG90YWwNCj4+Pj4+IDVHIFJB
TSB1c2VkLCBtZW1vcnkgcG9wdWxhdGVkIHdpdGggcG9zdGdyZXFzbCBkYXRhDQo+Pj4+PiBwcm9k
dWNlZCBieSBwZ2JlbmNoIHBlcmZvcm1hbmNlIGJlbmNobWFyaw0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBUaHJlYWRzOiAxIGNvbXByZXNzIOKAkyAxIGRlY29tcHJlc3MNCj4+Pj4+DQo+Pj4+PiB6c3Rk
IHByb3ZpZGVzIHNsaWdodGx5IGxlc3MgY29tcHJlc3Npb24gcmF0aW8gd2l0aCBhbG1vc3QgdGhl
IHNhbWUNCj4+Pj4+IENQVSB1c2FnZSBidXQgY29wZXMgd2l0aCBSQU0gIGNvbXByZXNzaW9uIHJv
Z2hseSAyIHRpbWVzIGZhc3Rlcg0KPj4+Pj4NCj4+Pj4+IGNvbXByZXNzaW9uIHR5cGUgICAgICAg
ICAgICAgIHpsaWIgICAgICAgfCAgICAgIHpzdGQNCj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4gY29tcHJlc3Npb24g
bGV2ZWwgICAgICAgICAgMSAgICAgICA1ICAgICB8ICAgMSAgICAgICA1DQo+Pj4+PiBjb21wcmVz
c2lvbiByYXRpbyAgICAgICAgICA2LjkyICAgIDcuMDUgIHwgICA2LjY5ICAgIDYuODkNCj4+Pj4+
IGNwdSBpZGxlLCAlICAgICAgICAgICAgICAgIDgyICAgICAgODMgICAgfCAgIDg2ICAgICAgODAN
Cj4+Pj4+IHRpbWUsIHNlYyAgICAgICAgICAgICAgICAgIDQ5ICAgICAgNzEgICAgfCAgIDI2ICAg
ICAgMzENCj4+Pj4+IHRpbWUgZGlmZiB0byB6bGliLCBzZWMgICAgICAgICAgICAgICAgICAgICAg
LTI1ICAgICAtNDENCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gVGhyZWFkczogOCBjb21wcmVzcyDigJMg
MiBkZWNvbXByZXNzDQo+Pj4+Pg0KPj4+Pj4genN0ZCBwcm92aWRlcyB0aGUgc2FtZSBtaWdyYXRp
b24gdGltZSB3aXRoIGxlc3MgY3B1IGNvbnN1bXB0aW9uDQo+Pj4+Pg0KPj4+Pj4gY29tcHJlc3Np
b24gdHlwZSAgICAgICAgIG5vbmUgIHwgICAgICAgIGd6aXAoemxpYikgICAgfCAgICAgICAgICB6
c3RkDQo+Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+IGNvbXByZXNzaW9uIGxldmVs
ICAgICAgICAtICAgICB8ICAxICAgICAgNSAgICAgICA5ICAgIHwgICAxICAgICAgIDUgICAgICAg
MTUNCj4+Pj4+IGNvbXByZXNzaW9uIHJhdGlvICAgICAgICAtICAgICB8ICA2Ljk0ICAgNi45OSAg
ICA3LjE0IHwgICA2LjY0ICAgIDYuODkgICAgNi45Mw0KPj4+Pj4gdGltZSwgc2VjICAgICAgICAg
ICAgICAgIDE1NCAgIHwgIDIyICAgICAyMyAgICAgIDI3ICAgfCAgIDIzICAgICAgMjMgICAgICAy
NQ0KPj4+Pj4gY3B1IGlkbGUsICUgICAgICAgICAgICAgIDk5ICAgIHwgIDQ1ICAgICAzMCAgICAg
IDEyICAgfCAgIDcwICAgICAgNTIgICAgICAyMw0KPj4+Pj4gY3B1IGlkbGUgZGlmZiB0byB6bGli
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfCAgLTI1JSAgICAtMjIlICAgIC0xMSUN
Cj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gRGVuaXMgUGxvdG5pa292ICgzKToNCj4+Pj4+ICAgICAgICBt
aWdyYXRpb246IHJld29yayBjb21wcmVzc2lvbiBjb2RlIGZvciBhZGRpbmcgbW9yZSBkYXRhIGNv
bXByZXNzb3JzDQo+Pj4+PiAgICAgICAgaG1wOiBhZGQgY29tcHJlc3MtdHlwZSBwYXJhbWV0ZXIg
dG8gbWlncmF0aW9uIHBhcmFtZXRlcnMNCj4+Pj4+ICAgICAgICBtaWdyYXRpb246IGFkZCB6c3Rk
IGNvbXByZXNzaW9uDQo+Pj4+Pg0KPj4+Pj4gICAgICAgY29uZmlndXJlICAgICAgICAgICAgIHwg
IDI2ICsrKysNCj4+Pj4+ICAgICAgIGhtcC5jICAgICAgICAgICAgICAgICB8ICAgOCArKw0KPj4+
Pj4gICAgICAgbWlncmF0aW9uL21pZ3JhdGlvbi5jIHwgIDQ1ICsrKysrKy0NCj4+Pj4+ICAgICAg
IG1pZ3JhdGlvbi9taWdyYXRpb24uaCB8ICAgMSArDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcWVt
dS1maWxlLmMgfCAgMzkgKystLS0tDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcWVtdS1maWxlLmgg
fCAgMTggKystDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcmFtLmMgICAgICAgfCAyOTEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+Pj4+PiAgICAgICBxYXBpL21p
Z3JhdGlvbi5qc29uICAgfCAgMjYgKysrLQ0KPj4+Pj4gICAgICAgOCBmaWxlcyBjaGFuZ2VkLCAz
NjkgaW5zZXJ0aW9ucygrKSwgODUgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pg0KPj4+DQo+Pg0K
PiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==

