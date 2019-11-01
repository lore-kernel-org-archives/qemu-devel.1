Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DFCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6871221734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JI03M4Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6871221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZxq-00064n-Hi
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQZx8-0005Xy-CR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQZx6-0006lN-LT
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:39:10 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com
 ([40.107.5.133]:25991 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQZx5-0006jO-Ue; Fri, 01 Nov 2019 12:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ6t/7VJv6rrCm9HZPZd6QQakmqHyzkn1Bb6l1G0KtSmnp2HNo+Qwej+xCfDMY9Lxe61BBAJvZ7iEd9C4WK7sJEuCCREln0D7VWNOtJIeFTv/zdQiFuOLknizYrSGwKqWODq1r7nUVmOPASqJRCdUYrDumKKxlfcLN+6LtCqCkjP1IKFwIPmXXMEp1iCMtsE5bv6QEVFhtK34WVm+rXpYqdEwVcPzZt/+PFDp3unaOAgyiktCLlbp8MFTHuAc17eBzbBmaaacjD2tZ+H9YMbQgCS6q2jyeik9rR0Au/F1u7aMclwqXVV/M7DIj5YEQ69mZBGxzadXcE6xh2EsntC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdAur+k1bn94Lp0SBPRLj+g03JIQucdYXH9tAiQQQGI=;
 b=BCG7U/OwDVIyTRU+Yg2ZlV8cvqBk5wBQ0pDvZpSxdzBBIFbkUjzqpRowUhN3Xd6l35VbboyzMgI+GGlqUzXLDpeJe+30OAJyrqW1p3BNK/pTBxjFMs6Zv6pRTIxtAdrVY10Ku5VcPZTrYfKZkr2jISuBt7nvaf3dCj26Udc1IgYB1BKyaJ1M0D51rpDZS+Z6x0PwDNY9NYTmwkG585diNBdcIIcRONQAhkhXc88FYYV0sMQOX627TFlrixV9s/+qoCV4pZRuM6OiUujoSu8gMCj0Os9JDYwEJa2l0Ol9wVisovP9Or41GcmE5Zf2+/gODGZH4nHeosHjooRsYB9aSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdAur+k1bn94Lp0SBPRLj+g03JIQucdYXH9tAiQQQGI=;
 b=JI03M4KtoFWXw2u4/jXBOQmqiTq2IOtdC0QeT6o4SUkDqmSppUoD280eR82q+ZEf6DZWO6wJ/MVUge4CPgRLsOcjvmrs2DM6Ot9thGih0psx53jyGMhs1T72GHOCU3x4CjwEs6B5Yj7QKJL1Gd77U8bf9NYmTLAfiZwlIcuumOg=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3172.eurprd08.prod.outlook.com (52.134.126.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 16:39:04 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 16:39:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Lunev <den@virtuozzo.com>, John Snow <jsnow@redhat.com>, Qemu-block
 <qemu-block@nongnu.org>
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
Thread-Topic: bitmaps -- copying allocation status into dirty bitmaps
Thread-Index: AQHVkMsD74l2GkYcp0KjyQwNU60SGad2dlMAgAAN0YA=
Date: Fri, 1 Nov 2019 16:39:03 +0000
Message-ID: <cc2febfb-7c4d-8c5d-da20-b0a16a96ca46@virtuozzo.com>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
 <c8a31188-ff21-368e-12ca-0481a51c3136@openvz.org>
In-Reply-To: <c8a31188-ff21-368e-12ca-0481a51c3136@openvz.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0062.eurprd09.prod.outlook.com
 (2603:10a6:3:45::30) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101193901847
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a85564a-b5f7-456f-d854-08d75eea0183
x-ms-traffictypediagnostic: AM0PR08MB3172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3172B4779EE35E5C423F05BBC1620@AM0PR08MB3172.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(346002)(396003)(366004)(189003)(199004)(6506007)(71200400001)(256004)(14444005)(6486002)(7736002)(2616005)(476003)(486006)(54906003)(229853002)(25786009)(478600001)(3846002)(11346002)(6116002)(14454004)(110136005)(2906002)(316002)(6246003)(66066001)(8936002)(81156014)(6512007)(4326008)(305945005)(6436002)(71190400001)(53546011)(8676002)(86362001)(66946007)(31686004)(26005)(186003)(76176011)(5660300002)(386003)(52116002)(102836004)(99286004)(66556008)(66446008)(66476007)(64756008)(36756003)(31696002)(446003)(81166006)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3172;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/uoy/IszR/tYa8EGo9CDtRtPqcT4y3W8BYou4BqeOjZQXntRqfoYqisBon/t2LhIICVltEB0yxRMTIYbiC91DyQRo4zEbSkRO9egr1M6THkBaV+qVmivoCzzZ3Hr5nfKQ7XY0LezMGE4yRNLhK3ZFJv8kk/SvfUDFcX9KZu0KAvWP/KBxjdJhImj6R2fB5pvOiAqzwsB+YB7iZaTRFIsGTMIJr/G0Pxm149pT9qj911Qnlin9xe2vn1P3kDXXDkQX4OjdibmUisTNzp/ktfGTy+4axmw9b77LWUyVd6aEO4WcPGdGsIFgZ6BochFsMIyC2dcMOi11n/tTpiZyZwucqnjs0ezXWVyE3jrFyy/hhp2qAhBB+8MvibhHksi/jqZPIVrKKDm6VbegMMzWyQQuCek404Bfu/y9gM5heRwmmbxbVWCiWjcGPKckXhvNgY
Content-Type: text/plain; charset="utf-8"
Content-ID: <957D923A4C7F4D489B0C8DCB29A81213@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a85564a-b5f7-456f-d854-08d75eea0183
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 16:39:04.0958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decXG1XTrvPHXYpuOxswZmOakK0PC9v4dIqVJ795Cjt8SNnykJPN1SkBVdzn7F/jifZQGILzfhG02drZzdV2S9WeLNWzNdiFnQwP2lOQqvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3172
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.133
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxODo0OSwgRGVuaXMgTHVuZXYgd3JvdGU6DQo+IE9uIDExLzEvMTkgNDo0MiBQ
TSwgSm9obiBTbm93IHdyb3RlOg0KPj4gSGksIGluIG9uZSBvZiBteSBpbmZhbW91c2x5IHVucmVh
ZGFibGUgYW5kIGxvbmcgc3RhdHVzIGVtYWlscywgSQ0KPj4gbWVudGlvbmVkIHBvc3NpYmx5IHdh
bnRpbmcgdG8gY29weSBhbGxvY2F0aW9uIGRhdGEgaW50byBiaXRtYXBzIGFzIGEgd2F5DQo+PiB0
byBlbmFibGUgdXNlcnMgdG8gY3JlYXRlIChleHRlcm5hbCkgc25hcHNob3RzIGZyb20gb3V0c2lk
ZSBvZiB0aGUNCj4+IGxpYnZpcnQvcWVtdSBjb250ZXh0Lg0KPj4NCj4+IChUaGF0IGlzOiB0byBy
ZXBhaXIgY2hlY2twb2ludHMgaW4gbGlidmlydCBhZnRlciBhIHVzZXIgZXh0ZW5kZWQgdGhlDQo+
PiBiYWNraW5nIGNoYWluIHRoZW1zZWx2ZXMsIHlvdSB3YW50IHRvIHJlc3RvcmUgYml0bWFwIGlu
Zm9ybWF0aW9uIGZvcg0KPj4gdGhhdCBub2RlLiBDb252ZW5pZW50bHksIHRoaXMgaW5mb3JtYXRp
b24gSVMgdGhlIGFsbG9jYXRpb24gbWFwLCBzbyB3ZQ0KPj4gY2FuIGRvIHRoaXMuKQ0KPj4NCj4+
IEl0IGNhbWUgdXAgYXQgS1ZNIEZvcnVtIHRoYXQgd2UgcHJvYmFibHkgZG8gd2FudCB0aGlzLCBi
ZWNhdXNlIG9WaXJ0DQo+PiBsaWtlcyB0aGUgaWRlYSBvZiBiZWluZyBhYmxlIHRvIG1hbmlwdWxh
dGUgdGhlc2UgY2hhaW5zIGZyb20gb3V0c2lkZSBvZg0KPj4gbGlidmlydC9xZW11Lg0KPj4NCj4+
IERlbmlzIHN1Z2dlc3RlZCB0aGF0IGluc3RlYWQgb2YgYSBuZXcgY29tbWFuZCwgd2UgY2FuIGNy
ZWF0ZSBhIHNwZWNpYWwNCj4+IG5hbWUgLS0gbWF5YmUgIiNBTExPQ0FURUQiIG9yIHNvbWV0aGlu
ZyBzaW1pbGFyIHRoYXQgY2FuIG5ldmVyIGJlDQo+PiBhbGxvY2F0ZWQgYXMgYSB1c2VyLWRlZmlu
ZWQgYml0bWFwIG5hbWUgLS0gYXMgYSBzcGVjaWFsIHNvdXJjZSBmb3IgdGhlDQo+PiBtZXJnZSBj
b21tYW5kLg0KPj4NCj4+IFlvdSdkIGlzc3VlIGEgbWVyZ2UgZnJvbSAiI0FMTE9DQVRFRCIgdG8g
Im15Qml0bWFwMCIgdG8gY29weSB0aGUgY3VycmVudA0KPj4gYWxsb2NhdGlvbiBkYXRhIGludG8g
Im15Qml0bWFwMCIsIGZvciBpbnN0YW5jZS4NCj4gb3JpZ2luYWwgcHJvYmxlbSB3YXMgYSBsaXR0
bGUgYml0IGluY29ycmVjdC4gQWZ0ZXIgc29tZSB0aG91Z2h0cyBJIGZvdW5kDQo+IHRoYXQgdGhp
cyBpcyBOT1QgZW5vdWdoLiBXZSBzaG91bGQgYWxzbyBhZGQgemVyb2VkIGNsdXN0ZXJzIHRvIHRo
ZQ0KPiBiaXRtYXAgdG8gbWVyZ2UhIFRoZXkgZG8gY292ZXIgc29tZSBkYXRhIGNsdXN0ZXJzIGZy
b20gdGhlIG9yaWdpbmFsDQo+IGltYWdlLg0KPiANCj4gVGh1cyB3ZSBzaG91bGQgZWl0aGVyIHBy
b3ZpZGUgIkFMTE9DQVRFRCIgYml0bWFwIGZvciBvdGhlciBwdXJwb3NlcywNCj4gYW5kIHdlIHNo
b3VsZCBzdXBwbHkgIkNIQU5HRUQiIHdoaWNoIGNvbnRhaW5zIGFsbG9jYXRlZCBBTkQNCj4gZXhw
bGljaXRseSB6ZXJvZWQgY2x1c3RlcnMuDQoNCkFjdHVhbGx5IGluIHRlcm1zIG9mIFFlbXUgKGJk
cnZfaXNfYWxsb2NhdGVkKSB6ZXJvZWQgY2x1c3RlcnMgKGluIHFjb3cyKQ0KYXJlIGNvbnNpZGVy
ZWQgYWxsb2NhdGVkLg0KDQpCRFJWX0JMT0NLX0FMTE9DQVRFRCBpcyBkZWZpbmVkIGFzDQoNCiAg
KiBCRFJWX0JMT0NLX0FMTE9DQVRFRDogdGhlIGNvbnRlbnQgb2YgdGhlIGJsb2NrIGlzIGRldGVy
bWluZWQgYnkgdGhpcw0KICAqICAgICAgICAgICAgICAgICAgICAgICBsYXllciByYXRoZXIgdGhh
biBhbnkgYmFja2luZywgc2V0IGJ5IGJsb2NrIGxheWVyDQoNCi0gc28sIGl0J3Mgbm90aGluZyBh
Ym91dCBhbGxvY2F0ZWQgcmVnaW9ucyBvbiBob3N0IGRpc2ssIGl0J3MgYW4gaW50ZXJuYWwNCmNv
bmNlcHQgYWJvdXQgaXMgZGF0YSAob3IgemVybykgaW4gdGhpcyBsYXllciBvciBpbiBiYWNraW5n
Lg0KDQo+IA0KPiBEZW4NCj4+IFNvbWUgdGhvdWdodHM6DQo+Pg0KPj4gLSBUaGUgb25seSBjb21t
YW5kcyB3aGVyZSB0aGlzIHBzZXVkby1iaXRtYXAgbWFrZXMgc2Vuc2UgaXMgbWVyZ2UuDQo+PiBl
bmFibGUvZGlzYWJsZS9yZW1vdmUvY2xlYXIvYWRkIGRvbid0IG1ha2Ugc2Vuc2UgaGVyZS4NCj4+
DQo+PiAtIFRoaXMgcHNldWRvIGJpdG1hcCBtaWdodCBtYWtlIHNlbnNlIGZvciBiYWNrdXAsIGJ1
dCBpdCdzIG5vdCBuZWVkZWQ7DQo+PiB5b3UgY2FuIGp1c3QgbWVyZ2UgaW50byBhbiBlbXB0eS9l
bmFibGVkIGJpdG1hcCBhbmQgdGhlbiB1c2UgdGhhdC4NCj4+DQo+PiAtIENyZWF0aW5nIGFuIGFs
bG9jYXRpb24gYml0bWFwIG9uLXRoZS1mbHkgaXMgcHJvYmFibHkgbm90IHBvc3NpYmxlDQo+PiBk
aXJlY3RseSBpbiB0aGUgbWVyZ2UgY29tbWFuZCwgYmVjYXVzZSB0aGUgZGlzayBzdGF0dXMgY2Fs
bHMgbWlnaHQgdGFrZQ0KPj4gdG9vIGxvbmcuLi4NCj4+DQo+PiBIbSwgYWN0dWFsbHksIEknbSBu
b3Qgc3VyZSBob3cgdG8gc29sdmUgdGhhdCBvbmUuIE1lcmdlIHdvdWxkIG5lZWQgdG8NCj4+IGJl
Y29tZSBhIGpvYiAob3IgYW4gYXN5bmMgUU1QIGNvbW1hbmQ/KSBvciB3ZSdkIG5lZWQgdG8ga2Vl
cCBhbg0KPj4gYWxsb2NhdGlvbiBiaXRtYXAgb2JqZWN0IGFyb3VuZCBhbmQgaW4tc3luYy4gSSBk
b24ndCByZWFsbHkgd2FudCB0byBkbw0KPj4gZWl0aGVyLCBzbyBtYXliZSBJJ20gbWlzc2luZyBh
biBvYnZpb3VzL2JldHRlciBzb2x1dGlvbi4NCj4+DQo+PiBBbHNvLCB3aXRoIHJlZ2FyZHMgdG8g
aW50cm9zcGVjdGlvbiwgaWYgd2UgZG8gY3JlYXRlIGEgc3BlY2lhbCByZXNlcnZlZA0KPj4gbmFt
ZSBsaWtlICNBTExPQ0FURUQsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBpcyBhdmFp
bGFibGUgYW5kDQo+PiBvYnZpb3VzIHZpYSB0aGUgUUFQSSBzY2hlbWEuDQo+Pg0KPj4gLS1qcw0K
Pj4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

