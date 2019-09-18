Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EDC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED3C218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mk+m78Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED3C218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbip-0002tq-N6
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAbgo-0001if-A7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAbgk-0007f8-L0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:16:17 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:6238 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAbgg-0007cA-Uh; Wed, 18 Sep 2019 11:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGuztisjeT2ZlWvhCrYxY1Tf4bvC1SPLGcmMzYS5C1fWGGPz5fCGodl53hohlz/jtnSJEYfBAYVS1qIIZ02gQZdxoDMMybOezizFS00ahRfJLbcDKMK+Isg/zFkMJoNggbMldUvPJ0Ma7tVq/klcKFEOoaFEoIDjRSC/I8bPjfS1/VXmXtVQfIkMkspz51trpjpaHTYRx3sJkHuxAqkkiJg/KEE6LLL3eqBEqZbEgr0FBpTa06oA+erD2zeM28Z+pMsfUzfkRFi18Lsp7LhrrzjvDmJZ0t4siAtzv6zuNZ7qvDccER1zqWpdwXr3ziDp/DxBN9XNDSe9bMkE7KPbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09JlsTLyfw0eY8pVUMnAb+WUFcMPusP5KFNBsf7qn4=;
 b=oHC9EbjmuxYdnDlq0wT3RWUJ7lyMlDzGkjx3gqK06VRL22hA+fINoPmUA5lJ20PdSmpi3cMX7sxZy1J65ybMiTwF1JawOhZfltiHXW0kf/T3xo6lVHXxOMeP1TV5c9pL3Vv38/ls1+TycihczKw2I8FaTLZiWvawF657c9U0txJ251kV2zfsuDg8XKNR7DN77PL08iF8JkxApgJkFOaocQ7kwVS8uiuvPIyaVhUACom99AoOw8uDs9DfJqiy0KXxHLtONrQEaPC3bd79ola1dj0AJnnfswJLDuw9EYcmbD/BCimRQ7sCbzr/k/saSVHQhlOyymyCfICK6YrtC6/b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09JlsTLyfw0eY8pVUMnAb+WUFcMPusP5KFNBsf7qn4=;
 b=mk+m78OsigEhT0uQZFNNhEJbU/nQH1pDmOexFNfdq8TiVqWicDnPFQSCDNoGsEsWqFyXoVT8A4lV8TcswKAuBk+Kqfjktx1b4AoWtGz3MqWARKAUbgoPIcC2WW9rKN8XqxWQIElF1teGc7mz0sDaofdxO2A1HTOi2UKGAo5KTC0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4044.eurprd08.prod.outlook.com (20.179.10.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 15:16:08 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 15:16:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/4] mirror: Do not dereference invalid
 pointers
Thread-Index: AQHVaXS2DVNGncqjs0qbhDrkQGrjWacxlRGA
Date: Wed, 18 Sep 2019 15:16:08 +0000
Message-ID: <ee392c08-97e3-5d67-4d86-28b3b009268c@virtuozzo.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-2-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:7:29::47) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918181605699
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d505de60-b940-421b-60f6-08d73c4b2180
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4044; 
x-ms-traffictypediagnostic: DB8PR08MB4044:
x-microsoft-antispam-prvs: <DB8PR08MB40444711464EC6DB5391B5C0C18E0@DB8PR08MB4044.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(189003)(25786009)(3846002)(26005)(305945005)(229853002)(64756008)(66556008)(11346002)(186003)(71190400001)(76176011)(4326008)(6506007)(6116002)(446003)(486006)(7736002)(476003)(386003)(71200400001)(6246003)(31686004)(2616005)(99286004)(54906003)(66476007)(14454004)(86362001)(81166006)(8936002)(8676002)(6436002)(81156014)(316002)(66446008)(256004)(102836004)(6512007)(36756003)(52116002)(110136005)(66066001)(66946007)(6486002)(2906002)(31696002)(5660300002)(478600001)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4044;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ItwSKLkylh0OZLQjmeyYB7Selb06mJK1GyVIsx3QC25Dm9WEGg2LOpQcgdXhiKjGUjM/9ihXHdZKhPL0mVbT4zHZ8hIphve29l/R9BDjIYAhRR4BlvD3uyGyPUifUlgsdql3QlNluK3Pz+BmRJ1PLYP0tZkk7rOYsVl4yIm++AGxCN2u7Uy4pmCjpplT/bbi/IV9F4PW0fi+4CjN/EcpNk3WDboJojFJvwSk5HJ1T4Wobv2R7FZLAbtS60ksIITlVRKLPJkjEKeXTMA5JHUbouMY75alNE9VKBJN2uOrEvy0ZtpK5AZlxe0hk3dCc4wVPkLkXJNM1MjZo+V5sK3Uru+ODF3tkU4hOg1WlPE4DThhBAm4eL1rr1XliuNfuGIPXzKgDR9JCvH+BS9FBduEoc2MW9MyFcvkvH0AMPcJ+5M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <860D725636737A428A13B635C550644C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d505de60-b940-421b-60f6-08d73c4b2180
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 15:16:08.0301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byhbK2iEBJ0COqKqJALqfu343L8AWE81TOqcfk+EehvVf4HFak77cOQ92z2GhdXCvoGzChqM0SQCy9jw9Zghh/AiPirBzEEYpQaBy/VlIs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4044
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.121
Subject: Re: [Qemu-devel] [PATCH 1/4] mirror: Do not dereference invalid
 pointers
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAxNjo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBtaXJyb3JfZXhpdF9jb21tb24o
KSBtYXkgYmUgY2FsbGVkIHR3aWNlIChpZiBpdCBpcyBjYWxsZWQgZnJvbQ0KPiBtaXJyb3JfcHJl
cGFyZSgpIGFuZCBmYWlscywgaXQgd2lsbCBiZSBjYWxsZWQgZnJvbSBtaXJyb3JfYWJvcnQoKQ0K
PiBhZ2FpbikuDQo+IA0KPiBJbiBzdWNoIGEgY2FzZSwgbWFueSBvZiB0aGUgcG9pbnRlcnMgaW4g
dGhlIE1pcnJvckJsb2NrSm9iIG9iamVjdCB3aWxsDQo+IGFscmVhZHkgYmUgZnJlZWQuICBUaGlz
IGNhbiBiZSBzZWVuIG1vc3QgcmVsaWFibHkgZm9yIHMtPnRhcmdldCwgd2hpY2gNCj4gaXMgc2V0
IHRvIE5VTEwgKGFuZCB0aGVuIGRlcmVmZXJlbmNlZCBieSBibGtfYnMoKSkuDQo+IA0KPiBDYzog
cWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPiBGaXhlczogNzM3ZWZjMWVkYTIzYjkwNGZiZTBlNjZi
Mzc3MTVmYjBlNWMzZTU4Yg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2NrL21pcnJvci5jIHwgMTMg
KysrKysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svbWlycm9yLmMgYi9ibG9jay9taXJy
b3IuYw0KPiBpbmRleCBmZTk4NGVmYjkwLi43MDZkODBmY2VkIDEwMDY0NA0KPiAtLS0gYS9ibG9j
ay9taXJyb3IuYw0KPiArKysgYi9ibG9jay9taXJyb3IuYw0KPiBAQCAtNjIwLDExICs2MjAsMTEg
QEAgc3RhdGljIGludCBtaXJyb3JfZXhpdF9jb21tb24oSm9iICpqb2IpDQo+ICAgew0KPiAgICAg
ICBNaXJyb3JCbG9ja0pvYiAqcyA9IGNvbnRhaW5lcl9vZihqb2IsIE1pcnJvckJsb2NrSm9iLCBj
b21tb24uam9iKTsNCj4gICAgICAgQmxvY2tKb2IgKmJqb2IgPSAmcy0+Y29tbW9uOw0KPiAtICAg
IE1pcnJvckJEU09wYXF1ZSAqYnNfb3BhcXVlID0gcy0+bWlycm9yX3RvcF9icy0+b3BhcXVlOw0K
PiArICAgIE1pcnJvckJEU09wYXF1ZSAqYnNfb3BhcXVlOw0KPiAgICAgICBBaW9Db250ZXh0ICpy
ZXBsYWNlX2Fpb19jb250ZXh0ID0gTlVMTDsNCj4gLSAgICBCbG9ja0RyaXZlclN0YXRlICpzcmMg
PSBzLT5taXJyb3JfdG9wX2JzLT5iYWNraW5nLT5iczsNCj4gLSAgICBCbG9ja0RyaXZlclN0YXRl
ICp0YXJnZXRfYnMgPSBibGtfYnMocy0+dGFyZ2V0KTsNCj4gLSAgICBCbG9ja0RyaXZlclN0YXRl
ICptaXJyb3JfdG9wX2JzID0gcy0+bWlycm9yX3RvcF9iczsNCj4gKyAgICBCbG9ja0RyaXZlclN0
YXRlICpzcmM7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqdGFyZ2V0X2JzOw0KPiArICAgIEJs
b2NrRHJpdmVyU3RhdGUgKm1pcnJvcl90b3BfYnM7DQo+ICAgICAgIEVycm9yICpsb2NhbF9lcnIg
PSBOVUxMOw0KPiAgICAgICBib29sIGFib3J0ID0gam9iLT5yZXQgPCAwOw0KPiAgICAgICBpbnQg
cmV0ID0gMDsNCj4gQEAgLTYzNCw2ICs2MzQsMTEgQEAgc3RhdGljIGludCBtaXJyb3JfZXhpdF9j
b21tb24oSm9iICpqb2IpDQo+ICAgICAgIH0NCj4gICAgICAgcy0+cHJlcGFyZWQgPSB0cnVlOw0K
PiAgIA0KPiArICAgIG1pcnJvcl90b3BfYnMgPSBzLT5taXJyb3JfdG9wX2JzOw0KPiArICAgIGJz
X29wYXF1ZSA9IG1pcnJvcl90b3BfYnMtPm9wYXF1ZTsNCj4gKyAgICBzcmMgPSBtaXJyb3JfdG9w
X2JzLT5iYWNraW5nLT5iczsNCj4gKyAgICB0YXJnZXRfYnMgPSBibGtfYnMocy0+dGFyZ2V0KTsN
Cj4gKw0KPiAgICAgICBpZiAoYmRydl9jaGFpbl9jb250YWlucyhzcmMsIHRhcmdldF9icykpIHsN
Cj4gICAgICAgICAgIGJkcnZfdW5mcmVlemVfYmFja2luZ19jaGFpbihtaXJyb3JfdG9wX2JzLCB0
YXJnZXRfYnMpOw0KPiAgICAgICB9DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

