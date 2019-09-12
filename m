Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B71DC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9BA20650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bq2OmgQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9BA20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KMF-0002Mj-5A
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8KLD-0001WI-0a
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8KLA-0002ld-PL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:20:34 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com
 ([40.107.3.138]:46564 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8KL8-0002k8-HE; Thu, 12 Sep 2019 04:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml4rDkabmYK60NsB0h0oEI/AhHp3cs82GCvWF96MsHDypAonSfFow10tlvnO1EcEuv/hNNNThtmX76ruIncfnY1SFbgJrOyaz0MWv4fuXmovIaA3kVEUUyyRZpnRC5PYox6vTP2iacJNaWa66EXPmPRuTB7Hyx0iphY9PNSMzPHFDRQYShpsBzENF7ahyKg634iPdQo1YigjuSUShyNMHlSG5HCT/pi+szt4e2cWKk/DVo8fBVmFKbEA+xXlSDEh1ldFowVklx1Gk5wTyBptL+0lrhmDSRhbzrt8lIhnimijBPfBXjMJppEZOmVHH3NbiRjhMlCLa9oEYR8gwe4wRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpjSkiX0k9p7DSXSkxgJgUAeRE7yAs8uUVwINkvXbSM=;
 b=kKJzzZtmxQdk1Selv1TE3TYwa6+ieNbzn9If+RA+kk5EdUoVBL/7mCoccxhsv4PySiPEqSFlDQWYBVUXkSq+nPp7VC0VDhVuikHzPeAV5wujMXVQ995CPaxcNi89dPJplHUmx3QZKrkhz2wZSp3je9ecNV+/psRnARPCfqgAodDH/cALsahWe/6lCUUN4mStSM8ukETx3k189zjJUaV9jbljFIglSpJGbSSIDEj74bjYbgCEtW+oghpuDeA/BB5P2SdvHpsYvRe0ZrbqzgghF8SK6OUMVSsENVePUoroz+pirPWmV7RjS7STwxHzlVm7GVzJRyZ+Db0hwj2Q/Ep/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpjSkiX0k9p7DSXSkxgJgUAeRE7yAs8uUVwINkvXbSM=;
 b=Bq2OmgQ5e+HtFWRwKWCJEOCp+u2vLTBL+Ib/60FTKN1szyI8+gbIZkC3i5OLkN9GQ2ZMTmM+q5nDCPBuNG7N9U/LjnilN+a8V3Oo6DikO4isIwBHi2S+Tzgw1JAKs7W+LtylGIj0yXl8zu/1Yjm154PHiNF/2dzyfkQ2TRaOm6s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5420.eurprd08.prod.outlook.com (52.133.241.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 08:20:27 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 08:20:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
Thread-Index: AQHVTGtMH7YacSuUYU+otoBPFxph3abuSc2AgAA1KACAAWIfgIA27PGAgAAuVgCAAPCoAA==
Date: Thu, 12 Sep 2019 08:20:27 +0000
Message-ID: <0ccc2288-fd76-25f9-0cc7-c92fd8ea5d36@virtuozzo.com>
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
 <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
 <c0f0831f-851b-a76d-208c-22d97e4392d8@virtuozzo.com>
 <57111ad3-6acc-1027-2e5a-f203929e48b6@redhat.com>
 <c773ab2c-368c-825e-dd51-5ff8b5060c2b@virtuozzo.com>
 <f125fc22-98ae-3146-4fba-524da959bf17@redhat.com>
In-Reply-To: <f125fc22-98ae-3146-4fba-524da959bf17@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190912112024819
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23774b17-11ce-4e1b-ab7f-08d7375a112a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5420; 
x-ms-traffictypediagnostic: DB8PR08MB5420:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5420D612FD0236CA9ED5B124C1B00@DB8PR08MB5420.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39840400004)(376002)(136003)(346002)(199004)(189003)(256004)(26005)(2501003)(5660300002)(14444005)(53546011)(186003)(102836004)(76176011)(110136005)(316002)(52116002)(54906003)(66446008)(64756008)(66556008)(66476007)(386003)(66946007)(99286004)(3846002)(6116002)(6506007)(71190400001)(71200400001)(2906002)(8936002)(966005)(107886003)(53936002)(14454004)(81156014)(8676002)(478600001)(4326008)(31686004)(81166006)(11346002)(6436002)(7736002)(486006)(6306002)(305945005)(446003)(25786009)(476003)(6512007)(2616005)(36756003)(229853002)(6486002)(6246003)(31696002)(66066001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5420;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0vcH+nS1MyR3IG6bvoovH5xkBWvWW500lrdRXcQyvczZKOLBsfX0NJq9cMyv742Rm8P1apAvXeQhvg8ZGmLEvfjIE+X6mN55s5S3KV5Qiu+Kd8qW853aDc08qqMaQyfh3W6J8IZzqfHw6l4m0+h2u6P2vzwBdpH7axNFTw8WaP5Ix8XseuanSbDquPVsuJbLBz4B0iR39osgJDs6Mr95dHBF0fvfT1TZzFOvHuh5/1wdFZTKfSz8dY4QrDO2Curr8uAwuZEwkTzu9lTWa0MCsj/HcSoPM49cjMiBaf6nmTx4pdbbrkgX/C21DoqFInqNU09Ug8z8JVxMwfzhOouweM72VFM0DvU6fIC5iYF31lA6dkbhJ0JTN+59T5w+M+ZvvZzaIHrtAa8Je3NLODlVD9oJDi7uOUgJyQ3Ob/10m0w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D208857A9BD3742937C98B85BF0C188@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23774b17-11ce-4e1b-ab7f-08d7375a112a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 08:20:27.3580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAEeWMy0BaZB+DIuOTxyUFYE2/XNhG2UOLaheQ3z3Iq9eSmzNqpLQLSImj5DKvBg7Aji7cgAN+SVbaxZhzcegWecQ9g4oM2f5lNRWULoxXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5420
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.138
Subject: Re: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDkuMjAxOSAyMDo1OSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTEvMTkg
MTE6MTMgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAwNy4wOC4y
MDE5IDE5OjI3LCBKb2huIFNub3cgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDgvNi8xOSAxMjox
OSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDYuMDguMjAx
OSAxOTowOSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24gMDYuMDguMTkgMTc6MjYsIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gaGJpdG1hcF9yZXNldCBoYXMg
YW4gdW5vYnZpb3VzIHByb3BlcnR5OiBpdCByb3VuZHMgcmVxdWVzdGVkIHJlZ2lvbiB1cC4NCj4+
Pj4+PiBJdCBtYXkgcHJvdm9rZSBidWdzLCBsaWtlIGluIHJlY2VudGx5IGZpeGVkIHdyaXRlLWJs
b2NraW5nIG1vZGUgb2YNCj4+Pj4+PiBtaXJyb3I6IHVzZXIgY2FsbHMgcmVzZXQgb24gdW5hbGln
bmVkIHJlZ2lvbiwgbm90IGtlZXBpbmcgaW4gbWluZCB0aGF0DQo+Pj4+Pj4gdGhlcmUgYXJlIHBv
c3NpYmxlIHVucmVsYXRlZCBkaXJ0eSBieXRlcywgY292ZXJlZCBieSByb3VuZGVkLXVwIHJlZ2lv
bg0KPj4+Pj4+IGFuZCBpbmZvcm1hdGlvbiBvZiB0aGlzIHVucmVsYXRlZCAiZGlydGluZXNzIiB3
aWxsIGJlIGxvc3QuDQo+Pj4+Pj4NCj4+Pj4+PiBNYWtlIGhiaXRtYXBfcmVzZXQgc3RyaWN0OiBh
c3NlcnQgdGhhdCBhcmd1bWVudHMgYXJlIGFsaWduZWQsIGFsbG93aW5nDQo+Pj4+Pj4gb25seSBv
bmUgZXhjZXB0aW9uIHdoZW4gQHN0YXJ0ICsgQGNvdW50ID09IGhiLT5vcmlnX3NpemUuIEl0J3Mg
bmVlZGVkDQo+Pj4+Pj4gdG8gY29tZm9ydCB1c2VycyBvZiBoYml0bWFwX25leHRfZGlydHlfYXJl
YSwgd2hpY2ggY2FyZXMgYWJvdXQNCj4+Pj4+PiBoYi0+b3JpZ19zaXplLg0KPj4+Pj4+DQo+Pj4+
Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+DQo+Pj4+Pj4gdjIgYmFzZWQgb24g
TWF4J3MgaHR0cHM6Ly9naXRodWIuY29tL1hhbkNsaWMvcWVtdS5naXQgYmxvY2sNCj4+Pj4+PiB3
aGljaCB3aWxsIGJlIG1lcmdlZCBzb29uIHRvIDQuMSwgYW5kIHRoaXMgcGF0Y2ggZ29lcyB0byA0
LjINCj4+Pj4+PiBCYXNlZC1vbjogaHR0cHM6Ly9naXRodWIuY29tL1hhbkNsaWMvcWVtdS5naXQg
YmxvY2sNCj4+Pj4+Pg0KPj4+Pj4+IHYxIHdhcyAiW1BBVENIXSB1dGlsL2hiaXRtYXA6IGZpeCB1
bmFsaWduZWQgcmVzZXQiLCBhbmQgYXMgSSB1bmRlcnN0YW5kDQo+Pj4+Pj4gd2UgYWxsIGFncmVl
ZCB0byBqdXN0IGFzc2VydCBhbGlnbm1lbnQgaW5zdGVhZCBvZiBhbGlnbmluZyBkb3duDQo+Pj4+
Pj4gYXV0b21hdGljYWxseS4NCj4+Pj4+Pg0KPj4+Pj4+ICAgICBpbmNsdWRlL3FlbXUvaGJpdG1h
cC5oIHwgNSArKysrKw0KPj4+Pj4+ICAgICB0ZXN0cy90ZXN0LWhiaXRtYXAuYyAgIHwgMiArLQ0K
Pj4+Pj4+ICAgICB1dGlsL2hiaXRtYXAuYyAgICAgICAgIHwgNCArKysrDQo+Pj4+Pj4gICAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pj4+DQo+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9oYml0bWFwLmggYi9pbmNsdWRlL3FlbXUv
aGJpdG1hcC5oDQo+Pj4+Pj4gaW5kZXggNGFmYmU2MjkyZS4uNzg2NWU4MTljYSAxMDA2NDQNCj4+
Pj4+PiAtLS0gYS9pbmNsdWRlL3FlbXUvaGJpdG1hcC5oDQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9x
ZW11L2hiaXRtYXAuaA0KPj4+Pj4+IEBAIC0xMzIsNiArMTMyLDExIEBAIHZvaWQgaGJpdG1hcF9z
ZXQoSEJpdG1hcCAqaGIsIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBjb3VudCk7DQo+Pj4+Pj4g
ICAgICAqIEBjb3VudDogTnVtYmVyIG9mIGJpdHMgdG8gcmVzZXQuDQo+Pj4+Pj4gICAgICAqDQo+
Pj4+Pj4gICAgICAqIFJlc2V0IGEgY29uc2VjdXRpdmUgcmFuZ2Ugb2YgYml0cyBpbiBhbiBIQml0
bWFwLg0KPj4+Pj4+ICsgKiBAc3RhcnQgYW5kIEBjb3VudCBtdXN0IGJlIGFsaWduZWQgdG8gYml0
bWFwIGdyYW51bGFyaXR5LiBUaGUgb25seSBleGNlcHRpb24NCj4+Pj4+PiArICogaXMgcmVzZXR0
aW5nIHRoZSB0YWlsIG9mIHRoZSBiaXRtYXA6IEBjb3VudCBtYXkgYmUgZXF1YWwgdG8gQHN0YXJ0
ICsNCj4+Pj4+PiArICogaGItPm9yaWdfc2l6ZSwNCj4+Pj4+DQo+Pj4+PiBzL0BzdGFydCArIGhi
LT5vcmlnX3NpemUvaGItPm9yaWdfc2l6ZSAtIEBzdGFydC8sIEkgdGhpbmsuDQo+Pj4+DQo+Pj4+
IEhhLCBJIHdhbnRlZCB0byBzYXkgc3RhcnQgKyBjb3VudCBlcXVhbCB0byBvcmlnX3NpemUuIFlv
dXJzIGlzIE9LIHRvbyBvZiBjb3Vyc2UuDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+ICAgICAgICBpbiB0
aGlzIGNhc2UgQGNvdW50IG1heSBiZSBub3QgYWxpZ25lZC4gQHN0YXJ0ICsgQGNvdW50DQo+Pj4+
Pg0KPj4+Pj4gK2FyZQ0KPj4+Pj4NCj4+Pj4+IFdpdGggdGhvc2UgZml4ZWQ6DQo+Pj4+Pg0KPj4+
Pj4gUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pj4+DQo+Pj4+
IFRoYW5rcyENCj4+Pj4NCj4+Pg0KPj4+IEknbGwgYWRkIHRoaXMgdG8gdGhlIHBpbGUgZm9yIDQu
MiwgYWZ0ZXIgSSBmaXggdGhlIHJlYmFzZSBjb25mbGljdHMgdGhhdA0KPj4+IGFyb3NlIGZyb20g
NC4xLXJjNC4NCj4+Pg0KPj4NCj4+IEhpIQ0KPj4NCj4+IERpZG4ndCB5b3UgZm9yZ2V0LCBvciBz
aG91bGQgSSByZXNlbmQ/DQo+Pg0KPj4NCj4gDQo+IEkgbXVzdCBoYXZlIGRyb3BwZWQgdGhlIHBh
dGNoIGJ5IGFjY2lkZW50IGR1cmluZyB0aGUgcmViYXNpbmcuIEFzIGFuDQo+IGFwb2xvZ3ksIEkg
c3F1YXNoZWQgaW4gTWF4J3Mgc3VnZ2VzdGlvbnMgZnJvbSB0aGUgbGlzdC4gQ2hlY2sgdGhhdCB0
aGV5DQo+IGxvb2sgT0ssIHBsZWFzZT8NCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBiaXRt
YXBzIHRyZWU6DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUvY29tbWl0cy9i
aXRtYXBzDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9qbnNub3cvcWVtdS5naXQNCj4gDQoNClRoYW5r
cyEgU3RpbGw6DQoNClF1b3RlIGZyb20geW91ciBicmFuY2g6DQoNCiA+ICAgKiBSZXNldCBhIGNv
bnNlY3V0aXZlIHJhbmdlIG9mIGJpdHMgaW4gYW4gSEJpdG1hcC4NCiA+ICsgKiBAc3RhcnQgYW5k
IEBjb3VudCBtdXN0IGJlIGFsaWduZWQgdG8gYml0bWFwIGdyYW51bGFyaXR5LiBUaGUgb25seSBl
eGNlcHRpb24NCiA+ICsgKiBpcyByZXNldHRpbmcgdGhlIHRhaWwgb2YgdGhlIGJpdG1hcDogQGNv
dW50IG1heSBiZSBlcXVhbCB0byBoYi0+b3JpZ19zaXplIC0NCiA+ICsgKiBzdGFydCwgaW4gdGhp
cyBjYXNlIEBjb3VudCBtYXkgYmUgbm90IGFsaWduZWQuIEBzdGFydCArIEBjb3VudCBhcmUNCg0K
cy9zdGFydC9Ac3RhcnQvIChjb3JyZXNwb25kcyB0byBNYXgncyBjb21tZW50LCB0b28pDQoNCkFs
c28sIEknbSBub3Qgc3VyZSBhYm91dCAiYXJlIiBzdWdnZXN0ZWQgYnkgTWF4LiAiYXJlIiBpcyBm
b3IgcGx1cmFsLCBidXQgaGVyZSBJIG1lYW50DQpvbmUgb2JqZWN0OiBzdW0gb2YgQHN0YXJ0IGFu
ZCBAY291bnQuDQoNClNvLCB5b3UgbWF5IHVzZSBleGFjdGx5ICJTdW0gb2YgQHN0YXJ0IGFuZCBA
Y291bnQgaXMiIG9yICIoQHN0YXJ0ICsgQGNvdW50KSBzdW0gaXMiIG9yDQpqdXN0ICIoQHN0YXJ0
ICsgQGNvdW50KSBpcyIsIHdoaWNoZXZlciB5b3UgbGlrZSBtb3JlLg0KDQogPiArICogYWxsb3dl
ZCB0byBiZSBncmVhdGVyIHRoYW4gaGItPm9yaWdfc2l6ZSwgYnV0IG9ubHkgaWYgQHN0YXJ0IDwg
aGItPm9yaWdfc2l6ZQ0KID4gKyAqIGFuZCBAc3RhcnQgKyBAY291bnQgPSBBTElHTl9VUChoYi0+
b3JpZ19zaXplLCBncmFudWxhcml0eSkuDQogPiAgICovDQogPiAgdm9pZCBoYml0bWFwX3Jlc2V0
KEhCaXRtYXAgKmhiLCB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgY291bnQpOw0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

