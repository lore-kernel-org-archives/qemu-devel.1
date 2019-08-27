Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E834DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F780206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uyxymm1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F780206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ayH-00037D-OB
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2awy-00025R-Gm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2awx-0002D1-6k
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:51:52 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com
 ([40.107.14.113]:28222 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2aws-0002BG-Uf; Tue, 27 Aug 2019 08:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXkXuq0BxwAXkZywQ4jvPWFlKPJEciiKuc6BPvr0rr1RPM1yK1xKaa4J31xTTgm+B4snYalBnLHOMtNFzL8oWrgZeVoqwM+8Q3z6R0Un3VOFO4KzULQI2HQNwXpIG8bUMvhtf6pz0V2rl44VnFKZCPL1cxfdtlxGdJvbfOxz97YhVKdNNJdxYm5ac90myz9KZrsvLvdwaq6TQTYJ+wxPuQ6oNvNcoEP2pXVZTDPl0ETeXg4Uv7HZ01/Cl7M8xaZQlFMOOzylMClQ0BkAwN3ZFNBbu9cCJvKVe/jWR6YT3NQ10n//+gkEJ4I2LxsjkYiNQ+tYI1igLbgh9DOdJyeBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqJ7trUX+5teN1dklrsxYTvIJFMuq5ZARJW+LHy+MB8=;
 b=EJRQQA+E8gJWogGG9LA41vu5fN0YY8iUw4vtbZISYkeBhyxPHm5RZ5RPlLGofH5HJEGZ6UZ1uAyI1A7O5HinrydnaNkxBrN3c3snsu16N4ZhJTA95ejYrf/sncmEgtokwIpfObNgWlXwf6pjKcbjZIUoRceIvnq2clLt0TxsIU5gUidx1fotq5AdBM8TtWvgxBZHpPcVrwy3jUGHd9mX/X9sRTYQWeZitYv+8FkvAoiGGSzwZYoBVWe534vP0sZaUPZXwTCPktoUFjyMZE9EmotEkZFyajm2IbBceF/ZCrRutLvba1ZTXQCjvceBc7gm3iZA+96SIuYwWieB9Ig1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqJ7trUX+5teN1dklrsxYTvIJFMuq5ZARJW+LHy+MB8=;
 b=uyxymm1Eou8KiD1udEogdsnEMba8VK95ur1dTdoC0U1A/fgbh00u80vA1AcSamw8hA7+bO9GuEiuNSzkPCFvgNeaDzPZEbBXcz4gy7wgtqUaxe/f2I5L8xkwUEDXAJLFBNBSUT0MLRkB2wlX2GoW5DrOrcW2J9rVmRpa/B1FWrc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8SPR01MB0010.eurprd08.prod.outlook.com (20.179.13.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 12:51:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:51:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVVp7pMVJrWuU2GEyiejPdM5Ms16cO/xqA
Date: Tue, 27 Aug 2019 12:51:43 +0000
Message-ID: <c714b323-5c35-1168-3d3d-fc12d9904542@virtuozzo.com>
References: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
 <20190819150049.28997-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190819150049.28997-4-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:7:66::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190827155141200
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7182fcc4-0154-44b4-1443-08d72aed5016
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8SPR01MB0010; 
x-ms-traffictypediagnostic: DB8SPR01MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8SPR01MB001065792A97A39F84857AAFC1A00@DB8SPR01MB0010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39840400004)(346002)(136003)(396003)(199004)(189003)(76176011)(478600001)(8936002)(2501003)(256004)(14444005)(186003)(6246003)(476003)(31686004)(446003)(2906002)(66066001)(305945005)(31696002)(6512007)(86362001)(53936002)(6486002)(4326008)(102836004)(66946007)(66556008)(66476007)(6116002)(64756008)(26005)(66446008)(6436002)(8676002)(110136005)(3846002)(7736002)(316002)(25786009)(52116002)(81166006)(71190400001)(71200400001)(14454004)(6506007)(36756003)(54906003)(486006)(81156014)(386003)(99286004)(2616005)(11346002)(5660300002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8SPR01MB0010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UvkhUNs0Pmz0Lg3aLEH8RQ/5Q8CaolNnH1BFdGZyclucpCz2aMhHK3Wr+xY3jiS4qIUBrZj+SiXZCAA4cMCG9xIjS1rfgAcJfSKasU2+yqOQUR3XHbWGr1wBn7A169r5qm5JCJJQHibN6qrD+iHZqN7IvvrHEtEVe390GzryOvN1Gg6OwivFOFXA8tf5G3lDZMMnu3kkLgRbWaS33yELxwKV6TEJw4IlPYaAyiv+YMfMQsNp7PGqyMl0J/8VWBE8+u44nLNX0PgkbQm71oLTxCkmG9MBh+sUMAzqhhl8v5tGgDYHHfvtNhrLrcbmxEvNwkoUrAf0fsAJ5Xl2rOiP7CgPIJEHg70TGdSWIcwih81iY6Wzc+HLRpFIwjT8u9bmUmmGvWIKZzGQTm1hWXI6yAWGhVWl9WCccoQqmU4nBp8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E9E4EE6026B443942007AB320719E2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7182fcc4-0154-44b4-1443-08d72aed5016
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:51:43.6855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vR8Q6dmcUXzyPXm/9BkppXh4/x/O9uVR9ISdPjmdJITuLafOkCcaTFyiK8583/mxdg7RlRBCQt+xU6D4lAQ9REHV0fg9uaL1QOSBeLmzbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.113
Subject: Re: [Qemu-devel] [PATCH v3 3/3] qcow2: add zstd cluster compression
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDguMjAxOSAxODowMCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiB6c3RkIHNpZ25pZmlj
YW50bHkgcmVkdWNlcyBjbHVzdGVyIGNvbXByZXNzaW9uIHRpbWUuDQo+IEl0IHByb3ZpZGVzIGJl
dHRlciBjb21wcmVzc2lvbiBwZXJmb3JtYW5jZSBtYWludGFpbmluZw0KPiB0aGUgc2FtZSBsZXZl
bCBvZiBjb21wcmVzc2lvbiByYXRpbyBpbiBjb21wYXJpc29uIHdpdGgNCj4gemxpYiwgd2hpY2gs
IGF0IHRoZSBtb21lbnQsIGhhcyBiZWVuIHRoZSBvbmx5IGNvbXByZXNzaW9uDQo+IG1ldGhvZCBh
dmFpbGFibGUuDQo+IA0KPiBUaGUgcGVyZm9ybWFuY2UgdGVzdCByZXN1bHRzOg0KPiBUZXN0IGNv
bXByZXNzZXMgYW5kIGRlY29tcHJlc3NlcyBxZW11IHFjb3cyIGltYWdlIHdpdGgganVzdA0KPiBp
bnN0YWxsZWQgcmhlbC03LjYgZ3Vlc3QuDQo+IEltYWdlIGNsdXN0ZXIgc2l6ZTogNjRLLiBJbWFn
ZSBvbiBkaXNrIHNpemU6IDIuMkcNCj4gDQo+IFRoZSB0ZXN0IHdhcyBjb25kdWN0ZWQgd2l0aCBi
cmQgZGlzayB0byByZWR1Y2UgdGhlIGluZmx1ZW5jZQ0KPiBvZiBkaXNrIHN1YnN5c3RlbSB0byB0
aGUgdGVzdCByZXN1bHRzLg0KPiBUaGUgcmVzdWx0cyBpcyBnaXZlbiBpbiBzZWNvbmRzLg0KPiAN
Cj4gY29tcHJlc3MgY21kOg0KPiAgICB0aW1lIC4vcWVtdS1pbWcgY29udmVydCAtTyBxY293MiAt
YyAtbyBjb21wcmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQo+ICAgICAgICAgICAgICAgICAgICBz
cmMuaW1nIFt6bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nDQo+IGRlY29tcHJlc3MgY21kDQo+ICAg
IHRpbWUgLi9xZW11LWltZyBjb252ZXJ0IC1PIHFjb3cyDQo+ICAgICAgICAgICAgICAgICAgICBb
emxpYnx6c3RkXV9jb21wcmVzc2VkLmltZyB1bmNvbXByZXNzZWQuaW1nDQo+IA0KPiAgICAgICAg
ICAgICBjb21wcmVzc2lvbiAgICAgICAgICAgICAgIGRlY29tcHJlc3Npb24NCj4gICAgICAgICAg
IHpsaWIgICAgICAgenN0ZCAgICAgICAgICAgemxpYiAgICAgICAgIHpzdGQNCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHJl
YWwgICAgIDY1LjUgICAgICAgMTYuMyAoLTc1ICUpICAgIDEuOSAgICAgICAgICAxLjYgKC0xNiAl
KQ0KPiB1c2VyICAgICA2NS4wICAgICAgIDE1LjggICAgICAgICAgICA1LjMgICAgICAgICAgMi41
DQo+IHN5cyAgICAgICAzLjMgICAgICAgIDAuMiAgICAgICAgICAgIDIuMCAgICAgICAgICAyLjAN
Cj4gDQo+IEJvdGggWkxJQiBhbmQgWlNURCBnYXZlIHRoZSBzYW1lIGNvbXByZXNzaW9uIHJhdGlv
OiAxLjU3DQo+IGNvbXByZXNzZWQgaW1hZ2Ugc2l6ZSBpbiBib3RoIGNhc2VzOiAxLjRHDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNv
bT4NCj4gLS0tDQo+ICAgYmxvY2svcWNvdzItdGhyZWFkcy5jICB8IDk0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAg
fCAgNiArKysNCj4gICBjb25maWd1cmUgICAgICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysr
DQo+ICAgZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dCB8IDIwICsrKysrKysrKw0KPiAgIHFhcGkvYmxv
Y2stY29yZS5qc29uICAgfCAgMyArLQ0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi10aHJl
YWRzLmMgYi9ibG9jay9xY293Mi10aHJlYWRzLmMNCj4gaW5kZXggMTRiNWJkNzZmYi4uODVkMDRl
NmMyZSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svcWNvdzItdGhyZWFkcy5jDQo+ICsrKyBiL2Jsb2Nr
L3Fjb3cyLXRocmVhZHMuYw0KPiBAQCAtMjgsNiArMjgsMTEgQEANCj4gICAjZGVmaW5lIFpMSUJf
Q09OU1QNCj4gICAjaW5jbHVkZSA8emxpYi5oPg0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19aU1RE
DQo+ICsjaW5jbHVkZSA8enN0ZC5oPg0KPiArI2luY2x1ZGUgPHpzdGRfZXJyb3JzLmg+DQo+ICsj
ZW5kaWYNCj4gKw0KPiAgICNpbmNsdWRlICJxY293Mi5oIg0KPiAgICNpbmNsdWRlICJibG9jay90
aHJlYWQtcG9vbC5oIg0KPiAgICNpbmNsdWRlICJjcnlwdG8uaCINCj4gQEAgLTE2NSw2ICsxNzAs
ODUgQEAgc3RhdGljIHNzaXplX3QgcWNvdzJfemxpYl9kZWNvbXByZXNzKHZvaWQgKmRlc3QsIHNp
emVfdCBkZXN0X3NpemUsDQo+ICAgICAgIHJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiArI2lm
ZGVmIENPTkZJR19aU1REDQo+ICsvKg0KPiArICogcWNvdzJfenN0ZF9jb21wcmVzcygpDQo+ICsg
Kg0KPiArICogQ29tcHJlc3MgQHNyY19zaXplIGJ5dGVzIG9mIGRhdGEgdXNpbmcgenN0ZCBjb21w
cmVzc2lvbiBtZXRob2QNCj4gKyAqDQo+ICsgKiBAZGVzdCAtIGRlc3RpbmF0aW9uIGJ1ZmZlciwg
QGRlc3Rfc2l6ZSBieXRlcw0KPiArICogQHNyYyAtIHNvdXJjZSBidWZmZXIsIEBzcmNfc2l6ZSBi
eXRlcw0KPiArICoNCj4gKyAqIFJldHVybnM6IGNvbXByZXNzZWQgc2l6ZSBvbiBzdWNjZXNzDQo+
ICsgKiAgICAgICAgICAtRU5PTUVNIGRlc3RpbmF0aW9uIGJ1ZmZlciBpcyBub3QgZW5vdWdoIHRv
IHN0b3JlIGNvbXByZXNzZWQgZGF0YQ0KPiArICogICAgICAgICAgLUVJTyAgICBvbiBhbnkgb3Ro
ZXIgZXJyb3INCj4gKyAqLw0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBxY293Ml96c3RkX2NvbXBy
ZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IHNyY19zaXplKQ0KPiArew0K
PiArICAgIHNzaXplX3QgcmV0Ow0KPiArICAgIHVpbnQzMl90ICpjX3NpemUgPSBkZXN0Ow0KPiAr
ICAgIC8qIHN0ZWFsIHNvbWUgYnl0ZXMgdG8gc3RvcmUgY29tcHJlc3NlZCBjaHVuayBzaXplICov
DQo+ICsgICAgY2hhciAqZF9idWYgPSAoKGNoYXIgKikgZGVzdCkgKyBzaXplb2YoKmNfc2l6ZSk7
DQo+ICsNCj4gKyAgICBpZiAoZGVzdF9zaXplIDwgc2l6ZW9mKCpjX3NpemUpKSB7DQo+ICsgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGRlc3Rfc2l6ZSAtPSBz
aXplb2YoKmNfc2l6ZSk7DQo+ICsNCj4gKyAgICByZXQgPSBaU1REX2NvbXByZXNzKGRfYnVmLCBk
ZXN0X3NpemUsIHNyYywgc3JjX3NpemUsIDUpOw0KDQpMZXQncyBjYWxsIHRoaXMgIjUiIHRvIGJl
IHNvbWV0aGluZyBsaWtlIFFDT1cyX0RFRkFVVExUX1pTVERfQ09NUFJFU1NJT05fTEVWRUwsIHdl
J2xsDQpwb3NzaWJseSB3YW50IHRvIGFkZCBhbiBvcHRpb24gZm9yIHRoaXMgaW4gZnV0dXJlLg0K
DQo+ICsNCj4gKyAgICBpZiAoWlNURF9pc0Vycm9yKHJldCkpIHsNCj4gKyAgICAgICAgaWYgKFpT
VERfZ2V0RXJyb3JDb2RlKHJldCkgPT0gWlNURF9lcnJvcl9kc3RTaXplX3Rvb1NtYWxsKSB7DQo+
ICsgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKyAgICAgICAgfSBlbHNlIHsNCj4gKyAg
ICAgICAgICAgIHJldHVybiAtRUlPOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArDQo+ICsg
ICAgLyogc3RvcmUgdGhlIGNvbXByZXNzZWQgY2h1bmsgc2l6ZSBpbiB0aGUgdmVyeSBiZWdpbm5p
bmcgb2YgdGhlIGJ1ZmZlciAqLw0KPiArICAgICpjX3NpemUgPSByZXQ7DQo+ICsNCj4gKyAgICBy
ZXR1cm4gcmV0ICsgc2l6ZW9mKCpjX3NpemUpOw0KPiArfQ0KPiArDQo+ICsvKg0KPiArICogcWNv
dzJfenN0ZF9kZWNvbXByZXNzKCkNCj4gKyAqDQo+ICsgKiBEZWNvbXByZXNzIHNvbWUgZGF0YSAo
bm90IG1vcmUgdGhhbiBAc3JjX3NpemUgYnl0ZXMpIHRvIHByb2R1Y2UgZXhhY3RseQ0KPiArICog
QGRlc3Rfc2l6ZSBieXRlcyB1c2luZyB6c3RkIGNvbXByZXNzaW9uIG1ldGhvZA0KPiArICoNCj4g
KyAqIEBkZXN0IC0gZGVzdGluYXRpb24gYnVmZmVyLCBAZGVzdF9zaXplIGJ5dGVzDQo+ICsgKiBA
c3JjIC0gc291cmNlIGJ1ZmZlciwgQHNyY19zaXplIGJ5dGVzDQo+ICsgKg0KPiArICogUmV0dXJu
czogMCBvbiBzdWNjZXNzDQo+ICsgKiAgICAgICAgICAtRUlPIG9uIGFueSBlcnJvcg0KPiArICov
DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IHFjb3cyX3pzdGRfZGVjb21wcmVzcyh2b2lkICpkZXN0
LCBzaXplX3QgZGVzdF9zaXplLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IHNyY19zaXplKQ0KPiArew0KPiArICAgIHNzaXpl
X3QgcmV0Ow0KPiArICAgIC8qDQo+ICsgICAgICogenN0ZCBkZWNvbXByZXNzIHdhbnRzIHRvIGtu
b3cgdGhlIGV4YWN0IGxlbmd0aCBvZiB0aGUgZGF0YQ0KPiArICAgICAqIGZvciB0aGF0IHB1cnBv
c2UsIG9uIHRoZSBjb21wcmVzc2lvbiB0aGUgbGVuZ3RoIGlzIHN0b3JlZCBpbg0KPiArICAgICAq
IHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiB0aGUgY29tcHJlc3NlZCBidWZmZXINCj4gKyAgICAgKi8N
Cj4gKyAgICBjb25zdCB1aW50MzJfdCAqc19zaXplID0gc3JjOw0KPiArICAgIGNvbnN0IGNoYXIg
KnNfYnVmID0gKChjb25zdCBjaGFyICopIHNyYykgKyBzaXplb2YoKnNfc2l6ZSk7DQoNCmJ1dCB3
aGF0IGlmICpzX3NpemUgKG9yIGV2ZW4gc3JjX3NpemUpIGlzIGNvcnJ1cHRlZD8gSSB0aGluayB3
ZSBuZWVkIHRvIGNoZWNrIGl0IGJlZm9yZSBjYWxsaW5nDQpaU1REX2RlY29tcHJlc3M6DQoNCmlm
IChzcmNfc2l6ZSA8IHNpemVvZigqc19zaXplKSB8fCBzcmNfc2l6ZSAtIHNpemVvZigqc19zaXpl
KSA8ICpzX3NpemUpIHsNCiAgICByZXR1cm4gLUVJTzsNCn0NCg0Kd2l0aCB0aGlzIChhbmQgb3B0
aW9uYWxseSB3aXRoIFFDT1cyX0RFRkFVVExUX1pTVERfQ09NUFJFU1NJT05fTEVWRUwpOg0KDQpS
ZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KDQoNCj4gKw0KPiArICAgIHJldCA9IFpTVERfZGVjb21wcmVzcyhkZXN0LCBk
ZXN0X3NpemUsIHNfYnVmLCAqc19zaXplKTsNCj4gKw0KPiArICAgIGlmIChaU1REX2lzRXJyb3Io
cmV0KSkgew0KPiArICAgICAgICByZXR1cm4gLUVJTzsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBy
ZXR1cm4gMDsNCj4gK30NCj4gKyNlbmRpZg0KPiArDQoNClsuLi5dDQoNCg0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

