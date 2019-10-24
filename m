Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19981CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D644921906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZN0UpVLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D644921906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdV4-0006FF-6h
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNcfd-0007PR-E8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNcfc-00084t-9X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:56:53 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
 ([40.107.13.123]:27104 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iNcfY-00080B-Ed; Thu, 24 Oct 2019 08:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQohRf7nTo8COyf4p+SnOr6ga2K4H3rN7VspuUR438BAmwenMOjskoo79oF06vUvRHf/yrEvleZUawXcCIoIocAP/zsObj2fKLW1/zTLh4pbMcdEFq7leb7FSV4bXcdlclZzO18KxYRVI8uz5k7u8PCDth/JKYD1s7I3T0SP3NooFtmV5t4kBgJu1h0dkyPf4WZOZ9WQD8OQoZ8cT2C32+X2uKqT+pw6mCDddRLhJrUVrFB8gh3u7Fp22Y7ndus20JqKicLKA1Ql7plk7AQ+6XO1OL5mcRj5kap6uAJuMSKvy7A/pdQWNmpDW+84wN83ERnfCXeQRoSp7ZRo65LpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS58ZRhAeSkBCwewdPpEtTEsfg6Dx4cf5CYc/b9kwgY=;
 b=HmqOhDcDZvCwo1OQ7tFZMppizL5jMJIVhKShV2L4dmgCF3+fIPBIyR3yh9AgIvFcz9k20eVZS7KyCRVtODMQHE/shr8mFRg39aHj8MH87pRinczAdwGbND00dtZ8roQ/BSUWzUs1ecRj7REua3t6tQUtYbqVVNRwiDmRwf/ZWAqoiz/ypcxYqHpiE0f6LCsU/fu1QusJvaAvHK6+lrXo0JfOx21kju1tWKLcWMqcCYbWqnSlsJsRBMTLUJz2tXoLgjir5NeE80r6/Q6o7e0uuHBpkgI82Ll6IVEqmYN5XHddNcNNSS2dfEOLcrjE9gP0Xp4iUnxcxzRa7iP8qfhQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS58ZRhAeSkBCwewdPpEtTEsfg6Dx4cf5CYc/b9kwgY=;
 b=ZN0UpVLKUYEyksTLTvxe3dcz2zNHzDgbNkNORxa/ZS8DTkNEBZuP+2Kp5CYg3ky4f+ywElV2JclOg+OhfT8Qn9r3IJ0+sXCr0H/y5Rd3oGnjIYHzbZjDKJ0M5Kpx1Zwr1DEuY3EYNmS2pKLaZoZhhcXOtJOd9XjbeH6UBGGJPSU=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2822.eurprd08.prod.outlook.com (10.170.222.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 12:56:44 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 12:56:44 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Topic: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Index: AQHVh4YxkyM0Azl4xEijX5NTK9vhK6dmZxIAgABBJ4D//9ScgIAADIKAgAAOngCAAAlKgIAAQkoAgAKp9ICAADhsgA==
Date: Thu, 24 Oct 2019 12:56:44 +0000
Message-ID: <539e7d9e-0cb7-fdb7-f376-1648361ec2f3@virtuozzo.com>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
 <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
 <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
 <787da788-9aca-2110-a092-b63ef498a9fa@redhat.com>
 <ae5bc00f-e65e-8c33-2620-a9147e48ea78@virtuozzo.com>
 <1088f0ff-d882-083f-705c-95c08bdc486f@redhat.com>
 <cb6db9c4-0dbc-9d9a-4ec5-b436c48178a8@virtuozzo.com>
 <4fd89d2a-94aa-6f2d-ed7d-7633356e5163@redhat.com>
In-Reply-To: <4fd89d2a-94aa-6f2d-ed7d-7633356e5163@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0255.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::31) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5bce652-3105-4e22-a643-08d758819f1b
x-ms-traffictypediagnostic: DB6PR08MB2822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB28226D19423DFDB877D36D7EF46A0@DB6PR08MB2822.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(14454004)(31686004)(476003)(66556008)(66476007)(64756008)(31696002)(54906003)(66946007)(66446008)(14444005)(8676002)(446003)(26005)(81166006)(6486002)(256004)(8936002)(2906002)(2201001)(4326008)(486006)(81156014)(186003)(11346002)(5660300002)(44832011)(110136005)(76176011)(53546011)(6246003)(478600001)(6506007)(6436002)(107886003)(386003)(25786009)(102836004)(2616005)(2501003)(86362001)(36756003)(305945005)(66066001)(7736002)(71190400001)(316002)(71200400001)(6116002)(99286004)(6512007)(3846002)(229853002)(52116002)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2822;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UdvcWnCJsgfleHTvkKOtpCjy6RydLt8HEifg+dzSxMJF0EzvrTP7e8qlZ/2MVY0neseKqjgcJCyhFqPrDkqMIVnfW83uYeHOujg57RwWmZCCghgTfq6yFBUg2SeEcBmdhJkMQnF58eJsrs4bQmTR2mLKq2ByfPT8QdJt7aHUYuixad46m4jEbNR/W0Z6TaBUWPIvLwc8a35pJICQezCZm+nEqbL9pnpzo2pk98n9Zh0n7k9HfNlsnvegHBz7jPDel1ig9ulLtRTg0nLLqdOiolSHv+gBA3CTxsN34BFL/lXSvNGelzaz2jhJVz9DE5OaOSUwupgGJwcXRHXWL5nx4CAIsNh5/hpn/lJzPzpnvYV5orfnS2gU0RQdGqo/gWnZmOi/HN/QuepdcU2jQr3ALKOxD2IbT8qUNFkV4cctFo1dzbAcnWsU2rPssne+kg2
Content-Type: text/plain; charset="utf-8"
Content-ID: <D23493F9DDB34648AE4C0A484042F437@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bce652-3105-4e22-a643-08d758819f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 12:56:44.1288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C60d+CS5UrzRaIM/zyUbY7itVMfvyby1RWrMyXkXAlR9FW+bmqBsvIxC+aYMSCDOLEt0zXVa1C1n71hNh4w/DGGKkAi0jeCQAnD48HwmIjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2822
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.123
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI0LzEwLzIwMTkgMTI6MzQsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjIuMTAuMTkg
MTU6NTMsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+PiBJZiB0
aGUgc3VwcG9ydCBvZiBDT1cgZm9yIGNvbXByZXNzZWQgd3JpdGVzIGlzIGZvdW5kIGZlYXNpYmxl
LCB3aWxsIGl0DQo+PiBtYWtlIGEgc2Vuc2UgdG8gaW1wbGVtZW50PyBUaGVuIHRoaXMgc2VyaWVz
IHdpbGwgZm9sbG93Lg0KPiANCj4gSG0sIHdoYXQgZXhhY3RseSBkbyB5b3UgbWVhbiBieSBzdXBw
b3J0IG9mIENPVyBmb3IgY29tcHJlc3NlZCB3cml0ZXM/DQo+IA0KDQpJIHNwb2tlIGluIHRlcm1z
IG9mIHRoZSBjb21taXQgbWVzc2FnZSB3aXRoIHRoZSBmb2xsb3dpbmcgSUQ6DQoNCmIwYjY4NjJl
NWUxYTEzOTRlMGFiM2Q1ZGE5NGJhOGIwZGE4NjY0ZTINCg0KInFjb3cyOiBGYWlsIHdyaXRlX2Nv
bXByZXNzZWQgd2hlbiBvdmVyd3JpdGluZyBkYXRhIg0KDQoiLi4ucWNvdzJfd3JpdGVfY29tcHJl
c3NlZCgpIGRvZXNuJ3QgcGVyZm9ybSBDT1cgYXMgaXQgd291bGQgaGF2ZSB0byBkby4uLiINCg0K
U28sIEkgc3VnZ2VzdCB0aGF0IHdlIGltcGxlbWVudCB3cml0aW5nIGNvbXByZXNzZWQgZGF0YSB0
byB0aGUgYWxsb2NhdGVkIA0KY2x1c3RlcnMgcmF0aGVyIHRoYW4gcWNvdzJfYWxsb2NfY29tcHJl
c3NlZF9jbHVzdGVyX29mZnNldCgpIHJldHVybnMgdGhlIA0KZXJyb3IuIFBhcnRpY3VsYXJseSwg
d2hlbiBpdCBjb21lcyB0byBOQkQgc2VydmVyIGNvbm5lY3Rpb24gZmFpbHVyZSBmb3IgDQp3cml0
aGluZyBhIGNvbXByZXNzZWQgY2x1c3RlciwgaXQgbWF5IG5vdCBiZSByZXdyaXR0ZW4gYWZ0ZXIg
dGhlIA0KY29ubmVjdGlvbiBpcyByZXN0b3JlZC4NCkFyZSB0aGVyZSBhbnkgaXNzdWVzIHdpdGgg
dGhhdCBpbXBsZW1lbnRhdGlvbiBpZGVhPw0KDQpBbmRyZXkNCg0KPj4gQSBjb21tZW50IGZvciB0
aGUgb3B0aW9uIHdvdWxkIHdhcm4gYSB1c2VyIHRoYXQgZ3Vlc3Qgd3JpdGluZyB3aWxsIHdvcmsN
Cj4+IHNsb3dlciBmb3IgaWYgY29tcHJlc3Mgc2VsZWN0ZWQuDQo+IA0KPiBJ4oCZbSBub3Qgc3Vy
ZSB3aGV0aGVyIHRoYXTigJlzIG5lY2Vzc2FyeS4gIEFzIGEgdXNlciwgSSB3b3VsZCBhc3N1bWUg
dGhhdA0KPiBlbmFibGluZyBjb21wcmVzc2lvbiB3aWxsIGFsd2F5cyBtYWtlIHNvbWV0aGluZyBz
bG93ZXIuDQo+IA0KPiBNYXgNCj4gDQoNCg==

