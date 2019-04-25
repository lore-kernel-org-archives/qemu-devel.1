Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44405C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BFC2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BY4p2eJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BFC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhAD-0007Hk-A3
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:23:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hJh3q-0002M3-VQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hJh3p-0001k3-0n
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:22 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
	([40.107.8.102]:13939
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hJh3n-0001ex-0h
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VSW6k7DLq0RrbPd/E67Ba2dV9VZy2wYOGsJvW4zfDmw=;
	b=BY4p2eJk/mbofMuyTqWN5kwaY1VjcfP3sLsf2QS0nTq0eKtXL9eT8uYaB1y0/4CBtDTYLrNJlnybB1ICtgSjJ+SVlAwL0r84F+U3zdnfrsfPtvLVog+ApAqs/GaASr7vgPvH8UmkiGZddw9lRtV1LGjMiHHlukSGU/bfDB9CwwI=
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com (10.255.99.74) by
	AM6PR08MB3526.eurprd08.prod.outlook.com (20.177.115.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Thu, 25 Apr 2019 16:17:14 +0000
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::81c5:a78f:cc78:a732]) by
	AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::81c5:a78f:cc78:a732%4]) with mapi id 15.20.1835.010;
	Thu, 25 Apr 2019 16:17:14 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com"
	<quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>
Thread-Topic: [PING PING PING] [PATCH 0/3] migration: add sztd compression
Thread-Index: AQHU+4JXRu2dOoVnz0KceGyz+ZPMbQ==
Date: Thu, 25 Apr 2019 16:17:13 +0000
Message-ID: <6955ecd7-7573-99a7-db0a-6f6afe86370f@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
	<8ef4ffa2-6c59-a6dd-e2bd-97b6fea7a5d1@virtuozzo.com>
	<7abd40bc-963b-cf61-14e8-4c4187813c5c@virtuozzo.com>
	<5c342066-30b6-e492-e23a-cb5accbfb11a@virtuozzo.com>
	<53b5c677-870e-56a0-402d-7fdc985ec3f5@virtuozzo.com>
	<4b9f5045-d4b2-fa10-ab8a-39eaf6ed220c@virtuozzo.com>
In-Reply-To: <4b9f5045-d4b2-fa10-ab8a-39eaf6ed220c@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0044.eurprd09.prod.outlook.com
	(2603:10a6:7:15::33) To AM6PR08MB4899.eurprd08.prod.outlook.com
	(2603:10a6:20b:ce::10)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59b04527-c73e-4de7-6266-08d6c99979ca
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3526; 
x-ms-traffictypediagnostic: AM6PR08MB3526:
x-microsoft-antispam-prvs: <AM6PR08MB3526969A864D2499D97A1B74CF3D0@AM6PR08MB3526.eurprd08.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(71200400001)(71190400001)(6512007)(5660300002)(36756003)(6436002)(478600001)(2501003)(8936002)(31686004)(476003)(316002)(54906003)(110136005)(486006)(2616005)(14454004)(256004)(446003)(97736004)(11346002)(99286004)(2201001)(8676002)(81156014)(66446008)(64756008)(66556008)(66476007)(26005)(86362001)(66946007)(93886005)(73956011)(81166006)(68736007)(229853002)(25786009)(7736002)(31696002)(6486002)(4326008)(52116002)(53546011)(102836004)(2906002)(6116002)(3846002)(66066001)(305945005)(386003)(6506007)(76176011)(53936002)(6246003)(186003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3526;
	H:AM6PR08MB4899.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JfFAB7AUDL5jIaUq6XY1XW+1TR9AxLIK0Mhe2E2Sdzp5NK5euHYwYxv4X4uXKb3SJPGq6Y7zdQ+mVrJ/izHOdcLkSlfw5jpW2nwRkVXsWlcKU+8S4b7rDNNK/x1LNuexNfyrqDIGYRJEoCzdrxT9fpMsWfx3hmy/M8KFiW2/12pL29QJIPxILlwYGup7+ubzKN7yy+9FvJVspr/cYiXblDDrzoRY+4U7obmATdUw2LtoeSkQjzQWOrX+xJnO0cl6f5uzPt/IzkPUZ9IFuUi4O6aqKcido6/DxGB+OKagoFUTWuRaTFqcWXTACtxQfEmdERsWTTiFeL2QxzmpLqTAni+FvgAJ+5b9yHO9kGg49+nujvzxsi/4cxZkonO3wifTcxuwooyGdsDapowqZD+v6axPf97ulmcYQEsbVZRlEt4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <FBEA6144B12EE447AC10AC984882D74A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b04527-c73e-4de7-6266-08d6c99979ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 16:17:13.8115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3526
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.102
Subject: Re: [Qemu-devel] [PING PING PING] [PATCH 0/3] migration: add sztd
 compression
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
Message-ID: <20190425161713.mqutAj5gGShIaNHHTUhSVdyEVitBCYOkdyrpjXIkL3g@z>

DQoNCk9uIDA1LjA0LjIwMTkgMTQ6NDAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4gcGluZyEN
Cj4gDQo+IE9uIDI2LjAzLjIwMTkgMTg6NTEsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+IHBp
bmcgcGluZyBwaW5nIHBpbmcgcGluZyENCj4+DQo+PiBPbiAxOC4wMy4yMDE5IDEwOjUzLCBEZW5p
cyBQbG90bmlrb3Ygd3JvdGU6DQo+Pj4gcGluZyBwaW5nIHBpbmcgcGluZyENCj4+Pg0KPj4+IE9u
IDExLjAzLjIwMTkgMTE6MjAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+Pj4gcGluZyBwaW5n
IHBpbmchDQo+Pj4+DQo+Pj4+IE9uIDA0LjAzLjIwMTkgMTg6MTAsIERlbmlzIFBsb3RuaWtvdiB3
cm90ZToNCj4+Pj4+IHBpbmchDQo+Pj4+Pg0KPj4+Pj4gT24gMjYuMDIuMjAxOSAxNjoxNSwgRGVu
aXMgUGxvdG5pa292IHdyb3RlOg0KPj4+Pj4+IHpzdGQgZGF0ZSBjb21wcmVzc2lvbiBhbGdvcml0
aG0gc2hvd3MgYmV0dGVyIHBlcmZvcm1hbmNlIG9uIGRhdGEgDQo+Pj4+Pj4gY29tcHJlc3Npb24u
DQo+Pj4+Pj4gSXQgbWlnaHQgYmUgdXNlZnVsIHRvIGVtcGxveSB0aGUgYWxnb3JpdGhtIGluIFZN
IG1pZ3JhdGlvbiB0byANCj4+Pj4+PiByZWR1Y2UgQ1BVIHVzYWdlLg0KPj4+Pj4+IEEgdXNlciB3
aWxsIGJlIGFibGUgdG8gY2hvb3NlIGJldHdlZW4gdGhvc2UgYWxnb3JpdGhtcywgdGhlcmVmb3Ig
DQo+Pj4+Pj4gY29tcHJlc3MtdHlwZQ0KPj4+Pj4+IG1pZ3JhdGlvbiBwYXJhbWV0ZXIgaXMgYWRk
ZWQuDQo+Pj4+Pj4NCj4+Pj4+PiBIZXJlIGFyZSBzb21lIHJlc3VsdHMgb2YgcGVyZm9ybWFuY2Ug
Y29tcGFyaXNvbiB6c3RkIHZzIGd6aXA6DQo+Pj4+Pj4NCj4+Pj4+PiBob3N0OiBpNy00NzkwIDh4
Q1BVIEAgMy42MEdIeiwgMTZHIFJBTQ0KPj4+Pj4+IG1pZ3JhdGlvbiB0byB0aGUgc2FtZSBob3N0
DQo+Pj4+Pj4gVk06IDJ4VkNQVSwgOEcgUkFNIHRvdGFsDQo+Pj4+Pj4gNUcgUkFNIHVzZWQsIG1l
bW9yeSBwb3B1bGF0ZWQgd2l0aCBwb3N0Z3JlcXNsIGRhdGENCj4+Pj4+PiBwcm9kdWNlZCBieSBw
Z2JlbmNoIHBlcmZvcm1hbmNlIGJlbmNobWFyaw0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBUaHJl
YWRzOiAxIGNvbXByZXNzIOKAkyAxIGRlY29tcHJlc3MNCj4+Pj4+Pg0KPj4+Pj4+IHpzdGQgcHJv
dmlkZXMgc2xpZ2h0bHkgbGVzcyBjb21wcmVzc2lvbiByYXRpbyB3aXRoIGFsbW9zdCB0aGUgc2Ft
ZQ0KPj4+Pj4+IENQVSB1c2FnZSBidXQgY29wZXMgd2l0aCBSQU3CoCBjb21wcmVzc2lvbiByb2do
bHkgMiB0aW1lcyBmYXN0ZXINCj4+Pj4+Pg0KPj4+Pj4+IGNvbXByZXNzaW9uIHR5cGXCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB6bGliwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIHpzdGQNCj4+
Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+Pj4+PiBjb21wcmVzc2lvbiBsZXZlbMKgwqDCoMKgwqDCoMKgwqDCoCAxwqDCoMKg
wqDCoMKgIDXCoMKgwqDCoCB8wqDCoCAxwqDCoMKgwqDCoMKgIDUNCj4+Pj4+PiBjb21wcmVzc2lv
biByYXRpb8KgwqDCoMKgwqDCoMKgwqDCoCA2LjkywqDCoMKgIDcuMDXCoCB8wqDCoCA2LjY5wqDC
oMKgIDYuODkNCj4+Pj4+PiBjcHUgaWRsZSwgJcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA4MsKgwqDCoMKgwqAgODPCoMKgwqAgfMKgwqAgODbCoMKgwqDCoMKgIDgwDQo+Pj4+Pj4gdGlt
ZSwgc2VjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0OcKgwqDCoMKgwqAgNzHC
oMKgwqAgfMKgwqAgMjbCoMKgwqDCoMKgIDMxDQo+Pj4+Pj4gdGltZSBkaWZmIHRvIHpsaWIsIHNl
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtMjXCoMKgwqDCoCAt
NDENCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gVGhyZWFkczogOCBjb21wcmVzcyDigJMgMiBkZWNv
bXByZXNzDQo+Pj4+Pj4NCj4+Pj4+PiB6c3RkIHByb3ZpZGVzIHRoZSBzYW1lIG1pZ3JhdGlvbiB0
aW1lIHdpdGggbGVzcyBjcHUgY29uc3VtcHRpb24NCj4+Pj4+Pg0KPj4+Pj4+IGNvbXByZXNzaW9u
IHR5cGXCoMKgwqDCoMKgwqDCoMKgIG5vbmXCoCB8wqDCoMKgwqDCoMKgwqAgZ3ppcCh6bGliKcKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgIHpzdGQNCj4+Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gDQo+Pj4+Pj4NCj4+Pj4+PiBjb21wcmVzc2lvbiBsZXZlbMKgwqDCoMKgwqDCoMKgIC3CoMKg
wqDCoCB8wqAgMcKgwqDCoMKgwqAgNcKgwqDCoMKgwqDCoCA5wqDCoMKgIHzCoMKgIDEgICAgICAg
DQo+Pj4+Pj4gNcKgwqDCoMKgwqDCoCAxNQ0KPj4+Pj4+IGNvbXByZXNzaW9uIHJhdGlvwqDCoMKg
wqDCoMKgwqAgLcKgwqDCoMKgIHzCoCA2Ljk0wqDCoCA2Ljk5wqDCoMKgIDcuMTQgfMKgwqAgNi42
NCAgICANCj4+Pj4+PiA2Ljg5wqDCoMKgIDYuOTMNCj4+Pj4+PiB0aW1lLCBzZWPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMTU0wqDCoCB8wqAgMjLCoMKgwqDCoCAyM8KgwqDCoMKgwqAg
MjfCoMKgIHzCoMKgIDIzICAgICAgDQo+Pj4+Pj4gMjPCoMKgwqDCoMKgIDI1DQo+Pj4+Pj4gY3B1
IGlkbGUsICXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA5OcKgwqDCoCB8wqAgNDXCoMKgwqDC
oCAzMMKgwqDCoMKgwqAgMTLCoMKgIHzCoMKgIDcwICAgICAgDQo+Pj4+Pj4gNTLCoMKgwqDCoMKg
IDIzDQo+Pj4+Pj4gY3B1IGlkbGUgZGlmZiB0byB6bGliwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIC0yNSUgICAgDQo+Pj4+
Pj4gLTIyJcKgwqDCoCAtMTElDQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IERlbmlzIFBsb3RuaWtv
diAoMyk6DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIG1pZ3JhdGlvbjogcmV3b3JrIGNvbXByZXNzaW9u
IGNvZGUgZm9yIGFkZGluZyBtb3JlIGRhdGEgDQo+Pj4+Pj4gY29tcHJlc3NvcnMNCj4+Pj4+PiDC
oMKgwqDCoMKgwqAgaG1wOiBhZGQgY29tcHJlc3MtdHlwZSBwYXJhbWV0ZXIgdG8gbWlncmF0aW9u
IHBhcmFtZXRlcnMNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgbWlncmF0aW9uOiBhZGQgenN0ZCBjb21w
cmVzc2lvbg0KPj4+Pj4+DQo+Pj4+Pj4gwqDCoMKgwqDCoCBjb25maWd1cmXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDI2ICsrKysNCj4+Pj4+PiDCoMKgwqDCoMKgIGhtcC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArKw0KPj4+Pj4+IMKgwqDCoMKgwqAgbWln
cmF0aW9uL21pZ3JhdGlvbi5jIHzCoCA0NSArKysrKystDQo+Pj4+Pj4gwqDCoMKgwqDCoCBtaWdy
YXRpb24vbWlncmF0aW9uLmggfMKgwqAgMSArDQo+Pj4+Pj4gwqDCoMKgwqDCoCBtaWdyYXRpb24v
cWVtdS1maWxlLmMgfMKgIDM5ICsrLS0tLQ0KPj4+Pj4+IMKgwqDCoMKgwqAgbWlncmF0aW9uL3Fl
bXUtZmlsZS5oIHzCoCAxOCArKy0NCj4+Pj4+PiDCoMKgwqDCoMKgIG1pZ3JhdGlvbi9yYW0uY8Kg
wqDCoMKgwqDCoCB8IDI5MSANCj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0NCj4+Pj4+PiDCoMKgwqDCoMKgIHFhcGkvbWlncmF0aW9uLmpzb27CoMKgIHzC
oCAyNiArKystDQo+Pj4+Pj4gwqDCoMKgwqDCoCA4IGZpbGVzIGNoYW5nZWQsIDM2OSBpbnNlcnRp
b25zKCspLCA4NSBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pg0KPj4NCj4g
DQoNCi0tIA0KQmVzdCwNCkRlbmlzDQo=

