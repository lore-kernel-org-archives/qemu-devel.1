Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE2C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B9320679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WiVdZFe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUlO-0007w6-1V
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxUku-0007Si-KP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxUkt-0002hy-1v
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:14:20 -0400
Received: from mail-eopbgr40110.outbound.protection.outlook.com
 ([40.107.4.110]:28979 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxUks-0002h7-H4; Tue, 13 Aug 2019 07:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1D2BuVEAH6JRCuKA5Yt8ZZthvbqDdg2+Fb8idxYmXdMDj9zIYslpT/6qVK1c/+aMG9uDmQ6+csKDJnNbK0AOQtIOJWWcs5MFsZO8oP7DMZO+bYYD60zgNxjYjNLt0/pC8yf02AhfWTjrk4o08Scx5vZMiBAm1lrUl108Ga/YnWpSzZj0NB1wKztzDczQTvPW+yllwGjzus8By9TR4rNyxQ3xjjpHJIFjEUxifb//A4T2J34tkI/zqJEBfHgMg26dLkGr/lY0VTWsWVjHkZ/3Hg0c9hsUtFU3qIaT58+Q/XJtpsObuJxAK+nWky6bXEKd35uPxXfO9M9GI9dwhDFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjE1GIQtVto2fLZPY/L1BNY2tN8emZ1tmcP1vp0vwGs=;
 b=JdEnC2iFpEp8bsr1XUmiTtHBLz9IdQjUlhhZy3r4dlb0k5UZXyqpmUKD04ZOFS+CygArw7mJrtZhbDkHC3Yhakww22N8vsMpeWooXBN0hzLuBYsteZ9n8+k/0j3HbX7wEJ+W8wlEpxiHC6upe8l2lYczCn8eoZOKnHdwAmIm0yv35xIYusPF4PFae5AaCWtxzSqm4mcq/gHQUYxTBtCBH9iHSBhkecFFo+IPofJSmoIDKvW6niQDPVW173igDCuWpyUgPJyPwk5IuebrMjQA1a8qYYbBYSM0GRvtn7zgi387W144sUhjKeTbPvFBO6WM21RAswiZZhJUCCk2RvSJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjE1GIQtVto2fLZPY/L1BNY2tN8emZ1tmcP1vp0vwGs=;
 b=WiVdZFe5lACeVrF2QxWfxEVMgItcrHxeDfiJR740fqYOnWJsGEMJElhTwVqDmLr9bEUef6TNdmZDb4zjRYJkcogtsQybjQCnn2n7ixJ/8b/BpVIajddS5sK7+zr85t3C6S/Zd/DGk2cFUSGCP+aYbSMUSS34LB0eBXdOf20ATII=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5291.eurprd08.prod.outlook.com (20.179.11.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Tue, 13 Aug 2019 11:14:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 11:14:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gIAABheAgAAIyICAABw7gA==
Date: Tue, 13 Aug 2019 11:14:13 +0000
Message-ID: <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
In-Reply-To: <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:7:28::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813141411503
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5541ad80-deca-48b4-cd46-08d71fdf5f8b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5291; 
x-ms-traffictypediagnostic: DB8PR08MB5291:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB529191B74B45EEE018DD4798C1D20@DB8PR08MB5291.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39840400004)(199004)(52314003)(53754006)(189003)(66476007)(31696002)(81156014)(53936002)(478600001)(81166006)(6486002)(5660300002)(71200400001)(71190400001)(110136005)(316002)(66446008)(6306002)(66946007)(229853002)(66556008)(54906003)(86362001)(6246003)(64756008)(8936002)(6436002)(99286004)(2906002)(6512007)(36756003)(256004)(26005)(4326008)(966005)(102836004)(476003)(305945005)(14454004)(107886003)(53546011)(7736002)(14444005)(8676002)(6506007)(25786009)(3846002)(2501003)(6116002)(52116002)(76176011)(486006)(66066001)(186003)(2616005)(31686004)(11346002)(386003)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5291;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m19iUF8cM/+2LJgxeaMox7hFnYlGCu8z0Bw8q4GBSMmEZm4/sEtkg4OD0sgqKuZZIy59wKEe+nslv3r9P3FLjumMJVICwO1UGs41mQL2/P81Czzly94WvAd0/vWys8dPKzHOzs8bzqIZzK/Y+sGKXd42Gz1AUfO5BRD/1vC+ouMHnovG39uZCS561Y8I5rgJa+KhbVHJJ/KNDOKGLYF1ZAdH6XoFyEI8KpUWnI66jtjW+Rn4GlQaOfo2BR1Q6QTLSiSe3yuP870+sUuQPTqn7+AHrocigmDL4zkZa+1k02QoOdsTYffw+KVy6gIgspu64XszfqbAcDy58WfmdvVyIiGJiRtlILWLNOIyEZdnj9P2QZxwG9PYDZtQQy0jn0uloHbuMwENYgUwX72VXuchun21Nvnmb4M7rs2FmL1GbSA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8763FC73709E78438CCBBE06E50280DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5541ad80-deca-48b4-cd46-08d71fdf5f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:14:13.9501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Pz65h8Db96rP3TTgUwA4HGgCBD5bDTJIMWsLhlaOUzqsRgBtP5pYXpE6QG3I3PcthuF60VR0/Eit0UTWKOjiWGOrX78Z8CorwNHdKT0SR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5291
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.110
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxMjozMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTMuMDguMjAxOSAxMjowMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDEzLjA4LjIwMTkgMTE6MzksIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+
Pj4gMTIuMDguMjAxOSAyMjo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMi4wOC4xOSAy
MTo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24gMTIuMDguMTkgMjA6MTEsIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gSGkgYWxsIQ0KPj4+Pj4+DQo+Pj4+
Pj4gSSdtIG5vdCBzdXJlLCBpcyBpdCBhIGJ1ZyBvciBhIGZlYXR1cmUsIGJ1dCB1c2luZyBxY293
MiB1bmRlciByYXcgaXMNCj4+Pj4+PiBicm9rZW4uIEl0IHNob3VsZCBiZSBlaXRoZXIgZml4ZWQg
bGlrZSBJIHByb3Bvc2UgKGJ5IE1heCdzIHN1Z2dlc3Rpb24pDQo+Pj4+Pj4gb3Igc29tZWhvdyBm
b3JiaWRkZW4gKGp1c3QgZm9yYmlkIGJhY2tpbmctZmlsZSBzdXBwb3J0aW5nIG5vZGUgdG8gYmUN
Cj4+Pj4+PiBmaWxlIGNoaWxkIG9mIHJhdy1mb3JtYXQgbm9kZSkuDQo+Pj4+Pg0KPj4+Pj4gSSBh
Z3JlZSwgSSB0aGluayBvbmx5IGZpbHRlcnMgc2hvdWxkIHJldHVybiBCRFJWX0JMT0NLX1JBVy4N
Cj4+Pj4+DQo+Pj4+PiAoQW5kIG5vdCBldmVuIHRoZW0sIHRoZXkgc2hvdWxkIGp1c3QgYmUgaGFu
ZGxlZCB0cmFuc3BhcmVudGx5IGJ5DQo+Pj4+PiBiZHJ2X2NvX2Jsb2NrX3N0YXR1cygpLsKgIEJ1
dCB0aGF04oCZcyBzb21ldGhpbmcgZm9yIGxhdGVyLikNCj4+Pj4+DQo+Pj4+Pj4gVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+Pj4+Pj4gwqDCoCBibG9jay9yYXctZm9ybWF0OiBz
d2l0Y2ggdG8gQkRSVl9CTE9DS19EQVRBIHdpdGggQkRSVl9CTE9DS19SRUNVUlNFDQo+Pj4+Pj4g
wqDCoCBpb3Rlc3RzOiB0ZXN0IG1pcnJvcmluZyBxY293MiB1bmRlciByYXcgZm9ybWF0DQo+Pj4+
Pj4NCj4+Pj4+PiDCoCBibG9jay9yYXctZm9ybWF0LmPCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICst
DQo+Pj4+Pj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2M8KgwqDCoMKgIHwgNDYgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVz
dHMvMjYzLm91dCB8IDEyICsrKysrKysrKysNCj4+Pj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMv
Z3JvdXDCoMKgIHzCoCAxICsNCj4+Pj4+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMv
cWVtdS1pb3Rlc3RzLzI2Mw0KPj4+Pj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11
LWlvdGVzdHMvMjYzLm91dA0KPj4+Pj4NCj4+Pj4+IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9j
ay1uZXh0IGJyYW5jaDoNCj4+Pj4+DQo+Pj4+PiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5D
bGljL3FlbXUvY29tbWl0cy9icmFuY2gvYmxvY2stbmV4dA0KPj4+Pg0KPj4+PiBPb3BzLCBtYXli
ZSBub3QuwqAgMjIxIG5lZWRzIHRvIGJlIGFkanVzdGVkLg0KPj4+Pg0KPj4+DQo+Pj4NCj4+PiBI
bW0geWVzLCBJIGZvcmdldCB0byBydW4gdGVzdHMuLiBBcmVhcyB3aGljaCB3ZXJlIHplcm8gYmVj
b21lcyBkYXRhfHplcm8sIGl0DQo+Pj4gZG9uJ3QgbG9vayBnb29kLg0KPj4+DQo+Pj4gU28sIGl0
J3Mgbm90IHF1aXRlIHJpZ2h0IHRvIHJlcG9ydCBEQVRBIHwgUkVDVVJTRSwgd2UgYWN0dWFsbHkg
c2hvdWxkIHJlcG9ydA0KPj4+IERBVEFfT1JfWkVSTyB8IFJFQ1VSU0UsIHdoaWNoIGlzIGFjdHVh
bGx5IEFMTE9DQVRFRCB8IFJFQ1VSU0UsIGFzIG90aGVyd2lzZQ0KPj4+IERBVEEgd2lsbCBiZSBz
ZXQgaW4gZmluYWwgcmVzdWx0IChnZW5lcmljIGxheWVyIG11c3Qgbm90IGRyb3AgaXQsIG9idmlv
dXNseSkuDQo+Pj4NCj4+PiBBTExPQ0FURUQgbmV2ZXIgcmV0dXJuZWQgYnkgZHJpdmVycyBidXQg
c2VlbXMgaXQgc2hvdWxkIGJlLiBJJ2xsIHRoaW5rIGEgYml0IGFuZA0KPj4+IHJlc2VuZCBzb21l
dGhpbmcgbmV3Lg0KPj4+DQo+Pj4NCj4+DQo+Pg0KPj4gSG1tbS4uIFNvLCB3ZSBoYXZlIHJhdyBu
b2RlLCBhbmQgYXNzdW1lIGJhY2tpbmcgY2hhaW4gdW5kZXIgaXQuIHdobyBzaG91bGQgbG9vcCB0
aHJvdWdoIGl0LA0KPj4gZ2VuZXJpYyBjb2RlIG9yIHJhdyBkcml2ZXI/DQo+Pg0KPj4gTm93IGl0
IGFsbCBsb29rcyBsaWtlIGdlbmVyaWMgY29kZSBpcyByZXNwb25zaWJsZSBmb3IgbG9vcGluZyB0
aHJvdWdoIGZpbHRlcmVkIGNoYWluIChiYWNraW5nIGZpbGVzDQo+PiBhbmQgZmlsdGVycykgYW5k
IGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3IgYWxsIGl0J3MgY2hpbGRyZW4gZXhjZXB0IGZvciBm
aWx0ZXJlZCBjaGlsZC4NCj4+DQo+PiBPciwgZHJpdmVyIG1heSByZXR1cm4gc29tZXRoaW5nIHRo
YXQgc2F5cyB0byBnZW5lcmljIGNoaWxkIHRvIGhhbmRsZSB0aGUgd2hvbGUgYmFja2luZyBjaGFp
biBvZiByZXR1cm5lZA0KPj4gZmlsZSBhdCBvbmNlLCBhcyBpdCdzIGFub3RoZXIgYmFja2luZyBj
aGFpbi4gQW5kIHNlZW1zIGV2ZW4gUkVDVVJTRSBkb24ndCB3b3JrIGNvcnJlY3RseSBhcyBpdCBk
b2Vzbid0IGhhbmRsZQ0KPj4gdGhlIGJhY2tpbmcgY2hhaW4gaW4gdGhpcyByZWN1cnNpb24uIFdo
eSBpdCB3b3JrcyBiZXR0ZXIgdGhhbiBSQVcgLSBqdXN0IGJlY2F1c2Ugd2UgcmV0dXJuIGl0IHRv
Z2V0aGVyDQo+PiB3aXRoIERBVEEgZmxhZ3MgYW5kIHRoaXMgREFUQSBmbGFnIGlzIGtlcHQgYW55
d2F5LCBpbmRlcGVuZGVudGx5IG9mIGZpbmRpbmcgemVyb3Mgb3Igbm90Lg0KPj4NCj4+DQo+IA0K
PiANCj4gSG1tLCBzbywgaXMgaXQgY29ycmVjdCB0aGF0IHdlIHJldHVybiBEQVRBIHwgUkVDVVJT
RSwgaWYgd2UgYXJlIG5vdCByZWFsbHkgc3VyZSB0aGF0IGl0IGlzIGRhdGE/DQo+IA0KPiBJZiB3
ZSBzZWUgYXQNCj4gDQo+ICDCoCogQkRSVl9CTE9DS19EQVRBOiBhbGxvY2F0aW9uIGZvciBkYXRh
IGF0IG9mZnNldCBpcyB0aWVkIHRvIHRoaXMgbGF5ZXINCj4gDQo+IHNlZW1zIGxpa2Ugd2Ugc2hv
dWxkIHJlcG9ydCBEQVRBIG9ubHkgaWYgdGhlcmUgaXMgYWxsb2NhdGlvbi4uDQo+IA0KPiAgwqAq
IERBVEEgWkVSTyBPRkZTRVRfVkFMSUQNCj4gIMKgKsKgIHTCoMKgwqAgdMKgwqDCoMKgwqDCoMKg
IHTCoMKgwqDCoMKgwqAgc2VjdG9ycyByZWFkIGFzIHplcm8sIHJldHVybmVkIGZpbGUgaXMgemVy
byBhdCBvZmZzZXQNCj4gIMKgKsKgIHTCoMKgwqAgZsKgwqDCoMKgwqDCoMKgIHTCoMKgwqDCoMKg
wqAgc2VjdG9ycyByZWFkIGFzIHZhbGlkIGZyb20gZmlsZSBhdCBvZmZzZXQNCj4gIMKgKsKgIGbC
oMKgwqAgdMKgwqDCoMKgwqDCoMKgIHTCoMKgwqDCoMKgwqAgc2VjdG9ycyBwcmVhbGxvY2F0ZWQs
IHJlYWQgYXMgemVybywgcmV0dXJuZWQgZmlsZSBub3QNCj4gDQo+IHNvLCBaRVJPIGFsb25lIGRv
ZXNuJ3QgZ3VhcmFudGVlIHRoYXQgd2UgbWF5IHNhZmVseSByZWFkPw0KPiANCj4gU28sIGZvciBx
Y293MiBtZXRhZGF0YS1wcmVhbGxvY2F0ZWQgaW1hZ2VzLCB3aGF0IGFib3V0IHplcm8taW5pdD8g
V2UgcmVwb3J0IERBVEEsIGFuZCBwcm9iYWJseSBnZXQgWkVSTyBmcm9tDQo+IGZpbGUgYW5kIGhh
dmUgZmluYWxseSBEQVlBIHwgWkVSTyB3aGljaCBndWFyYW50ZWVzIHRoYXQgcmVhZCB3aWxsIHJl
dHVybiB6ZXJvcywgYnV0IGlzIGl0IHRydWU/DQo+IA0KPiBGaW5hbGx5LCB3aGF0ICJEQVRBIiBt
ZWFuPyBUaGF0IHNwYWNlIGlzIGFsbG9jYXRlZCBhbmQgb2NjdXBpZXMgZGlzayBzcGFjZT8gT3Ig
aXQgb25secKgIG1lYW5zIG9ubHkgQUxMT0NBVEVEIGkuZS4NCj4gInJlYWQgZnJvbSB0aGlzIGxh
eWVyLCBub3QgZnJvbSBiYWNraW5nIiBvdGhlcndpc2UsIGFuZCBhZGRzIGFkZGl0aW9uYWwgbWVh
bmluZyB0byBaRVJPIHdoZW4gdXNlZCB0b2dldGhlciwgdGhhdA0KPiByZWFkIHdpbGwgcmV0dXJu
IHplcm9zIGZvciBzdXJlPw0KPiANCg0KDQpDb250aW51ZSBzZWxmLWRpc2N1c3Npb24uDQoNCkNv
bnNpZGVyIGNsb3NlciB0aGUgZm9sbG93aW5nIGNhc2U6DQogPiAgICogREFUQSBaRVJPIE9GRlNF
VF9WQUxJRA0KID4gICAqICBmICAgIHQgICAgICAgIHQgICAgICAgc2VjdG9ycyBwcmVhbGxvY2F0
ZWQsIHJlYWQgYXMgemVybywgcmV0dXJuZWQgZmlsZSBub3QNCg0KSXQgYWN0dWFsbHkgbWVhbnMg
dGhhdCB3ZSBtdXN0IG5vdCByZWFkLCBhcyByZWFkIHdpbGwgcmV0dXJuIHdyb25nIGRhdGEsIHdo
ZW4gY2x1c3RlcnMgYXJlIGFjdHVhbGx5IHplcm8gZm9yIGd1ZXN0Lg0KDQpJdCdzIE9LLCB3aGVu
IGZvciBleC4gcWNvdzIgcmV0dXJucyB0aGlzIGNvbWJpbmF0aW9uIGFuZCBsaW5rIHRvIGl0cyBm
aWxlIGNoaWxkOiBpdCBtZWFucyB0aGF0IGlmIHlvdSByZWFkIGZyb20gcWNvdzINCm5vZGUsIHlv
dSdsbCBzZWUgY29ycmVjdCB6ZXJvcywgYXMgcWNvdzIgaGFzIHNwZWNpYWwgbWV0YWRhdGEgd2hp
Y2ggc2hvd3MgdGhhdCB0aGVzZSBjbHVzdGVycyBhcmUgemVyby4gQnV0IGlmIHlvdSByZWFkDQpm
cm9tIGZpbGUgZGlyZWN0bHkgYXQgcmV0dXJuZWQgb2Zmc2V0IHlvdSdsbCBzZWUgZ2FyYmFnZSwg
c28gZG9uJ3QgZG8gaXQuDQoNCkJ1dCB3aGF0IGlmIHNvbWUgbm9kZSByZXR1cm5zIHRoaXMgY29t
YmluYXRpb24gd2l0aCBmaWxlID09IGl0c2VsZj8gSXQgYWN0dWFsbHkgbWVhbnMgdGhhdCB5b3Ug
bXVzdCBub3QgcmVhZCwgYnV0IHlvdQ0Kc2hvdWxkIGNhbGwgYmxvY2stc3RhdHVzIHRvIHVuZGVy
c3RhbmQgdGhhdCB0aGVyZSBhcmUgemVyb3MuIFNvLCBpZiBzb21lIGZvcm1hdCBjYW4gcmV0dXJu
IHRoaXMgY29tYmluYXRpb24gd2l0aA0KZmlsZSA9PSBpdHNlbGYgaXQgbWVhbnMgdGhhdCB5b3Ug
bXVzdCBub3QgcmVhZCBpdCBkaXJlY3RseSwgYnV0IG9ubHkgYWZ0ZXIgY2hlY2tpbmcgYmxvY2sg
c3RhdHVzLg0KDQpBbmQgZmlsZS1wb3NpeCBpcyBleGFtcGxlIG9mIHN1Y2ggZHJpdmVyLiBCdXQg
ZmlsZS1wb3NpeCBob2xlcyBhcmUgZ3VhcmFudGVlZCB0byByZWFkIGFzIHplcm8sIHNvIHdlIGNh
biByZXBvcnQgREFUQSB8IFpFUk8uDQpCdXQgdGhpcyB3aWxsIGJyZWFrIHVzZXIgZXhwaXJpZW5j
ZSB3aGljaCBhc3N1bWVzIHRoYXQgREFUQSBtZWFucyBvY2N1cGF0aW9uIG9mIHJlYWwgZGlzayBz
cGFjZS4NCg0KLi4uDQptZSBnbyBhbmQgcmUtcmVhZCB3aGF0IHdlJ3ZlIGRvY3VtZW50ZWQgaW4g
TkJEIHByb3RvY29sIGFib3V0IGJsb2NrIHN0ZXVzLi4uDQoNCiJEQVRBIiB0dXJucyBpbnRvIE5C
RF9TVEFURV9IT0xFLCB3aGljaCBmb3JtYWxseSBtZWFucyBub3RoaW5nLCBhbmQganVzdCBub3Rl
cyB0aGF0IHByb2JhYmx5IHRoZXJlIGlzIG5vIGRpc2sgc3BhY2Ugb2NjdXBhdGlvbg0KZm9yIHRo
aXMgcmVnaW9uLi4gU28gaXQncyBhYm91dCBkaXNrIHNwYWNlIGFsbG9jYXRpb24gYW5kIG5vdGhp
bmcgYWJvdXQgY29ycmVjdG5lc3Mgb2YgcmVhZC4NCmFuZCBOQkRfU1RBVEVfWkVSTyBndWFyYW50
ZWVzIHRoYXQgcmVnaW9uIHJlYWQgYXMgYWxsIHplcm9lcy4NCg0KTG9vayBhdCBjb2RlIGluIG5i
ZC9zZXJ2ZXIuYy4uIEFoYSwgaXQgY2FsbHMgYmxvY2tfc3RhdHVzX2Fib3ZlIGFuZCB0dXJucyAh
QUxMT0NBVEVEIGludG8gSE9MRS4gV2hpY2ggbWVhbnMgdGhhdCBpdCB3aWxsIG5ldmVyDQpyZXR1
cm4gSE9MRSBmb3IgZmlsZS1wb3NpeC4uDQoNCg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

