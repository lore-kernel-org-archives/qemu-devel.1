Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C16CC388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3784921920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u8K+P6aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3784921920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFF75-0007RD-Dy
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFF2O-0003aD-Ht
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFF2M-0007EE-Sm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:05:44 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com
 ([40.107.15.120]:49569 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFF2G-0007Ak-0A; Tue, 01 Oct 2019 06:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyifHZKgZcpowZPQiDlJGycyIwXWgemk5FrHC/M6G0ondoQ9fSR4NzYiLbK0PBozVAda11v6k1OzMwewzEd7Ty/CXl1rNgVuDvkH6sSU2nRjo1bEuTtx4qqz0CvV+bGBhL0HqJLVedGHx0Shi8c8Wd7O2upiY2jK1zLdJgpL2EZAyfnXGhst9jJL36wg10EktaF1VVQK46fee17DxfA8Bc5SmSWvOZQJupZmxVzVNJXFBxSDhOQl1gRqwRx07NhsPOikTVssI7Nq5OukP/6fu2gIgHBDeQNOJzROIClQhDRjZa8KJpLtzqnbSyogQyqwoO4HNxmz2T0USnmTbQ8hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrpOb39C6MomTiSyBboh2zA9s+qiKWkxm4VMtj5wKcw=;
 b=EzGj2JJMuj9ciMRSZHLGLdPhd9IabABmsqXck9/zvit2VLWZ1/NLtj8YZOeYqJnOE/dpI5ZS0Wh8CoxGHuECm3hUlo7wd5hR/5KDIFziXf1MLydgVNgJQP4lDtQA+lVLHd1IygvSNB82z0JEU6GVrqnZIlFyd94ayeYsXrezSVdVw092VmsmWivtEXSJ+uamSV76s838oa9+HwXqmTx4Jr5Lgeo8+OO8UyDji6nFtWaHCertjVXyWlqW3lzmpBChKGQvSqx83qJcV6wAhXQg6WZjJzZh/zPXlKISHMzyIT2THDuw2cTqOAOWMKcrpBu+oJryc9qy30pl6W2ZkU/BTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrpOb39C6MomTiSyBboh2zA9s+qiKWkxm4VMtj5wKcw=;
 b=u8K+P6aSjZgJ89qyOhtCtA5Lt2ZlddXpSphS965Wc5g5DdHPvfGCwu7/y7WEgc+sNrTDTQ8mgxVFiicR/vBI3k17L1dPbjhRde8EOBp5QsT5ZwQLYKZdeo8kp7LlPpcC4/DG90IX3JCrLZy1DKOf2SKCE0UljoEg50w9objizos=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5211.eurprd08.prod.outlook.com (10.255.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 10:05:33 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 10:05:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdFfK+AgAAP1wCAAAMjAA==
Date: Tue, 1 Oct 2019 10:05:32 +0000
Message-ID: <7c506d34-5bb4-83a1-9959-b36a4fb020de@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
 <20191001095416.GC4688@linux.fritz.box>
In-Reply-To: <20191001095416.GC4688@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:7:67::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001130530035
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d49e46f3-6f79-4a77-cf2f-08d74656e55b
x-ms-traffictypediagnostic: DB8PR08MB5211:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5211CD6AD279CD4FF86A1A5AC19D0@DB8PR08MB5211.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(396003)(366004)(136003)(189003)(199004)(66946007)(66556008)(66476007)(64756008)(66446008)(8936002)(66066001)(52116002)(54906003)(71200400001)(71190400001)(31686004)(36756003)(76176011)(14454004)(3846002)(26005)(446003)(478600001)(6916009)(186003)(316002)(2616005)(25786009)(476003)(966005)(6116002)(99286004)(11346002)(229853002)(4326008)(6486002)(6306002)(6436002)(5660300002)(31696002)(6512007)(486006)(305945005)(81156014)(81166006)(6506007)(386003)(7736002)(102836004)(86362001)(6246003)(256004)(8676002)(2906002)(5024004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5211;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zX4HixGH+QacAKkwtVl1uOJw+pE2ZOTm7KKdyxkcDjaeqI+KgKJ2BnHtdoGYhM6LWierehZgnlSmpD6rZGJnwpZ0Z9FKUfr2yKLCakVnLWPctjdvlXX4GIneC4N+yPq3j0C1XgomjW+wHStQBccUnmHsv3RkJ34kFUdTont8Oxi2hpqqKsKKAQghXV3N2MEh3wwmpfhhVuYO5iHn2O/IZXfEjbkR1zZpPqUthDjq7WcQXUBig0csSJ4V9/ImVQFQsd6GNVZnmHO1Sh44Omow9yGlbBxPVyjoHcTss/pFK0bn+iUMjgRwBGyLRS5WTW7rGA9H2PmSY5ANKqcOZR6025QM7amdXMTK4CG+pniUgRb0NgPYURQug0zNkIW6yJO2oxcYIY9UbCKF62ATIEFVC7FFToDhDYkYYVJvYbzM3er/lJ9BGcFlGUBu2toF7tIbvX9wqMwoPByE5/jFBkKXJA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <308D7EC90924C3468560C22BA6EBCA64@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49e46f3-6f79-4a77-cf2f-08d74656e55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 10:05:32.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2AMRlREIKELVOylkNKAagO6w1HD5dd92V2htJMRXynhQj6IJ6RAAVCH/eiZQuD7EoDksHdwCyqEzdNtIjs2yz8sOwGNd072fxRg9njxuXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5211
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.120
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
Cc: Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxMjo1NCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDEuMTAuMjAxOSB1bSAx
MDo1NyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDAx
LjEwLjIwMTkgMzowOSwgSm9obiBTbm93IHdyb3RlOg0KPj4+IEhpIGZvbGtzLCBJIGlkZW50aWZp
ZWQgYSBwcm9ibGVtIHdpdGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQgUmVkIEhhdCBRRQ0KPj4+
IGZvdW5kIGFuZCB0aG91Z2h0IHlvdSdkIGxpa2UgdG8gc2VlIGl0Og0KPj4+DQo+Pj4gaHR0cHM6
Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNjUyNDI0I2MyMA0KPj4+DQo+
Pj4gVmVyeSwgdmVyeSBicmllZmx5OiBkcml2ZS1taXJyb3IgaW5zZXJ0cyBhIGZpbHRlciBub2Rl
IHRoYXQgY2hhbmdlcyB3aGF0DQo+Pj4gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZSgpIHJl
dHVybnMsIHdoaWNoIGNhdXNlcyBhIG1pZ3JhdGlvbiBwcm9ibGVtLg0KPj4+DQo+Pj4NCj4+PiBJ
Z25vcmFudCBxdWVzdGlvbiAjMTogQ2FuIHdlIG11bHRpLXBhcmVudCB0aGUgZmlsdGVyIG5vZGUg
YW5kDQo+Pj4gc291cmNlLW5vZGU/IEl0IGxvb2tzIGxpa2UgYXQgdGhlIG1vbWVudCBib3RoIGNv
bnNpZGVyIHRoZWlyIG9ubHkgcGFyZW50DQo+Pj4gdG8gYmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9u
J3QgaGF2ZSBhIGxpbmsgYmFjayB0byB0aGVpciBwYXJlbnRzIG90aGVyd2lzZS4NCj4+Pg0KPj4+
DQo+Pj4gT3RoZXJ3aXNlOiBJIGhhdmUgYSBsb3Qgb2YgY2xvdWR5IGlkZWFzIG9uIGhvdyB0byBz
b2x2ZSB0aGlzLCBidXQNCj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxl
IHRvIGZpbmQgdGhlICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+PiB0aGUgbm9kZSB0aGUgYml0
bWFwIGlzIGF0dGFjaGVkIHRvLCB3aGljaCB3b3VsZCBiZSB0aGUgbmFtZSBvZiB0aGUgZmlyc3QN
Cj4+PiBhbmNlc3RvciBub2RlIHRoYXQgaXNuJ3QgYSBmaWx0ZXIuIChPUiwgdGhlIG5hbWUgb2Yg
dGhlIGJsb2NrLWJhY2tlbmQNCj4+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPj4NCj4+DQo+PiBCZXR0
ZXIgd291bGQgYmUgdG8gbWlncmF0ZSBieSBub2RlLW5hbWUgb25seS4uIEJ1dCBhbSBJIHJpZ2h0
IHRoYXQNCj4+IG5vZGUtbmFtZXMgYXJlIGRpZmZlcmVudCBvbiBzb3VyY2UgYW5kIGRlc3RpbmF0
aW9uPyBPciB0aGlzIHNpdHVhdGlvbg0KPj4gY2hhbmdlZD8NCj4gDQo+IFRyYWRpdGlvbmFsbHks
IEkgdGhpbmsgbWlncmF0aW9uIGFzc3VtZXMgdGhhdCBmcm9udGVuZHMgKGd1ZXN0IGRldmljZXMp
DQo+IG11c3QgbWF0Y2ggZXhhY3RseSwgYnV0IGJhY2tlbmRzIG1heSBhbmQgdXN1YWxseSB3aWxs
IGRpZmZlci4NCj4gDQo+IE9mIGNvdXJzZSwgZGlydHkgYml0bWFwcyBhcmUgYSBiYWNrZW5kIGZl
YXR1cmUgdGhhdCBpc24ndCByZWFsbHkgcmVsYXRlZA0KPiB0byBndWVzdCBkZXZpY2VzLCBzbyB0
aGlzIGRvZXNuJ3QgcmVhbGx5IHdvcmsgb3V0IGFueSBtb3JlIGluIHlvdXIgY2FzZS4NCj4gQmxv
Y2tCYWNrZW5kIG5hbWVzIGFyZSB1bnVzYWJsZSBmb3IgdGhpcyBwdXJwb3NlIChlc3BlY2lhbGx5
IGFzIHdlJ3JlDQo+IG1vdmluZyB0b3dhcmRzIGFub255bW91cyBCbG9ja0JhY2tlbmRzIGV2ZXJ5
d2hlcmUpLCB3aGljaCBJIGd1ZXNzDQo+IGVzc2VudGlhbGx5IG1lYW5zIG5vZGUtbmFtZSBpcyB0
aGUgb25seSBvcHRpb24gbGVmdC4NCj4gDQo+IElzIGJpdG1hcCBtaWdyYXRpb24gc29tZXRoaW5n
IHRoYXQgbXVzdCBiZSBlbmFibGVkIGV4cGxpY2l0bHkgb3IgZG9lcw0KPiBpdCBoYXBwZW4gYXV0
b21hdGljYWxseT8gSWYgaXQncyBleHBsaWNpdCwgdGhlbiBtYWtpbmcgYW4gYWRkaXRpb25hbA0K
PiByZXF1aXJlbWVudCAobWF0Y2hpbmcgbm9kZS1uYW1lcykgc2hvdWxkbid0IGJlIGEgcHJvYmxl
bS4NCg0KVGhlIHByb2JsZW0gaXMgdGhhdCBtaXJyb3IgZmlsdGVyIGlzIGFscmVhZHkgaW4gUmhl
bCBxZW11IGFuZCB3ZSBoYXZlIHRoaXMgYnVnLA0KYnV0IGxpYnZpcnQgaXMgbm90IHlldCBwcmVw
YXJlZCB0byBtYXRjaCBub2RlLW5hbWUgb24gbWlncmF0aW9uLCBvciBhbSBJIHdyb25nPw0KDQo+
IA0KPj4+IEEgc2ltcGxlIHdheSB0byBkbyB0aGlzIG1pZ2h0IGJlIGEgImNoaWxkX3VuZmlsdGVy
ZWQiIEJkcnZDaGlsZCByb2xlDQo+Pj4gdGhhdCBzaW1wbHkgYnlwYXNzZXMgdGhlIGZpbHRlciB0
aGF0IHdhcyBpbnNlcnRlZCBhbmQgc2VydmVzIG5vIHJlYWwNCj4+PiBwdXJwb3NlIG90aGVyIHRo
YW4gdG8gYWxsb3cgdGhlIGNoaWxkIHRvIGhhdmUgYSBwYXJlbnQgbGluayBhbmQgZmluZCB3aG8N
Cj4+PiBpdCdzICIiInJlYWwiIiIgcGFyZW50IGlzLg0KPj4+DQo+Pj4gQmVjYXVzZSBvZiBmbHVz
aGluZywgcmVvcGVuLCBzeW5jLCBkcmFpbiAmYyAmYyAmYyBJJ20gbm90IHN1cmUgaG93DQo+Pj4g
ZmVhc2libGUgdGhpcyBxdWljayBpZGVhIG1pZ2h0IGJlLCB0aG91Z2guDQo+Pj4NCj4+Pg0KPj4+
IC0gQ29yb2xsYXJ5IGZpeCAjMTogY2FsbCBlcnJvcl9zZXRnIGlmIHRoZSBiaXRtYXAgbm9kZSBu
YW1lIHRoYXQncyBhYm91dA0KPj4+IHRvIGdvIG92ZXIgdGhlIHdpcmUgaXMgYW4gYXV0b2dlbmVy
YXRlZCBub2RlOiB0aGlzIGlzIG5ldmVyIGNvcnJlY3QhDQo+Pj4NCj4+PiAoV2h5IG5vdD8gYmVj
YXVzZSB0aGUgdGFyZ2V0IGlzIGluY2FwYWJsZSBvZiBtYXRjaGluZyB0aGUgbm9kZS1uYW1lDQo+
Pj4gYmVjYXVzZSB0aGV5IGFyZSByYW5kb21seSBnZW5lcmF0ZWQgQU5EIHlvdSBjYW5ub3Qgc3Bl
Y2lmeSBub2RlLW5hbWVzDQo+Pj4gd2l0aCAjIHByZWZpeGVzIGFzIHRoZXkgYXJlIGVzcGVjaWFs
bHkgcmVzZXJ2ZWQhDQo+Pj4NCj4+PiAoVGhpcyByYWlzZXMgYSByZWxhdGVkIHByb2JsZW06IGlm
IHlvdSBleHBsaWNpdGx5IGFkZCBiaXRtYXBzIHRvIG5vZGVzDQo+Pj4gd2l0aCBhdXRvZ2VuZXJh
dGVkIG5hbWVzLCB5b3Ugd2lsbCBiZSB1bmFibGUgdG8gbWlncmF0ZSB0aGVtLikpDQo+Pj4NCj4+
DQo+PiBJbiBvdGhlciB3b3Jkcywgd2UgbmVlZCBhIHdlbGwgZGVmaW5lZCB3YXkgdG8gbWF0Y2gg
bm9kZXMgb24gc291cmNlIGFuZCBkZXN0aW5hdGlvbiwNCj4+IGtlZXBpbmcgaW4gbWluZCBmaWx0
ZXJzLCB0byBtaWdyYXRlIGJpdG1hcHMgY29ycmVjdGx5Lg0KPj4NCj4+IEhtLCBkaWQgeW91IHRo
b3VnaHQgYWJvdXQgYml0bWFwcyBpbiBmaWx0ZXJzPyBJdCdzIG5vdCBhIHByb2JsZW0gdG8gY3Jl
YXRlIGJpdG1hcCBpbg0KPj4gbWlycm9yLXRvcCBmaWx0ZXIgZHVyaW5nIG1pcnJvciBqb2I6KQ0K
Pj4NCj4+IE9yIHdoYXQgYWJvdXQgYml0bWFwcyBpbiBRdW9ydW0gY2hpbGRyZW4/IE9yIHdoYXQg
YWJvdXQgYml0bWFwIGluIHFjb3cyIGZpbGUgY2hpbGQgYnM/DQo+Pg0KPj4gSWYgbm9kZS1uYW1l
cyBhcmUgZGlmZmVyZW50IG9uIHNvdXJjZSBhbmQgZGVzdGluYXRpb24sIHdoYXQgaXMgdGhlIHNh
bWU/IFRvcCBibGsgbmFtZQ0KPj4gYW5kIGJkcnYtY2hpbGRyZW4gbmFtZXMgKEkgcmVjZW50bHkg
c2F3IE1heCdzIGlkZWEgdG8gY2hlY2sgbm9kZSAicGF0aCIgaW4gaW90ZXN0KS4NCj4gDQo+IGJs
a19uYW1lIGhhcyB0byBiZSBhc3N1bWVkIHRvIGJlICIiLiBUaGUgQmRydkNoaWxkIHBhdGggY2hh
bmdlcyB3aGVuDQo+IGZpbHRlcnMgYXJlIGluc2VydGVkIChhbmQgaW5zZXJ0aW5nIGZpbHRlcnMg
b24gdGhlIGRlc3RpbmF0aW9uIHRoYXQNCj4gYXJlbid0IHByZXNlbnQgb24gdGhlIHNvdXJjZSwg
b3IgdmljZSB2ZXJzYSwgc291bmRzIGxpa2Ugc29tZXRoaW5nIHRoYXQNCj4gc2hvdWxkIGp1c3Qg
d29yaykuDQoNClNraXBwaW5nIGZpbHRlcnMgaXMgbm90IGEgcHJvYmxlbSB1bnRpbCB3ZSBkb24n
dCB3YW50IGJpdG1hcHMgaW4gZmlsdGVycy4NCg0KPiANCj4gU28gYm90aCBwYXJ0cyBvZiB0aGlz
IGFyZSBub3QgZ3JlYXQgd2F5cyBmb3IgYWRkcmVzc2luZyBub2Rlcy4NCg0KTm90IGdyZWF0LCB5
ZXMuLg0KDQo+IA0KPj4gU28sIGFjdHVhbGx5IG5vZGUgaXMgbWlncmF0aW9uLWFkZHJlc3NhYmxl
LCBpZiBwYXRoIDxibGstbmFtZT4vcm9vdFsvY2hpbGQtbmFtZV0gdG8gdGhlDQo+PiBkZWZpbmVz
IHRoaXMgbm9kZSBkaXJlY3RseSAod2UgbXVzdCBub3QgaGF2ZSBjaGlsZHJlbiB3aXRoIHNhbWUg
bmFtZSBmb3Igc29tZSBub2RlIGluDQo+PiB0aGUgcGF0aCkuDQo+Pg0KPj4gQW5kIEkgdGhpbmsg
aXQncyBhIGNvcnJlY3Qgd2F5IHRvIGRlZmluZSBub2RlIGluIG1pZ3JhdGlvbiBzdHJlYW0gLSBi
eSBwYXRoLg0KPiANCj4gSSdtIGFmcmFpZCBub2RlLW5hbWUgaXMgdGhlIG9ubHkgdGhpbmcgdGhh
dCBjb3VsZCBwb3NzaWJseSB3b3JrIHJlbGlhYmx5DQo+IGZvciBpZGVudGlmeWluZyBub2Rlcy4N
Cj4gDQoNCkNhbiB3ZSBkbyBpdCB0byBmaXggYnVnIGluIGN1cnJlbnQgUmhlbCdzIHFlbXU/IEhv
dyBtdWNoIGVmZm9ydCBvbiBsaWJ2aXJ0IHBhcnQgaXMgbmVlZGVkPw0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

