Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97C6C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23962075B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QrUjLeVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23962075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufHv-0002CM-WB
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hufHV-0001a6-2G
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hufHU-0006oe-0h
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:52:17 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:47297 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hufHR-0006nJ-9I; Mon, 05 Aug 2019 11:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrdQeUBwPkeF23TYFNKarNayKObkLKvkcb1cyqy2FKIQCB0c/r7OI/AVTXyT9DpLRKfO2opZeMDF9p/7s5mWHDv+1fbR/usx3bPqUEliRj5XL9/vW/6Qo7Se23XwzTxmP9M3iNeHv2sVFkr/BIYC1/shvwT+3zVWLxIMquWMsJ4Xck5r3g9w3HyuVe4j3rVegVAJzaH4K2ybDKrasqI/XO/ocHgf6ufnz2x5tQGdKoM9ErBBBrqVBsvYiAL1dlfijwtYfXbGEyJ65CZxxepPA6OaGosCWSe6fX1G4c3IvyTvKYlJjCmb30+qrTVjTINBny65bZUCVIKqFtkfxhEl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxpRkY8NlZ/0qEF9rRO6PkikprkIlT5k+LkD0SwNRI=;
 b=KptM2vWIVsk1o+NBbHCovVmcTeMYfI/qZqF8B18/MZEi1u6tdD3wPIJLVAh0rVBKXDLoAFwD74phH4f0TLRA2xSqd9U+NXACh48B2UW0fqUPKbjyeRnF5PNR3TN6X+P4MFK7jerDMZ4DepRsG6gp8RsPckZz3fWUDokln2/fhUf6/XY2k1m4Q1lV7JELLA7gsGwJ2rlIXmHhTShUnfl0HjgZ+3GqYYcpHfV2GZDoILB6yIp1+OGH6BlEfRSqD6Lf8O8ww06kEbRUIfyxPUMO1rRkwiPPCeLzdYwcIECbEER7AHroigcu5eI1WsCBrY28v1TidWJVUwE0428xnbUJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxpRkY8NlZ/0qEF9rRO6PkikprkIlT5k+LkD0SwNRI=;
 b=QrUjLeVnprH8e5qDvovlNje/swipdCC9Q5Q9hMC4vUMpCe6Q7gtx3bllGONm9tr3xPWBh2E97/n/EQCCRHstw+sznRwyoAQKVMp3tj7Cl28yoSpJtAWFJfctwnClxQZo+SlqPcm92ULbwRsDja7h06hyoVfVkp9WSjRpFGBrTqk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5419.eurprd08.prod.outlook.com (52.133.241.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Mon, 5 Aug 2019 15:52:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 15:52:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3] mirror: Only mirror granularity-aligned chunks
Thread-Index: AQHVS6MZaljcSTBJLkye1KUBpzlKEqbstDIA
Date: Mon, 5 Aug 2019 15:52:11 +0000
Message-ID: <519b3763-9cd1-d794-d411-ae59d32fa0be@virtuozzo.com>
References: <20190805153308.2657-1-mreitz@redhat.com>
In-Reply-To: <20190805153308.2657-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0016.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805185208918
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7786280-8494-44c3-0c2c-08d719bce0ae
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5419; 
x-ms-traffictypediagnostic: DB8PR08MB5419:
x-microsoft-antispam-prvs: <DB8PR08MB54190CC5E959781351741E49C1DA0@DB8PR08MB5419.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(71200400001)(36756003)(14454004)(386003)(54906003)(6486002)(6436002)(11346002)(476003)(2616005)(446003)(110136005)(76176011)(53936002)(2906002)(4326008)(6512007)(478600001)(229853002)(71190400001)(6246003)(2501003)(6116002)(316002)(68736007)(26005)(81166006)(31696002)(81156014)(5660300002)(186003)(3846002)(66446008)(66556008)(25786009)(64756008)(66476007)(8936002)(305945005)(7736002)(52116002)(86362001)(66066001)(8676002)(14444005)(66946007)(256004)(6506007)(31686004)(486006)(99286004)(102836004)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5419;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CkICrC/z+7r3NetWavIZbbCrg8rcXUgOT9WQhZCIItOARQ6vxswtnNgGmkN5Yv0XLx4TCnbEiNNEvWl3aD+INfyid3wIko77dHo+piPFjPs2OeB6swnCr1mNFKtptkdfveRJGoSFZ3qR2rl102TjumhbBG5sfAurAsaRzhRqA65y1/5wZQT/xH7SfNFBFxMkrYWbBOle478zkA+IoUCbebIvfFXWjWBGEH5HLjbYkpf3m3JIp32X9ALQlHJk2XNUo1g8bDrFEBrNGl6vxcDRfMDGJhUq7q/cXFvbApgiUItFBe0+8FekAu2VPSRMqgvS0ttDHR4ioxwoJbRDPOf1dpgLs3dJmv3+3Yw66JFff6hNT5Za1E59cHj4+iFw+glQEQHbolVjkiY7L8MhSx9IBOPZo+jZU123jLQkir6i0jc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82DB82842E3E4A469193A47DB0B48FDB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7786280-8494-44c3-0c2c-08d719bce0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 15:52:11.1954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.111
Subject: Re: [Qemu-devel] [PATCH v3] mirror: Only mirror granularity-aligned
 chunks
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxODozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJbiB3cml0ZS1ibG9ja2luZyBt
b2RlLCBhbGwgd3JpdGVzIHRvIHRoZSB0b3Agbm9kZSBkaXJlY3RseSBnbyB0byB0aGUNCj4gdGFy
Z2V0LiAgV2UgbXVzdCBvbmx5IG1pcnJvciBjaHVua3Mgb2YgZGF0YSB0aGF0IGFyZSBhbGlnbmVk
IHRvIHRoZQ0KPiBqb2IncyBncmFudWxhcml0eSwgYmVjYXVzZSB0aGF0IGlzIGhvdyB0aGUgZGly
dHkgYml0bWFwIHdvcmtzLg0KPiBUaGVyZWZvcmUsIHRoZSByZXF1ZXN0IGFsaWdubWVudCBmb3Ig
d3JpdGVzIG11c3QgYmUgdGhlIGpvYidzDQo+IGdyYW51bGFyaXR5IChpbiB3cml0ZS1ibG9ja2lu
ZyBtb2RlKS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoaXMgZm9yY2VzIGFsbCByZWFkcyBhbmQg
d3JpdGVzIHRvIGhhdmUgdGhlIHNhbWUNCj4gZ3JhbnVsYXJpdHkgKHdlIG9ubHkgbmVlZCB0aGlz
IGFsaWdubWVudCBmb3Igd3JpdGVzIHRvIHRoZSB0YXJnZXQsIG5vdA0KPiB0aGUgc291cmNlKSwg
YnV0IHRoYXQgaXMgc29tZXRoaW5nIHRvIGJlIGZpeGVkIGFub3RoZXIgdGltZS4NCj4gDQo+IENj
OiBxZW11LXN0YWJsZUBub25nbnUub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

