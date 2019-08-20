Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C49C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8EB216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UAx9a8Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8EB216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05tY-0003ED-RN
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i05s2-0002WJ-Kh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i05s1-0000h1-A2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:16:26 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com
 ([40.107.3.106]:1956 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i05s0-0000fX-H0
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+HxBN/VByyljbSwgLxgWvuUiNS1IPzhnHrDKYEUPMdct6XADqWErw4Vo4ugFwIPsSAmbpcQiPhx8v/lMSvY3vqWe48toPaTgHbOdSYHYFJD6eSrmGs9w+zJSUsyMFAPAVXJDcvQW8SuOjMisErn853t1uMPaDZv0dsSuaPoizvvGx841Rwk/Plmmv5ajq32qCT6oqg3YJsYBcA01tSpVJ9rw1lmtT/Yj+Zcl3JPWpRkS7nxmi3gGdhHBtyzwNLBCwuCmO2Rh50ttppb7J2zPPZ5pZX0UXZqds/tI2eOhv4xj3jv395o/reNCDax5T81tPiiC7dcmhkA+AEi8ltABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUgp8K1PE5512tpfYOPJ1GPzeB28nGiGszzVozTXZsA=;
 b=Nhy5r0TzyiFM4VJ7FGDvAwZWcyVLZavZwR53vk6FxyZMHRpMNjdbHmA5gockomwFJU3t3EOWdf6PPEr5JY/lHQwCg6DbacPgJm8mh0eCUkDwqBi5aF0orkl8qJTInBLTUpvl6feXE8RQ6UVF2vT+GyS7Y2iP1ryPDPn6KowFmJY6ptxuwgQM1IfpQiKULesKD8rGvxsZ9xcCM8UoVYUyIY7Jq1d0T9VomZkWRvISOzUEqLH8IwKcbqVx6VZ+YNW4pLTJq8LilZCnt60WHKukjNxBE4aDnJHtrfEeXNGouCEGp4W6m1Ixa9DU2ZjSlNEmMza1P00LdkpEoi3w8Xfhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUgp8K1PE5512tpfYOPJ1GPzeB28nGiGszzVozTXZsA=;
 b=UAx9a8WpdmL/hk+nJRx0/QXPnkZvVhbbfqnRE7d352OHPqrugUXStFOEXAoMMjAG7z58vJCxVker+wMSB5ajFFIl8rMPr+D5/ls78ASVSsaCUpS9UYUu5Mc5s/eC5jBJgt62l/GGAVxNeEXye7OE4i9w7IXCl3MoPbvW4v+B6QM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3567.eurprd08.prod.outlook.com (20.177.61.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:16:21 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 15:16:20 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] Fix: fp-test uninitialized member floatX::exp
Thread-Index: AQHVRr9xspCki27n+kGlF3NZYO6LkacERu8A
Date: Tue, 20 Aug 2019 15:16:20 +0000
Message-ID: <7a3c6043-7fff-7589-875a-9f81754af275@virtuozzo.com>
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0053.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::24) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 754e7074-a557-4c9a-2b9a-08d725815b2d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3567; 
x-ms-traffictypediagnostic: VI1PR08MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB3567F7375BB435878E1E31ACF4AB0@VI1PR08MB3567.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(6436002)(6486002)(66066001)(5640700003)(6512007)(107886003)(25786009)(4326008)(6246003)(8936002)(14454004)(3846002)(6116002)(31696002)(44832011)(186003)(71200400001)(36756003)(66946007)(66446008)(64756008)(66556008)(66476007)(256004)(11346002)(2616005)(7736002)(446003)(486006)(476003)(305945005)(86362001)(2906002)(76176011)(31686004)(386003)(6506007)(53546011)(102836004)(26005)(99286004)(52116002)(71190400001)(2501003)(54906003)(478600001)(229853002)(53936002)(81156014)(2351001)(5660300002)(6916009)(8676002)(316002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3567;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZKARvzmnTnAxLm20vUkKR4qzODB3Gt+qsxfh4dOwhDudWR3cAqn5so1srGdn8Erxc4WYStFvDg3D4jQKvY+SoOqls1gvaCSrGQUFf6k60I1GRo9ld2WzRXxczoP8WCEs9sZGvCNjkVEqe1DhkV6+0BiLj4B7QTkzqB3OeXKjGbSsfu+C9xrIrdjgG4yi3RciuqEAEYgoi5SPulMPHuE/flps/hKh3UKs5p55rx1aGmBBpeafaY53pnpH09BQUYoE2DQTNif7/wfOUmbm/Nj8llko2UlzL0D4B7d+W1kMEvImWsF2xO6ivOioEPL9o7g6qfS/cskTUJcP68fRDaLyHMX7ot3lxHX9Xmlnlu9JwBDJICKIrFJin1g1jmlTFEuXuSqN6R0lhura9zB9gvF3JvKOLCeL5SnjxN9BUbTHISQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE471A847AC020499823D06E92D2AAFC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e7074-a557-4c9a-2b9a-08d725815b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 15:16:20.9388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61ucUmY/k7RocCnwCPSFBtfuej+MvrD2DlzdVPGI+0Cp+mbN/PFiv7WZVfn7/+t9v5wYorW/P8k7RhAkYoSjPp89CzRPYlfSOG0rhdlEOuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3567
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.106
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "cota@braap.org" <cota@braap.org>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UElOR0lORy4uLg0KDQpPbiAzMC8wNy8yMDE5IDEzOjEzLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gTm90IGFsbCB0aGUgcGF0aHMgaW4gdGhlIGZ1bmN0aW9ucywgc3VjaCBhcyBmMTZUb0Zs
b2F0WCgpLCBpbml0aWFsaXplDQo+IHRoZSBtZW1iZXIgJ2V4cCcgb2YgdGhlIHN0cnVjdHVyZSBm
bG9hdFguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNo
aW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgc291cmNlL3Nsb3dmbG9hdC5jIHwg
NCArKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYyBi
L3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYw0KPiBpbmRl
eCA0ZTg0NjU2Li42ZTBmMGE2IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9mcC9iZXJrZWxleS10ZXN0
ZmxvYXQtMy9zb3VyY2Uvc2xvd2Zsb2F0LmMNCj4gKysrIGIvdGVzdHMvZnAvYmVya2VsZXktdGVz
dGZsb2F0LTMvc291cmNlL3Nsb3dmbG9hdC5jDQo+IEBAIC02MjMsNiArNjIzLDcgQEAgc3RhdGlj
IHZvaWQgZjE2VG9GbG9hdFgoIGZsb2F0MTZfdCBhLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4g
ICAgICAgeFB0ci0+aXNJbmYgPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+aXNaZXJvID0gZmFsc2U7
DQo+ICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMCkgIT0gMCk7DQo+ICsgICAgeFB0
ci0+ZXhwID0gMDsNCj4gICAgICAgZXhwID0gdWlBPj4xMCAmIDB4MUY7DQo+ICAgICAgIHNpZzY0
ID0gdWlBICYgMHgwM0ZGOw0KPiAgICAgICBzaWc2NCA8PD0gNDU7DQo+IEBAIC03NTksNiArNzYw
LDcgQEAgc3RhdGljIHZvaWQgZjMyVG9GbG9hdFgoIGZsb2F0MzJfdCBhLCBzdHJ1Y3QgZmxvYXRY
ICp4UHRyICkNCj4gICAgICAgeFB0ci0+aXNJbmYgPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+aXNa
ZXJvID0gZmFsc2U7DQo+ICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMDAwMDApICE9
IDApOw0KPiArICAgIHhQdHItPmV4cCA9IDA7DQo+ICAgICAgIGV4cCA9IHVpQT4+MjMgJiAweEZG
Ow0KPiAgICAgICBzaWc2NCA9IHVpQSAmIDB4MDA3RkZGRkY7DQo+ICAgICAgIHNpZzY0IDw8PSAz
MjsNCj4gQEAgLTg5NSw2ICs4OTcsNyBAQCBzdGF0aWMgdm9pZCBmNjRUb0Zsb2F0WCggZmxvYXQ2
NF90IGEsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0KPiAgICAgICB4UHRyLT5pc0luZiA9IGZhbHNl
Ow0KPiAgICAgICB4UHRyLT5pc1plcm8gPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+c2lnbiA9ICgo
dWlBICYgVUlOVDY0X0MoIDB4ODAwMDAwMDAwMDAwMDAwMCApKSAhPSAwKTsNCj4gKyAgICB4UHRy
LT5leHAgPSAwOw0KPiAgICAgICBleHAgPSB1aUE+PjUyICYgMHg3RkY7DQo+ICAgICAgIHNpZzY0
ID0gdWlBICYgVUlOVDY0X0MoIDB4MDAwRkZGRkZGRkZGRkZGRiApOw0KPiAgICAgICBpZiAoIGV4
cCA9PSAweDdGRiApIHsNCj4gQEAgLTEyMjAsNiArMTIyMyw3IEBAIHN0YXRpYyB2b2lkIGYxMjhN
VG9GbG9hdFgoIGNvbnN0IGZsb2F0MTI4X3QgKmFQdHIsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0K
PiAgICAgICB4UHRyLT5pc1plcm8gPSBmYWxzZTsNCj4gICAgICAgdWlBNjQgPSB1aUFQdHItPnY2
NDsNCj4gICAgICAgeFB0ci0+c2lnbiA9ICgodWlBNjQgJiBVSU5UNjRfQyggMHg4MDAwMDAwMDAw
MDAwMDAwICkpICE9IDApOw0KPiArICAgIHhQdHItPmV4cCA9IDA7DQo+ICAgICAgIGV4cCA9IHVp
QTY0Pj40OCAmIDB4N0ZGRjsNCj4gICAgICAgc2lnLnY2NCA9IHVpQTY0ICYgVUlOVDY0X0MoIDB4
MDAwMEZGRkZGRkZGRkZGRiApOw0KPiAgICAgICBzaWcudjAgID0gdWlBUHRyLT52MDsNCj4gDQoN
Ci0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

