Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B14F2073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rHyMa979"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIRe-0004qR-AV
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBIQJ-0004GW-DV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBIQG-0004nJ-6J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:54:06 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:56705 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBIQD-0004lQ-0r; Fri, 20 Sep 2019 08:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTt5/AB/Zp97syjrTU8BrR/PWQffJ7ZvyNoVIhT8pyqDLs07Ru+rRlcLTCiUOYEqoSPVV94QhVW0p8x8t1dYAWhuit7awc6edqCN6yifRsWFigYYhK/QomMcOJpqrPhmTP4V16I+IANTvHJjB2blVOeYWof6czjJstVxoum4Fg5IWwcVvuT42ViW+4DVHUEJepdCT2T1WTrqeu6f7GTNXNQYAx7Rt9CfV7LaGIm4o+hIJjDxhoRU0Od2rRM53UB0099gJvJ1YuoQZrH78Pl70QB9hcHnnWmEGAyvwhO1r35mk3hX8q8j15p2NY2MeOahv+7XdUO6MJVUsDxBf9JdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2GOMphLlEZ1Ht3yPv8hHHgotumXuKLW6pyREvB2oHA=;
 b=H5qW4WHlwCcPIT75zd0HGboOpYtnqWMY/THBjmndkwlFqTZPIZIyZeXVxIaPszCBWoT993JBN4bn6zEynrYVjqTUE+ccaE1zx2e2JtCcxyeYl7Pni08NUBCEKMPYMLOLEoB5QcmcHrqLcD7SV1hh8zn4tUbqYyQtB3RQNItKskBPE+5kysGF0zPn1B1ncw82Ev1v2D6mO9t8oNGr7cHFREAsoa8lCujAr7EE8JbnMwfxrbEnMQamPK7T3iFNnnacFxY8rcv05fEJVTK4TQO9kXlHefQk7I4WrAMHxI3UaIYq13ZHu3/Nx6CCG+oTur7nkBcvTFVW5BU+rUIIh3U1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2GOMphLlEZ1Ht3yPv8hHHgotumXuKLW6pyREvB2oHA=;
 b=rHyMa9796j+kBF3eonFfgD/Zs1eO2o7c3Hy8RTkclEVe6Q1pQiIe/TZLrRCKZszJAqfFPsPoKc4Zqw3ONp/RoR9E46VYrZmbAmBhAc1YWMSym+rMU1Lz+q2hXrSrkAyjC2zORXNvNNUIF0XhWXml+bvi1f8xkpTCbVpwpqlocZ0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5401.eurprd08.prod.outlook.com (10.255.185.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 12:53:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 12:53:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Topic: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVbLeo76n3Ba9lJkqJlS+3Y8+k26c0bngAgAAMPwCAAA0OgIAAA7gA
Date: Fri, 20 Sep 2019 12:53:59 +0000
Message-ID: <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
In-Reply-To: <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0254.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920155356601
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea7e98b-0dd7-4003-4a2d-08d73dc99ab7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5401; 
x-ms-traffictypediagnostic: DB8PR08MB5401:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54015C2F517E6CF26DE52587C1880@DB8PR08MB5401.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39850400004)(53754006)(189003)(199004)(446003)(8936002)(11346002)(486006)(2616005)(316002)(476003)(25786009)(81166006)(8676002)(76176011)(186003)(36756003)(81156014)(53546011)(386003)(99286004)(52116002)(31686004)(86362001)(6506007)(102836004)(5660300002)(71190400001)(256004)(71200400001)(26005)(6436002)(966005)(14454004)(6306002)(4326008)(478600001)(6486002)(2501003)(229853002)(64756008)(66946007)(66446008)(66556008)(66476007)(6512007)(54906003)(66066001)(110136005)(305945005)(7736002)(31696002)(2906002)(6116002)(107886003)(3846002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5401;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7CCA9noaeK7xqD88c1PCAEQE1h69zdCStWIE5oggGpT9B8VkgOlq4MbztFRzzpyVQbyKHswArZeHZ6yTL36Q3aQSWFAytnZj2cKci8c0gL9ZYHHfWx+Bl5jm5X34Oss6JkhlpTE+O9j8GIvXd0dzV9qkOeAIR/akcVnnXK4Y3HTeNxDGG6xot5UZdKhZVMuodFDfcM38sm7yH9HMSn1in4bvBQ+OeGUzwVZT1mUQeC671O4L5i67RkaVEGjwwylS6I/rir1vSTd4RZ/7AoOWJjUCi1WcoGyxzM91Y+T/GqZht8jgubP5wYBhDqjWf1lf0UxBq2et8tV7fEHdOwllPp0qtHIXNnktq0r5TBB6EDrLC7HeHaWW1LAOs7NcQJ8wiNrwAM91yq13i8Ya9Vm9q5r41JY1OjPwBKwsiPv1bRE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04DB53DB66BE814AB8BB9603305BA6B0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea7e98b-0dd7-4003-4a2d-08d73dc99ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 12:53:59.0839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nvq5urF0QWqT/C9K4PFOPi0b2lksIKo75BXJYZxwPKJLZVeCjbjjQ8wzIu3gWublMhoFuGswUhj9ekdyeV2+9Uk4vkshvsLCiDBQoteTXV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.115
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxNTo0MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wOS4xOSAxMzo1Mywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIwLjA5LjIwMTkgMTQ6MTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxNi4wOS4xOSAxOTo1MywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gSGkgYWxsIQ0KPj4+Pg0KPj4+PiBIZXJlIGlzIGFu
IGFzeW5jaHJvbm91cyBzY2hlbWUgZm9yIGhhbmRsaW5nIGZyYWdtZW50ZWQgcWNvdzINCj4+Pj4g
cmVhZHMgYW5kIHdyaXRlcy4gQm90aCBxY293MiByZWFkIGFuZCB3cml0ZSBmdW5jdGlvbnMgbG9v
cHMgdGhyb3VnaA0KPj4+PiBzZXF1ZW50aWFsIHBvcnRpb25zIG9mIGRhdGEuIFRoZSBzZXJpZXMg
YWltIGl0IHRvIHBhcmFsbGVsaXplIHRoZXNlDQo+Pj4+IGxvb3BzIGl0ZXJhdGlvbnMuDQo+Pj4+
IEl0IGltcHJvdmVzIHBlcmZvcm1hbmNlIGZvciBmcmFnbWVudGVkIHFjb3cyIGltYWdlcywgSSd2
ZSB0ZXN0ZWQgaXQNCj4+Pj4gYXMgZGVzY3JpYmVkIGJlbG93Lg0KPj4+DQo+Pj4gVGhhbmtzIGFn
YWluLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJyYW5jaDoNCj4+Pg0KPj4+IGh0dHBzOi8vZ2l0Lnhh
bmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jaw0KPj4NCj4+IFRoYW5r
cyBhIGxvdCENCj4+DQo+Pj4NCj4+Pj4gdjU6IGZpeCAwMjYgYW5kIHJlYmFzZSBvbiBNYXgncyBi
bG9jayBicmFuY2ggW3BlcmYgcmVzdWx0cyBub3QgdXBkYXRlZF06DQo+Pj4+DQo+Pj4+IDAxOiBu
ZXcsIHByZXBhcmUgMDI2IHRvIG5vdCBmYWlsDQo+Pj4+IDAzOiAtIGRyb3AgcmVhZF9lbmNyeXB0
ZWQgYmxrZGJnIGV2ZW50IFtLZXZpbl0NCj4+Pj4gICAgICAgLSBhc3NlcnQoKHggJiAoQkRSVl9T
RUNUT1JfU0laRSAtIDEpKSA9PSAwKSAtPiBhc3NlcnQoUUVNVV9JU19BTElHTkVEKHgsIEJEUlZf
U0VDVE9SX1NJWkUpKSBbcmViYXNlXQ0KPj4+PiAgICAgICAtIGZ1bGwgaG9zdCBvZmZzZXQgaW4g
YXJndW1lbnQgb2YgcWNvdzJfY29fZGVjcnlwdCBbcmViYXNlXQ0KPj4+PiAwNDogLSBzdWJzdGl0
dXRlIHJlbWFpbmluZyBxY293Ml9jb19kb19wd3JpdGV2IGJ5IHFjb3cyX2NvX3B3cml0ZXZfdGFz
ayBpbiBjb21tZW50IFtNYXhdDQo+Pj4+ICAgICAgIC0gZnVsbCBob3N0IG9mZnNldCBpbiBhcmd1
bWVudCBvZiBxY293Ml9jb19lbmNyeXB0IFtyZWJhc2VdDQo+Pj4+IDA1OiAtIE5vdyBwYXRjaCBk
b24ndCBhZmZlY3QgMDI2IGlvdGVzdCwgc28gaXRzIG91dHB1dCBpcyBub3QgY2hhbmdlZA0KPj4+
Pg0KPj4+PiBSZWJhc2UgY2hhbmdlcyBzZWVtcyB0cml2aWFsLCBzbywgSSd2ZSBrZXB0IHItYiBt
YXJrcy4NCj4+Pg0KPj4+IChGb3IgdGhlIHJlY29yZCwgSSBkaWRu4oCZdCBjb25zaWRlciB0aGVt
IHRyaXZpYWwsIG9yIEnigJlk4oCZdmUgYXBwbGllZA0KPj4+IE1heGlt4oCZcyBzZXJpZXMgb24g
dG9wIG9mIHlvdXJzLiAgSSBjb25zaWRlciBhIGNvbmZsaWN0IHRvIGJlIHRyaXZpYWxseQ0KPj4+
IHJlc29sdmFibGUgb25seSBpZiB0aGVyZSBpcyBvbmx5IG9uZSB3YXkgb2YgZG9pbmcgaXQ7IGJ1
dCB3aGVuIEkNCj4+PiByZXNvbHZlZCB0aGUgY29uZmxpY3RzIG15c2VsZiwgSSByZXNvbHZlZCB0
aGUgb25lIGluIHBhdGNoIDMgZGlmZmVyZW50bHkNCj4+PiBmcm9tIHlvdSDigJMgSSBhZGRlZCBh
biBvZmZzZXRfaW5fY2x1c3RlciB2YXJpYWJsZSB0bw0KPj4+IHFjb3cyX2NvX3ByZWFkdl9lbmNy
eXB0ZWQoKS4gIFN1cmUsIGl04oCZcyBzdGlsbCBzaW1wbGUgYW5kIHRoZSBkaWZmZXJlbmNlDQo+
Pj4gaXMgbWlub3IsIGJ1dCB0aGF0IHdhcyBleGFjdGx5IHdoZXJlIEkgdGhvdWdodCB0aGF0IEkg
Y2Fu4oCZdCBjb25zaWRlcg0KPj4+IHRoaXMgdHJpdmlhbC4pDQo+Pj4NCj4+DQo+PiBIbW0uIE1h
eSBiZSBpdCdzIHRyaXZpYWwgZW5vdWdoIHRvIGtlZXAgci1iIChhcyBteSBjaGFuZ2UgaXMgdHJp
dmlhbCBpdHNlbGYpLCBidXQgbm90DQo+PiB0cml2aWFsIGVub3VnaCB0byBjaGFuZ2UgYWxpZW4g
cGF0Y2ggb24gcXVldWluZz8gSWYgeW91IGRpc2FncmVlLCBJJ2xsIGJlIG1vcmUNCj4+IGNhcmVm
dWwgb24ga2VlcGluZyByLWIgaW4gY2hhbmdlZCBwYXRjaGVzLCBzb3JyeS4NCj4gDQo+IEl0IGRv
ZXNu4oCZdCBtYXR0ZXIgbXVjaCB0byBtZSwgSSBkaWZmIGFsbCBwYXRjaGVzIGFueXdheS4gOi0p
DQo+IA0KDQp0aGVuIGEgYml0IG9mZnRvcGljOg0KDQpXaGljaCB0b29scyBhcmUgeW91IHVzZT8N
Cg0KSSd2ZSBzb21lIHNjcmlwdHMgdG8gY29tcGFyZSBkaWZmZXJlbnQgdmVyc2lvbnMgb2Ygb25l
IHNlcmllIChvciB0byBjaGVjaywgd2hhdA0Kd2FzIGNoYW5nZWQgaW4gcGF0Y2hlcyBkdXJpbmcg
c29tZSBwb3J0aW5nIHByb2Nlc3MuLikuLiBUaGUgY29yZSB0aGluZyBpcyB0byBmaWx0ZXINCnNv
bWUgbm90IGludGVyZXN0aW5nIG51bWJlcnMgYW5kIGhhc2hlcywgd2hpY2ggbWFrZXMgZGlmZnMg
ZGlydHksIGFuZCB0aGVuIGNhbGwgdmltZGlmZi4NCkJ1dCBtYXliZSBJJ3ZlIHJlaW52ZW50ZWQg
dGhlIHdoZWVsLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

