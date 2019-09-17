Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C36C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935FD21670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ut4bc2tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935FD21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB7e-0003mN-Q7
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAApB-00025i-Eh
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAAp9-00058c-K9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:35:08 -0400
Received: from mail-eopbgr150119.outbound.protection.outlook.com
 ([40.107.15.119]:57925 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAAp9-00057M-08; Tue, 17 Sep 2019 06:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXhVjBipSTqSQEJSITZUj+YjKU5HRcb9as61YHoRmovS8G1OHTLGDdjrnLueSumusbYW5wPJWlsA/SY1bs680gEVVr7oPp56jjyn1VCCKKuHCwOmLWXqi1c4zBcMUpxo1FRmuic/SAl8IjmUH7J/6zohrlu6NcwJupezAdI20vdIrv/bxPIZBbju9S7C68l7/gLfSMfRXKI1aK5vHaIENcvbax1kdxyjwKjjU5zoJu9Jeem1KDLH8hmUaU+N95avGU6M3DWfKeEKjq7zsHPaw5VhOKNfozAxFOe4/kcRW6d1J0dNBi//cfSG9PmoPh+KPOFPh52OV6Tmz3eqDcI9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++lEKp9LIfc6Txp93ysp5a1P1A6vWDz5lUPDu5Aq5jU=;
 b=QqZ5gjTcbAzTVYp35G7Mk+Fow1lcinpIJqj5946Vhwz9A9vbPyng9TCRlDYyGik7r04zA2IbDXTxlV8rhGsoARcF/wu4Xoz2bZW7dtCwgEjdNppPxpqjkghLWiodXXcHXaUQZyavUvrz8hgVL9uwagOz33qfxoEv9gOaIimZLI0Urm8U6VEGNWdFyhBcKLHYobsbpFh/dEn7yp20yOcUzrQFBYEZLUY3A0WJGcP6Iv/CaXDviYe82tNf3YYmaDA4u1AOKz8QQUwAsx1guU4t2fF6FA3iPfB4yOJMRmHDo3HnWaeQgwJNfRydNqdCupQVJHe4yzbg7fSQlKSJKBCNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++lEKp9LIfc6Txp93ysp5a1P1A6vWDz5lUPDu5Aq5jU=;
 b=ut4bc2tVtod7s7Wkjyej3ncflhU3+TVeQtn1Tz4XYMsnWUWbm3P7YdsRhPz+8jsXj0Z1wj55beeDOVHBQ7+KSqMqDmCGbjhowt3EtV++YxAXrZxFsvYk2LHP/dP6dXtmtFfWLJyNJxXTpsbLhePILZzMV/P2f+eAblQJqgfxVU0=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2362.eurprd08.prod.outlook.com (10.172.131.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Tue, 17 Sep 2019 10:35:03 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 10:35:03 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 1/7] iotests: Prefer null-co over null-aio
Thread-Index: AQHVbTkfgVf10i1Q2UC+Tm2h5se2AqcvrK0A
Date: Tue, 17 Sep 2019 10:35:03 +0000
Message-ID: <f374c7dc-8834-1429-9869-6f92b15c8a49@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-2-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-2-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0252.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::28) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e88c5ad-c8de-4fe1-4b7a-08d73b5ab31f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2362; 
x-ms-traffictypediagnostic: HE1PR0802MB2362:
x-microsoft-antispam-prvs: <HE1PR0802MB23624F872581FEF6045ADA17F48F0@HE1PR0802MB2362.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(366004)(136003)(396003)(199004)(189003)(2501003)(486006)(66556008)(6506007)(7736002)(229853002)(86362001)(186003)(8676002)(4326008)(386003)(26005)(446003)(476003)(11346002)(6486002)(6512007)(6436002)(53546011)(2616005)(6246003)(66066001)(81166006)(478600001)(102836004)(25786009)(5660300002)(110136005)(76176011)(36756003)(256004)(6116002)(316002)(52116002)(44832011)(2906002)(81156014)(3846002)(71190400001)(71200400001)(31696002)(99286004)(31686004)(305945005)(66476007)(66946007)(66446008)(64756008)(8936002)(14454004)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2362;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FZ+yqGUtw3UNBP4pqh96ya6G0tIrLytCIPEC2QaKjrokh3yACAuENof+iBOmQX8oy+KLLajw7tfz5NdVGhNAa3J2WiqbjXRknIYdQVfP6ySMQV/vVKJHfFHUGrn7H3fm26PrCR/mOrDpySlcOD2AUrz3NM7S3u6ebtL9ZBrzYhEG2ActI52oS7K4Q+8gR5SCvW/FT2ABHSjQvEQLIuXMeRZL9M7smULoXFWh9KmpruCmTNj1DoMCpRnAHeWgGGHvNz0c9XZ7/lthUR8ATLAuMk/mwnF1YiX2AYPDV37j9nPF7vakyYD9wvRxMK1Ln7LKA8keg+1zBf83jwflF6THOC5gyIS0Af9Cxi97xu8YSnqlSWXV6zQ4RmD/W3qVlRuXTRy4dYGLZpZ0OSrQy0/zJs7/ft/FHEioKFVFhUahqwU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DA83B4802948042BF512C541B934FCC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e88c5ad-c8de-4fe1-4b7a-08d73b5ab31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 10:35:03.6311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 009e6mCxGBb4Wo0yRo7gxosA3aLdhWMZXmHmBv4KTfBR80nobPRgYqnX5NQ/HSHf8Pl6qH7xm7Kgn5yydsjLaQg3W5mLelRrPY80hueoM0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2362
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.119
Subject: Re: [Qemu-devel] [PATCH v4 1/7] iotests: Prefer null-co over
 null-aio
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LzA5LzIwMTkgMTI6MTksIE1heCBSZWl0eiB3cm90ZToNCj4gV2UgdXNlIG51bGwt
Y28gYmFzaWNhbGx5IGV2ZXJ5d2hlcmUgaW4gdGhlIGlvdGVzdHMuICBVbmxlc3Mgd2Ugd2FudCB0
bw0KPiB0ZXN0IG51bGwtYWlvIHNwZWNpZmljYWxseSwgd2Ugc2hvdWxkIHVzZSBpdCBpbnN0ZWFk
IChmb3IgY29uc2lzdGVuY3kpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiAtLS0N
Cj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDkzIHwgNyArKystLS0tDQo+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzI0NSB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDkz
IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA5Mw0KPiBpbmRleCAzYzRmNTE3M2NlLi41MGMxZTdmMmVj
IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDkzDQo+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8wOTMNCj4gQEAgLTI2NywxMyArMjY3LDEyIEBAIGNsYXNzIFRocm90dGxlVGVz
dENvcm91dGluZShUaHJvdHRsZVRlc3RDYXNlKToNCj4gICAgICAgdGVzdF9pbWcgPSAibnVsbC1j
bzovLyINCj4gICANCj4gICBjbGFzcyBUaHJvdHRsZVRlc3RHcm91cE5hbWVzKGlvdGVzdHMuUU1Q
VGVzdENhc2UpOg0KPiAtICAgIHRlc3RfaW1nID0gIm51bGwtYWlvOi8vIg0KPiAgICAgICBtYXhf
ZHJpdmVzID0gMw0KPiAgIA0KPiAgICAgICBkZWYgc2V0VXAoc2VsZik6DQo+ICAgICAgICAgICBz
ZWxmLnZtID0gaW90ZXN0cy5WTSgpDQo+ICAgICAgICAgICBmb3IgaSBpbiByYW5nZSgwLCBzZWxm
Lm1heF9kcml2ZXMpOg0KPiAtICAgICAgICAgICAgc2VsZi52bS5hZGRfZHJpdmUoc2VsZi50ZXN0
X2ltZywNCj4gKyAgICAgICAgICAgIHNlbGYudm0uYWRkX2RyaXZlKCJudWxsLWNvOi8vIiwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidGhyb3R0bGluZy5pb3BzLXRvdGFsPTEw
MCxmaWxlLnJlYWQtemVyb2VzPW9uIikNCj4gICAgICAgICAgIHNlbGYudm0ubGF1bmNoKCkNCj4g
ICANCj4gQEAgLTM3NiwxMCArMzc1LDEwIEBAIGNsYXNzIFRocm90dGxlVGVzdFJlbW92YWJsZU1l
ZGlhKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgIA0KPiAgICAgICBkZWYgdGVzdF9yZW1vdmFi
bGVfbWVkaWEoc2VsZik6DQo+ICAgICAgICAgICAjIEFkZCBhIGNvdXBsZSBvZiBkdW1teSBub2Rl
cyBuYW1lZCBjZDAgYW5kIGNkMQ0KPiAtICAgICAgICByZXN1bHQgPSBzZWxmLnZtLnFtcCgiYmxv
Y2tkZXYtYWRkIiwgZHJpdmVyPSJudWxsLWFpbyIsDQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYu
dm0ucW1wKCJibG9ja2Rldi1hZGQiLCBkcml2ZXI9Im51bGwtY28iLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVhZF96ZXJvZXM9VHJ1ZSwgbm9kZV9uYW1lPSJjZDAiKQ0KPiAg
ICAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiAtICAgICAg
ICByZXN1bHQgPSBzZWxmLnZtLnFtcCgiYmxvY2tkZXYtYWRkIiwgZHJpdmVyPSJudWxsLWFpbyIs
DQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCJibG9ja2Rldi1hZGQiLCBkcml2ZXI9
Im51bGwtY28iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVhZF96ZXJvZXM9
VHJ1ZSwgbm9kZV9uYW1lPSJjZDEiKQ0KPiAgICAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3Vs
dCwgJ3JldHVybicsIHt9KQ0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI0NSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDUNCj4gaW5kZXggNDEyMThkNWYxZC4uZTY2YTIz
YzVmMCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0NQ0KPiArKysgYi90ZXN0
cy9xZW11LWlvdGVzdHMvMjQ1DQo+IEBAIC01OTgsNyArNTk4LDcgQEAgY2xhc3MgVGVzdEJsb2Nr
ZGV2UmVvcGVuKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgIyMjIyMjIyMjIyMj
IyMjIyMjDQo+ICAgICAgICAgICAjIyMjIyMgbnVsbCAjIyMjIyMNCj4gICAgICAgICAgICMjIyMj
IyMjIyMjIyMjIyMjIw0KPiAtICAgICAgICBvcHRzID0geydkcml2ZXInOiAnbnVsbC1haW8nLCAn
bm9kZS1uYW1lJzogJ3Jvb3QnLCAnc2l6ZSc6IDEwMjR9DQo+ICsgICAgICAgIG9wdHMgPSB7J2Ry
aXZlcic6ICdudWxsLWNvJywgJ25vZGUtbmFtZSc6ICdyb290JywgJ3NpemUnOiAxMDI0fQ0KPiAg
IA0KPiAgICAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrZGV2LWFkZCcsIGNvbnZf
a2V5cyA9IEZhbHNlLCAqKm9wdHMpDQo+ICAgICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0
LCAncmV0dXJuJywge30pDQo+IA0KDQpSZXZpZXdlZC1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFu
ZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJk
cywNCkFuZHJleSBTaGlua2V2aWNoDQo=

