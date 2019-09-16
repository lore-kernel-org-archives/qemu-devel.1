Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C8C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5297C20678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="i+MWeBE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5297C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tgu-0001s8-LH
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9sQq-0003zs-D8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9sQo-0004Um-Vr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:56:48 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com
 ([40.107.1.102]:16547 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9sQl-0004T2-3o; Mon, 16 Sep 2019 10:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhxlr2s6Ze9f7Bk4oceETI1mwP4QSQcKb3zxT0GAlftn2+QInrhVk/GbJCL7oGBnr7pZ1AdSy3yhLygjkKOKh3vE5wadvpqgixEKKhIfjuj1ob43ftuZnWWLfDz6ab8Lm43g5/2hgYsdRVB/M1/PSS1qdFePpDD2JjCP118NIRgxDe07veeKOgbQdy291NjqcxfzaKEp65vFtiMGG3fcCF7I4CAfBVQ3s/o5Qz3GDvFGxjI8ZRh9Zo1N3UPsCo3BVDINk+IPmOvMpV0dlyWkBpWunpa3U5aIGQ8WZeENU15VPggJ21jQmvnj237nobSeV3NlviJUpy91eECtWOZ8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y5Ig7Pqpd3gskmiV0cXjTgVKZO6go3uPkFDSq0Iivc=;
 b=PT2FqrKupxDH8XQf8YsCmWwwtHpFQgueHHEMUkHZ4qW0Po/PjJ8Pk2TphwffJZ73FByIcLXyNr+dCITch26N+e8YEgWvNp/LjNJkr+sUHDimYZR+IcAOHD0fv+Q3EietGGVsVcda06f5aZACGJS4M4PdkW2RDBJCv13zuRN+kOzQA75q8f+0kydUdQJ+QdvfQ2EgalVlrURixS6vB4nE7fgqA4VbLv3ktf7b/aWBugVhh/7J3xvkfSbxJ5yMt/ocda2Htj4FnkREeHmgoGAlS26opyiAvPRm+I2c8fz0ERFiPfQFZxqnFuB/Iw5MaOuy6TDI4ijuwltR2u01Meu2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y5Ig7Pqpd3gskmiV0cXjTgVKZO6go3uPkFDSq0Iivc=;
 b=i+MWeBE9/kM7y1c/zql+C8yLf9cRqmcbSFW+oPMWYAvMYo+w5mQm/4uifFXHvuwdtVt9dNFXrCiEaCySmZkCckorq+KpVX7qS+aBdCyPWNNSzWZwd1ITFSv7hs/qv7j/2r2bOgM1Ftmr9XGqK5ES/BIgVIOjpXYJ2JGHWiZNQVg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5147.eurprd08.prod.outlook.com (10.255.17.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 14:56:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 14:56:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
Thread-Index: AQHVaP+sHvXQg5mIX0qbfLdZwy5qOKcua+GA
Date: Mon, 16 Sep 2019 14:56:40 +0000
Message-ID: <974b64b8-a191-c529-4e77-6a38b372c4b8@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-2-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0166.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190916175637794
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 838266ad-1ad4-42ba-cd3f-08d73ab614f9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5147; 
x-ms-traffictypediagnostic: DB8PR08MB5147:
x-microsoft-antispam-prvs: <DB8PR08MB51476C7C3BC3051945720119C18C0@DB8PR08MB5147.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(376002)(366004)(136003)(346002)(52314003)(189003)(199004)(5660300002)(2906002)(486006)(53936002)(36756003)(66446008)(66946007)(6512007)(64756008)(66476007)(76176011)(52116002)(66556008)(31686004)(81156014)(8676002)(6436002)(14454004)(86362001)(478600001)(446003)(11346002)(229853002)(31696002)(81166006)(71190400001)(4326008)(2616005)(476003)(2501003)(71200400001)(25786009)(3846002)(6486002)(6246003)(8936002)(256004)(6116002)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5147;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IHiC1UTsxLQtFgp1gQTPePsCZ2dl62RKDJiNgvHlKRU4YQP3CyyJVPK2pLv3zn7vKhzm3u2ioeONSZy3LDqvpXBBSEcmLzKv/mVpxuows/7ELPD16iouc9kfdQRC0BrdwLc6nnmoJhC4CA+gQyYZkLazneE/gXuQ4XOdni4NIP6lA/5WveTJ+9OvcgCln9dHkWfHnXCgjQF7gtB/aHzwXZjYBamAOXDgWFAfJ/6jlSfm4uZK866ZyLRJ3VCIuhx+IjvM/s56OyQGeUMFQNVmCGp88/NCGXC2vKdFSnsZ/uiHpVxRe+++kSMW8lFFla7Eu+YLegGb77r4viL3eAS/AOUnO3ZlF3yAt5nKl9yLjlHBrMQalxa7rJ3B44FubKn4JSjpqmUoB7HVhtHWixGfH3qh9B8VaAIrKl7cvAqCrgU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A00BC0D63BF584C8FC76A559CEF7BDB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838266ad-1ad4-42ba-cd3f-08d73ab614f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 14:56:40.8079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AE3Ai7WodpxDeX/n0YjMA26/trFAQNSNaF44i+tT0uTOfTPxGN+7FHvZ+aImXWckVnIdhCj289mTS6xxmbM+8HgvHsWSPIwYxyLINkCzkeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5147
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.102
Subject: Re: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAzOjE2LCBKb2huIFNub3cgd3JvdGU6DQo+IExpa2Ugc2NyaXB0X21haW4sIGJ1
dCBkb2Vzbid0IHJlcXVpcmUgYSBzaW5nbGUgcG9pbnQgb2YgZW50cnkuDQo+IFJlcGxhY2UgYWxs
IGV4aXN0aW5nIGluaXRpYWxpemF0aW9uIHNlY3Rpb25zIHdpdGggdGhpcyBkcm9wLWluIHJlcGxh
Y2VtZW50Lg0KPiANCj4gVGhpcyBicmluZ3MgZGVidWcgc3VwcG9ydCB0byBhbGwgZXhpc3Rpbmcg
c2NyaXB0LXN0eWxlIGlvdGVzdHMuDQo+IA0KPiBOb3RlOiBzdXBwb3J0ZWRfb3Nlcz1bJ2xpbnV4
J10gd2FzIG9taXR0ZWQsIGFzIGl0IGlzIGEgZGVmYXVsdCBhcmd1bWVudC4NCg0KQnV0IGFmdGVy
IHRoaXMgcGF0Y2ggYWxsIHRlc3Qgd2hpY2ggZGlkbid0IGNoZWNrIG9zIHN0YXJ0IHRvIGNoZWNr
IGxpbnV4DQooYXMgaXQncyBkZWZhdWx0KS4uIFNvIGFsbCB0ZXN0cyB3aGljaCB3b3JrZWQgb24g
b3RoZXIgcGxhdGZvcm1zIHdpbGwgbm93DQpiZSBza2lwcGVkIG9uIHRoZXNlIG90aGVyIHBsYXRm
b3Jtcz8NCg0KRmluYWxseSBkbyB3ZSBzdXBwb3J0IHNvbWV0aGluZyBleGNlcHQgbGludXggZm9y
IGlvdGVzdHM/DQpmb3IgYmFzaCB0ZXN0cyBfc3VwcG9ydGVkX29zIGFsc28gdXNlZCBvbmx5IHdp
dGggIkxpbnV4IiBpbiA4NyB0ZXN0cy4uDQoNCk1heSBiZSB3ZSdkIGJldHRlciBkcm9wIGJvdGgg
X3N1cHBvcnRlZF9vcyBhbmQgc3VwcG9ydGVkX29zZXMgYWxsdG9nZXRoZXIsDQphbmQgZG9uJ3Qg
Y2FyZT8NCg0KQW55d2F5LCBpZiB3ZSBzdXBwb3J0IG9ubHkgbGludXgsIGFueSByZWFzb24gdG8g
c2tpcCBhbG1vc3QgYWxsIHRlc3RzLA0KaWYgc29tZW9uZSB0cmllcyB0byBydW4gdGVzdCBvbiBv
dGhlciBwbGF0Zm9ybT8gTGV0IGhpbSBydW4gd2hhdCBoZSB3YW50cy4NCg0KPiBTaWduZWQtb2Zm
LWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+IC0tLQ0KDQpbLi5dDQoNCj4gK2Rl
ZiBleGVjdXRlX3Rlc3QodGVzdF9mdW5jdGlvbj1Ob25lLCAqYXJncywgKiprd2FyZ3MpOg0KPiAr
ICAgICIiIlJ1biBlaXRoZXIgdW5pdHRlc3Qgb3Igc2NyaXB0LXN0eWxlIHRlc3RzLiIiIg0KPiAr
DQo+ICsgICAgZGVidWcgPSBleGVjdXRlX3NldHVwX2NvbW1vbigqYXJncywgKiprd2FyZ3MpDQo+
ICAgICAgIGlmIG5vdCB0ZXN0X2Z1bmN0aW9uOg0KPiAtICAgICAgICBleGVjdXRlX3VuaXR0ZXN0
KG91dHB1dCwgdmVyYm9zaXR5LCBkZWJ1ZykNCj4gKyAgICAgICAgZXhlY3V0ZV91bml0dGVzdChk
ZWJ1ZykNCj4gICAgICAgZWxzZToNCj4gICAgICAgICAgIHRlc3RfZnVuY3Rpb24oKQ0KPiAgIA0K
PiArIyBUaGlzIGlzIGNhbGxlZCBmcm9tIHNjcmlwdC1zdHlsZSBpb3Rlc3RzIHdpdGhvdXQgYSBz
aW5nbGUgcG9pbnQgb2YgZW50cnkNCj4gK2RlZiBzY3JpcHRfaW5pdGlhbGl6ZSgqYXJncywgKipr
d2FyZ3MpOg0KPiArICAgICIiIkluaXRpYWxpemUgc2NyaXB0LXN0eWxlIHRlc3RzIHdpdGhvdXQg
cnVubmluZyBhbnkgdGVzdHMuIiIiDQo+ICsgICAgZXhlY3V0ZV9zZXR1cF9jb21tb24oKmFyZ3Ms
ICoqa3dhcmdzKQ0KPiArDQo+ICsjIFRoaXMgaXMgY2FsbGVkIGZyb20gc2NyaXB0LXN0eWxlIGlv
dGVzdHMgd2l0aCBhIHNpbmdsZSBwb2ludCBvZiBlbnRyeQ0KPiAgIGRlZiBzY3JpcHRfbWFpbih0
ZXN0X2Z1bmN0aW9uLCAqYXJncywgKiprd2FyZ3MpOg0KPiAgICAgICAiIiJSdW4gc2NyaXB0LXN0
eWxlIHRlc3RzIG91dHNpZGUgb2YgdGhlIHVuaXR0ZXN0IGZyYW1ld29yayIiIg0KPiAgICAgICBl
eGVjdXRlX3Rlc3QodGVzdF9mdW5jdGlvbiwgKmFyZ3MsICoqa3dhcmdzKQ0KPiAgIA0KPiArIyBU
aGlzIGlzIGNhbGxlZCBmcm9tIHVuaXR0ZXN0IHN0eWxlIGlvdGVzdHMNCj4gICBkZWYgbWFpbigq
YXJncywgKiprd2FyZ3MpOg0KPiAgICAgICAiIiJSdW4gdGVzdHMgdXNpbmcgdGhlIHVuaXR0ZXN0
IGZyYW1ld29yayIiIg0KDQoNCkhtbSwgbm93IHR3byBkaWZmZXJlbnQgc3R5bGVzIG9mIGNvZGUg
ZG9jdW1lbnRpbmcgdXNlZDogY29tbWVudCBhbmQgZG9jLXN0cmluZywNCmJvdGggY29udGFpbmlu
ZyBhbG1vc3QgZXF1YWwgbWVhbmluZy4uIEkgZG9uJ3QgbGlrZSBpdCwgc3RpbGwgZG9uJ3QgcmVh
bGx5IG1pbmQuDQoNCj4gICAgICAgZXhlY3V0ZV90ZXN0KE5vbmUsICphcmdzLCAqKmt3YXJncykN
Cj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

