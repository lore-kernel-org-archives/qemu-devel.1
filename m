Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD7C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693AD208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U/2I5w6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693AD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huzpC-0007TN-OE
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huzon-00070I-1h
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huzol-0006mw-QG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:48:00 -0400
Received: from mail-eopbgr140091.outbound.protection.outlook.com
 ([40.107.14.91]:12399 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huzol-0006mX-39; Tue, 06 Aug 2019 09:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6d09I7vJRJR5IQtV4xy+h4Iv1wbYfN+DXKi47nD9Bc7waZ2CCkpDzcvN32nZd817oO67sZP2JTA9fisbrf5hfcTQGpo3K7UjvK+UEMqJ6EGPx0GLaMqTknv7I0m6kD4bSe0YM/Unc4uFVzS8O5DDpGGX3v75qlBEkDXfYCgTAqjQISbcXOrqacWK24IGTbQ3wZ2I2uN0ZUmMUF2Cgfr0CFU/E0dreVp6mSGY3WnGVbAb/tijj37Q7PObxkU/dqkfx8BxHfr/kJ2EWJL6ceBOg97iciMHlEaDBSuk+roNAMQZ+kOD/4zXUnzZZiNji+XRQv8hpiOV8YvBaVKAbvyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL638vvmfVTP41R1nWA/qqP0X1pi1SAlDQdJYdxuf4U=;
 b=ZjupOhYyLleTk3UwiwOW8G+X6SEoaDplmCo3xBgJfyFvYRTb0HyOYN3jdOgQt5vYOBokSA6yKmBYShZ2v2tBWOmAGxOoHxb7CzgGbcbb5QPyGN10IN3eOGEpPyULms5o3E1C3hTQ5MJH9051yqOsI60g6VY2mjo1/Um6r+jZE2sCtxTweqrIEKJgj/QDhUAhQ764WNiDhy1lE51dF5uKm0WFILQT5ocD7VROs8zzYgfA4EBYwF+FgdVG+IXX9DJFhGFi4kHFNEiZxJz/LNP4JgGJ/RpNllM0Fv4iN0QLv4HjhQocC9iH67B3hKqMLFIYRi+cVaEQduWDXSOxqifuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL638vvmfVTP41R1nWA/qqP0X1pi1SAlDQdJYdxuf4U=;
 b=U/2I5w6EER5OUGDgSyvFyOP8w/LVvJNxWH6MmE7eb47bxvwfG723afx/P6whMiNGGPK48P2olRugWlgfiJbmpguNiKyeJ3G4GyoTEcQbGNHXjxOxp1ceSkF4StoagbOl7Un657llmh2hdPWDCIaxm6KQrCcSgXxPYO99UU/GAG8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5356.eurprd08.prod.outlook.com (52.133.240.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 13:47:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 13:47:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoaboXTQAgAXqVID//9vIgIAABP2A
Date: Tue, 6 Aug 2019 13:47:55 +0000
Message-ID: <7248f24d-4c5e-a06a-70a9-0650b26e00bc@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <a7b3d467-e3c4-3559-fa73-7f4572202b5e@virtuozzo.com>
 <6c6fe98e-1be5-32f4-abf0-7ddcc4838412@redhat.com>
In-Reply-To: <6c6fe98e-1be5-32f4-abf0-7ddcc4838412@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0025.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::35) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190806164753147
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2cadf5-b7aa-49d3-5600-08d71a74af72
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5356; 
x-ms-traffictypediagnostic: DB8PR08MB5356:
x-microsoft-antispam-prvs: <DB8PR08MB5356A9B5996B4E8113E67872C1D50@DB8PR08MB5356.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(53754006)(51444003)(189003)(199004)(6246003)(446003)(81166006)(107886003)(305945005)(11346002)(71190400001)(71200400001)(6506007)(2501003)(86362001)(7736002)(2906002)(476003)(26005)(256004)(53546011)(102836004)(2616005)(31696002)(36756003)(52116002)(186003)(486006)(54906003)(76176011)(316002)(386003)(110136005)(99286004)(3846002)(6116002)(31686004)(8676002)(229853002)(4326008)(25786009)(66066001)(6436002)(5660300002)(66476007)(66556008)(6512007)(14454004)(6486002)(478600001)(8936002)(66946007)(81156014)(53936002)(68736007)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5356;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XtwmZcO3fb9Jz8SYwMTbsC+f+dS11aVJzbX4QqvrA5E1GJDuXykKleCK3/HXMuJ5E8S8u6c3RmF33kip9V8BLWHhmVB8LZmhaS+STlC3MD0hjIecoLFrejWUzC1aHZYvGasKYP7bM3saC47WR1o1NuPEdFwkD3LuiWXLrfzwpr6K9tlctTKIeTKY/RUZmWHfSetxnPurFRCjZ32TMN2aQkzAhNzkB91e6DDWRUdyoDtbRyh2cTGsU2sf2bg2vvG5Z1vQhuV72t7jWYhuMtTgVptaL4/VjaCnCOUoGtmewittDD1OnbgBXqJ7/kNcHO4zKjGUze1Rxy7qvrVcf8Y+q+odleY2Fnf7lojzhmSSzJUOuTTSVL0U0IywTA0QQPYC60c1bn0JuU6MvGeSwmzIjNSHDTUD+5LWxYVh595WG3Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA54C368220E844CB10011526581A785@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2cadf5-b7aa-49d3-5600-08d71a74af72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 13:47:55.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5356
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.91
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDguMjAxOSAxNjozMCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvNi8xOSA4
OjM5IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDMuMDguMjAx
OSAwOjE5LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gT24gMDIuMDguMTkgMjA6NTgsIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IGhiaXRtYXBfcmVzZXQgaXMgYnJva2Vu
OiBpdCByb3VuZHMgdXAgdGhlIHJlcXVlc3RlZCByZWdpb24uIEl0IGxlYWRzIHRvDQo+Pj4+IHRo
ZSBmb2xsb3dpbmcgYnVnLCB3aGljaCBpcyBzaG93biBieSBmaXhlZCB0ZXN0Og0KPj4+Pg0KPj4+
PiBhc3N1bWUgZ3JhbnVsYXJpdHkgPSAyDQo+Pj4+IHNldCgwLCAzKSAjIGNvdW50IGJlY29tZXMg
NA0KPj4+PiByZXNldCgwLCAxKSAjIGNvdW50IGJlY29tZXMgMg0KPj4+Pg0KPj4+PiBCdXQgdXNl
ciBvZiB0aGUgaW50ZXJmYWNlIGFzc3VtZSB0aGF0IHZpcnR1YWwgYml0IDEgc2hvdWxkIGJlIHN0
aWxsDQo+Pj4+IGRpcnR5LCBzbyBoYml0bWFwIHNob3VsZCByZXBvcnQgY291bnQgdG8gYmUgNCEN
Cj4+Pj4NCj4+Pj4gSW4gb3RoZXIgd29yZHMsIGJlY2F1c2Ugb2YgZ3JhbnVsYXJpdHksIHdoZW4g
d2Ugc2V0IG9uZSAidmlydHVhbCIgYml0LA0KPj4+PiB5ZXMsIHdlIG1ha2UgYWxsICJ2aXJ0dWFs
IiBiaXRzIGluIHNhbWUgY2h1bmsgdG8gYmUgZGlydHkuIEJ1dCB0aGlzDQo+Pj4+IHNob3VsZCBu
b3QgYmUgc28gZm9yIHJlc2V0Lg0KPj4+Pg0KPj4+PiBGaXggdGhpcywgYWxpZ25pbmcgYm91bmQg
Y29ycmVjdGx5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+Pg0KPj4+
PiBIaSBhbGwhDQo+Pj4+DQo+Pj4+IEhtbSwgaXMgaXQgYSBidWcgb3IgZmVhdHVyZT8gOikNCj4+
Pj4gSSBkb24ndCBoYXZlIGEgdGVzdCBmb3IgbWlycm9yIHlldCwgYnV0IEkgdGhpbmsgdGhhdCBz
eW5jIG1pcnJvciBtYXkgYmUgYnJva2VuDQo+Pj4+IGJlY2F1c2Ugb2YgdGhpcywgYXMgZG9fc3lu
Y190YXJnZXRfd3JpdGUoKSBzZWVtcyB0byBiZSB1c2luZyB1bmFsaWduZWQgcmVzZXQuDQo+Pj4N
Cj4+PiBDcmFwLg0KPj4+DQo+Pj4NCj4+PiBZZXMsIHlvdeKAmXJlIHJpZ2h0LiAgVGhpcyB3b3Vs
ZCBmaXggaXQsIGFuZCBpdCB3b3VsZG7igJl0IGZpeCBpdCBpbiB0aGUNCj4+PiB3b3JzdCB3YXku
DQo+Pj4NCj4+PiBCdXQgSSBkb27igJl0IGtub3cgd2hldGhlciB0aGlzIHBhdGNoIGlzIHRoZSBi
ZXN0IHdheSBmb3J3YXJkIHN0aWxsLiAgSQ0KPj4+IHRoaW5rIGNhbGwgaGJpdG1hcF9yZXNldCgp
IHdpdGggdW5hbGlnbmVkIGJvdW5kYXJpZXMgZ2VuZXJhbGx5IGNhbGxzIGZvcg0KPj4+IHRyb3Vi
bGUsIGFzIEpvaG4gaGFzIGxhaWQgb3V0LiAgSWYgbWlycm9y4oCZcyBkb19zeW5jX3RhcmdldF93
cml0ZSgpIGlzDQo+Pj4gdGhlIG9ubHkgb2ZmZW5kZXIgcmlnaHQgbm93LA0KPj4NCj4+IEFub3Ro
ZXIgdGhpbmcgaXMgbWlncmF0aW9uL2Jsb2NrLiBTaG91bGQgd2UgY2FyZSBvZiBpdCwgaXMgaXQg
c3VwcG9ydGVkIGF0IGFsbD8NCj4+DQo+IA0KPiBEb3duc3RyZWFtIHByb2R1Y3RzIGFsd2F5cyBo
YXZlIHRpbWUgYW5kIHJvb20gdG8gZ2V0IGFkZGl0aW9uYWwgZml4ZXM7IEkNCj4gdGhpbmsgdGhp
cyBpcyBzdXBwb3J0ZWQgZnJvbSBhbiB1cHN0cmVhbSBQT1Ygc28gd2Ugc2hvdWxkIGludmVzdGln
YXRlIHRoaXMuDQo+IA0KPiBJIGFzc3VtZSBtaWdyYXRpb24vYmxvY2sgaGFzIHRoZSBzYW1lIHBy
b2JsZW0gdGhhdCBpdCBmdWxseSBjbGVhcnMNCj4gdW5hbGlnbmVkIGJsb2Nrcz8NCj4gDQoNCg0K
SG1tLCBhZnRlciBjbG9zZXIgbG9vaywgaXQgc2VlbXMgbGlrZSBpdCdzIE9LLiBJdCBqdXN0IGEg
Yml0IG1vcmUgZGlmZmljdWx0IHRvDQpzZWUgdGhhbiBpbiBvdGhlciBwbGFjZXMgd2l0aCByZXNl
dC4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

