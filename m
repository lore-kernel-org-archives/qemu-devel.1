Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F713C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B704229F4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pi7TYHMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B704229F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFCi-0002Xe-H8
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50575)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqFCV-00024Q-VG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqFCU-00020h-Ob
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:12:51 -0400
Received: from mail-eopbgr00107.outbound.protection.outlook.com
 ([40.107.0.107]:4327 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqFCT-0001zY-V6; Wed, 24 Jul 2019 07:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk3RnEg6CuciH8Goq3rE+/KKj/0FtJfdSUjNwbJhizHctrWiaNBswbnusHqlqSr0sln5b99Giith1YqfajCuSmZ8SIApl0alxwsO/xnQap6WcDnF3JySwbhjQz2Emgqu6IGBhl478JLqF2zKI2cr40Y1Twgm83BKtq2K1aSY9l7ZHcArDZeLczJzMsqKxgCX+Du29HI141igD6szOA0/tNnzNpK/45NbcJTYarpQ+nfDYyRG7McuRa7YghIXRj3VYCgHB8/pzi+XsRRk3voof0joPwyy5jJnwMB2S2i5iZiSf3IG5lHXMmHEV6nlun3hGITkwUNXIDbkJeK/FxnZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be/HqqUMZ+F1EBFDsEbQylX6EfkQjJsXUgjUeSTdmbw=;
 b=jUXRu1AN8b8ybGrW8aIkmASguqG5LyMoaE0FlQRsLzBFpj6siNH00bVPl17BJ/Kfj9UHeigF8UdryqYPclk3BPZcY0ar/EauVzf6AogP2J6KKh9FWOlQI+R3tZEtt90/sY8n8Ih6dk28lxWH+avxCllm0er8MeHCP5bfTc126tvZLfsfiAZL+BcvGg5TVsJeG5+Mum5ebwlgW6DfILNVG6MqjAnS1H2CJXiaF5zelghk6ThYExbLaHN+Uox2CplCteT4/xEIKxrYNqGCEjgzXBRJK0fTJIG7Ec6s/+p+IlyvWhs5ooUTg8KeQO/eCnFCV/oiVqz9NVTM8RA5zvf4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be/HqqUMZ+F1EBFDsEbQylX6EfkQjJsXUgjUeSTdmbw=;
 b=Pi7TYHMSRqzID08CGo1fCh0AmtWi1JFgE+bOCKOUf0dUEwKm5xdafypXWGw5PJ99J2c+EEO2b/kad+lfY4e6Oq+gKiBlnOmToiq2gw7cIbOgKx0pG26MvnNZzWpAfsLFFXlR8uqM0jCruxHd9zW9v26AxKAyfXVpcxHGlyA21HM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5209.eurprd08.prod.outlook.com (10.255.17.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Wed, 24 Jul 2019 11:12:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 11:12:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 0/3] qapi: block-dirty-bitmap-remove
 transaction action
Thread-Index: AQHVNdk4ZPKxooDMyUuWDIX1m9Wf6abMINeAgA2U5QA=
Date: Wed, 24 Jul 2019 11:12:47 +0000
Message-ID: <dc4deae4-d80c-66a2-df4f-4966a6068767@virtuozzo.com>
References: <20190708220502.12977-1-jsnow@redhat.com>
 <bfd251ed-2f86-f463-b682-cd00c1caba51@redhat.com>
In-Reply-To: <bfd251ed-2f86-f463-b682-cd00c1caba51@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0158.eurprd05.prod.outlook.com
 (2603:10a6:7:28::45) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724141244295
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcdecd29-ca91-45d3-6f33-08d71027dba0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5209; 
x-ms-traffictypediagnostic: DB8PR08MB5209:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB8PR08MB5209FC3129498F42D2A50F86C1C60@DB8PR08MB5209.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(39850400004)(346002)(136003)(52314003)(189003)(199004)(476003)(53936002)(6246003)(36756003)(6512007)(76176011)(31696002)(7416002)(6436002)(6306002)(7736002)(31686004)(110136005)(54906003)(14454004)(305945005)(52116002)(86362001)(229853002)(316002)(561944003)(66946007)(4326008)(66066001)(8676002)(2906002)(5660300002)(26005)(14444005)(68736007)(102836004)(478600001)(486006)(6116002)(186003)(2201001)(966005)(81166006)(11346002)(256004)(81156014)(8936002)(99286004)(6486002)(66476007)(71190400001)(446003)(66446008)(2616005)(3846002)(386003)(2501003)(6506007)(71200400001)(53546011)(64756008)(25786009)(66556008)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5209;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AXqOKw8Yy9QyxboSLfAI4W6DPBXMv7h5/BOJXJQHSSQ/OzEeNlJAuvWJLxFEIBYyYhT5HWEBiQJjwv2d99B1LdFWzXj53meWbmkQAlm2jh6Smbw+TKd/ZHEvMMNu9ZaVW4sYGWWJdqYtChbR559Jp5p2d3ijJXFTBPQRhFHky5n2A7sYz6ghqgK1jip47qRJu0v7mRG5Jp3jIjh3IS3ZN1FlmwTLVWonm6BkhtKAmjCoQ5/gre458PpLK56coshfge+B8nA5uv0K43Pp1ROkRPedzCVHrzNirPs4XJFA3WLPaVGrkE9Ycg+rdrjlQtZBenrLBIJrxns14C7TtiTusmtHDdn1uPUr5ZihD0SHpJHxJCpeuo3kNSMN4iiqixRzvA/8zlBbSqF2lWAgPqMFdYZvWXXVZGnEeWsjj5tT/wI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AF15F9D90563942A47EF44FDFC76B47@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdecd29-ca91-45d3-6f33-08d71027dba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 11:12:47.3390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5209
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.107
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qapi: block-dirty-bitmap-remove
 transaction action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDcuMjAxOSAyMjo0OCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvOC8xOSA2
OjA0IFBNLCBKb2huIFNub3cgd3JvdGU6DQo+PiBIaSwgdGhpcyBpcyBhIHByb3Bvc2FsIGJhc2Vk
IG9mZiBvZiBWbGFkaW1pcidzIHBhdGNoc2V0Og0KPj4gW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzRd
IHFhcGk6IGJsb2NrLWRpcnR5LWJpdG1hcC1yZW1vdmUgdHJhbnNhY3Rpb24gYWN0aW9uDQo+Pg0K
Pj4gPT09DQo+PiBWMzoNCj4+ID09PQ0KPj4NCj4+IDAwMS8zOlstLS0tXSBbLS1dICdibG9ja2Rl
djogcmVkdWNlIGFpb19jb250ZXh0IGxvY2tlZCBzZWN0aW9ucyBpbiBiaXRtYXAgYWRkL3JlbW92
ZScNCj4+IDAwMi8zOlswMDI0XSBbRkNdICdxYXBpOiBpbXBsZW1lbnQgYmxvY2stZGlydHktYml0
bWFwLXJlbW92ZSB0cmFuc2FjdGlvbiBhY3Rpb24nDQo+PiAwMDMvMzpbLS0tLV0gWy0tXSAnaW90
ZXN0czogdGVzdCBiaXRtYXAgbW92aW5nIGluc2lkZSAyNTQnDQo+Pg0KPj4gLSBDaGFuZ2VkICJz
cXVlbGNoX3BlcnNpc3RlbmNlIiB0byAic2tpcF9zdG9yZSINCj4+IC0gVXNlIE1heCdzIHN1Z2dl
c3Rpb24gZm9yIHJldHVybiBleHByDQo+Pg0KPj4gPT09DQo+PiBWMjoNCj4+ID09PQ0KPj4NCj4+
IEl0IHJlcGxhY2VzIHBhdGNoZXMgdHdvIGFuZCB0aHJlZSB3aXRoIGEgbW9kaWZpZWQgcGF0Y2gg
KG5vdyBwYXRjaCAyKQ0KPj4gdGhhdCBmb3JlZ29lcyB0aGUgbmVlZCBmb3IgYSBoaWRlKCkvdW5o
aWRlKCkgYml0bWFwIEFQSS4gSSB0aGluayBpdCdzDQo+PiBzdWl0YWJsZSBhcyBhIHNtYWxsZXIg
YWx0ZXJuYXRpdmUsIGJ1dCBJJ20gbm90IHN1cmUgaWYgaXQgY292ZXJzIGFsbA0KPj4gb2YgdGhl
IHVzZSBjYXNlcyBvZiB0aGUgb3JpZ2luYWwgc2VyaWVzLg0KPj4NCj4+IFBhdGNoZXMgMSBhbmQg
MyAoZm9ybWVybHkgNCkgaW5jbHVkZWQgYXMtaXMuDQo+Pg0KPj4gSm9obiBTbm93ICgxKToNCj4+
ICAgIHFhcGk6IGltcGxlbWVudCBibG9jay1kaXJ0eS1iaXRtYXAtcmVtb3ZlIHRyYW5zYWN0aW9u
IGFjdGlvbg0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIpOg0KPj4gICAg
YmxvY2tkZXY6IHJlZHVjZSBhaW9fY29udGV4dCBsb2NrZWQgc2VjdGlvbnMgaW4gYml0bWFwIGFk
ZC9yZW1vdmUNCj4+ICAgIGlvdGVzdHM6IHRlc3QgYml0bWFwIG1vdmluZyBpbnNpZGUgMjU0DQo+
Pg0KPj4gICBibG9jay5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4+ICAgYmxv
Y2svZGlydHktYml0bWFwLmMgICAgICAgICAgIHwgIDE1ICsrKy0tDQo+PiAgIGJsb2NrZGV2LmMg
ICAgICAgICAgICAgICAgICAgICB8IDEwNSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0NCj4+ICAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCAgIHwgICAyICstDQo+PiAgIG1p
Z3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8ICAgMiArLQ0KPj4gICBxYXBpL3RyYW5zYWN0
aW9uLmpzb24gICAgICAgICAgfCAgIDIgKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU0ICAg
ICAgICAgfCAgMzAgKysrKysrKysrLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU0Lm91dCAg
ICAgfCAgODIgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICA4IGZpbGVzIGNoYW5nZWQs
IDIwNiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCj4+DQo+IA0KPiBUaGFua3MsIGFw
cGxpZWQgdG8gbXkgYml0bWFwcyB0cmVlOg0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL2puc25v
dy9xZW11L2NvbW1pdHMvYml0bWFwcw0KPiBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUu
Z2l0DQo+IA0KPiAtLWpzDQo+IA0KPiANCj4gKFZsYWRpbWlyOiBpZiB0aGlzIGlzbid0IGFtZW5h
YmxlIHRvIHlvdSwgaXQncyBnb2luZyBpbiBmb3IgNC4yLCBzbyB3ZQ0KPiBoYXZlIHVudGlsIHRo
ZSBuZXh0IGZyZWV6ZSB0byBjaGFuZ2UgaXQuIExldCBtZSBrbm93LCBPSz8pDQo+IA0KDQoNCkFu
ZCBmaW5hbGx5IEknbSBoZXJlIDopDQoNClRoYW5rcyBhIGxvdCBmb3IgZG9pbmcgdGhpcyBqb2Ig
YW5kIGZvciB5b3VyIGV4cGxhbmF0aW9ucyBpbiBvdGhlciB0aHJlYWRzIHdoaWNoDQpJJ20gcmVh
ZGluZyB0b2RheSBhbmQgc29ycnkgZm9yIHRoZSBkZWxheSEgSSdsbCBsb29rIHRocm91Z2ggdGhl
c2Ugc2VyaWVzIHNvb24uDQoNCkFjdHVhbGx5LCBteSBzZWNvbmQgY2hpbGQgKGdpcmw6KSB3YXMg
Ym9ybiBhIG1vbnRoIGFnbywgYW5kIHRoZW4gaGVyIGVsZGVyIGJyb3RoZXINCndhcyBpbGwsIHNv
IEkgdG9vayB0d28gd2Vla3Mgc2ljayBsZWF2ZSBhZnRlciBhYm91dCB0d28gd2Vla3MgdmFjYXRp
b24gYW5kIGZvcmdldA0KYWJvdXQgd29yayBmb3IgYSBtb250aC4NCg0KSG1tLiBBbmQgTmlrb2xh
eSwgd2hvIGRvaW5nIGxpYnZpcnQgcGFydCBpcyBvbiB2b2NhdGlvbiBub3cgKEkgc3RhcnRlZCBi
aXRtYXAgcmVtb3ZlDQp0cmFuc2FjdGlvbiBzZXJpZXMgYnkgaGlzIHJlcXVlc3QpLCBzbyBJIGRv
bid0IGtub3cgYWJvdXQgdGhlIGVuZCBvZiB0aGUgc3Rvcnkgd2l0aA0KcmVsZWFzZSBhbmQgdGhp
cyBmdW5jdGlvbmFsaXR5Li4NCg0KQW55d2F5LCBpdCdzIGNvb2wsIHRoYW5rcyENCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

