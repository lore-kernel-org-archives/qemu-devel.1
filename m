Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A360C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D942081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bKiYvnum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D942081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cWm-0002RU-Gp
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7cMd-0008Aq-PT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7cMb-0001KQ-Ca
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:23:06 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com
 ([40.107.3.102]:6406 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7cMa-0001Jd-LW; Tue, 10 Sep 2019 05:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFO04mj/oWIH/072b0FDvzw5AcdPiwyJC/Rlz22N9FpbhA0krxg8l14IuYwIHBCxtpyMTPUN7ihkPLrgaz5U57nGxmm40HRionvZ8iOSslgeGQJAHn24MEfBxuH+GBFHsWf/Foi8ab2VtAj4r2taz0ALsP3dJuYvLywK/J6L4SW4mgdA1m7v7g1OjuOWRG/PlQN4t1hoqcyTN0Iewx3nnyQWn0wcyVQzMBpAO+EUCjpGj18spI7bw7fA8f88V4Bwjlq1NKZtlFh3Oa/dOrLwJVyzPJiSXR9y0aD0sR/QxfvccrEudoOzHHPU9q+IgEo0WH90P6k1qrmVm5ZATDNW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifLEhsHM36ECVEoIjLwMko5CeOvGtPT5vrIzrcyxFII=;
 b=X2K1cz/sGRgHk8oiHM6C3CMjkyCfR1LXqrHzTh9SPGtjsxksM5RwoXXeOfYWYigOldIUyE44VPxJZ1iI+qU2uAT9UxUZ8cDOiE0afWdN2k4zMlJgg1s3ZZOxJqI+eeTKfjEfgR1y4233qkLdqIznQ54nb31ZF0ikP90c3fKsa6MV7d9+j7dhx+GTmoPORdwkZEOiYfdkpwxh56YKmnsvjmR1FQpXC13owMZ8eMnprndsEXwq5kWlGcqvbbUwk80p5TE69YKwd96hE/W3uWcfksaAaqB0zhxUPCGNmE0hNdmweGQ4X3IRmUYJKnh3R+c2oFKrxzrYaHc2C7adQdkzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifLEhsHM36ECVEoIjLwMko5CeOvGtPT5vrIzrcyxFII=;
 b=bKiYvnumh3AWiki86k6KMLS/YG7uDQmyzyJgzXPpeXHyAnyNioku50KTbgRVZY4fxuLYjQv8a2rFvl4G7+6tUTmbr3Aob+z2mhThi4SrhsfxBTil4hRHu1vtYqU4fWUgukgfjFBALC9mKMC/MOnHiHt1xKPuMUgunFhuQ6zkk8I=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5210.eurprd08.prod.outlook.com (10.255.17.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.19; Tue, 10 Sep 2019 09:23:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 09:23:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVX03FFzbmaM/Nm0mHXVJ2sTGOiKcjXkKAgABGsID//9DwAIAADU8AgAEU5gCAAAgnAIAAB5qAgAAMNoA=
Date: Tue, 10 Sep 2019 09:22:59 +0000
Message-ID: <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
 <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
 <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
In-Reply-To: <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190910122256994
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e606c80b-b162-41c1-64ac-08d735d07921
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5210; 
x-ms-traffictypediagnostic: DB8PR08MB5210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5210DF924A1C6B118604D85FC1B60@DB8PR08MB5210.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39840400004)(199004)(189003)(52314003)(14444005)(6512007)(71190400001)(52116002)(2501003)(256004)(478600001)(76176011)(8936002)(53936002)(102836004)(31696002)(6506007)(99286004)(386003)(186003)(53546011)(305945005)(8676002)(7416002)(7736002)(4326008)(81156014)(81166006)(86362001)(66556008)(64756008)(66446008)(66946007)(31686004)(66476007)(486006)(2906002)(6436002)(6486002)(36756003)(6116002)(107886003)(26005)(6246003)(2616005)(14454004)(110136005)(54906003)(446003)(316002)(476003)(11346002)(25786009)(5660300002)(66066001)(71200400001)(229853002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5210;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h/ZAERnlBMYxtWnOK9V0yC4UkvZV8EpD+sM5UrqK6LrTQsDfUXA1In0nK3Dl3qOidnFgJ4DW0+9zm1aQNsowFSgW3vs76lFgaweJnn2/9Nr2i/pm3HsSnFcdq5q/hlR2psT6vRDIQwmQ0P1ijJPw1pHpFJHzYoQGsVMZqOOt4AgqqYmiXBlJMDwRNWPMjULYHaYRIk1DeLjANjaOVNyEDs1mxailcSumigZWXzimY40wlGnEjhtmjriIngmMBi/EmwBR6CW24W0KxtrY9Gut8qam3nhG7QjZmpjZ9nvQN6GplXrdPU8PVlz1mx6YJbZFD8Du9imHHKoTtD7fRpQ+c78sldImgtm+v2bl1dL7+JNqjUzu9sFjQ+nJIpbws3AE1NARx4GvcICB7w4+osx2EhQ+AnoVNKD+pPDbVj3LIYQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <501145D1F437AE4AB494E70D68B2522F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e606c80b-b162-41c1-64ac-08d735d07921
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 09:22:59.9466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpN95mv0ShCN4/jx+MmiNsLihAjeuDCl6KKbzARg7tUq4vrgaG1R8KKXx9NsHDp8/QZiuFZtSQTLooJSscmTvohvA1Zss7RV4EpBjNo5GIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5210
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.102
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxMTozOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMC4wOS4xOSAxMDoxMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEwLjA5LjIwMTkgMTA6NDIs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwOS4wOS4xOSAxNzoxMSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDkuMDkuMjAxOSAxNzoyNCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMDkuMDkuMTkgMTY6MTIsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMDkuMDkuMjAxOSAxNTo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+
Pj4+PiBPbiAzMC4wOC4xOSAxODoxMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+Pj4+Pj4+IFNwbGl0IGNvcHlpbmcgY29kZSBwYXJ0IGZyb20gYmFja3VwIHRvICJibG9j
ay1jb3B5IiwgaW5jbHVkaW5nIHNlcGFyYXRlDQo+Pj4+Pj4+PiBzdGF0ZSBzdHJ1Y3R1cmUgYW5k
IGZ1bmN0aW9uIHJlbmFtaW5nLiBUaGlzIGlzIG5lZWRlZCB0byBzaGFyZSBpdCB3aXRoDQo+Pj4+
Pj4+PiBiYWNrdXAtdG9wIGZpbHRlciBkcml2ZXIgaW4gZnVydGhlciBjb21taXRzLg0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4+IE5vdGVzOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IDEuIEFzIEJsb2NrQ29weVN0
YXRlIGtlZXBzIG93biBCbG9ja0JhY2tlbmQgb2JqZWN0cywgcmVtYWluaW5nDQo+Pj4+Pj4+PiBq
b2ItPmNvbW1vbi5ibGsgdXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJsa19icygpIGNh
bGwsIHNvIGNsZWFyDQo+Pj4+Pj4+PiBqb2ItPmNvbW1lbi5ibGsgcGVybWlzc2lvbnMgc2V0IGlu
IGJsb2NrX2pvYl9jcmVhdGUgYW5kIGFkZA0KPj4+Pj4+Pj4gam9iLT5zb3VyY2VfYnMgdG8gYmUg
dXNlZCBpbnN0ZWFkIG9mIGJsa19icyhqb2ItPmNvbW1vbi5ibGspLCB0byBrZWVwDQo+Pj4+Pj4+
PiBpdCBtb3JlIGNsZWFyIHdoaWNoIGJzIHdlIHVzZSB3aGVuIGludHJvZHVjZSBiYWNrdXAtdG9w
IGZpbHRlciBpbg0KPj4+Pj4+Pj4gZnVydGhlciBjb21taXQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4g
Mi4gUmVuYW1lIHMvaW5pdGlhbGl6aW5nX2JpdG1hcC9za2lwX3VuYWxsb2NhdGVkLyB0byBzb3Vu
ZCBhIGJpdCBiZXR0ZXINCj4+Pj4+Pj4+IGFzIGludGVyZmFjZSB0byBCbG9ja0NvcHlTdGF0ZQ0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IDMuIFNwbGl0IGlzIG5vdCB2ZXJ5IGNsZWFuOiB0aGVyZSBsZWZ0
IHNvbWUgZHVwbGljYXRlZCBmaWVsZHMsIGJhY2t1cA0KPj4+Pj4+Pj4gY29kZSB1c2VzIHNvbWUg
QmxvY2tDb3B5U3RhdGUgZmllbGRzIGRpcmVjdGx5LCBsZXQncyBwb3N0cG9uZSBpdCBmb3INCj4+
Pj4+Pj4+IGZ1cnRoZXIgaW1wcm92ZW1lbnRzIGFuZCBrZWVwIHRoaXMgY29tbWVudCBzaW1wbGVy
IGZvciByZXZpZXcuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pj4+Pj4g
LS0tDQo+Pj4+Pj4+PiAgICAgIGJsb2NrL2JhY2t1cC5jICAgICB8IDM1NyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+Pj4+ICAgICAgYmxvY2svdHJh
Y2UtZXZlbnRzIHwgIDEyICstDQo+Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgMjMxIGlu
c2VydGlvbnMoKyksIDEzOCBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4+Pj4gaW5kZXggYWJi
NTA5OWZhMy4uMDAyZGVlNGQ3ZiAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5j
DQo+Pj4+Pj4+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4+Pj4gQEAgLTM1LDEyICszNSw0
MyBAQCB0eXBlZGVmIHN0cnVjdCBDb3dSZXF1ZXN0IHsNCj4+Pj4+Pj4+ICAgICAgICAgIENvUXVl
dWUgd2FpdF9xdWV1ZTsgLyogY29yb3V0aW5lcyBibG9ja2VkIG9uIHRoaXMgcmVxdWVzdCAqLw0K
Pj4+Pj4+Pj4gICAgICB9IENvd1JlcXVlc3Q7DQo+Pj4+Pj4+PiAgICAgIA0KPj4+Pj4+Pj4gK3R5
cGVkZWYgdm9pZCAoKlByb2dyZXNzQnl0ZXNDYWxsYmFja0Z1bmMpKGludDY0X3QgYnl0ZXMsIHZv
aWQgKm9wYXF1ZSk7DQo+Pj4+Pj4+PiArdHlwZWRlZiB2b2lkICgqUHJvZ3Jlc3NSZXNldENhbGxi
YWNrRnVuYykodm9pZCAqb3BhcXVlKTsNCj4+Pj4+Pj4+ICt0eXBlZGVmIHN0cnVjdCBCbG9ja0Nv
cHlTdGF0ZSB7DQo+Pj4+Pj4+PiArICAgIEJsb2NrQmFja2VuZCAqc291cmNlOw0KPj4+Pj4+Pj4g
KyAgICBCbG9ja0JhY2tlbmQgKnRhcmdldDsNCj4+Pj4+Pj4+ICsgICAgQmRydkRpcnR5Qml0bWFw
ICpjb3B5X2JpdG1hcDsNCj4+Pj4+Pj4+ICsgICAgaW50NjRfdCBjbHVzdGVyX3NpemU7DQo+Pj4+
Pj4+PiArICAgIGJvb2wgdXNlX2NvcHlfcmFuZ2U7DQo+Pj4+Pj4+PiArICAgIGludDY0X3QgY29w
eV9yYW5nZV9zaXplOw0KPj4+Pj4+Pj4gKyAgICB1aW50NjRfdCBsZW47DQo+Pj4+Pj4+PiArDQo+
Pj4+Pj4+PiArICAgIEJkcnZSZXF1ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3M7DQo+Pj4+Pj4+PiArDQo+
Pj4+Pj4+PiArICAgIC8qDQo+Pj4+Pj4+PiArICAgICAqIHNraXBfdW5hbGxvY2F0ZWQ6IGlmIHRy
dWUsIG9uIGNvcHkgb3BlcmF0aW9uIGZpcnN0bHkgcmVzZXQgYXJlYXMNCj4+Pj4+Pj4+ICsgICAg
ICogdW5hbGxvY2F0ZWQgaW4gdG9wIGxheWVyIG9mIHNvdXJjZSAoYW5kIHRoZW4gb2YgY291cnNl
IGRvbid0IGNvcHkNCj4+Pj4+Pj4+ICsgICAgICogY29ycmVzcG9uZGluZyBjbHVzdGVycykuIElm
IHNvbWUgYnl0ZXMgcmVzZXQsIGNhbGwNCj4+Pj4+Pj4+ICsgICAgICogcHJvZ3Jlc3NfcmVzZXRf
Y2FsbGJhY2suDQo+Pj4+Pj4+PiArICAgICAqLw0KPj4+Pj4+Pg0KPj4+Pj4+PiBJdCBpc27igJl0
IHF1aXRlIGNsZWFyIHRoYXQgdGhpcyByZWZlcnMgdG8gdGhlIGNvcHlfYml0bWFwLiAgTWF5YmUN
Cj4+Pj4+Pj4gc29tZXRoaW5nIGxpa2UNCj4+Pj4+Pj4NCj4+Pj4+Pj4g4oCcSWYgdHJ1ZSwgdGhl
IGNvcHkgb3BlcmF0aW9uIHByZXBhcmVzIGEgc3luYz10b3Agam9iOiBJdCBzY2FucyB0aGUNCj4+
Pj4+Pg0KPj4+Pj4+IGhtbSwgbm93IGl0J3Mgbm90IHJlZmFjdG9yZWQgdG8gc2NhbiBpdCBiZWZv
cmUgY29weWluZyBsb29wLCBzbyBpdCdzIG5vdCBwcmVjaXNlDQo+Pj4+Pj4gd29yZGluZy4uDQo+
Pj4+Pj4NCj4+Pj4+Pj4gc291cmNlJ3MgdG9wIGxheWVyIHRvIGZpbmQgYWxsIHVuYWxsb2NhdGVk
IGFyZWFzIGFuZCByZXNldHMgdGhlbSBpbiB0aGUNCj4+Pj4+Pg0KPj4+Pj4+IE5vdCBhbGwsIGJ1
dCBtb3N0bHkgaW5zaWRlIGJsb2NrLWNvcHkgcmVxdWVzdGVkIGFyZWEgKGJ1dCBtYXkgYmUgbW9y
ZSkNCj4+Pj4+DQo+Pj4+PiBTb3JyeSwgSSBtZWFudCBiYWNrdXAgb3BlcmF0aW9uLg0KPj4+Pj4N
Cj4+Pj4+Pj4gY29weV9iaXRtYXAgKHNvIHRoZXkgd2lsbCBub3QgYmUgY29waWVkKS4gIFdoZW5l
dmVyIGFueSBzdWNoIGFyZWEgaXMNCj4+Pj4+Pj4gY2xlYXJlZCwgcHJvZ3Jlc3NfcmVzZXRfY2Fs
bGJhY2sgd2lsbCBiZSBpbnZva2VkLg0KPj4+Pj4+PiBPbmNlIHRoZSB3aG9sZSB0b3AgbGF5ZXIg
aGFzIGJlZW4gc2Nhbm5lZCwgc2tpcF91bmFsbG9jYXRlZCBpcyBjbGVhcmVkDQo+Pj4+Pj4+IGFu
ZCB0aGUgYWN0dWFsIGNvcHlpbmcgYmVnaW5zLuKAnQ0KPj4+Pj4+DQo+Pj4+Pj4gTGFzdCBzZW50
ZW5jZSBzb3VuZHMgbGlrZSBpdCdzIGEgYmxvY2stY29weSB3aG8gd2lsbCBjbGVhciBza2lwX3Vu
YWxsb2NhdGVkLA0KPj4+Pj4+IGJ1dCBpdCdzIG5vdCBzby4gSXQncyBub3QgdmVyeSBnb29kIGRl
c2lnbiBhbmQgbWF5IGJlIHJlZmFjdG9yZWQgaW4gZnV0dXJlLA0KPj4+Pj4+IGJ1dCBmb3Igbm93
LCBJJ2QgYmV0dGVyIGRyb3AgbGFzdCBzZW50ZW5jZS4NCj4+Pj4+DQo+Pj4+PiBCdXQgd2FzbuKA
mXQgdGhhdCB0aGUgcG9pbnQgb2YgdGhpcyB2YXJpYWJsZT8gIFRoYXQgaXQgZ29lcyBiYWNrIHRv
IGZhbHNlDQo+Pj4+PiBvbmNlIHRoZSBiaXRtYXAgaXMgZnVsbHkgaW5pdGlhbGl6ZWQ/DQo+Pj4+
DQo+Pj4+IEkganVzdCB3YW50IHRvIHN0cmVzcywgdGhhdCBibG9jay1jb3B5IGl0c2VsZiAod2hp
Y2ggd2lsbCBiZSBpbiBhIHNlcGFyYXRlIGZpbGUsDQo+Pj4+IHNvIGl0IHdvdWxkIGJlIGNsZWFu
IGVub3VnaCwgd2hhdCBpcyBibG9jay1jb3B5IGFuZCB3aGF0IGlzIGl0cyB1c2VyKSBkbyBub3Qg
Y2xlYXINCj4+Pj4gdGhpcyB2YXJpYWJsZS4gSXQgb2YgY291cnNlIG1heSB0cmFjayBjYWxscyB0
byAgYmxvY2tfY29weV9yZXNldF91bmFsbG9jYXRlZCgpIGFuZA0KPj4+PiBjbGVhciB0aGlzIHZh
cmlhYmxlIGF1dG9tYXRpY2FsbHksIGJ1dCBpdCBkb24ndCBkbyBpdCBub3cuIEFuZCB5b3VyIHdv
cmRpbmcgbG9va3MNCj4+Pj4gZm9yIG1lIGxpa2UgYmxvY2stY29weSBjb2RlIG1heSBhdXRvbWF0
aWNhbGx5IGNsZWFyIHRoaXMgdmFyaWFibGUNCj4+Pg0KPj4+IEhtLCBPSy4NCj4+Pg0KPj4+Pj4N
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gaW5zdGVhZD8NCj4+Pj4+Pg0KPj4+Pj4+IE9yLCB3aGF0IGFib3V0
IHRoZSBmb2xsb3dpbmcgbWl4Og0KPj4+Pj4+DQo+Pj4+Pj4gVXNlZCBmb3Igam9iIHN5bmM9dG9w
IG1vZGUuIElmIHRydWUsIGJsb2NrX2NvcHkoKSB3aWxsIHJlc2V0IGluIGNvcHlfYml0bWFwIGFy
ZWFzDQo+Pj4+Pj4gdW5hbGxvY2F0ZWQgaW4gdG9wIGltYWdlIChzbyB0aGV5IHdpbGwgbm90IGJl
IGNvcGllZCkuIFdoZW5ldmVyIGFueSBzdWNoIGFyZWEgaXMgY2xlYXJlZCwNCj4+Pj4+PiBwcm9n
cmVzc19yZXNldF9jYWxsYmFjayB3aWxsIGJlIGludm9rZWQuIFVzZXIgaXMgYXNzdW1lZCB0byBj
YWxsIGluIGJhY2tncm91bmQNCj4+Pj4+PiBibG9ja19jb3B5X3Jlc2V0X3VuYWxsb2NhdGVkKCkg
c2V2ZXJhbCB0aW1lcyB0byBjb3ZlciB0aGUgd2hvbGUgY29waWVkIGRpc2sgYW5kDQo+Pj4+Pj4g
dGhlbiBjbGVhciBza2lwX3VuYWxsb2NhdGVkLCB0byBwcmV2ZW50IGV4dHJhIGVmZm9ydC4NCj4+
Pj4+DQo+Pj4+PiBJIGRvbuKAmXQga25vdy4gIFRoZSBwb2ludCBvZiB0aGlzIHZhcmlhYmxlIGlz
IHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUNCj4+Pj4+IGJpdG1hcC4gIGJsb2NrLWNvcHkgb25s
eSB1c2VzIHRoaXMgYXMgYSBoaW50IHRoYXQgaXQgbmVlZHMgdG8NCj4+Pj4+IHBhcnRpY2lwYXRl
IGluIHRoYXQgaW5pdGlhbGl6YXRpb24gcHJvY2VzcywgdG9vLCBhbmQgY2Fubm90IGFzc3VtZSB0
aGUNCj4+Pj4+IGJpdG1hcCB0byBiZSBmdWxseSBhbGxvY2F0ZWQuDQo+Pj4+DQo+Pj4+IEhtbSwg
YnV0IHdoZXJlIGlzIGEgY29uZmxpY3Qgb2YgdGhpcyBhbmQgbXkgd29yZGluZz8gSU1ITywgSSBq
dXN0IGRvY3VtZW50ZWQNCj4+Pj4gZXhhY3RseSB3aGF0J3Mgd3JpdHRlbiBpbiB0aGUgY29kZS4N
Cj4+Pg0KPj4+IFRoZXJl4oCZcyBubyBjb25mbGljdCBiZWNhdXNlIGl0IGlzbuKAmXQgbWVudGlv
bmVkOyB3aGljaCBpcyB0aGUgcHJvYmxlbSBJDQo+Pj4gaGF2ZSB3aXRoIGl0Lg0KPj4+DQo+Pj4g
V2hhdCBJIHdhcyByZWFsbHkgY29uZnVzZWQgYWJvdXQgaXMgd2hvIGNvbnN1bWVzIHRoZSB2YXJp
YWJsZS4gIEl0IGFsbA0KPj4+IGJlY29tZXMgbXVjaCBjbGVhcmVyIHdoZW4gSSB0YWtlIGl0IGFz
IGEgZ2l2ZW4gdGhhdCBhbGwgb2YgeW91cg0KPj4+IGRlc2NyaXB0aW9uIGp1c3QgaXMgYW4gaW1w
ZXJhdGl2ZSB0byBibG9jay1jb3B5LiAgVGhhdCBzaW1wbHkgd2FzbuKAmXQNCj4+PiBjbGVhciB0
byBtZS4gIChXaGljaCBpcyB3aHkgeW91IGRvbuKAmXQgbGlrZSBteSBkZXNjcmlwdGlvbiwgcHJl
Y2lzZWx5DQo+Pj4gYmVjYXVzZSBpdCB0ZWxscyB0aGUgc3RvcnkgZnJvbSBhbm90aGVyIFBPViwg
bmFtZWx5IHRoYXQgb2YgYmFja3VwLikNCj4+Pg0KPj4+IEZ1cnRoZXJtb3JlLCBJIGp1c3QgbWlz
cyB0aGUgYmlnIHBpY3R1cmUgYWJvdXQgaXQuICBXaHkgZG9lcyB0aGUNCj4+PiB2YXJpYWJsZSBl
dmVuIGV4aXN0Pw0KPj4NCj4+IFRvbyBrZWVwIGl0IHNpbXBsZXIgZm9yIG5vdywgd2UgY2FuIGlt
cHJvdmUgaXQgYXMgYSBmb2xsb3ctdXAuIEkgc2VlDQo+PiBzZXZlcmFsIHNvbHV0aW9uczoNCj4+
DQo+PiAxLiB0cmFjayBzZXF1ZW50aWFsIGNhbGxzIHRvIGJsb2NrX2NvcHlfcmVzZXRfdW5hbGxv
Y2F0ZWQoKSBhbmQgd2hlbg0KPj4gaXQgY29tZXMgdG8gdGhlIGRpc2sgZW5kIC0gY2xlYXIgdGhl
IHZhcmlhYmxlDQo+Pg0KPj4gMi4gZG9uJ3QgcHVibGlzaCBibG9ja19jb3B5X3Jlc2V0X3VuYWxs
b2NhdGVkKCkgYXQgYWxsLCBhc3N1bWluZyBzZXF1ZW50aWFsDQo+PiBjYWxscyB0byBibG9ja19j
b3B5KCkgYW5kIGRvIGxpa2UgaW4gKDEuKQ0KPj4NCj4+IDMuIGtlZXAgYWRkaXRpb25hbCBiaXRt
YXAgdG8gdHJhY2ssIHdoYXQgd2FzIGFscmVhZHkgZXhwbG9yZWQgYWJvdXQgYmVpbmcNCj4+IGFs
bG9jYXRlZC91bmFsbG9jYXRlZCAoc2VlbXMgdG9vIG11Y2gpDQo+IA0KPiBTb3JyeSwgb3ZlciBz
b21lIGVkaXRpbmcgSSBhY2NpZGVudGFsbHkgcmVtb3ZlZCB0aGUgbWVhbmluZyBmcm9tIHdoYXQg
SQ0KPiB3cm90ZSB0aGVyZS4gIEkgZGlkbuKAmXQgbWVhbiBsaXRlcmFsbHkg4oCcV2h5IGRvZXMg
dGhlIHZhcmlhYmxlIGV4aXN04oCdIG9yDQo+IOKAnEkgZG9u4oCZdCB1bmRlcnN0YW5kIHRoZSBi
aWcgcGljdHVyZeKAnS4gIEkgbWVhbnQg4oCcVGhlIGNvbW1lbnQgZG9lcyBub3QNCj4gZXhwbGFp
biB0aGUgYmlnIHBpY3R1cmUsIGZvciBleGFtcGxlLCBpdCBkb2VzIG5vdCBleHBsYWluIHdoeSB0
aGUNCj4gdmFyaWFibGUgZXZlbiBleGlzdHMu4oCdDQo+IA0KDQoNCk9rLCB0aGFuDQoNCjQuIFBv
c3Rwb25lIGltcHJvdmVtZW50cyBmb3IgYSBmb2xsb3ctdXAgKGFueXdheSwgZmluYWxseSwgYmxv
Y2stY29weSBzaG91bGQNCnVzZSBibG9ja19zdGF0dXMgdG8gY29weSBieSBsYXJnZXIgY2h1bmtz
LCBsaWtlIG1pcnJvciBkb2VzKSwgYW5kIGltcHJvdmUgdGhlDQpjb21tZW50IGxpa2UgdGhpczoN
Cg0KIiIiDQpVc2VkIGZvciBqb2Igc3luYz10b3AgbW9kZSwgd2hpY2ggY3VycmVudGx5IHdvcmtz
IGFzIGZvbGxvd3MgKHRoZSBzaXplIG9mIHRoZQ0KY29tbWVudCBkZWZpbml0ZWx5IHNob3dzIHVu
Y2xlYW4gZGVzaWduLCBidXQgdGhpcyBpcyBhIFRPRE8gdG8gaW1wcm92ZSBpdCk6DQpJZiBqb2Ig
c3RhcnRlZCBpbiBzeW5jPXRvcCBtb2RlLCB3aGljaCBtZWFucyB0aGF0IHdlIHdhbnQgdG8gY29w
eSBvbmx5IHBhcnRzDQphbGxvY2F0ZWQgaW4gdG9wIGxheWVyLCBqb2Igc2hvdWxkIGJlaGF2ZSBs
aWtlIHRoaXM6DQoNCjEuIENyZWF0ZSBibG9jay1jb3B5IHN0YXRlIHdpdGggc2tpcF91bmFsbG9j
YXRlZCA9IHRydWUuDQoyLiBUaGVuLCBibG9ja19jb3B5KCkgd2lsbCBhdXRvbWF0aWNhbGx5IGNo
ZWNrIGZvciBhbGxvY2F0aW9uIGluIHRvcCBsYXllciwNCmFuZCBkbyBub3QgY29weSBhcmVhcyB3
aGljaCBhcmUgbm90IGFsbG9jYXRlZCBpbiB0b3AgbGF5ZXIuIFNvLCBmb3IgZXhhbXBsZSwNCmNv
cHktYmVmb3JlLXdyaXRlIG9wZXJhdGlvbnMgaW4gYmFja3VwIHdvcmtzIGNvcnJlY3RseSBldmVu
IGJlZm9yZSBbMy5dDQozLiBTZXF1ZW50aWFsbHkgY2FsbCBibG9ja19jb3B5X3Jlc2V0X3VuYWxs
b2NhdGVkKCkgdG8gY292ZXIgdGhlIHdob2xlIHNvdXJjZQ0Kbm9kZSwgY29weV9iaXRtYXAgd2ls
bCBiZSB1cGRhdGVkIGNvcnJlc3BvbmRpbmdseS4NCjQuIFVuc2V0IHNraXBfdW5hbGxvY2F0ZWQg
dmFyaWFibGUgaW4gYmxvY2stY29weSBzdGF0ZSwgdG8gYXZvaWQgZXh0cmEgKGFzDQpldmVyeXRo
aW5nIGlzIGNvdmVyZWQgYnkgWzMuXSkgYmxvY2stc3RhdHVzIHF1ZXJpZXMgaW4gYmxvY2tfY29w
eSgpIGNhbGxzDQo1LiBEbyBzZXF1ZW50aWFsIGNvcHlpbmcgYnkgbG9vcCBvZiBibG9ja19jb3B5
KCkgY2FsbHMsIGFsbCBuZWVkZWQgYWxsb2NhdGlvbg0KaW5mb3JtYXRpb24gaXMgYWxyZWFkeSBp
biBjb3B5X2JpdG1hcC4NCg0KIEZyb20gYmxvY2tfY29weSgpIHNpZGUsIGl0IGJlaGF2ZXMgbGlr
ZSB0aGlzOg0KSWYgc2tpcF91bmFsbG9jYXRlZCBpcyBzZXQsIGJsb2NrX2NvcHkoKSB3aWxsIHJl
c2V0IGluIGNvcHlfYml0bWFwIGFyZWFzDQp1bmFsbG9jYXRlZCBpbiB0b3AgaW1hZ2UgKHNvIHRo
ZXkgd2lsbCBub3QgYmUgY29waWVkKS4gV2hlbmV2ZXIgYW55IHN1Y2gNCmFyZWEgaXMgY2xlYXJl
ZCwgcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkLiBOb3RlLCB0aGF0DQpw
cm9ncmVzc19yZXNldF9jYWxsYmFjayBpcyBjYWxsZWQgZnJvbSBibG9ja19jb3B5X3Jlc2V0X3Vu
YWxsb2NhdGVkKCkgdG9vLg0KIiIiDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

