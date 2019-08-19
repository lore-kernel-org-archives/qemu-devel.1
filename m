Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28782C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C5C206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tJ97s8DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C5C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzogj-0003Lh-39
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1hzoeb-0001sN-Vr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hzoeb-00020T-07
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:53:25 -0400
Received: from mail-am5eur03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::72d]:16262
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hzoeX-0001xo-5y; Mon, 19 Aug 2019 16:53:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONYULo8FF9aS4AnRYkO2wOvIT91wDWGD1IOPWxcpSiWEXzywW6Lp5H0C8Me6Btlr85Gptp1ZLc3L4U4WiR6ECPTC+Ue3K/N4b21L9HCqKSJktZM8AZEYiJEq1hqOtOCjXx5JVktgGXbqz6YeFd2PshMWPCzz1iL/JHtkZM8tZPuxOEipMTHWKxnb1zUkDcejaqVOIkVaYgNc5Jjz1+dyjLu6Nh6dRZxIaVQ5WCLty65gfj7VCNRb41oPdLdKTGe/WOZNkAwv3y37VaIL2f2HapFli2Gh6jUmFPHFK/G1ICencjjTdVQzjLMxFKcfoNVMW/mek79VVNO/6OPYGKYinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKvX8jP1Qu9lXeZzCRM+MWUBcNEvG3FOOKi3VCEPP1M=;
 b=bDodXr79avwOqkEBi/OapmIw+9s3csmko94+2v5XV806Vgac/NNauWyw2Dvk3iy/2tGuZMSdqkSKqc3yorfh2l3drj2WNlZUuzPKo9TrR16rWPIRcUljx87x9Ey2mr4TOXipGu27c/GllIQH0syylTHbw7RprutH4nhU5Q7j3ijycfn5000eoQ2Me1iMvmZ2R5mj9CSCPu7Bla00PjcOYhzaIklIQGYMQ/9fLsyXE74980kNTL5jd8Lxv61gika1asCxnPDnqst7x77rzPDHlVrdhqb26cklar5QEKMXM1+qcq6IBHv5XT2oqbPrFDy83MnHN/7yXdAmmd4Kku9uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKvX8jP1Qu9lXeZzCRM+MWUBcNEvG3FOOKi3VCEPP1M=;
 b=tJ97s8DCeoxdzZnV3+JVuBEhhCpQWgBnbKJmn5ZkSdFQhUdJmEczjhHMsYR1HekZLZUNOrwQ9xIszneRSbV/Djxe+ncZkUWIl34zR1tyzgub+GPr0o5S+1QbxmvtaeB6G9TOF47VyOaPXI9QtguvkbxlOVWsaj+kBYuWuoIif5E=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4694.eurprd08.prod.outlook.com (10.255.79.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Mon, 19 Aug 2019 20:53:18 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d%7]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 20:53:18 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
Thread-Index: AQHU67tBNfVtWsWTSEqO4ep6MEFcGKcAPJoAgAAB6wCAAAIFgIADdZIAgAAMXACAAAZQAA==
Date: Mon, 19 Aug 2019 20:53:18 +0000
Message-ID: <c5936c33-5488-ff74-b7de-bb4802c70f2d@openvz.org>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
 <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
 <5dc0231e-6fbc-3efc-8cc7-ff953651d0e9@redhat.com>
 <a7cfd04b-5185-e13c-2ced-7e689de05247@openvz.org>
 <71d406a0-d1a0-6feb-5768-6295d36e18fc@redhat.com>
In-Reply-To: <71d406a0-d1a0-6feb-5768-6295d36e18fc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::26) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.26.82.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9befa4ea-a59d-4b74-3136-08d724e74323
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4694; 
x-ms-traffictypediagnostic: DBBPR08MB4694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB4694F71A262CC4A3D46C02F2B6A80@DBBPR08MB4694.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(5660300002)(229853002)(6116002)(52116002)(99286004)(25786009)(26005)(31686004)(54906003)(3846002)(71200400001)(66066001)(66476007)(14444005)(8676002)(6512007)(6436002)(478600001)(53546011)(110136005)(8936002)(102836004)(36756003)(316002)(71190400001)(31696002)(2201001)(386003)(53936002)(76176011)(7736002)(6246003)(6486002)(42882007)(486006)(14454004)(476003)(81156014)(66556008)(66946007)(66446008)(446003)(11346002)(256004)(2616005)(81166006)(64756008)(2906002)(2501003)(305945005)(186003)(6506007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4694;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZK934SNCMjPYevpSwgtz0lMNIt4Lbk+nln3J48SCBnu1ghb+LMjHPBjTh5QCdBk0IUbRWjPAbn1/vtU+Q5ZPIgyBFPZtRE1DUusg74BZK0wCjZcI9p5RCPVXoj19KdkqWkXQ7ayoPiVQnGuX26WCadGdnxB3y9FswFk1whfG0eZrQM5ZMG+hF4wgD61oAo/xvyhYg4ubZMlORFaavYOt0rFkuX5p2xfcRqAba6cQKskMUr/foI5myaXv4MqlrW6ETzEBaoTDQhHBUlDN4+pBJQ1/P8xGQIH2cNwEAq6w3i5fX92hTBFB/hBseCQgQKLnATPxNCOEFWHgCdPzQpGCZgPOkukXbA7KoIhRDKm7RpGFEVW2oGo3d1A1MbtA1N2r/aFkJATQRSM6SNIBCchezAPPaVCSltLKTZ2ncWlpnCw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4D2E2A4831CC943845AE0730E9A5880@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 9befa4ea-a59d-4b74-3136-08d724e74323
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 20:53:18.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq0a1CUCBH5QC0aU+oE5pJv0k4Ap+9lcaDuxZgFKfbc64xhZzrdXLyiB0izf2b8fq+60Mx5dALODa50Q0CYJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4694
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::72d
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOC8xOS8xOSAxMTozMCBQTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC8xOS8xOSAyOjQ2
IFBNLCBEZW5pcyBWLiBMdW5ldiB3cm90ZToNCj4+IE9uIDgvMTcvMTkgNTo1NiBQTSwgRXJpYyBC
bGFrZSB3cm90ZToNCj4+PiBPbiA4LzE3LzE5IDk6NDkgQU0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+
Pj4NCj4+Pj4+IFRoaXMgY2hhbmdlIGlzIGEgcmVncmVzc2lvbiBvZiBzb3J0cy4gIE5vdywgeW91
IGFyZSB1bmNvbmRpdGlvbmFsbHkNCj4+Pj4+IGF0dGVtcHRpbmcgdGhlIGZhbGxiYWNrIGZvciBB
TEwgZmFpbHVyZXMgKHN1Y2ggYXMgRUlPKSBhbmQgZm9yIGFsbA0KPj4+Pj4gZHJpdmVycywgZXZl
biB3aGVuIHRoYXQgd2FzIG5vdCBwcmV2aW91c2x5IGF0dGVtcHRlZCBhbmQgaW5jcmVhc2VzIHRo
ZQ0KPj4+Pj4gdHJhZmZpYy4gIEkgdGhpbmsgd2Ugc2hvdWxkIHJldmVydCB0aGlzIHBhdGNoIGFu
ZCBpbnN0ZWFkIGZpeCB0aGUNCj4+Pj4+IGZhbGxvY2F0ZSgpIHBhdGggdG8gY29udmVydCB3aGF0
ZXZlciBBQ1RVQUwgZXJybm8geW91IGdvdCBmcm9tIHVuYWxpZ25lZA0KPj4+Pj4gZmFsbG9jYXRl
IGZhaWx1cmUgaW50byBFTk9UU1VQICh0aGF0IGlzLCBqdXN0IHRoZSBmaWxlLXBvc2l4LmMgbG9j
YXRpb24NCj4+Pj4+IHRoYXQgZmFpbGVkKSwgd2hpbGUgbGVhdmluZyBhbGwgb3RoZXIgZXJyb3Jz
IGFzIGltbWVkaWF0ZWx5IGZhdGFsLg0KPj4+IE9yIGV2ZW4gYmV0dGVyLCBmaXggdGhlIGNhbGwg
c2l0ZSBvZiBmYWxsb2NhdGUoKSB0byBza2lwIGF0dGVtcHRpbmcgYW4NCj4+PiB1bmFsaWduZWQg
ZmFsbG9jYXRlKCksIGFuZCBqdXN0IGRpcmVjdGx5IHJldHVybiBFTk9UU1VQLCByYXRoZXIgdGhh
bg0KPj4+IHRyeWluZyB0byBkaWFnbm9zZSBFSU5WQUwgYWZ0ZXIgdGhlIGZhY3QuDQo+Pj4NCj4+
IE5vIHdheS4gU2luZ2xlIEVOT1RTVVAgd2lsbCB0dXJuIG9mZiBmYWxsb2NhdGUoKSBzdXBwb3J0
IG9uIGNhbGxlciBzaWRlDQo+PiB3aGlsZQ0KPj4gYWxpZ25lZCAoOTkuOTklIG9mIGNhbGxzKSB3
b3JrcyBub3JtYWxseS4NCj4gSSBkaWRuJ3QgbWVhbiBza2lwIGZhbGxvY2F0ZSgpIHVuY29uZGl0
aW9uYWxseSwgb25seSB3aGVuIHVuYWxpZ25lZDoNCj4NCj4gaWYgKHJlcXVlc3Qgbm90IGFsaWdu
ZWQgZW5vdWdoKQ0KPiAgICByZXR1cm4gLUVOT1RTVVA7DQo+IGZhbGxvY2F0ZSgpIC4uLg0KPg0K
PiBzbyB0aGF0IHRoZSA5OS45OSUgcmVxdWVzdHMgdGhhdCBBUkUgYWxpZ25lZCBnZXQgdG8gdXNl
IGZhbGxvY2F0ZSgpDQo+IG5vcm1hbGx5Lg0KPg0Kc3RhdGljIGludCBoYW5kbGVfYWlvY2Jfd3Jp
dGVfemVyb2VzKHZvaWQgKm9wYXF1ZSkNCnsNCi4uLg0KI2lmZGVmIENPTkZJR19GQUxMT0NBVEVf
WkVST19SQU5HRQ0KwqDCoMKgIGlmIChzLT5oYXNfd3JpdGVfemVyb2VzKSB7DQrCoMKgwqDCoMKg
wqDCoCBpbnQgcmV0ID0gZG9fZmFsbG9jYXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwN
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhaW9jYi0+YWlvX29mZnNldCwgYWlvY2ItPmFpb19uYnl0ZXMpOw0KwqDCoMKgwqDCoMKg
wqAgaWYgKHJldCA9PSAwIHx8IHJldCAhPSAtRU5PVFNVUCkgew0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gcmV0Ow0KwqDCoMKgwqDCoMKgwqAgfQ0KwqDCoMKgwqDCoMKgwqAgcy0+aGFz
X3dyaXRlX3plcm9lcyA9IGZhbHNlOw0KwqDCoMKgIH0NCiNlbmRpZg0KDQp0aHVzLCByaWdodCBu
b3csIHNpbmdsZSBFTk9UU1VQIGRpc2FibGVzIGZhbGxvY2F0ZQ0KZnVuY3Rpb25hbGl0eSBjb21w
bGV0ZWx5IHNldHRpbmcgcy0+aGFzX3dyaXRlX3plcm9lcw0KdG8gZmFsc2UgYW5kIHRoYXQgaXMg
cHJldHR5IG11Y2ggY29ycmVjdC4NCg0KRU5PVFNVUCBpcyAic3RhdGljIiBlcnJvciBjb2RlIHdo
aWNoIHJldHVybnMgcGVyc2lzdGVudA0KRU5PVFNVUCB1bmRlciBhbnkgY29uc2VxdWVuY2VzLiBJ
dHMgaGFuZGxpbmcgdXN1YWxseQ0KZGlzYWJsZXMgc29tZSBmdW5jdGlvbmFsaXR5Lg0KDQpUaGlz
IGlzIHdoeSBvcmlnaW5hbCBpZGVhIGlzIHByb3Bvc2VkLg0KDQpEZW4NCg==

