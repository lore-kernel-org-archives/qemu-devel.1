Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6053BC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327472067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327472067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7nP-0002Dj-I8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49653)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <BROGERS@suse.com>) id 1hs7mw-0001ml-GX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hs7mu-0000kv-Kc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:42:14 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:50722)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hs7ms-0000iG-NL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:42:12 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY
 m4a0039g.houston.softwaregrp.com WITH ESMTP; 
 Mon, 29 Jul 2019 15:42:06 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 29 Jul 2019 15:22:13 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 29 Jul 2019 15:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyX7at/tCu657p/gIobmNyfvat5IsmzrB+BGRkIgepmt4r2+SYSV9/2paUUYDwEPlfXb0dEmVIzYr+oKmn90GPEzjCP3KHGoGygncFFQdz8TBwuelPxnfOpL2Kl/X6TPAT8zjwOE5/Tu58LU+DpTPJvIrfv1SPVAucnnblNOWt+WioB1dpxuaphCAuS2IueD7e5jYqf5z5/H0YhAvZxnldhc++IWXzWngOLENO2Z7dGi4vMEsb8ogkbClAN8t8OunaHIwdl6NAC01StzIQMGqCVuDB6bdIfCzuxHpIOcM7smYded7LSfOvtr5DqsEgRqbySRVGhruyM2sS03jWfvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFzRDVxQnjP5kMJ9WpHWXWbw3gnalSreLF+gq7URkc=;
 b=mk/UuFSpa6ek5NIWxN4/+8QtIrs+pKdTjbetWmNsxFOLZxqCz/1QbZuEtmkVC2CgDbSHwFQgIyRbFFmGFf7kTcHjqzpGUfTpk30H7/KXjkPZKT9FO/qxKc6r9j9d96GLuMz3RPFkMz9VIYvexfR5l9PamNxzQJauQC8NnsuJrv1VCDJGPLCMHiGUmy1g1BuAZNHj/V1MJBbz7PHBpTOOVoSVSH3lHckI8LrwS01FXb2Nkwi6HVVR2hZ6Tqpp+4bvujrUt+vQeMXYL86vetdM7lWPVNx8I24zLTCn6LnNUvRafDGejSl4SXS8nzrpYzufcZ+v1oGxsr0NleOGz6jTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (10.255.155.222) by
 CH2PR18MB3335.namprd18.prod.outlook.com (52.132.246.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 15:22:11 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::54ad:4562:f961:5610%3]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 15:22:11 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "paul.c.lai@intel.com"
 <paul.c.lai@intel.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel]  Fixing Snowridge CPU model name and features
Thread-Index: AQHVO++rwnjP5vO/OEuCByxO4tC57abhyuMA
Date: Mon, 29 Jul 2019 15:22:11 +0000
Message-ID: <1a33ae335f396d49689425e0137213efd9f28a7c.camel@suse.com>
References: <20190716155808.25010-1-paul.c.lai@intel.com>
In-Reply-To: <20190716155808.25010-1-paul.c.lai@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [2620:113:8044:4009:ffff:ffff:ffff:f626]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d250318-4309-46e5-40f3-08d71438876a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR18MB3335; 
x-ms-traffictypediagnostic: CH2PR18MB3335:
x-microsoft-antispam-prvs: <CH2PR18MB3335ABAF37324337C55F8112D9DD0@CH2PR18MB3335.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(8676002)(53936002)(25786009)(102836004)(229853002)(99286004)(81156014)(81166006)(6486002)(118296001)(7736002)(5660300002)(2201001)(305945005)(8936002)(6436002)(6512007)(2906002)(316002)(46003)(54906003)(110136005)(76176011)(478600001)(6506007)(4326008)(186003)(446003)(11346002)(68736007)(486006)(14454004)(36756003)(6116002)(71190400001)(476003)(2616005)(86362001)(71200400001)(66476007)(256004)(76116006)(91956017)(66946007)(6246003)(66446008)(64756008)(66556008)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3335;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uRT1yMKqXyGlwpGPhhboiATFpR4yk0XYY7QDf8RRkcGtSXJkM9iCnEhRoZFo/fP3f8uJBPM+rjegRb1OWg1xf3kOaO6QOw3I8qBZQd8aKS0ty+GSgYe7BMjta9SGrHO92y/Ahg1Xdo4PT/RBL3k3nzYXYalyceTrJnurSb+IBjHuqlz1u93qXIEUuINo/X/lTww9QiKS2Qp4Awj6J3MCvXHLoTQlQ5zRYdY1sOaMmAw/lv3CdvR6FCZbas8YPWEl00W0WWjfVY/Ko2MdUTNgEay90JjY+Ky8vYqo6aAeOWGK0P/3BUFu+hQCqE2AKLRYhwk6aTQvNLCFyJQYwQMLe1aEtykDaJWYD3qFJ8NudNKI1h5FTw1y5ieKpiOjqIOCIC6dtwGkT2rjVYG6DyxCIfVq55PVQfLySHHA8kvEfZY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A328C44E4095FC478188C9366AD0B375@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d250318-4309-46e5-40f3-08d71438876a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 15:22:11.6757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BROGERS@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3335
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.2.85
Subject: Re: [Qemu-devel] Fixing Snowridge CPU model name and features
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
Cc: "tao3.xu@intel.com" <tao3.xu@intel.com>,
 "luwei.kang@intel.com" <luwei.kang@intel.com>,
 "wei.w.wang@intel.com" <wei.w.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDE5LTA3LTE2IGF0IDA4OjU4IC0wNzAwLCBQYXVsIExhaSB3cm90ZToNCj4gQ2hh
bmdpbmcgdGhlIG5hbWUgdG8gU25vd3JpZGdlIGZyb20gU25vd1JpZGdlLVNlcnZlci4NCj4gVGhl
cmUgaXMgbm8gY2xpZW50IG1vZGVsIG9mIFNub3dyaWRnZSwgc28gIi1TZXJ2ZXIiIGlzIHVubmVj
ZXNzYXJ5Lg0KPiANCj4gUmVtb3ZpbmcgQ1BVSURfRVhUX1ZNWCBmcm9tIFNub3dyaWRnZSBjcHUg
ZmVhdHVyZSBsaXN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF1bCBMYWkgPHBhdWwuYy5sYWlA
aW50ZWwuY29tPg0KPiBUZXN0ZWQtYnk6IFRhbzMgWHUgPHRhbzMueHVAaW50ZWwuY29tPg0KPiAt
LS0NCj4gIHRhcmdldC9pMzg2L2NwdS5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4
Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+IGluZGV4IDYzZDg5Mjc2ZmUuLjdmNTZlODg3
YWUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+ICsrKyBiL3RhcmdldC9pMzg2
L2NwdS5jDQo+IEBAIC0yNjg4LDcgKzI2ODgsNyBAQCBzdGF0aWMgWDg2Q1BVRGVmaW5pdGlvbiBi
dWlsdGluX3g4Nl9kZWZzW10gPSB7DQo+ICAgICAgICAgIC5tb2RlbF9pZCA9ICJJbnRlbCBYZW9u
IFByb2Nlc3NvciAoSWNlbGFrZSkiLA0KPiAgICAgIH0sDQo+ICAgICAgew0KPiAtICAgICAgICAu
bmFtZSA9ICJTbm93UmlkZ2UtU2VydmVyIiwNCj4gKyAgICAgICAgLm5hbWUgPSAiU25vd3JpZGdl
IiwNCj4gICAgICAgICAgLmxldmVsID0gMjcsDQo+ICAgICAgICAgIC52ZW5kb3IgPSBDUFVJRF9W
RU5ET1JfSU5URUwsDQo+ICAgICAgICAgIC5mYW1pbHkgPSA2LA0KPiBAQCAtMjcwNiw3ICsyNzA2
LDYgQEAgc3RhdGljIFg4NkNQVURlZmluaXRpb24gYnVpbHRpbl94ODZfZGVmc1tdID0gew0KPiAg
ICAgICAgICAgICAgQ1BVSURfRlhTUiB8IENQVUlEX1NTRSB8IENQVUlEX1NTRTIsDQo+ICAgICAg
ICAgIC5mZWF0dXJlc1tGRUFUXzFfRUNYXSA9DQo+ICAgICAgICAgICAgICBDUFVJRF9FWFRfU1NF
MyB8IENQVUlEX0VYVF9QQ0xNVUxRRFEgfCBDUFVJRF9FWFRfTU9OSVRPUg0KPiB8DQo+IC0gICAg
ICAgICAgICBDUFVJRF9FWFRfVk1YIHwNCj4gICAgICAgICAgICAgIENQVUlEX0VYVF9TU1NFMyB8
DQo+ICAgICAgICAgICAgICBDUFVJRF9FWFRfQ1gxNiB8DQo+ICAgICAgICAgICAgICBDUFVJRF9F
WFRfU1NFNDEgfA0KDQpXaGF0IGlzIHRoZSBzdGF0dXMgb2YgdGhpcyBwYXRjaCB3aXRoIHJlc3Bl
Y3QgdG8gdGhlIHY0LjEuMCByZWxlYXNlPw0KSXQgd291bGQgc2VlbSB0byBtZSB0aGF0IGl0IHdh
cyB0YXJnZXRlZCBmb3IgdGhpcyByZWxlYXNlLCB0byBnZXQgdGhlDQpuYW1lIGFuZCBmZWF0dXJl
cyByaWdodCBiZWZvcmUgY29kaWZpZWQgaW4gYSByZWxlYXNlZCB2ZXJzaW9uLCBidXQNCkludGVs
IHdvdWxkIGtub3cgYmV0dGVyLg0KDQpCcnVjZQ0K

