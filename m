Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7957ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CFF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cmzzY7/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CFF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpiu-0001Sz-GA
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIpYL-0000hw-4V
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIpYK-0003hK-39
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:41:33 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com
 ([40.107.1.113]:23501 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIpYE-0003d2-TF; Fri, 11 Oct 2019 03:41:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBQY5qhr6FvLjBJ8L79jct1SSHRViSRE07G83/+O5Y3t24JaU+lDYFOEB4ePfaXeTLQzsoIyz7S6mLRzUV8vxLGDHOk3+aQHd+zHs+Ypa+53TKNwZLgMe7TQMGi/O2cVpeZdzdcIUvT6py4a3rlY5efDFuPY5uPFIqYmA5ALGFLKKiuGTtDgBy83ui/tZxT3ZL7XicIFsz9KscxbBnFTAoC96WOX/XL/evnOvNUGIS7/kPuQOdDtDL+0OG909fZUm+OO98Z5T8Dg9v3hrTvOnfKHKOL6EPvwhRbCd8vhKfMorjbnyhDxx4/5jXnRxd/jjJoQw88IBRp63ZvGAXI9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI8rt3+fS4QcOpgfQetZBHeg4htyBmOoOtQeyugTto0=;
 b=l4g0RK7bkw/mStUn0SYT0KzkQGkWWcu6dxQMIfMGH/7Cbl6ibQ7MsTEMWYtqGy315Cy9fPpUjIRwn1Gy7MF6dg85ng0O605i6Fw+ATzDUGd/IUo/yFWomR30epJIpGw/amvBBWLp7fAaMLK7xl7LQeQ1TSMKLEoE7GHn3ZKZS5UUx2l76Cgvok4a2RI7aBz+/GR6zplkg0INMkZkrZRKjBzLYsHaSX8xv7hNyIH/qJdSttxlW39qs5NHgkfFBR5LI+dp6XMU0zulmDNULv5m3EIYixovljlDi536z1RxbiPyvC9xXs0d0eXCQCAjaFA85WORRFvktXx4wF6USnmn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI8rt3+fS4QcOpgfQetZBHeg4htyBmOoOtQeyugTto0=;
 b=cmzzY7/w6ZP1za1Yd22HKOk8KTkbxIYyXdU3L7JRX3I9ADxLVZ5mP0DN8SjZcW9JX1DWaBavs/Zjre1ltuuk7yt8a7yKS3NLu55bbTGqquVqmFbxP9qRiWWzPc+SHqfNIdkgQJNtT2pzQ2mNzKPhZBmEblUwBh3RX8gLTojHtZ4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5018.eurprd08.prod.outlook.com (10.255.16.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 07:41:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 07:41:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/2] nbd: Allow description when creating NBD blockdev
Thread-Topic: [PATCH v2 2/2] nbd: Allow description when creating NBD blockdev
Thread-Index: AQHVf629k2MuG+kVEE64yFRXZjDGPadVDyyA
Date: Fri, 11 Oct 2019 07:41:20 +0000
Message-ID: <ac6040ac-a42a-8c23-3958-6566b22960b9@virtuozzo.com>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-3-eblake@redhat.com>
In-Reply-To: <20191010210018.22000-3-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011104116975
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8c6d94-b5df-4454-739a-08d74e1e6864
x-ms-traffictypediagnostic: DB8PR08MB5018:
x-microsoft-antispam-prvs: <DB8PR08MB50183E63AAD69C1779A72012C1970@DB8PR08MB5018.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(66476007)(8936002)(6116002)(8676002)(6512007)(11346002)(25786009)(446003)(476003)(486006)(6436002)(7736002)(66066001)(2616005)(6246003)(4326008)(31686004)(81156014)(86362001)(26005)(66946007)(14454004)(186003)(256004)(3846002)(71190400001)(71200400001)(6486002)(81166006)(66446008)(5660300002)(102836004)(31696002)(64756008)(66556008)(110136005)(54906003)(386003)(2501003)(6506007)(36756003)(99286004)(229853002)(305945005)(478600001)(316002)(52116002)(76176011)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5018;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqbhYo/Ixy0BlrC0VSo/Jqb+nwHreGtZLgRU92HyklIwWYBl9EN4fBU+u7IihJ071TagD2btCDm0B0utL9r3uqZWMHPky0mnGCvQIMIE8Z7M9JLgs3njciJVqoJUFvgn8zaqZYTT08L2rcHQWuHc1FNlVNuJyL56ihV9NFXQojBA6Bd+S+eNb47N2jKbabp57DtHlSSLTdl7FlIwX9HTogjOUXFPgkaTbx55w9aZoW588gYdP6o48U9FZyoDstYq6p8LUFPDup6DiGTZJ70dwks6SCkjg9LAw0Q0jNPTh+/R2DN9qHAeQ2ml3NKv31tijFHv2lgRAs4t2PMldv8Dv2zbpWaEr1v3GNFiw0NLB1gwYHhu2XFTH2RCDSu74KxyHankXKWfAnuOvsnW7FBku6R9PnXYsbbeF7RNhGqkSqI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5C0D84C1E42F348B60B0B44B4113B64@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c6d94-b5df-4454-739a-08d74e1e6864
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 07:41:20.5194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNcojDHoPFBN3+PFFk56xh1HOXUJWxSdfPtAe5Ps7L8nINDqG/u8Rm9Nv+RMQ9Kp+PgYypeitTC5qgICmw9BziVmYVnan85nQkFGh0y2l1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5018
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.113
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMTAuMjAxOSAwOjAwLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBBbGxvdyBibG9ja2RldnMgdG8g
bWF0Y2ggdGhlIGZlYXR1cmUgYWxyZWFkeSBwcmVzZW50IGluIHFlbXUtbmJkIC1ELg0KPiBFbmhh
bmNlIGlvdGVzdCAyMjMgdG8gY292ZXIgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJs
YWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBxYXBp
L2Jsb2NrLmpzb24gICAgICAgICAgICB8IDggKysrKystLS0NCj4gICBibG9ja2Rldi1uYmQuYyAg
ICAgICAgICAgICB8IDkgKysrKysrKystDQo+ICAgbW9uaXRvci9obXAtY21kcy5jICAgICAgICAg
fCA0ICsrLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjIzICAgICB8IDIgKy0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMjIzLm91dCB8IDEgKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9xYXBpL2Jsb2Nr
Lmpzb24gYi9xYXBpL2Jsb2NrLmpzb24NCj4gaW5kZXggMTQ1YzI2OGJiNjQ2Li5hNjYxN2I1YmQw
M2EgMTAwNjQ0DQo+IC0tLSBhL3FhcGkvYmxvY2suanNvbg0KPiArKysgYi9xYXBpL2Jsb2NrLmpz
b24NCj4gQEAgLTI1MCw5ICsyNTAsMTEgQEANCj4gICAjIEBuYW1lOiBFeHBvcnQgbmFtZS4gSWYg
dW5zcGVjaWZpZWQsIHRoZSBAZGV2aWNlIHBhcmFtZXRlciBpcyB1c2VkIGFzIHRoZQ0KPiAgICMg
ICAgICAgIGV4cG9ydCBuYW1lLiAoU2luY2UgMi4xMikNCj4gICAjDQo+ICsjIEBkZXNjcmlwdGlv
bjogRnJlZS1mb3JtIGRlc2NyaXB0aW9uIG9mIHRoZSBleHBvcnQuIChTaW5jZSA0LjIpDQoNCldv
cnRoIG1lbnRpb24gbWF4aW11bSBvZiA0MDk2Pw0KDQo+ICsjDQo+ICAgIyBAd3JpdGFibGU6IFdo
ZXRoZXIgY2xpZW50cyBzaG91bGQgYmUgYWJsZSB0byB3cml0ZSB0byB0aGUgZGV2aWNlIHZpYSB0
aGUNCj4gICAjICAgICBOQkQgY29ubmVjdGlvbiAoZGVmYXVsdCBmYWxzZSkuDQo+IC0NCj4gKyMN
Cj4gICAjIEBiaXRtYXA6IEFsc28gZXhwb3J0IHRoZSBkaXJ0eSBiaXRtYXAgcmVhY2hhYmxlIGZy
b20gQGRldmljZSwgc28gdGhlDQo+ICAgIyAgICAgICAgICBOQkQgY2xpZW50IGNhbiB1c2UgTkJE
X09QVF9TRVRfTUVUQV9DT05URVhUIHdpdGgNCj4gICAjICAgICAgICAgICJxZW11OmRpcnR5LWJp
dG1hcDpOQU1FIiB0byBpbnNwZWN0IHRoZSBiaXRtYXAuIChzaW5jZSA0LjApDQo+IEBAIC0yNjMs
OCArMjY1LDggQEANCj4gICAjIFNpbmNlOiAxLjMuMA0KPiAgICMjDQoNClsuLl0NCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

