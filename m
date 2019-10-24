Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E624CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32564205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ds8I9WBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32564205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfeU-00085V-91
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNe5B-0002Ke-JR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNe5A-0004S3-5l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:21 -0400
Received: from mail-eopbgr00125.outbound.protection.outlook.com
 ([40.107.0.125]:38827 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iNe56-0004NP-MA; Thu, 24 Oct 2019 10:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR6kUUnWrLy1IMW4bVFVIbtSObUPtMULwcFOaTxiVRaIYMBFDU4Ir/LA9DwlsyWluRx2rNvARV5DTQs2y8y8ShJX8m6PR8jUMwwckV15SAOSKfVX1X0nU2ujVMIhRCf5y7ZliL7GuF2242Xu9+bHZtYoBcgm4Nrw+NdrP+YGor5z942ZQZXaKSgzYylPESOLCZRtVLlav4RGZ5h7AysZrztJQZd+uoQrBHWA8S4z0VGQyI+wLpHo7W3YpHFXMnZM/gADz2C43aj1iuY4bFuLXGeJWwBjdJflb4VA15Lyx7XumKkq6Nk9gMk8SOfsVSDC90L6G5sKnny/ZgsZqJK1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljnGNIDtLhCrWP/ufhzwPHrYGrptIxBOJAUnKduC80U=;
 b=YTrWntjS9J7hQIsOimOHyEgopO4xKWcH2UZSEKTuY0EFY/YW2661wt6+QoG+Qtccy4UdiynLRxfxBD5jl2bEquk+rKXQlZ4DhTZVNudefMMMoLLqNCZ6VyNid6F1Zl/plm1iCPGlyjYos6s7NTT2RdtRnct+2pR/k6puUuy/3Os4BQjqLbK7Wk4oZFjGUdeSJYgNa+iWpKyj3f+l4R0n1pKfn3+tOg1NV88wKE+0ZcqmvViKWFxQGY1W49mBQVu8MUxphAkYB++l2ew5f8WdmLosGKF4n54YPAO5Q6qOTFuvQ1CJgk1E5cDo5/ymjqIlsDcAr6pftbwQ0z59Z19tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljnGNIDtLhCrWP/ufhzwPHrYGrptIxBOJAUnKduC80U=;
 b=Ds8I9WBHoVufbr/aiNEDeppxqp5HVcWpAj9xTG/H2bnXwPVNH2RL7d9Tx7V3D61nKeXZL3KEclGmRBRtgTfJo54uz87x7DLXV9Tr/aB5fmRcsDD9bb8OD0KzYjM8SIP5zIl+Ryf82CB+n0okD5vE7SHT9b9SBWGJkztvukYcLBk=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2632.eurprd08.prod.outlook.com (10.170.219.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 24 Oct 2019 14:27:14 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 14:27:14 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Topic: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Index: AQHVh4YxkyM0Azl4xEijX5NTK9vhK6dmZxIAgABBJ4D//9ScgIAADIKAgAAOngCAAAlKgIAAQkoAgAKp9ICAAGq2gP//3BKAgAAK7YA=
Date: Thu, 24 Oct 2019 14:27:14 +0000
Message-ID: <cc1f7f63-23ab-8cde-8fb5-590ccfe702d0@virtuozzo.com>
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
 <539e7d9e-0cb7-fdb7-f376-1648361ec2f3@virtuozzo.com>
 <8828d08f-79aa-f3a6-4387-f1423a8b7d70@redhat.com>
In-Reply-To: <8828d08f-79aa-f3a6-4387-f1423a8b7d70@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843d2ed8-69eb-4d2d-e416-08d7588e43cf
x-ms-traffictypediagnostic: DB6PR08MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB263213EC6CAB23C112D142C4F46A0@DB6PR08MB2632.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(376002)(366004)(346002)(199004)(189003)(316002)(81166006)(81156014)(386003)(66476007)(5660300002)(2906002)(44832011)(4326008)(99286004)(8676002)(76176011)(36756003)(31686004)(14444005)(107886003)(66556008)(110136005)(256004)(52116002)(478600001)(14454004)(66066001)(2201001)(64756008)(54906003)(66446008)(6512007)(186003)(446003)(6436002)(6486002)(2501003)(2616005)(31696002)(7736002)(305945005)(6246003)(25786009)(26005)(229853002)(8936002)(102836004)(53546011)(3846002)(486006)(86362001)(71190400001)(66946007)(6116002)(476003)(11346002)(6506007)(71200400001)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2632;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHrF9wuHsZlzXJzbIMpFVtlis5iOir+C8+SvjYbXo8/zLqBqDfAKYi9sP2hmm3N5AJ+ZXW5J1GidGpu9Iu4m78nFi0DMFBJiCui/x17mEbjrz8ZP2mvLnTxViPlC1ff9DlbttRvr8wMmv/YswuqQno1SpMg2WhG/T/kGRHqorTXpKBU/Okf2oFpCZO7D+PllxsoQYuf4C4iSp03kZrqkmw+Xz9yEFGUGyaCJxIcEjkTHqWGb4W3NpV6C4cIH4GCPX48/Ow2Xon7BdngE6fmp1JQgldGpbkSSc6RVuiRDAJ/U4nLjQJLq3bIJIBabGfnWbwCqbHUcT/qIfRAgj/0yt9xKg1x31LgdGRjCtIrYcP+NjbLhmDW77JhQANuQibJPW0UU4YZaO/bUwSHvcNZz+3DsAneWySbLN4Gi4FcNUyrIRN8UHIFExh+ejaY4Dbge
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E8DC3D67E71614BAE8239F1B036E1BA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843d2ed8-69eb-4d2d-e416-08d7588e43cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 14:27:14.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4ry3ON9u9RqLPh/0BjpC1Cj7lYbFJGH/Ry03ts5/E8ECPJ+10fR01aVEDYAgYeSdGOR6s9zTH4gwqFKfMdfLN+zrVywI5RBuDM561jnoYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2632
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.125
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

DQoNCk9uIDI0LzEwLzIwMTkgMTY6NDgsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjQuMTAuMTkg
MTQ6NTYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAyNC8xMC8yMDE5
IDEyOjM0LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gT24gMjIuMTAuMTkgMTU6NTMsIEFuZHJleSBT
aGlua2V2aWNoIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+PiBJZiB0aGUgc3VwcG9y
dCBvZiBDT1cgZm9yIGNvbXByZXNzZWQgd3JpdGVzIGlzIGZvdW5kIGZlYXNpYmxlLCB3aWxsIGl0
DQo+Pj4+IG1ha2UgYSBzZW5zZSB0byBpbXBsZW1lbnQ/IFRoZW4gdGhpcyBzZXJpZXMgd2lsbCBm
b2xsb3cuDQo+Pj4NCj4+PiBIbSwgd2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5IHN1cHBvcnQg
b2YgQ09XIGZvciBjb21wcmVzc2VkIHdyaXRlcz8NCj4+Pg0KPj4NCj4+IEkgc3Bva2UgaW4gdGVy
bXMgb2YgdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggdGhlIGZvbGxvd2luZyBJRDoNCj4+DQo+PiBi
MGI2ODYyZTVlMWExMzk0ZTBhYjNkNWRhOTRiYThiMGRhODY2NGUyDQo+Pg0KPj4gInFjb3cyOiBG
YWlsIHdyaXRlX2NvbXByZXNzZWQgd2hlbiBvdmVyd3JpdGluZyBkYXRhIg0KPj4NCj4+ICIuLi5x
Y293Ml93cml0ZV9jb21wcmVzc2VkKCkgZG9lc24ndCBwZXJmb3JtIENPVyBhcyBpdCB3b3VsZCBo
YXZlIHRvIGRvLi4uIg0KPj4NCj4+IFNvLCBJIHN1Z2dlc3QgdGhhdCB3ZSBpbXBsZW1lbnQgd3Jp
dGluZyBjb21wcmVzc2VkIGRhdGEgdG8gdGhlIGFsbG9jYXRlZA0KPj4gY2x1c3RlcnMgcmF0aGVy
IHRoYW4gcWNvdzJfYWxsb2NfY29tcHJlc3NlZF9jbHVzdGVyX29mZnNldCgpIHJldHVybnMgdGhl
DQo+PiBlcnJvci4gUGFydGljdWxhcmx5LCB3aGVuIGl0IGNvbWVzIHRvIE5CRCBzZXJ2ZXIgY29u
bmVjdGlvbiBmYWlsdXJlIGZvcg0KPj4gd3JpdGhpbmcgYSBjb21wcmVzc2VkIGNsdXN0ZXIsIGl0
IG1heSBub3QgYmUgcmV3cml0dGVuIGFmdGVyIHRoZQ0KPj4gY29ubmVjdGlvbiBpcyByZXN0b3Jl
ZC4NCj4+IEFyZSB0aGVyZSBhbnkgaXNzdWVzIHdpdGggdGhhdCBpbXBsZW1lbnRhdGlvbiBpZGVh
Pw0KPiANCj4gV2VsbCwgdGhlIENPVyBpbiB0aGF0IGNvbW1pdCBpcyBtZWFudCBkaWZmZXJlbnRs
eSwgYmVjYXVzZSBpdCByZWZlcnMgdG8NCj4gdGhlIENPVyB0aGF04oCZcyByZXF1aXJlZCB3aGVu
IHdyaXRpbmcgdG8gYSBjbHVzdGVyIHNoYXJlZCBieSBhbiBpbnRlcm5hbA0KPiBzbmFwc2hvdC4N
Cj4gDQo+IE9UT0gsIHlvdSBjb3VsZCBzYXkgdGhhdCBhbGwgY29tcHJlc3NlZCB3cml0ZXMgdG8g
YSBjbHVzdGVyIHRoYXQgaXMNCj4gYWxyZWFkeSBhbGxvY2F0ZWQgd291bGQgbmVlZCB0byBkbyBD
T1cgYmVjYXVzZSB3ZeKAmWQgYWx3YXlzIGhhdmUgdG8gZnVsbHkNCj4gcmV3cml0ZSB0aGF0IGNs
dXN0ZXIgaW4gYW4gUk1XIGN5Y2xlLg0KPiANCj4gSSBkb27igJl0IHNlZSBob3cgbGV0dGluZyBx
Y293Ml9hbGxvY19jb21wcmVzc2VkX2NsdXN0ZXJfb2Zmc2V0KCkgdXNlIHRoZQ0KPiBleGlzdGlu
ZyBjbHVzdGVyIHdvdWxkIHNvbHZlIHRoZSBwcm9ibGVtLCB0aG91Z2guICBZb3XigJlkIGdlbmVy
YWxseSBuZWVkDQo+IHRvIGFsbG9jYXRlIGEgbmV3IGNsdXN0ZXI7IG9yIGF0dGVtcHQgdG8gcmV1
c2UgdGhlIGV4aXN0aW5nIHNwYWNlIGluIGENCj4gY29tcHJlc3NlZCBjbHVzdGVyLg0KPiANCj4g
TWF4DQo+IA0KDQpUaGUgaWRlYSB3YXMgdG8gYXZvaWQgdGhlIGZvbGxvd2luZyBlcnJvcjoNCg0K
JCAuL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAtbyBzaXplPTEwTSAuL2ltYWdlLnFjb3cyDQpG
b3JtYXR0aW5nICcuL2ltYWdlLnFjb3cyJywgZm10PXFjb3cyIHNpemU9MTA0ODU3NjAgY2x1c3Rl
cl9zaXplPTY1NTM2IA0KbGF6eV9yZWZjb3VudHM9b2ZmIHJlZmNvdW50X2JpdHM9MTYNClthbmRy
ZXlAZGhjcC0xNzItMTYtMjUtMTM2IHFlbXVdJCBnaXQgZGlmZiAtLW5hbWUtb25seQ0KbmJkL3Nl
cnZlci5jDQokIC4vcWVtdS1pbyAtYyAid3JpdGUgLVAgMHgxMiAwIDY0ayIgLi9pbWFnZS5xY293
Mg0Kd3JvdGUgNjU1MzYvNjU1MzYgYnl0ZXMgYXQgb2Zmc2V0IDANCjY0IEtpQiwgMSBvcHM7IDAu
MDE1MiBzZWMgKDQuMTAxIE1pQi9zZWMgYW5kIDY1LjYwODIgb3BzL3NlYykNCiQgLi9xZW11LWlv
IC1jICJ3cml0ZSAtYyAtUCAweDEyIDAgNjRrIiAuL2ltYWdlLnFjb3cyDQp3cml0ZSBmYWlsZWQ6
IElucHV0L291dHB1dCBlcnJvcg0KDQpJZiBpdCBpbmN1cnMgYSBoaWdoIGNvc3QsIHdlIGNhbiBj
aG9vc2UgdGhlIGZpbHRlciBvcHRpb24gYXMgZGlzY3Vzc2VkIA0KYWJvdmUuDQoNCkFuZHJleQ0K
DQo=

