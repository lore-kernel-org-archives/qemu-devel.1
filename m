Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B700522DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QZuSVOxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B700522DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0NHZ-0005qz-TN
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0NGs-0005Qh-2t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0NGq-0000dC-Gh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:51:13 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com
 ([40.107.2.128]:54691 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i0NGp-0000b5-RU
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXvYb6E7B4PNsFo8DSK5pNPn8Wpe7EBAPFssLnZKEvMs4RGx3Ajl0P/KxnfqnfMRro2hHV2/Dbb61N8CET5pyoODqQlxpPmj3+KCo/Sm+tQw5VoeYPIz89ADRWNpZbg57uudRbOHfXv4H+rtZAFEve6hJN/+x1QF3ah9f6qxkFVWwrW/6X4HY1KTx2+YxJJwhXzjWMpdbxEnnlxsQCikEFX+fkbddYvnGIDvjj47g9NeZGvC5zq3/UJPnIIGE2577CKiwBuJBrh9l6e/G7QMeREvQQZEETCkD53PcyfMhLgj6RIZoT0+ANjp+5HghaY6ug1+7tcrfsjFBYLgz6n0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fydo5fdcW7BCkdnKFuZNAkRP1PtsmJSScFhIinr5K4=;
 b=biGGPYuUM7hBvuMhmHDKfQxWOguDYntrQinJHx98NR3euPQNd7+YxgVwZnFuPcLsfpB90W2RnYzu0heMP9q/SEdkQJkgAQONy5qwiYWmDyNZidrAlnB5iq+uRPt1C21EkDsRGtN0QmjGkfkk6oAw7bKNDadGm1ICB6Fa4GWg62IYcozRq2V0uNtjFAdqA8UDTn+Y9mXoR2l92IbbyqsWpDvRoFhTwEDytjPaF8CK+WFHmuKnhuiqCZqtu/UOSMb6fwcfR/6KLL++vkSKc6mJpkzzk04XKpHn3KyC3fpNhR9JQ53wGSnAAPcVanrnHcmpngC/5M2L64qFhMgcGyk5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fydo5fdcW7BCkdnKFuZNAkRP1PtsmJSScFhIinr5K4=;
 b=QZuSVOxzk1d1yWl3bWp2YsCkkDB0DkIg10HTuE3W65/jULAUS9kOlaDIhWe/6SDCM/PUUw4C5Cx3ZOS6Ut6unvs/Hz6mkgIyAioFrTK7caIl6QCoKSJGzY81gZhNpdM7H8MhpimJme5KuM97mP9qNoykXSGG08SwtuHNtQ63CKM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3296.eurprd08.prod.outlook.com (52.134.31.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 09:51:08 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.024; Wed, 21 Aug 2019
 09:51:08 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v4 0/2] char-socket: Fix race condition
Thread-Index: AQHVUSbVHyVd+SwErUyn2NKEEVH8tacFT8gAgAAZ0IA=
Date: Wed, 21 Aug 2019 09:51:07 +0000
Message-ID: <8cfe0089-b65b-c0f1-0648-ea72ac1b8702@virtuozzo.com>
References: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4883fb10-5863-f260-5698-90b3a5e0a00c@redhat.com>
In-Reply-To: <4883fb10-5863-f260-5698-90b3a5e0a00c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0077.eurprd07.prod.outlook.com
 (2603:10a6:3:64::21) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 549cdf8a-aaf2-4ef0-125b-08d7261d16fc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3296; 
x-ms-traffictypediagnostic: VI1PR08MB3296:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB32964B11ADF7C6DDA638C966F4AA0@VI1PR08MB3296.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(6116002)(3846002)(6506007)(71190400001)(66066001)(386003)(36756003)(53546011)(5660300002)(4744005)(6486002)(486006)(2616005)(446003)(11346002)(476003)(102836004)(186003)(44832011)(14454004)(26005)(52116002)(6512007)(6436002)(4326008)(71200400001)(25786009)(2501003)(86362001)(31686004)(31696002)(8936002)(229853002)(305945005)(316002)(66446008)(64756008)(66556008)(66476007)(256004)(81166006)(99286004)(7736002)(478600001)(81156014)(2906002)(14444005)(8676002)(6246003)(66946007)(53936002)(110136005)(54906003)(76176011)(107886003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3296;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Owd52CG5WBj7COM/ZOyJv7+arkpaaowh6vZOdSGPbn2MOtGPi8KpRRPwQr/fMKMlK1LiWT+G4N/CHMzhs+o2n18Hpq6EzASXTgiI0aD+2NJg5lL3KjSjyPS2gEsNl8p4ffyFDI4Irwbnz62XEMfiE//UBO5W0wBa7rdETt/mymhTqnjui1AEGkv9rZh6kiBsFrqo+XgJqH88z6YBGn9ADpysUJDCYgjFCZQy8rMOcMxlAfWVHwDVovT3dNWD4j2CDURscc86w0RfMfn08BOJPPRgkeCUJhkXSWTj+AUhM9Zk5NsT9tEBfu6JQaFTQZ4cu/c/npgLa7FN13q5eck/9MWHktYYfeGsQWAshTzR+Q3DF0BV9Ud22kefuBxe6RRv/CBljckqoTMU1xhQ2N4q8T0vrGKz1rDaii4wArDtPXU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA179BD965A34447A367B02D377E21E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549cdf8a-aaf2-4ef0-125b-08d7261d16fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 09:51:07.9229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgZVkgdZjanQcM+eXRd7kmNrPav9tGK0d6PZvfoa74/aNByE6ZNl/p7I6KAaJqUv3A/CwoyW3S8veokaHR8K+E2dPp240YXOyC6+MxXEy8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3296
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.128
Subject: Re: [Qemu-devel] [PATCH v4 0/2] char-socket: Fix race condition
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIxLzA4LzIwMTkgMTE6MTgsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDEyLzA4
LzE5IDE3OjU4LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFRoaXMgZml4ZXMgYSByYWNl
IGNvbmRpdGlvbiBpbiB3aGljaCB0aGUgdGNwX2Nocl9yZWFkKCkgaW9jIGhhbmRsZXINCj4+IGNh
biBjbG9zZSBhIGNvbm5lY3Rpb24gdGhhdCBpcyBiZWluZyB3cml0dGVuIHRvIGZyb20gYW5vdGhl
ciB0aHJlYWQuDQo+Pg0KPj4gdjQ6DQo+PiAgICAgIFRoZSBmdW5jdGlvbnMgcWVtdV9pZGxlX2Fk
ZCgpIGFuZCB0Y3BfY2hyX2JlX2V2ZW50X2Nsb3NlZCgpIHdlcmUgcmVtb3ZlZA0KPj4gICAgICBi
ZWNhdXNlIHRoZSBjYWxsYmFjayBpcyBpbnZva2VkIGFmdGVyIHRoZSBjYWxsIHRvIG9iamVjdF9w
cm9wZXJ0eV9kZWxfYWxsKCkNCj4+ICAgICAgc28sIHRoZSAiY2hhcmRldiIgb2JqZWN0IGhhZCBi
ZWVuIGRlbGV0ZWQgYW5kIHRoZSBzZWdtZW50YXRpb24gZmF1bHQgb2NjdXJzLg0KPj4gICAgICBM
ZXQncyBwbGVhc2UgYXBwbHkgdGhlIEFsYmVydG8ncyBzaW1wbGlmaWVkIHNlcmllcyB0byBhdm9p
ZCB0aGUgcmFjZSBjb25kaXRpb24uDQo+Pg0KPj4gdjM6DQo+PiAgICAgIFNlZSB0aGUgZW1haWwg
dGhyZWFkIHdpdGggdGhlIE1lc3NhZ2UgSUQNCj4+ICAgICAgPGNvdmVyLjE1NTA4NDI5MTUuZ2l0
LmJlcnRvQGlnYWxpYS5jb20+DQo+Pg0KPj4gQWxiZXJ0byBHYXJjaWEgKDIpOg0KPj4gICAgbWFp
bi1sb29wOiBGaXggR1NvdXJjZSBsZWFrIGluIHFpb190YXNrX3RocmVhZF93b3JrZXIoKQ0KPj4g
ICAgY2hhci1zb2NrZXQ6IExvY2sgdGNwX2Nocl9kaXNjb25uZWN0KCkNCj4+DQo+PiAgIGNoYXJk
ZXYvY2hhci1zb2NrZXQuYyB8IDE2ICsrKysrKysrKysrKystLS0NCj4+ICAgaW8vdGFzay5jICAg
ICAgICAgICAgIHwgIDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gUXVldWVkLCB0aGFua3MuDQo+IA0KPiBQYW9sbw0K
PiANClRoYW5rcyB5b3UgYWxsIHRvby4NCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2Fy
ZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

