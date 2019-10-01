Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B217C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E8B2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F279SbPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFL79-00077t-1D
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKlr-0004PG-NX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKlq-0001zr-5I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:13:03 -0400
Received: from mail-eopbgr130120.outbound.protection.outlook.com
 ([40.107.13.120]:13278 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKlk-0001vX-6n; Tue, 01 Oct 2019 12:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayYPezyfW1NwPvb2ajbIb09bEqXKpDMzdyI8elBdF3ta7NR/FDggF2wimsO1MhKPoy+Jzx+eeh74ANuJLn+HnCRFfvunIzfvrBdnYH048bUAiTMTLmc6HehjF0A6LSk8qePJVMS021u0Cp39jRu6C6nFXNZ9KPiUXNH382O6rm5hSLlarbr724sPP8JTDyidypEkXoLAWYfT7Y0HJgTb6K9YxDv2fhboyUDaosuMMn9ezM2cN+3abXcYSalVXlUET3bfJnNk3g91WRqUQ1W4yfXRpj6ImYZvs85lAc2VwLcR1fNfbXkdRvBOnJdu7Nb+vP0s8Henx1eYopsZholruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpnf45amaJqm6y0T5UBhcWIcg5aybAKabwHiQtcBVPc=;
 b=CSQl3YvUgTyewqcqQ1JNwqCmlMljWkruNliZXYHDHPtvPzU7emf6F+KaPE0BXdYUDBucmIDGigGdYnZmxincDaOn1NaeBM49ydH0Jy19OTqvHtjHjI9rZLwYOs3I6Dy5RGHr6J/9QMmPXd9p7C5feiGVfWYa+UhjFOQ+U/lovfbCuKZeLgrdm3z8mLXKNODay2uwJfRajvstQJtO9jGVJ9It3cnZgW6RuyubKU8d5zVlTjRqKXfZ9dl5vWdWKBJDNeaifrtiUmFdQkd22+OmCJuCgWW1KJ2SlDYhc8wgyuhQa3xmZ33K/1WJUo9sRyTzgVAKzxjl+Y3tIo9I89uYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpnf45amaJqm6y0T5UBhcWIcg5aybAKabwHiQtcBVPc=;
 b=F279SbPhiFDS3DkWjC5+9KczRoN38oMkFc0IRtCh7s2qvp1+9GjBqX6PeRp/kKAUdKMrYa4dps4CFuodM6uEtTUVZ9suf00P99A6rGs5q+r0hQLY/zmDlO8ARAlNFPI5SKTqTYNkGVYPDcw1F+h6VqgU/4+zTficoRbNaIrbfFI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3961.eurprd08.prod.outlook.com (20.179.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 16:12:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 16:12:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdFfK+AgAAP1wCAAFgsgIAADbqAgAAD3oA=
Date: Tue, 1 Oct 2019 16:12:52 +0000
Message-ID: <296167e0-396d-5f0a-456c-2747c6ad770d@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
 <20191001095416.GC4688@linux.fritz.box>
 <c051fd5c-31be-c98b-8155-70fe1b6c1283@redhat.com>
 <20191001155859.GE4688@linux.fritz.box>
In-Reply-To: <20191001155859.GE4688@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001191249798
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8151bb71-9d85-4a54-177f-08d7468a3601
x-ms-traffictypediagnostic: DB8PR08MB3961:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB3961A7FD39396257131B5CFEC19D0@DB8PR08MB3961.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(366004)(376002)(136003)(346002)(199004)(189003)(2906002)(6246003)(6512007)(86362001)(6306002)(6116002)(3846002)(305945005)(8676002)(71200400001)(478600001)(71190400001)(36756003)(81166006)(31686004)(25786009)(81156014)(4326008)(66066001)(54906003)(31696002)(8936002)(110136005)(14444005)(966005)(14454004)(316002)(5024004)(5660300002)(486006)(6436002)(2616005)(476003)(11346002)(99286004)(52116002)(256004)(76176011)(6486002)(229853002)(446003)(66446008)(64756008)(66556008)(66946007)(66476007)(7736002)(386003)(6506007)(53546011)(186003)(102836004)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3961;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxDS8l3YjVXZzcX9MUEnMPL0RrbML1ZA91Mf5W0UnZyETDGOPTQ7tlj+wWH4FbPBu52P035SDHF6pzJmB3Rx49mXKNDzU4PVYtnUlG4uYBS3e8REea1p4skEioYs/lBth+JHVtgqIqS8+t5051UvHmCLZAWqeUTj1loNR0tgAfPimBciMt2OVtzx2sgzXZObvvWQ7PJrfj1/MHM8dX9qM8plB+wkKnpI1K4gK7ePpsUB6cbD7+HNiYBOsg9IlDjHkaCfBur4YKWHBHbpi0cwv7QmixCHq4DgdMe3IPBsZQc08rZb40r5F9gcpOm2U1a4GpW1lbWI3I48VVXBRbeRnaRrqUKdKnLo2jt6ArTVhvbmW/IRCz8NlNm7I5vlrGcfuTGEpvbDBevV4Np0VU4rLdltMGJErFP5K0BOlDSn2v4ZWlRSieNvBPuZ3xnnfTaL8gqsHbbHEjvDezFQzuSFYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <760EB08A9633954284A18F0CD50EC0A2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8151bb71-9d85-4a54-177f-08d7468a3601
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 16:12:52.3288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ElRY17vYQNMD/eXWQxSF1fsa9/Dooj3dGiYFLaL5hIdt8k4c/SryfWWHslmhJ/ij0uYEt0PrFy5uoGyJydhiLamWifjG8mLLgqNcxjfrMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3961
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxODo1OCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDEuMTAuMjAxOSB1bSAx
NzowOSBoYXQgSm9obiBTbm93IGdlc2NocmllYmVuOg0KPj4NCj4+DQo+PiBPbiAxMC8xLzE5IDU6
NTQgQU0sIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMDEuMTAuMjAxOSB1bSAxMDo1NyBoYXQg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4gMDEuMTAuMjAx
OSAzOjA5LCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+PiBIaSBmb2xrcywgSSBpZGVudGlmaWVkIGEg
cHJvYmxlbSB3aXRoIHRoZSBtaWdyYXRpb24gY29kZSB0aGF0IFJlZCBIYXQgUUUNCj4+Pj4+IGZv
dW5kIGFuZCB0aG91Z2h0IHlvdSdkIGxpa2UgdG8gc2VlIGl0Og0KPj4+Pj4NCj4+Pj4+IGh0dHBz
Oi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4+Pj4+
DQo+Pj4+PiBWZXJ5LCB2ZXJ5IGJyaWVmbHk6IGRyaXZlLW1pcnJvciBpbnNlcnRzIGEgZmlsdGVy
IG5vZGUgdGhhdCBjaGFuZ2VzIHdoYXQNCj4+Pj4+IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25h
bWUoKSByZXR1cm5zLCB3aGljaCBjYXVzZXMgYSBtaWdyYXRpb24gcHJvYmxlbS4NCj4+Pj4+DQo+
Pj4+Pg0KPj4+Pj4gSWdub3JhbnQgcXVlc3Rpb24gIzE6IENhbiB3ZSBtdWx0aS1wYXJlbnQgdGhl
IGZpbHRlciBub2RlIGFuZA0KPj4+Pj4gc291cmNlLW5vZGU/IEl0IGxvb2tzIGxpa2UgYXQgdGhl
IG1vbWVudCBib3RoIGNvbnNpZGVyIHRoZWlyIG9ubHkgcGFyZW50DQo+Pj4+PiB0byBiZSB0aGUg
YmxvY2stam9iIGFuZCBkb24ndCBoYXZlIGEgbGluayBiYWNrIHRvIHRoZWlyIHBhcmVudHMgb3Ro
ZXJ3aXNlLg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBPdGhlcndpc2U6IEkgaGF2ZSBhIGxvdCBvZiBj
bG91ZHkgaWRlYXMgb24gaG93IHRvIHNvbHZlIHRoaXMsIGJ1dA0KPj4+Pj4gdWx0aW1hdGVseSB3
aGF0IHdlIHdhbnQgaXMgdG8gYmUgYWJsZSB0byBmaW5kIHRoZSAiYWRkcmVzc2FibGUiIG5hbWUg
Zm9yDQo+Pj4+PiB0aGUgbm9kZSB0aGUgYml0bWFwIGlzIGF0dGFjaGVkIHRvLCB3aGljaCB3b3Vs
ZCBiZSB0aGUgbmFtZSBvZiB0aGUgZmlyc3QNCj4+Pj4+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24n
dCBhIGZpbHRlci4gKE9SLCB0aGUgbmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPj4+Pj4gYWJv
dmUgdGhhdCBub2RlLikNCj4+Pj4NCj4+Pj4NCj4+Pj4gQmV0dGVyIHdvdWxkIGJlIHRvIG1pZ3Jh
dGUgYnkgbm9kZS1uYW1lIG9ubHkuLiBCdXQgYW0gSSByaWdodCB0aGF0DQo+Pj4+IG5vZGUtbmFt
ZXMgYXJlIGRpZmZlcmVudCBvbiBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uPyBPciB0aGlzIHNpdHVh
dGlvbg0KPj4+PiBjaGFuZ2VkPw0KPj4+DQo+Pj4gVHJhZGl0aW9uYWxseSwgSSB0aGluayBtaWdy
YXRpb24gYXNzdW1lcyB0aGF0IGZyb250ZW5kcyAoZ3Vlc3QgZGV2aWNlcykNCj4+PiBtdXN0IG1h
dGNoIGV4YWN0bHksIGJ1dCBiYWNrZW5kcyBtYXkgYW5kIHVzdWFsbHkgd2lsbCBkaWZmZXIuDQo+
Pj4NCj4+PiBPZiBjb3Vyc2UsIGRpcnR5IGJpdG1hcHMgYXJlIGEgYmFja2VuZCBmZWF0dXJlIHRo
YXQgaXNuJ3QgcmVhbGx5IHJlbGF0ZWQNCj4+PiB0byBndWVzdCBkZXZpY2VzLCBzbyB0aGlzIGRv
ZXNuJ3QgcmVhbGx5IHdvcmsgb3V0IGFueSBtb3JlIGluIHlvdXIgY2FzZS4NCj4+PiBCbG9ja0Jh
Y2tlbmQgbmFtZXMgYXJlIHVudXNhYmxlIGZvciB0aGlzIHB1cnBvc2UgKGVzcGVjaWFsbHkgYXMg
d2UncmUNCj4+PiBtb3ZpbmcgdG93YXJkcyBhbm9ueW1vdXMgQmxvY2tCYWNrZW5kcyBldmVyeXdo
ZXJlKSwgd2hpY2ggSSBndWVzcw0KPj4+IGVzc2VudGlhbGx5IG1lYW5zIG5vZGUtbmFtZSBpcyB0
aGUgb25seSBvcHRpb24gbGVmdC4NCj4+Pg0KPj4NCj4+IFRoZSBwcm9ibGVtIGFzIEkgc2VlIGl0
IGludm9sdmVzIEFQSSBzdGFiaWxpdHkuDQo+Pg0KPj4gV2UgYWxsb3cgYmxvY2stZGlydHktYml0
bWFwLWFkZCBhZ2FpbnN0IGUuZy4gImRyaXZlMSIgdGhyb3VnaCB0aGUNCj4+IGJsb2NrLWJhY2tl
bmQgbmFtZSAodGhlIG5hbWUgb2YgdGhlICJkcml2ZSIgYXMgdGhlIHVzZXIgc2VlcyBpdC4pDQo+
Pg0KPj4gT2YgY291cnNlLCBvbmNlIHlvdSBzdGFydCBtaXJyb3IsIHlvdSBhcmVuJ3QgYWJsZSB0
byBhY2Nlc3MgdGhhdCBiaXRtYXANCj4+IHRocm91Z2ggdGhhdCBuYW1lcGFpciBhbnltb3JlIC0t
IHRoZSAiYWRkcmVzcyIgb2YgdGhlIGJpdG1hcCBoYXMgImNoYW5nZWQiIQ0KPj4NCj4+IChJbiBh
Y3R1YWwgZmFjdCwgdGhlIGJpdG1hcCBhbHdheXMgaGFkIHR3byBhZGRyZXNzZXM7IGFuZCBzaW1w
bHkgd2UgbG9zdA0KPj4gYW4gYWxpYXMgLS0gYnV0IGl0J3MgdGhlIG9uZSB0aGF0IHRoZSB1c2Vy
IGxpa2VseSB1c2VkIHRvIGNyZWF0ZSB0aGUNCj4+IGJpdG1hcCwgc28gdGhhdCdzIGJhZC4pDQo+
IA0KPiBTbyBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHdp
dGhvdXQgYSBmaWx0ZXIsIGluDQo+IHNvbWUgc2V0dXBzIHdlIGdldCBhIHVzYWJsZSBCbG9ja0Jh
Y2tlbmQgbmFtZSBsaWtlICJkcml2ZTEiLCBidXQgd2hlbiBhDQo+IGZpbHRlciBpcyBhZGRlZCwg
d2UgcmV0dXJuIHRoZSBub2RlLW5hbWUgaW5zdGVhZCB3aGljaCBpcw0KPiBhdXRvLWdlbmVyYXRl
ZCBhbmQgd2lsbCBiZSBkaWZmZXJlbnQgb24gdGhlIGRlc3RpbmF0aW9uLg0KPiANCj4gTG9va2lu
ZyBhdCB0aGUgQ2hpbGRSb2xlIGRvY3VtZW50YXRpb246DQo+IA0KPiAgICAgIC8qIFJldHVybnMg
YSBuYW1lIHRoYXQgaXMgc3VwcG9zZWRseSBtb3JlIHVzZWZ1bCBmb3IgaHVtYW4gdXNlcnMgdGhh
biB0aGUNCj4gICAgICAgKiBub2RlIG5hbWUgZm9yIGlkZW50aWZ5aW5nIHRoZSBub2RlIGluIHF1
ZXN0aW9uIChpbiBwYXJ0aWN1bGFyLCBhIEJCDQo+ICAgICAgICogbmFtZSksIG9yIE5VTEwgaWYg
dGhlIHBhcmVudCBjYW4ndCBwcm92aWRlIGEgYmV0dGVyIG5hbWUuICovDQo+ICAgICAgY29uc3Qg
Y2hhciAqKCpnZXRfbmFtZSkoQmRydkNoaWxkICpjaGlsZCk7DQo+IA0KPiBJJ2QgYXJndWUgdGhh
dCBhIEJsb2NrQmFja2VuZCBuYW1lIGlzIG1vcmUgdXNlZnVsIGZvciBhIGh1bWFuIHVzZXIgZXZl
bg0KPiBhY3Jvc3MgZmlsdGVyLCBzbyBJJ2Qgc3VwcG9ydCBhIC5nZXRfbmFtZSBpbXBsZW1lbnRh
dGlvbiBmb3IgYSBmaWx0ZXINCj4gY2hpbGQgcm9sZSAod2hpY2ggTWF4IHdhbnRlZCB0byBpbnRy
b2R1Y2UgYW55d2F5IGZvciBoaXMgZmlsdGVyIHNlcmllcykuDQo+IA0KPiBPZiBjb3Vyc2UsIGlm
IHlvdSBoYXZlIGEgZnVuY3Rpb24gdGhhdCBpcyBtYWRlIHRvIHJldHVybiBhIGNvbnZlbmllbnQN
Cj4gdGV4dCBmb3IgaHVtYW4gdXNlcnMsIGFuZCB5b3UgdXNlIGl0IGZvciBhIHN0YWJsZSBBQkkg
bGlrZSB0aGUgbWlncmF0aW9uDQo+IHN0cmVhbSwgdGhpcyBpcyBhbiBpZGVhIHRoYXQgd291bGQg
Y2VydGFpbmx5IGhhdmUgY2F1c2VkIGFuIGVudGVydGFpbmluZw0KPiBMaW51cyByYW50IGluIHRo
ZSBnb29kIG9sZCBrZXJuZWwgdGltZXMuDQo+IA0KPj4+IElzIGJpdG1hcCBtaWdyYXRpb24gc29t
ZXRoaW5nIHRoYXQgbXVzdCBiZSBlbmFibGVkIGV4cGxpY2l0bHkgb3IgZG9lcw0KPj4+IGl0IGhh
cHBlbiBhdXRvbWF0aWNhbGx5PyBJZiBpdCdzIGV4cGxpY2l0LCB0aGVuIG1ha2luZyBhbiBhZGRp
dGlvbmFsDQo+Pj4gcmVxdWlyZW1lbnQgKG1hdGNoaW5nIG5vZGUtbmFtZXMpIHNob3VsZG4ndCBi
ZSBhIHByb2JsZW0uDQo+Pg0KPj4gVGhpcyBtZWFucyB0aGF0IGJpdG1hcCBtaWdyYXRpb24gYmVj
b21lcyBhIGJsb2NrZGV2LW9ubHkgZmVhdHVyZS4NCj4gDQo+IEkgbWVhbnQgdGhpcyBtb3JlIGFz
IHRoZSBwcmVmZXJyZWQgd2F5IGZvciB0aGUgZnV0dXJlIHJhdGhlciB0aGFuIHRoZQ0KPiBvbmx5
IHRoaW5nIHN1cHBvcnRlZC4NCj4gDQo+IEJ1dCBQZXRlciBoYXMgYWN0dWFsbHkgbWVudGlvbmVk
IHRoYXQgZm9yIGxpYnZpcnQgaXQgd2lsbCBiZQ0KPiBibG9ja2Rldi1vbmx5IGFueXdheS4gU28g
ZG8gd2UgZXZlbiBoYXZlIGEgZ29vZCByZWFzb24gdG8gaW52ZXN0IG11Y2gNCj4gZm9yIHRoZSBu
b24tYmxvY2tkZXYgY2FzZT8NCj4gDQo+IE1heWJlIG1ha2luZyBpdCBibG9ja2Rldi1vbmx5IGlz
IGFjdHVhbGx5IHByZXR0eSByZWFzb25hYmxlLg0KDQpXZSBpbiBWaXJ0dW96em8gdXNlIGJpdG1h
cCBtaWdyYXRpb24sIHNvIEknZCBoYXZlIHRvIGZpeCBpdCBhdCBsZWFzdA0KZG93bnN0cmVhbSAo
aXQgc2VlbXMgZWFzaWVyIHRoYW4gc3dpdGNoIGRvd25zdHJlYW0gbGlidmlydCB0byBibG9ja2Rl
diBub3cpLg0KDQpBbmQgd2hhdCBhYm91dCBvcmlnaW5hbCBidWcNCmh0dHBzOi8vYnVnemlsbGEu
cmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj8NCg0KQWxzbywgaWYgd2Ug
bWFrZSBpdCBibG9ja2Rldi1vbmx5IHVwc3RyZWFtLCB3aGF0IHdlIG1lYW4gYnkgdGhhdD8gTm9k
ZSBuYW1lcw0Kb24gZGVzdGluYXRpb24gbXVzdCBtYXRjaCwgb3Igd2UgYWRkIGFkZGl0aW9uYWwg
cW1wIGNvbW1hbmQNCm1pZ3JhdGlvbi1zZXQtYml0bWFwLW5vZGUtbWFwcGluZywgdG8gc3BlY2lm
eSBtYXBwaW5nIGJldHdlZW4gbm9kZSBuYW1lcyBvbg0Kc291cmNlIGFuZCB0YXJnZXQ/DQoNCg0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

