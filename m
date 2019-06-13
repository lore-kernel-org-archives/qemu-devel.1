Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14485C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D738F2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CWR9bdNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D738F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMr1-0002rO-70
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMcX-0002dy-Nr
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMcW-00045b-C8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:06:13 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:53983 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMcT-00042C-A2; Thu, 13 Jun 2019 06:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTLotgG9kYP6PTfpi5AVJ5TM8jcBmOggdgZwC5ITsWk=;
 b=CWR9bdNrmtALH/Ja7n1AMe0rNwQ0azq7ZoTaVVrv0W2L6XRqdUJXSbSiYr1/HyEpfd297FwMkPRK4AYTMe+1mpCf7dqaF0DBzKIK4ls2XJRzFNyaqdvG6ZOMdy7Q0h389iOJZi7YLH07fEFX0ZNffe1P3PLiq0NgcBvZerQNiGc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4563.eurprd08.prod.outlook.com (20.178.202.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 10:06:05 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 10:06:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 7/7] iotests: new file to suppress Valgrind errors
Thread-Index: AQHVIH/XyPCLZiW8PEGiqni4o746saaZXjeA
Date: Thu, 13 Jun 2019 10:06:05 +0000
Message-ID: <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613130603615
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d842f9-96c0-444e-49b0-08d6efe6bfa0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4563; 
x-ms-traffictypediagnostic: AM0PR08MB4563:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB4563383F4AA5293E38267024C1EF0@AM0PR08MB4563.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(366004)(396003)(136003)(189003)(199004)(66476007)(64756008)(66556008)(73956011)(66446008)(66946007)(86362001)(2501003)(31696002)(2201001)(99286004)(6116002)(3846002)(2906002)(186003)(7736002)(305945005)(52116002)(76176011)(81156014)(8676002)(81166006)(26005)(8936002)(102836004)(6506007)(386003)(66066001)(229853002)(316002)(2616005)(11346002)(476003)(446003)(486006)(4326008)(6246003)(71200400001)(71190400001)(478600001)(6436002)(6486002)(68736007)(14454004)(110136005)(54906003)(6512007)(31686004)(25786009)(5660300002)(36756003)(6306002)(53936002)(14444005)(256004)(107886003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4563;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HvpndVMZhw9Fzgi4X03xtS1UI2MYdS5njl2yfLid6H+/tDh5GJXiYPhGCbexo5w4R5Wr/Sq4xPiBHnt3D5F2Kd6UpATiLcBKMqLA0jTalPSmaJRiJ+AvkBA17jw6hUJ3/8j5KRtCRnIvAG/BTnC29wBYEwNhe5Inhwa1yzgwbYKxkugRXo/5dMqeRGF6Q17+x9mSgy8iziSlcjhj8xmEcEbGVN7QSNTiZfgDt9zRcGoMfmiGQV2/1B2tsGObfya0O7ywWa1szl6LpJUVfFnS6wnjI6KD7LqN0cc/hg6N95wGTlzJcG2wfLAuRsXMnGc1IY1SoxWikZUvSmsRWMurSLdhMM30qPjRceL0X2UC6OhK1BayYaSbycLqUWHF/4LnXITIos6re84hvU6mA4SqQfoQaChCQ3fcKcdsrXon/2A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE8D139E8260F144B35625099E906048@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d842f9-96c0-444e-49b0-08d6efe6bfa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:06:05.8561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4563
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.123
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBWYWxncmlu
ZCB0b29sIHJlcG9ydHMgYWJvdXQgYW4gdW5pbml0aWFsaXNlZCBtZW1vcnkgdXNhZ2Ugd2hlbiB0
aGUNCj4gaW5pdGlhbGl6YXRpb24gaXMgYWN0dWFsbHkgbm90IG5lZWRlZC4gRm9yIGV4YW1wbGUs
IHRoZSBidWZmZXIgJ2J1ZicNCj4gaW5zdGFudGlhdGVkIG9uIGEgc3RhY2sgb2YgdGhlIGZ1bmN0
aW9uIGd1ZXNzX2Rpc2tfbGNocygpLg0KDQpmb3IgY29udmluaWVuY2UsIHlvdSBtYXkgYWRkOiAi
b2YgdGhlIGZ1bmN0aW9uIGd1ZXNzX2Rpc2tfbGNocygpLCB3aGljaA0KaXMgdGhlbiBhY3R1YWxs
eSBpbml0aWFsaXplZCBieSBibGtfcHJlYWRfdW50aHJvdHRsZWQoKSINCg0KPiBMZXQncyB1c2Ug
dGhlIFZhbGdyaW5kIHRlY2hub2xvZ3kgdG8gc3VwcHJlc3MgdGhlIHVud2FudGVkIHJlcG9ydHMg
YnkNCj4gYWRkaW5nIHRoZSBWYWxncmluZCBzcGVjaWZpYyBmb3JtYXQgZmlsZSB2YWxncmluZC5z
dXBwIHRvIHRoZSBRRU1VDQo+IHByb2plY3QuIFRoZSBmaWxlIGNvbnRlbnQgaXMgZXh0ZW5kYWJs
ZSBmb3IgZnV0dXJlIG5lZWRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZp
Y2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy9jb21tb24ucmMgICAgIHwgIDUgKysrKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVz
dHMvdmFsZ3JpbmQuc3VwcCB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcWVtdS1pb3Rlc3RzL3ZhbGdyaW5kLnN1cHANCj4gDQo+
IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjIGIvdGVzdHMvcWVtdS1p
b3Rlc3RzL2NvbW1vbi5yYw0KPiBpbmRleCAzY2FhY2E0Li45Yjc0ODkwIDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy9jb21tb24ucmMNCj4gQEAgLTE3LDYgKzE3LDggQEANCj4gICAjIGFsb25nIHdpdGggdGhpcyBw
cm9ncmFtLiAgSWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPiAg
ICMNCj4gICANCj4gK3JlYWRvbmx5IFZBTEdSSU5EX1NVUFBSRVNTX0VSUk9SUz0uL3ZhbGdyaW5k
LnN1cHANCg0KV2h5IHJlYWRvbmx5Pw0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSBkZWZpbmVkIG5l
YXIgYW5kIGluIHNhbWUgbWFubmVyIGFzIFZBTEdSSU5EX0xPR0ZJTEUsDQp3aXRoIHVzZSBvZiBU
RVNUX0RJUg0KDQo+ICsNCj4gICBTRUQ9DQo+ICAgZm9yIHNlZCBpbiBzZWQgZ3NlZDsgZG8NCj4g
ICAgICAgKCRzZWQgLS12ZXJzaW9uIHwgZ3JlcCAnR05VIHNlZCcpID4gL2Rldi9udWxsIDI+JjEN
Cj4gQEAgLTY1LDcgKzY3LDggQEAgX3FlbXVfcHJvY193cmFwcGVyKCkNCj4gICAgICAgbG9jYWwg
VkFMR1JJTkRfTE9HRklMRT0iJDEiDQo+ICAgICAgIHNoaWZ0DQo+ICAgICAgIGlmIFsgIiR7VkFM
R1JJTkRfUUVNVX0iID09ICJ5IiBdOyB0aGVuDQo+IC0gICAgICAgIGV4ZWMgdmFsZ3JpbmQgLS1s
b2ctZmlsZT0iJHtWQUxHUklORF9MT0dGSUxFfSIgLS1lcnJvci1leGl0Y29kZT05OSAiJEAiDQo+
ICsgICAgICAgIGV4ZWMgdmFsZ3JpbmQgLS1sb2ctZmlsZT0iJHtWQUxHUklORF9MT0dGSUxFfSIg
LS1lcnJvci1leGl0Y29kZT05OSBcDQo+ICsgICAgICAgICAgICAtLXN1cHByZXNzaW9ucz0iJHtW
QUxHUklORF9TVVBQUkVTU19FUlJPUlN9IiAiJEAiDQo+ICAgICAgIGVsc2UNCj4gICAgICAgICAg
IGV4ZWMgIiRAIg0KPiAgICAgICBmaQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
L3ZhbGdyaW5kLnN1cHAgYi90ZXN0cy9xZW11LWlvdGVzdHMvdmFsZ3JpbmQuc3VwcA0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi43ODIxNWI2DQo+IC0tLSAvZGV2L251
bGwNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL3ZhbGdyaW5kLnN1cHANCj4gQEAgLTAsMCAr
MSwzMSBAQA0KPiArIw0KPiArIyBWYWxncmluZCBlcnJvcnMgc3VwcHJlc3Npb24gZmlsZSBmb3Ig
UUVNVSBpb3Rlc3RzDQo+ICsjDQo+ICsjIENvcHlyaWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50
ZXJuYXRpb25hbCBHbWJIDQo+ICsjDQo+ICsjIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+ICsjIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
DQo+ICsjIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yDQo+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
DQo+ICsjDQo+ICsjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLA0KPiArIyBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPiArIyBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+ICsjIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ICsjDQo+ICsjIFlvdSBzaG91
bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
DQo+ICsjIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiAgSWYgbm90LCBzZWUgPGh0dHA6Ly93d3cu
Z251Lm9yZy9saWNlbnNlcy8+Lg0KPiArIw0KPiArew0KPiArICAgaHcvYmxvY2svaGQtZ2VvbWV0
cnkuYw0KPiArICAgTWVtY2hlY2s6Q29uZA0KPiArICAgZnVuOmd1ZXNzX2Rpc2tfbGNocw0KPiAr
ICAgZnVuOmhkX2dlb21ldHJ5X2d1ZXNzDQo+ICsgICBmdW46YmxrY29uZl9nZW9tZXRyeQ0KPiAr
ICAgLi4uDQo+ICsgICBmdW46ZGV2aWNlX3NldF9yZWFsaXplZA0KPiArICAgZnVuOnByb3BlcnR5
X3NldF9ib29sDQo+ICsgICBmdW46b2JqZWN0X3Byb3BlcnR5X3NldA0KPiArICAgZnVuOm9iamVj
dF9wcm9wZXJ0eV9zZXRfcW9iamVjdA0KPiArICAgZnVuOm9iamVjdF9wcm9wZXJ0eV9zZXRfYm9v
bA0KPiArfQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

