Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D412C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C532086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OCXzDCeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C532086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubJG-0002Gd-JP
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hubIq-0001kd-AC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hubIp-0007ZY-5M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:37:24 -0400
Received: from mail-eopbgr10092.outbound.protection.outlook.com
 ([40.107.1.92]:37766 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hubIo-0007YF-DF; Mon, 05 Aug 2019 07:37:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4VotNTPUmtQKLDKNyzHfUb8l+KlxuN7Bv+5T1o76Mo4+XrFpJ2+XIKRisR+xSpJgsqy2SKKd5iOIFlEX+Gll3XdkmIgu87lhFLghfhvhmnrtp8FExjSpmNxuC12JkIR1f0W5+EDeI8U1T/CA/zUYiEvSe7CMDBRlbYCqpXC2L29vZfhAreqfbQYnHOyR/7jrF4yJ1k5WbXh4dLF0QXCH/KropKXNeY0EkltDAs8tWd7IrCGfuQq35f616lO6pvjxaGYKs/WHjzNJzJr+NNeS1A15g5NeYWDNS3VFYzMYcSxZtSagdIcdElfotxpdRJ5MV/H3gFFEFRg5g3sfDLHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk1RFBqyE69H/GbIf2WL9742tbjC0aVHPETQRaJ4bA0=;
 b=FOBi/nFkp8qLKCpmcneUrw64oIlySaz3CAiZ0BIx4PYZqxbkec0OFOA+x1uYw75rhDxPiZk/wUVvP55L6HWvDbc1SPz7djwAlovGixU6rolm7mfbAZ/seE4HQV0ja5RfpuPnEXvhsCHphmIfrObeannSNyn5monFdVz4eBpKs8J0KTHE0rXFkOffwLSLVot5xteLfOlo/ioRqZ8ClBFQRIEHzIbi+W2RQefFwwtO8hWWhiqWzQ1GsuuvuSEbv+W3/IN5bzxNV5kpTmm2QWMI64J+xFmfCDv0l4yI2yjKDSLVcOSk4wncxl5UTPF3ry0C1p85krLZQ5ZDECzEEWvpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk1RFBqyE69H/GbIf2WL9742tbjC0aVHPETQRaJ4bA0=;
 b=OCXzDCebKu1ikuqJwtNWhGY4cUSeyR2INhr4sVrnmbnRmCF+EHDwytGHfW7FKo3xTmAvMzRQCbR8LhdnY7LH9AiQkeuPchccI1HoVxrkV2MsdQRAg0svdFbLwYB5McGWiVkZo6yVx+jKmAeOdaTJEhbf3ESqBskeTtI+Mr7qG2E=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5355.eurprd08.prod.outlook.com (52.133.240.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 11:37:18 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 11:37:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoabscC8AgAABSoA=
Date: Mon, 5 Aug 2019 11:37:18 +0000
Message-ID: <59db58e9-7c27-87cd-41c4-446433237236@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <e97ff375-6527-8701-2ee5-bf5bb4e1a9bf@redhat.com>
In-Reply-To: <e97ff375-6527-8701-2ee5-bf5bb4e1a9bf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805143715873
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 505bc437-814b-4dc1-1e8d-08d719994539
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5355; 
x-ms-traffictypediagnostic: DB8PR08MB5355:
x-microsoft-antispam-prvs: <DB8PR08MB53553FE4F1597DAEC3008EE1C1DA0@DB8PR08MB5355.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(136003)(39840400004)(366004)(51444003)(199004)(189003)(53754006)(446003)(14444005)(81156014)(26005)(54906003)(6512007)(186003)(66476007)(66556008)(64756008)(8936002)(66946007)(71200400001)(71190400001)(31696002)(25786009)(6486002)(14454004)(5660300002)(305945005)(6436002)(7736002)(81166006)(99286004)(107886003)(6246003)(256004)(110136005)(229853002)(86362001)(478600001)(8676002)(53546011)(2501003)(66066001)(66446008)(3846002)(316002)(76176011)(2906002)(53936002)(6116002)(486006)(68736007)(11346002)(102836004)(386003)(4326008)(2616005)(52116002)(6506007)(36756003)(31686004)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5355;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HBlLmrOJu5axxPucbw4rrGOycR7qMFKVZ1DYZY9lWrr8sGHo+gsfJu0OpXC0/0l30rwTBBo4OUM1Fe04mM0WToDTbOHW26VyVmvOpnO8JOpb54RQvIxOPrd31iAYirTY8fwofcTeHRVRBaFD0+xa9S4QLY9v2EwP7LG7u6gh1BnchxbWAZcppqG0Sq5uzB9cP1M6SYPTgeVOJ2VWmHpFFzfNtnc04tjuiPKYdoWvfX7i5QjXVgXH5DCYF2bQv4LxSmanbSvPL1wkBIWtstDnEKq+9he/RqHb2FRDO0SacqQmIejgz+8FW/5jPazuTB+xsb5cpSWX18je9kBRrELt8ZGH8xX3u0X7vQmvZiGAmsNvUvWeY7UD39TD4kL/Q5eXccpcAVJd6q6XaSuGNhHfxzF5YII6a3AzgEwSjqbpYjI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C05552FE82840428CD458EBC68E8F2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505bc437-814b-4dc1-1e8d-08d719994539
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 11:37:18.0498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5355
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.92
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxNDozMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMi4wOC4xOSAyMDo1OCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGhiaXRtYXBfcmVzZXQgaXMg
YnJva2VuOiBpdCByb3VuZHMgdXAgdGhlIHJlcXVlc3RlZCByZWdpb24uIEl0IGxlYWRzIHRvDQo+
PiB0aGUgZm9sbG93aW5nIGJ1Zywgd2hpY2ggaXMgc2hvd24gYnkgZml4ZWQgdGVzdDoNCj4+DQo+
PiBhc3N1bWUgZ3JhbnVsYXJpdHkgPSAyDQo+PiBzZXQoMCwgMykgIyBjb3VudCBiZWNvbWVzIDQN
Cj4+IHJlc2V0KDAsIDEpICMgY291bnQgYmVjb21lcyAyDQo+Pg0KPj4gQnV0IHVzZXIgb2YgdGhl
IGludGVyZmFjZSBhc3N1bWUgdGhhdCB2aXJ0dWFsIGJpdCAxIHNob3VsZCBiZSBzdGlsbA0KPj4g
ZGlydHksIHNvIGhiaXRtYXAgc2hvdWxkIHJlcG9ydCBjb3VudCB0byBiZSA0IQ0KPj4NCj4+IElu
IG90aGVyIHdvcmRzLCBiZWNhdXNlIG9mIGdyYW51bGFyaXR5LCB3aGVuIHdlIHNldCBvbmUgInZp
cnR1YWwiIGJpdCwNCj4+IHllcywgd2UgbWFrZSBhbGwgInZpcnR1YWwiIGJpdHMgaW4gc2FtZSBj
aHVuayB0byBiZSBkaXJ0eS4gQnV0IHRoaXMNCj4+IHNob3VsZCBub3QgYmUgc28gZm9yIHJlc2V0
Lg0KPj4NCj4+IEZpeCB0aGlzLCBhbGlnbmluZyBib3VuZCBjb3JyZWN0bHkuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KPj4gLS0tDQo+Pg0KPj4gSGkgYWxsIQ0KPj4NCj4+IEhtbSwgaXMgaXQgYSBi
dWcgb3IgZmVhdHVyZT8gOikNCj4+IEkgZG9uJ3QgaGF2ZSBhIHRlc3QgZm9yIG1pcnJvciB5ZXQs
IGJ1dCBJIHRoaW5rIHRoYXQgc3luYyBtaXJyb3IgbWF5IGJlIGJyb2tlbg0KPj4gYmVjYXVzZSBv
ZiB0aGlzLCBhcyBkb19zeW5jX3RhcmdldF93cml0ZSgpIHNlZW1zIHRvIGJlIHVzaW5nIHVuYWxp
Z25lZCByZXNldC4NCj4+DQo+PiAgIHRlc3RzL3Rlc3QtaGJpdG1hcC5jIHwgIDIgKy0NCj4+ICAg
dXRpbC9oYml0bWFwLmMgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS90ZXN0cy90ZXN0LWhiaXRtYXAuYyBiL3Rlc3RzL3Rlc3QtaGJpdG1hcC5j
DQo+PiBpbmRleCA1OTJkODIxOWRiLi4wMDA4MDI1YTlmIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMv
dGVzdC1oYml0bWFwLmMNCj4+ICsrKyBiL3Rlc3RzL3Rlc3QtaGJpdG1hcC5jDQo+PiBAQCAtNDI0
LDcgKzQyNCw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfaGJpdG1hcF9ncmFudWxhcml0eShUZXN0SEJp
dG1hcERhdGEgKmRhdGEsDQo+PiAgICAgICBoYml0bWFwX3Rlc3Rfc2V0KGRhdGEsIDAsIDMpOw0K
Pj4gICAgICAgZ19hc3NlcnRfY21waW50KGhiaXRtYXBfY291bnQoZGF0YS0+aGIpLCA9PSwgNCk7
DQo+PiAgICAgICBoYml0bWFwX3Rlc3RfcmVzZXQoZGF0YSwgMCwgMSk7DQo+PiAtICAgIGdfYXNz
ZXJ0X2NtcGludChoYml0bWFwX2NvdW50KGRhdGEtPmhiKSwgPT0sIDIpOw0KPj4gKyAgICBnX2Fz
c2VydF9jbXBpbnQoaGJpdG1hcF9jb3VudChkYXRhLT5oYiksID09LCA0KTsNCj4+ICAgfQ0KPj4g
ICANCj4+ICAgc3RhdGljIHZvaWQgdGVzdF9oYml0bWFwX2l0ZXJfZ3JhbnVsYXJpdHkoVGVzdEhC
aXRtYXBEYXRhICpkYXRhLA0KPj4gZGlmZiAtLWdpdCBhL3V0aWwvaGJpdG1hcC5jIGIvdXRpbC9o
Yml0bWFwLmMNCj4+IGluZGV4IDc5MDUyMTJhOGIuLjYxYTgxMzk5NGEgMTAwNjQ0DQo+PiAtLS0g
YS91dGlsL2hiaXRtYXAuYw0KPj4gKysrIGIvdXRpbC9oYml0bWFwLmMNCj4+IEBAIC00NzMsMTUg
KzQ3MywyOSBAQCB2b2lkIGhiaXRtYXBfcmVzZXQoSEJpdG1hcCAqaGIsIHVpbnQ2NF90IHN0YXJ0
LCB1aW50NjRfdCBjb3VudCkNCj4+ICAgew0KPj4gICAgICAgLyogQ29tcHV0ZSByYW5nZSBpbiB0
aGUgbGFzdCBsYXllci4gICovDQo+PiAgICAgICB1aW50NjRfdCBmaXJzdDsNCj4+IC0gICAgdWlu
dDY0X3QgbGFzdCA9IHN0YXJ0ICsgY291bnQgLSAxOw0KPj4gKyAgICB1aW50NjRfdCBsYXN0Ow0K
Pj4gKyAgICB1aW50NjRfdCBlbmQgPSBzdGFydCArIGNvdW50Ow0KPj4gKyAgICB1aW50NjRfdCBn
cmFuID0gVUlOVDY0X0MoMSkgPDwgaGItPmdyYW51bGFyaXR5Ow0KPj4gICANCj4+IC0gICAgdHJh
Y2VfaGJpdG1hcF9yZXNldChoYiwgc3RhcnQsIGNvdW50LA0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgIHN0YXJ0ID4+IGhiLT5ncmFudWxhcml0eSwgbGFzdCA+PiBoYi0+Z3JhbnVsYXJpdHkp
Ow0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBXZSBzaG91bGQgY2xlYXIgb25seSBiaXRzLCBmdWxs
eSBjb3ZlcmVkIGJ5IHJlcXVlc3RlZCByZWdpb24uIE90aGVyd2lzZQ0KPj4gKyAgICAgKiB3ZSBt
YXkgY2xlYXIgc29tZXRoaW5nIHRoYXQgaXMgYWN0dWFsbHkgc3RpbGwgZGlydHkuDQo+PiArICAg
ICAqLw0KPj4gKyAgICBmaXJzdCA9IERJVl9ST1VORF9VUChzdGFydCwgZ3Jhbik7DQo+PiAgIA0K
Pj4gLSAgICBmaXJzdCA9IHN0YXJ0ID4+IGhiLT5ncmFudWxhcml0eTsNCj4+IC0gICAgbGFzdCA+
Pj0gaGItPmdyYW51bGFyaXR5Ow0KPj4gKyAgICBpZiAoZW5kID09IGhiLT5vcmlnX3NpemUpIHsN
Cj4gDQo+IFRoaXMgc2hvdWxkIGJlIOKAnD494oCdLg0KPiANCj4gVGhlcmUgYXJlIGNhbGxlcnMg
dGhhdCBkb27igJl0IG1ha2Ugc3VyZSB0aGF0IHN0YXJ0ICsgY291bnQgPD0NCj4gaGItPm9yaWdf
c2l6ZSAoZS5nLiB0aGUgYmFja3VwIGpvYiBqdXN0IGNhbGxzIGl0IHdpdGggbXVsdGlwbGVzIG9m
DQo+IGNsdXN0ZXJfc2l6ZSwgd2hpY2ggbWF5IG9yIG1heSBub3QgZW5kIHVwIGF0IHRoZSBpbWFn
ZSBlbmQ7IGFuZA0KPiBoYml0bWFwX3RydW5jYXRlKCkganVzdCB1c2VzIOKAnGhiLT5zaXplIDw8
IGhiLT5ncmFudWxhcml0eeKAnSBhcyB0aGUgZW5kLA0KPiB3aGljaCBpcyBhcmd1YWJseSBub3Qg
aWRlYWwsIGJ1dCB0aGF04oCZcyBob3cgaXQgaXMpLg0KPiANCg0KQWgsIHllcywgeW91IGFyZSBy
aWdodC4gT3JpZ2luYWxseSwgSSBoYWQgYW5kIGFzc2VydGlvbiB0aGF0IGVuZCA8PSBoYi0+b3Jp
Z19zaXplLA0KYnV0IGl0IGZhaWxlZCB3aXRoIHRlc3QgYmVjYXVzZSBvZiB0aGVzZSBjYXNlcy4g
SSBkcm9wcGVkIGl0IGFuZCBmb3Jnb3QgdG8gdXBkYXRlDQp0aGUgY29uZGl0aW9uLiBPZ2gsIHRo
aXMgaXMgaG93IHN1Y2ggc21hbGwgaHVnZSBidWdzIGFyZSBhcHBlYXJpbmcuLg0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

