Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D327C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4843920830
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XnXNi97i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4843920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPgx-0008VQ-Ci
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGPfL-0007qP-8F
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGPfJ-0007Tc-Ar
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:38:46 -0400
Received: from mail-eopbgr20107.outbound.protection.outlook.com
 ([40.107.2.107]:48138 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGPfF-0007Qd-O5; Fri, 04 Oct 2019 11:38:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNDGBQXfQaG4Hbk+ZpuQMsLncUqZL8HL+AQNzfDLKQJfwZoDKnkrQq6zR0L6OVtyZgncqsKC+22SgfBNc0i+6vY/u0OOJLmI3zQ5pS/9BAsgVabygU0wBkgu/aGLmU3GjP17EGEwFn6PnQAOo2LT0Sz+gcvTwk1xUxgL5RtZ2ymmj/xtkwj2cN6yydXSugaeyvoOyDgm21Zyfhuj8QXRYzvseOtwOfszeTR9/y3qL0oY+DRCZUx69uJuYUPrLhU4+S5V0V7qNnRg45sM2/aKMuDwGDu/oNhtBvQZtpjegI1kNq96s8CDuYp5em1aXnNeypeIaxkOiHMjxdbcV7k5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SguuLWt2vYdgh/kQJbyj8syG2N/KDOAyhc7H2lJ1sTA=;
 b=F/DgkYsf8aItrBJDDezBcVmtzrKk8TTIVTlm/qtBX0y6Yd3fIlpZGOceg5sum3RiDiNVzSRfDjZrSg4zZXVLkSKEZf5l16jR/6L6ehOSc31PQAxYRnPLT9OiRNKFEChkUjEm03QovviCX2oq4WcVdViYfjx0KH6BeGqdRrxYn04qSumVcRJu+Ln+OBBVCqz0udgtIIT7MJQdQKeVb0j0jBBBwnLPWnLN1lZcaY7MReP6irGoQ4ZJbrhmzxMmYFvhUF5S9srms4G35iIRM1o7r7P2XBz8AsrwJkpRq/FA/CMKY93S6ZPLuZMRawr3WsLIudGT+ITjs/XAml8E6ZmQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SguuLWt2vYdgh/kQJbyj8syG2N/KDOAyhc7H2lJ1sTA=;
 b=XnXNi97ioOcaljG5zFGrNAs8Ha1vM2gQAERz/lllbbzCs1Xs+lpjuFOluHoDKp6dABpTbnysDcqqrvX2yuqu+ndr+t584cTdOM342sMAiqogHkxkyJpmrnyZX/nCQnuVDd34r9pPAagB/zCS7xn4im8DtH9F5LLr8Lp9CXPUheM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5385.eurprd08.prod.outlook.com (52.133.241.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Fri, 4 Oct 2019 15:38:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 15:38:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAA0KAD//857AIAADO6AgAFa8ICAAZlDgIAABlQAgAAYAACAAASFgIAABo4AgAADDIA=
Date: Fri, 4 Oct 2019 15:38:37 +0000
Message-ID: <8e8827ad-16be-792e-3b92-ba1ad6e18f2d@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
 <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
 <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
 <3193c71d-cd5e-fa94-4dc1-dc8ebbe9ce22@virtuozzo.com>
 <65b4fd06-4d66-ebc3-4e0e-1e8c2d983ef6@redhat.com>
 <76736494-f3f6-6b42-e3cc-260250a8d862@virtuozzo.com>
 <28b2674b-f720-e850-ae00-f5f85574e522@redhat.com>
In-Reply-To: <28b2674b-f720-e850-ae00-f5f85574e522@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0052.eurprd09.prod.outlook.com
 (2603:10a6:3:45::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191004183834965
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62003aeb-ee45-405b-58ec-08d748e0ec51
x-ms-traffictypediagnostic: DB8PR08MB5385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB538550280487DA8013611829C19E0@DB8PR08MB5385.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(376002)(136003)(346002)(199004)(189003)(66556008)(66476007)(66446008)(64756008)(31686004)(66946007)(110136005)(31696002)(54906003)(76176011)(14454004)(36756003)(99286004)(25786009)(478600001)(316002)(52116002)(2906002)(8676002)(3846002)(6116002)(66066001)(14444005)(256004)(8936002)(81156014)(81166006)(305945005)(2501003)(71200400001)(71190400001)(7736002)(53546011)(186003)(86362001)(6436002)(6486002)(26005)(446003)(102836004)(5660300002)(6512007)(4326008)(2616005)(229853002)(486006)(6506007)(386003)(11346002)(476003)(107886003)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5385;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F294bdsrPKLxldikc9SrZi/4UCX+bNf5aAmcusl4JJZGcKV8QNq8fPSYG4XWvdRE9FYzp4tzt8fBRCMupxNNAJqapPtthdyQUfty0VLud1aFn6YinhWqIQeYKb6yEIq54jNUOio3A44Ka+AD3IssDF0Vjb+TKRHWeU/T86XDw5aFf+bRa6IWAko67T4GIJLfEfG5joHeq/EDfR/hbijyHwMeDVb9tGPP758tlA0o06Z5n1grEcTmdrotcpStY3dd3ofzB/IaSRN2pvmU8CefbrvYQmz+XR/rKUX8TiHXHD8I6/wzFNPcWDDYqlRx9l2buU6RCeb+rpC23NSJlPbBK8Vrm10sQd307BdfME22qhrheZzj+CtHXZw0pn286mcSA6ICiMeFbR4dMGVI9E+ovPiKRGrgBRQC1cTS77fLuY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F07F06DC81D1241A50A81BD3678ADB2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62003aeb-ee45-405b-58ec-08d748e0ec51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 15:38:37.2804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcuVmot6cWc47GsPHkIHh5hG+/wM7kYqInWBzgnHsdOFYGsrUmPcKBA2xjFt9WXlhbceeq0qbJ8shKyMfCQFSF+J03IDj96+f/a2YkMGfjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5385
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.107
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNC4xMC4xOSAxNzowNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA0LjEwLjIwMTkgMTc6NDgs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwNC4xMC4xOSAxNToyMiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDQuMTAuMjAxOSAxNTo1OSwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMDMuMTAuMTkgMTE6MzQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMDIuMTAuMjAxOSAxODo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+
Pj4+PiBPbiAwMi4xMC4xOSAxNzowNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+Pj4+Pj4+IDAyLjEwLjIwMTkgMTg6MDMsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4+Pj4gMDIuMTAuMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdyb3RlOg0K
Pj4+Pj4+Pj4+PiBPbiAxMi4wOS4xOSAxNzoxMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSB3cm90ZToNCj4+Pj4+Pj4+Pj4+IFByaW9yIDlhZGMxY2I0OWFmOGQgZG9fc3luY190YXJnZXRf
d3JpdGUgaGFkIGEgYnVnOiBpdCByZXNldCBhbGlnbmVkLXVwDQo+Pj4+Pj4+Pj4+PiByZWdpb24g
aW4gdGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkgbm90IGNvcHkgc29t
ZSBieXRlcw0KPj4+Pj4+Pj4+Pj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFs
bHkgbGVhZHMgdG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4+Pj4+Pj4+Pj4gdGFyZ2V0Lg0KPj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IFNvIDlhZGMxY2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1h
cCBncmFudWxhcml0eSB0byBiZQ0KPj4+Pj4+Pj4+Pj4gcmVxdWVzdF9hbGlnbm1lbnQgZm9yIG1p
cnJvci10b3AgZmlsdGVyLCBzbyB3ZSBhcmUgbm90IHdvcmtpbmcgd2l0aA0KPj4+Pj4+Pj4+Pj4g
dW5hbGlnbmVkIHJlcXVlc3RzLiBIb3dldmVyIGZvcmNpbmcgbGFyZ2UgYWxpZ25tZW50IG9idmlv
dXNseSBkZWNyZWFzZXMNCj4+Pj4+Pj4+Pj4+IHBlcmZvcm1hbmNlIG9mIHVuYWxpZ25lZCByZXF1
ZXN0cy4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBUaGlzIGNvbW1pdCBwcm92aWRlcyBhbm90
aGVyIHNvbHV0aW9uIGZvciB0aGUgcHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+Pj4+Pj4+Pj4+PiBw
YWRkaW5nIGlzIGFscmVhZHkgZGlydHksIHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4+
Pj4+Pj4+Pj4gMS4gSXQncyBkaXJ0eSwgaXQgd2lsbCBiZSBjb3BpZWQgYnkgbWlycm9yX2l0ZXJh
dGlvbiBhbnl3YXkNCj4+Pj4+Pj4+Pj4+IDIuIEl0J3MgZGlydHksIHNvIHNraXBwaW5nIGl0IG5v
dyB3ZSBkb24ndCBpbmNyZWFzZSBkaXJ0aW5lc3Mgb2YgdGhlDQo+Pj4+Pj4+Pj4+PiAgICAgwqDC
oMKgIGJpdG1hcCBhbmQgdGhlcmVmb3JlIGRvbid0IGRhbWFnZSAic3luY2hyb25pY2l0eSIgb2Yg
dGhlDQo+Pj4+Pj4+Pj4+PiAgICAgwqDCoMKgIHdyaXRlLWJsb2NraW5nIG1pcnJvci4NCj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4gQnV0IHRoYXTigJlzIG5vdCB3aGF0IGFjdGl2ZSBtaXJyb3IgaXMg
Zm9yLsKgIFRoZSBwb2ludCBvZiBhY3RpdmUgbWlycm9yIGlzDQo+Pj4+Pj4+Pj4+IHRoYXQgaXQg
bXVzdCBjb252ZXJnZSBiZWNhdXNlIGV2ZXJ5IGd1ZXN0IHdyaXRlIHdpbGwgY29udHJpYnV0ZSB0
b3dhcmRzDQo+Pj4+Pj4+Pj4+IHRoYXQgZ29hbC4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gSWYg
eW91IHNraXAgYWN0aXZlIG1pcnJvcmluZyBmb3IgdW5hbGlnbmVkIGd1ZXN0IHdyaXRlcywgdGhl
eSB3aWxsIG5vdA0KPj4+Pj4+Pj4+PiBjb250cmlidXRlIHRvd2FyZHMgY29udmVyZ2luZywgYnV0
IGluIGZhY3QgbGVhZCB0byB0aGUgb3Bwb3NpdGUuDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiBUaGUgd2lsbCBub3QgY29udHJpYnV0ZSBvbmx5IGlmIHJlZ2lvbiBpcyBhbHJlYWR5
IGRpcnR5LiBBY3R1YWxseSwgYWZ0ZXINCj4+Pj4+Pj4+PiBmaXJzdCBpdGVyYXRpb24gb2YgbWly
cm9yaW5nIChjb3B5aW5nIHRoZSB3aG9sZSBkaXNrKSwgYWxsIGZvbGxvd2luZyB3cml0ZXMNCj4+
Pj4+Pj4+PiB3aWxsIGNvbnRyaWJ1dGUsIHNvIHRoZSB3aG9sZSBwcm9jZXNzIG11c3QgY29udmVy
Z2UuIEl0IGlzIGEgYml0IHNpbWlsYXIgd2l0aA0KPj4+Pj4+Pj4+IHJ1bm5pbmcgb25lIG1pcnJv
ciBsb29wIGluIG5vcm1hbCBtb2RlLCBhbmQgdGhlbiBlbmFibGUgd3JpdGUtYmxvY2tpbmcuDQo+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSW4gb3RoZXIgd29yZHMsIHdl
IGRvbid0IG5lZWQgImFsbCBndWVzdCB3cml0ZXMgY29udHJpYnV0ZSIgdG8gY29udmVyZ2UsDQo+
Pj4+Pj4+PiAiYWxsIGd1ZXN0IHdyaXRlcyBkb24ndCBjcmVhdGUgbmV3IGRpcnR5IGJpdHMiIGlz
IGVub3VnaCwgYXMgd2UgaGF2ZSBwYXJhbGxlbA0KPj4+Pj4+Pj4gbWlycm9yIGl0ZXJhdGlvbiB3
aGljaCBjb250aWd1b3VzbHkgaGFuZGxlcyBkaXJ0eSBiaXRzLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBI
bSwgaW4gYSBzZW5zZS4gIEJ1dCBpdCBkb2VzIG1lYW4gdGhhdCBndWVzdCB3cml0ZXMgd2lsbCBu
b3QgY29udHJpYnV0ZQ0KPj4+Pj4+PiB0byBjb252ZXJnZW5jZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
QW5kIHRoYXTigJlzIGFnYWluc3QgdGhlIGN1cnJlbnQgZGVmaW5pdGlvbiBvZiB3cml0ZS1ibG9j
a2luZywgd2hpY2ggZG9lcw0KPj4+Pj4+PiBzdGF0ZSB0aGF0IOKAnHdoZW4gZGF0YSBpcyB3cml0
dGVuIHRvIHRoZSBzb3VyY2UsIHdyaXRlIGl0IChzeW5jaHJvbm91c2x5KQ0KPj4+Pj4+PiB0byB0
aGUgdGFyZ2V0IGFzIHdlbGzigJ0uDQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBIbW0sIHVuZGVy
c3RhbmQuIEJ1dCBJTUhPIG91ciBwcm9wb3NlZCBiZWhhdmlvciBpcyBiZXR0ZXIgaW4gZ2VuZXJh
bC4NCj4+Pj4+PiBEbyB5b3UgdGhpbmsgaXQncyBhIHByb2JsZW0gdG8gY2hhbmdlIHNwZWMgbm93
Pw0KPj4+Pj4+IElmIHllcywgSSdsbCByZXNlbmQgd2l0aCBhbiBvcHRpb24NCj4+Pj4+DQo+Pj4+
PiBXZWxsLCB0aGUgdGhpbmcgaXMgdGhhdCBJ4oCZZCBmaW5kIGl0IHdlaXJkIGlmIHdyaXRlLWJs
b2NraW5nIHdhc27igJl0DQo+Pj4+PiBibG9ja2luZyBpbiBhbGwgY2FzZXMuICBBbmQgaW4gbXkg
b3BpbmlvbiwgaXQgbWFrZXMgbW9yZSBzZW5zZSBmb3INCj4+Pj4+IGFjdGl2ZSBtaXJyb3IgaWYg
YWxsIHdyaXRlcyBhY3RpdmVseSBjb250cmlidXRlZCB0byBjb252ZXJnZW5jZS4NCj4+Pj4+DQo+
Pj4+DQo+Pj4+IFdoeT8gV2hhdCBpcyB0aGUgYmVuZWZpdCBpbiBpdD8NCj4+Pj4gV2hhdCBpcyAi
YWxsIHdyaXRlcyBhY3RpdmVseSBjb250cmlidXRlZCB0byBjb252ZXJnZW5jZSIgZm9yIHVzZXI/
DQo+Pj4NCj4+PiBPbmUgdGhpbmcgSSB3b25kZXIgYWJvdXQgaXMgd2hldGhlciBpdOKAmXMgcmVh
bGx5IGd1YXJhbnRlZWQgdGhhdCB0aGUNCj4+PiBiYWNrZ3JvdW5kIGpvYiB3aWxsIHJ1biB1bmRl
ciBmdWxsIEkvTyBsb2FkLCBhbmQgaG93IG9mdGVuIGl0IHJ1bnMuDQo+Pj4NCj4+PiBJIGZlYXIg
dGhhdCB3aXRoIHlvdXIgbW9kZWwsIHRoZSBiYWNrZ3JvdW5kIGpvYiBtaWdodCBzdGFydmUgYW5k
IHRoZQ0KPj4+IG1pcnJvciBtYXkgdGFrZSBhIHZlcnkgbG9uZyB0aW1lLg0KPj4NCj4+IEhtbW0u
IEkgdGhpbmsgbWlycm9yIGpvYiBpcyBpbiBzYW1lIGNvbnRleHQgYXMgZ3Vlc3Qgd3JpdGVzLCBh
bmQgZ29lcw0KPj4gdGhyb3VnaCBzYW1lIElPIGFwaS4uIFdoeSBpdCB3aWxsIHN0YXJ2ZT8gKEkg
dW5kZXJzdGFuZCB0aGF0IG15IHdvcmRzDQo+PiBhcmUgbm90IGFuIGV2aWRlbmNlLi4uKS4NCj4g
DQo+IEkgdGhvdWdodCB0aGF0IG1heWJlIGlmIHRoZSBkaXNrIGlzIHJlYWQgdG8gd3JpdGUgYW5k
IHdyaXRlIGFsbCB0aGUNCj4gdGltZSwgdGhlcmXigJlkIGJlIG5vIHRpbWUgZm9yIHRoZSBtaXJy
b3IgY29yb3V0aW5lLg0KPiANCj4+PiAgIEl0IHdvbuKAmXQgZGl2ZXJnZSwgYnV0IGl0IGFsc28g
d29u4oCZdA0KPj4+IHJlYWxseSBjb252ZXJnZS4NCj4+DQo+PiBCdXQgc2FtZSB3aWxsIGJlIHdp
dGggY3VycmVudCBiZWhhdmlvcjogZ3Vlc3QgaXMgbm90IGd1YXJhbnRlZWQgdG8gd3JpdGUNCj4+
IHRvIGFsbCBwYXJ0cyBvZiBkaXNrLiBBbmQgaW4gbW9zdCBzY2VuYXJpb3MgaXQgZG9lc24ndC4g
U28sIGlmIG1pcnJvciBqb2INCj4+IHN0YXJ2ZSBiZWNhdXNlIG9mIGh1Z2UgZ3Vlc3QgSU8gbG9h
ZCwgd2Ugd2lsbCBub3QgY29udmVyZ2UgYW55d2F5Lg0KPj4NCj4+IFNvLCBiYWNrZ3JvdW5kIHBy
b2Nlc3MgaXMgbmVjZXNzYXJ5IHRoaW5nIGZvciBjb252ZXJnZSBhbnl3YXkuDQo+IA0KPiBHb29k
IHBvaW50LiAgVGhhdCBjb252aW5jZXMgbWUuDQo+IA0KPj4+IFRoZSBhZHZhbnRhZ2Ugb2YgbGV0
dGluZyBhbGwgd3JpdGVzIGJsb2NrIGlzIHRoYXQgZXZlbiB1bmRlciBmdWxsIEkvTw0KPj4+IGxv
YWQsIHRoZSBtaXJyb3Igam9iIHdpbGwgcHJvZ3Jlc3MgYXQgYSBzdGVhZHkgcGFjZS4NCj4+Pg0K
Pj4+PiBJIHRoaW5rIGZvciB1c2VyIHRoZXJlIG1heSBiZSB0aGUgZm9sbG93aW5nIGNyaXRlcmlh
Og0KPj4+Pg0KPj4+PiAxLiBndWFyYW50ZWVkIGNvbnZlcmdlLCB3aXRoIGFueSBndWVzdCB3cml0
ZSBsb2FkLg0KPj4+PiBCb3RoIGN1cnJlbnQgYW5kIG15IHByb3Bvc2VkIHZhcmlhbnRzIGFyZSBP
Sy4NCj4+Pj4NCj4+Pj4gMi4gTGVzcyBpbXBhY3Qgb24gZ3Vlc3QuDQo+Pj4+IE9idmlvdXNseSBt
eSBwcm9wb3NlZCB2YXJpYW50IGlzIGJldHRlcg0KPj4+Pg0KPj4+PiAzLiBUb3RhbCB0aW1lIG9m
IG1pcnJvcmluZw0KPj4+PiBTZWVtcywgY3VycmVudCBtYXkgYmUgYSBiaXQgYmV0dGVyLCBidXQg
SSBkb24ndCB0aGluayB0aGF0IHVuYWxpZ25lZA0KPj4+PiB0YWlscyBnaXZlcyBzaWduaWZpY2Fu
dCBpbXBhY3QuDQo+Pj4+DQo+Pj4+ID09PQ0KPj4+Pg0KPj4+PiBTbywgYXNzdW1lIEkgd2FudCBb
MV0rWzJdLiBBbmQgcG9zc2libHkNCj4+Pj4gMi4yOiBFdmVuIGxlc3MgaW1wYWN0IG9uIGd1ZXN0
OiBpZ25vcmUgbm90IG9ubHkgdW5hbGlnbmVkIHRhaWxzIGlmIHRoZXkgYXJlDQo+Pj4+IGFscmVh
ZHkgZGlydHksIGJ1dCBmdWxsIHN5bmNocm9ub3VzIG1pcnJvciBvcGVyYXRpb24gaWYgYXJlYSBp
cyBhbHJlYWR5IGRpcnR5Lg0KPj4+Pg0KPj4+PiBIb3cgc2hvdWxkIEkgY2FsbCB0aGlzPyBTaG91
bGQgaXQgYmUgc2VwYXJhdGUgbW9kZSwgb3Igb3B0aW9uIGZvciB3cml0ZS1ibG9ja2luZz8NCj4+
Pg0KPj4+IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgaXQgbWFrZXMgc2Vuc2UgdG8gYWRkIGEgc2Vw
YXJhdGUgbW9kZSBvciBhIHNlcGFyYXRlDQo+Pj4gb3B0aW9uIGp1c3QgZm9yIHRoaXMgZGlmZmVy
ZW5jZS4gIEkgZG9u4oCZdCB0aGluayBhbnlvbmUgd291bGQgY2hvb3NlIHRoZQ0KPj4+IG5vbi1k
ZWZhdWx0IG9wdGlvbi4NCj4+DQo+PiBBdCBsZWFzdCBWaXJ0dW96em8gd2lsbCBjaG9vc2UgOikN
Cj4gDQo+IEJ1dCBpZiBWaXJ0dW96em8ga25vd3MgZXhhY3RseSB3aGF0IHRvIGNob29zZSwgdGhl
biB3ZSBjYW4ganVzdA0KPiBpbXBsZW1lbnQgb25seSB0aGF0IGJlaGF2aW9yLg0KPiANCg0KVGhl
biwgd2VsY29tZSB0byB0aGVzZSBzZXJpZXMpDQoNClN0aWxsIFsyLjJdIGlzIGFyZ3VhYmxlOiBp
ZiB3ZSBza2lwIHNvbWUgZGlydHkgYXJlYXMgb24gc3luY2hyb25vdXMgY29weSwgZ3Vlc3QNCndp
bGwgYmUgYSBiaXQgaGFwcGllciwgYnV0IHdlIG1pc3MgYSBjaGFuY2UgdG8gc2tpcCByZWFkIHBh
cnQgb2YgY29weWluZyBmb3IgdGhlDQptaXJyb3IgcGFydC4gQnV0IHRoaXMgbWF5IGJlIHBvc3Rw
b25lZC4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

