Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BCFC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5DD2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MJJcOxez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DD2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0xF-0003iu-VD
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw0wa-0002mc-84
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw0wY-0006jp-BM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:12:16 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com
 ([40.107.1.118]:21606 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw0wV-0006hf-WE; Fri, 09 Aug 2019 05:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLeZQNeGt/wTx8mlDMEo1yoJY2BOrsoDNaaL9jL9NxdL21H3beFpVVMZ708VERhWJOuTXrXkx5AFpfZwjEs1q/uv5KPb3Z6V5b6wsmJW9jOd+p8YECMUbAnucQucjOZshj6y0FpS/uH51HKKkDEM+6kTrhefsslV2Lm73JW8uFEDSfCv+xW53/Z4uNQ46msd8iBb2EDnq6iM/SIv63GTAybBcFy+ujRh4JrTHsgVYcvMYENGR7uRawjt/RhYIArQOUqE0OCkgoA2qQkAJueIWlL830hzmKuU1ZzMYhBvyIm+vT60qc/QKK4z5OxEssgshzt/ZIS3hTCcBB7rLT4rrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf00erUvVSVhO75uFB19xWxXwhs4LCjYZ8Er/tyqKOU=;
 b=X7dguEKV9iMfTzSWWAslxdPbg7WdtTUJRHqFM5U1p1qq573uWr3oFv1el6v3P2uGuG0SpjCfApi5qf5VRYHimbdxYHF1pygXP/uc0APtPbwtyjuG86Z6XOb4SDnk5QrZDTZ1Lq6SujkkWNF1Lv6rAVzG9Xfklgi8/dV5086tnHg4+xYDz2CCUm4QnbH3gQnABBWTdDj7naINxIlV1NDEQj7dHgqklwko2piSwhoxg4qhup9jX4PQB2sm/YhlrAfmTkKQo+16i4QJds/1pSVJpNj2UhBxl8l7aQlyqRCc54p5qIxQdfIppWKWcC1TKBvgnQzhommzREWziA3/ky3sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf00erUvVSVhO75uFB19xWxXwhs4LCjYZ8Er/tyqKOU=;
 b=MJJcOxezIqmRwZcl/3NGNQGAbqF+bg42lQi4ewOgo+QQdAaLWOFY1HAgfxKvSbaYF0LurST4UMCPtutoAy4TDJ8ZVG+E+4yVVh3iMRLAv1u2YEL+64cStxmyfsbxXpGFdSLwzOtzTPrizbJNikSEsgFmiQWG9Do0ZxZNY+J/cD0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5113.eurprd08.prod.outlook.com (10.255.16.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 09:12:08 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 09:12:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 4/8] block/backup: improve unallocated clusters skipping
Thread-Index: AQHVTPc5s/npQfEhfkGoVKrBP/0JC6bv+juAgAKsOgD//+SigA==
Date: Fri, 9 Aug 2019 09:12:08 +0000
Message-ID: <5413f403-e83e-207d-fef0-61a2908d397a@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
In-Reply-To: <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809121205076
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20945d67-878d-435a-5659-08d71ca9a799
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5113; 
x-ms-traffictypediagnostic: DB8PR08MB5113:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB511384E87DD2B3A23F2D3449C1D60@DB8PR08MB5113.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39850400004)(478684002)(189003)(199004)(36756003)(316002)(110136005)(305945005)(186003)(11346002)(446003)(256004)(8676002)(14444005)(66066001)(7736002)(2616005)(476003)(66476007)(66446008)(66556008)(26005)(2501003)(64756008)(99286004)(66946007)(76176011)(52116002)(102836004)(386003)(6506007)(6116002)(53546011)(54906003)(71200400001)(71190400001)(486006)(3846002)(31686004)(81156014)(6436002)(25786009)(8936002)(6512007)(2906002)(86362001)(81166006)(478600001)(31696002)(4326008)(5660300002)(6486002)(107886003)(229853002)(6246003)(53936002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5113;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ihFm72xDz38nZQ6y+DAkYy/eIoTrQqOoKvi4Sqrxv4S9oBgJzh06EHd3tO78oIljkoM1OoBTm9wzWMBmlEaJHXBK7vHKVGohRVsFQcjt/qDqs8cWN2/trREBLTeXia4J+aVTvCBgFcVtyo1q2/8gc9bAFg5uhamgFc6uEuKcGa89wWXFHTwq1LNFqyFFgD+0OZqd9PjU1KFjIZXKSis9b2d+4e7baZyY5lC3YwwECwcAkOxyFooma7kbx8it67aN9oh17/xu0LdcKBHOTjfCiAsuYmBTZQlWDNLNVq46dgG0XTOPYAFRp/NXUBWQu3dylhPSUsn559qtA1fSUfXS/QNx9kWStYBItBnr0MJXw0zTjOxezSWBvhrgPFm+xLd/mzbnuvZbf/j+5wK5w8JfbdMvZXRt4/QoJldjznaWHcg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82CC5F0FB6915B4CBCFA7F9430D3ED56@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20945d67-878d-435a-5659-08d71ca9a799
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 09:12:08.5551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlcRRyT8Vske1zJe/umAZ1fp96bO+UE1UTCjxZCqDTLeX1YiagP0RkgaOh4mGAyGQGpD+RshH4zfx5+AXzKiLp40Dz+wYrhFGdLVRvSBqKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5113
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.118
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxMDo1MCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDcuMDguMjAxOSAyMTowMSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDcuMDguMTkgMTA6MDcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gTGltaXQgYmxvY2tfc3Rh
dHVzIHF1ZXJ5aW5nIHRvIHJlcXVlc3QgYm91bmRzIG9uIHdyaXRlIG5vdGlmaWVyIHRvDQo+Pj4g
YXZvaWQgZXh0cmEgc2Vla2luZy4NCj4+DQo+PiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB0aGlzIHJl
YXNvbmluZy7CoCBDaGVja2luZyB3aGV0aGVyIHNvbWV0aGluZyBpcw0KPj4gYWxsb2NhdGVkIGZv
ciBxY293MiBzaG91bGQganVzdCBtZWFuIGFuIEwyIGNhY2hlIGxvb2t1cC7CoCBXaGljaCB3ZSBo
YXZlDQo+PiB0byBkbyBhbnl3YXkgd2hlbiB3ZSB0cnkgdG8gY29weSBkYXRhIG9mZiB0aGUgc291
cmNlLg0KPiANCj4gQnV0IGZvciByYXcgaXQncyBzZWVraW5nLiBJIHRoaW5rIHdlIGp1c3Qgc2hv
dWxkbid0IGRvIGFueSB1bm5lY2Vzc2FyeSBvcGVyYXRpb25zDQo+IGluIGNvcHktYmVmb3JlLXdy
aXRlIGhhbmRsaW5nLiBTbyBpbnN0ZWFkIG9mIGNhbGxpbmcNCj4gYmxvY2tfc3RhdHVzKHJlcXVl
c3Rfc3RhcnQsIGRpc2tfZW5kKSBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNhbGwNCj4gYmxvY2tf
c3RhdHVzKHJlcXVlc3Rfc3RhcnQsIHJlcXVlc3RfZW5kKS4gQW5kIGl0IGlzIG1vcmUgYXBwbGlj
YWJsZSBmb3IgcmV1c2luZyB0aGlzDQo+IGNvZGUgdG9vLg0KPiANCj4+DQo+PiBJIGNvdWxkIHVu
ZGVyc3RhbmQgc2F5aW5nIHRoaXMgbWFrZXMgdGhlIGNvZGUgZWFzaWVyLCBidXQgSSBhY3R1YWxs
eQ0KPj4gZG9u4oCZdCB0aGluayBpdCBkb2VzLsKgIElmIHlvdSBpbXBsZW1lbnRlZCBjaGVja2lu
ZyB0aGUgYWxsb2NhdGlvbiBzdGF0dXMNCj4+IG9ubHkgZm9yIGFyZWFzIHdoZXJlIHRoZSBiaXRt
YXAgaXMgcmVzZXQgKHdoaWNoIEkgdGhpbmsgdGhpcyBwYXRjaA0KPj4gc2hvdWxkKSwgdGhlbiBp
dOKAmWQganVzdCBkdXBsaWNhdGUgdGhlIGV4aXN0aW5nIGxvb3AuDQo+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBibG9jay9iYWNrdXAuYyB8IDM4ICsrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jh
Y2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+PiBpbmRleCAxMWUyN2M4NDRkLi5hNGQzN2QyZDYy
IDEwMDY0NA0KPj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+Pj4gKysrIGIvYmxvY2svYmFja3Vw
LmMNCj4+DQo+PiBbLi4uXQ0KPj4NCj4+PiBAQCAtMjY3LDYgKzI2NywxOCBAQCBzdGF0aWMgaW50
IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY293KEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4gwqDC
oMKgwqDCoCB3YWl0X2Zvcl9vdmVybGFwcGluZ19yZXF1ZXN0cyhqb2IsIHN0YXJ0LCBlbmQpOw0K
Pj4+IMKgwqDCoMKgwqAgY293X3JlcXVlc3RfYmVnaW4oJmNvd19yZXF1ZXN0LCBqb2IsIHN0YXJ0
LCBlbmQpOw0KPj4+ICvCoMKgwqAgaWYgKGpvYi0+aW5pdGlhbGl6aW5nX2JpdG1hcCkgew0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IG9mZiwgY2h1bms7DQo+Pj4gKw0KPj4+ICvCoMKgwqDC
oMKgwqDCoCBmb3IgKG9mZiA9IG9mZnNldDsgb2Zmc2V0IDwgZW5kOyBvZmZzZXQgKz0gY2h1bmsp
IHsNCj4+DQo+PiBUaGlzIGlzIHdoYXQgSeKAmW0gcmVmZXJyaW5nIHRvLCBJIHRoaW5rIHRoaXMg
bG9vcCBzaG91bGQgc2tpcCBhcmVhcyB0aGF0DQo+PiBhcmUgY2xlYW4uDQo+IA0KPiBBZ3JlZSwg
d2lsbCBkby4NCg0KSG1tLCBJIHJlbWVtYmVyZWQgdGhhdCBJIHRob3VnaHQgb2YgaXQsIGJ1dCBk
ZWNpZGVkIHRoYXQgaXQgbWF5IGJlIG5vdCBlZmZpY2llbnQgaWYNCmJpdG1hcCBmcmFnbWVudGF0
aW9uIGlzIGhpZ2hlciB0aGFuIGJsb2NrLXN0YXR1cyBmcmFnbWVudGF0aW9uLiBTbywgaWYgd2Ug
ZG9uJ3Qga25vdw0Kd2hhdCBpcyBiZXR0ZXIsIGxldCdzIGtlZXAgc2ltcGxlciBjb2RlLg0KDQo+
IA0KPj4NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiYWNrdXBfYml0bWFwX3Jl
c2V0X3VuYWxsb2NhdGVkKGpvYiwgb2ZmLCBlbmQgLSBvZmYsICZjaHVuayk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNodW5rID0gam9iLT5jbHVzdGVyX3NpemU7DQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoCB9DQo+Pj4g
K8KgwqDCoCByZXQgPSAwOw0KPj4+ICsNCj4+PiDCoMKgwqDCoMKgIHdoaWxlIChzdGFydCA8IGVu
ZCkgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IGRpcnR5X2VuZDsNCj4+PiBAQCAt
Mjc2LDE1ICsyODgsNiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY293KEJh
Y2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGlu
dWU7IC8qIGFscmVhZHkgY29waWVkICovDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiAt
wqDCoMKgwqDCoMKgwqAgaWYgKGpvYi0+aW5pdGlhbGl6aW5nX2JpdG1hcCkgew0KPj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGJhY2t1cF9iaXRtYXBfcmVzZXRfdW5hbGxvY2F0ZWQo
am9iLCBzdGFydCwgJnNraXBfYnl0ZXMpOw0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChyZXQgPT0gMCkgew0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2Vf
YmFja3VwX2RvX2Nvd19za2lwX3JhbmdlKGpvYiwgc3RhcnQsIHNraXBfYnl0ZXMpOw0KPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQgKz0gc2tpcF9ieXRlczsNCj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4+PiAtwqDCoMKgwqDCoMKgwqAgfQ0KPj4+IC0NCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZGlydHlfZW5kID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dF96ZXJvKGpvYi0+
Y29weV9iaXRtYXAsIHN0YXJ0LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVuZCAtIHN0YXJ0KTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRpcnR5
X2VuZCA8IDApIHsNCj4+DQo+PiBIbSwgeW91IHJlc29sdmVkIHRoYXQgY29uZmxpY3QgZGlmZmVy
ZW50bHkgZnJvbSBtZS4NCj4+DQo+PiBJIGRlY2lkZWQgdGhlIGJkcnZfZGlydHlfYml0bWFwX25l
eHRfemVybygpIGNhbGwgc2hvdWxkIGdvIGJlZm9yZSB0aGUNCj4+IGJhY2t1cF9iaXRtYXBfcmVz
ZXRfdW5hbGxvY2F0ZWQoKSBjYWxsIHNvIHRoYXQgd2UgY2FuIHRoZW4gZG8gYQ0KPj4NCj4+IMKg
wqAgZGlydHlfZW5kID0gTUlOKGRpcnR5X2VuZCwgc3RhcnQgKyBza2lwX2J5dGVzKTsNCj4+DQo+
PiBiZWNhdXNlIHdlIHByb2JhYmx5IGRvbuKAmXQgd2FudCB0byBjb3B5IGFueXRoaW5nIHBhc3Qg
d2hhdA0KPj4gYmFja3VwX2JpdG1hcF9yZXNldF91bmFsbG9jYXRlZCgpIGhhcyBpbnF1aXJlZC4N
Cj4+DQo+Pg0KPj4gQnV0IHRoZW4gYWdhaW4gdGhpcyBwYXRjaCBlbGltaW5hdGVzIHRoZSBkaWZm
ZXJlbmNlIGFueXdheS4uLg0KPj4gwqA+DQo+Pj4gQEAgLTU0Niw3ICs1NDksOCBAQCBzdGF0aWMg
aW50IGNvcm91dGluZV9mbiBiYWNrdXBfcnVuKEpvYiAqam9iLCBFcnJvciAqKmVycnApDQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0g
YmFja3VwX2JpdG1hcF9yZXNldF91bmFsbG9jYXRlZChzLCBvZmZzZXQsICZjb3VudCk7DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gYmFja3VwX2JpdG1hcF9yZXNldF91bmFsbG9j
YXRlZChzLCBvZmZzZXQsIHMtPmxlbiAtIG9mZnNldCwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNvdW50KTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+
Pg0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

