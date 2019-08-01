Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF38C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC44220679
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bcI7SnhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC44220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htE2h-00075e-5H
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54967)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htE15-0005qa-RV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htE14-0004Em-Av
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:33:23 -0400
Received: from mail-ve1eur02on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::704]:59957
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htE0z-0004Bw-DQ; Thu, 01 Aug 2019 12:33:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaXp4sYtLJ1/x/xAk9TvdNSVipNHc67kWIwnbF8gcyfcKZSKfHEqpItdXG5xuhFprBTiFZAFiweoxzrExitd0VaqUg4RH9ysNrxJRnMoZmWDS/pI4JSMbe2zGAhkFFyw8rSWisuOZU1AlgajgXywzRGo6niWvEmfD9XeM5ZWlOHFGRM6mVhXI9KooRXhIJ5Y2e0dq3lMwfDkR3auMy+5/i4bzVHptpTgfR9psr48vki9cJoostVz2Ef98DZr2UczpjE45sno/GdlHC1H6SzWGpNhe1Z5YrJUSrWCb6dIInZQQTeZqpPhtRvGsioqjyYAF+ZCIS9G+OLKxg8MTqcVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV9tPrwzF3HLmsyj5fbDP3EN6L8Bzpt5DRi/2uOgbzo=;
 b=bsiV0w7a0MJRnY3sgTb3PGJis4776PWVpumEQvvI0uJWHcxDlYJbuIv7J5ctw7kiMlxSb20PC3On+nskwsz45mEmLqisX3QzhNUIG/zAjYCUx06EpymMenKgiPrmVBUb8hmC54242YDSOlMIklsaHl2e5R+iTQZaHjI8/8DSdpBG4DeNnrIwyOSdhbnbwEA2SIxBhP8B1zQMxLKdviGB7jPUHS7y/+utHpeQMyy8tWMP4o7Fh+6IZST5saXO02UVkwNqjaNedEYdOqkq2dRZ8nX9JrziMntSsH7w9HO0oB1QuWt0Y8ljVGRU59lauhphiGPy26D3HpvGOMmUaWHeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV9tPrwzF3HLmsyj5fbDP3EN6L8Bzpt5DRi/2uOgbzo=;
 b=bcI7SnhR9Dh/dudYGZMHoRoVSqeUce3jSaQnf6CqOr2l65XWNgAx6DzVT4dW8bNEntPge+ZUab68OQjvFD2hj/ZDeN4b9+yXRkRoOgimcfOt/7DKLLrLmvm5ZgN/R0dcE7UYs9AoDyy5w3oQkgxeLI0gNHUMniepZ0ZxyBJh/Tk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5419.eurprd08.prod.outlook.com (52.133.241.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 1 Aug 2019 16:33:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 16:33:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 0/2] backup: Copy only dirty areas
Thread-Index: AQHVSHuPSt9Ywb4N7Ue2ptvbXBjziqbmfKcA
Date: Thu, 1 Aug 2019 16:33:15 +0000
Message-ID: <0d84e9f9-7067-16da-10ac-c1dff9b38510@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
In-Reply-To: <20190801151235.8434-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801193312211
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f95d00a-4a90-45db-6123-08d7169df39d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5419; 
x-ms-traffictypediagnostic: DB8PR08MB5419:
x-microsoft-antispam-prvs: <DB8PR08MB5419D62BE7F54D01EB9E041EC1DE0@DB8PR08MB5419.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(396003)(346002)(39850400004)(189003)(199004)(316002)(6506007)(6246003)(6436002)(66066001)(486006)(6486002)(229853002)(386003)(110136005)(54906003)(71200400001)(71190400001)(31686004)(446003)(25786009)(36756003)(2501003)(26005)(476003)(4326008)(478600001)(102836004)(2906002)(11346002)(14454004)(3846002)(6116002)(186003)(76176011)(31696002)(86362001)(8676002)(66556008)(2616005)(81166006)(256004)(53936002)(99286004)(81156014)(8936002)(66946007)(7736002)(52116002)(66446008)(66476007)(68736007)(305945005)(64756008)(5660300002)(6512007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5419;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5MJVwso49nal95HoP9Y+vHfxF4Cyli8Dqx0zY/K1qxYuzMR/KmpM/bU2dbDXA6axhDAS+oHT00DqwEkMLEeMjR84h9IdY7Hcicj8zeR4bUr0CC/QxNL2jcxNqlHxz17uQy978f/Rm6zH9VttPV55+qzJjl7vb9uXU9rNjm6SraNd5iKDDLJxEXC9FC1wq+KqQ1zZkbGh28K7qggAuATfiSF4Cb7gM8Ig/RdTI76p3FbVmufG17l4oddFlNbG5hqx47NygWzHfDxHrd5Ie8jsWXZXRnRFUCYD0g5+VvIQyTO9heCDLGGjK83vUSN/CGdy93YUDgcMJGhucMDhZ1TWHM45PhnUJGUXW3/gLIZ+/rRm3mPi2JM7xdd1SUzP9oEL6txOy4MJv7fMazKPJkuYJ5+D1ZrXN4NA0jKT5zPsQI8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE8B4D642AC23B47AFDC1AD7D00E12D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95d00a-4a90-45db-6123-08d7169df39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:33:15.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::704
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] backup: Copy only dirty areas
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAxODoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBIaSwNCj4gDQo+IEluIGEgZGlz
Y3Vzc2lvbiB3aXRoIFZsYWRpbWlyIHRvZGF5LCB3ZSBub3RpY2VkIHRoYXQgdGhlIGJhY2t1cCBq
b2INCj4gY3VycmVudGx5IGlzIHByZXR0eSBicm9rZW4gd2hlbiB1c2luZyBjb3B5IG9mZmxvYWRp
bmcuICBJIGRvbuKAmXQga25vdw0KPiBhYm91dCB5b3UsIGJ1dCBteSBsb2NhbCBmaWxlc3lzdGVt
IChYRlMpIHN1cHBvcnRzIGNvcHkgb2ZmbG9hZGluZywgc28NCj4gdGhlIGpvYiB1c2VzIGl0IGF1
dG9tYXRpY2FsbHkuICBUaGF0IG1lYW5zLCB0aGF0IGJhY2t1cCBpcyBicm9rZW4gYW5kDQo+IGhh
cyBiZWVuIGJyb2tlbiBmb3IgYSB5ZWFyIG9uIG15IGxvY2FsIEZTLg0KPiANCj4gVGhlIGxhc3Qg
d29ya2luZyB2ZXJzaW9uIHdhcyAyLjEyLCBzbyB0aGlzIGlzbuKAmXQgYSByZWdyZXNzaW9uIGlu
IDQuMS4NCj4gV2UgY291bGQgdGh1cyBqdXN0aWZ5IG1vdmluZyBpdCB0byA0LjIuICBCdXQgSSB0
aGluayB0aGlzIHNob3VsZCByZWFsbHkNCj4gZ28gaW50byA0LjEsIGJlY2F1c2UgdGhpcyBpcyBu
b3QgcmVhbGx5IGFuIGVkZ2UgY2FzZSBhbmQgYXMgZmFyIGFzIEkNCj4ga25vdyB1c2VycyBjYW5u
b3QgZG8gYW55dGhpbmcgdG8gcHJldmVudCB0aGUgYmFja3VwIGpvYiBmcm9tIHBlcmZvcm1pbmcN
Cj4gY29weSBvZmZsb2FkaW5nIGlmIHRoZSBzeXN0ZW0gYW5kIGFsbCBpbnZvbHZlZCBibG9jayBk
cml2ZXJzIHN1cHBvcnQgaXQuDQo+IEkganVzdCB3b25kZXIgd2h5IG5vYm9keSBoYXMgbm90aWNl
ZC4uLg0KPiANCg0KQWdyZWUuIEFuZCBpZiB0aGlzIGdvZXMgaW50byA0LjEsIEkgc3VnZ2VzdCB0
byBhZGQNCltQQVRDSCAyLzNdIGJsb2NrL2JhY2t1cDogZGlzYWJsZSBjb3B5X3JhbmdlIGZvciBj
b21wcmVzc2VkIGJhY2t1cA0KDQphcyBmb3Igbm93IGNvbXByZXNzZWQgYmFja3VwIGp1c3QgZG9u
J3QgY29tcHJlc3MgYW55dGhpbmcgb24gRlMgd2l0aA0KY29weSBvZmZsb2FkaW5nIHN1cHBvcnRl
ZC4NCg0KPiANCj4gTWF4IFJlaXR6ICgyKToNCj4gICAgYmFja3VwOiBDb3B5IG9ubHkgZGlydHkg
YXJlYXMNCj4gICAgaW90ZXN0czogVGVzdCBiYWNrdXAgam9iIHdpdGggdHdvIGd1ZXN0IHdyaXRl
cw0KPiANCj4gICBibG9jay9iYWNrdXAuYyAgICAgICAgICAgICB8IDEzICsrKysrKysrKysrLS0N
Cj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDU2ICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dCB8ICA0ICsrLS0N
Cj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

