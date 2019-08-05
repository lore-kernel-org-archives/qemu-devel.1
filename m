Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7037C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D742086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IYKsSSOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D742086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZaC-0006Af-TO
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 05:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZZf-0005jw-5G
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZZd-0007Lv-Pk
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:46:38 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:55684 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huZZc-0007Ka-EQ; Mon, 05 Aug 2019 05:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz55Tu99/seS4LYNZN3frEDQ+iKZKjgPuT8W2ZsRo30YjsWhwu/DTwRHu92dDL1ud/93z5DsoHDxWUvqLYRnSVbfFJAPh0m35YDrqYhS6ecjKwqJSwbr0UIarXsTD3Kg2cyyPIUUwuyMH7jd0g+VaJq5FJLoyZ6hGry/o/Zd1/xsJFr8H9yU67x8R0apnkXhe38W84Bai7ZYR2bQF88TR1SaQFnLnkmHZJ78teMVxIygRiVuZRY+SSPFbJZkcqigtOzNl3jJ8NvAiQo5+cSVE1hpARh7EwpCO6LvxlTlkKscrNruJygW8l9sx1Q2FcFbwJgH9K3V7RC95FIUBYXhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHeVbds9qJVPhPzwsS+XBYnOYb3DrHJS+8Pss/YnJ4o=;
 b=gKHl2VBE2QQdm5vZwOEUXN0RH5tsu5Evr0/lYX0XPuoDQE7nijW15e3Fupmxa8vfgCVdfON1DsIOYNH3Snj7V3D1XPqoVdXVziUu26rvdzOwB/U6mtKXdRLzR0M5EVDSI5lwWWNGzTEx4r4YkZLpVrMGmw+o4acb6rJUlRv/8TTTsXdAU/lWEQ2rbflofrTV5UeNpUUNzlKPYzY2iQgtFkaFRCX2xtWuocqWT16/heV4/cKljqPX0sFilNhycwS74OVbgoGOFSf7wzyjDkbhhZwDu39wOfDok8ZU+Hn4MfgFqDjFn6LPOtFYLQrhX3OzS/iDiATZhI2dz3lJsyRGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHeVbds9qJVPhPzwsS+XBYnOYb3DrHJS+8Pss/YnJ4o=;
 b=IYKsSSOclW4lX4mjwZYnQSZH7luD/+FRUH6AirtSMj1bfmvHPDB2dcFUz9GTNsh2ucvJ7bWC2u48X4OnWmPnGkTdEEU66myOFtH5e6lkYHCQOsoWiJEg+mdSumP4btTVYR/JrVHRIb0CQhbKzETPFKkUf/37RKAS/Xxvig999Ds=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4124.eurprd08.prod.outlook.com (20.179.12.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 09:45:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 09:45:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoaboXTQAgAP1KQA=
Date: Mon, 5 Aug 2019 09:45:56 +0000
Message-ID: <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
In-Reply-To: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0040.eurprd09.prod.outlook.com
 (2603:10a6:7:15::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805124554625
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cac0827f-494d-4ddc-5bd2-08d71989b6e4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4124; 
x-ms-traffictypediagnostic: DB8PR08MB4124:
x-microsoft-antispam-prvs: <DB8PR08MB4124E3C27EB795F1BAF67837C1DA0@DB8PR08MB4124.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39840400004)(189003)(199004)(53754006)(51444003)(52314003)(110136005)(76176011)(316002)(6116002)(3846002)(8676002)(68736007)(6486002)(31686004)(386003)(6246003)(102836004)(53546011)(6436002)(86362001)(26005)(107886003)(71190400001)(2501003)(66066001)(71200400001)(54906003)(4326008)(229853002)(5660300002)(476003)(486006)(2616005)(446003)(7736002)(186003)(11346002)(36756003)(52116002)(256004)(14444005)(25786009)(6512007)(478600001)(305945005)(6506007)(99286004)(31696002)(81166006)(66446008)(64756008)(66556008)(66476007)(53936002)(66946007)(2906002)(8936002)(81156014)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4124;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eq3V2ohPNLr+X7Gck88X5b9/wN+Brp7USq6ct7obtL2LR2gcQVaAZqyvkdw39aB9H080WMCXc37/2vznydS2qxVCTA7WLMlp3a88ji76t1UoDNb4sqFCUpos9JBa1TOp42HtgcB+DQ5O8LFAtzlsbBrk5d6S/IPj09et3zr3UyND4D3wz/Cy8LyE7pdQIYJjWUejy7gy9KB2GXf/bIrVFp06PFDstx2O7dUOn/VsEukqPnZV4l4XRB5RMqr3TARe69pn3rZkIyad5WOjwbwi+FzFwPNZhIohluIJIYmkY1Fqw7qSJD7lm9XLtO9zxnqDphZcLVcc9jehSrULG9D295gKleeAV4LgfeOwkGRkDNa9qPBBvjU/Z0RDV3zEVOcipDYkuM42RKjkjDwsFcVX/whgJyx/t0LoLaUDkoPaze0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57E300D4879FEB48A594A0502A6047D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac0827f-494d-4ddc-5bd2-08d71989b6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:45:56.7578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4124
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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

MDMuMDguMjAxOSAwOjE5LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDAyLjA4LjE5IDIwOjU4LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gaGJpdG1hcF9yZXNldCBpcyBi
cm9rZW46IGl0IHJvdW5kcyB1cCB0aGUgcmVxdWVzdGVkIHJlZ2lvbi4gSXQgbGVhZHMgdG8NCj4+
IHRoZSBmb2xsb3dpbmcgYnVnLCB3aGljaCBpcyBzaG93biBieSBmaXhlZCB0ZXN0Og0KPj4NCj4+
IGFzc3VtZSBncmFudWxhcml0eSA9IDINCj4+IHNldCgwLCAzKSAjIGNvdW50IGJlY29tZXMgNA0K
Pj4gcmVzZXQoMCwgMSkgIyBjb3VudCBiZWNvbWVzIDINCj4+DQo+PiBCdXQgdXNlciBvZiB0aGUg
aW50ZXJmYWNlIGFzc3VtZSB0aGF0IHZpcnR1YWwgYml0IDEgc2hvdWxkIGJlIHN0aWxsDQo+PiBk
aXJ0eSwgc28gaGJpdG1hcCBzaG91bGQgcmVwb3J0IGNvdW50IHRvIGJlIDQhDQo+Pg0KPj4gSW4g
b3RoZXIgd29yZHMsIGJlY2F1c2Ugb2YgZ3JhbnVsYXJpdHksIHdoZW4gd2Ugc2V0IG9uZSAidmly
dHVhbCIgYml0LA0KPj4geWVzLCB3ZSBtYWtlIGFsbCAidmlydHVhbCIgYml0cyBpbiBzYW1lIGNo
dW5rIHRvIGJlIGRpcnR5LiBCdXQgdGhpcw0KPj4gc2hvdWxkIG5vdCBiZSBzbyBmb3IgcmVzZXQu
DQo+Pg0KPj4gRml4IHRoaXMsIGFsaWduaW5nIGJvdW5kIGNvcnJlY3RseS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBIaSBhbGwhDQo+Pg0KPj4gSG1tLCBpcyBpdCBhIGJ1
ZyBvciBmZWF0dXJlPyA6KQ0KPj4gSSBkb24ndCBoYXZlIGEgdGVzdCBmb3IgbWlycm9yIHlldCwg
YnV0IEkgdGhpbmsgdGhhdCBzeW5jIG1pcnJvciBtYXkgYmUgYnJva2VuDQo+PiBiZWNhdXNlIG9m
IHRoaXMsIGFzIGRvX3N5bmNfdGFyZ2V0X3dyaXRlKCkgc2VlbXMgdG8gYmUgdXNpbmcgdW5hbGln
bmVkIHJlc2V0Lg0KPiANCj4gQ3JhcC4NCj4gDQo+IA0KPiBZZXMsIHlvdeKAmXJlIHJpZ2h0LiAg
VGhpcyB3b3VsZCBmaXggaXQsIGFuZCBpdCB3b3VsZG7igJl0IGZpeCBpdCBpbiB0aGUNCj4gd29y
c3Qgd2F5Lg0KPiANCj4gQnV0IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhpcyBwYXRjaCBpcyB0
aGUgYmVzdCB3YXkgZm9yd2FyZCBzdGlsbC4gIEkNCj4gdGhpbmsgY2FsbCBoYml0bWFwX3Jlc2V0
KCkgd2l0aCB1bmFsaWduZWQgYm91bmRhcmllcyBnZW5lcmFsbHkgY2FsbHMgZm9yDQo+IHRyb3Vi
bGUsIGFzIEpvaG4gaGFzIGxhaWQgb3V0LiAgSWYgbWlycm9y4oCZcyBkb19zeW5jX3RhcmdldF93
cml0ZSgpIGlzDQo+IHRoZSBvbmx5IG9mZmVuZGVyIHJpZ2h0IG5vdywgSeKAmWQgcHJlZmVyIGZv
ciBoYml0bWFwX3Jlc2V0KCkgdG8gYXNzZXJ0DQo+IHRoYXQgdGhlIGJvdW5kYXJpZXMgYXJlIGFs
aWduZWQgKGZvciA0LjIpLA0KDQpPSywgYWdyZWUgdGhhdCBhc3NlcnRpbmcgdGhpcyBpcyBiZXR0
ZXIuDQoNCiAgYW5kIGZvcg0KPiBkb19zeW5jX3RhcmdldF93cml0ZSgpIHRvIGJlIGZpeGVkIChm
b3IgNC4xPyA6LS8pLg0KPiANCj4gKEEgcHJhY3RpY2FsIHByb2JsZW0gd2l0aCB0aGlzIHBhdGNo
IGlzIHRoYXQgZG9fc3luY190YXJnZXRfd3JpdGUoKSB3aWxsDQo+IHN0aWxsIGRvIHRoZSB3cml0
ZSwgYnV0IGl0IHdvbuKAmXQgY2hhbmdlIGFueXRoaW5nIGluIHRoZSBiaXRtYXAsIHNvIHRoZQ0K
PiBjb3B5IG9wZXJhdGlvbiB3YXMgZWZmZWN0aXZlbHkgdXNlbGVzcy4pDQo+IA0KPiBJIGRvbuKA
mXQga25vdyBob3cgdG8gZml4IG1pcnJvciBleGFjdGx5LCB0aG91Z2guICBJIGhhdmUgZm91ciBp
ZGVhczoNCj4gDQo+IChBKSBRdWljayBmaXggMTogZG9fc3luY190YXJnZXRfd3JpdGUoKSBzaG91
bGQgc2hyaW5rIFtvZmZzZXQsIG9mZnNldCArDQo+IGJ5dGVzKSBzdWNoIHRoYXQgaXQgaXMgYWxp
Z25lZC4gIFRoaXMgd291bGQgbWFrZSBpdCBza2lwIHdyaXRlcyB0aGF0DQo+IGRvbuKAmXQgZmls
bCBvbmUgd2hvbGUgY2h1bmsuDQo+IA0KPiArOiBTaW1wbGUgZml4LiAgQ291bGQgZ28gaW50byA0
LjEuDQo+IC06IE1ha2VzIGNvcHktbW9kZT13cml0ZS1ibG9ja2luZyBlcXVhbCB0byBjb3B5LW1v
ZGU9YmFja2dyb3VuZCB1bmxlc3MNCj4gICAgIHlvdSBzZXQgdGhlIGdyYW51bGFyaXR5IHRvIGxp
a2UgNTEyLiAoU3RpbGwgYmVhdHMganVzdCBiZWluZw0KPiAgICAgY29tcGxldGVseSBicm9rZW4u
KQ0KPiANCj4gKEIpIFF1aWNrIGZpeCAyOiBTZXR0aW5nIHRoZSByZXF1ZXN0X2FsaWdubWVudCBi
bG9jayBsaW1pdCB0byB0aGUgam9i4oCZcw0KPiBncmFudWxhcml0eSB3aGVuIGluIHdyaXRlLWJs
b2NraW5nIG1vZGUuDQo+IA0KPiArOiBWZXJ5IHNpbXBsZSBmaXguICBDb3VsZCBnbyBpbnRvIDQu
MS4NCj4gKzogRXZlcnkgd3JpdGUgd2lsbCB0cmlnZ2VyIGEgUk1XIGN5Y2xlLCB3aGljaCBjb3Bp
ZXMgdGhlIHdob2xlIGNodW5rIHRvDQo+ICAgICB0aGUgdGFyZ2V0LCBzbyB3cml0ZS1ibG9ja2lu
ZyB3aWxsIGRvIHdoYXQgaXTigJlzIHN1cHBvc2VkIHRvIGRvLg0KPiAtOiByZXF1ZXN0X2FsaWdu
bWVudCBmb3JjZXMgZXZlcnl0aGluZyB0byBoYXZlIHRoZSBzYW1lIGdyYW51bGFyaXR5LCBzbw0K
PiAgICAgdGhpcyBzbG93cyBkb3duIHJlYWRzIG5lZWRsZXNzbHkuICAoQnV0IG9ubHkgZm9yIHdy
aXRlLWJsb2NraW5nLikNCj4gDQo+IChDKSBNYXliZSB0aGUgcmlnaHQgZml4IDE6IExldCBkb19z
eW5jX3RhcmdldF93cml0ZSgpIGV4cGFuZCBbb2Zmc2V0LA0KPiBvZmZzZXQgKyBieXRlcykgc3Vj
aCB0aGF0IGl0IGlzIGFsaWduZWQgYW5kIHJlYWQgaGVhZCBhbmQgdGFpbCBmcm9tIHRoZQ0KPiBz
b3VyY2Ugbm9kZS4gIChTbyBpdCB3b3VsZCBkbyB0aGUgUk1XIGl0c2VsZi4pDQo+IA0KPiArIERv
ZXNu4oCZdCBzbG93IHJlYWRzIGRvd24uDQo+ICsgV3JpdGVzIHRvIGRpcnR5IGFyZWFzIHdpbGwg
bWFrZSB0aGVtIGNsZWFuIOKAkyB3aGljaCBpcyB3aGF0DQo+ICAgIHdyaXRlLWJsb2NraW5nIGlz
IGZvci4NCj4gLSBQcm9iYWJseSBtb3JlIGNvbXBsaWNhdGVkLiAgTm90aGluZyBmb3IgNC4xLg0K
DQpUaGlzIGlzIGhvdyBiYWNrdXAgd29ya3MuDQoNCj4gDQo+IChEKSBNYXliZSB0aGUgcmlnaHQg
Zml4IDI6IFNwbGl0IEJsb2NrTGltaXRzLnJlcXVlc3RfYWxpZ25tZW50IGludG8NCj4gcmVhZF9h
bGlnbm1lbnQgYW5kIHdyaXRlX2FsaWdubWVudC4gIFRoZW4gZG8gKEIpLg0KDQpOb3cgaXQncyBP
SywgYnV0IGlmIHdlIGltcGxlbWVudCBiaXRtYXAgbW9kZSBmb3IgbWlycm9yICh3aGljaCBpcyB1
cGNvbWluZw0KYW55d2F5LCBJIHRoaW5rKSwgaXQgd2lsbCBzbG93IGRvd24gYWxsIHdyaXRlcywg
d2hlbiB3ZSBhcmUgaW50ZXJlc3RlZCBvbmx5DQppbiB3aGljaCBhcmUgdG91Y2hpbmcgZGlydHkg
cGFydHMuDQoNCj4gDQo+IEluIGVmZmVjdCwgdGhpcyBpcyBtb3JlIG9yIGxlc3MgdGhlIHNhbWUg
YXMgKEMpLCBidXQgcHJvYmFibHkgaW4gYQ0KPiBzaW1wbGVyIHdheS4gIFN0aWxsIG5vdCBzaW1w
bGUgZW5vdWdoIGZvciA0LjEsIHRob3VnaC4NCj4gDQo+IA0KPiBTby4uLiAgSSB0ZW5kIHRvIGRv
IGVpdGhlciAoQSkgb3IgKEIpIG5vdywgYW5kIHRoZW4gcHJvYmFibHkgKEQpIGZvcg0KPiA0LjI/
ICAoQW5kIGJlY2F1c2UgKEQpIGlzIGFuIGV4dGVuc2lvbiB0byAoQiksIGl0IHdvdWxkIG1ha2Ug
c2Vuc2UgdG8gZG8NCj4gKEIpIG5vdywgdW5sZXNzIHlvdeKAmWQgcHJlZmVyIChBKS4pDQo+IA0K
PiBNYXgNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

