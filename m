Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F37C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC8D20673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YSGSAroP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC8D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUyl-0001IW-TX
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxUyJ-0000ie-Ug
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxUyI-0001pG-No
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:28:11 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com
 ([40.107.0.139]:65507 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxUyI-0001oa-HY; Tue, 13 Aug 2019 07:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/9s7nMVXyCFsNDbvTm2Qal6lRGSJNz/YrEzRPzBZG0QIdJW14a4DqI7czx9sYv0719bdv8O6h6yJLNUKsG23oW6X5yHwWr36UTq2AGQXJKHzfsCpjXn9qZlxTh0k9KeQVN1bnJERl3vXXmXB9Ug9CquPUrR15Ph+27yNPsylzBaHHpAfmz9YD0LrqjUmRrdULtMGeGHHNhDaAroR1KMFbaItVTmFGsZmdWPF21x/ci+UvUIDVUWy93PBMksI+7CByzVk/YuylDMuTfvBBtVUUaLi/gAoKOLYp5VUOsNU0EqW/udCgMlSAmRcPaK4zqdMAX/YWSMd9mJFUmIFht8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28hbuT5hKOaq340AtE/fazJO4/WWsdqyrlbPLL1DrDs=;
 b=XZe+utapWwMurrHgYkyP3V8KitaQY6YLUjFyYSK1DB/Lf5uAbvRbT2XX/y9Tm4dA0/403pAXa/rFyve7nPBcfvoeY3Wqm9fbbLNYo8glXHXohpB0NkGrddjghXCrUsB/mrE6vPgpEi7EMtJhBQ39CyngiHgLK1yp6n/njeWzqIurvG7NSKxLWRfKX4yJF6QdSJr3wIy8HFQAJ/lrj//kGm/kxl7mpTIHIgVrXepVjvs6MbIX9euCluHRmitq0uQMAlR7/FtdDtMxVCPskGgsIfh6Qm19eaauHJavZp/w9LezrVygDJ+cu1+FRuxWUB+/qzOJJdv9P+Jc0XZkKUpuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28hbuT5hKOaq340AtE/fazJO4/WWsdqyrlbPLL1DrDs=;
 b=YSGSAroPnBtl3KTQLYpCei5zm1TnSByYU61G/PQO905IXwcDfbq6BSxFt59kRra+edOGzqdp/eL2eQdGnxoDiUhBKN5SLx8Dor3FJSnqLyyz+QgbiIwSyNYj9ulD+9pzhxSgAA68YlojnzDspyBOAOzNVipIgEUTI6Xq6FUXQ/s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4138.eurprd08.prod.outlook.com (20.179.9.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 11:28:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 11:28:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAAGmAA=
Date: Tue, 13 Aug 2019 11:28:06 +0000
Message-ID: <7fcab62a-ad7b-4105-7a23-76c46d8cee0f@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
In-Reply-To: <20190813110428.GE4663@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813142804751
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e2a9fc4-7a57-46f0-0eef-08d71fe15015
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4138; 
x-ms-traffictypediagnostic: DB8PR08MB4138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4138DF59C2DFE4D003CBADD9C1D20@DB8PR08MB4138.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(386003)(486006)(4326008)(52116002)(36756003)(446003)(2616005)(6246003)(14454004)(6506007)(478600001)(107886003)(66946007)(81156014)(86362001)(6512007)(66446008)(102836004)(6436002)(53936002)(476003)(256004)(11346002)(76176011)(81166006)(31696002)(25786009)(6916009)(64756008)(8936002)(66476007)(66556008)(99286004)(6486002)(229853002)(66066001)(6116002)(5660300002)(316002)(3846002)(31686004)(54906003)(8676002)(26005)(305945005)(2906002)(71200400001)(71190400001)(7736002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4138;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hNgzxLIF1fb6uNnj3MP78uYDxddVfqZ2GRmqNrij7z7llEl5ZKt/gwOcxzyiFOZKbg3rMyB5bRexYqNllpI7aRfsYS6Ob9sQqbGFAPTYZms/ydixQkujwK9mWKD2ZkYKsPSgYBa9fU9ndA6tbjCq9pnos9oOC6vb33pJEYU/vCdzpQRY44Bo8iq1qrQl+VOLBzLxPi2ucOjoSGigFBPwua6twzSznmX0o/fFJIXGYqsAKA19D4/ETO3cvuc08Y9OXJPmfFLm1D8GRrbIEh/enz3SFcbij/i8KBFak4JNY3pXKPRxHGQgiziQtwMd6B0USZF19DSQ1Gh6LiISOwLVDj90bs2z0lgB/AYNnwIFrS9lxEJ6zF6W5578axaB0PRYC/VwkN9dCQ4QFGg29iGNJmAdKPjAOFpen+zQZTKw6ho=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFDA9D809817346B8D61FD1A42DE7E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a9fc4-7a57-46f0-0eef-08d71fe15015
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:28:06.9335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8w+BSxwt5kfJ4LjDfZdiQJLXZGCDNDd0JhEfxevFfHUvt1cjTPT0EPs80pZ3n4lUIggwvmvoKy8Iac31EJXKLFSSvPpgu+nrfuRQnVcQa0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4138
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.139
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxNDowNCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTIuMDguMjAxOSB1bSAy
MDoxMSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEJE
UlZfQkxPQ0tfUkFXIG1ha2VzIGdlbmVyaWMgYmRydl9jb19ibG9ja19zdGF0dXMgdG8gZmFsbHRo
cm91Z2ggdG8NCj4+IHJldHVybmVkIGZpbGUuIEJ1dCBpcyBpdCBjb3JyZWN0IGJlaGF2aW9yIGF0
IGFsbD8gSWYgcmV0dXJuZWQgZmlsZQ0KPj4gaXRzZWxmIGhhcyBhIGJhY2tpbmcgZmlsZSwgd2Ug
bWF5IHJlcG9ydCBhcyB0b3RhbGx5IHVuYWxsb2NhdGVkIGFuZA0KPj4gYXJlYSB3aGljaCBhY3R1
YWxseSBoYXMgZGF0YSBpbiBib3R0b20gYmFja2luZyBmaWxlLg0KPj4NCj4+IFNvLCBtaXJyb3Jp
bmcgb2YgcWNvdzIgdW5kZXIgcmF3LWZvcm1hdCBpcyBicm9rZW4uIFdoaWNoIGlzIGlsbHVzdHJh
dGVkDQo+PiBieSBmb2xsb3dpbmcgY29tbWl0IHdpdGggYSB0ZXN0LiBMZXQncyBtYWtlIHJhdy1m
b3JtYXQgYmVoYXZlIG1vcmUNCj4+IGNvcnJlY3RseSByZXR1cm5pbmcgQkRSVl9CTE9DS19EQVRB
Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4gDQo+IEFmdGVyIHNvbWUgcmVhZGluZywgSSB0aGluayBJIGNhbWUg
dG8gdGhlIGNvbmNsdXNpb24gdGhhdCBSQVcgaXMgdGhlDQo+IGNvcnJlY3QgdGhpbmcgdG8gZG8u
IFRoZXJlIGlzIGluZGVlZCBhIHByb2JsZW0sIGJ1dCB0aGlzIHBhdGNoIGlzIHRyeWluZw0KPiB0
byBmaXggaXQgaW4gdGhlIHdyb25nIHBsYWNlLg0KPiANCj4gSW4gdGhlIGNhc2Ugd2hlcmUgdGhl
IGJhY2tpbmcgZmlsZSBjb250YWlucyBzb21lIGRhdGEsIGFuZCB3ZSBoYXZlIGENCj4gJ3Jhdycg
bm9kZSBhYm92ZSB0aGUgcWNvdzIgb3ZlcmxheSBub2RlLCB0aGUgY29udGVudCBvZiB0aGUgcmVz
cGVjdGl2ZQ0KPiBibG9jayBpcyBub3QgZGVmaW5lZCBieSB0aGUgcXVlcmllZCBiYWNraW5nIGZp
bGUgbGF5ZXIsIHNvIGl0IGlzDQo+IGNvbXBsZXRlbHkgY29ycmVjdCB0aGF0IGJkcnZfaXNfYWxs
b2NhdGVkKCkgcmV0dXJucyBmYWxzZSwgbGlrZSBpdCB3b3VsZA0KPiBpZiB5b3UgcXVlcmllZCB0
aGUgcWNvdzIgbGF5ZXIgZGlyZWN0bHkuIElmIGl0IHJldHVybmVkIHRydWUsIHdlIHdvdWxkDQo+
IGNvcHkgZXZlcnl0aGluZywgd2hpY2ggaXNuJ3QgcmlnaHQgZWl0aGVyICh0aGUgdGVzdCBjYXNl
cyBzaG91bGQgbWF5IGFkZA0KPiB0aGUgcWVtdS1pbWcgbWFwIG91dHB1dCBvZiB0aGUgdGFyZ2V0
IHNvIHRoaXMgYmVjb21lcyB2aXNpYmxlKS4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2Ug
dHJ5IHRvIHJlY3Vyc2UgYWxvbmcgdGhlIGJhY2tpbmcgY2hhaW4sIGJ1dCB3ZQ0KPiBmYWlsIHRv
IG1ha2UgdGhlIHN0ZXAgZnJvbSB0aGUgcmF3IG5vZGUgdG8gdGhlIGJhY2tpbmcgZmlsZS4NCg0K
SSdkIHNheSwgdGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBpZ25vcmUgYmFja2luZyBjaGFpbiBvZiBu
b24tYmFja2luZyBjaGlsZA0KDQo+IA0KPiBOb3RlIHRoYXQganVzdCBleHRlbmRpbmcgTWF4J3Mg
ImRlYWwgd2l0aCBmaWx0ZXJzIiBpcyBub3QgZW5vdWdoIHRvIGZpeA0KPiB0aGlzIGJlY2F1c2Ug
cmF3IGRvZXNuJ3QgYWN0dWFsbHkgbWVldCBhbGwgb2YgdGhlIGNyaXRlcmlhIGZvciBiZWluZyBh
DQo+IGZpbHRlciBpbiB0aGlzIHNlbnNlIChhdCBsZWFzdCBiZWNhdXNlIHRoZSAnb2Zmc2V0JyBv
cHRpb24gY2FuIGNoYW5nZQ0KPiBvZmZzZXRzIGJldHdlZW4gcmF3IGFuZCBpdHMgY2hpbGQpLg0K
PiANCj4gSSB0aGluayB0aGlzIGlzIGVzc2VudGlhbGx5IGEgcmVzdWx0IG9mIHNwZWNpYWwtY2Fz
aW5nIGJhY2tpbmcgZmlsZXMNCj4gZXZlcnl3aGVyZSBpbnN0ZWFkIG9mIHRyZWF0aW5nIHRoZW0g
bGlrZSBjaGlsZHJlbiBsaWtlIGFueSBvdGhlci4NCg0KQnV0IHdlIG5lZWQgdG8gc3BlY2lhbC1j
YXNlIHRoZW0sIGFzIHdlIGhhdmUgaW50ZXJmYWNlcyBvcGVyYXRpbmcgb24gYmFja2luZyBjaGFp
biwNCg0KPiBiZHJ2X2NvX2Jsb2NrX3N0YXR1c19hYm92ZSgpIHByb2JhYmx5IHNob3VsZG4ndCBy
ZWN1cnNlIGFsb25nIHRoZQ0KPiBiYWNraW5nIGNoYWluLCBidXQgYWxvbmcgdGhlIHJldHVybmVk
ICpmaWxlIHBvaW50ZXJzLCBhbmQgY29uc2lkZXIgdGhlDQo+IHJldHVybmVkIG9mZnNldCBpbiAq
bWFwLg0KPiANCg0KU28sIHlvdSBtZWFuIHRoYXQgaW4gY2FzZSBvZiB1bmFsbG9jYXRlZCwgZm9y
bWF0IGxheWVyIHNob3VsZCByZXR1cm4gaXQncyBiYWNraW5nIGZpbGUgYXMgZmlsZT8NClRoZW4s
IG1heWJlIGJkcnZfY29fYmxvY2tfc3RhdHVzIHNob3VsZCBub3QgcmVjdXJzZSBhdCBhbGw/DQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

