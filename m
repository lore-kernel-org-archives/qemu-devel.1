Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73864C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB7222CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VZoXhT83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7222CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zej-0005dF-CA
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2zco-0004Zx-Hu
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2zcn-0002bp-BM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:12:42 -0400
Received: from mail-eopbgr20099.outbound.protection.outlook.com
 ([40.107.2.99]:7758 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2zck-0002YO-Fm; Wed, 28 Aug 2019 11:12:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAV4roKxHV8MFcGzMtp7HWWCGCWF3QDkuRDccvkLOnELnezsIhmuo9rfAwUh85yhEPIvTjBaM6bPyA7DBsoqR6d3dWWZ4sX5LG2r9C/OdeKfv0m6KZ95w5YwfFr++WbXpfugLYVtSb+TSk5V+M+S4Da4A0sSxZ0oyr7h22nm27jBJEe3DkhGiX2Eu1RZIY+y//5NaKK6BzcDrPjELwT6YRhOix8d7F73YsS3JDWDu+/ds/cxG46kDuO0MHjsiz+PPkIIjeM9/jZkyDoBApXYBtAlPHhNqoIQPYV+PD+TC+qsJbdSfIGpWJTowhePJ9wwR1r1itCJQz8WXLxigZcm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6M3LgQlS+PA3A1MuO3VzwHvz3+YRJv/W9xhzflVfeM=;
 b=E5M+SUGNxJsNCdtqL7E224yIQqT+HCkjcVwNErZERcPP+Krxf9KFDboTI/eTRXGzuh/tyWD6oO55KZphFiB9+Jmg/K1eHLsnNt0cKuL+6nf2CYwjHHdtOHtQKLMkBTP7oMYNReRT8m2u4F0EU9rfa4GJbDSLnwuSLpQEhDYPCgyqzW/Q4i7f7dND2VZi/EOhB+weWe3JZQM2w0jazpudRzlKONQmveKgHpfPsYdZzeKjiPf1yHvTyRc//zgSXnUBH0Wqy9/m/yDUnCnU/jYJ53YuOhDICmu72GInf+EjGbxvjR2hvHbZLcNxVNdPJJplZmd4BDTNuak0vVSFbRHCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6M3LgQlS+PA3A1MuO3VzwHvz3+YRJv/W9xhzflVfeM=;
 b=VZoXhT83dHorDhXoSw1ofug3CTD4Flp4idac62mBInhMXcjysmEwH6XDj/XHGXDPeo95ofbVkHyGYZ2NtKlEob1sJ++92YZAvrdB557TLg5ovuKeulBffmInWXe5qUnQBco+/fsOJXrtqrfwjYs2x+TzY/gb+E7UjxeNEUZdj3Q=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3118.eurprd08.prod.outlook.com (52.133.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 15:12:34 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:12:34 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v5 4/6] iotests: Valgrind fails with
 nonexistent directory
Thread-Index: AQHVPk9L3/ITZiX1kkydw2eCRwLO7qb9HeMAgA9KB4CAAzt3AIABRgaA
Date: Wed, 28 Aug 2019 15:12:33 +0000
Message-ID: <caba91b9-f9e6-90a4-b5fa-3b57dda6b005@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <8b68a897-4ff9-5517-d7ad-3f7a18f12be7@redhat.com>
 <4b77f137-07c2-94ea-ec72-3d8d5c0ad5f7@virtuozzo.com>
 <7715daea-104e-eca8-bdd3-c61b3ffb26a5@redhat.com>
In-Reply-To: <7715daea-104e-eca8-bdd3-c61b3ffb26a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::51) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a85b1389-524c-4e86-ec82-08d72bca270f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3118; 
x-ms-traffictypediagnostic: VI1PR08MB3118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB3118AA58792EAA72275ACD1AF4A30@VI1PR08MB3118.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(396003)(346002)(376002)(189003)(199004)(86362001)(110136005)(66476007)(66556008)(64756008)(66446008)(26005)(66066001)(478600001)(71200400001)(486006)(8676002)(186003)(44832011)(81166006)(54906003)(81156014)(8936002)(229853002)(66946007)(53546011)(102836004)(31686004)(386003)(3846002)(6116002)(31696002)(14454004)(7736002)(305945005)(36756003)(25786009)(6506007)(5660300002)(446003)(4326008)(6246003)(11346002)(2616005)(107886003)(76176011)(14444005)(53936002)(256004)(6512007)(2501003)(476003)(52116002)(2906002)(99286004)(6486002)(6436002)(2201001)(316002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3118;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OxqoTQvhiYklovlxPihXQClSUZi7RcBqllquZ4TlOmMZoonyTEEUzy/s9D+Ryl2Spgul4bprgRrxsAIEeELvAf9vTd7q1Q4MTEa+jAAEESpZ51nAI20ESmVbfto/xbjfv0srB0FAP6/RU+YHgZeRt3GCNNn5QtlK2wMz0UVp0/8wqTtlop3e+0YjQTIXhuvxeOa1mTh59lRSl59c7eBcFpHm/JcZCg/GghwMgqqKGOrjenagpC7DglCjlKWB5IimYF4uau0CLU9Iu2Y2N90IJHGfFft+SkPt08SrdfQBEO/iSDhUTlyhrytVSMCbVhxp3ul+QmZV+mF+fO/wTzbrljmZCrAoavCTIZgNnsvERLjs579zHyIkEPncBvByeFvQkolloptoO9wnijmTyqLBmfwEi8Zei2C9y+io+LcOosg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01E5AA91362FEC4C8C7A2E538C0845C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85b1389-524c-4e86-ec82-08d72bca270f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:12:33.6896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEJmWQFC+fhw6uxL2D9svPXwattOrjb6pPMqaO7j4LsqDFiOPw4Bcq3mjyP7lbB9SlduzUop0Ersa+KvILL5QD6WgKh+zsPl5YNETQAlAzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3118
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.99
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

DQoNCk9uIDI3LzA4LzIwMTkgMjI6NDUsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzI1LzE5IDExOjI0IEFNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+DQo+Pg0KPj4gT24g
MTYvMDgvMjAxOSAwMzo1NSwgSm9obiBTbm93IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA3LzE5
LzE5IDEyOjMwIFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+Pj4gVGhlIFZhbGdyaW5k
IHVzZXMgdGhlIGV4cG9ydGVkIHZhcmlhYmxlIFRNUERJUiBhbmQgZmFpbHMgaWYgdGhlDQo+Pj4+
IGRpcmVjdG9yeSBkb2VzIG5vdCBleGlzdC4gTGV0IHVzIGV4Y2x1ZGUgc3VjaCBhIHRlc3QgY2Fz
ZSBmcm9tDQo+Pj4+IGJlaW5nIHJ1biB1bmRlciB0aGUgVmFsZ3JpbmQgYW5kIG5vdGlmeSB0aGUg
dXNlciBvZiBpdC4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkBy
ZWRoYXQuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5
LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIHRlc3RzL3FlbXUt
aW90ZXN0cy8wNTEgfCA0ICsrKysNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MSBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNTENCj4+Pj4gaW5kZXggY2U5NDJhNS4uZjgxNDFjYSAxMDA3NTUN
Cj4+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MQ0KPj4+PiArKysgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMDUxDQo+Pj4+IEBAIC0zNzcsNiArMzc3LDEwIEBAIHByaW50ZiAlYiAicWVtdS1p
byAkZGV2aWNlX2lkIFwid3JpdGUgLVAgMHgzMyAwIDRrXCJcbmNvbW1pdCAkZGV2aWNlX2lkXG4i
IHwNCj4+Pj4gICAgJFFFTVVfSU8gLWMgInJlYWQgLVAgMHgzMyAwIDRrIiAiJFRFU1RfSU1HIiB8
IF9maWx0ZXJfcWVtdV9pbw0KPj4+PiAgICANCj4+Pj4gICAgIyBVc2luZyBzbmFwc2hvdD1vbiB3
aXRoIGEgbm9uLWV4aXN0ZW50IFRNUERJUg0KPj4+PiAraWYgWyAiJHtWQUxHUklORF9RRU1VfSIg
PT0gInkiIF07IHRoZW4NCj4+Pj4gKyAgICBfY2FzZW5vdHJ1biAiVmFsZ3JpbmQgbmVlZHMgYSB2
YWxpZCBUTVBESVIgZm9yIGl0c2VsZiINCj4+Pj4gK2ZpDQo+Pj4+ICtWQUxHUklORF9RRU1VPSIi
IFwNCj4+Pj4gICAgVE1QRElSPS9ub25leGlzdGVudCBydW5fcWVtdSAtZHJpdmUgZHJpdmVyPW51
bGwtY28sc25hcHNob3Q9b24NCj4+Pj4gICAgDQo+Pj4+ICAgICMgVXNpbmcgc25hcHNob3Q9b24g
dG9nZXRoZXIgd2l0aCByZWFkLW9ubHk9b24NCj4+Pj4NCj4+Pg0KPj4+IFRoZSBvbmx5IG90aGVy
IHdheSBhcm91bmQgdGhpcyB3b3VsZCBiZSBhIGNvbXBsaWNhdGVkIG1lY2hhbmlzbSB0byBzZXQN
Cj4+PiB0aGUgVE1QRElSIGZvciB2YWxncmluZCdzIHN1Yi1wcm9jZXNzZXMgb25seSwgd2l0aCBl
LmcuDQo+Pj4NCj4+PiB2YWxncmluZCAuLi4gZW52IFRNUERJUj0vbm9uZXhpc3RlbnQgcWVtdSAu
Li4NCj4+Pg0KPj4+IC4uLiBJdCdzIHByb2JhYmx5IG5vdCB3b3J0aCB0cnlpbmcgdG8gY29uY29j
dCBzdWNoIGEgdGhpbmc7IGJ1dCBJDQo+Pj4gc3VwcG9zZSBpdCBpcyBwb3NzaWJsZS4gWW91J2Qg
aGF2ZSB0byBzZXQgdXAgYSBnZW5lcmljIGxheWVyIGZvciBzZXR0aW5nDQo+Pj4gZW52aXJvbm1l
bnQgdmFyaWFibGVzLCB0aGVuIGluIHRoZSBxZW11IHNoaW0sIHlvdSBjb3VsZCBlaXRoZXIgc2V0
IHRoZW0NCj4+PiBkaXJlY3RseSAobm9uLXZhbGdyaW5kIGludm9jYXRpb24pIG9yIHNldCB0aGVt
IGFzIHBhcnQgb2YgdGhlIHZhbGdyaW5kDQo+Pj4gY29tbWFuZC1saW5lLg0KPj4+DQo+Pj4gT3Ig
eW91IGNvdWxkIGp1c3QgdGFrZSBteSBSLUI6DQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogSm9obiBT
bm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4+DQo+Pg0KPj4gVGhhbmtzIGFnYWluIEpvaG4gZm9y
IHlvdXIgcmV2aWV3IGFuZCB0aGUgYWR2aWNlLg0KPj4gUHJvYmFibHksIGl0IGRvZXNuJ3Qgd29y
dGggZWZmb3J0cyB0byBtYW5hZ2UgdGhhdCBjYXNlIGJlY2F1c2UgUUVNVQ0KPj4gc2hvdWxkIGZh
aWwgYW55d2F5IHdpdGggdGhlIGVycm9yIG1lc3NhZ2UgIkNvdWxkIG5vdCBnZXQgdGVtcG9yYXJ5
DQo+PiBmaWxlbmFtZTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSIuIFNvLCB3ZSB3b3VsZCBu
b3QgYmVuZWZpdCBtdWNoIGZyb20NCj4+IHRoYXQgcnVuLiBXZSBoYXZlIG90aGVyIHRlc3QgY2Fz
ZXMgdGhhdCBjb3ZlciB0aGUgbWFpbiBmdW5jdGlvbmFsaXR5Lg0KPj4gSXQncyBqdXN0IHRvIGNo
ZWNrIHRoZSBRRU1VIGVycm9yIHBhdGggZm9yIHBvc3NpYmxlIG1lbW9yeSBpc3N1ZXMuIFNoYWxs
IHdlPw0KPj4NCj4+IEFuZHJleQ0KPj4NCj4gDQo+IFllYWgsIGRvbid0IGJvdGhlciB3aXRoIHRo
aXMgZm9yIG5vdy4gSSBqdXN0IGhhdmUgYSBwZXJzb25hbCBjb21wdWxzaW9uDQo+IHRvIHRyeSB0
byBjb25jcmV0ZWx5IG1lYXN1cmUgaG93IG11Y2ggd29yayBpdCB3b3VsZCB0YWtlIHRvIGF2b2lk
IGENCj4gImhhY2siIGFuZCB0aGVuIG1ha2UgbXkgZGVjaXNpb24uDQo+IA0KPiBZb3UncmUgZnJl
ZSB0byBqdXN0IHRha2UgdGhlIFItQiA6KQ0KPiANCj4gLS1qcw0KPiANCg0KVGhhbmsgeW91LCBK
b2huLiBEb25lIGluIHY2Lg0KUGxlYXNlIGNoZWNrIHRoZSBzZXJpZXMgaW4gdGhlIGVtYWlsIG1l
c3NhZ2UNCiJbUEFUQ0ggdjYgMC82XSBBbGxvdyBWYWxncmluZCBjaGVja2luZyBhbGwgUUVNVSBw
cm9jZXNzZXMiDQpieSAyNi4wOC4yMDE5IHdpdGggdGhlIG1lc3NhZ2UgSUQNCjwxNTY2ODM0NjI4
LTQ4NTUyNS0xLWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+
DQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmlj
aA0K

