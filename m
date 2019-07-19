Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E088BC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED7521872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FqnJlVOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoV8H-0004aE-TK
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoV7l-0003mn-AX
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoV7N-0006N1-Nl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:48:28 -0400
Received: from mail-eopbgr50120.outbound.protection.outlook.com
 ([40.107.5.120]:35475 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoV6k-0005Dq-E9; Fri, 19 Jul 2019 11:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1ORfyXyHqHBkEGrAkrkpce5UnbeCWrJK2mgi5Rmi81Y1lwVTTyMb6s9M3WO9fFsG2LLNi5KCu8R6IZxEFZV8/hq7GqoXVI5jTVYygScnJxZq0e6GUQ7MAQ8ZaLu/hytwlUGelDi0iugEi1EjZp6uje2Gubwo5U8HwVXcPDwJqe0OyBbWOmaV1YpvNh2PdSRsKFla2nAIb0Quio3myNw0HfHd96nrU1diY/dC+IvxY3N9h1CSa3Fsb5WkXTuRF79Ye3XVeNni6lBIsCIPfyYPwPJ9wjVuJCf71cibBhvm/Cmk8RNVjnWggfU/UdelBnc5AmagyqUQuiFFrMsUAZiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDRjoozx0qAXBTPGHQWNDI6jVDURWwUzRalF5ryOFRQ=;
 b=eAwDMOD2XbVPSHkk7tlrLpo6uhO/O5fIQhUySvVJ82iTfJQTtBJyCc7A/fCaZUVB3Eeo99FL8ITKtmcE2qBdSg6YikMH5Z6BcvkD4ma2/yGYtITMELn6vnZrs2KHcUK9CUQDdKnFM9J0CjxmajRIozKvudRP2awRy+0aeZE2CeVNbRhZlHcWOD+z3vbBW9Bq1HTCL4m+Y/cRmCG5jfSb79VdH6QrFyM5NLa4dBvPeP3XrA+Px0iJLLiysLB9lTg93bFt9az0IlyEfjXYDCqH5k2HXXPVs8QAiH+rozo7LAjO5P6kmiIab6UCdFJQFhIPuNTRhARZa6niQIzFEu39Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDRjoozx0qAXBTPGHQWNDI6jVDURWwUzRalF5ryOFRQ=;
 b=FqnJlVOZrQgMylzievecTGecgxrVP0kCTYL/+h8Gtm4VaFt2OkrOj2//3jb4Y1O4UJ6b61dfQKzTbiP+txk4WYZOjXIsO8f+z7OYQB9nLPuSRacLov7IqthKCJb/GDLofZIJBq0yCUoax3Qvf9FCPa/2PyGOTS8PdhoOK1rtHqc=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4047.eurprd08.prod.outlook.com (20.178.127.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 15:00:54 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 15:00:54 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 7/7] block/nbd: NBDReply is used being uninitialized
Thread-Index: AQHVPhX6yHnO2fi6H020bxQ0/FYE6abSAfoAgAAC0gCAAASIgA==
Date: Fri, 19 Jul 2019 15:00:53 +0000
Message-ID: <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>
References: <1563529204-3368-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563529204-3368-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
 <e12c0aa2-6757-856a-bbe0-717895453986@redhat.com>
In-Reply-To: <e12c0aa2-6757-856a-bbe0-717895453986@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 499f48a5-6ec3-4a06-fbfa-08d70c59e573
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4047; 
x-ms-traffictypediagnostic: VI1PR08MB4047:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB4047E397C825D43883EED821F4CB0@VI1PR08MB4047.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39850400004)(199004)(189003)(6512007)(44832011)(486006)(52116002)(3846002)(6116002)(66476007)(229853002)(6486002)(6306002)(6436002)(66556008)(64756008)(2201001)(2906002)(4326008)(14454004)(66446008)(66946007)(71190400001)(71200400001)(14444005)(256004)(6246003)(53936002)(25786009)(446003)(966005)(476003)(2616005)(7736002)(31696002)(305945005)(11346002)(478600001)(5660300002)(66066001)(31686004)(76176011)(102836004)(53546011)(36756003)(386003)(6506007)(26005)(186003)(8936002)(81156014)(68736007)(99286004)(86362001)(2501003)(8676002)(81166006)(110136005)(54906003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4047;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lRpiiBsYeywQN9M8TJFmR33RaLGJBzHcceRhF/IFA3c7brlNY9vM0f3HCEYKRcB+AE3/9TsPXMgGhbdRZR/ze4Hh+3GhF+NBhrN4issudiNYNUAcKDzjbTAkWFAsNqFHTxVUeJIaBQc03iq8lTk22v06KuXPM84k73sDAmsD92HJ8POJcWvjsrC+9waiqW/Guu5RDgxazuwhURkOyFo8glKgBR933SRfP3LQA1PcOZ2C9dVqaw0x+zJJR9/ovuTCY6BkTApgAXUQ9ngoFN+tAj1OXb/0+zc61zb0BsqCstttw/PMSQps5lpUUv5SDMn0xsf7GmrlyTHOcTxz3dOtfim1FgLHG65NaDwpXoliEo0nhu2K/JeQECx+G5MpiUtyRNxN8O5JfFVcKi6puDmgf35l6wkgfPkPxcnFOBoiscQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BF9A9BA7CB60C4DB875C051FC9969C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499f48a5-6ec3-4a06-fbfa-08d70c59e573
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 15:00:53.9179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4047
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.120
Subject: Re: [Qemu-devel] [PATCH v4 7/7] block/nbd: NBDReply is used being
 uninitialized
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA3LzIwMTkgMTc6NDQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDcvMTkvMTkg
OTozNCBBTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDcvMTkvMTkgNDo0MCBBTSwgQW5kcmV5
IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4gSW4gY2FzZSBuYmRfY29fcmVjZWl2ZV9vbmVfY2h1bmso
KSBmYWlscyBpbg0KPj4+IG5iZF9yZXBseV9jaHVua19pdGVyX3JlY2VpdmUoKSwgJ05CRFJlcGx5
IHJlcGx5JyBwYXJhbWV0ZXIgaXMgdXNlZCBpbg0KPj4+IHRoZSBjaGVjayBuYmRfcmVwbHlfaXNf
c2ltcGxlKCkgd2l0aG91dCBiZWluZyBpbml0aWFsaXplZC4gVGhlIGlvdGVzdA0KPj4+IDA4MyBk
b2VzIG5vdCBwYXNzIHVuZGVyIHRoZSBWYWxncmluZDogJC4vY2hlY2sgLW5iZCAtdmFsZ3JpbmQg
MDgzLg0KPj4+IFRoZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBzd2FwIHRoZSBvcGVyYW5k
cyBpbiB0aGUgY29uZGl0aW9uOg0KPj4+ICdpZiAocy0+cXVpdCB8fCBuYmRfcmVwbHlfaXNfc2lt
cGxlKHJlcGx5KSknDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8
YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGJsb2NrL25i
ZC5jIHwgMiArLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gSHVoLiBWZXJ5IHNpbWlsYXIgdG8NCj4+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTA3L21zZzAzNzEyLmh0bWwsIGJ1dA0K
Pj4gYWZmZWN0cyBhIGRpZmZlcmVudCBmdW5jdGlvbi4gSSBjYW4gcXVldWUgdGhpcyBvbmUgdGhy
b3VnaCBteSBOQkQgdHJlZQ0KPj4gdG8gZ2V0IGJvdGggaW4gbXkgcmMyIHB1bGwgcmVxdWVzdC4N
Cj4+DQo+PiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0K
PiBBY3R1YWxseSwgc2luY2UgdGhpcyBpcyB0aGUgc2Vjb25kIHBhdGNoIG9uIHRoZSBzYW1lIHRv
cGljLCBJJ20NCj4gd29uZGVyaW5nIGlmIGl0J3MgYmV0dGVyIHRvIHVzZSB0aGUgZm9sbG93aW5n
IG9uZS1saW5lciB0byBmaXggQk9USA0KPiBpc3N1ZXMgYW5kIHdpdGhvdXQgcmVseWluZyBvbiBh
IGdjYyBleHRlbnNpb246DQo+IA0KPiBkaWZmIC0tZ2l0IGkvYmxvY2svbmJkLmMgdy9ibG9jay9u
YmQuYw0KPiBpbmRleCA4ZDU2NWNjNjI0ZWMuLmY3NTFhOGU2MzNlNSAxMDA2NDQNCj4gLS0tIGkv
YmxvY2svbmJkLmMNCj4gKysrIHcvYmxvY2svbmJkLmMNCj4gQEAgLTY0MCw2ICs2NDAsNyBAQCBz
dGF0aWMgY29yb3V0aW5lX2ZuIGludCBuYmRfY29fcmVjZWl2ZV9vbmVfY2h1bmsoDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVxdWVzdF9yZXQsIHFpb3Ys
IHBheWxvYWQsDQo+IGVycnApOw0KPiANCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAg
ICAgbWVtc2V0KHJlcGx5LCAwLCBzaXplb2YgKnJlcGx5KTsNCg0KVGhlIGNhbGwgdG8gbWVtc2V0
KCkgY29uc3VtZXMgbW9yZSBDUFUgdGltZS4gSSBkb24ndCBrbm93IGhvdyBmcmVxdWVudCANCnRo
ZSAicmV0IDwgMCIgcGF0aCBpcy4gVGhlIGluaXRpYWxpemF0aW9uICcgPSB7MH0nIGlzIGNoZWFw
ZXIuDQpJcyBpdCBzYWZlIHRvIHN3YXAgdGhlIG9wZXJhbmRzIGluIHRoZSBjb25kaXRpb24gaW4g
DQpuYmRfcmVwbHlfY2h1bmtfaXRlcl9yZWNlaXZlKCk6DQonaWYgKHMtPnF1aXQgfHwgbmJkX3Jl
cGx5X2lzX3NpbXBsZShyZXBseSkpJyA/DQoNCkFuZHJleQ0KDQo+ICAgICAgICAgICBzLT5xdWl0
ID0gdHJ1ZTsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgIC8qIEZvciBhc3NlcnQgYXQg
bG9vcCBzdGFydCBpbiBuYmRfY29ubmVjdGlvbl9lbnRyeSAqLw0KPiANCg0KLS0gDQpXaXRoIHRo
ZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

