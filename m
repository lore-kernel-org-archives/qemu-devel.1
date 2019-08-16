Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84F3C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A894A2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oCl7xxOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A894A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfKK-00021c-Le
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyfJM-0001Th-Ic
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyfJJ-00088u-KL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:42:44 -0400
Received: from mail-eopbgr130091.outbound.protection.outlook.com
 ([40.107.13.91]:30374 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyfJJ-00087M-1g; Fri, 16 Aug 2019 12:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6yegm3Yc5cRdTKIyY4O2n3jzg2kH+lDJyUWJAmwzRq/GVL2Ak+twocn5sjqYJhLwVRXvcagySBCis2ra3Q2bYADFfCGlfEChFeqmzgCIKH8XOZZvVwgS51HEbCl2FOR+N9ANyWMtVnsWwDlYdR1OKbRyO08LnLVUtgE98rRVlj7J/umpr973FvbCylZQhK1H45LM7QJAtNRgv9oNF2yHekSZnMSYPDqu/N5gyr8KQF83j7ZGkgimIDI5JY/y5EQDfzWP4QElHOcgwI3Om6/qcF8mA6BzGAOSeYSMisdN08DagwFfXJo6sAoeLC3JZCuxXMy8wNL59tLt8vOCNZTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VyDA36mEJt51oPhYb8qm9y1BxS6qUeWpOpZ9eq0Hzk=;
 b=dhq2nNEWrABePc4n5BPPbgF20la1br3dS1zPnKn0OUNhiOHExdnH6KUJSQBxnutF+/t/LOrlp+mCkMtPzJ6JVRTpprnIxFAUwKiZTvnvnae+lSiVYeU5j6/Y5y8g7t6ShEesUT8vaaS84hK29h7jAlLocx+/FZYthnQJ0BwWgqx7o/R70JaV1x1ml6oHA0uho68IF1FfnHAgFGJx3S1+ogEGfRxiC2SnJoOLImmXyJquoF0TOpgVJBQcTxrUkySDMuWZmWytNndctWY62jXIfSFfbObb7VI1Q9h9gVHoCKCeCdMQTJqYXl4WaiUt8Mfr7yP3Pg9TeGP9wRUaVRcCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VyDA36mEJt51oPhYb8qm9y1BxS6qUeWpOpZ9eq0Hzk=;
 b=oCl7xxOVFtzMiHoxQ2filfH5sRJ3rJLtOZP13I4zh0GCG7v3soSQ6ybFl1xVptI/kxRjkCP0D3OfjYLij9hm/fmM5+PimJjJdUgDbK8CwIKBqxshxfdwP/SV1cqxQLrg5WDHsZwFpQ2aGd4EKO8NXTI3IHDMIgQFrPHvOGSoTUg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4012.eurprd08.prod.outlook.com (20.179.9.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Fri, 16 Aug 2019 16:42:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 16:42:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 0/4] qcow2: async handling of fragmented io
Thread-Index: AQHVU2J5fEq8y0bXA0+IlUQwrVWabKb8P0eAgABLlQCAAXGVgA==
Date: Fri, 16 Aug 2019 16:42:37 +0000
Message-ID: <8d3ca847-a3c6-6e22-344d-d63b5dc5667f@virtuozzo.com>
References: <20190815121042.121309-1-vsementsov@virtuozzo.com>
 <ed48ba6b-f90d-abe6-c77e-34c4a6bfab8c@redhat.com>
 <8c259ef0-ccce-5fd0-6c88-4f0a2109715c@virtuozzo.com>
In-Reply-To: <8c259ef0-ccce-5fd0-6c88-4f0a2109715c@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816194235467
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5e1080-1f18-4dc3-dc65-08d72268bf2f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4012; 
x-ms-traffictypediagnostic: DB8PR08MB4012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB401291F16295455F04B552BAC1AF0@DB8PR08MB4012.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(53754006)(76176011)(81156014)(81166006)(102836004)(53546011)(86362001)(6436002)(71200400001)(229853002)(386003)(186003)(6506007)(66446008)(2616005)(446003)(8676002)(64756008)(66476007)(66556008)(476003)(3846002)(6116002)(99286004)(26005)(486006)(71190400001)(11346002)(54906003)(66066001)(110136005)(7736002)(256004)(25786009)(66946007)(31696002)(2501003)(6246003)(478600001)(6512007)(52116002)(36756003)(316002)(53936002)(4326008)(5660300002)(8936002)(2906002)(14454004)(31686004)(6486002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4012;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KnSQsEPwL/lBcexo6Ds07iSB76d8OWz5WQePb3DdpB8Hnc3qUeP/CNhRwoxtySrz+4FDbNwxg+RWvDOMaRX8qkHbak2gs4lkkGDNGbTPGLYUcaJSDWcQPeqfAsssRhRsRUDjH9Q5nxw1YJ4cbOGWtev0Yr5FqfS0wCXCiY/s4pfL62PqH0nzru+hi9xMX3YqTa/fCnHI0EqwmoNqTEbGqgbpR1G21FUUvc6nEW11iVbouVAFqun1pkwa4mgmmKatQDDpxEZUU8Dl+/nC5cm2YeGhd7HH7iPAKapzroitOK0AGXgFe6tAZGPhEqxdDMOU22QWfr/WYuMuE/HSYN+Gg5CpQqjI8IGWZo8P8cB6KRESABV0DCFK77pi3s/Tkfyhl/kocI85JbNXWjhzSF+YQUS2RI2GnGPDQvCTfXMYmBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3432311517A6E0408BD8BF3A481759EC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e1080-1f18-4dc3-dc65-08d72268bf2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 16:42:37.7543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfH7N/mOi/FXyieZjxLDPjXK3S9upwfM+RIFUt540EpUFF0fsAKaS4XHPOWGrhejnp7SGA70zTxRDPrcyvxoG16tpcDPrO922a1O2+XQma0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4012
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.91
Subject: Re: [Qemu-devel] [PATCH v3 0/4] qcow2: async handling of fragmented
 io
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDguMjAxOSAxODozOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTUuMDguMjAxOSAxNzowOSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTUuMDguMTkgMTQ6MTAs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gSGkgYWxsIQ0KPj4+DQo+
Pj4gSGVyZSBpcyBhbiBhc3luY2hyb25vdXMgc2NoZW1lIGZvciBoYW5kbGluZyBmcmFnbWVudGVk
IHFjb3cyDQo+Pj4gcmVhZHMgYW5kIHdyaXRlcy4gQm90aCBxY293MiByZWFkIGFuZCB3cml0ZSBm
dW5jdGlvbnMgbG9vcHMgdGhyb3VnaA0KPj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4g
VGhlIHNlcmllcyBhaW0gaXQgdG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+PiBsb29wcyBpdGVyYXRp
b25zLg0KPj4+IEl0IGltcHJvdmVzIHBlcmZvcm1hbmNlIGZvciBmcmFnbWVudGVkIHFjb3cyIGlt
YWdlcywgSSd2ZSB0ZXN0ZWQgaXQNCj4+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+Pg0KPj4gTG9v
a3MgZ29vZCB0byBtZSwgYnV0IEkgY2Fu4oCZdCB0YWtlIGl0IHlldCBiZWNhdXNlIEkgbmVlZCB0
byB3YWl0IGZvcg0KPj4gU3RlZmFu4oCZcyBicmFuY2ggdG8gYmUgbWVyZ2VkLCBvZiBjb3Vyc2Uu
DQo+Pg0KPj4gU3BlYWtpbmcgb2Ygd2hpY2gsIHdoeSBkaWRu4oCZdCB5b3UgYWRkIGFueSB0ZXN0
cyBmb3IgdGhlICpfcGFydCgpDQo+PiBtZXRob2RzP8KgIEkgZmluZCBpdCBhIGJpdCB1bnNldHRs
aW5nIHRoYXQgbm90aGluZyB3b3VsZCBoYXZlIGNhdWdodCB0aGUNCj4+IGJ1ZyB5b3UgaGFkIGlu
IHYyIGluIHBhdGNoIDMuDQo+Pg0KPiANCj4gSG1tLCBhbnkgdGVzdCB3aXRoIHdyaXRlIHRvIGZy
YWdtZW50ZWQgYXJlYSBzaG91bGQgaGF2ZSBjYXVnaHQgaXQuLiBPaywNCj4gSSdsbCB0aGluayBv
ZiBzb21ldGhpbmcuDQo+IA0KPiANCg0KQW5kIG5vdyBJIHNlZSB0aGF0IGl0J3Mgbm90IHRyaXZp
YWwgdG8gbWFrZSBzdWNoIGEgdGVzdDoNCg0KMS4gcWNvdzIgd3JpdGUgaXMgYnJva2VuIHdoZW4g
d2UgZ2l2ZSBub256ZXJvIHFpb3Zfb2Zmc2V0IHRvIGl0LCBidXQgb25seQ0KcWNvdzJfd3JpdGUg
Y2FsbHMgYmRydl9jb19wd3JpdGV2X3BhcnQsIHNvIHdlIG5lZWQgdG8gaGF2ZSBhIHRlc3Qgd2hl
cmUgcWNvdzINCmlzIGEgZmlsZSBjaGlsZCBmb3IgcWNvdzINCg0KMi4gVGhlbiwgdGhlIGJ1ZyBs
ZWFkcyB0byB0aGUgYmVnaW5uaW5nIG9mIHRoZSBxaW92IHdpbGwgYmUgd3JpdHRlbiB0byBhbGwg
cGFydHMuDQpCdXQgb3VyIHRlc3RpbmcgdG9vbCBxZW11LWlvIGhhcyBvbmx5ICJ3cml0ZSAtUCIg
Y29tbWFuZCB3aXRoIGJ1ZmZlciBmaWxsZWQgd2l0aA0KdGhlIHNhbWUgb25lIGJ5dGUsIHNvIHdl
IGNhbid0IGNhdGNoIGl0DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

