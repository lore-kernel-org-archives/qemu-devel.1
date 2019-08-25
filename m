Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F44206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O6zzifMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F44206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1uO6-0007H8-Qq
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 11:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1uNK-0006lJ-KF
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1uNJ-000422-Eu
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:24:14 -0400
Received: from mail-eopbgr130091.outbound.protection.outlook.com
 ([40.107.13.91]:62599 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i1uNF-0003z1-Oa; Sun, 25 Aug 2019 11:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/N29Ed6SgUlGqnIyJYjVT+XsP3XpNlQtz9BegHSevnv4xeFNbgn1i4w+lhO6QG9hGjEu3frTKV4Rx7EQwoe41910nog9RODQcA+CHXoEUsOIXnjTFEfWaToWroOdDfl6HpKpZbASvY7RzKJ07CC4tiw4eBNWEyRxhWSZOnscKmUBBdO5Y34YGoyIXfzb/3s5VLdwppPFVzdet1eS5VA5ABC3BXtmKOEzhK7yntYScXJBZ6Oixt3r4pmaGKtU0T4NVJiHVF11sR99nD/09ik/0QIiSlL8iRZhN5u1qTms28UioMhHtHPtLPtFM4ru8lEdM4T6EoSRB5Bmy5NRzAJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg4e6/s0wN70WjnBLstPOD6V9xRkUh/KvE4V6hGyXfY=;
 b=eCfmZGEejJv0+2Lciek+w+2IQyEEonza0bWjNbPrIgwEm+tpdtLQm+A3iRkHk9kkeE8UdTZT9a1Y/mTI63liYdX9qsVf/RszOz/Uf2ft1Nwk1+UGdxcZ8WQoY14G1K+YHpb25iceKBy1JZn747NhN838TsNKOkumm1nPeI23psDIXGbVyEa+azO3InoeRRiPL5L8/+SzTxkEq/Vj5FGLYNT3rCwQR5URB6RjOxK9XFJoaGUC6lIZnT6ycoOs7IyNi9U+HHH+Ssl5EJKEVU2A4+4XP4uc7qflNXHHEOPdXYLzsSRA1IXj3AfxOAmGZw5Kcan+d/896gxXPxInfzfkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg4e6/s0wN70WjnBLstPOD6V9xRkUh/KvE4V6hGyXfY=;
 b=O6zzifMjIMvkrJkAMrcW26WIGXiM9GAFr4HPeBxXn4Ru+fBkcAXFpti+xXrHn4Rqb5pGzxzYdAQ2E30ELZMt+QcG5h8Lldx16/ZA6gL+TdkbCZBIkaCLR/onkkKGFzJ4KRVp4OicDRCpl2246pUfV36XLuZllF+6IZ6ofAW/FFo=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3567.eurprd08.prod.outlook.com (20.177.61.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sun, 25 Aug 2019 15:24:04 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 15:24:04 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v5 4/6] iotests: Valgrind fails with
 nonexistent directory
Thread-Index: AQHVPk9L3/ITZiX1kkydw2eCRwLO7qb9HeMAgA8XvIA=
Date: Sun, 25 Aug 2019 15:24:04 +0000
Message-ID: <4b77f137-07c2-94ea-ec72-3d8d5c0ad5f7@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <8b68a897-4ff9-5517-d7ad-3f7a18f12be7@redhat.com>
In-Reply-To: <8b68a897-4ff9-5517-d7ad-3f7a18f12be7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::41)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9668da7b-39aa-4449-38c5-08d729704371
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3567; 
x-ms-traffictypediagnostic: VI1PR08MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB356782CE744D76DC8407E660F4A60@VI1PR08MB3567.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39830400003)(136003)(396003)(199004)(189003)(6512007)(53546011)(25786009)(26005)(102836004)(36756003)(6506007)(76176011)(4326008)(186003)(52116002)(54906003)(110136005)(6116002)(3846002)(478600001)(2906002)(6436002)(8676002)(66946007)(2501003)(81166006)(81156014)(6486002)(316002)(2201001)(86362001)(8936002)(256004)(14444005)(31696002)(14454004)(7736002)(66066001)(99286004)(6246003)(446003)(486006)(31686004)(71200400001)(53936002)(107886003)(71190400001)(44832011)(5660300002)(11346002)(476003)(229853002)(305945005)(2616005)(386003)(66476007)(64756008)(66446008)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3567;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4ZcA8NnsHOgK5TYjC1vFoTx1QKfefvoXc658xuA3LHj9GVbkIjDDA+Phqj3Hkf8aHClerV7LNXZj2aGV+/hbkYuNAmVAn66I4d1EXvFrgiNXSgP+Ey95k5mFb43Yq3cl2drJsaX5Eeh6FPkKJBvx6zxwRbGz3Nyufhtcriuxo7iH46FPdop0rVru0x7mAyWvnYgqwY3blCsegjHTAoNCFApweYDipaZGiEpHXacdTymfF20F0yFttNpn1tdTdCElxwvliKdIXdaneJbltcPdnG7ieJCWObBSywmXdOX3w7w2IO17SxDSJQfQsi/j8xGAFv50fNqJFfhfyYSssVvoOmDEflHoeT00tiR2lBFst+BgeL9lBDuicGSTSsjP5+T55C788ti9N2l4Ile6wy29MIsjJubRnc+yZ5UgDAdhBc8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDC67D9E3FD8DC4CBC7C420EE42FA33E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9668da7b-39aa-4449-38c5-08d729704371
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 15:24:04.4531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+SON0Fuv8ONazlVcuewjUSrX8TQ/hvu6Db36HPkXCsglsfG9jiva5hVaZU/rjI2ytH8i62wpzL20c2emXo5DC3FYNenMni/32fFGKtZuGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3567
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.91
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 4/6] iotests: Valgrind
 fails with nonexistent directory
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LzA4LzIwMTkgMDM6NTUsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA3
LzE5LzE5IDEyOjMwIFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFRoZSBWYWxncmlu
ZCB1c2VzIHRoZSBleHBvcnRlZCB2YXJpYWJsZSBUTVBESVIgYW5kIGZhaWxzIGlmIHRoZQ0KPj4g
ZGlyZWN0b3J5IGRvZXMgbm90IGV4aXN0LiBMZXQgdXMgZXhjbHVkZSBzdWNoIGEgdGVzdCBjYXNl
IGZyb20NCj4+IGJlaW5nIHJ1biB1bmRlciB0aGUgVmFsZ3JpbmQgYW5kIG5vdGlmeSB0aGUgdXNl
ciBvZiBpdC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZp
Y2hAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDUxIHwg
NCArKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTEN
Cj4+IGluZGV4IGNlOTQyYTUuLmY4MTQxY2EgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlv
dGVzdHMvMDUxDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDUxDQo+PiBAQCAtMzc3LDYg
KzM3NywxMCBAQCBwcmludGYgJWIgInFlbXUtaW8gJGRldmljZV9pZCBcIndyaXRlIC1QIDB4MzMg
MCA0a1wiXG5jb21taXQgJGRldmljZV9pZFxuIiB8DQo+PiAgICRRRU1VX0lPIC1jICJyZWFkIC1Q
IDB4MzMgMCA0ayIgIiRURVNUX0lNRyIgfCBfZmlsdGVyX3FlbXVfaW8NCj4+ICAgDQo+PiAgICMg
VXNpbmcgc25hcHNob3Q9b24gd2l0aCBhIG5vbi1leGlzdGVudCBUTVBESVINCj4+ICtpZiBbICIk
e1ZBTEdSSU5EX1FFTVV9IiA9PSAieSIgXTsgdGhlbg0KPj4gKyAgICBfY2FzZW5vdHJ1biAiVmFs
Z3JpbmQgbmVlZHMgYSB2YWxpZCBUTVBESVIgZm9yIGl0c2VsZiINCj4+ICtmaQ0KPj4gK1ZBTEdS
SU5EX1FFTVU9IiIgXA0KPj4gICBUTVBESVI9L25vbmV4aXN0ZW50IHJ1bl9xZW11IC1kcml2ZSBk
cml2ZXI9bnVsbC1jbyxzbmFwc2hvdD1vbg0KPj4gICANCj4+ICAgIyBVc2luZyBzbmFwc2hvdD1v
biB0b2dldGhlciB3aXRoIHJlYWQtb25seT1vbg0KPj4NCj4gDQo+IFRoZSBvbmx5IG90aGVyIHdh
eSBhcm91bmQgdGhpcyB3b3VsZCBiZSBhIGNvbXBsaWNhdGVkIG1lY2hhbmlzbSB0byBzZXQNCj4g
dGhlIFRNUERJUiBmb3IgdmFsZ3JpbmQncyBzdWItcHJvY2Vzc2VzIG9ubHksIHdpdGggZS5nLg0K
PiANCj4gdmFsZ3JpbmQgLi4uIGVudiBUTVBESVI9L25vbmV4aXN0ZW50IHFlbXUgLi4uDQo+IA0K
PiAuLi4gSXQncyBwcm9iYWJseSBub3Qgd29ydGggdHJ5aW5nIHRvIGNvbmNvY3Qgc3VjaCBhIHRo
aW5nOyBidXQgSQ0KPiBzdXBwb3NlIGl0IGlzIHBvc3NpYmxlLiBZb3UnZCBoYXZlIHRvIHNldCB1
cCBhIGdlbmVyaWMgbGF5ZXIgZm9yIHNldHRpbmcNCj4gZW52aXJvbm1lbnQgdmFyaWFibGVzLCB0
aGVuIGluIHRoZSBxZW11IHNoaW0sIHlvdSBjb3VsZCBlaXRoZXIgc2V0IHRoZW0NCj4gZGlyZWN0
bHkgKG5vbi12YWxncmluZCBpbnZvY2F0aW9uKSBvciBzZXQgdGhlbSBhcyBwYXJ0IG9mIHRoZSB2
YWxncmluZA0KPiBjb21tYW5kLWxpbmUuDQo+IA0KPiBPciB5b3UgY291bGQganVzdCB0YWtlIG15
IFItQjoNCj4gDQo+IFJldmlld2VkLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+
IA0KDQpUaGFua3MgYWdhaW4gSm9obiBmb3IgeW91ciByZXZpZXcgYW5kIHRoZSBhZHZpY2UuDQpQ
cm9iYWJseSwgaXQgZG9lc24ndCB3b3J0aCBlZmZvcnRzIHRvIG1hbmFnZSB0aGF0IGNhc2UgYmVj
YXVzZSBRRU1VIA0Kc2hvdWxkIGZhaWwgYW55d2F5IHdpdGggdGhlIGVycm9yIG1lc3NhZ2UgIkNv
dWxkIG5vdCBnZXQgdGVtcG9yYXJ5IA0KZmlsZW5hbWU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnkiLiBTbywgd2Ugd291bGQgbm90IGJlbmVmaXQgbXVjaCBmcm9tIA0KdGhhdCBydW4uIFdlIGhh
dmUgb3RoZXIgdGVzdCBjYXNlcyB0aGF0IGNvdmVyIHRoZSBtYWluIGZ1bmN0aW9uYWxpdHkuIA0K
SXQncyBqdXN0IHRvIGNoZWNrIHRoZSBRRU1VIGVycm9yIHBhdGggZm9yIHBvc3NpYmxlIG1lbW9y
eSBpc3N1ZXMuIFNoYWxsIHdlPw0KDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRz
LA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

