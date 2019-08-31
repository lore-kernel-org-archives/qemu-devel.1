Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB1C3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 08:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8A123697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 08:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EV1iItXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A123697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3yVA-0004Eu-KJ
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 04:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3yUC-0003jO-62
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 04:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3yUB-00017c-6I
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 04:11:52 -0400
Received: from mail-eopbgr30134.outbound.protection.outlook.com
 ([40.107.3.134]:9381 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3yU7-00010R-Iy; Sat, 31 Aug 2019 04:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONwygeJpcYQUcehwUmU9rPTK6GFkDrClpkJxlMaB4iDUSWyUtIkJbSwt/cmI27+jcy4yXKjznVRt8VWW4Kv+0leYZZrl2FrCj7g1oGv5OG5WTPwWvK9iyTxwLRcXBdI6Fzin7YH5wbAnKWxdn4qPg9ZMLEvngeZM4m3qNb4o+L2b/ahTYiMJKmcxyRnSC2lD5hS3GJVf7O7W0fDQaRKHaaOsJbz56AdoMNAmLmgTj/QVyOFFzQysImuJ4dguJQArLPIZpriIcTD/D+yOYhwgMdlG+DrM8f+nyAnyovocZsxAvm2eSPOqwC7rRtR9uNEsvdSdku554c2lZtpoTxL3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQTLidQXu6QZyAlTqjAUaThMA5ymiFH2Df+1Ynb5CCI=;
 b=mzEvnRD9xxTG6XhcBkEaq5KL1DvybKzMhx6QWBL7nCZNJCkmAOvqdshGuy7qHMyNbkQZHQeuPMjKogE5Au0ew+50bgxnpz0ovM62QzSzsQtqgdvRei46xhKnNCs94Ae3l+ZSK1pMnCHzB0A4wVOmPQHx+CNfsISC8aSE0VEgc9mgGoo+tCzToFXih2CHvT9kXHvRKtkEtcf71AzAN4+6PLwh+l9x+Vaf7M5yyt/y+YJFZQMR6GcjUnYas5D+HVPsGYaH1WuuT81krgqoy6pOoChUYcD+KhfkESNbAPOLqpG9nCvrG+j0U2FAGnURNm6IqEfkzCGZ6T/yZyCFs/2zjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQTLidQXu6QZyAlTqjAUaThMA5ymiFH2Df+1Ynb5CCI=;
 b=EV1iItXm+sYzS+iKYOWrLxK02Dn8WjpTyV/ZQ9Jpei/hiVZVlSoFgHEj2Ssz6aH7WvpoWLoyIKEEgpG0CpQLYt8eVWc69r1SXgoq0ECbujLBrNeD+6NIlkdOhH1xwMwSZBinbCj3kPmGd7CsL1Nw24ar785caz4hNqoonaTEji4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4154.eurprd08.prod.outlook.com (20.179.12.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Sat, 31 Aug 2019 08:11:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.020; Sat, 31 Aug 2019
 08:11:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
Thread-Index: AQHVWcJnZgUz/ZiSEEiPmfDFNqlCh6cUCAIAgABcQACAAI+qAA==
Date: Sat, 31 Aug 2019 08:11:45 +0000
Message-ID: <c56103bc-cf94-1585-8ffa-aa2efbc5bba8@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-3-eblake@redhat.com>
 <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>
 <911ecfee-675a-da91-19ec-dd11d6d21e78@redhat.com>
In-Reply-To: <911ecfee-675a-da91-19ec-dd11d6d21e78@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:7:67::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190831111142413
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe6a4520-6279-4457-9567-08d72deadce4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4154; 
x-ms-traffictypediagnostic: DB8PR08MB4154:
x-microsoft-antispam-prvs: <DB8PR08MB41543D948A05F174BE91A464C1BC0@DB8PR08MB4154.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(346002)(376002)(366004)(52314003)(199004)(189003)(2501003)(478600001)(66446008)(52116002)(66066001)(186003)(71200400001)(71190400001)(102836004)(3846002)(2616005)(14454004)(26005)(76176011)(446003)(6486002)(11346002)(486006)(2906002)(476003)(229853002)(110136005)(4326008)(6246003)(7736002)(316002)(54906003)(8936002)(64756008)(6116002)(305945005)(66556008)(25786009)(36756003)(31686004)(81156014)(6506007)(53546011)(86362001)(5660300002)(14444005)(6512007)(386003)(256004)(31696002)(99286004)(8676002)(6436002)(81166006)(66946007)(66476007)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4154;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qGTkgcKSEKXkjoObLwmFsFKlDvgYrvyfSr+osfYsTM+NbbTjOWd2PbRfsB5ZyKzxQaI0jnFT7sUe7mR9RR+RCCjS6mf5CpUERdJUphi/zrWnP3yUyVHwFxrIr8axJoxzWqZOrq60a0LsLplZl3g76zX5QbusMSP0tIsmegMMRELn4ypELfKQ/B74tSHDeaT7oQr0AkIhkKS7Z20T8kCzhU3XIIkMZ6qALbBbXCxxkCSdFnzOLC/OXGF4zykVv3tKpbQKvGP2zYZ5uEfd68VfiUbCcq5cxEJiuy/CaS35r1AMoa7fFUCsfraRHv069P3XtHjTxZS4myDVBdOeNFhTE7g6XdwPqsq/sUr5MYk4scSvzW/D3ZllNraxmoHq/F8N1pD97aRAdNyIGQBhNprKavO6c9UT3esc2Xh8rY+R7co=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F419A915487F1E4091182EF1A137FE43@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6a4520-6279-4457-9567-08d72deadce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 08:11:45.1302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjDLHC8DfDjJ1UshNPRtIrrIDR/PNcNNUDYT/NwP5BUhzfmPub5mNoF/BINAHw2IFlWSVQRRiR/PYuptPwxRc7k3dkh0W+2LwAVEkK+mtkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4154
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.134
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzEuMDguMjAxOSAyOjM3LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiA4LzMwLzE5IDE6MDcgUE0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAyMy4wOC4yMDE5IDE3OjM3
LCBFcmljIEJsYWtlIHdyb3RlOg0KPj4+IENvbW1pdCBmZTA0ODBkNiBhbmQgZnJpZW5kcyBhZGRl
ZCBCRFJWX1JFUV9OT19GQUxMQkFDSyBhcyBhIHdheSB0bw0KPj4+IGF2b2lkIHdhc3RpbmcgdGlt
ZSBvbiBhIHByZWxpbWluYXJ5IHdyaXRlLXplcm8gcmVxdWVzdCB0aGF0IHdpbGwgbGF0ZXINCj4+
PiBiZSByZXdyaXR0ZW4gYnkgYWN0dWFsIGRhdGEsIGlmIGl0IGlzIGtub3duIHRoYXQgdGhlIHdy
aXRlLXplcm8NCj4+PiByZXF1ZXN0IHdpbGwgdXNlIGEgc2xvdyBmYWxsYmFjazsgYnV0IGluIGRv
aW5nIHNvLCBjb3VsZCBub3Qgb3B0aW1pemUNCj4+PiBmb3IgTkJELiAgVGhlIE5CRCBzcGVjaWZp
Y2F0aW9uIGlzIG5vdyBjb25zaWRlcmluZyBhbiBleHRlbnNpb24gdGhhdA0KPj4+IHdpbGwgYWxs
b3cgcGFzc2luZyBvbiB0aG9zZSBzZW1hbnRpY3M7IHRoaXMgcGF0Y2ggdXBkYXRlcyB0aGUgbmV3
DQo+Pj4gcHJvdG9jb2wgYml0cyBhbmQgJ3FlbXUtbmJkIC0tbGlzdCcgb3V0cHV0IHRvIHJlY29n
bml6ZSB0aGUgYml0LCBhcw0KPj4+IHdlbGwgYXMgdGhlIG5ldyBlcnJubyB2YWx1ZSBwb3NzaWJs
ZSB3aGVuIHVzaW5nIHRoZSBuZXcgZmxhZzsgd2hpbGUNCj4+PiB1cGNvbWluZyBwYXRjaGVzIHdp
bGwgaW1wcm92ZSB0aGUgY2xpZW50IHRvIHVzZSB0aGUgZmVhdHVyZSB3aGVuDQo+Pj4gcHJlc2Vu
dCwgYW5kIHRoZSBzZXJ2ZXIgdG8gYWR2ZXJ0aXNlIHN1cHBvcnQgZm9yIGl0Lg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0KPj4+ICsr
KyBiL25iZC9zZXJ2ZXIuYw0KPj4+IEBAIC01NSw2ICs1NSw4IEBAIHN0YXRpYyBpbnQgc3lzdGVt
X2Vycm5vX3RvX25iZF9lcnJubyhpbnQgZXJyKQ0KPj4+ICAgICAgICAgICAgcmV0dXJuIE5CRF9F
Tk9TUEM7DQo+Pj4gICAgICAgIGNhc2UgRU9WRVJGTE9XOg0KPj4+ICAgICAgICAgICAgcmV0dXJu
IE5CRF9FT1ZFUkZMT1c7DQo+Pj4gKyAgICBjYXNlIEVOT1RTVVA6DQo+Pj4gKyAgICAgICAgcmV0
dXJuIE5CRF9FTk9UU1VQOw0KPj4NCj4+IFRoaXMgbWF5IHByb3Zva2UgcmV0dXJuaW5nIE5CRF9F
Tk9UU1VQIGluIG90aGVyIGNhc2VzLCBub3Qgb25seSBuZXcgb25lIHdlIGFyZSBnb2luZyB0byBh
ZGQuDQo+IA0KPiBDb3JyZWN0LiBCdXQgdGhlIHNwZWMgb25seSBzYWlkIFNIT1VMRCBhdm9pZCBF
Tk9UU1VQIGluIHRob3NlIG90aGVyDQo+IGNhc2VzLCBub3QgTVVTVCBhdm9pZCBFTk9UU1VQOyBh
bmQgaW4gcHJhY3RpY2UsIGVpdGhlciB0aGUgY2xpZW50IHRoYXQNCj4gaXMgbm90IHN1c3BlY3Rp
bmcgaXQgd2lsbCB0cmVhdCBpdCB0aGUgc2FtZSBhcyBOQkRfRUlOVkFMLCBvciB3ZSd2ZQ0KPiBt
YW5hZ2VkIHRvIGdldCBhIHNsaWdodGx5IGJldHRlciBlcnJvciBtZXNzYWdlIGFjcm9zcyB0aGFu
IG5vcm1hbC4gIEkNCj4gZG9uJ3Qgc2VlIHRoYXQgYXMgYSByZWFsIHNob3ctc3RvcHBlci4NCj4g
DQo+IEJ1dCBpZiBpdCBib3RoZXJzIHlvdSwNCg0KTm8sIEkgdGhpbmsgaXQgZG9lc24ndC4gT0ss
IEVOT1RTVVAgaXMgRU5PVFNVUCBhbnl3YXksIGl0IHNob3VsZG4ndCBiZSB0cmVhdGVkIGluY29y
cmVjdGx5Lg0KDQo+IG5vdGUgdGhhdCBpbiBuYmRraXQsIEkgYWN0dWFsbHkgY29kZWQgdGhpbmdz
IHVwDQo+IHRvIHJlZnVzZSB0byBzZW5kIE5CRF9FT1ZFUkZMT1cgdW5sZXNzIE5CRF9DTURfRkxB
R19ERiB3YXMgc2V0LCBhbmQgdG8NCj4gcmVmdXNlIHRvIHNlbmQgTkJEX0VOT1RTVVAgdW5sZXNz
IE5CRF9DTURfRkxBR19GQVNUX1pFUk8gd2FzIHNldC4gSQ0KPiBjb3VsZCBjb3B5IHRoYXQgYmVo
YXZpb3IgaGVyZSwgaWYgd2Ugd2FudCBxZW11IHRvIGJlIHRoYXQgbXVjaCBzdHJpY3Rlcg0KPiBh
cyBhIHNlcnZlci4NCj4gDQo+IChOb3RlIHRvIHNlbGY6IGFsc28gY2hlY2sgaWYsIHdoZW4gdXNp
bmcgc3RydWN0dXJlZCByZXBsaWVzIHRvIHNlbmQNCj4gZXJyb3IgbWVzc2FnZXMsIGluIGFkZGl0
aW9uIHRvIHRoZSBjb2RlLCBpZiB0aGUgc3RyaW5nIGNvbnRhaW5zDQo+IHN0cmVycm9yKGVycm5v
KSBmcm9tIEJFRk9SRSB0aGUgbWFwcGluZywgcmF0aGVyIHRoYW4gYWZ0ZXIgd2UndmUgbG9zdA0K
PiBpbmZvcm1hdGlvbiB0byB0aGUgbW9yZS1saW1pdGVkIE5CRF9FKiB2YWx1ZXMpDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

