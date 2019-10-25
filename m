Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7949221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BouItJaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7949221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyqh-0004l2-Dl
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNylM-0002VD-1M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNylK-0003CK-Hv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:32:15 -0400
Received: from mail-am5eur02on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::705]:38660
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNylJ-0003BI-Pd; Fri, 25 Oct 2019 08:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR/Tp3cg9uGW+cxKwt9ouV0NUaMqFvtpthCp+YHbHu+uziXKfJ5+IxvXcAelueIJSc46XBWwOh+22Uh1XPupIzugI/RJbApaZ1Ivk+qjVnfjLYKK0AFTo4pnfoGygBv7LjXokvXqBACMBc9CpfBam1isiIyfW9GEDExBuY48XHf5qbgHEIyc0aFcfuSQ5hSI2xKEzD29/StX7lmD4qOx94jLUjC0e8c9OoaJbDp4pd14DiOR9yDHoz7er6AcMBupfhjiBXscbv56ytRNfl12TNvi+lHtY0qmtsOSVbc3n+rcHdZT4SXE1c+jA2wY4YPP2ekHGJu8MDgsQv0IBNEFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ/8zxWR8ekm66POkXuC4NVv8A6wvwOyTsisQTkbvVk=;
 b=iz4ZcF+tn80yU19r9CnYhL/HK2CJC8TbLNnwkSckBO+X8arH29Hvbj2jKtdtXOkUXBrKUoxkMKsLSUR5pNkR5MuSWnALoOy98tWx80M4qvFnSepIcCfKzwawx+QhG5OizyQsFeUDA+X3Z2MMGncgqfLkuiUeddvZM2mXQmAqWMvZnqWJoHeYPFfP7EItfttmFlWnSS/7RdPG1mYGxkSyi+I/mnsg2q4x7yPI3fh2IWQOrf7Tn6XagzFfEwUNc0lwdSD+LjZRfA4lAcdSeMlD4X6d6fFjhpbAiDpE5PVqee8n9Qnqb1Y13QHKz1Ri68pGHyNnszulG5g8iifpIy+Gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ/8zxWR8ekm66POkXuC4NVv8A6wvwOyTsisQTkbvVk=;
 b=BouItJaHszFjq+W3LKUq5w3MWtg03PuMs3W6loYKPczpW277Rz6Qxed1FGb2CHDIr2rrXwrMJ21JQRAcz1dd+S3+O3UpEG8grpTqdF1Cm3DtgWqH0dpcf9P+R2FgulWbdRbn7XlvxAWpy5uDI/6tEio1gNgKbSTnkuqBi8QZBL8=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5460.eurprd08.prod.outlook.com (52.132.214.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 12:32:11 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.029; Fri, 25 Oct 2019
 12:32:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 0/6] block-copy: memory limit
Thread-Topic: [PATCH v3 0/6] block-copy: memory limit
Thread-Index: AQHViMplMiHceFM7pkqvcNumK960y6drTo0AgAAASgA=
Date: Fri, 25 Oct 2019 12:32:11 +0000
Message-ID: <76222181-10a5-a9ed-3a01-445821838320@virtuozzo.com>
References: <20191022111805.3432-1-vsementsov@virtuozzo.com>
 <06c576de-91f4-69ab-5962-53f2ba9930e3@redhat.com>
In-Reply-To: <06c576de-91f4-69ab-5962-53f2ba9930e3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191025153206743
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb0048fa-d0f6-4c4b-6487-08d759475b9c
x-ms-traffictypediagnostic: AM0PR08MB5460:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB546063445385012228AEE767C1650@AM0PR08MB5460.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(346002)(39840400004)(136003)(199004)(189003)(305945005)(966005)(186003)(6436002)(36756003)(71190400001)(8676002)(25786009)(2616005)(8936002)(4326008)(7736002)(486006)(71200400001)(476003)(86362001)(11346002)(31696002)(446003)(81156014)(31686004)(81166006)(66066001)(107886003)(6246003)(229853002)(53546011)(386003)(64756008)(6506007)(66946007)(6306002)(6512007)(76176011)(2906002)(478600001)(6116002)(52116002)(316002)(3846002)(66476007)(66446008)(66556008)(99286004)(5660300002)(14454004)(256004)(54906003)(26005)(14444005)(110136005)(6486002)(102836004)(2501003)(116466001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5460;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9uoswyrLGlZI3znKY62JhsMVAss+VwJblMXprM8YsNDIiKma70OaecsnLIQCdKRTNtq6YG8sTyPyMhMFsf82lXt34IVpFj6mC75QyLnZzVhlakq8uWG2HSc3kqOdvskk3d/cCBhaCJdHa3Cxy4Sa3oE9rCyXCu+7jnRpjb5coIjeWVD1MzlRNF2CEhYHml6Zfszwx11XkKHnOI4NVn5qtz3ZCjXGqbRgkoGbnW/yGvkGhNZWlFNnGeOcwdEYpWtEdnO/jDzQcTOw5/DCN+D6tIz+c1HXVRNFs4ROhSR8+isbawLLRlfw2LGx0JWzm6qtL7nnfthU5FI7MON+UH2wncOvxlS58zPScufIi02Wc4nF/IgDc6yK7Wa3sEIu4YosZW2VZ5Lowb8Zldul+HmbdXkUR/lXoBL6duW4Iorpu6Ag1MCbfLJN16t6N/rC9QU2HlUYl/1igLvijjW4Z7y618BnnkOrNrtkGQyChQcDLU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53975B6AA499140A13B15B69384F169@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0048fa-d0f6-4c4b-6487-08d759475b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 12:32:11.2389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPXXcmdnNr6eKiuDL6IhkdePPv0+Plbtzc51cotA2+1nVVxrXSjfIxxDxNc+jA7mjJMkEbhtKr2bHpBj5DsSQ82CUe1xwQ4Pfk0jMgd5IgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5460
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::705
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

MjUuMTAuMjAxOSAxNTozMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMi4xMC4xOSAxMzoxNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEknbSBnb2luZyB0byBicmlu
ZyBibG9jay1zdGF0dXMgZHJpdmVuLCBhc3luYyBjb3B5aW5nIHByb2Nlc3MgdG8NCj4+IGJsb2Nr
LWNvcHksIHRvIG1ha2UgaXQgZmFzdC4gVGhlIGZpcnN0IHN0ZXAgaXMgdG8gbGltaXQgbWVtb3J5
IHVzYWdlIG9mDQo+PiBiYWNrdXAsIGhlcmUgaXMgaXQuDQo+Pg0KPj4gdjM6DQo+PiAwMzogYWRk
IE1heCdzIHItYg0KPj4gMDQ6IGZpeCBjb21taXQgbWVzc2FnZSBhbmQgaW5jbHVkZSBndWFyZHMs
IGFkZCBNYXgncyByLWINCj4+IDA1LTA2OiBhZGQgTWF4J3Mgci1iDQo+Pg0KPj4gdjI6IFttb3N0
bHkgYnkgTWF4J3MgY29tbWVudHNdDQo+PiBOb3cgYmFzZWQgb24gbWFzdGVyIChUaGFuayB5b3Ug
TWF4ISkNCj4+IDAxOiBhZGQgTWF4J3Mgci1iDQo+PiAwMjogYWRkIE1heCdzIHItYg0KPj4gMDM6
IC0gcmVmYWN0b3IgYmxvY2tfY29weV9kb19jb3B5IGdvdG8vcmV0dXJuDQo+PiAgICAgIC0gYWRk
IHNtYWxsIGNvbW1lbnQgdG8gYmxvY2tfY29weV9kb19jb3B5DQo+PiAwNDogLSBhIGxvdCBvZiBy
ZW5hbWluZyBhbmQgd29yZGluZyBmaXhlcw0KPj4gICAgICAtIHJlZmFjdG9yIHRvIHVzZSAiYXZh
aWxhYmxlIiBpbnN0ZWFkIG9mICJ0YWtlbiINCj4+ICAgICAgLSByZWZhY3RvciBjb19nZXRfZnJv
bV9zaHJlcw0KPj4gMDU6IHJlYmFzZSBvbiAwNCBjaGFuZ2VzDQo+PiAwNjogZHJvcCBleHRyYSB0
aGluZ3MgZnJvbSBtYXhfdHJhbnNmZXIgY2FsY3VsYXRpb24NCj4+DQo+PiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5ICg2KToNCj4+ICAgIGJsb2NrL2Jsb2NrLWNvcHk6IGFsbG9jYXRlIGJ1
ZmZlciBpbiBibG9ja19jb3B5X3dpdGhfYm91bmNlX2J1ZmZlcg0KPj4gICAgYmxvY2svYmxvY2st
Y29weTogbGltaXQgY29weV9yYW5nZV9zaXplIHRvIDE2IE1pQg0KPj4gICAgYmxvY2svYmxvY2st
Y29weTogcmVmYWN0b3IgY29weWluZw0KPj4gICAgdXRpbDogaW50cm9kdWNlIFNoYXJlZFJlc291
cmNlDQo+PiAgICBibG9jay9ibG9jay1jb3B5OiBhZGQgbWVtb3J5IGxpbWl0DQo+PiAgICBibG9j
ay9ibG9jay1jb3B5OiBpbmNyZWFzZSBidWZmZXJlZCBjb3B5IHJlcXVlc3QNCj4+DQo+PiAgIGlu
Y2x1ZGUvYmxvY2svYmxvY2stY29weS5oICAgICAgICB8ICAgNSArLQ0KPj4gICBpbmNsdWRlL3Fl
bXUvY28tc2hhcmVkLXJlc291cmNlLmggfCAgNzEgKysrKysrKysrKysrDQo+PiAgIGJsb2NrL2Js
b2NrLWNvcHkuYyAgICAgICAgICAgICAgICB8IDE4MiArKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0NCj4+ICAgdXRpbC9xZW11LWNvLXNoYXJlZC1yZXNvdXJjZS5jICAgIHwgIDc2ICsrKysr
KysrKysrKysNCj4+ICAgYmxvY2svdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgIHwgICA2ICst
DQo+PiAgIHV0aWwvTWFrZWZpbGUub2JqcyAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIDYg
ZmlsZXMgY2hhbmdlZCwgMjQ5IGluc2VydGlvbnMoKyksIDkyIGRlbGV0aW9ucygtKQ0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9xZW11L2NvLXNoYXJlZC1yZXNvdXJjZS5oDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL3FlbXUtY28tc2hhcmVkLXJlc291cmNlLmMNCj4gDQo+
IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9jayBicmFuY2g6DQo+IA0KPiBodHRwczovL2dpdC54
YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gvYmxvY2sNCj4gDQo+IE1heA0K
PiANCg0KVGhhbmsgeW91IE1heCENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

