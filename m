Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FAC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90F621920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ciBie/3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90F621920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdfK-00054s-Rt
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFde1-0004Km-QW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFde0-00070F-EW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:22:13 -0400
Received: from mail-eopbgr50126.outbound.protection.outlook.com
 ([40.107.5.126]:35515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFddv-0006uI-Lj; Wed, 02 Oct 2019 08:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdMzMIKoFW01lofEk6E39K/AcAdJoyXtaKbKPfDGVKJKlyL+7ZyRHxKm1kLoD7+tlt9cFU9fuXWToaxLbPMpsu2Ojn8mVUJbDfg4bMxGgeHa0nJD/SJ2Ii+hiLt+fqNIOL1wBopTdXC5xQjatUyixI5p0t900bxY4qOKQmatpdCgblrKR+Mu9WQfM5ZsrBQWCKW3HG+P3H/O2hJw9nX1loWTGmtEPkPihD0wemj88mSWpJSnCE4hhfjDErFSZUIeofUkmmCcS9WYlvA3zPVn0Tuxez31pWhguikTZC3XLLurNMos6eXJJhQznG4jOA1r9r38TIekYMoSv5l3H5hyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds0ypAe2y7m/yZyXoIi+eRJerqNk6+g7I9Gitw0/Ogs=;
 b=SRfzhAVkv2Qx5R0rofGsyCkkbZVQeWbAK0xL8bRtqdXktJoC7+aX0VQOzQrdlRFq66hwx07mBN89PDOvwRTz38Pus9eKTGqvL3zuiKpiUrxomX844AyaER9cb4w3h+DRu3iUby6/Ctt+KIUfJMWIcxn2ED60HcGC1l8VE2q0bp5+JHPt1Og83MTMJY2T6YF5UwXQYgErTeUZX32iAZp7/gvgiv9xT2FJRoUxdJP28ttZxvcQTtJ+oPmMR6q919UAVFBJFm0Ou7gN0Zp2OklJTTvfm+QymaLQlk2KpUeWl8ZlCOCC8EteyxL54K7SYwR2wYxQYGhBmjIKIxkEJD/Zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds0ypAe2y7m/yZyXoIi+eRJerqNk6+g7I9Gitw0/Ogs=;
 b=ciBie/3vdMBeUxwHx+K5mhY54T1IMeEWIRU6g059lzs4Pb1pdfRO3Mk/Kh8MP3IzCGNCuAFn6KLIxoxWy0F0XByR2Cs9wADGT/a/0JDLT3pB1USV/lfSZVHrjIB0IdHTwWgW7glacHrg9h99uHv0HgepAkc3/tr2XUxAk9jSbk8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4058.eurprd08.prod.outlook.com (20.179.10.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 12:22:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 12:22:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAAC+ICAAB3ngIAAAtYAgAE4ZQCAAAc0gIAAE54A
Date: Wed, 2 Oct 2019 12:22:01 +0000
Message-ID: <b102c656-0d17-16d7-3414-6828e569b90f@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
 <20191002111147.GB5819@localhost.localdomain>
In-Reply-To: <20191002111147.GB5819@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002152159991
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d164bace-f74f-40aa-9f46-08d747332103
x-ms-traffictypediagnostic: DB8PR08MB4058:
x-microsoft-antispam-prvs: <DB8PR08MB40580BB5BCE78EFB4CC0F69EC19C0@DB8PR08MB4058.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(376002)(136003)(396003)(39850400004)(366004)(199004)(189003)(305945005)(8936002)(7736002)(66946007)(64756008)(81166006)(66066001)(66556008)(81156014)(66476007)(66446008)(8676002)(31686004)(6512007)(6246003)(5024004)(14454004)(256004)(4326008)(5660300002)(14444005)(6116002)(3846002)(229853002)(99286004)(36756003)(6436002)(53546011)(102836004)(52116002)(386003)(6506007)(76176011)(26005)(316002)(478600001)(86362001)(31696002)(71200400001)(110136005)(54906003)(71190400001)(486006)(476003)(2616005)(11346002)(446003)(2906002)(25786009)(6486002)(186003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4058;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4Gx2Q6bkqYG29RuZ+zoT//mOYJzNATABuYULJ4lGJXtA3QO3b0ER1LUb1TE5mr+8/9eaOrJEM6eZpRcyHfP/ZQxVv8JXyu4b/zlsqNjoYWL6qS3fNCqF5np6arhf3nydEhRqw2JiYojrB9sflvbkkFCkPiNFXQ2cH6AuOuNJHviG7/WgV9fs6GcSxg8w48Fn8GU/TxBrFvKg1+7Gvta4+Omd4kw8hFtFGY1/VsbQTb4SV2CmYhoeXBM/1OaNKM2Vbi4gfDhPji/gWzNpzuGL/9d+ABImznIyWlBKF+CrFQHBuUympJwAtoMLqNSHaft7pirpTo+h7+FwJ6SirOwzN405gj/mI1jMHtPcQsaIdwQCq5vu4r/FsvJHcagAkd/5XdnX4i+1b0KccY94bNqGCyPT5Tfus2mpX+FInZP+p8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F99AE584DE149347B2F32D9205E8D067@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d164bace-f74f-40aa-9f46-08d747332103
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 12:22:02.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6onNUfqYw7uGbxxBiYf1Gqg5x9KHqk0snjAmcZOrQmU8yJTG/6Izm5p9+2gy3FwtIBZKvL5TJi3e3qS5/e0ZtaopTMbNlrqVbEDbrYA2POU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4058
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.126
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNDoxMSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDIuMTAuMjAxOSB1bSAx
Mjo0NiBoYXQgUGV0ZXIgS3JlbXBhIGdlc2NocmllYmVuOg0KPj4gT24gVHVlLCBPY3QgMDEsIDIw
MTkgYXQgMTI6MDc6NTQgLTA0MDAsIEpvaG4gU25vdyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24g
MTAvMS8xOSAxMTo1NyBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
Pj4gMDEuMTAuMjAxOSAxNzoxMCwgSm9obiBTbm93IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBPbiAxMC8xLzE5IDEwOjAwIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3Rl
Og0KPj4+Pj4+PiBPdGhlcndpc2U6IEkgaGF2ZSBhIGxvdCBvZiBjbG91ZHkgaWRlYXMgb24gaG93
IHRvIHNvbHZlIHRoaXMsIGJ1dA0KPj4+Pj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0
byBiZSBhYmxlIHRvIGZpbmQgdGhlICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+Pj4+Pj4gdGhl
IG5vZGUgdGhlIGJpdG1hcCBpcyBhdHRhY2hlZCB0bywgd2hpY2ggd291bGQgYmUgdGhlIG5hbWUg
b2YgdGhlIGZpcnN0DQo+Pj4+Pj4+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24ndCBhIGZpbHRlci4g
KE9SLCB0aGUgbmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPj4+Pj4+PiBhYm92ZSB0aGF0IG5v
ZGUuKQ0KPj4+Pj4+IE5vdCB0aGUgbmFtZSBvZiBhbmNlc3RvciBub2RlLCBpdCB3aWxsIGJyZWFr
IG1hcHBpbmc6IGl0IG11c3QgYmUgbmFtZSBvZiB0aGUNCj4+Pj4+PiBub2RlIGl0c2VsZiBvciBu
YW1lIG9mIHBhcmVudCAobWF5IGJlIHRocm91Z2ggc2V2ZXJhbCBmaWx0ZXJzKSBibG9jay1iYWNr
ZW5kDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBBaCwgeW91IGFyZSByaWdodCBvZiBjb3Vyc2UgLS0g
YmVjYXVzZSBibG9jay1iYWNrZW5kcyBhcmUgdGhlIG9ubHkNCj4+Pj4+ICJub2RlcyIgZm9yIHdo
aWNoIHdlIGFjdHVhbGx5IGRlc2NlbmQgdGhlIGdyYXBoIGFuZCBhZGQgdGhlIGJpdG1hcCB0bw0K
Pj4+Pj4gaXRzIGNoaWxkLg0KPj4+Pj4NCj4+Pj4+IFNvIHRoZSByZWFsIGJhY2stcmVzb2x1dGlv
biBtZWNoYW5pc20gaXM6DQo+Pj4+Pg0KPj4+DQo+Pj4gQW1lbmRtZW50Og0KPj4+ICAgICAtIElm
IG91ciBsb2NhbCBub2RlLW5hbWUgTiBpcyB3ZWxsLWZvcm1lZCwgdXNlIHRoaXMuDQo+Pg0KPj4g
SSdkIGxpa2UgdG8gcmUtaXRlcmF0ZSB0aGF0IHRoZSBuZWNlc3NpdHkgdG8ga2VlcCBub2RlIG5h
bWVzIHNhbWUgb24NCj4+IGJvdGggc2lkZXMgb2YgbWlncmF0aW9uIGlzIHVuZXhwZWN0ZWQsIHVu
ZG9jdW1lbnRlZCBhbmQgaW4gc29tZSBjYXNlcw0KPj4gaW1wb3NzaWJsZS4NCj4gDQo+IEkgdGhp
bmsgdGhlIChpbXBsaWNpdGx5IG1hZGUpIHJlcXVpcmVtZW50IGlzIG5vdCB0aGF0IGFsbCBub2Rl
LW5hbWVzIGFyZQ0KPiBrZXB0IHRoZSBzYW1lLCBidXQgb25seSB0aGUgbm9kZS1uYW1lcyBvZiB0
aG9zZSBub2RlcyBmb3Igd2hpY2gNCj4gbWlncmF0aW9uIHRyYW5zZmVycyBzb21lIHN0YXRlLg0K
PiANCj4gSXQgc2VlbXMgdG8gbWUgdGhhdCBiaXRtYXAgbWlncmF0aW9uIGlzIHRoZSBmaXJzdCBj
YXNlIG9mIHB1dHRpbmcNCj4gc29tZXRoaW5nIGluIHRoZSBtaWdyYXRpb24gc3RyZWFtIHRoYXQg
aXNuJ3QgcmVsYXRlZCB0byBhIGZyb250ZW5kLCBidXQNCj4gdG8gdGhlIGJhY2tlbmQsIHNvIHRo
ZSB1c3VhbCBkZXZpY2UgaGllcmFyY2h5IHRvIGFkZHJlc3MgaW5mb3JtYXRpb24NCj4gZG9lc24n
dCB3b3JrIGhlcmUuIEFuZCBpdCBzZWVtcyB0aGUgaW1wbGljYXRpb25zIG9mIHRoaXMgd2VyZW4n
dCByZWFsbHkNCj4gY29uc2lkZXJlZCBzdWZmaWNpZW50bHksIHJlc3VsdGluZyBpbiB0aGUgZGVz
aWduIHByb2JsZW0gd2UncmUNCj4gZGlzY3Vzc2luZyBub3cuDQo+IA0KPiBXaGF0IHdlIG5lZWQg
dG8gdHJhbnNmZXIgaXMgZGlydHkgYml0bWFwcywgd2hpY2ggY2FuIGJlIGF0dGFjaGVkIHRvIGFu
eQ0KPiBub2RlIGluIHRoZSBibG9jayBncmFwaC4gSWYgd2UgYWNjZXB0IHRoYXQgdGhlIHdheSB0
byB0cmFuc2ZlciB0aGlzIGlzDQo+IHRoZSBtaWdyYXRpb24gc3RyZWFtLCB3ZSBuZWVkIGEgd2F5
IHRvIHRlbGwgd2hpY2ggYml0bWFwIGJlbG9uZ3MgdG8NCj4gd2hpY2ggbm9kZS4gTWF0Y2hpbmcg
bm9kZS1uYW1lIGlzIHRoZSBvYnZpb3VzIGFuc3dlciwganVzdCBsaWtlIGENCj4gbWF0Y2hpbmcg
ZGV2aWNlIHRyZWUgaGllcmFyY2h5IGlzIHVzZWQgZm9yIGZyb250ZW5kcy4NCj4gDQo+IElmIHdl
IGRvbid0IHdhbnQgdG8gdXNlIHRoZSBtaWdyYXRpb24gc3RyZWFtIGZvciBiYWNrZW5kcywgd2Ug
d291bGQgbmVlZA0KPiB0byBmaW5kIGFub3RoZXIgd2F5IHRvIHRyYW5zZmVyIHRoZSBiaXRtYXBz
LiBJIHdvdWxkIHdlbGNvbWUgcmVtb3ZpbmcNCj4gYmFja2VuZCBkYXRhIGZyb20gdGhlIG1pZ3Jh
dGlvbiBzdHJlYW0sIGJ1dCBpZiB0aGlzIGluY2x1ZGVzDQo+IG5vbi1wZXJzaXN0ZW50IGJpdG1h
cHMsIEkgZG9uJ3Qgc2VlIHdoYXQgdGhlIGFsdGVybmF0aXZlIGNvdWxkIGJlLg0KDQpCdXQgaG93
IHRvIG1pZ3JhdGUgcGVyc2lzdGVudCBiaXRtYXBzIGlmIHN0b3JhZ2UgaXMgbm90IHNoYXJlZD8N
Cg0KQW5kIGV2ZW4gd2l0aCBvbmx5IHBlcnNpc3RlbnQgYml0bWFwcyBhbmQgc2hhcmVkIHN0b3Jh
Z2U6IGJpdG1hcHMgZGF0YSBtYXkNCmJlIGxhcmdlLCBhbmQgc3RvcmluZy9sb2FkaW5nIGl0IGR1
cmluZyBtaWdyYXRpb24gZG93bnRpbWUgd2lsbCBpbmNyZWFzZQ0KaXQuDQoNCj4gDQo+PiBJZiB5
b3Ugd2FudCB0byBtYW5kYXRlIHRoYXQgdGhleSBtdXN0IGJlIGtlcHQgdGhlIHNhbWUgcGxlYXNl
IGRvY3VtZW50DQo+PiBpdCBhbmQgYWxzbyBub3RlIHRoZSBmb2xsb3dpbmc6DQo+Pg0KPj4gLSBk
dXJpbmcgbWlncmF0aW9ucyB0aGUgc3RvcmFnZSBsYXlvdXQgbWF5IGNoYW5nZSBlLmcuIGEgYmFj
a2luZyBjaGFpbg0KPj4gICAgbWF5IGJlY29tZSBmbGF0dGVuZWQsIHRodXMga2VlcGluZyBub2Rl
IG5hbWVzIHN0YWJsZSBiZXlvbmQgdGhlIHRvcA0KPj4gICAgbGF5ZXIgaXMgaW1wb3NzaWJsZQ0K
PiANCj4gWW91IGRvbid0IHdhbnQgdG8gdHJhbnNmZXIgYml0bWFwcyBvZiBub2RlcyB0aGF0IHlv
dSdyZSBnb2luZyB0byBkcm9wLg0KPiBJJ20gbm90IGFuIGV4cGVydCBmb3IgdGhlc2UgYml0bWFw
cywgYnV0IEkgdGhpbmsgdGhpcyBqdXN0IG1lYW5zIHlvdQ0KPiB3b3VsZCBoYXZlIHRvIGRpc2Fi
bGUgYW55IGJpdG1hcHMgb24gdGhlIGJhY2tpbmcgZmlsZXMgdG8gYmUgZHJvcHBlZCBvbg0KPiB0
aGUgc291cmNlIGhvc3QgYmVmb3JlIHlvdSBtaWdyYXRlLg0KDQpZb3UgbWVhbiByZW1vdmUgdGhl
bS4uIEJ1dCB5ZXMsIGFueSB3YXkgaXQncyBub3QgYSBwcm9ibGVtLiBJZiBjb3JyZXNwb25kaW5n
DQpub2RlIGlzbid0IGV4aXN0IG9uIHRhcmdldCwgd2UgZG9uJ3QgbmVlZCBhbnkgYml0bWFwcyBm
b3IgaXQuDQoNCj4gDQo+PiAtIGluIHNvbWUgY2FzZXMgKHJlYWRvbmx5IGltYWdlIGluIGEgY2Ry
b20gbm90IHByZXNlbnQgb24gZGVzdGluYXRpb24sDQo+PiAgICB0aHVzIG5vdCByZWxldmFudCBo
ZXJlIHByb2JhYmx5KSBpdCBtYXkgZXZlbiBiZWNvbWUgaW1wb3NzaWJsZSB0bw0KPj4gICAgY3Jl
YXRlIGFueSBub2RlIHRodXMga2VlcGluZyB0aGUgdG9wIG5vZGUgbWF5IGJlIGltcG9zc2libGUN
Cj4gDQo+IFNhbWUgdGhpbmcsIHlvdSBkb24ndCB3YW50IHRvIHRyYW5zZmVyIGEgYml0bWFwIGZv
ciBhIG5vZGUgdGhhdA0KPiBkaXNhcHBlYXJzLg0KPiANCj4+IC0gaXQgc2hvdWxkIGJlIGRvY3Vt
ZW50ZWQgd2hlbiBhbmQgd2h5IHRoaXMgaGFwcGVucyBhbmQgaG93IG1hbmFnZW1lbnQNCj4+ICAg
IHRvb2xzIGFyZSBzdXBwb3NlZCB0byBkbyBpdA0KPj4NCj4+IC0gcGxlYXNlIGxldCBtZSBrbm93
IHdoYXQncyBhY3R1YWxseSBleHBlY3RlZCwgc2luY2UgbGlidmlydA0KPj4gICAgZGlkbid0IGVu
YWJsZSBibG9ja2RldiB5ZXQgd2UgY2FuIGZpeCBhbnkgdW5leHBlY3RlZCBleHBlY3RhdGlvbnMN
Cj4+DQo+PiAtIERvY3VtZW50IGl0IHNvIHRoYXQgdGhlIGV4cGVjdGF0aW9ucyBkb24ndCBjaGFu
Z2UgYWZ0ZXIgdGhpcy4NCj4gDQo+IFllcywgd2UgbmVlZCBhIGdvb2QgYW5kIGlkZWFsbHkgZnV0
dXJlLXByb29mIHJ1bGUgb2Ygd2hpY2ggbm9kZS1uYW1lcw0KPiBuZWVkIHRvIHN0YXkgdGhlIHNh
bWUuIEN1cnJlbnRseSBpdCdzIG9ubHkgYml0bWFwcywgYnV0IG1pZ2h0IHdlIGdldA0KPiBhbm90
aGVyIGZlYXR1cmUgbGF0ZXIgd2hlcmUgd2Ugd2FudCB0byB0cmFuc2ZlciBtb3JlIGJhY2tlbmQg
ZGF0YT8NCj4gDQo+PiAtIElkZWFsbHkgbm9kZSBuYW1lcyB3aWxsIG5vdCBiZSBib3VuZCB0byBh
bnl0aGluZyBhbmQgZnJlZWx5DQo+PiAgICBjaGFuZ2VhYmxlLiBJZiBuZWNlc3Nhcnkgd2UgY2Fu
IHByb3ZpZGUgYSBtYXAgdG8gcWVtdSBkdXJpbmcgbWlncmF0aW9uDQo+PiAgICB3aGljaCBpcyBw
cm9iYWJseSBsZXNzIHBhaW5mdWwgYW5kIG1vcmUgc3RyYWlnaHRmb3J3YXJkIHRoYW4ga2VlcGlu
Zw0KPj4gICAgdGhlbSBpbiBzeW5jIHNvbWVob3cgLi4uDQo+IA0KPiBBIG1hcCBmZWVscyBwYWlu
ZnVsIGZvciB0aGUgYXZlcmFnZSB1c2VyIChhbmQgZm9yIHRoZSBRRU1VDQo+IGltcGxlbWVudGF0
aW9uKSwgZXZlbiBpZiBpdCBsb29rcyBjb252ZW5pZW50IGZvciBsaWJ2aXJ0LiBJZiBhbnl0aGlu
ZywNCj4gSSdkIG1ha2UgaXQgb3B0aW9uYWwgYW5kIGRlZmF1bHQgdG8gMToxIG1hcHBpbmdzIGZv
ciBhbnl0aGluZyB0aGF0IGlzbid0DQo+IGV4cGxpY2l0bHkgbWFwcGVkLg0KPiANCg0KSG1tLCBJ
IGRvbid0IHRoaW5rIHRoYXQgb3B0aW9uYWwgbWFwIGlzIHBhaW5mdWwuDQoNCldoYXQgYWJvdXQg
dGhlIGZvbGxvd2luZzoNCg0KMS4gSWYgbWFwIGlzIHByb3ZpZGVkOg0KLSBtaWdyYXRlIG9ubHkg
Yml0bWFwcyBpbiBub2Rlcywgc3BlY2lmaWVkIGJ5IG1hcA0KLSBiaXRtYXBzIG1pZ3JhdGVkIG9u
bHkgYWNjb3JkaW5nbHkgdG8gdGhlIG1hcCwgYmxvY2sgZGV2aWNlIG5hbWVzIGFyZSBub3QgaW52
b2x2ZWQgYXQgYWxsDQoNCjIuIElmIG1hcCBub3QgcHJvdmlkZWQ6DQotIEZvciBub2RlcyBkaXJl
Y3RseSBib3VuZCB0byBuYW1lZCBibG9jayBiYWNrZW5kcywgb3IgdGhyb3VnaCBzZXZlcmFsIGZp
bHRlcnMsIHVzZSBuYW1lIG9mIHRoaXMNCmJsb2NrIGJhY2tlbmQuDQotIEZvciBvdGhlciBub2Rl
cyB1c2Ugbm9kZS1uYW1lDQoNCj09PQ0KDQpBbmQgSSB0aGluayBbMi5dIHNob3VsZCBiZSBkb25l
IG5vdyB0byBmaXggY3VycmVudCBidWcsIGFuZCBbMS5dIG1heSBiZSBwb3N0cG9uZWQgdW50aWwg
d2UNCnJlYWxseSBuZWVkIGl0Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

