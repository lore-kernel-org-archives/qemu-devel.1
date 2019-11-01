Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E6CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57731217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A14Nhqm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57731217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUCB-0007wO-GT
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQUAw-0007P7-4q
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQUAu-0004TQ-HX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:29:01 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com
 ([40.107.0.139]:8929 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQUAt-0004L9-SI; Fri, 01 Nov 2019 06:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/EUQjgO55EyndTp2T9yi0InEeokTmospyuhWFXLAIIU7n8oDDRRgDHjRLD/3iZR35wVFQ1rlV5sYHycxXsuLPwJqQVbl5bWLITwHiBbwyH7AAsA8iYNyxdZab+xhPSD9Yka7FrDCg9Oe7yykTy8djYPJilNAz881Dqs/6UrT6sMiX7AhWz0fSg0uTqPy9GiqZYrXPqp974jcDrZEOZtr1HIo7mPLXQ1kCbj6jX3z5QqAGTjLRoNc5v2ilk0XjNBhwSWQJirpKx7fZ98XKvg3vrwaTDRTMeITGlfFYANfLJE3UCBF1oP/O248NjeiP+J8ppvod1leGozxjPP5vCIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOKJVqESJwp1pVE09mm/kXp45bRvdLIhQoDK3rZXAfU=;
 b=Xerp4PkmyRUtEff+3cyNZtANh+8JkmXYPIvctqaExcY1yjEPMrf2SCUt5E1MDOFrTkCy9nqsdtvvOFTs6kOyIh3LPGd6U8K4liuFAyElbtdsmwoiF/65FpgQstz/noGqGj5g1ON2+pG4AHdqmWG0fyM/j+ltlEXP2W9PFqIlMleXonxt8qyJwAu+8OnEYZosUq8kT6Pk2c6f6NdKY3Q3/JfzXtFk8F1G4M6/yagJ35H4Gj20G+yJj16FTzgsktctw+THbGC5Hrv79QcQzjqbw6jPPARQby8TSgGd63R72NPYfnKjkGijoXuV7VWO5RrAa29FKjFx90+ot86rSgmJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOKJVqESJwp1pVE09mm/kXp45bRvdLIhQoDK3rZXAfU=;
 b=A14Nhqm1MNlqj3RPLrUn+pnYKgKORZts2lvVwEg6kkPPFND2dsdJsu7J0zp1Zn/M8R51OSwgRxzm2bQQ4KBmb2zKzpXFbiwn1NAuX62JiFre40wK3f9pmYdHggRUhjqTYf1AAh94AXOrlMQz5GPIezVynLsPDvsTKwKZaVOmyHU=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB5540.eurprd08.prod.outlook.com (20.179.35.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 10:28:57 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 10:28:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Topic: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Index: AQHVkJs1nNWugfYf7EOzXc04zyxgzKd2Gq6AgAACbQA=
Date: Fri, 1 Nov 2019 10:28:57 +0000
Message-ID: <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
In-Reply-To: <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0041.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::30) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101132854897
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d888cab7-7265-4071-dabb-08d75eb64d3b
x-ms-traffictypediagnostic: AM0PR08MB5540:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB554083B29BEC494404B25AFDC1620@AM0PR08MB5540.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(39840400004)(396003)(136003)(189003)(199004)(52314003)(71190400001)(6306002)(86362001)(64756008)(66446008)(66556008)(66476007)(6512007)(2616005)(476003)(36756003)(66946007)(25786009)(52116002)(6486002)(6506007)(14454004)(76176011)(26005)(6436002)(186003)(102836004)(11346002)(66066001)(229853002)(486006)(2501003)(446003)(31686004)(99286004)(31696002)(14444005)(256004)(316002)(8936002)(7736002)(305945005)(54906003)(4326008)(386003)(478600001)(53546011)(107886003)(110136005)(3846002)(5660300002)(6116002)(2906002)(6246003)(8676002)(81166006)(81156014)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5540;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mibQchM9SXel7EVpTwLdhbAV4JXW+1BmAYC1sRNB2UcaTrOID3qHCaMLqSoep9MwWEMJI3yQamB3lT2+8fFf8uuFWD13R0L0FtISfgKX+v2/lrcOcidysR4IUzyYsuDIysQ67HwX66K/6TDio2UvmDqYZp4L+fUtkRmTuYcOy3Om4J5JteKu9DX8HevlDWu3hfG66lK4L4ZGlJq4YWnUr2zoBo3bk0k3i+nX3TgX0KmpYBXXwdQxbXZvV9xaS7fe+Rw2C9VG4rhvv6z3HXTgMoYFJESWxHJwmjvOzYwUaByQWrIzsUqyatWutv2ATFt0aWqHajiBLe6LeeprFm54d3CLEhEhFOyn9xKLWW5ZithPtVqdbKClwM1NIiO4pmfXZlo8KGVw1tt2pqJpqoJ/tmQ9akbu2tYkjx88BTRdRxzELroEmVkxDFZRCNhfxTX6ZCSnNjCrK5Ag1ycFNimuL0WLnf1Gm0OPtL3tNrVcqn0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BB1563B5CF42947A56C323702FB5FF7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d888cab7-7265-4071-dabb-08d75eb64d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 10:28:57.0500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4w9liUGvTIMBpTlbcsBjB/87HwFTpitzRTbIRirKN9y99qFIsWJ3I8nnrUDBtL8hrhby+q6/1qrXZJT4CdCNcjC3pZA+oS3uPQ2prDKV1B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5540
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.139
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxMzoyMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMS4xOSAxMTowMCwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gVGhpcyBzZXJpZXMgYnVpbGRzIG9uIHRo
ZSBwcmV2aW91cyBSRkMuICBUaGUgd29ya2Fyb3VuZCBpcyBub3cgYXBwbGllZA0KPj4gdW5jb25k
aXRpb25hbGx5IG9mIEFJTyBtb2RlIGFuZCBmaWxlc3lzdGVtIGJlY2F1c2Ugd2UgZG9u4oCZdCBr
bm93IHRob3NlDQo+PiB0aGluZ3MgZm9yIHJlbW90ZSBmaWxlc3lzdGVtcy4gIEZ1cnRoZXJtb3Jl
LCBiZHJ2X2NvX2dldF9zZWxmX3JlcXVlc3QoKQ0KPj4gaGFzIGJlZW4gbW92ZWQgdG8gYmxvY2sv
aW8uYy4NCj4+DQo+PiBBcHBseWluZyB0aGUgd29ya2Fyb3VuZCB1bmNvbmRpdGlvbmFsbHkgaXMg
ZmluZSBmcm9tIGEgcGVyZm9ybWFuY2UNCj4+IHN0YW5kcG9pbnQsIGJlY2F1c2UgaXQgc2hvdWxk
IGFjdHVhbGx5IGJlIGRlYWQgY29kZSwgdGhhbmtzIHRvIHBhdGNoIDENCj4+ICh0aGUgZWxlcGhh
bnQgaW4gdGhlIHJvb20pLiAgQXMgZmFyIGFzIEkga25vdywgdGhlcmUgaXMgbm8gb3RoZXIgYmxv
Y2sNCj4+IGRyaXZlciBidXQgcWNvdzIgaW4gaGFuZGxlX2FsbG9jX3NwYWNlKCkgdGhhdCB3b3Vs
ZCBzdWJtaXQgemVybyB3cml0ZXMNCj4+IGFzIHBhcnQgb2Ygbm9ybWFsIEkvTyBzbyBpdCBjYW4g
b2NjdXIgY29uY3VycmVudGx5IHRvIG90aGVyIHdyaXRlDQo+PiByZXF1ZXN0cy4gIEl0IHN0aWxs
IG1ha2VzIHNlbnNlIHRvIHRha2UgdGhlIHdvcmthcm91bmQgZm9yIGZpbGUtcG9zaXgNCj4+IGJl
Y2F1c2Ugd2UgY2Fu4oCZdCByZWFsbHkgcHJldmVudCB0aGF0IGFueSBvdGhlciBibG9jayBkcml2
ZXIgd2lsbCBzdWJtaXQNCj4+IHplcm8gd3JpdGVzIGFzIHBhcnQgb2Ygbm9ybWFsIEkvTyBpbiB0
aGUgZnV0dXJlLg0KPj4NCj4+IEFueXdheSwgbGV04oCZcyBnZXQgdG8gdGhlIGVsZXBoYW50Lg0K
Pj4NCj4+ICBGcm9tIGlucHV0IGJ5IFhGUyBkZXZlbG9wZXJzDQo+PiAoaHR0cHM6Ly9idWd6aWxs
YS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzY1NTQ3I2M3KSBpdCBzZWVtcyBjbGVhcg0K
Pj4gdGhhdCBjOGJiMjNjYmRiZSBjYXVzZXMgZnVuZGFtZW50YWwgcGVyZm9ybWFuY2UgcHJvYmxl
bXMgb24gWEZTIHdpdGgNCj4+IGFpbz1uYXRpdmUgdGhhdCBjYW5ub3QgYmUgZml4ZWQuICBJbiBv
dGhlciBjYXNlcywgYzhiYjIzY2JkYmUgaW1wcm92ZXMNCj4+IHBlcmZvcm1hbmNlIG9yIHdlIHdv
dWxkbuKAmXQgaGF2ZSBpdC4NCj4+DQo+PiBJbiBnZW5lcmFsLCBhdm9pZGluZyBwZXJmb3JtYW5j
ZSByZWdyZXNzaW9ucyBpcyBtb3JlIGltcG9ydGFudCB0aGFuDQo+PiBpbXByb3ZpbmcgcGVyZm9y
bWFuY2UsIHVubGVzcyB0aGUgcmVncmVzc2lvbnMgYXJlIGp1c3QgYSBtaW5vciBjb3JuZXINCj4+
IGNhc2Ugb3IgaW5zaWduaWZpY2FudCB3aGVuIGNvbXBhcmVkIHRvIHRoZSBpbXByb3ZlbWVudC4g
IFRoZSBYRlMNCj4+IHJlZ3Jlc3Npb24gaXMgbm8gbWlub3IgY29ybmVyIGNhc2UsIGFuZCBpdCBp
c27igJl0IGluc2lnbmlmaWNhbnQuICBMYXVyZW50DQo+PiBWaXZpZXIgaGFzIGZvdW5kIHBlcmZv
cm1hbmNlIHRvIGRlY3JlYXNlIGJ5IGFzIG11Y2ggYXMgODggJSAob24gcHBjNjRsZSwNCj4+IGZp
byBpbiBhIGd1ZXN0IHdpdGggNGsgYmxvY2tzLCBpb2RlcHRoPTg6IDE2NjIga0IvcyBmcm9tIDEz
LjkgTUIvcykuDQo+IA0KPiBBaCwgY3JhcC4NCj4gDQo+IEkgd2FudGVkIHRvIHNlbmQgdGhpcyBz
ZXJpZXMgYXMgZWFybHkgdG9kYXkgYXMgcG9zc2libGUgdG8gZ2V0IGFzIG11Y2gNCj4gZmVlZGJh
Y2sgYXMgcG9zc2libGUsIHNvIEnigJl2ZSBvbmx5IHN0YXJ0ZWQgZG9pbmcgYmVuY2htYXJrcyBu
b3cuDQo+IA0KPiBUaGUgb2J2aW91cw0KPiANCj4gJCBxZW11LWltZyBiZW5jaCAtdCBub25lIC1u
IC13IC1TIDY1NTM2IHRlc3QucWNvdzINCj4gDQo+IG9uIFhGUyB0YWtlcyBsaWtlIDYgc2Vjb25k
cyBvbiBtYXN0ZXIsIGFuZCBsaWtlIDUwIHRvIDgwIHNlY29uZHMgd2l0aA0KPiBjOGJiMjNjYmRi
ZSByZXZlcnRlZC4gIFNvIG5vdyBvbiB0byBndWVzdCB0ZXN0cy4uLg0KDQpBaGEsIHRoYXQncyB2
ZXJ5IGludGVyZXN0aW5nKSBXaGF0IGFib3V0IGFpby1uYXRpdmUgd2hpY2ggc2hvdWxkIGJlIHNs
b3dlZCBkb3duPw0KQ291bGQgaXQgYmUgdGVzdGVkIGxpa2UgdGhpcz8NCg0KPiANCj4gKFdlbGws
IGFuZCB0aGUgcXVlc3Rpb24gaXMgc3RpbGwgd2hlcmUgdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Np
b24gb24NCj4gcHBjNjQgY29tZXMgZnJvbS4pDQo+IA0KPiBNYXgNCj4gDQo+PiBUaHVzLCBJIGJl
bGlldmUgd2Ugc2hvdWxkIHJldmVydCB0aGUgY29tbWl0IGZvciBub3cgKGFuZCBtb3N0DQo+PiBp
bXBvcnRhbnRseSBmb3IgNC4xLjEpLiAgV2UgY2FuIHRoaW5rIGFib3V0IHJlaW50cm9kdWNpbmcg
aXQgZm9yIDUuMCwNCj4+IGJ1dCB0aGF0IHdvdWxkIHJlcXVpcmUgbW9yZSBleHRlbnNpdmUgYmVu
Y2htYXJrcyBvbiBhIHZhcmlldHkgb2YNCj4+IHN5c3RlbXMsIGFuZCB3ZSBtdXN0IHNlZSBob3cg
c3ViY2x1c3RlcnMgY2hhbmdlIHRoZSBwaWN0dXJlLg0KPj4NCj4+DQo+PiBJIHdvdWxkIGhhdmUg
bGlrZWQgdG8gZG8gYmVuY2htYXJrcyBteXNlbGYgYmVmb3JlIG1ha2luZyB0aGlzIGRlY2lzaW9u
LA0KPj4gYnV0IGFzIGZhciBhcyBJ4oCZbSBpbmZvcm1lZCwgcGF0Y2hlcyBmb3IgNC4xLjEgYXJl
IHRvIGJlIGNvbGxlY3RlZCBvbg0KPj4gTW9uZGF5LCBzbyB3ZSBuZWVkIHRvIGJlIHF1aWNrLg0K
Pj4NCj4+DQo+PiBnaXQtYmFja3BvcnQtZGlmZiBhZ2FpbnN0IHRoZSBSRkM6DQo+Pg0KPj4gS2V5
Og0KPj4gWy0tLS1dIDogcGF0Y2hlcyBhcmUgaWRlbnRpY2FsDQo+PiBbIyMjI10gOiBudW1iZXIg
b2YgZnVuY3Rpb25hbCBkaWZmZXJlbmNlcyBiZXR3ZWVuIHVwc3RyZWFtL2Rvd25zdHJlYW0gcGF0
Y2gNCj4+IFtkb3duXSA6IHBhdGNoIGlzIGRvd25zdHJlYW0tb25seQ0KPj4gVGhlIGZsYWdzIFtG
Q10gaW5kaWNhdGUgKEYpdW5jdGlvbmFsIGFuZCAoQylvbnRleHR1YWwgZGlmZmVyZW5jZXMsIHJl
c3BlY3RpdmVseQ0KPj4NCj4+IDAwMS80Oltkb3duXSAnUmV2ZXJ0ICJxY293Mjogc2tpcCB3cml0
aW5nIHplcm8gYnVmZmVycyB0byBlbXB0eSBDT1cgYXJlYXMiJw0KPj4gMDAyLzQ6Wy0tLS1dIFst
Q10gJ2Jsb2NrOiBNYWtlIHdhaXQvbWFyayBzZXJpYWxpc2luZyByZXF1ZXN0cyBwdWJsaWMnDQo+
PiAwMDMvNDpbZG93bl0gJ2Jsb2NrOiBBZGQgYmRydl9jb19nZXRfc2VsZl9yZXF1ZXN0KCknDQo+
PiAwMDQvNDpbMDAzNl0gW0ZDXSAnYmxvY2svZmlsZS1wb3NpeDogTGV0IHBvc3QtRU9GIGZhbGxv
Y2F0ZSBzZXJpYWxpemUnDQo+Pg0KPj4NCj4+IE1heCBSZWl0eiAoNCk6DQo+PiAgICBSZXZlcnQg
InFjb3cyOiBza2lwIHdyaXRpbmcgemVybyBidWZmZXJzIHRvIGVtcHR5IENPVyBhcmVhcyINCj4+
ICAgIGJsb2NrOiBNYWtlIHdhaXQvbWFyayBzZXJpYWxpc2luZyByZXF1ZXN0cyBwdWJsaWMNCj4+
ICAgIGJsb2NrOiBBZGQgYmRydl9jb19nZXRfc2VsZl9yZXF1ZXN0KCkNCj4+ICAgIGJsb2NrL2Zp
bGUtcG9zaXg6IExldCBwb3N0LUVPRiBmYWxsb2NhdGUgc2VyaWFsaXplDQo+Pg0KPj4gICBxYXBp
L2Jsb2NrLWNvcmUuanNvbiAgICAgICB8ICA0ICstDQo+PiAgIGJsb2NrL3Fjb3cyLmggICAgICAg
ICAgICAgIHwgIDYgLS0tDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggIHwgIDQgKysN
Cj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jICAgICAgICAgfCAzOCArKysrKysrKysrKysrKysrKw0K
Pj4gICBibG9jay9pby5jICAgICAgICAgICAgICAgICB8IDQyICsrKysrKysrKysrKystLS0tLS0N
Cj4+ICAgYmxvY2svcWNvdzItY2x1c3Rlci5jICAgICAgfCAgMiArLQ0KPj4gICBibG9jay9xY293
Mi5jICAgICAgICAgICAgICB8IDg2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+PiAgIGJsb2NrL3RyYWNlLWV2ZW50cyAgICAgICAgIHwgIDEgLQ0KPj4gICB0ZXN0cy9x
ZW11LWlvdGVzdHMvMDYwICAgICB8ICA3ICstLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA2
MC5vdXQgfCAgNSArLS0NCj4+ICAgMTAgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwg
MTE5IGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

