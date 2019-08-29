Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F6C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1206D2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Mhvy9nee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1206D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MFM-0007VN-3u
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3MAF-00037K-B8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3MA6-0003xU-4m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:16:37 -0400
Received: from mail-eopbgr20095.outbound.protection.outlook.com
 ([40.107.2.95]:27635 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3M9x-0003q8-5K; Thu, 29 Aug 2019 11:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBcx+6fDGreyV0UByTNSBcwllxZP45nYTsAm6CMxFWqeLUDpxolBAxG9QaihMUeZe9p4bqgkyRRm/QqEEzqLSRgqqeozM1LATawi8JQKfEhcqBEB30RtVC3ftzLezy3Cj2DwwEQKdTl4VtLmlIXWJ/fr9nypdBA8SIxDDnc736/K/3PdPDqTfYjCDSSl0CRwrMqCefGQjEqZgvCO/bKVbpE0iE+SJWfnLxiqiKhkaLMWqiaQd/1IRID9Dl3NkffB8o60OZOouMO+mnELwrg22Ofcck2JTUqKCxSfRF1SCiVpWy2SfJUiZgRwVtXhn99eR0O4pMVUZ/pcBt06TTArbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS+msOay0bM0Nvv1olEU96CpiONah5KclEpIf2/DA5s=;
 b=F96F1v1k2zMm+BXPC05BlHXohEF7d3JpKs1BxVvjEWSqrf/SvpEUhcFmlP9EItrBws0MIQRngiiUDk/40q9TN3fHXDwwVa0c3mj8PJnwRWR0F1NO9116PvP0sZwTXSHPpBl5Wiul3D37DOVspwgavze8jAejJwKqLT/NvatuDl6MGtwp5deNlT6nnzV+Yep9oL2jBt3YMX0cMzYSuk9VgFASCUDHCUBooVgNihnsRnEb8cHkQKNE3tBf54eFaD4kLYGPWYnJFxeQlPiIRMEktGS+hW6u61gQSLwL+rzgejpiI/2Y18eMGcS+VVWkU6QvZUOcB/hN+hWmwGaCqX+nbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS+msOay0bM0Nvv1olEU96CpiONah5KclEpIf2/DA5s=;
 b=Mhvy9neeUIC7bLHOUFd16cBOO7GokONi5ry5N5sh038Q7NW2MeyVuSv5S/iQeGInkfNny0dH6GV0aeRV6Zdmd7WPSlEksSoF4KGMwB6hWi2XIGy/lryB9iNHjrQ8nOBBxTen+raKK7nJNHBCgRHTLSfaKRvPO02n9OKWGUs8Ljs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4172.eurprd08.prod.outlook.com (20.179.11.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 15:16:19 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:16:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Peter Krempa <pkrempa@redhat.com>
Thread-Topic: [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26cIg2YAgAb++gCAANxRAIAAjcEAgAGVsgD//9I0gA==
Date: Thu, 29 Aug 2019 15:16:19 +0000
Message-ID: <315c4015-aa3b-ee18-e83c-83496aab62e3@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
 <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
 <ba0e7e98-d02f-3514-b435-71923a483c6e@virtuozzo.com>
 <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
 <28206440-3929-7bb5-f4ea-ee14a9018eab@virtuozzo.com>
In-Reply-To: <28206440-3929-7bb5-f4ea-ee14a9018eab@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0190.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829181617218
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10dd7fe4-3ab7-4753-d21c-08d72c93d822
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4172; 
x-ms-traffictypediagnostic: DB8PR08MB4172:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4172FDFF7B499C5EA89368E3C1A20@DB8PR08MB4172.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39850400004)(346002)(376002)(199004)(189003)(76176011)(478600001)(31696002)(107886003)(86362001)(6246003)(53936002)(52116002)(6486002)(186003)(966005)(66556008)(446003)(25786009)(14454004)(476003)(66946007)(66066001)(2616005)(486006)(26005)(4326008)(6306002)(66446008)(66476007)(6436002)(2501003)(81156014)(7736002)(54906003)(110136005)(3846002)(81166006)(229853002)(31686004)(64756008)(305945005)(102836004)(36756003)(8936002)(6116002)(11346002)(8676002)(256004)(71200400001)(71190400001)(14444005)(316002)(99286004)(2906002)(6512007)(386003)(5660300002)(53546011)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4172;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C2yglyd59I+2Y9v+Sw8MJpT3azBsQ0qD20o0P/bbJRgmGNzGGeL/hIhvEVp1u+qyajZcmmMbl6kdRWs8tt4nmCDgGDC+c6bI0QwsL9Tli0Ig2AnF4AmmkwIp1Ctr6EfNPzrA4Yx6+/EsXjv96VKB2Ukhd+Gd7nKcuFhdiqXKg97S6ocL/iK0e5o+B8enT8G6WkIPSrDOmHDGEyJWSxUuM/FWWbskiE9ZSo3UlvE1VYbbKZ4kujGeLBbEI9zaoCAf02fO44wpAgEAG5xNPrJqh2pQo7Nm7i3BMFm4EipcotD52vm3J8ZIcS8q5WxA78lWy7E/D+HKGLDcjZVPNcINww/qzbabHkPp9ackoar9i9aJi+tG3tPoEu+xj5g24ecX2cpnItyrm7aEOhYaZeDRtgDi+GvOBO9tES+0E0BOkzU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39E0E2ECC4EAE499C1191CDDDACE660@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dd7fe4-3ab7-4753-d21c-08d72c93d822
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:16:19.5951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9SrIOI0S1t78F2x0IBcTz3ugl/ecDUNJrwjUIf05k1BvrlxdpjM8GcGt8eAND68GEiAOwRXu9JYjKpG1rz2T/bftITkzxFK8mTDvG0so2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4172
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.95
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMDguMjAxOSAxODowMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjguMDguMjAxOSAyMDo0OCwgSm9obiBTbm93IHdyb3RlOg0KPj4gKFBldGVyOiBzZWFyY2ggZm9y
ICJwa3JlbXBhIiBkb3duIGJlbG93LikNCj4+DQo+PiBPbiA4LzI4LzE5IDU6MjAgQU0sIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMjcuMDguMjAxOSAyMzoxMiwgSm9o
biBTbm93IHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+PiBPbiA4LzIzLzE5IDU6MjIgQU0sIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+PiAxNC4wOC4yMDE5IDEzOjA3LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+Pj4+IFRvIGdldCByaWQgb2Yg
aW1wbGljaXQgZmlsdGVycyByZWxhdGVkIHdvcmthcm91bmRzIGluIGZ1dHVyZSBsZXQncw0KPj4+
Pj4+IGRlcHJlY2F0ZSB0aGVtIG5vdy4NCj4+Pj4+DQo+Pj4+PiBJbnRlcmVzdGluZywgY291bGQg
d2UgZGVwcmVjYXRlIGltcGxpY2l0IGZpbHRlciB3aXRob3V0IGRlcHJlY2F0aW9uIG9mIHVubmVj
ZXNzaXR5IG9mDQo+Pj4+PiBwYXJhbWV0ZXI/IEFzIGFjdHVhbGx5LCBpdCdzIGdvb2Qgd2hlbiB0
aGlzIHBhcmFtZXRlciBpcyBub3QgbmVjZXNzYXJ5LCBpbiBtb3N0IGNhc2VzDQo+Pj4+PiB1c2Vy
IGlzIG5vdCBpbnRlcmVzdGVkIGluIG5vZGUtbmFtZS4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IGh0dHBz
Oi8vZW4ud2lrdGlvbmFyeS5vcmcvd2lraS91bm5lY2Vzc2l0eSAtLSBJIGFtIHN1cnByaXNlZCB0
byBsZWFybg0KPj4+PiB0aGF0IHRoaXMgYSByZWFsIHdvcmQgaW4gdGhlIGxhbmd1YWdlIEkgc3Bl
YWsuIDopDQo+Pj4+DQo+Pj4+IEkgYXNzdW1lIHlvdSdyZSByZWZlcnJpbmcgdG8gbWFraW5nIHRo
ZSBvcHRpb25hbCBhcmd1bWVudCBtYW5kYXRvcnkuDQo+Pj4NCj4+PiBleGFjdGx5LCBpdCdzIG15
IGEgYml0ICJnb29nbGUtdHJhbnNsYXRlLWRyaXZlbiIgRW5nbGlzaCkNCj4+Pg0KPj4NCj4+IEl0
IHRlYWNoZXMgbWUgc29tZSBmdW4gd29yZHMhDQo+Pg0KPj4+Pg0KPj4+Pj4gT2J2aW91c2x5IHdl
IGNhbiBkbyB0aGUgZm9sbG93aW5nOg0KPj4+Pj4NCj4+Pj4+IDEuIEluIDQuMiB3ZSBkZXByZWNh
dGUgdW5uZWNlc3NpdHksIHdoaWNoIGltcGxpZXMgZGVwcmVjYXRpb24gb2YgaW1wbGljaXQgZmls
dGVycw0KPj4+Pj4gMi4gQWZ0ZXIgc29tZSByZWxlYXNlcyBpbiA0Lnggd2UgY2FuIGRyb3AgZGVw
cmVjYXRlZCBmdW5jdGlvbmFsaXR5LCBzbyB3ZSBkcm9wIGl0IHRvZ2V0aGVyIHdpdGgNCj4+Pj4+
IGltcGxpY2l0IGZpbHRlcnMuIEFuZCwgaW4gc2FtZSByZWxlYXNlIDQueCB3ZSByZXR1cm4gaXQg
YmFjayAoYXMgaXQncyBjb21wYXRpYmxlIGNoYW5nZSA6KQ0KPj4+Pj4gYnV0IHdpdGhvdXQgaW1w
bGljaXQgZmlsdGVycyAoc28sIGlmIGZpbHRlci1ub2RlLW5hbWUgbm90IHNwZWNpZmllZCwgd2Ug
anVzdCBjcmVhdGUNCj4+Pj4+IGV4cGxpY2l0IGZpbHRlciB3aXRoIGF1dG9nZW5lcmF0ZWQgbm9k
ZS1uYW1lKQ0KPj4+Pj4NCj4+Pj4+IFNvLCBlZmZlY3RpdmVseSB3ZSBqdXN0IGRyb3AgImRlcHJl
Y2F0aW9uIG1hcmsiIHRvZ2V0aGVyIHdpdGggaW1wbGljaXQgZmlsdGVycywgd2hpY2ggaXMgbmlj
ZQ0KPj4+Pj4gYnV0IGFjdHVhbGx5IGNvbmZ1c2luZy4NCj4+Pj4+DQo+Pj4+PiBJbnN0ZWFkLCB3
ZSBtYXkgZG8NCj4+Pj4+IDEuIEluIDQuMiBkZXByZWNhdGUNCj4+Pj4+IDIuIEluIDQueCBkcm9w
IG9wdGlvbmFsaXR5IHRvZ2V0aGVyIHdpdGggaW1wbGljaXQgZmlsdGVycw0KPj4+Pj4gMy4gSW4g
NC55ICh5ID4geCBvZiBjb3Vyc2UpIHJldHVybiBvcHRpb25hbGl0eSBiYWNrDQo+Pj4+Pg0KPj4+
Pg0KPj4+PiBBaCwgSSBzZWUgd2hhdCB5b3UncmUgZGlnZ2luZyBhdCBoZXJlIG5vdy4uLg0KPj4+
Pg0KPj4+Pj4gSXQncyBhIGJpdCBzYWZlciwgYnV0IGZvciB1c2VycyB3aG8gbWlzcyByZWxlYXNl
cyBbNC54LCA0LnkpIGl0J3Mgbm8gZGlmZmVyZW5jZS4uDQo+Pj4+Pg0KPj4+Pj4gT3Igd2UganVz
dCB3cml0ZSBpbiBzcGVjLCB0aGF0IGltcGxpY2l0IGZpbHRlcnMgYXJlIGRlcHJlY2F0ZWQ/IEJ1
dCB3ZSBoYXZlIG5vdGhpbmcgYWJvdXQgaW1wbGljaXQNCj4+Pj4+IGZpbHRlcnMgaW4gc3BlYy4g
TW9yZSBvdmVyLCB3ZSBkaXJlY3RseSB3cml0ZSB0aGF0IHdlIGhhdmUgZmlsdGVyLCBhbmQgaWYg
cGFyYW1ldGVyIGlzIG9taXR0ZWQNCj4+Pj4+IGl0J3Mgbm9kZS1uYW1lIGlzIGF1dG9nZW5lcmF0
ZWQuIFNvIGFjdHVhbGx5LCB0aGUgZmFjdCB0aGUgZmlsdGVyIGlzIGhpZGRlbiB3aGVuIGZpbHRl
ci1ub2RlLW5hbWUgaXMNCj4+Pj4+IHVuc3BlY2lmaWVkIGlzIF91bmRvY3VtZW50ZWRfLg0KPj4+
Pj4NCj4+Pj4+IFNvLCBmaW5hbGx5LCBpdCBsb29rcyBsaWtlIG5vdGhpbmcgdG8gZGVwcmVjYXRl
ZCBpbiBzcGVjaWZpY2F0aW9uLCB3ZSBjYW4ganVzdCBkcm9wIGltcGxpY2l0IGZpbHRlcnMgOikN
Cj4+Pj4+DQo+Pj4+PiBXaGF0IGRvIHlvdSB0aGluaz8NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFdoYXQg
ZXhhY3RseSBfSVNfIGFuIGltcGxpY2l0IGZpbHRlcj8gSG93IGRvZXMgaXQgZGlmZmVyIHRvZGF5
IGZyb20gYW4NCj4+Pj4gZXhwbGljaXQgZmlsdGVyPyBJIGFzc3VtZWQgdGhlIG9ubHkgZGlmZmVy
ZW5jZSB3YXMgaWYgaXQgd2FzIG5hbWVkIG9yDQo+Pj4+IG5vdDsgYnV0IEkgdGhpbmsgSSBtdXN0
IGJlIG1pc3Rha2VuIG5vdyBpZiB5b3UncmUgcHJvcG9zaW5nIGxlYXZpbmcgdGhlDQo+Pj4+IGlu
dGVyZmFjZSBhbG9uZSBlbnRpcmVseS4NCj4+Pj4NCj4+Pj4gQXJlIHRoZXkgaW5zdGFudGlhdGVk
IGRpZmZlcmVudGx5Pw0KPj4+Pg0KPj4+DQo+Pj4gQXMgSSB1bmRlcnN0YW5kLCB0aGUgb25seSBk
aWZmZXJlbmNlIGlzIHRoZWlyIEJsb2NrRHJpdmVyU3RhdGUuaW1waWNpdCBmaWVsZCwgYW5kIHNl
dmVyYWwgcGxhY2VzIGluIGNvZGUNCj4+PiB3aGVyZSB3ZSBza2lwIGltcGxpY2l0IGZpbHRlciB3
aGVuIHRyeWluZyB0byBmaW5kIHNvbWV0aGluZyBpbiBhIGNoYWluIHN0YXJ0aW5nIGZyb20gYSBk
ZXZpY2UuDQo+Pj4NCj4+DQo+PiBPaCwgb2gsIHllcy4gSSBzZWUuDQo+Pg0KPj4+IEhtbSwgT0ss
IGxldCdzIHNlZToNCj4+Pg0KPj4+IDEuIHRoZSBvbmx5IGltcGxpY2l0IGZpbHRlcnMgYXJlIGNv
bW1pdF90b3AgYW5kIG1pcnJvcl90b3AgaWYgdXNlciBkb24ndCBzcGVjaWZ5IGZpbHRlci1ub2Rl
LW5hbWUuDQo+Pj4NCj4+PiBXaGVyZSBpdCBtYWtlIHNlbnNlLCBpLmUuLCB3aGVyZSBpbXBsaWNp
dCBmaWVsZCB1c2VkPw0KPj4+DQo+Pg0KPj4gYGdpdCBncmVwIC1FICcoLT58XC4paW1wbGljaXQn
YCBpcyB3aGF0IEkgdXNlZCB0byBmaW5kIHVzYWdlcy4NCj4+DQo+Pj4gMi4gYmRydl9xdWVyeV9p
bmZvLCBiZHJ2X3F1ZXJ5X2Jkc19zdGF0cywgYmRydl9ibG9ja19kZXZpY2VfaW5mbyhvbmx5IHdo
ZW4gY2FsbGVkIGZyb20gYmRydl9xdWVyeV9pbmZvKSwgdGhleSdsbA0KPj4+IHJlcG9ydCBmaWx0
ZXIgYXMgdG9wIG5vZGUgaWYgd2UgZG9uJ3QgbWFyayBpdCBpbXBsaWNpdC4NCj4+Pg0KPj4NCj4+
IFNvIHRoYXQncyBhIGJpdCBvZiBhIGNoYW5nZSwgYnV0IG9ubHkgdmlzdWFsbHkuIFRoZSAicmVh
bGl0eSIgaXMgc3RpbGwNCj4+IHRoZSBzYW1lLCB3ZSBqdXN0IHJlcG9ydCBpdCBtb3JlICJhY2N1
cmF0ZWx5LiIgbGlidmlydCBNSUdIVCBuZWVkIGENCj4+IGhlYWRzIHVwIGhlcmUuIEknbSBsb29w
aW5nIHBrcmVtcGEgYmFjayBpbiBmb3IgY29tbWVudC4NCj4+DQo+PiA8cGtyZW1wYT4NCj4+IFdv
dWxkIGxpYnZpcnQgYmUgbmVnYXRpdmVseSBpbXBhY3RlZCBieSB0aGUgcmV2ZWxhdGlvbiBvZiBm
b3JtZXJseQ0KPj4gaW50ZXJuYWwgKCJpbXBsaWNpdCIpIG5vZGVzIGNyZWF0ZWQgYnkgbWlycm9y
IGFuZCBjb21taXQgdmlhIHF1ZXJ5IGJsb2NrDQo+PiBjb21tYW5kcz8gQXQgdGhlIG1vbWVudCwg
UUVNVSBoaWRlcyB0aGVtIGZyb20geW91IGlmIHlvdSBkbyBub3QgbmFtZSB0aGVtLg0KPj4gPC9w
a3JlbXBhPg0KPj4NCj4+PiAzLiBiZHJ2X3JlZnJlc2hfZmlsZW5hbWUsIGJkcnZfcmVvcGVuX3Bh
cnNlX2JhY2tpbmcsIGJkcnZfZHJvcF9pbnRlcm1lZGlhdGU6DQo+Pj4gwqDCoMKgIEkgdGhpbmsg
aXQncyBub3QgYSBwcm9ibGVtLCBqdXN0IGRyb3Agc3BlY2lhbCBjYXNlIGZvciBpbXBsaWNpdCBm
aXRsZXJzDQo+Pj4NCj4+DQo+PiBJJ20gbXVjaCBsZXNzIGNlcnRhaW4gYWJvdXQgd2hhdCB0aGUg
aW1wYWN0IG9mIHRoaXMgd291bGQgYmUgYW5kIHdvdWxkDQo+PiBuZWVkIHRvIGF1ZGl0IGl0IChh
bmQgZG9uJ3QgaGF2ZSB0aGUgdGltZSB0bywgcGVyc29uYWxseS4pDQo+Pg0KPj4gRG8geW91IGhh
dmUgYSBQT0Mgb3IgUkZDIHBhdGNoIHRoYXQgZGVtb25zdHJhdGVzIGRyb3BwaW5nIHRoZXNlIHNw
ZWNpYWwNCj4+IGNhc2VzPyBJdCBtaWdodCBiZSBuaWNlIHRvIHNlZSBhcyBwcm9vZiB0aGF0IGl0
J3Mgc2FmZSB0byBkZXByZWNhdGUuDQoNCkkgZmFjZWQgYSBwcm9ibGVtIHdpdGggc29tZSBpb3Rl
c3QgKGl0J3Mgbm90IGEgc3VycHJpc2Ugb2YgY291cnNlKSwgYnV0IEkgdGhpbmssIEknbGwNCmNv
bWUgYmFjayB3aXRoIGFuZCBSRkMgb2YgY291cnNlLg0KDQo+Pg0KPj4+IFNvLCBzZWVtcyB0aGUg
b25seSByZWFsIGNoYW5nZSBpcyBxdWVyeS1ibG9jayBhbmQgcXVlcnktYmxvY2tzdGF0cyBvdXRw
dXQgd2hlbiBtaXJyb3Igb3IgY29tbWl0IGlzIHN0YXJ0ZWQNCj4+PiB3aXRob3V0IHNwZWNpZnlp
bmcgZmlsdGVyLW5vZGUtbmFtZSAoZmlsdGVyIHdvdWxkIGJlIG9uIHRvcCkNCj4+Pg0KPj4+IFNv
LCBob3cgc2hvdWxkIHdlIGRlcHJlY2F0ZSB0aGlzLCBvciBjYW4gd2UganVzdCBjaGFuZ2UgaXQ/
DQo+Pj4NCj4+DQo+PiBJJ20gbm90IHN1cmUgaWYgaXQncyB3b3J0aCBpdCB5ZXQsIHdoYXQgZG9l
cyBkcm9wcGluZyB0aGUgaW1wbGljaXQgZmllbGQNCj4+IGJ1eSB1cz8gQ29uY2VwdHVhbGx5IEkg
dW5kZXJzdGFuZCB0aGF0IGl0J3Mgc2ltcGxlciB3aXRob3V0IHRoZSBub3Rpb24NCj4+IG9mIGlt
cGxpY2l0IGZpZWxkcywgYnV0IEkgaW1hZ2luZSB0aGVyZSdzIHNvbWUgY2xlYW51cCBpbiBwYXJ0
aWN1bGFyDQo+PiB0aGF0IG1vdGl2YXRlZCB0aGlzLg0KPiANCj4gUmV2aWV3aW5nIE1heCdzICJi
bG9jazogRGVhbCB3aXRoIGZpbHRlcnMiIHNlcmllcyBtb3RpdmF0ZWQgbWUuDQoNCg0KQ3VycmVu
dGx5LCB3ZSBqdXN0IG1vc3RseSBkb24ndCBjYXJlIGFib3V0IGltcGxpY2l0IGZpbHRlcnMuDQoN
CnlvdXIgY29tbWFuZCBvbiBtYXN0ZXI6DQojIGdpdCBncmVwIC1FICcoLT58XC4paW1wbGljaXQn
DQpibG9jay5jOiAgICB3aGlsZSAoYmFja2luZ19icyhvdmVybGF5X2JzKSAmJiBiYWNraW5nX2Jz
KG92ZXJsYXlfYnMpLT5pbXBsaWNpdCkgew0KYmxvY2suYzogICAgICAgIGFzc2VydCghb2xkX2Jh
Y2tpbmdfYnMgfHwgIW9sZF9iYWNraW5nX2JzLT5pbXBsaWNpdCk7DQpibG9jay5jOiAgICB3aGls
ZSAoZXhwbGljaXRfdG9wICYmIGV4cGxpY2l0X3RvcC0+aW1wbGljaXQpIHsNCmJsb2NrLmM6ICAg
IGlmIChicy0+aW1wbGljaXQpIHsNCmJsb2NrL2NvbW1pdC5jOiAgICAgICAgY29tbWl0X3RvcF9i
cy0+aW1wbGljaXQgPSB0cnVlOw0KYmxvY2svbWlycm9yLmM6ICAgICAgICBtaXJyb3JfdG9wX2Jz
LT5pbXBsaWNpdCA9IHRydWU7DQpibG9jay9xYXBpLmM6ICAgICAgICB3aGlsZSAoYmxrICYmIGJz
MC0+ZHJ2ICYmIGJzMC0+aW1wbGljaXQpIHsNCmJsb2NrL3FhcGkuYzogICAgd2hpbGUgKGJzICYm
IGJzLT5kcnYgJiYgYnMtPmltcGxpY2l0KSB7DQpibG9jay9xYXBpLmM6ICAgIHdoaWxlIChibGtf
bGV2ZWwgJiYgYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsNCg0KDQpvbiBNYXgncyBzZXJpZXM6
DQoNCiMgZ2l0IGdyZXAgLUUgJygtPnxcLilpbXBsaWNpdCcNCmJsb2NrLmM6ICAgICAgICAgICBi
ZHJ2X2ZpbHRlcmVkX2JzKG92ZXJsYXlfYnMpLT5pbXBsaWNpdCkNCmJsb2NrLmM6ICAgICAgICBh
c3NlcnQoIW9sZF9iYWNraW5nX2JzIHx8ICFvbGRfYmFja2luZ19icy0+aW1wbGljaXQpOw0KYmxv
Y2suYzogICAgaWYgKGJzLT5pbXBsaWNpdCkgew0KYmxvY2suYzogICAgd2hpbGUgKCEoc3RvcF9v
bl9leHBsaWNpdF9maWx0ZXIgJiYgIWJzLT5pbXBsaWNpdCkpIHsNCmJsb2NrL2NvbW1pdC5jOiAg
ICAgICAgY29tbWl0X3RvcF9icy0+aW1wbGljaXQgPSB0cnVlOw0KYmxvY2svbWlycm9yLmM6ICAg
ICAgICBtaXJyb3JfdG9wX2JzLT5pbXBsaWNpdCA9IHRydWU7DQoNCnNlZW1zIGJldHRlciwgYnV0
IGFjdHVhbGx5LCB3ZSBnZXQgbmV3IGZ1bmN0aW9uIGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJz
Og0KIyBnaXQgZ3JlcCBiZHJ2X3NraXBfaW1wbGljaXRfZmlsdGVycw0KYmxvY2suYzogICAgZXhw
bGljaXRfdG9wID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMoZXhwbGljaXRfdG9wKTsNCmJs
b2NrLmM6QmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMpDQpibG9jay9ibG9jay1iYWNrZW5kLmM6ICAgICAgICAgICAgbm9uX2Zp
bHRlciA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJzKGJsay0+cm9vdC0+YnMpOw0KYmxvY2sv
cWFwaS5jOiAgICAgICAgICAgIGJzMCA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJzKGJzMCk7
DQpibG9jay9xYXBpLmM6ICAgICAgICBicyA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJzKGJz
KTsNCmJsb2NrL3FhcGkuYzogICAgICAgIGJzID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMo
YnMpOw0KYmxvY2tkZXYuYzogICAgICAgIGJzID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMo
YmxrX2JzKGJsaykpOw0KYmxvY2tkZXYuYzogICAgICAgICAgICAgICAgYmRydl9za2lwX2ltcGxp
Y2l0X2ZpbHRlcnMoc291cmNlKTsNCmJsb2NrZGV2LmM6ICAgIHVuZmlsdGVyZWRfYnMgPSBiZHJ2
X3NraXBfaW1wbGljaXRfZmlsdGVycyhicyk7DQpibG9ja2Rldi5jOiAgICAgICAgQmxvY2tEcml2
ZXJTdGF0ZSAqZXhwbGljaXRfYmFja2luZyA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJzKHNv
dXJjZSk7DQpibG9ja2Rldi5jOiAgICB1bmZpbHRlcmVkX2JzID0gYmRydl9za2lwX2ltcGxpY2l0
X2ZpbHRlcnMoYnMpOw0KaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaDpCbG9ja0RyaXZlclN0YXRl
ICpiZHJ2X3NraXBfaW1wbGljaXRfZmlsdGVycyhCbG9ja0RyaXZlclN0YXRlICpicyk7DQoNCg0K
U28sIGlmIHdlIGFyZSBnb2luZyB0byByZWFsbHkgc3VwcG9ydCBpbXBsaWNpdCBmaWx0ZXJzLCB3
ZSBoYXZlIHRvIHN1cHBvcnQgdGhlbSBldmVyeXdoZXJlLg0KSSdtIG5vdCBzdXJlIHRoYXQgTWF4
J3Mgc2VyaWVzIGNvdmVyZWQgYWxsIGNhc2VzLiBXZSBkb24ndCBoYXZlIHN0cm9uZyBkZWZpbml0
aW9uIG9mIGltcGxpY2l0DQpmaWx0ZXJzLCBvciBhYm91dCBoYXZlIGltcGxpY2l0IGFuZCBleHBs
aWNpdCBmaWx0ZXJzIHNob3VsZCBiZSBpbnRlcmxlYXZlZCBvbiBhcHBlbmRpbmcuDQoNClRoYXQn
cyB3aHkgSSB0aGluayBpdCdzIGJldHRlciB0byBkcm9wIHRoZW0gZWFybGllciwgYXMgaXQgc2Vl
bXMgdGhhdCB3ZSBhcmUgZ29pbmcgdG8gaW5jcmVhc2UNCmZpbHRlciB1c2FnZSBpbiBibG9jay1s
YXllci4NCg0KPiANCj4+DQo+PiBJJ2Qgc2F5IHRvIGp1c3QgY2hhbmdlIHRoZSBiZWhhdmlvciwg
d2Ugc2hvdWxkOg0KPj4NCj4+IC0gR2l2ZSBhIHN0YW5kYXJkIHRocmVlLXJlbGVhc2Ugd2Fybmlu
ZyB0aGF0IHRoZSBiZWhhdmlvciB3aWxsIGNoYW5nZSBpbg0KPj4gYW4gaW5jb21wYXRpYmxlIHdh
eQ0KPj4gLSBEZW1vbnN0cmF0ZSB3aXRoIGFuIFJGQyBwYXRjaCB0aGF0IHNwZWNpYWwgY2FzZXMg
YXJvdW5kIC0+aW1wbGljaXQgaW4NCj4+IGJsb2NrLmMgY2FuIGJlIHJlbW92ZWQgYW5kIGRvIG5v
dCBtYWtlIHRoZSBjb2RlIG1vcmUgY29tcGxleCwNCj4+IC0gR2V0IGJsZXNzaW5ncyBmcm9tIFBl
dGVyIEtyZW1wYS4NCj4+DQo+PiBBcyBhbHdheXM6IExpYnZpcnQgaXMgbm90IHRoZSBlbmQtYWxs
IGJlLWFsbCBvZiBRRU1VIG1hbmFnZW1lbnQsIGJ1dCBpZg0KPj4gbGlidmlydCBpcyBjYXBhYmxl
IG9mIHdvcmtpbmcgYXJvdW5kIGRlc2lnbiBjaGFuZ2VzIHRoZW4gSSBiZWxpZXZlIGFueQ0KPj4g
cHJvamVjdCBvdXQgdGhlcmUgdG9kYXkgYWxzbyBjb3VsZCwgc28gaXQncyBhIGdvb2QgbGl0bXVz
IHRlc3QuDQo+Pg0KPj4gLS1qcw0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

