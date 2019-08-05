Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB44C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF5B2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JrDZoOFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZcS-0007Pc-7X
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZbz-0006rv-5i
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZbx-0008LJ-Ia
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:49:03 -0400
Received: from mail-ve1eur01on0716.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::716]:65254
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huZbx-0008KT-BM; Mon, 05 Aug 2019 05:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1l9Rhu/QeIBOFzRIpYKqla8Fv+Tmgc/JM15aFmtfzP2YaTk7MnukxBtQKUtmzaID3BR+WXW59YI1TLdblrHHAfJmSGUQMb5VrBSNO2guNTRF4HEHMaorqInV54Xq/H1K4y8ED4eILKlCM3WI+Bx8oJ2CjYb4Af2iZGnpTCe+AKG7bjcx3H133jBqFMWMYcOFs9UxmU+RsFokDKnsjAVmmz1LBUpHOpNcMhzJX6YaBw8ANw+t9kSP4aOzZ5/cGpN21R8I+61WMCOYDCSeUY6mtpjyyH0YZCMKEOmEAZhhG71xBfzzG3GUTjBjvXace8ilIfvyex/O/wpr+6gQ8+0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/44A6idkLwSmLF0r111O9y0Q+OtwmEN4vvn5uCmjTE=;
 b=IaXA2tZjyub9E6MvXy8F2aXMJkJrvWMOcPOongKI+nV2iy8d7/pC+AOc0DsSh01PmitjhWk09z+1TeTjMAvF0e9jIlf3yzMWWmkHMmNOzNIoxqiwkTuHQ3thzTCgF8dBi09oQiFmUz2I4Y0cZjM6CBgJOZtVc9eGI79dw8dG8pz5YwaQQX1lGFktj7U7t+bZLitAGYAlGUAGAnGiCokqrc11BGhBws/Xrfy52rv3KxNq/V1m6Vc+nirvDw3iPywQZmjMPO69G7TYAoNokIkHcF66Ckuf6ZVpF1sIue5CETUEq7tLpg2esnLjjhRcBYKTvbCG/Jj3lHnZlMZS8ddpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/44A6idkLwSmLF0r111O9y0Q+OtwmEN4vvn5uCmjTE=;
 b=JrDZoOFQS7tw0yH4iFmQ2oxWIXQGmOEZR4Ke0m2cJKIYtiMzzyobPMPZ/PQq8fVahy7ZsGAXZOjBj3gGdtuCZUEVVEg6vWM7KkUUlKpfRjtMuFi6R+dQwSA09L3DjXas0EDj/issNXFpUd14ZxfFrGNrz8LJeDz9qgufkF3ATM0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4169.eurprd08.prod.outlook.com (20.179.10.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Mon, 5 Aug 2019 09:48:58 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 09:48:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoaboPFCAgAQQs4CAAAYxgA==
Date: Mon, 5 Aug 2019 09:48:58 +0000
Message-ID: <40bedaee-393e-5b65-7118-ded5b8ad4484@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <c784af61-663d-a633-657e-9f7541c9e97b@redhat.com>
 <83854e0f-31a1-0e08-8935-b0f95af94dfc@virtuozzo.com>
In-Reply-To: <83854e0f-31a1-0e08-8935-b0f95af94dfc@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::34)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805124855622
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40728c67-2861-41a2-baf1-08d7198a22f3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4169; 
x-ms-traffictypediagnostic: DB8PR08MB4169:
x-microsoft-antispam-prvs: <DB8PR08MB41690CEAAF3453F0C14F483DC1DA0@DB8PR08MB4169.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(39840400004)(396003)(366004)(53754006)(199004)(189003)(51444003)(107886003)(76176011)(7736002)(53546011)(478600001)(66946007)(68736007)(64756008)(66446008)(2501003)(5660300002)(6486002)(102836004)(31696002)(26005)(86362001)(186003)(81166006)(8676002)(6512007)(6436002)(99286004)(386003)(6506007)(81156014)(52116002)(66476007)(66556008)(8936002)(486006)(53936002)(14444005)(256004)(4326008)(14454004)(2906002)(110136005)(229853002)(31686004)(476003)(305945005)(71200400001)(71190400001)(6116002)(3846002)(11346002)(6246003)(316002)(54906003)(66066001)(446003)(36756003)(25786009)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4169;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eZbwIt9RwVRcjeltC6DGhmhN6F5doVZ51c9xGeVsJTFx5HgnweLc1yPd2DA03nSiGk/6kG0fkCssPQSXVAyFtt/Rg6p8tuGyiNpEwaLSj0+7LZ+lD3S/P124j2//i9deMC8Lmbgaxow5AweseG/DbX4HP2IewrLORiomB4I7LDYEWC2dD0GB9iWIMhqsk4DyNco7FN08HQrn6NhQfUbnPMK+gHDLN2AakL54CRM13oG0ENvlmWu3MALDnmXBGmDElUI2nSlL2HrGfb7xEgSObXg/w0gUZStvkv9NOBUg3v3wsHLYBlS94p1qWBK7DGibeGK4b5aAKd9R6SPuL6c94AropmgcqKo41Sl4UZUxDk7Qppy1uykjtvxG4+ayj8zcrb9EgoNM5wLN8cKKQafmEflW9TfLW4i2JnEy1oFtWy8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0D925802491264E9FD5EB4101A53ED1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40728c67-2861-41a2-baf1-08d7198a22f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:48:58.0435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4169
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::716
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxMjoyNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDIuMDguMjAxOSAyMjoyMSwgSm9obiBTbm93IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA4LzIvMTkg
Mjo1OCBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBoYml0bWFw
X3Jlc2V0IGlzIGJyb2tlbjogaXQgcm91bmRzIHVwIHRoZSByZXF1ZXN0ZWQgcmVnaW9uLiBJdCBs
ZWFkcyB0bw0KPj4+IHRoZSBmb2xsb3dpbmcgYnVnLCB3aGljaCBpcyBzaG93biBieSBmaXhlZCB0
ZXN0Og0KPj4+DQo+Pj4gYXNzdW1lIGdyYW51bGFyaXR5ID0gMg0KPj4+IHNldCgwLCAzKSAjIGNv
dW50IGJlY29tZXMgNA0KPj4+IHJlc2V0KDAsIDEpICMgY291bnQgYmVjb21lcyAyDQo+Pj4NCj4+
PiBCdXQgdXNlciBvZiB0aGUgaW50ZXJmYWNlIGFzc3VtZSB0aGF0IHZpcnR1YWwgYml0IDEgc2hv
dWxkIGJlIHN0aWxsDQo+Pj4gZGlydHksIHNvIGhiaXRtYXAgc2hvdWxkIHJlcG9ydCBjb3VudCB0
byBiZSA0IQ0KPj4+DQo+Pj4gSW4gb3RoZXIgd29yZHMsIGJlY2F1c2Ugb2YgZ3JhbnVsYXJpdHks
IHdoZW4gd2Ugc2V0IG9uZSAidmlydHVhbCIgYml0LA0KPj4+IHllcywgd2UgbWFrZSBhbGwgInZp
cnR1YWwiIGJpdHMgaW4gc2FtZSBjaHVuayB0byBiZSBkaXJ0eS4gQnV0IHRoaXMNCj4+PiBzaG91
bGQgbm90IGJlIHNvIGZvciByZXNldC4NCj4+Pg0KPj4+IEZpeCB0aGlzLCBhbGlnbmluZyBib3Vu
ZCBjb3JyZWN0bHkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBI
aSBhbGwhDQo+Pj4NCj4+PiBIbW0sIGlzIGl0IGEgYnVnIG9yIGZlYXR1cmU/IDopDQo+Pg0KPj4g
VmVyeSwgdmVyeSBnb29kIHF1ZXN0aW9uLg0KPj4NCj4+PiBJIGRvbid0IGhhdmUgYSB0ZXN0IGZv
ciBtaXJyb3IgeWV0LCBidXQgSSB0aGluayB0aGF0IHN5bmMgbWlycm9yIG1heSBiZSBicm9rZW4N
Cj4+PiBiZWNhdXNlIG9mIHRoaXMsIGFzIGRvX3N5bmNfdGFyZ2V0X3dyaXRlKCkgc2VlbXMgdG8g
YmUgdXNpbmcgdW5hbGlnbmVkIHJlc2V0Lg0KPj4+DQo+Pg0KPj4gSG9uZXN0bHkgSSB3YXMgd29y
cmllZCBhYm91dCB0aGlzIC0tIGlmIHlvdSB0YWtlIGEgbG9vayBhdCBteSBwYXRjaGVzDQo+PiB3
aGVyZSBJIGFkZCBuZXcgYml0bWFwIHN5bmMgbW9kZXMsIEkgYmVudCBvdmVyIGJhY2t3YXJkcyB0
byBhbGlnbg0KPj4gcmVxdWVzdHMgZm9yIHRoZSBzeW5jPXRvcCBiaXRtYXAgaW5pdGlhbGl6YXRp
b24gbWV0aG9kcyBiZWNhdXNlIEkgd2FzDQo+PiB3b3JyaWVkIGFib3V0IHRoaXMgcG9zc2libHkg
YmVpbmcgdGhlIGNhc2UuDQo+Pg0KPj4NCj4+IEknbSBub3Qgc3VyZSB3aGF0IHRoZSAicmlnaHQi
IGJlaGF2aW9yIG91Z2h0IHRvIGJlLg0KPj4NCj4+IExldCdzIHNheSB5b3UgaGF2ZSBhIGdyYW51
bGFyaXR5IG9mIDggYnl0ZXM6DQo+Pg0KPj4gaWYgeW91IHJlc2V0IDAtMyBpbiBvbmUgY2FsbCwg
YW5kIHRoZW4gNC03IGluIHRoZSBuZXh0LCB3aGF0IGhhcHBlbnM/IElmDQo+PiB0aGUgY2FsbGVy
IG5haXZlbHkgdGhpbmtzIHRoZXJlJ3MgYSAxOjEgcmVsYXRpb25zaGlwLCBpdCBtaWdodCBhY3R1
YWxseQ0KPj4gZXhwZWN0IHRoYXQgdG8gcmVmbGVjdCBhIGNsZWFyZWQgYml0LiBXaXRoIGFsaWdu
bWVudCBwcm90ZWN0aW9uLCB3ZSdsbA0KPj4ganVzdCBmYWlsIHRvIGNsZWFyIGl0IGJvdGggdGlt
ZXMgYW5kIGl0IHJlbWFpbnMgc2V0Lg0KPj4NCj4+IE9uIHRoZSBvdGhlciBoYW5kLCBpZiB5b3Ug
ZG8gYWxsb3cgcGFydGlhbCBjbGVhcnMsIHRoZSBmaXJzdCByZXNldCBmb3INCj4+IDAtMyB3aWxs
IHRvZ2dsZSBvZmYgNC03IHRvbywgd2hlcmUgd2UgbWlnaHQgcmVseSBvbiB0aGUgZmFjdCB0aGF0
IGl0J3MNCj4+IGFjdHVhbGx5IHN0aWxsIGRpcnR5Lg0KPj4NCj4+IFdoZXRoZXIgb3Igbm90IHRo
YXQncyBkYW5nZXJvdXMgZGVwZW5kcyBvbiB0aGUgY29udGV4dCwgYW5kIG9ubHkgdGhlDQo+PiBj
YWxsZXIga25vd3MgdGhlIGNvbnRleHQuIEkgdGhpbmsgd2UgbmVlZCB0byBtYWtlIHRoZSBzZW1h
bnRpYyBlZmZlY3Qgb2YNCj4+IHRoZSByZXNldCAib2J2aW91cyIgdG8gdGhlIGNhbGxlci4NCj4+
DQo+Pg0KPj4gSSBlbnZpc2lvbiB0aGlzOg0KPj4NCj4+IC0gaGJpdG1hcF9yZXNldChiaXRtYXAs
IHN0YXJ0LCBsZW5ndGgpDQo+PiDCoMKgIHJldHVybnMgLUVJTlZBTCBpZiB0aGUgcmFuZ2UgaXMg
bm90IHByb3Blcmx5IGFsaWduZWQNCj4gDQo+IGhiaXRtYXBfcmVzZXQgZG9uJ3QgcmV0dXJuLCBJ
IHRoaW5rcyBpdCBzaG91bGQgYmUgYW4gYXNzZXJ0aW9uDQoNCmRvbid0IHJldHVybiBhbnkgdmFs
dWUNCg0KPiANCj4+DQo+PiAtIGhiaXRtYXBfcmVzZXRfZmxhZ3MoYml0bWFwLCBmbGFncywgc3Rh
cnQsIGxlbmd0aCkNCj4+IMKgwqAgaWYgKGZsYWdzICYgSEJJVE1BUF9BTElHTl9ET1dOKSBhbGln
biByZXF1ZXN0IHRvIG9ubHkgZnVsbCBiaXRzDQo+PiDCoMKgIGlmIChmbGFncyAmIEhCSVRNQVBf
QUxJR05fVVApIGFsaWduIHJlcXVlc3QgdG8gY292ZXIgYW55IGJpdCBldmVuDQo+PiBwYXJ0aWFs
bHkgdG91Y2hlZCBieSB0aGUgc3BlY2lmaWVkIHJhbmdlDQo+PiDCoMKgIG90aGVyd2lzZSwgcGFz
cyByYW5nZSB0aHJvdWdoIGFzLWlzIHRvIGhiaXRtYXBfcmVzZXQgKGFuZCBwb3NzaWJseSBnZXQN
Cj4+IC1FSU5WQUwgaWYgY2FsbGVyIGRpZCBub3QgYWxpZ24gdGhlIHJlcXVlc3QuKQ0KPj4NCj4+
DQo+PiBUaGF0IHdheSB0aGUgc2VtYW50aWNzIGFyZSBhbHdheXMgY2xlYXIgdG8gdGhlIGNhbGxl
ci4NCj4gDQo+IEhtbSwgSSBkb3VidCwgaXMgdGhlcmUgYW55IHVzZSBvZiBBTElHTl9VUD8gSW4g
bW9zdCBjYXNlcyBpdCdzIHNhZmUgdG8gdGhpbmcgdGhhdA0KPiBzb21ldGhpbmcgY2xlYXIgaXMg
ZGlydHkgKGFuZCB0aGlzIGlzIGhvdyBoYml0bWFwIGFjdHVhbGx5IHdvcmtzIG9uIHNldC9nZXQp
LCBidXQNCj4gaXQgc2VlbXMgYWx3YXlzIHVuc2FmZSB0byBBTElHTl9VUCByZXNldC4uDQo+IA0K
PiBTbywgSSB0aGluayB0aGF0IGl0IHNob3VsZCBiZSBkZWZhdWx0IHRvIEFMSUdOX0RPV04sIG9y
IGp1c3QgYW4gYXNzZXJ0aW9uIHRoYXQgcmVxdWVzdA0KPiBpcyBhbGlnbmVkICh3aGljaCBhbnl3
YXkgbGVhZHMgdG8gaW1wbGVtZW50aW5nIGEgaGVscGVyIGhiaXRtYXBfcmVzZXRfYWxpZ25fdXAp
Li4NCg0KaGJpdG1hcF9yZXNldF9hbGlnbl9kb3duIEkgbWVhbi4NCg0KPiANCj4+DQo+PiAtLWpz
DQo+Pg0KPj4+IMKgIHRlc3RzL3Rlc3QtaGJpdG1hcC5jIHzCoCAyICstDQo+Pj4gwqAgdXRpbC9o
Yml0bWFwLmPCoMKgwqDCoMKgwqAgfCAyNCArKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+PiDC
oCAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4N
Cj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGVzdC1oYml0bWFwLmMgYi90ZXN0cy90ZXN0LWhiaXRt
YXAuYw0KPj4+IGluZGV4IDU5MmQ4MjE5ZGIuLjAwMDgwMjVhOWYgMTAwNjQ0DQo+Pj4gLS0tIGEv
dGVzdHMvdGVzdC1oYml0bWFwLmMNCj4+PiArKysgYi90ZXN0cy90ZXN0LWhiaXRtYXAuYw0KPj4+
IEBAIC00MjQsNyArNDI0LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9oYml0bWFwX2dyYW51bGFyaXR5
KFRlc3RIQml0bWFwRGF0YSAqZGF0YSwNCj4+PiDCoMKgwqDCoMKgIGhiaXRtYXBfdGVzdF9zZXQo
ZGF0YSwgMCwgMyk7DQo+Pj4gwqDCoMKgwqDCoCBnX2Fzc2VydF9jbXBpbnQoaGJpdG1hcF9jb3Vu
dChkYXRhLT5oYiksID09LCA0KTsNCj4+PiDCoMKgwqDCoMKgIGhiaXRtYXBfdGVzdF9yZXNldChk
YXRhLCAwLCAxKTsNCj4+PiAtwqDCoMKgIGdfYXNzZXJ0X2NtcGludChoYml0bWFwX2NvdW50KGRh
dGEtPmhiKSwgPT0sIDIpOw0KPj4+ICvCoMKgwqAgZ19hc3NlcnRfY21waW50KGhiaXRtYXBfY291
bnQoZGF0YS0+aGIpLCA9PSwgNCk7DQo+Pj4gwqAgfQ0KPj4+IMKgIHN0YXRpYyB2b2lkIHRlc3Rf
aGJpdG1hcF9pdGVyX2dyYW51bGFyaXR5KFRlc3RIQml0bWFwRGF0YSAqZGF0YSwNCj4+PiBkaWZm
IC0tZ2l0IGEvdXRpbC9oYml0bWFwLmMgYi91dGlsL2hiaXRtYXAuYw0KPj4+IGluZGV4IDc5MDUy
MTJhOGIuLjYxYTgxMzk5NGEgMTAwNjQ0DQo+Pj4gLS0tIGEvdXRpbC9oYml0bWFwLmMNCj4+PiAr
KysgYi91dGlsL2hiaXRtYXAuYw0KPj4+IEBAIC00NzMsMTUgKzQ3MywyOSBAQCB2b2lkIGhiaXRt
YXBfcmVzZXQoSEJpdG1hcCAqaGIsIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBjb3VudCkNCj4+
PiDCoCB7DQo+Pj4gwqDCoMKgwqDCoCAvKiBDb21wdXRlIHJhbmdlIGluIHRoZSBsYXN0IGxheWVy
LsKgICovDQo+Pj4gwqDCoMKgwqDCoCB1aW50NjRfdCBmaXJzdDsNCj4+PiAtwqDCoMKgIHVpbnQ2
NF90IGxhc3QgPSBzdGFydCArIGNvdW50IC0gMTsNCj4+PiArwqDCoMKgIHVpbnQ2NF90IGxhc3Q7
DQo+Pj4gK8KgwqDCoCB1aW50NjRfdCBlbmQgPSBzdGFydCArIGNvdW50Ow0KPj4+ICvCoMKgwqAg
dWludDY0X3QgZ3JhbiA9IFVJTlQ2NF9DKDEpIDw8IGhiLT5ncmFudWxhcml0eTsNCj4+PiAtwqDC
oMKgIHRyYWNlX2hiaXRtYXBfcmVzZXQoaGIsIHN0YXJ0LCBjb3VudCwNCj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFydCA+PiBoYi0+Z3JhbnVs
YXJpdHksIGxhc3QgPj4gaGItPmdyYW51bGFyaXR5KTsNCj4+PiArwqDCoMKgIC8qDQo+Pj4gK8Kg
wqDCoMKgICogV2Ugc2hvdWxkIGNsZWFyIG9ubHkgYml0cywgZnVsbHkgY292ZXJlZCBieSByZXF1
ZXN0ZWQgcmVnaW9uLiBPdGhlcndpc2UNCj4+PiArwqDCoMKgwqAgKiB3ZSBtYXkgY2xlYXIgc29t
ZXRoaW5nIHRoYXQgaXMgYWN0dWFsbHkgc3RpbGwgZGlydHkuDQo+Pj4gK8KgwqDCoMKgICovDQo+
Pj4gK8KgwqDCoCBmaXJzdCA9IERJVl9ST1VORF9VUChzdGFydCwgZ3Jhbik7DQo+Pj4gLcKgwqDC
oCBmaXJzdCA9IHN0YXJ0ID4+IGhiLT5ncmFudWxhcml0eTsNCj4+PiAtwqDCoMKgIGxhc3QgPj49
IGhiLT5ncmFudWxhcml0eTsNCj4+PiArwqDCoMKgIGlmIChlbmQgPT0gaGItPm9yaWdfc2l6ZSkg
ew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBlbmQgPSBESVZfUk9VTkRfVVAoZW5kLCBncmFuKTsNCj4+
PiArwqDCoMKgIH0gZWxzZSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVuZCA9IGVuZCA+PiBoYi0+
Z3JhbnVsYXJpdHk7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gK8KgwqDCoCBpZiAoZW5kIDw9IGZpcnN0
KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+PiArwqDCoMKgIH0NCj4+PiArwqDC
oMKgIGxhc3QgPSBlbmQgLSAxOw0KPj4+IMKgwqDCoMKgwqAgYXNzZXJ0KGxhc3QgPCBoYi0+c2l6
ZSk7DQo+Pj4gK8KgwqDCoCB0cmFjZV9oYml0bWFwX3Jlc2V0KGhiLCBzdGFydCwgY291bnQsIGZp
cnN0LCBsYXN0KTsNCj4+PiArDQo+Pj4gwqDCoMKgwqDCoCBoYi0+Y291bnQgLT0gaGJfY291bnRf
YmV0d2VlbihoYiwgZmlyc3QsIGxhc3QpOw0KPj4+IMKgwqDCoMKgwqAgaWYgKGhiX3Jlc2V0X2Jl
dHdlZW4oaGIsIEhCSVRNQVBfTEVWRUxTIC0gMSwgZmlyc3QsIGxhc3QpICYmDQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGhiLT5tZXRhKSB7DQo+Pj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

