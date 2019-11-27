Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB15C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1232068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jd8Pe+cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1232068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3qY-0005SX-OF
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 15:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3pZ-0004x1-RD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3pY-0006QI-LB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:22:33 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:60364 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia3pR-0006AU-EL; Wed, 27 Nov 2019 15:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzLtFArlhGBsGhwZQqV17mVrLnDZ3ErLllN13xnR4Jxurp3SrQjH4JpZOODbyUGK2iCn5ucwCUYO01sF26yFKa2UxSH+PrmEwYPW3SCO5iCO+bfparufTpZt6Jsea+37SKo7fGJ9edFXGXc2K2iRnAHsVuyZ0uTk22Njaaey7TqdKd3fQWgmdEkQQVpoYwfXXopAXkn4x9WlWkdaMbvRIkvhm4sBbvup6rgh+0Gvvjo6W5JCmDk4AM5p9Ou8rCjMiT+iIlyWZpLOxli0uan+nlkGWwAhm9FHe+vYKSldkXrNzSQSS7e80vpWPsi+wqxz0EJsJu/aACE/4kFK2pbVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMIXpMl/x0oQOgQEdBexDT4Hc9WNivHCap4hLmdyyqQ=;
 b=D4UQmZFFPFmHMm99GEwTBeKhZKx26omFWGSHJafho+ngJf6jpWjYhEBuRPcPtqcbMvgO4GFk7UByMUn8w1shggRFKoqthgxbujhQTdpwsYyLuzEG5PA2IOheRPDjH5YEesyyALi/6dudVVQmEeklHEbk9VtRaM1RMMmVRxmny4FjJ9bfYCkgOMvqfn3ocKVfNlFRjrrgs9JflAmzQntwm/4kIeCx0PJB3pUm1788vVM1rthPRQfg6EIqa8anUvezwveMQC5Z0iwKuGismw3CBuFCGdyBHLSrLbv9YaWZfWD/DrjgadRQNcQlSQQrNDwn5b8yFAFl/DAepa0T9UdQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMIXpMl/x0oQOgQEdBexDT4Hc9WNivHCap4hLmdyyqQ=;
 b=Jd8Pe+cw4fN9swNTGi53V1B83fXuht5PJsgqzLZJk0WB7eLR+HMa4yIvxJHoHDqNXJCxCeXvaBqSC/fInSs0ii4xHYI1P4NRWyeSK4Wx4BpVz26BuwhURuGnuMLdNudIPWnnZ5tlRfW0qYGc2HKKeeWMrT5VA0cPTsBMU0j+WBU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5031.eurprd08.prod.outlook.com (10.255.123.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 27 Nov 2019 20:22:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 20:22:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Topic: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Index: AQHVpHEG5YfDz7UI8UOBrTTRR2csGaefcReAgAAGvoA=
Date: Wed, 27 Nov 2019 20:22:18 +0000
Message-ID: <caacca90-0597-966c-d570-61d4faaa1b1d@virtuozzo.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
 <CAL1e-=ixsfP5tYb0MHf1qLTR=4qLJO4hjjHtyU==Sdk0TcE7hg@mail.gmail.com>
In-Reply-To: <CAL1e-=ixsfP5tYb0MHf1qLTR=4qLJO4hjjHtyU==Sdk0TcE7hg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191127232215801
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03fb7809-10e5-4504-7d1a-08d773777fc6
x-ms-traffictypediagnostic: AM6PR08MB5031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB50310C529A034E5F31A94BCFC1440@AM6PR08MB5031.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39840400004)(396003)(136003)(376002)(199004)(189003)(53754006)(66946007)(71190400001)(25786009)(256004)(14444005)(52116002)(6512007)(99286004)(53546011)(6916009)(316002)(76176011)(386003)(4326008)(71200400001)(6486002)(5660300002)(6436002)(54906003)(102836004)(26005)(229853002)(11346002)(446003)(6506007)(186003)(2616005)(14454004)(31686004)(6116002)(8676002)(81166006)(3846002)(66556008)(64756008)(8936002)(86362001)(66476007)(66446008)(478600001)(2906002)(66066001)(36756003)(31696002)(81156014)(6246003)(305945005)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5031;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwKUMf+d6PfWxqKJgrc7+GZTd/zH/B18CfyfRYkQHdjVQPptxBfw1ksiKMnmawt/MGEiEo8icixBgetqGv9QkCZwksiAgHGCD02961juY5tD0Lo3pyMG6f4oTNhXdEPUW7cdVVkoXGNmNYSyuygbsX1CO5ECmhs7Po94JaSxEUkBgsyXJ6/v50IjxCEfozeLMlfwLttkmZ7jVvU5JlO1uui/4M2x6kKZ69RvJlvvirKaqfm/i3evSksPtOkf/LQb+B+18cAvFZr2SQD3JG8kjkWxRxAVZEU+jPPPlMBWFwm56Ny/kGQhmFHfdryshkr/l7ypI8AzVqykS2Y8Le3tjyhA455PJ/CADZHaGFrWT5hG7IDPLkwtweGUG9ohVyKuoeEIye9+whAuXuMtfJk9h67vrXh5q59D9zp360o4nzAlq9ACbSFvh8ZVujeqRGCU
Content-Type: text/plain; charset="utf-8"
Content-ID: <F966404BC8339A47972B325886A67AC1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fb7809-10e5-4504-7d1a-08d773777fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 20:22:18.1369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3EDSEncI557XZPujtAhkEw603XthiksctQO5EdDHgLdGzgLNz7aYqV81P0Rn4miIatIa8JI94Xy3jTatxLjKu5MDtueA2+RbqUGCuTFG3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.95
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:bochs" <qemu-block@nongnu.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMTEuMjAxOSAyMjo1OCwgQWxla3NhbmRhciBNYXJrb3ZpYyB3cm90ZToNCj4gT24gVHVlLCBO
b3YgMjYsIDIwMTkgYXQgNDo0OSBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+IEhpIGFsbCENCj4+DQo+PiBI
ZXJlIGlzIHNpbXBsZSBiZW5jaG1hcmtpbmcgdXRpbGl0eSwgdG8gZ2VuZXJhdGUgcGVyZm9ybWFu
Y2UNCj4+IGNvbXBhcmlzb24gdGFibGVzLCBsaWtlIHRoZSBmb2xsb3dpbmc6DQo+Pg0KPj4gLS0t
LS0tLS0tLSAgLS0tLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLQ0KPj4g
ICAgICAgICAgICAgIGJhY2t1cC0xICAgICAgIGJhY2t1cC0yICAgICAgIG1pcnJvcg0KPj4gc3Nk
IC0+IHNzZCAgMC40MyArLSAwLjAwICAgNC40OCArLSAwLjA2ICAgNC4zOCArLSAwLjAyDQo+PiBz
c2QgLT4gaGRkICAxMC42MCArLSAwLjA4ICAxMC42OSArLSAwLjE4ICAxMC41NyArLSAwLjA1DQo+
PiBzc2QgLT4gbmJkICAzMy44MSArLSAwLjM3ICAxMC42NyArLSAwLjE3ICAxMC4wNyArLSAwLjA3
DQo+PiAtLS0tLS0tLS0tICAtLS0tLS0tLS0tLS0tICAtLS0tLS0tLS0tLS0tICAtLS0tLS0tLS0t
LS0tDQo+Pg0KPj4gVGhpcyBpcyBhIHYyLCBhcyB2MSB3YXMgaW5zaWRlDQo+PiAgICJbUkZDIDAw
LzI0XSBiYWNrdXAgcGVyZm9ybWFuY2U6IGJsb2NrX3N0YXR1cyArIGFzeW5jIg0KPj4NCj4+IEkn
bGwgdXNlIHRoaXMgYmVuY2htYXJrIGluIG90aGVyIHNlcmllcywgaG9wZSBzb21lb25lDQo+PiB3
aWxsIGxpa2UgaXQuDQo+Pg0KPiANCj4gVmxhZGltaXIsDQo+IA0KPiBJIHJlYWxseSBsaWtlIHRo
aXMgaWRlYSwgZXZlbiB0aG91Z2ggSSBhbSBpbnRlcmVzdGVkIGluIGJlbmNobWFya3Mgb2YNCj4g
ZGlmZmVyZW50IG5hdHVyZS4gQ2VydGFpbmx5IGEgYmVhdXRpZnVsIGFuZCBoYW5keSB0b29sIGZv
ciBkb2luZw0KPiBkZXRlY3Rpb24gb2YgcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMgKGFuZCBhbHNv
IGNvbmZpcm1hdGlvbiBvZg0KPiBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb25zKS4NCg0KSGkgQWxl
a3NhbmRhciENCg0KR2xhZCB5b3UgYXJlIGludGVyZXN0ZWQhDQoNCj4gDQo+IERpZCB5b3UgcnVu
IHRoZSB0b29sIG9uIHRoZSBwcmV2aW91cyBRRU1VIHZlcnNpb25zLCB0byBkZXRlY3QgY2hhbmdl
DQo+IGluIG51bWJlcnMgYmV0d2VlbiBRRU1VIHZlcnNpb25zPyBEbyB5b3UgaGF2ZSB0aGUgcmVz
dWx0cyBvZiB0aGUgc2FtZQ0KPiBiZW5jaG1hcmsgZm9yIFFFTVUgMi4xMiwgMy4wLCA0LjAsLi4u
ID8NCg0KTm8sIEkgZG9uJ3QgcmVhbGx5IGludGVyZXN0ZWQgaW4gc3VjaCBjb21wYXJpc29ucywg
bXkgZ29hbCBpcyB0byBtZWFzdXJlDQpiYWNrdXAgcGVyZm9ybWFuY2UgaW4gY29udGV4dCBvZiBt
eSBiYWNrdXAvYmxvY2stY29weSBzZXJpZXMuDQoNCkJ1dCBzdWNoIHN0YXRpc3RpY3MgbWF5IGJl
IHNpbXBseSBnZW5lcmF0ZWQsIGp1c3QgbWFrZSBzZXZlcmFsIGdpdCB3b3JrLXRyZWVzDQpwZXIg
cmVsZWFzZSB5b3UgaW50ZXJlc3RlZCBpbiwgZmlsbCB0ZXN0X2VudnMgdmFyaWFibGUgKHRvZ2V0
aGVyIHdpdGggb3RoZXINCnZhcmlhYmxlcykgaW4gcHl0aG9uL2JlbmNoLWV4YW1wbGUucHkgKHBh
dGNoIDAzKSwgYW5kIHJ1biBpdC4NCg0KPiANCj4gV2hhdCBhcmUgdW5pdHMgdXNlZCBpbiB0aGUg
dGFibGU/IFNlY29uZHMsIG1pbnV0ZXM/IEhvcGVmdWxseSwgbm90IGhvdXJzPw0KDQpTZWNvbmRz
IG9mIGNvdXJzZSwgSSdtIG5vdCBzbyBwYXRpZW50IDopDQpBbHNvLCBpZiB5b3UgYXJlIGludGVy
ZXN0ZWQsIDEwMDBNIHJhdyBpbWFnZXMgZmlsbGVkIHdpdGggb25lcyB1c2VkIHRvIG1ha2UNCnRo
aXMgYmVuY2htYXJrIHRhYmxlLiBIb3dldmVyLCBpdCdzIGluIGNvdmVyLWxldHRlciBvbmx5IGFz
IGV4YW1wbGUuDQoNCmJhY2t1cC0xIGFuZCBtaXJyb3IgYXJlIHVwc3RyZWFtLiBiYWNrdXAtMiBp
cyBvdXIgZG93bnN0cmVhbS4gbmJkIGdhaW4gb2YNCmJhY2t1cC0yIGlzIHJlbGF0ZWQgdG8gYXN5
bmMgcmVxdWVzdHMuIHNzZCBnYWluIGZvciBiYWNrdXAtMSBpcyByZWxhdGVkIHRvDQpjb3B5IG9m
ZmxvYWRpbmcgKHdvdywgaXQgd29ya3MhKS4NCg0KPiANCj4gWW91cnMsDQo+IEFsZWtzYW5kYXIN
Cj4gDQo+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgzKToNCj4+ICAgIHB5dGhvbjog
YWRkIHNpbXBsZWJlbmNoLnB5DQo+PiAgICBweXRob246IGFkZCBxZW11L2JlbmNoX2Jsb2NrX2pv
Yi5weQ0KPj4gICAgcHl0aG9uOiBhZGQgZXhhbXBsZSB1c2FnZSBvZiBzaW1wbGViZW5jaA0KPj4N
Cj4+ICAgcHl0aG9uL2JlbmNoLWV4YW1wbGUucHkgICAgICAgIHwgIDgwICsrKysrKysrKysrKysr
KysrKysrKw0KPj4gICBweXRob24vcWVtdS9iZW5jaF9ibG9ja19qb2IucHkgfCAxMTUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgcHl0aG9uL3NpbXBsZWJlbmNoLnB5ICAgICAg
ICAgIHwgMTI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVz
IGNoYW5nZWQsIDMyMyBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBweXRo
b24vYmVuY2gtZXhhbXBsZS5weQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgcHl0aG9uL3FlbXUv
YmVuY2hfYmxvY2tfam9iLnB5DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBweXRob24vc2ltcGxl
YmVuY2gucHkNCj4+DQo+PiAtLQ0KPj4gMi4xOC4wDQo+Pg0KPj4NCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

