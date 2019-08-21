Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD516C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975ED206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sb8vdsKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975ED206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Pe9-0000KE-P2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0Pcz-0007n9-AD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0Pcw-0007RR-SC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:22:12 -0400
Received: from mail-db3eur04on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70a]:32590
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i0Pcw-0007QH-6k; Wed, 21 Aug 2019 08:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvxZfnK75MEZRY9uWnNDhxsGaF5+TkLn5ou+3tTRvJiEhmIFN2HRNBZtpwxfB2ALPxO3GcQgDNaa/F45D/K6qcHHY/1uORQFT1jvabvSDuEy/DdZGPLuvWT+KvorpkWzWNP5wNnJxPo1th25+LpKgky+aOuy7t7Oew23ClaY04L8JfUrKTWCA9TtVibFzKRMQbiWTB4Uo81Fem1NthOFyWGNsb1uJprpIjqIDNZRI3htKW7DOkeILsKv9Iw4cfnFgcVSwmh8Y/8X063QmuSDj1tYXrHZlyDoiblQcOLm3ZOp+908HhMOvNkYAD5osdDhm/kSbJXfe1JDGgTAkmR9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R14+CG5/UdoU2aEWdM8fnH6vNAyblcBN7MUy7+/4Udg=;
 b=ObbDaSKQRQfQcoJj17bfLYm09wgZDLSBSx3v8MYMk0DITGaxq9CPJ/mLyNkPORI1SLv8QOMBa33gwN4bNxpH8yRWuhnduX3VsPVjWrM9tkIYbVtCm4EYX7XmOj/QN8jz/gA8v2TyXwUMHknkI5z5gkaW+1YNvExma4Ld+XXEX13+4SwQZbI8OM/fecZhLbc1qG1/3i9vlrPhZZwI4CIYagy3UBJ7ckUNPHV3ttMYD2m+z85zZHQeMrpCwnpFhzC2rRc25/OntIfYWTzbUv+pbDZB61d1WLH9+O6V8dv/3smG95uHnA7gbdQ4VtNv4NVpLlWNFXfKCP4L0zz0AEYSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R14+CG5/UdoU2aEWdM8fnH6vNAyblcBN7MUy7+/4Udg=;
 b=Sb8vdsKIfi/yLOeW3A67eIY0FZ4lKntRd3Et4C2VSmkPEQ0JU/0iTePUASBn/abUoBnePfQru2bQbN4KdW+wZHx8OCQVcUn28ceveP8Iss9zpI4070NJRFRbQxZI9fGbvEx9FjsuRmXmcWFjHW1jANFxtYZCVu7wVuE5doZ4cmQ=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB4818.eurprd08.prod.outlook.com (10.255.98.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Wed, 21 Aug 2019 12:22:06 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 12:22:06 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 9/9] qapi: query-blockstat: add driver specific
 file-posix stats
Thread-Index: AQHVC/RUe8c1xWymNEa1To8CIBQlnKb4aaeAgA2d0gCAAAXIgIAAEOsA
Date: Wed, 21 Aug 2019 12:22:05 +0000
Message-ID: <394d5d85-8d9b-fd84-3ede-a826b6721ed8@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
 <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
 <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>
 <57ec1cb0-107c-b811-b59c-992ffa5e2ed4@redhat.com>
In-Reply-To: <57ec1cb0-107c-b811-b59c-992ffa5e2ed4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9e1e468-f48f-4eb7-0384-08d726322df3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB4818; 
x-ms-traffictypediagnostic: AM6PR08MB4818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB481836D87C0C236F25D59BEEF8AA0@AM6PR08MB4818.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39850400004)(136003)(366004)(346002)(52314003)(199004)(189003)(36756003)(76176011)(476003)(64756008)(54906003)(11346002)(31686004)(256004)(186003)(71190400001)(229853002)(14444005)(86362001)(3846002)(486006)(107886003)(8676002)(14454004)(66446008)(6246003)(2616005)(66066001)(31696002)(99286004)(446003)(2501003)(4326008)(110136005)(6506007)(8936002)(386003)(102836004)(6116002)(53936002)(81166006)(81156014)(71200400001)(6512007)(7736002)(25786009)(2906002)(44832011)(305945005)(316002)(52116002)(66556008)(5660300002)(478600001)(53546011)(66946007)(6486002)(26005)(66476007)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4818;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x4vtDUaSb4oKdr0WCCmtF32nT+t/NPMWT9alw6ogkWsJRSN/CqVq2nPQKjtzCXo23CHP0ju7SHIE0YpPyKnO6Ctt2n21o2DwQ2HTUUDnKyTw7+VtWEcLEfyibcRjo9FE3rvVX1ipWDWGFXGba3ZJ9nTKttz4VFK/vtXZN3CUxcRF6QWMGUKMgKk4SWrtDZM7s1kr0HqsYoA0knL8jGzJABz6ZcwJDUmqDSYmix482GYPh0IfTSd2lj/nTZo7qujth2cxzIUUjNEXbMJ2eDzyY0bU7+h9pyAvfTtvP3egL3XsMrc5So9hgU/+30SP/lUvVKSvjZ/4Es7xurEizdYPAlgO1/qkEXFxT6GJX9QIrnjqaHqh34swi3VbbP8yvuFKtBer3G4/cLUKbUDv4fRxtUIdKbIvrLWZuCvfL4cVJqc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9AA0AB4E2DCC04583C6FA97C00E1760@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e1e468-f48f-4eb7-0384-08d726322df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 12:22:05.9554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHYS5piBMJXELCumKq14Xs1cUBlfRY+HkhjCyQpi3E6RhKgugffIQrOn9QU0smq/+6K6JHqREokMi+uDguWjPeSznig6H6DoLnucjD1mNgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4818
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::70a
Subject: Re: [Qemu-devel] [PATCH v8 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
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
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjEvOC8yMDE5IDI6MjEgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjEuMDguMTkgMTM6
MDAsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiBPbiAxMi84LzIwMTkgMTA6MDQgUE0sIE1heCBS
ZWl0eiB3cm90ZToNCj4+PiBPbiAxNi4wNS4xOSAxNjozMywgQW50b24gTmVmZWRvdiB3cm90ZToN
Cj4+Pj4gQSBibG9jayBkcml2ZXIgY2FuIHByb3ZpZGUgYSBjYWxsYmFjayB0byByZXBvcnQgZHJp
dmVyLXNwZWNpZmljDQo+Pj4+IHN0YXRpc3RpY3MuDQo+Pj4+DQo+Pj4+IGZpbGUtcG9zaXggZHJp
dmVyIG5vdyByZXBvcnRzIGRpc2NhcmQgc3RhdGlzdGljcw0KPj4+Pg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQo+Pj4+IFJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pj4+IEFja2VkLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhh
dC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgIHwgMzgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgaW5jbHVkZS9i
bG9jay9ibG9jay5oICAgICB8ICAxICsNCj4+Pj4gICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQu
aCB8ICAxICsNCj4+Pj4gICAgYmxvY2suYyAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrKysr
Kw0KPj4+PiAgICBibG9jay9maWxlLXBvc2l4LmMgICAgICAgIHwgMzggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4+Pj4gICAgYmxvY2svcWFwaS5jICAgICAgICAgICAg
ICB8ICA1ICsrKysrDQo+Pj4+ICAgIDYgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLWNv
cmUuanNvbiBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+Pj4+IGluZGV4IDU1MTk0Zjg0Y2UuLjM2
OGUwOWFlMzcgMTAwNjQ0DQo+Pj4+IC0tLSBhL3FhcGkvYmxvY2stY29yZS5qc29uDQo+Pj4+ICsr
KyBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+Pj4+IEBAIC05NTYsNiArOTU2LDQxIEBADQo+Pj4+
ICAgICAgICAgICAgICAgJyp3cl9sYXRlbmN5X2hpc3RvZ3JhbSc6ICdCbG9ja0xhdGVuY3lIaXN0
b2dyYW1JbmZvJywNCj4+Pj4gICAgICAgICAgICAgICAnKmZsdXNoX2xhdGVuY3lfaGlzdG9ncmFt
JzogJ0Jsb2NrTGF0ZW5jeUhpc3RvZ3JhbUluZm8nIH0gfQ0KPj4+PiAgICANCj4+Pj4gKyMjDQo+
Pj4+ICsjIEBCbG9ja1N0YXRzU3BlY2lmaWNGaWxlOg0KPj4+PiArIw0KPj4+PiArIyBGaWxlIGRy
aXZlciBzdGF0aXN0aWNzDQo+Pj4+ICsjDQo+Pj4+ICsjIEBkaXNjYXJkLW5iLW9rOiBUaGUgbnVt
YmVyIG9mIHN1Y2Nlc3NmdWwgZGlzY2FyZCBvcGVyYXRpb25zIHBlcmZvcm1lZCBieQ0KPj4+PiAr
IyAgICAgICAgICAgICAgICAgdGhlIGRyaXZlci4NCj4+Pj4gKyMNCj4+Pj4gKyMgQGRpc2NhcmQt
bmItZmFpbGVkOiBUaGUgbnVtYmVyIG9mIGZhaWxlZCBkaXNjYXJkIG9wZXJhdGlvbnMgcGVyZm9y
bWVkIGJ5DQo+Pj4+ICsjICAgICAgICAgICAgICAgICAgICAgdGhlIGRyaXZlci4NCj4+Pj4gKyMN
Cj4+Pj4gKyMgQGRpc2NhcmQtYnl0ZXMtb2s6IFRoZSBudW1iZXIgb2YgYnl0ZXMgZGlzY2FyZGVk
IGJ5IHRoZSBkcml2ZXIuDQo+Pj4+ICsjDQo+Pj4+ICsjIFNpbmNlOiA0LjENCj4+Pj4gKyMjDQo+
Pj4+ICt7ICdzdHJ1Y3QnOiAnQmxvY2tTdGF0c1NwZWNpZmljRmlsZScsDQo+Pj4+ICsgICdkYXRh
Jzogew0KPj4+PiArICAgICAgJ2Rpc2NhcmQtbmItb2snOiAndWludDY0JywNCj4+Pj4gKyAgICAg
ICdkaXNjYXJkLW5iLWZhaWxlZCc6ICd1aW50NjQnLA0KPj4+PiArICAgICAgJ2Rpc2NhcmQtYnl0
ZXMtb2snOiAndWludDY0JyB9IH0NCj4+Pj4gKw0KPj4+PiArIyMNCj4+Pj4gKyMgQEJsb2NrU3Rh
dHNTcGVjaWZpYzoNCj4+Pj4gKyMNCj4+Pj4gKyMgQmxvY2sgZHJpdmVyIHNwZWNpZmljIHN0YXRp
c3RpY3MNCj4+Pj4gKyMNCj4+Pj4gKyMgU2luY2U6IDQuMQ0KPj4+PiArIyMNCj4+Pj4gK3sgJ3Vu
aW9uJzogJ0Jsb2NrU3RhdHNTcGVjaWZpYycsDQo+Pj4+ICsgICdiYXNlJzogeyAnZHJpdmVyJzog
J0Jsb2NrZGV2RHJpdmVyJyB9LA0KPj4+PiArICAnZGlzY3JpbWluYXRvcic6ICdkcml2ZXInLA0K
Pj4+PiArICAnZGF0YSc6IHsNCj4+Pj4gKyAgICAgICdmaWxlJzogJ0Jsb2NrU3RhdHNTcGVjaWZp
Y0ZpbGUnLA0KPj4+PiArICAgICAgJ2hvc3RfZGV2aWNlJzogJ0Jsb2NrU3RhdHNTcGVjaWZpY0Zp
bGUnIH0gfQ0KPj4+DQo+Pj4gSSB3b3VsZCBsaWtlIHRvIHVzZSB0aGVzZSBjaGFuY2UgdG8gY29t
cGxhaW4gdGhhdCBJIGZpbmQgdGhpcyBhd2t3YXJkLg0KPj4+IE15IHByb2JsZW0gaXMgdGhhdCBJ
IGRvbuKAmXQga25vdyBob3cgYW55IG1hbmFnZW1lbnQgYXBwbGljYXRpb24gaXMNCj4+PiBzdXBw
b3NlZCB0byByZWFzb25hYmx5IGNvbnN1bWUgdGhpcy4gIEl0IGZlZWxzIHdlaXJkIHRvIHBvdGVu
dGlhbGx5IGhhdmUNCj4+PiB0byByZWNvZ25pemUgdGhlIHJlc3VsdCBmb3IgZXZlcnkgYmxvY2sg
ZHJpdmVyLg0KPj4+DQo+Pj4gSSB3b3VsZCBub3cgbGlrZSB0byBub3RlIHRoYXQgSeKAmW0gY2xl
YXJseSBub3QgaW4gYSBwb3NpdGlvbiB0byBibG9jaw0KPj4+IHRoaXMgYXQgdGhpcyBwb2ludCwg
YmVjYXVzZSBJ4oCZdmUgaGFkIGEgeWVhciB0byBkbyBzbywgSSBkaWRu4oCZdCwgc28gaXQNCj4+
PiB3b3VsZCBiZSB1bmZhaXIgdG8gZG8gaXQgbm93Lg0KPj4+DQo+Pj4gKFN0aWxsLCBJIGZlZWwg
bGlrZSBpZiBJIGhhdmUgYSBjb25jZXJuLCBJIHNob3VsZCByYWlzZSBpdCwgZXZlbiBpZiBpdOKA
mXMNCj4+PiB0b28gbGF0ZS4pDQo+Pj4NCj4+PiBJIGtub3cgTWFya3VzIGhhcyBwcm9wb3NlZCB0
aGlzLCBidXQgSSBkb27igJl0IHVuZGVyc3RhbmQgd2h5LiAgSGUgc2V0DQo+Pj4gSW1hZ2VJbmZv
U3BlY2lmaWMgYXMgYSBwcmVjZWRlbmNlLCBidXQgdGhhdCBoYXMgYSBkaWZmZXJlbnQgcmVhc29u
aW5nDQo+Pj4gYmVoaW5kIGl0LiAgVGhlIHBvaW50IGZvciB0aGF0IGlzIHRoYXQgaXQgc2ltcGx5
IGRvZXNu4oCZdCB3b3JrIGFueSBvdGhlcg0KPj4+IHdheSwgYmVjYXVzZSBpdCBpcyBjbGVhcmx5
IGZvcm1hdC1zcGVjaWZpYyBpbmZvcm1hdGlvbiB0aGF0IGNhbm5vdCBiZQ0KPj4+IHNoYXJlZCBi
ZXR3ZWVuIGRyaXZlcnMuICBBbnl0aGluZyB0aGF0IGNhbiBiZSBzaGFyZWQgaXMgcHV0IGludG8N
Cj4+PiBJbWFnZUluZm8gKGxpa2UgdGhlIGNsdXN0ZXIgc2l6ZSkuDQo+Pj4NCj4+PiBXZSBoYXZl
IHRoZSBzYW1lIGNvbnN0ZWxsYXRpb24gaGVyZSwgQmxvY2tTdGF0cyBjb250YWlucyBjb21tb24g
c3R1ZmYsDQo+Pj4gYW5kIEJsb2NrU3RhdHNTcGVjaWZpYyB3b3VsZCBjb250YWluIGRyaXZlci1z
cGVjaWZpYyBzdHVmZi4gIEJ1dCB0byBtZSwNCj4+PiBCbG9ja1N0YXRzU3BlY2lmaWNGaWxlIGRv
ZXNu4oCZdCBsb29rIHZlcnkgc3BlY2lhbC4gIEl0IGxvb2tzIGxpa2UgaXQganVzdA0KPj4+IGR1
cGxpY2F0ZXMgZmllbGRzIHRoYXQgYWxyZWFkeSBleGlzdCBpbiBCbG9ja0RldmljZVN0YXRzLg0K
Pj4+DQo+Pj4NCj4+PiAoRnVydGhlcm1vcmUsIG1vc3Qgb2YgSW1hZ2VJbmZvU3BlY2lmaWMgaXMg
YWN0dWFsbHkgbm90IHVzZWZ1bCB0bw0KPj4+IG1hbmFnZW1lbnQgc29mdHdhcmUsIGJ1dCBvbmx5
IGFzIGFuIGluZm9ybWF0aW9uIGZvciBodW1hbnMgKGFuZCBoYXZpbmcNCj4+PiBzdWNoIGEgc3Ry
dWN0dXJlIGZvciB0aGF0IGlzIHBlcmZlY3RseSBmaW5lKS4gIEJ1dCB0aGVzZSBzdGF0cyBkb27i
gJl0DQo+Pj4gcmVhbGx5IGxvb2sgbGlrZSBzb21ldGhpbmcgZm9yIGltbWVkaWF0ZSBodW1hbiBj
b25zdW1wdGlvbi4pDQo+Pj4NCj4+Pg0KPj4+IFNvIEkgd29uZGVyIHdoeSB5b3UgZG9u4oCZdCBq
dXN0IHB1dCB0aGlzIGluZm9ybWF0aW9uIGludG8NCj4+PiBCbG9ja0RldmljZVN0YXRzLiAgRnJv
bSB3aGF0IEkgY2FuIHRlbGwgbG9va2luZyBhdA0KPj4+IGJkcnZfcXVlcnlfYmRzX3N0YXRzKCkg
YW5kIHFtcF9xdWVyeV9ibG9ja3N0YXRzKCksIHRoZSBAc3RhdHMgZmllbGQgaXMNCj4+PiBjdXJy
ZW50bHkgY29tcGxldGVseSAwIGlmIEBxdWVyeS1ub2RlcyBpcyB0cnVlLg0KPj4+DQo+Pj4gKEZ1
cnRoZXJtb3JlLCBJIHdvbmRlciB3aGV0aGVyIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gcmUtYWRk
DQo+Pj4gQmxvY2tBY2N0U3RhdHMgdG8gZWFjaCBCRFMgYW5kIHRoZW4gbGV0IHRoZSBnZW5lcmlj
IGJsb2NrIGNvZGUgZG8gdGhlDQo+Pj4gYWNjb3VudGluZyBvbiBpdC4gIEkgbW92ZWQgaXQgdG8g
dGhlIEJCIGluIDdmMGU5ZGE2ZjEzIGJlY2F1c2Ugd2UgZGlkbuKAmXQNCj4+PiBjYXJlIGFib3V0
IG5vZGUtbGV2ZWwgaW5mb3JtYXRpb24gYXQgdGhlIHRpbWUsIGJ1dCBtYXliZSBpdOKAmXMgdGlt
ZSB0bw0KPj4+IHJlY29uc2lkZXIuKQ0KPj4+DQo+Pj4NCj4+PiBBbnl3YXksIGFzIEnigJl2ZSBz
YWlkLCBJIGZ1bGx5IHVuZGVyc3RhbmQgdGhhdCBjb21wbGFpbmluZyBhYm91dCBhIGRlc2lnbg0K
Pj4+IGRlY2lzaW9uIGlzIGp1c3QgdW5mYWlyIGF0IHRoaXMgcG9pbnQsIHNvIHRoaXMgaXMgbm90
IGEgdmV0by4NCj4+Pg0KPj4NCj4+IGhpIQ0KPj4NCj4+IEhhdmluZyBib3RoICJ1bm1hcCIgYW5k
ICJkaXNjYXJkIiBzdGF0cyBpbiB0aGUgc2FtZSBsaXN0IGZlZWxzIHdlaXJkLg0KPj4gVGhlIGlu
dGVudGlvbiBpcyB0aGF0IHVubWFwIGJlbG9uZ3MgdG8gdGhlIGRldmljZSBsZXZlbCwgYW5kIGRp
c2NhcmQgaXMNCj4+IGZyb20gdGhlIGRyaXZlciBsZXZlbC4NCj4gDQo+IFNvcnJ5LCB3aGF0IEkg
bWVhbnQgd2FzbuKAmXQgYWRkaW5nIGEgc2VwYXJhdGUg4oCcZGlzY2FyZOKAnSBncm91cCwgYnV0
IGp1c3QNCj4gZmlsbGluZyBpbiB0aGUgZXhpc3Rpbmcg4oCcdW5tYXDigJ0gZmllbGRzLiAgQXMg
ZmFyIGFzIEkgdW5kZXJzdGFuZCwgaWYgd2UNCj4gaGFkIEJsb2NrQWNjdFN0YXRzIGZvciBlYWNo
IEJEUywgdGhlIGZpbGUgbm9kZeKAmXMgdW5tYXAgc3RhdHMgd291bGQgYmUNCj4gdGhlIHNhbWUg
YXMgaXRzIGRpc2NhcmQgc3RhdHMsIHdvdWxkbuKAmXQgaXQ/DQo+IA0KDQpTbywgeW91IG1lYW4g
Y291bnQgaXQgYWxsIG9uIEJEUyBsZXZlbCBfaW5zdGVhZF8gb2YgU0NTSS9JREUgbGV2ZWw/DQoN
Ck5vdyBpdCdzOg0KDQogICAgICAgImRldmljZSI6ICJkcml2ZS1zY3NpMC0wLTAtMCIsDQogICAg
ICAgIm5vZGUtbmFtZSI6ICIjYmxvY2sxNTEiLA0KICAgICAgICJzdGF0cyI6IHsNCiAgICAgICAg
ICJ1bm1hcF9vcGVyYXRpb25zIjogMCwgPC0tLSBmaWxsZWQgYnkgU0NTSQ0KICAgICAgIFsuLl0N
Cg0KICAgICAgICJwYXJlbnQiOiB7DQogICAgICAgICAibm9kZS1uYW1lIjogIiNibG9jazA1NiIs
DQogICAgICAgICAic3RhdHMiOiB7DQogICAgICAgICAgICJ1bm1hcF9vcGVyYXRpb25zIjogMCwg
PC0tLSBub3QgZmlsbGVkDQoNCiAgICAgICAgICJkcml2ZXItc3RhdHMiOiB7IDwtLS0gZmlsbGVk
IGJ5IGZpbGUtcG9zaXggZHJpdmVyDQogICAgICAgICAgICJ0eXBlIjogImZpbGUiLA0KICAgICAg
ICAgICAiZGF0YSI6IHsNCiAgICAgICAgICAgICAiZGlzY2FyZF9ieXRlc19vayI6IDAsDQogICAg
ICAgICAgICAgImRpc2NhcmRfbmJfZmFpbGVkIjogMCwNCiAgICAgICAgICAgICAiZGlzY2FyZF9u
Yl9vayI6IDANCiAgICAgICAgICAgfQ0KICAgICAgICAgfQ0KICAgICAgIH0sDQoNCg0KRXZlcnkg
bGV2ZWwgbWF5IGRyb3Agc29tZSByZXF1ZXN0cyAoaS5lLiBxY293MiB3b24ndCBwYXNzIHJlcXVl
c3RzDQpzbWFsbGVyIHRoYW4gYSBjbHVzdGVyIHNpemUpIGkuZS4NCkJsb2NrQmFja2VuZCBzdGF0
cyA+PSBCRFMgZm9ybWF0IGRyaXZlciBzdGF0cyA+PSBCRFMgcHJvdG9jb2wgZHJpdmVyDQpzdGF0
cw0KDQphbmQgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGVtIChtb3N0bHkgYmV0d2VlbiB0aGUg
dG9wIGFuZCB0aGUgYm90dG9tIA0Kb25lcykgaXMgaW50ZXJlc3RpbmcgaGVyZSB0b287IGdvb2Qg
dG8ga25vdyB3aGV0aGVyIGl0J3MgYSBndWVzdCB3aG8NCmRvZXNuJ3Qgc2VuZCByZXF1ZXN0cywg
b3IgUUVNVSB0aGF0IGxpbWl0cyB0aGVtLg0KDQo+PiBOb3cgd2UgaGF2ZSBhIHNlcGFyYXRlIHN0
cnVjdHVyZSBuYW1lZCAiZHJpdmVyLQ0KPj4gc3BlY2lmaWMiLiBDb3VsZCBhbHNvIGJlIGNhbGxl
ZCAiZHJpdmVyLXN0YXRzIi4NCj4+DQo+PiBXZSBjb3VsZCBtYWtlIHRoaXMgc3RydWN0dXJlIG5v
bi1vcHRpb25hbCwgcHJlc2VudCBmb3IgYWxsIGRyaXZlcg0KPj4gdHlwZXMsIGFzIGluZGVlZCB0
aGVyZSBpcyBub3RoaW5nIHNwZWNpYWwgYWJvdXQgZGlzY2FyZCBzdGF0cy4gQnV0IHRoZW4NCj4+
IHdlIG5lZWQgc29tZSB3YXkgdG8gZGlzdGluZ3Vpc2gNCj4+ICAgIC0gZGlzY2FyZF9uYl9vayA9
PSAwIGFzIG5vIHJlcXVlc3QgcmVhY2hlZCB0aGUgZHJpdmVyIGxldmVsDQo+PiAgICAtIGRpc2Nh
cmRfbmJfb2sgPT0gMCBhcyB0aGUgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgdGhlIGFjY291bnRp
bmcNCj4gDQo+IFlvdSBjYW4gc2ltcGx5IG1ha2UgdGhlIGZpZWxkcyBvcHRpb25hbC4gIChUaGVu
IHRoZSBmaXJzdCBjYXNlIGlzDQo+IOKAnHByZXNlbnQsIGJ1dCAw4oCdLCBhbmQgdGhlIHNlY29u
ZCBpcyDigJxub3QgcHJlc2VudOKAnS4pDQo+IA0KPj4gWWVzLCBwdXR0aW5nIHRoZSBhY2NvdW50
aW5nIGluIHRoZSBnZW5lcmljIGNvZGUgd291bGQgaGVscCwgYnV0IGRvIHdlDQo+PiByZWFsbHkg
d2FudCB0byBidXJkZW4gaXQgd2l0aCBhY2NvdW50aW5nIHRvbz8gVHJhY2tpbmcgdGhhdCBlYWNo
IGFuZA0KPj4gZXZlcnkgY2FzZSBpcyBjb3ZlcmVkIHdpdGggYWxsIHRob3NlIGJsb2NrX2FjY3Rf
ZG9uZSgpIGludmFsaWQoKSBhbmQNCj4+IGZhaWxlZCgpIGNhbiByZWFsbHkgYmUgYSBwYWluLg0K
PiANCj4gVGhhdOKAmXMgaW5kZWVkIGEgcHJvYmxlbSwgeWVzLiA6LSkNCj4gDQo+PiBBbmQgd2hh
dCBhY2NvdW50aW5nIHNob3VsZCBiZSB0aGVyZT8gQWxsIHRoZSBvcGVyYXRpb25zPyBNZWFzdXJp
bmcNCj4+IGRpc2NhcmRzIGF0IGJvdGggZGV2aWNlIGFuZCBCRFMgbGV2ZWwgaXMgdXNlZnVsIHNp
bmNlIGRpc2NhcmRzIGFyZQ0KPj4gb3B0aW9uYWwuIERvdWJsZS1tZWFzdXJpbmcgcmVhZHMmd3Jp
dGVzIGlzIHByb2JhYmx5IG5vdCBzbyB1c2VmdWwgKFJNVw0KPj4gYWNjb3VudGluZz8gUmVhZCBz
dGF0cyBmb3IgdGhlIGJhY2tpbmcgaW1hZ2VzPykNCj4gDQo+IFllcywgaWYgd2UgcHV0IEJsb2Nr
QWNjdFN0YXRzIGF0IHRoZSBub2RlIGxldmVsLCB3ZSBzaG91bGQgdHJhY2sgYWxsDQo+IG9wZXJh
dGlvbnMsIEkgc3VwcG9zZS4gIFRoYXQgd291bGQgcmVxdWlyZSBhZGRpbmcgYWNjb3VudGluZyBj
b2RlIGluDQo+IG1hbnkgcGxhY2VzLCBzbyBpdCB3b3VsZG7igJl0IGJlIGVhc3ksIGNvcnJlY3Qu
DQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIHRoZSBiZXR0ZXIgc29sdXRpb24sIGJ1dCB5b3Xi
gJlyZSByaWdodCBpbiB0aGF0IGl04oCZcw0KPiBwcm9iYWJseSBub3Qgd29ydGggaXQuDQo+IA0K
PiBCdXQgSSBkbyB0aGluayBpdCB3b3VsZCBiZSBnb29kIGlmIHdlIGNvdWxkIGdldCBhd2F5IGZy
b20gYQ0KPiBkcml2ZXItc3BlY2lmaWMgc3RydWN0dXJlICh1bmxlc3Mgd2UgcmVhbGx5IG5lZWQg
aXQ7IGFuZCBJIGRvbuKAmXQgdGhpbmsNCj4gd2UgZG8gaWYgd2UganVzdCBtYWtlIHRoZSBzdGF0
cyBmaWVsZHMgb3B0aW9uYWwpLg0KPiANCg0K

