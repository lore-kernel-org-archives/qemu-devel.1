Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07BC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250E52133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VX+3j/Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250E52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgEY-0000py-Rm
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgAh-00051J-DE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgAg-00082O-37
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:04:07 -0400
Received: from mail-ve1eur03on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::705]:44609
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFgAf-0007wK-7n; Wed, 02 Oct 2019 11:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiC2KGbn3UB5tSOPaPW7xwEJX27C3uTneqXkmUzYtoNSb2p+5L4DFIH/H4Se5MokzoV9vCO1TrKA+bzPiAd4DjwC6ni8BulHnOa7E7ralm/vuO3iRnRieK4htAdtiMexc6emcgfxXd5xcXeP7Lf5s38ufrzPmLVSvWKKOsOW9tw0dvhVvioMKObvhPUsroKc8z5gYfP8vScQrQ2i0XxS2g+WksQ+itldTDyDeHJVx3UrLd6MRwlTe0nddcZwZ9GIQZMJqdHBmFdcPi+3g69c5mNqtz3i/uXzWpascPLiwcWoYME8HkwfcK3/6/Jx8+jh33t25qi2QzfirL3Xew4CXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfZs/9UMs8uomyNm41jkxqZkctdLPmvasGLBJgRJ97c=;
 b=Muo3XWtCFY3JXHnBpamYq1Di2xdHu+SHjchv3Sc508i+gNE3rG3L/B4Fv240W4tzufxryb8yxf7il3DhpdLSEyYnHVobjjAunibKdOG3S3Q8yx4bEit6F/qLamWoo1DUB6tsZhZF6kBJ4vPakgvayoqyux3TFs96u3AnEK0mTsrvUarX6mFwso/04VusGrMdihqQUvmBn5tajQA22fiyWmoFGlSrdruuEYzTkgQCiKp9+HNa0T4QWhRYyzLEr9HDZtRuDh0Fc7qE42xLTzyYOylJVWf48NrWteYCPJ9kAns42ZTadJ4ssTW54AeFzuz4NQnyRh4AjJLdE3THaeANhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfZs/9UMs8uomyNm41jkxqZkctdLPmvasGLBJgRJ97c=;
 b=VX+3j/AmNpWU9qTiZJOIOPMIdI31/LqHtQzJ0EoWaKGzT1BJ/sbQ1jVQD38gQ6Ev6Vtc+DsbLcTxeLZjPAwH84U4JQPnWcwS0jaNBXJpKiaas1bJD8u8bYquLnDZzf5mmZG1dn/dMGkiNR7RsB3Bmid5YCnZncWuLE+coreI6Gg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Wed, 2 Oct 2019 15:03:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 15:03:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAAB3QA=
Date: Wed, 2 Oct 2019 15:03:57 +0000
Message-ID: <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
In-Reply-To: <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::25)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002180354335
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5260a2-8762-44e7-661c-08d74749bfb2
x-ms-traffictypediagnostic: DB8PR08MB3977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3977D03A14834EB3705E172BC19C0@DB8PR08MB3977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(39850400004)(396003)(136003)(189003)(199004)(186003)(31696002)(64756008)(66556008)(8936002)(256004)(8676002)(86362001)(5660300002)(11346002)(476003)(81166006)(66446008)(31686004)(66476007)(99286004)(386003)(76176011)(102836004)(6506007)(53546011)(26005)(2501003)(52116002)(2616005)(66946007)(14444005)(2906002)(446003)(110136005)(6436002)(54906003)(71190400001)(36756003)(6512007)(478600001)(25786009)(316002)(6486002)(81156014)(229853002)(6116002)(3846002)(14454004)(7736002)(66066001)(107886003)(4326008)(305945005)(71200400001)(486006)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3977;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLsgKhA/k77b03zfoGEG1UwbEf7R3cHwzZyMKDBJC41crc4vBmgbKcoNHQdvPDlV0TEYLpwKgugvrgfvvqv9GD2r+CKYW+aJo3MgcA802FD6CoQnNgPUN1J+041Va20/LjNekIVcE3wMiqKdhZB5iJPgYviCBVTrgK1HLugv+LZtWy6R1S1LfEpEolrF25wsTJ9D2mnwo0zye9vMXCnn60+RwMzkRrJoKGADnRJmsfKq5hWNFchy+zK2vDtr7qzge4r6y19IgoGvHGx8a6WB8qXcbGveVHsjt5MU4VT9SEWCPxR+LdN1tj2dt0czWvGbsstgrWu9jfodnRzfoCZBasxpI4E48y7YzaNLgUqHzX1rPbDIkfwF+gxevX5I946EiGNJsEcRUKKcoCgTZhf80HS60936n547NcgUn6RHARU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C6F8F1C8C577F4BAA8BACB60494A223@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5260a2-8762-44e7-661c-08d74749bfb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 15:03:57.2880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 663UETp4Q9NzLYsYLuOVmNMGJLtbGyMOFrrNkX4wf/NVkhoYg5ZZ2BChcsGXov4wbgj8Snjq2RqPt58gwiGNNCSp9DTIGnxezHreV1RfDO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::705
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOS4xOSAxNzoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFByaW9yIDlhZGMxY2I0OWFm
OGQgZG9fc3luY190YXJnZXRfd3JpdGUgaGFkIGEgYnVnOiBpdCByZXNldCBhbGlnbmVkLXVwDQo+
PiByZWdpb24gaW4gdGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkgbm90
IGNvcHkgc29tZSBieXRlcw0KPj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFs
bHkgbGVhZHMgdG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4gdGFyZ2V0Lg0KPj4NCj4+IFNvIDlh
ZGMxY2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBiZQ0KPj4gcmVx
dWVzdF9hbGlnbm1lbnQgZm9yIG1pcnJvci10b3AgZmlsdGVyLCBzbyB3ZSBhcmUgbm90IHdvcmtp
bmcgd2l0aA0KPj4gdW5hbGlnbmVkIHJlcXVlc3RzLiBIb3dldmVyIGZvcmNpbmcgbGFyZ2UgYWxp
Z25tZW50IG9idmlvdXNseSBkZWNyZWFzZXMNCj4+IHBlcmZvcm1hbmNlIG9mIHVuYWxpZ25lZCBy
ZXF1ZXN0cy4NCj4+DQo+PiBUaGlzIGNvbW1pdCBwcm92aWRlcyBhbm90aGVyIHNvbHV0aW9uIGZv
ciB0aGUgcHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+PiBwYWRkaW5nIGlzIGFscmVhZHkgZGlydHks
IHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4gMS4gSXQncyBkaXJ0eSwgaXQgd2lsbCBi
ZSBjb3BpZWQgYnkgbWlycm9yX2l0ZXJhdGlvbiBhbnl3YXkNCj4+IDIuIEl0J3MgZGlydHksIHNv
IHNraXBwaW5nIGl0IG5vdyB3ZSBkb24ndCBpbmNyZWFzZSBkaXJ0aW5lc3Mgb2YgdGhlDQo+PiAg
ICAgYml0bWFwIGFuZCB0aGVyZWZvcmUgZG9uJ3QgZGFtYWdlICJzeW5jaHJvbmljaXR5IiBvZiB0
aGUNCj4+ICAgICB3cml0ZS1ibG9ja2luZyBtaXJyb3IuDQo+IA0KPiBCdXQgdGhhdOKAmXMgbm90
IHdoYXQgYWN0aXZlIG1pcnJvciBpcyBmb3IuICBUaGUgcG9pbnQgb2YgYWN0aXZlIG1pcnJvciBp
cw0KPiB0aGF0IGl0IG11c3QgY29udmVyZ2UgYmVjYXVzZSBldmVyeSBndWVzdCB3cml0ZSB3aWxs
IGNvbnRyaWJ1dGUgdG93YXJkcw0KPiB0aGF0IGdvYWwuDQo+IA0KPiBJZiB5b3Ugc2tpcCBhY3Rp
dmUgbWlycm9yaW5nIGZvciB1bmFsaWduZWQgZ3Vlc3Qgd3JpdGVzLCB0aGV5IHdpbGwgbm90DQo+
IGNvbnRyaWJ1dGUgdG93YXJkcyBjb252ZXJnaW5nLCBidXQgaW4gZmFjdCBsZWFkIHRvIHRoZSBv
cHBvc2l0ZS4NCj4gDQoNClRoZSB3aWxsIG5vdCBjb250cmlidXRlIG9ubHkgaWYgcmVnaW9uIGlz
IGFscmVhZHkgZGlydHkuIEFjdHVhbGx5LCBhZnRlcg0KZmlyc3QgaXRlcmF0aW9uIG9mIG1pcnJv
cmluZyAoY29weWluZyB0aGUgd2hvbGUgZGlzayksIGFsbCBmb2xsb3dpbmcgd3JpdGVzDQp3aWxs
IGNvbnRyaWJ1dGUsIHNvIHRoZSB3aG9sZSBwcm9jZXNzIG11c3QgY29udmVyZ2UuIEl0IGlzIGEg
Yml0IHNpbWlsYXIgd2l0aA0KcnVubmluZyBvbmUgbWlycm9yIGxvb3AgaW4gbm9ybWFsIG1vZGUs
IGFuZCB0aGVuIGVuYWJsZSB3cml0ZS1ibG9ja2luZy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

