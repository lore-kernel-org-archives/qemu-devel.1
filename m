Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842CC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F0121019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ALI2ZBMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F0121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtiF-0007aO-5q
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:13:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVtg6-0006Wt-N1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVtg5-0002CU-9B
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:11:18 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
	([40.107.4.129]:58209
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVtg1-00027z-KG; Wed, 29 May 2019 04:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2Hy9GgFhj8nfSvxSjDYvW2EH4KkGMGVbfyVr2AHw94M=;
	b=ALI2ZBMUapkezKE90Y3lRb8bMzrfTvx5UiPgt3TCrKVJaxUhwf+/hmG4RwFoxCg563vIbgm2AGn+oYXdR2cgWbaTGdP746fWM4eGhkagBCXc7RCiH9dczI0KesKJEV2BqpWdIIZ4NoDxBXcYB82JbqSX0ReLNIuEqDKKwYC4m4s=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3777.eurprd08.prod.outlook.com (20.178.22.223) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Wed, 29 May 2019 08:11:09 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 08:11:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "kwolf@redhat.com"
	<kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v0] qemu-io: add pattern file for write command
Thread-Index: AQHVFeqLRAt51NQ58ke4dsrnowlVHaaBwE2A
Date: Wed, 29 May 2019 08:11:09 +0000
Message-ID: <4442baee-ac68-bf06-60a2-257fd52f4592@virtuozzo.com>
References: <20190529064824.32064-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190529064824.32064-1-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::17)
	To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529111106981
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3658a71a-b657-4771-afa5-08d6e40d3496
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3777; 
x-ms-traffictypediagnostic: AM0PR08MB3777:
x-microsoft-antispam-prvs: <AM0PR08MB3777819806A99CF6AB2505CFC11F0@AM0PR08MB3777.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6116002)(64756008)(107886003)(2201001)(66066001)(86362001)(66946007)(71190400001)(26005)(66446008)(99286004)(386003)(66556008)(52116002)(6506007)(73956011)(66476007)(186003)(256004)(76176011)(2906002)(31696002)(102836004)(71200400001)(31686004)(3846002)(5660300002)(7736002)(305945005)(4326008)(2616005)(229853002)(68736007)(6512007)(2501003)(53936002)(6486002)(6436002)(11346002)(486006)(36756003)(316002)(110136005)(446003)(54906003)(478600001)(25786009)(476003)(6246003)(8936002)(81166006)(8676002)(81156014)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3777;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DD2ND1SGQHEQuIqxL3LSsWzKgNQFNvjZLBlAaiuQMLgFUfiRgS9DeAE88byw/zDKPWxDMEn6r2/ruFwevKhTnDglBo5tCSPPmCFoYaX8sRY8FK4IlPk5PDMczHQsChUo1NmCMvLNd+tQRepJXe1AfcO1Lq5UtS0Lmx3tNEN0Tz+PP8YGPUDU5CL2KbsvqWmaZJofVpaCzItcsCRnHXIOzy4idzcx5+LGoa41kBrw9/uW53YnOCeb8ju+/lvmCe9TDzSyfAqEZoG6NS9TTgAizJOIGlQmOXqNTft9gQhRa+hsfSsrdK62H59wVzSbNUHz7VFjP5Bba4IS7/ZqFFFoPT5zPC6kwmYRiFnwN9qRkecn6TXlOqVw3Rx4JRvrcoM5fR9iF72XjCGKTvIT2xePq00iTjHjvRksM4YUjtBYmrM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC92BBC126E85418D7E7F69F299187F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3658a71a-b657-4771-afa5-08d6e40d3496
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:11:09.2459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3777
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.129
Subject: Re: [Qemu-devel] [PATCH v0] qemu-io: add pattern file for write
 command
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMDUuMjAxOSA5OjQ4LCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+IFRoZSBwYXRjaCBhbGxv
d3MgdG8gcHJvdmlkZSBhIHBhdHRlcm4gZmlsZSBmb3Igd3JpdGUNCj4gY29tbWFuZC4gVGhlcmUg
d2FzIG5vIHNpbWlsYXIgYWJpbGl0eSBiZWZvcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5p
cyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgcWVtdS1p
by1jbWRzLmMgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3FlbXUtaW8tY21kcy5jIGIvcWVtdS1pby1jbWRzLmMN
Cj4gaW5kZXggMDk3NTBhMjNjZS4uYjkzOTU1MTE2ZiAxMDA2NDQNCj4gLS0tIGEvcWVtdS1pby1j
bWRzLmMNCj4gKysrIGIvcWVtdS1pby1jbWRzLmMNCj4gQEAgLTIxLDYgKzIxLDcgQEANCj4gICAj
aW5jbHVkZSAicWVtdS9vcHRpb24uaCINCj4gICAjaW5jbHVkZSAicWVtdS90aW1lci5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiArI2luY2x1ZGUgInN0cmluZy5oIg0KPiAgIA0K
PiAgICNkZWZpbmUgQ01EX05PRklMRV9PSyAgIDB4MDENCj4gICANCj4gQEAgLTM0Myw2ICszNDQs
MzUgQEAgc3RhdGljIHZvaWQgKnFlbXVfaW9fYWxsb2MoQmxvY2tCYWNrZW5kICpibGssIHNpemVf
dCBsZW4sIGludCBwYXR0ZXJuKQ0KPiAgICAgICByZXR1cm4gYnVmOw0KPiAgIH0NCj4gICANCj4g
K3N0YXRpYyB2b2lkICpxZW11X2lvX2FsbG9jX2Zyb21fZmlsZShCbG9ja0JhY2tlbmQgKmJsaywg
c2l6ZV90IGxlbiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGFy
ICpmaWxlX25hbWUpDQo+ICt7DQo+ICsgICAgdm9pZCAqYnVmOw0KPiArICAgIEZJTEUgKmYgPSBm
b3BlbihmaWxlX25hbWUsICJyIik7DQo+ICsNCj4gKyAgICBpZiAoIWYpIHsNCj4gKyAgICAgICAg
cHJpbnRmKCJjYW5ub3Qgb3BlbiBmaWxlICclcydcbiIsIGZpbGVfbmFtZSk7DQoNCkkgc2VlLCBw
cmludGYgZnJvIGVycm9ycyBpcyBwcmVleGlzdGluZyBpbiBxZW11LWlvLWNtZHMuYywgYnV0IGVy
cm9yX3JlcG9ydCBpcyB1c2VkIGhlcmUgdG9vLA0KSSB0aGluayBpdCdzIGJldHRlciB0byB1c2Ug
ZXJyb3JfcmVwb3J0Lg0KDQo+ICsgICAgICAgIHJldHVybiBOVUxMOw0KPiArICAgIH0NCj4gKw0K
PiArICAgIGlmIChxZW11aW9fbWlzYWxpZ24pIHsNCj4gKyAgICAgICAgbGVuICs9IE1JU0FMSUdO
X09GRlNFVDsNCj4gKyAgICB9DQo+ICsgICAgYnVmID0gYmxrX2Jsb2NrYWxpZ24oYmxrLCBsZW4p
Ow0KPiArICAgIG1lbXNldChidWYsIDAsIGxlbik7DQo+ICsNCj4gKyAgICBpZiAoIWZyZWFkKGJ1
Ziwgc2l6ZW9mKGNoYXIpLCBsZW4sIGYpKSB7DQo+ICsgICAgICAgIHByaW50ZigiZmlsZSAnJXMn
IGlzIGVtcHR5XG4iLCBmaWxlX25hbWUpOw0KPiArICAgICAgICBmcmVlKGJ1Zik7DQo+ICsgICAg
ICAgIHJldHVybiBOVUxMOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmIChxZW11aW9fbWlzYWxp
Z24pIHsNCj4gKyAgICAgICAgYnVmICs9IE1JU0FMSUdOX09GRlNFVDsNCg0KaG1tLCBwcmVleGlz
dGluZyBpbiBxZW11X2lvX2FsbG9jIGFuZCBxZW11X2lvX2ZyZWUsIGJ1dCBJZiBJIHJlbWVtYmVy
IGNvcnJlY3RseSwgcG9pbnRlciBhcml0aG1ldGljDQpvbiB2b2lkKiBpcyBub3QgZ3VhcmFudGVl
ZCB0byB3b3JrIGFzIGV4cGVjdGVkIGhlcmUuLg0KDQo+ICsgICAgfQ0KPiArICAgIHJldHVybiBi
dWY7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBxZW11X2lvX2ZyZWUodm9pZCAqcCkNCj4g
ICB7DQo+ICAgICAgIGlmIChxZW11aW9fbWlzYWxpZ24pIHsNCj4gQEAgLTk2NSw3ICs5OTUsNyBA
QCBzdGF0aWMgY29uc3QgY21kaW5mb190IHdyaXRlX2NtZCA9IHsNCj4gICAgICAgLnBlcm0gICAg
ICAgPSBCTEtfUEVSTV9XUklURSwNCj4gICAgICAgLmFyZ21pbiAgICAgPSAyLA0KPiAgICAgICAu
YXJnbWF4ICAgICA9IC0xLA0KPiAtICAgIC5hcmdzICAgICAgID0gIlstYmNDZm5xdXpdIFstUCBw
YXR0ZXJuXSBvZmYgbGVuIiwNCj4gKyAgICAuYXJncyAgICAgICA9ICJbLWJjQ2ZucXV6XSBbLVAg
cGF0dGVybiB8IC1zIHNvdXJjZV9maWxlXSBvZmYgbGVuIiwNCj4gICAgICAgLm9uZWxpbmUgICAg
PSAid3JpdGVzIGEgbnVtYmVyIG9mIGJ5dGVzIGF0IGEgc3BlY2lmaWVkIG9mZnNldCIsDQo+ICAg
ICAgIC5oZWxwICAgICAgID0gd3JpdGVfaGVscCwNCj4gICB9Ow0KPiBAQCAtOTc0LDcgKzEwMDQs
NyBAQCBzdGF0aWMgaW50IHdyaXRlX2YoQmxvY2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFy
ICoqYXJndikNCj4gICB7DQo+ICAgICAgIHN0cnVjdCB0aW1ldmFsIHQxLCB0MjsNCj4gICAgICAg
Ym9vbCBDZmxhZyA9IGZhbHNlLCBxZmxhZyA9IGZhbHNlLCBiZmxhZyA9IGZhbHNlOw0KPiAtICAg
IGJvb2wgUGZsYWcgPSBmYWxzZSwgemZsYWcgPSBmYWxzZSwgY2ZsYWcgPSBmYWxzZTsNCj4gKyAg
ICBib29sIFBmbGFnID0gZmFsc2UsIHpmbGFnID0gZmFsc2UsIGNmbGFnID0gZmFsc2UsIHNmbGFn
ID0gZmFsc2U7DQo+ICAgICAgIGludCBmbGFncyA9IDA7DQo+ICAgICAgIGludCBjLCBjbnQsIHJl
dDsNCj4gICAgICAgY2hhciAqYnVmID0gTlVMTDsNCj4gQEAgLTk4Myw4ICsxMDEzLDkgQEAgc3Rh
dGljIGludCB3cml0ZV9mKEJsb2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
DQo+ICAgICAgIC8qIFNvbWUgY29tcGlsZXJzIGdldCBjb25mdXNlZCBhbmQgd2FybiBpZiB0aGlz
IGlzIG5vdCBpbml0aWFsaXplZC4gICovDQo+ICAgICAgIGludDY0X3QgdG90YWwgPSAwOw0KPiAg
ICAgICBpbnQgcGF0dGVybiA9IDB4Y2Q7DQo+ICsgICAgY2hhciBmaWxlX25hbWVbMjU1XSA9IHsg
MCB9Ow0KPiAgIA0KPiAtICAgIHdoaWxlICgoYyA9IGdldG9wdChhcmdjLCBhcmd2LCAiYmNDZm5w
UDpxdXoiKSkgIT0gLTEpIHsNCj4gKyAgICB3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwg
ImJjQ2ZucFA6cXV6czoiKSkgIT0gLTEpIHsNCj4gICAgICAgICAgIHN3aXRjaCAoYykgew0KPiAg
ICAgICAgICAgY2FzZSAnYic6DQo+ICAgICAgICAgICAgICAgYmZsYWcgPSB0cnVlOw0KPiBAQCAt
MTAyMCw2ICsxMDUxLDEwIEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJsaywg
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgY2FzZSAneic6DQo+ICAgICAgICAg
ICAgICAgemZsYWcgPSB0cnVlOw0KPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICBj
YXNlICdzJzoNCj4gKyAgICAgICAgICAgIHNmbGFnID0gdHJ1ZTsNCj4gKyAgICAgICAgICAgIHN0
cm5jcHkoZmlsZV9uYW1lLCBvcHRhcmcsIHNpemVvZihmaWxlX25hbWUpIC0gMSk7DQoNCk1heWJl
LCBnX3N0cmR1cCBhbmQgZG9uJ3QgY2FyZSBhYm91dCBmaWxlX25hbWUgbGVuZ3RoPw0KDQo+ICsg
ICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAg
cWVtdWlvX2NvbW1hbmRfdXNhZ2UoJndyaXRlX2NtZCk7DQo+ICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+IEBAIC0xMDU2LDYgKzEwOTEsMTQgQEAgc3RhdGljIGludCB3cml0ZV9mKEJs
b2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIGlmIChzZmxhZyAmJiBQZmxhZykg
ew0KPiArICAgICAgICBwcmludGYoIi1zIGFuZCAtUCBjYW5ub3QgYmUgc3BlY2lmaWVkIGF0IHRo
ZSBzYW1lIHRpbWVcbiIpOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmICh6ZmxhZyAmJiBQZmxh
Zykgew0KPiArICAgICAgICBwcmludGYoIi16IGFuZCAtUCBjYW5ub3QgYmUgc3BlY2lmaWVkIGF0
IHRoZSBzYW1lIHRpbWVcbiIpOw0KPiArICAgIH0NCg0Kc3RyYW5nZSwgdGhhdCB5b3UgYWRkIHRo
aXMgbGFzdCBjaGVjay4uIEkgc2VlIGl0IGluIG1hc3RlciBicmFuY2ggYWxyZWFkeS4NCg0KPiAr
DQo+ICAgICAgIG9mZnNldCA9IGN2dG51bShhcmd2W29wdGluZF0pOw0KPiAgICAgICBpZiAob2Zm
c2V0IDwgMCkgew0KPiAgICAgICAgICAgcHJpbnRfY3Z0bnVtX2VycihvZmZzZXQsIGFyZ3Zbb3B0
aW5kXSk7DQo+IEBAIC0xMDg4LDcgKzExMzEsMTQgQEAgc3RhdGljIGludCB3cml0ZV9mKEJsb2Nr
QmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgIH0NCj4gICANCj4g
ICAgICAgaWYgKCF6ZmxhZykgew0KPiAtICAgICAgICBidWYgPSBxZW11X2lvX2FsbG9jKGJsaywg
Y291bnQsIHBhdHRlcm4pOw0KPiArICAgICAgICBpZiAoc2ZsYWcpIHsNCj4gKyAgICAgICAgICAg
IGJ1ZiA9IHFlbXVfaW9fYWxsb2NfZnJvbV9maWxlKGJsaywgY291bnQsIGZpbGVfbmFtZSk7DQo+
ICsgICAgICAgICAgICBpZiAoIWJ1Zikgew0KPiArICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiArICAgICAgICAgICAgfQ0KPiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAg
ICAgYnVmID0gcWVtdV9pb19hbGxvYyhibGssIGNvdW50LCBwYXR0ZXJuKTsNCj4gKyAgICAgICAg
fQ0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIGdldHRpbWVvZmRheSgmdDEsIE5VTEwpOw0KPiAN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

