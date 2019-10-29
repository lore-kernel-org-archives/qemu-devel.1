Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC40CCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5872086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JxbaNPHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5872086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQAO-0007o0-AQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQ7m-0005L6-4I
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQ7k-0006KY-Lp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:57:21 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com
 ([40.107.8.128]:13078 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iPQ7i-0006J2-Ea; Tue, 29 Oct 2019 07:57:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9TxCntJtjaz/RPS+glh8dTQ8XKJYFmTs9zgkgTFM/SU8KSN28fZLvLm6NTH0CdSFBfQFh9LcsTiWXgdVoKUHgIJGtCmzqq5a6X5xJ71pSXdN1EZoaLaCw/Fd/Ir+igrHRn7d0BbbLC4Di4N57piKnuajcuc2m6YQ5QHeKTxuIHrny0NDWNEQOlYxiifj8SsJmsGXny3qAdkZBveaa6h7wYNNuLC4F9gWLUAiDq8dEaPWSk7vakPNgB+moIq4vdSLrho/aT03kimVzxgJeA2z9NtUisrjohF/5NWLYZo66amzcN1/6QSo4IVZkW3kenDO+i3gZbuYlwuTX/miZcGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECFE7A69ASplArgbKZK6bi1gHChXqU2dU8PDnhp/4rU=;
 b=lBdW0Tm8q4MkDjwy7tMCq3d3pHE7tvKm8zblT2dSmd2V6z8+/w2yTo3Wr2JwBhQ1SfbnA+vOXaVv/rN00jJVnxcOHdiY4FWoAwsEv35pcAZ2SCMapdmQT8yhe4N3tRU95QtV9/BiMw81fiQpXz42RPgM+xh8I59C7SYZdzpSLrKbKuqU9rxh0DV0xd9MkqZd2M7TDpIUjX89VWnkYQCYO2jrdOxMgwIf4HqMj7VLsiRc4DbJLWRMckFJiLp+RhNP44CxkV+lKdT1IeiyKbnWCjYS8Myb2K4qepLqS43UjRg0q8ErApRfGFAjX01rGXng+QSk4LN8Uh6wf3Bt1GK4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECFE7A69ASplArgbKZK6bi1gHChXqU2dU8PDnhp/4rU=;
 b=JxbaNPHMcRFiuqKFEriXpeR4YnvlzyrequhewqUvCLE+Sobe/R1vvWd1HBXTxkBJ49og1wXpEr95Wb3tSSHhyKsOy5nWgDnqinjKm/WBGWRe71VR4z1o79wgWg4E/Lb5/LFjavQrUoSgKfyUpM6+fJszA8G03iJl7kX0aPq3aA4=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3763.eurprd08.prod.outlook.com (20.178.82.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 11:57:15 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 11:57:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Tuguoyi <tu.guoyi@h3c.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWNWOAJ7czUdZfnT3+PEnECPxQetwA8Sm8AAAF9noA=
Date: Tue, 29 Oct 2019 11:57:15 +0000
Message-ID: <c5c45c60-8d8a-ca0d-4a89-4a5e26176164@virtuozzo.com>
References: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
 <8f65c725-68ae-6a9f-d155-cb0dd15c995e@redhat.com>
In-Reply-To: <8f65c725-68ae-6a9f-d155-cb0dd15c995e@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0038.eurprd07.prod.outlook.com
 (2603:10a6:7:66::24) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191029145713144
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0fbb5b6-691a-43a2-2745-08d75c672445
x-ms-traffictypediagnostic: AM0PR08MB3763:
x-microsoft-antispam-prvs: <AM0PR08MB3763026E47B59E2407A39B8DC1610@AM0PR08MB3763.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(189003)(199004)(478600001)(71190400001)(8936002)(71200400001)(4326008)(66066001)(25786009)(99286004)(7416002)(6512007)(6436002)(229853002)(6486002)(256004)(316002)(86362001)(5660300002)(54906003)(110136005)(2201001)(31696002)(8676002)(26005)(36756003)(486006)(6506007)(305945005)(31686004)(3846002)(64756008)(66556008)(66446008)(52116002)(76176011)(2501003)(66476007)(66946007)(386003)(6116002)(476003)(11346002)(446003)(2616005)(102836004)(6246003)(186003)(81166006)(53546011)(7736002)(81156014)(14454004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3763;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeMmmm41Wv3geH+YVTg9GHv/8KDHHMxVS6sgx6dRJ0z9MvPh1IV3G6y1c7hL6QqyFIImZHlQxUzTAzFU1RgqQqm7yjhRwpV7hXrXQf848AQyqCRk0CLs28c/Ux616j8nwwT5hptp9dyQNq1PUPwu9qy20OOdjqdpqrDNT5bGZDphelvy3D+FenLLwYocmU+dIg9r6pkG689KkZDutgRqm4zTCgIqJ2AzU58o3X9wrrrqGrzmREdz7MG7f4MbMh1luWr9RVha3Uh9RFlmMRt2WvcenguqUei+XpOORq6QnvYBOEkr9wp6VLJ6/fi0G79MlP6C8qqmTkV6lpS4HO36KKRpQxJWDd5nwU+MrcLy8E8ufQPmbzXVbDqEznR0iH7aOoXkbMwZoVQgV9Bv7BWQymO5c5he2RaPgKgky5BoxfEm+P+5sgNT0qiEqUN5R7Hl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9102EFD3E9C3784E914F3BC3415A61CC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fbb5b6-691a-43a2-2745-08d75c672445
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:57:15.7592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uvw5XKg92C4vPruzzt3fFXg5da9nlbEzI7fPBmMDT5IVukoVbhIx/GlXQ/Kwe8ZKaG8t7v3Zq7FHz6+MX3mjJKvn8zlQ0YP6wHuHwr/K41I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3763
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.128
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTAuMjAxOSAxNDoxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOC4xMC4xOSAwNzozMywg
VHVndW95aSB3cm90ZToNCj4+IEluIGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcCgpLCB0aGUg
c2FuaXR5IGNoZWNrIG9uIHRoZQ0KPj4gZ3JhbnVsYXJpdHkgd2lsbCBjYXVzZSB1aW50NjRfdCBp
bnRlZ2VyIGxlZnQtc2hpZnQgb3ZlcmZsb3cNCj4+IHdoZW4gY2x1c3Rlcl9zaXplIGlzIDJNIGFu
ZCB0aGUgZ3JhbnVsYXJpdHkgaXMgQklHR0VSIHRoYW4NCj4+IDMySy4gQXMgYSByZXN1bHQsIGZv
ciBhIHFjb3cyIGRpc2sgd2l0aCBjbHVzdGVyX3NpemUgc2V0IHRvDQo+PiAyTSwgd2UgY291bGQg
bm90IGV2ZW4gY3JlYXRlIGEgZGlydHkgYml0bWFwIHdpdGggZGVmYXVsdA0KPj4gZ3JhbnVsYXJp
dHkuIFRoaXMgcGF0Y2ggZml4IHRoZSBpc3N1ZSBieSBkaXZpZGluZyBAbGVuIGJ5DQo+PiBncmFu
dWxhcml0eSBpbnN0ZWFkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEd1b3lpIFR1IDx0dS5ndW95
aUBoM2MuY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgNCArKy0tDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jIGIvYmxvY2svcWNvdzItYml0bWFw
LmMNCj4+IGluZGV4IDk4Mjk0YTcuLjcxYWM4MjIgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293
Mi1iaXRtYXAuYw0KPj4gKysrIGIvYmxvY2svcWNvdzItYml0bWFwLmMNCj4+IEBAIC0xNzIsOCAr
MTcyLDggQEAgc3RhdGljIGludCBjaGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICAgICAgaWYgKChsZW4gPiAodWlu
dDY0X3QpQk1FX01BWF9QSFlTX1NJWkUgPDwgZ3JhbnVsYXJpdHlfYml0cykgfHwNCj4+IC0gICAg
ICAgIChsZW4gPiAodWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICogcy0+Y2x1c3Rlcl9zaXpl
IDw8DQo+PiAtICAgICAgICAgICAgICAgZ3JhbnVsYXJpdHlfYml0cykpDQo+PiArICAgICAgICAo
RElWX1JPVU5EX1VQKGxlbiwgZ3JhbnVsYXJpdHkpID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVf
U0laRSAqDQo+PiArICAgICAgICAgICAgICAgIHMtPmNsdXN0ZXJfc2l6ZSkpDQo+IA0KPiBUaGlz
IGRpZG7igJl0IGNoYW5nZSBiZWNhdXNlIG9mIHRoaXMgcGF0Y2gsIGJ1dCBkb2VzbuKAmXQgdGhp
cyBjb21wYXJpc29uDQo+IG5lZWQgYSBjb252ZXJzaW9uIG9mIGJpdHMgdG8gYnl0ZXMgc29tZXdo
ZXJlPw0KPiANCj4gbGVuIC8gZ3JhbnVsYXJpdHkgZ2l2ZXMgdXMgdGhlIG51bWJlciBvZiBiaXRz
IG5lZWRlZCBmb3IgdGhlIGJpdG1hcC4NCj4gDQo+IEJNRV9NQVhfVEFCTEVfU0laRSBpcywgYXMg
ZmFyIGFzIEkgY2FuIHNlZSwgYSBudW1iZXIgb2YgYml0bWFwIGNsdXN0ZXJzLA0KPiBzbyBtdWx0
aXBseWluZyBpdCBieSB0aGUgY2x1c3RlciBzaXplIGdpdmVzIHRoZSBudW1iZXIgb2YgYnl0ZXMg
aW4gdGhlDQo+IGJpdG1hcC4gIEJ1dCB0aGUgbnVtYmVyIG9mIGJpdHMgaXMgZWlnaHQgdGltZXMg
aGlnaGVyLg0KDQpJIHRoaW5rIHlvdSBhcmUgcmlnaHQuIEl0IHdvdWxkIGJlIGJldHRlciB0byBm
aXggaXQgaW4gdGhlIHNhbWUgcGF0Y2guLg0KDQo+IA0KPiBBbm90aGVyIHRvcGljOiBJc27igJl0
IEJNRV9NQVhfVEFCTEVfU0laRSB0b28gYmlnPw0KDQpNYXliZSkgU3RpbGwsIEkgZG9uJ3Qgc3Vy
ZSB0aGF0IHdlIG5lZWQgdG8gY2hhbmdlIGl0Li4NCg0KPiAgQXMgaXQgaXMsIGJpdG1hcA0KPiB0
YWJsZXMgY2FuIGhhdmUgYSBzaXplIG9mIDEgR0IsIGFuZCB0aGF04oCZcyB0aGUgdGFibGUgYWxv
bmUuICBEZXBlbmRpbmcNCj4gb24gdGhlIGNsdXN0ZXIgc2l6ZSwgdGhlIGJpdG1hcCB3b3VsZCB0
YWtlIHVwIGF0IGxlYXN0IDY0IEdCIGFuZCBjb3Zlcg0KPiBhdCBsZWFzdCAzMiBUQiAoYXQgYSBn
cmFudWxhcml0eSBvZiA1MTIgYnl0ZXMpLg0KPiANCj4gTWF4DQo+IA0KPj4gICAgICAgew0KPj4g
ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlRvbyBtdWNoIHNwYWNlIHdpbGwgYmUgb2NjdXBp
ZWQgYnkgdGhlIGJpdG1hcC4gIg0KPj4gICAgICAgICAgICAgICAgICAgICAgIlVzZSBsYXJnZXIg
Z3JhbnVsYXJpdHkiKTsNCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

