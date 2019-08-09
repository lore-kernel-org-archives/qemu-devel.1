Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6EC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0937B2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aO919Try"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0937B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw25h-0001dh-CH
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw259-0000w5-Ly
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw258-00016X-By
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:25:11 -0400
Received: from mail-eopbgr60139.outbound.protection.outlook.com
 ([40.107.6.139]:39586 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw257-00015P-HS; Fri, 09 Aug 2019 06:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHZesDv+4nUEmzK/jbzflIJf1gF8pem6ILP7Ck+WpE50ZeZAYO5MY/2kA+AhfVoJWSnZO8Zmp8aOQvzPBKzt5qy8SAqeWUJuEjpKp8nw6GP2hIXDUbxq5e2sh483IELYf6kkJ9iAs4yB4xypSZZGzjgNmLKvIO3d4Yh+CuKqq4/8OSSTUGAuNpQ7H3HDUS+Sw4ZDZ5AcEAmFyKX28h1+Ai8aZv0OfBztFkX2yjJ0YmOxjIrMYfkvjiDTUuTMADwbI7awvnh+EcylI/a/WFh0LYpuTU3JZUEKe9U5YnNI8OsmF+/KbLwJ4kNTf1YPBRs2T+BdQYmBD+4Gl2oHwIytIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOuW/6YNAR6+n1JENumTWI2AZoZWUUzPifRXe+WnKPw=;
 b=oRFiE/VRsmbx043PHZhwFx9kD+hWgrYHQdq/rDqnCBAmsQP0uUsWqUpXNgduEmLHM1VO0PWEdXlP7cFgYGOnZF8gQNACH/QrPr35ApC5rJ8nbfx3AY95Ef6at2621CPi4sICKAslCDxt7iH94uqGt028OEjkRNYeG+U4lZUQC/kxwTgZPrYd4FPpv+HAh8vx30tvPlPjZm8OhkrgVxg3rS2TGTcEvY/bZCePDiHxyiXsf4bzdF/Zr989wQ0DVVniSVAKzSwaMHbURD+IJLXCWM8JVvihIa8uvFeYJqQpXcqO3EB2FlOxAJzpAVsbBgBXt7hNGIbNb5ecGRJwNtKuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOuW/6YNAR6+n1JENumTWI2AZoZWUUzPifRXe+WnKPw=;
 b=aO919TryLbFMVt0gyqT0mF7MRQGfEYgy2JB1yXWi5IgrNKjO8Mnx3ml3uNEIkQBferPZf2eXhvDS2ydcikL8yshWgkyeyHsQrDTmqbhvbnVBFXhTu/BvCdVhjgozsadw5/J4JjpylZeXqOM2Kkbrzls5tJ2H2ysPLJZsjgkKKVA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3931.eurprd08.prod.outlook.com (20.179.10.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 10:25:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 10:25:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 4/8] block/backup: improve unallocated clusters skipping
Thread-Index: AQHVTPc5s/npQfEhfkGoVKrBP/0JC6bv+juAgAKsOgD//+SigIAAFGOA
Date: Fri, 9 Aug 2019 10:25:06 +0000
Message-ID: <d1561cac-8eb1-1573-eb12-0eb4f30d56b9@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
 <5413f403-e83e-207d-fef0-61a2908d397a@virtuozzo.com>
In-Reply-To: <5413f403-e83e-207d-fef0-61a2908d397a@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0368.eurprd05.prod.outlook.com
 (2603:10a6:7:94::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809132503841
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dc191ee-351f-4ae4-6367-08d71cb3d940
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3931; 
x-ms-traffictypediagnostic: DB8PR08MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB393190C19C0298470E2F2BB9C1D60@DB8PR08MB3931.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39850400004)(199004)(189003)(478684002)(66946007)(229853002)(66476007)(8676002)(64756008)(7736002)(66066001)(81166006)(53936002)(4326008)(6436002)(81156014)(66446008)(110136005)(31686004)(107886003)(54906003)(6246003)(478600001)(66556008)(2906002)(53546011)(6506007)(386003)(6116002)(3846002)(6512007)(14454004)(305945005)(36756003)(25786009)(476003)(31696002)(71190400001)(8936002)(6486002)(486006)(316002)(86362001)(2616005)(71200400001)(99286004)(11346002)(26005)(102836004)(2501003)(446003)(14444005)(256004)(52116002)(5660300002)(186003)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3931;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a05QFhFRWttMBnkygoou49UUt5DscEXeP7G0Yqd3UNpL3a7Wh/AiT6ht3IFamSjuUMo6Nc2I6K0DAGHqAM/y2Vb9LdY/rqG5aN56nXi8tsGR/yGNV5OI8/qigeESQASFdVc/XnC7zxN08yBW3wHTWRMZr8Jr+r6F3bpgGLM6S8uiCUFSanvZM6bQ6r06c9iuPaWI+pVjdthzWI3q2i1EIO49I7CLp9ZAWAAuc04jlr3YE/yx8CxwWphqjoaauJ8MrnzS+lao9yO9OeHBnD6KHolWweaOhh9DXYGtRQpjlQCkYWnEOhteo1VWqmMBHCMnzBhopw0BfR+yMhd1linwb2lLmqOMhLsDP958ZsAzOELXLokO/p2RqHtX2QwSd4Mjy6mVPQIruIpymVBdmmr84uUOU3owJSRtWRSgvgqYXn0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F8D5BE0108B93449B870262C4EFF39A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc191ee-351f-4ae4-6367-08d71cb3d940
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 10:25:06.7635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8nqmyJ4KLiDbW49sXJyA0fCPdeM0lwdhpC9OE3KFE2HhKaI7YUrM4wK9mI9o/PaGenbeuDBLPhbJrhZ96Cevs/kV6W15J9Gn7NDmRDf+yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3931
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.139
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxMjoxMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDkuMDguMjAxOSAxMDo1MCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDA3LjA4LjIwMTkgMjE6MDEsIE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwNy4wOC4xOSAxMDow
NywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gTGltaXQgYmxvY2tf
c3RhdHVzIHF1ZXJ5aW5nIHRvIHJlcXVlc3QgYm91bmRzIG9uIHdyaXRlIG5vdGlmaWVyIHRvDQo+
Pj4+IGF2b2lkIGV4dHJhIHNlZWtpbmcuDQo+Pj4NCj4+PiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB0
aGlzIHJlYXNvbmluZy7CoCBDaGVja2luZyB3aGV0aGVyIHNvbWV0aGluZyBpcw0KPj4+IGFsbG9j
YXRlZCBmb3IgcWNvdzIgc2hvdWxkIGp1c3QgbWVhbiBhbiBMMiBjYWNoZSBsb29rdXAuwqAgV2hp
Y2ggd2UgaGF2ZQ0KPj4+IHRvIGRvIGFueXdheSB3aGVuIHdlIHRyeSB0byBjb3B5IGRhdGEgb2Zm
IHRoZSBzb3VyY2UuDQo+Pg0KPj4gQnV0IGZvciByYXcgaXQncyBzZWVraW5nLiBJIHRoaW5rIHdl
IGp1c3Qgc2hvdWxkbid0IGRvIGFueSB1bm5lY2Vzc2FyeSBvcGVyYXRpb25zDQo+PiBpbiBjb3B5
LWJlZm9yZS13cml0ZSBoYW5kbGluZy4gU28gaW5zdGVhZCBvZiBjYWxsaW5nDQo+PiBibG9ja19z
dGF0dXMocmVxdWVzdF9zdGFydCwgZGlza19lbmQpIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gY2Fs
bA0KPj4gYmxvY2tfc3RhdHVzKHJlcXVlc3Rfc3RhcnQsIHJlcXVlc3RfZW5kKS4gQW5kIGl0IGlz
IG1vcmUgYXBwbGljYWJsZSBmb3IgcmV1c2luZyB0aGlzDQo+PiBjb2RlIHRvby4NCj4+DQo+Pj4N
Cj4+PiBJIGNvdWxkIHVuZGVyc3RhbmQgc2F5aW5nIHRoaXMgbWFrZXMgdGhlIGNvZGUgZWFzaWVy
LCBidXQgSSBhY3R1YWxseQ0KPj4+IGRvbuKAmXQgdGhpbmsgaXQgZG9lcy7CoCBJZiB5b3UgaW1w
bGVtZW50ZWQgY2hlY2tpbmcgdGhlIGFsbG9jYXRpb24gc3RhdHVzDQo+Pj4gb25seSBmb3IgYXJl
YXMgd2hlcmUgdGhlIGJpdG1hcCBpcyByZXNldCAod2hpY2ggSSB0aGluayB0aGlzIHBhdGNoDQo+
Pj4gc2hvdWxkKSwgdGhlbiBpdOKAmWQganVzdCBkdXBsaWNhdGUgdGhlIGV4aXN0aW5nIGxvb3Au
DQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgYmxvY2svYmFja3Vw
LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+IGlu
ZGV4IDExZTI3Yzg0NGQuLmE0ZDM3ZDJkNjIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1
cC5jDQo+Pj4+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4NCj4+PiBbLi4uXQ0KPj4+DQo+Pj4+
IEBAIC0yNjcsNiArMjY3LDE4IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19j
b3coQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4gwqDCoMKgwqDCoCB3YWl0X2Zvcl9vdmVybGFw
cGluZ19yZXF1ZXN0cyhqb2IsIHN0YXJ0LCBlbmQpOw0KPj4+PiDCoMKgwqDCoMKgIGNvd19yZXF1
ZXN0X2JlZ2luKCZjb3dfcmVxdWVzdCwgam9iLCBzdGFydCwgZW5kKTsNCj4+Pj4gK8KgwqDCoCBp
ZiAoam9iLT5pbml0aWFsaXppbmdfYml0bWFwKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpbnQ2
NF90IG9mZiwgY2h1bms7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAob2ZmID0g
b2Zmc2V0OyBvZmZzZXQgPCBlbmQ7IG9mZnNldCArPSBjaHVuaykgew0KPj4+DQo+Pj4gVGhpcyBp
cyB3aGF0IEnigJltIHJlZmVycmluZyB0bywgSSB0aGluayB0aGlzIGxvb3Agc2hvdWxkIHNraXAg
YXJlYXMgdGhhdA0KPj4+IGFyZSBjbGVhbi4NCj4+DQo+PiBBZ3JlZSwgd2lsbCBkby4NCj4gDQo+
IEhtbSwgSSByZW1lbWJlcmVkIHRoYXQgSSB0aG91Z2h0IG9mIGl0LCBidXQgZGVjaWRlZCB0aGF0
IGl0IG1heSBiZSBub3QgZWZmaWNpZW50IGlmDQo+IGJpdG1hcCBmcmFnbWVudGF0aW9uIGlzIGhp
Z2hlciB0aGFuIGJsb2NrLXN0YXR1cyBmcmFnbWVudGF0aW9uLiBTbywgaWYgd2UgZG9uJ3Qga25v
dw0KPiB3aGF0IGlzIGJldHRlciwgbGV0J3Mga2VlcCBzaW1wbGVyIGNvZGUuDQoNCkhtbTIsIGJ1
dCBJIHNlZSBhIGNvbXByb21pc2UgKG1heSBiZSB5b3UgbWVhbnQgZXhhY3RseSB0aGlzKTogbm90
IHVzaW5nIG5leHQgemVybyBhcyBsaW1pdA0KKGJ1dCBhbHdheXMgdXNlIHJlcXVlc3RfZW5kKSwg
YnV0IGJlZm9yZSBlYWNoIGl0ZXJhdGlvbiBza2lwIHRvIG5leHRfZGlydHkuDQoNCj4gDQo+Pg0K
Pj4+DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGJhY2t1cF9iaXRtYXBfcmVz
ZXRfdW5hbGxvY2F0ZWQoam9iLCBvZmYsIGVuZCAtIG9mZiwgJmNodW5rKTsNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjaHVuayA9IGpvYi0+Y2x1c3Rlcl9zaXplOw0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+ICvCoMKgwqAgfQ0K
Pj4+PiArwqDCoMKgIHJldCA9IDA7DQo+Pj4+ICsNCj4+Pj4gwqDCoMKgwqDCoCB3aGlsZSAoc3Rh
cnQgPCBlbmQpIHsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGludDY0X3QgZGlydHlfZW5kOw0K
Pj4+PiBAQCAtMjc2LDE1ICsyODgsNiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBf
ZG9fY293KEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnRpbnVlOyAvKiBhbHJlYWR5IGNvcGllZCAqLw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGpvYi0+aW5pdGlhbGl6aW5nX2JpdG1hcCkg
ew0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiYWNrdXBfYml0bWFwX3Jlc2V0
X3VuYWxsb2NhdGVkKGpvYiwgc3RhcnQsICZza2lwX2J5dGVzKTsNCj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHJldCA9PSAwKSB7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdHJhY2VfYmFja3VwX2RvX2Nvd19za2lwX3JhbmdlKGpvYiwgc3RhcnQsIHNraXBf
Ynl0ZXMpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0ICs9IHNr
aXBfYnl0ZXM7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIH0N
Cj4+Pj4gLQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGlydHlfZW5kID0gYmRydl9kaXJ0eV9i
aXRtYXBfbmV4dF96ZXJvKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LA0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmQgLSBzdGFydCk7DQo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoZGlydHlfZW5kIDwgMCkgew0KPj4+DQo+Pj4gSG0sIHlvdSByZXNv
bHZlZCB0aGF0IGNvbmZsaWN0IGRpZmZlcmVudGx5IGZyb20gbWUuDQo+Pj4NCj4+PiBJIGRlY2lk
ZWQgdGhlIGJkcnZfZGlydHlfYml0bWFwX25leHRfemVybygpIGNhbGwgc2hvdWxkIGdvIGJlZm9y
ZSB0aGUNCj4+PiBiYWNrdXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKCkgY2FsbCBzbyB0aGF0
IHdlIGNhbiB0aGVuIGRvIGENCj4+Pg0KPj4+IMKgwqAgZGlydHlfZW5kID0gTUlOKGRpcnR5X2Vu
ZCwgc3RhcnQgKyBza2lwX2J5dGVzKTsNCj4+Pg0KPj4+IGJlY2F1c2Ugd2UgcHJvYmFibHkgZG9u
4oCZdCB3YW50IHRvIGNvcHkgYW55dGhpbmcgcGFzdCB3aGF0DQo+Pj4gYmFja3VwX2JpdG1hcF9y
ZXNldF91bmFsbG9jYXRlZCgpIGhhcyBpbnF1aXJlZC4NCj4+Pg0KPj4+DQo+Pj4gQnV0IHRoZW4g
YWdhaW4gdGhpcyBwYXRjaCBlbGltaW5hdGVzIHRoZSBkaWZmZXJlbmNlIGFueXdheS4uLg0KPj4+
IMKgPg0KPj4+PiBAQCAtNTQ2LDcgKzU0OSw4IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJh
Y2t1cF9ydW4oSm9iICpqb2IsIEVycm9yICoqZXJycCkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiYWNrdXBfYml0bWFwX3Jl
c2V0X3VuYWxsb2NhdGVkKHMsIG9mZnNldCwgJmNvdW50KTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0ID0gYmFja3VwX2JpdG1hcF9yZXNldF91bmFsbG9jYXRlZChzLCBvZmZzZXQs
IHMtPmxlbiAtIG9mZnNldCwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZjb3VudCk7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChy
ZXQgPCAwKSB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBv
dXQ7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4NCj4+Pg0KPj4+DQo+
Pg0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

