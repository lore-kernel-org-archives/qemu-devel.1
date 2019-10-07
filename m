Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD09C352AA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035072084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UHfQt7pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035072084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQaC-0002HR-5L
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHQZR-0001k5-Hc
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHQZO-0008FD-Bx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:48:52 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com
 ([40.107.15.103]:54202 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHQZL-0008Br-R4; Mon, 07 Oct 2019 06:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isr83GIsnHCokNyW/9Otq+Oxlnaith4m/dmvgz02OD9dZMDZlDtL6RZdh8z5atPKj2+lryDoYz+b+HxhbD6edUXWMGOMh2LHpfUkhXEqpVKkOAqiFWfDarUo3bw784S4dso3fzY8kF4tLJkljbGV0e/Af8ooj4tAWA8mdURsHNeg1g0lE5LuMjUO9+TiJHMOLUhF83KotBMb+oMHPvsHRh3uLobJK+6BCCJ1MlPmbVDKFVoCUiAVhuHlP004PJJ00IMX//Xd42aWUIdWB5ZrUauVJ+UOeR1qUI2OV2zhb0fbrP0456sBuBTZVkPJWg/M+B8Hr+GJv89XstqcsApHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO7hmWiKaQ7xTFvQIJiWY/pKC4TQyu/+xd5WMel7CV4=;
 b=du/zgObW/lYHUQhVxOiEuNSlcBuzNT+sPJe3A2ZbCX6t0PekJmsZ/NwbA3lI0pWAc5s62g4jN7sTUn/PSRlg2rfXWnT/bLu1sQmll4E60+QlOl90F6Q2pTqbmgZ8UNqM/Zn6d3Gv9T+aHGM4yfcWvH6Ve8Kj7f8BBljnbCop0CEg9bTtblvoerXWGsh3yTfKJQo2dwoBetz1TdGXJQLJTQmJHhtiI2bb8q4gWSicNpJz7sRtqWRzJBYjqkvznRdMfD8tPnVjvfnb931WhBYoTeavUKTDlock2EvJX1BqTZdGzFntDMILIzaisZR0v+XeufRnHtPpUMUOfxsxmOaHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO7hmWiKaQ7xTFvQIJiWY/pKC4TQyu/+xd5WMel7CV4=;
 b=UHfQt7pSMlEbyZfj60kxMqzeb+m5hIIfWM+GATDO+tAoYkrtRkKg+9QrebysEwNDleukpf6ZsMykOtXRzXDMoKJRqipREhrCO91cVnaNfxyVER3x1NTmrHW1K2bwoqbLn172k2w8kg4kyF+i9ZhVnFEuh9wXK5iHHhRXDHHWq9A=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5292.eurprd08.prod.outlook.com (20.179.9.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 10:48:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 10:48:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
Thread-Topic: [PATCH v9 3/3] iotests: test nbd reconnect
Thread-Index: AQHVbXs7mHyYLS78iEaXGwF4PWg406c5ta+AgAEGfoCAECVyAIAEPPiA
Date: Mon, 7 Oct 2019 10:48:42 +0000
Message-ID: <b8f833ed-5c0f-7cba-0cd4-acb96c1afbc9@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
 <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
 <88a7e9c9-caf2-b114-93c4-7c99036c9b33@virtuozzo.com>
 <7854fa11-5c2d-4b88-16f8-2bbb2679efa2@redhat.com>
In-Reply-To: <7854fa11-5c2d-4b88-16f8-2bbb2679efa2@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007134838992
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3256ca78-4197-44d4-2703-08d74b13eb71
x-ms-traffictypediagnostic: DB8PR08MB5292:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5292DA62B269934D312978AAC19B0@DB8PR08MB5292.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(446003)(11346002)(476003)(305945005)(486006)(2616005)(5660300002)(14444005)(7736002)(6116002)(3846002)(66066001)(2906002)(36756003)(110136005)(186003)(2501003)(54906003)(256004)(316002)(31686004)(86362001)(25786009)(52116002)(31696002)(71200400001)(26005)(71190400001)(478600001)(229853002)(102836004)(6506007)(53546011)(6436002)(386003)(99286004)(6486002)(14454004)(6306002)(6512007)(107886003)(8936002)(81156014)(4326008)(81166006)(76176011)(66446008)(64756008)(66556008)(66476007)(66946007)(966005)(8676002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5292;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vEZYZVdrhsREVof8puyRMfaqXHce/7iVCFPn6XfDvZYLB1piSJhg0skmxcq7BNs5Hd/dTT6z8VUYpxlPDeed8dihb4qPBa2ddJCczWvgWphFwge4X+qfvhmV4fZ2P5MD06+2VhqjU+xk3m57F1dE43WxLlv0VWYMI3yi4q7X7KEVVmRIUupzZ2nnHK7ZRZn4dg0EdJ6GKMyoAV53p1Vg4ZEok2heGI8Rcc150VvY1RYPk/6Ov5YqUUopNcNxm3hEJECFh+dTZslF+ypgyCrGPe1fr5PbGuVuVph7lD1Hf8ERRxpuLxFl6mhQBrJENnQ+h/ovqsOxDpr/mfnkX1nCXotzfxFfmO18BYTgtQt8jd7ve8mvE+06FeqQUVNdrV45QYF8qh9zFF27VKu00wXsKFpktd5FUc8sMLl64NbPkPSz5YUqfKkm3CKDao1uzfrBlxRNIX2KB81BMFI99iVbmQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AEC089E1AE9374381AF2E3B18C6FAF5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3256ca78-4197-44d4-2703-08d74b13eb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 10:48:42.4448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fBKksTinP6/7GU0tzKypeUrpqpFjh5Y+r+N0kvjOhJ+Z1mSy2OMcDWKG8G5PRxcta59uU5haZODMj59BXYKDOrk5vaJmg0H97BcTl/zdS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5292
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.103
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAyMTowNSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8yNC8xOSAzOjMxIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4gK2RlZiBxZW11
X25iZF9wb3BlbigqYXJncyk6DQo+Pj4+ICvCoMKgwqAgJycnUnVuIHFlbXUtbmJkIGluIGRhZW1v
biBtb2RlIGFuZCByZXR1cm4gdGhlIHBhcmVudCdzIGV4aXQgY29kZScnJw0KPj4+PiArwqDCoMKg
IHJldHVybiBzdWJwcm9jZXNzLlBvcGVuKHFlbXVfbmJkX2FyZ3MgKyBbJy0tcGVyc2lzdGVudCdd
ICsgbGlzdChhcmdzKSkNCj4+Pj4gKw0KPj4+DQo+Pj4gU2hvdWxkIHlvdSBhbHNvIHVzZSBhIHBp
ZCBmaWxlIGhlcmUsIGFuZCB3YWl0IGZvciB0aGUgZXhpc3RlbmNlIG9mIHRoZQ0KPj4+IHBpZCBm
aWxlIGJlZm9yZSByZXR1cm5pbmcgKHJhdGhlciB0aGFuIGhhcmQtY29kaW5nIHNsZWVwKDEpKT8N
Cj4+DQo+PiBXaGF0IGRvIHlvdSBtZWFuIC8gaG93IHRvIGRvIGl0Pw0KPj4NCj4+IFdlIHdhbnQg
dG8gd2FpdCB1bnRpbCBsaXN0ZW5pbmcgc29ja2V0IGlzIHByZXBhcmVkLi4NCj4gDQo+IEluIHNo
ZWxsOg0KPiANCj4gcWVtdS1uYmQgLS1waWQtZmlsZT0vcGF0aC90by9maWxlIC4uLg0KPiB3aGls
ZSBbICEgLWUgL3BhdGgvdG8vZmlsZSBdOyBkbw0KPiAgwqAgc2xlZXAgLi4uICMgZnJhY3Rpb25h
bCBzZWNvbmQsIG9yIGV4cG9uZW50aWFsLCBvciB3aGF0ZXZlci4uLg0KPiBkb25lDQo+ICMgTm93
IHRoZSBsaXN0ZW5pbmcgc29ja2V0IGlzIGluZGVlZCBwcmVwYXJlZA0KPiANCj4gWW91J2QgaGF2
ZSB0byB0cmFuc2xhdGUgdGhhdCBpZGlvbSB0byBweXRob24uDQoNCkRvbid0IHNlZSwgaG93IGl0
IGlzIGJldHRlciB0aGFuIHdoYXQgSSd2ZSBkb25lIGluIDA0Li4gQnV0IEkgY2FuIHJlc2VuZCB3
aXRoIHRoaXMuDQpBdCBsZWFzdCwgdGhlIGZhY3QgdGhhdCBzb2NrZXQgaXMgaW5pdGlhbGl6ZWQg
YmVmb3JlIGNyZWF0aW5nIHBpZCBmaWxlIGlzIHVuZG9jdW1lbnRlZC4uDQoNCj4gDQo+IE9yOg0K
PiANCj4gcHJlLW9wZW4gVW5peCBzb2NrZXQgYXQgL3BhdGgvdG8vc29ja2V0DQo+IExJU1RFTl9Q
SUQ9Li4uIExJU1RFTl9GRFM9MSBxZW11LW5iZCAuLi4gMzw+L3BhdGgvdG8vc29ja2V0DQo+IA0K
PiBOb3cgdGhlIHNvY2tldCBpcyBwcmUtY3JlYXRlZCBhbmQgcGFzc2VkIGludG8gcWVtdS1uYmQg
dmlhIHN5c3RlbWQgc29ja2V0IGFjdGl2YXRpb24sIHNvIHlvdSBrbm93IHRoZSBsaXN0ZW5pbmcg
c29ja2V0IGlzIHJlYWR5IHdpdGhvdXQgaGF2aW5nIHRvIGRvIGFueSBsb29wIGF0IGFsbC7CoCBI
ZXJlJ3MgYSBwYXRjaCBpbiBsaWJuYmQgd2hlcmUgd2UganVzdCBzd2l0Y2hlZCBmcm9tIHdhaXRp
bmcgZm9yIHRoZSBwb3J0IHRvIGFwcGVhciAoYmVjYXVzZSB0aGUgdGVzdCBwcmVkYXRlZCBxZW11
LW5iZCBwaWRmaWxlIHN1cHBvcnQpIHRvIGluc3RlYWQgdXNpbmcgc29ja2V0IGFjdGl2YXRpb24s
IGZvciByZWZlcmVuY2U6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJndWVzdGZzL2xpYm5iZC9j
b21taXQvMzUyMzMxZDE3Nw0KPiANCg0KSG1tLCBJJ20gYWZyYWlkIEkgbmVlZCBtb3JlIGhlbHAg
aW4gaXQsIEkgZG9uJ3Qga25vdyBzb2NrZXQgYWN0aXZhdGlvbiBhbmQgZ29vZ2xpbmcgZm9yIHNv
bWUgdGltZSBkaWRuJ3QgaGVscC4NCkhvdyB0byBwcmUtb3BlbiB0aGUgc29ja2V0PyBIb3cgdG8g
c2V0IExJU1RFTl9QSUQ/IExvb2tpbmcgYXQgdGhlIGNvZGUgSSBzZWUgdGhhdCBhY3RpdmF0aW9u
IHBhdGggZmFpbGVkIGlmDQpMSVNURU5fUElEICE9IGdldHBpZCgpLi4gU28gSSBuZWVkIHRvIGtu
b3cgcWVtdS1uYmQgcGlkIGJlZm9yZSBzdGFydGluZyBpdD8gb19PDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

