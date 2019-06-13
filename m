Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94FC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597302173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qm7rzPaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597302173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMRP-0001fn-Bm
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMKb-0003qc-Pm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMKZ-00086T-Hs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:47:41 -0400
Received: from mail-eopbgr150113.outbound.protection.outlook.com
 ([40.107.15.113]:6678 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMKP-0007zM-7W; Thu, 13 Jun 2019 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vc2/jpV1tvXVPifsBNADCsIrVBCmrKvi7X7KOyegEs=;
 b=Qm7rzPazMberS/wSDGGhrLCvlvqVfNlh//HPknkizmFFIx5XHoe+9A+Y2b3cKNKHq3Jwqf7TO/cbGiGGuZH6skatzrE2ta1sa0TMNPmZ1KPK0acYjBCxoqTeOHjl/UHWD1cpS91uQAg9go8aMVolqYXn10II+/kRSfdY1p/qItg=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4049.eurprd08.prod.outlook.com (20.178.119.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 09:47:21 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:47:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 2/7] iotests: exclude killed processes from running
 under Valgrind
Thread-Index: AQHVIH/WAy1FhWD1FEuxS5KUQHYpx6aZWPoA
Date: Thu, 13 Jun 2019 09:47:21 +0000
Message-ID: <3bd93c9c-6f8e-d982-1c60-0cd8b5a9ec51@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0069.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::13) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613124718524
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51a6db07-e73d-4605-c536-08d6efe42122
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4049; 
x-ms-traffictypediagnostic: AM0PR08MB4049:
x-microsoft-antispam-prvs: <AM0PR08MB40494D0480515A82CED5AC7AC1EF0@AM0PR08MB4049.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39850400004)(136003)(366004)(346002)(199004)(189003)(2616005)(6512007)(6246003)(107886003)(71190400001)(256004)(11346002)(4326008)(53936002)(36756003)(71200400001)(486006)(5660300002)(86362001)(14444005)(229853002)(6436002)(446003)(6486002)(25786009)(31686004)(76176011)(386003)(54906003)(2501003)(99286004)(6506007)(26005)(316002)(476003)(102836004)(52116002)(2906002)(3846002)(14454004)(68736007)(110136005)(73956011)(64756008)(66946007)(6116002)(186003)(478600001)(81156014)(31696002)(81166006)(66446008)(7736002)(2201001)(66066001)(8676002)(66556008)(66476007)(8936002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4049;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n7oUsqUXlKCn5GV0c//6E3EdtiUE8MjWlN/1cTJlBCrDsKoi/A91P2AJ5N9/afqZQHvk+NwEVe9ZyIB7msjrJ1BYuA15NO3Bhl9MelaPcdja2C6R8dEV5qMP0PNse02vLN0Wmp2scsoEuQsBMCgdDxCzg6h+Q1gFyziL/J6teS3jOJmS0VNhcYnCBd84eQQPemN9C0/NS3yK9ehshU4VXwGdGt/dgAwl3NpFWN33JBv0wc9SFGTj+QIFb/Yqz9zGNiXtyaT7KaLX1ZtOZLU5XkSgLJ5bZj6uJVh2kzHJoXAEyVu1zIV5X5pPsTbqBKMnyioZn/fILP6FSCkcjoO0xgxqHP0dz1APJ4W7FPzkoJHjgX061XFtwBQe+9cUkLP9bmqJYzuTF10Z6E9uBAOvz8xLdTI9/chrGz0ZYPHOBg4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4281567AEEDC1C47B88AA157FCE13E87@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a6db07-e73d-4605-c536-08d6efe42122
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:47:21.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4049
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.113
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iotests: exclude killed processes
 from running under Valgrind
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
ZCB0b29sIGZhaWxzIHRvIG1hbmFnZSBpdHMgdGVybWluYXRpb24gd2hlbiBRRU1VIHJhaXNlcyB0
aGUNCj4gc2lnbmFsIFNJR0tJTEwuIExldHMgZXhjbHVkZSBzdWNoIHRlc3QgY2FzZXMgZnJvbSBy
dW5uaW5nIHVuZGVyIHRoZQ0KPiBWYWxncmluZCBiZWNhdXNlIHRoZXJlIGlzIG5vIHNlbnNlIHRv
IGNoZWNrIG1lbW9yeSBpc3N1ZXMgdGhhdCB3YXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzAzOSB8IDUgKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVz
dHMvMDYxIHwgMiArKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8xMzcgfCAxICsNCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8wMzkgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDM5DQo+IGluZGV4IDBkNGU5NjMu
Ljk1MTE1ZTIgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wMzkNCj4gKysrIGIv
dGVzdHMvcWVtdS1pb3Rlc3RzLzAzOQ0KPiBAQCAtNjUsNiArNjUsNyBAQCBlY2hvICI9PSBDcmVh
dGluZyBhIGRpcnR5IGltYWdlIGZpbGUgPT0iDQo+ICAgSU1HT1BUUz0iY29tcGF0PTEuMSxsYXp5
X3JlZmNvdW50cz1vbiINCj4gICBfbWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPiAgIA0KPiArVkFMR1JJ
TkRfUUVNVT0iIiBcDQoNCg0KU2hvdWxkbid0IGl0IGJlIHdyaXR0ZW4gb25jZSBwZXIgdGVzdCwg
anVzdCB3aXRob3V0ICJcIiA/DQoNCj4gICAkUUVNVV9JTyAtYyAid3JpdGUgLVAgMHg1YSAwIDUx
MiIgXA0KPiAgICAgICAgICAgIC1jICJzaWdyYWlzZSAkKGtpbGwgLWwgS0lMTCkiICIkVEVTVF9J
TUciIDI+JjEgXA0KPiAgICAgICB8IF9maWx0ZXJfcWVtdV9pbw0KPiBAQCAtMTAwLDYgKzEwMSw3
IEBAIGVjaG8gIj09IE9wZW5pbmcgYSBkaXJ0eSBpbWFnZSByZWFkL3dyaXRlIHNob3VsZCByZXBh
aXIgaXQgPT0iDQo+ICAgSU1HT1BUUz0iY29tcGF0PTEuMSxsYXp5X3JlZmNvdW50cz1vbiINCj4g
ICBfbWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPiAgIA0KPiArVkFMR1JJTkRfUUVNVT0iIiBcDQo+ICAg
JFFFTVVfSU8gLWMgIndyaXRlIC1QIDB4NWEgMCA1MTIiIFwNCj4gICAgICAgICAgICAtYyAic2ln
cmFpc2UgJChraWxsIC1sIEtJTEwpIiAiJFRFU1RfSU1HIiAyPiYxIFwNCj4gICAgICAgfCBfZmls
dGVyX3FlbXVfaW8NCj4gQEAgLTExOCw2ICsxMjAsNyBAQCBlY2hvICI9PSBDcmVhdGluZyBhbiBp
bWFnZSBmaWxlIHdpdGggbGF6eV9yZWZjb3VudHM9b2ZmID09Ig0KPiAgIElNR09QVFM9ImNvbXBh
dD0xLjEsbGF6eV9yZWZjb3VudHM9b2ZmIg0KPiAgIF9tYWtlX3Rlc3RfaW1nICRzaXplDQo+ICAg
DQo+ICtWQUxHUklORF9RRU1VPSIiIFwNCj4gICAkUUVNVV9JTyAtYyAid3JpdGUgLVAgMHg1YSAw
IDUxMiIgXA0KPiAgICAgICAgICAgIC1jICJzaWdyYWlzZSAkKGtpbGwgLWwgS0lMTCkiICIkVEVT
VF9JTUciIDI+JjEgXA0KPiAgICAgICB8IF9maWx0ZXJfcWVtdV9pbw0KPiBAQCAtMTUxLDYgKzE1
NCw3IEBAIGVjaG8gIj09IENoYW5naW5nIGxhenlfcmVmY291bnRzIHNldHRpbmcgYXQgcnVudGlt
ZSA9PSINCj4gICBJTUdPUFRTPSJjb21wYXQ9MS4xLGxhenlfcmVmY291bnRzPW9mZiINCj4gICBf
bWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPiAgIA0KPiArVkFMR1JJTkRfUUVNVT0iIiBcDQo+ICAgJFFF
TVVfSU8gLWMgInJlb3BlbiAtbyBsYXp5LXJlZmNvdW50cz1vbiIgXA0KPiAgICAgICAgICAgIC1j
ICJ3cml0ZSAtUCAweDVhIDAgNTEyIiBcDQo+ICAgICAgICAgICAgLWMgInNpZ3JhaXNlICQoa2ls
bCAtbCBLSUxMKSIgIiRURVNUX0lNRyIgMj4mMSBcDQo+IEBAIC0xNjMsNiArMTY3LDcgQEAgX2No
ZWNrX3Rlc3RfaW1nDQo+ICAgSU1HT1BUUz0iY29tcGF0PTEuMSxsYXp5X3JlZmNvdW50cz1vbiIN
Cj4gICBfbWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPiAgIA0KPiArVkFMR1JJTkRfUUVNVT0iIiBcDQo+
ICAgJFFFTVVfSU8gLWMgInJlb3BlbiAtbyBsYXp5LXJlZmNvdW50cz1vZmYiIFwNCj4gICAgICAg
ICAgICAtYyAid3JpdGUgLVAgMHg1YSAwIDUxMiIgXA0KPiAgICAgICAgICAgIC1jICJzaWdyYWlz
ZSAkKGtpbGwgLWwgS0lMTCkiICIkVEVTVF9JTUciIDI+JjEgXA0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvcWVtdS1pb3Rlc3RzLzA2MSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNjENCj4gaW5kZXggZDdk
YmQ3ZS4uNWQwNzI0YyAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA2MQ0KPiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDYxDQo+IEBAIC03Myw2ICs3Myw3IEBAIGVjaG8NCj4g
ICBlY2hvICI9PT0gVGVzdGluZyBkaXJ0eSB2ZXJzaW9uIGRvd25ncmFkZSA9PT0iDQo+ICAgZWNo
bw0KPiAgIElNR09QVFM9ImNvbXBhdD0xLjEsbGF6eV9yZWZjb3VudHM9b24iIF9tYWtlX3Rlc3Rf
aW1nIDY0TQ0KPiArVkFMR1JJTkRfUUVNVT0iIiBcDQo+ICAgJFFFTVVfSU8gLWMgIndyaXRlIC1Q
IDB4MmEgMCAxMjhrIiAtYyBmbHVzaCBcDQo+ICAgICAgICAgICAgLWMgInNpZ3JhaXNlICQoa2ls
bCAtbCBLSUxMKSIgIiRURVNUX0lNRyIgMj4mMSB8IF9maWx0ZXJfcWVtdV9pbw0KPiAgICRQWVRI
T04gcWNvdzIucHkgIiRURVNUX0lNRyIgZHVtcC1oZWFkZXINCj4gQEAgLTEwNyw2ICsxMDgsNyBA
QCBlY2hvDQo+ICAgZWNobyAiPT09IFRlc3RpbmcgZGlydHkgbGF6eV9yZWZjb3VudHM9b2ZmID09
PSINCj4gICBlY2hvDQo+ICAgSU1HT1BUUz0iY29tcGF0PTEuMSxsYXp5X3JlZmNvdW50cz1vbiIg
X21ha2VfdGVzdF9pbWcgNjRNDQo+ICtWQUxHUklORF9RRU1VPSIiIFwNCj4gICAkUUVNVV9JTyAt
YyAid3JpdGUgLVAgMHgyYSAwIDEyOGsiIC1jIGZsdXNoIFwNCj4gICAgICAgICAgICAtYyAic2ln
cmFpc2UgJChraWxsIC1sIEtJTEwpIiAiJFRFU1RfSU1HIiAyPiYxIHwgX2ZpbHRlcl9xZW11X2lv
DQo+ICAgJFBZVEhPTiBxY293Mi5weSAiJFRFU1RfSU1HIiBkdW1wLWhlYWRlcg0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzEzNyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xMzcNCj4g
aW5kZXggMGMzZDJhMS4uYTQ0MmZjOCAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzEzNw0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTM3DQo+IEBAIC0xMzAsNiArMTMwLDcg
QEAgZWNobw0KPiAgIA0KPiAgICMgV2hldGhlciBsYXp5LXJlZmNvdW50cyB3YXMgYWN0dWFsbHkg
ZW5hYmxlZCBjYW4gZWFzaWx5IGJlIHRlc3RlZDogQ2hlY2sgaWYNCj4gICAjIHRoZSBkaXJ0eSBi
aXQgaXMgc2V0IGFmdGVyIGEgY3Jhc2gNCj4gK1ZBTEdSSU5EX1FFTVU9IiIgXA0KPiAgICRRRU1V
X0lPIFwNCj4gICAgICAgLWMgInJlb3BlbiAtbyBsYXp5LXJlZmNvdW50cz1vbixvdmVybGFwLWNo
ZWNrPWJsdWJiIiBcDQo+ICAgICAgIC1jICJ3cml0ZSAtUCAweDVhIDAgNTEyIiBcDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

