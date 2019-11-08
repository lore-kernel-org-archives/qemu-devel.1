Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78777C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FC721D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KlKgKEar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FC721D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4xj-0005oe-B6
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4ti-0001AO-Eq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4th-0002jS-7t
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:05:58 -0500
Received: from mail-eopbgr00131.outbound.protection.outlook.com
 ([40.107.0.131]:2334 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT4th-0002jE-2F; Fri, 08 Nov 2019 09:05:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPZYna7mFrbMivHeLrKYMi3Mjv8TvHCAr7mb6whmKjbKhBvKb9TrzGIOj0UQrKlWyA2FdxRvO7bGva20d2RlIm7ETjEtWYxAeYJ6mweoq8FVpAbRmL/Xg+8L27/BBAz7R46ZMB6vbzAtXYN15iAKy4HWYpvLprMWGWzIwXnAYXqhKJQ9jS4d45wOjy2XylTJcKT9TlUU9aVfV6ijPhuIhKJnQarS5B96b6XHl2JXxDwPElej05S8Xjjixi1czDJFD1oofhdTGKm9aO3fmXY+eGsCcyutCj34cXZStY7arnyaddEnscLyRFCFUYZMltdPPOAYSkDqhJwjwjAGTFVhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxLsAAY44g0C42N3WxNE8DSwj5qHpLlDqtkipkeuURw=;
 b=B8VVn7GaWYmxBuTB8XfDqS9HEXuNNIZPviUN0vupBrm/DBSc+C06caBHe8gLW+ZaRXVcNZYX0o3Y13dtZfkp6ULc6yy+VsFP2N5XUvnYFKqL1M1eiClxvjCVIY4dI2qn8L6ccZgoJdfS3H7O9guAAB/jE2szBSHtVgiHcfMGpaJUef108+6YOMmOZZ1LjWte+jGl7/MYoqJf2yuj7WKLpBl7kU8a9BhMBtYxK14WUfwEPsP0VClwRSwHJUNquzSsUzhPJhtpVxtXEINvBwwXnG6AF1hGJsTIYymUiRV2LTBw2Sdge1YL16htH21bWWe531JavU9g71c4SsULrwfv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxLsAAY44g0C42N3WxNE8DSwj5qHpLlDqtkipkeuURw=;
 b=KlKgKEar9QSDD4NVyXWZEEg5ZpM8CVsWxIFR7Gv5JN6vID+lrQHWHfpRGYobMS/fhmmAVWKQeh+8OWrU4H17ZIfeIIZkcDtFG4RFdcpMtFhWNz8YjaLIprmDqFARr8QYnR3mv3MAerC1vPHJ5sqeT7PHk+IUb5mA71i4gddz+yM=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3761.eurprd08.prod.outlook.com (20.178.23.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 14:05:54 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 14:05:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v4 1/5] block: Add bdrv_qapi_perm_to_blk_perm()
Thread-Topic: [PATCH for-5.0 v4 1/5] block: Add bdrv_qapi_perm_to_blk_perm()
Thread-Index: AQHVljDxgCMEQd4wGU2ON230PseUU6eBTuAA
Date: Fri, 8 Nov 2019 14:05:54 +0000
Message-ID: <d77d0a3e-6466-88fa-f169-98293babdf22@virtuozzo.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
 <20191108123455.39445-2-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0134.eurprd05.prod.outlook.com
 (2603:10a6:7:28::21) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108170552201
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa4ddb78-2b8a-4601-f4bd-08d76454c4e2
x-ms-traffictypediagnostic: AM0PR08MB3761:
x-microsoft-antispam-prvs: <AM0PR08MB3761F291D0ACC7AD69AA40FDC17B0@AM0PR08MB3761.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(39840400004)(366004)(346002)(199004)(189003)(4326008)(2616005)(446003)(99286004)(26005)(8936002)(256004)(186003)(36756003)(86362001)(8676002)(25786009)(14444005)(31686004)(31696002)(6116002)(81166006)(81156014)(71200400001)(66066001)(71190400001)(3846002)(476003)(386003)(52116002)(14454004)(64756008)(102836004)(66446008)(66556008)(66476007)(478600001)(2501003)(486006)(316002)(110136005)(76176011)(6486002)(7736002)(11346002)(66946007)(5660300002)(6512007)(6506007)(6246003)(54906003)(229853002)(305945005)(6436002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3761;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWGYjG3I05kTxRwv9h4HXGDo9I8fxqDLjQsfKMOCmKlXUQ2Bs3V5Eg0abPbhHo5S42IgBIKKkQ7eDYnu0n/kHhJpWjbZR26gzVsOjmPz2t2UzNNRj44IFxNjQtkpypDHfp5NLCzhnZWl66Fjjlw5UsqqOHVvPTZ5Mf6sa6GCFEkgqmKgpspKjzJE2/bKPHnn35R91Ngmhr9hxB435e3ZNaxHPNGJCPV/H8XIZEbt8WnBSMrg2rwoMp+LlIX6AqIHTIabQUfqX10eoFjCtk0cqqG4Luvuh2mAROP1rRbPm+pSJqFs8EVnLmTfRC+J11+/C1fsmcYW9qreOg2oR6GZVYdmOZ9JD36qM1/sPYHxkwnh9zeDmQwoDFYlwfrGaOfA/kKM6NrC/E6z4ZITxdNFJ/dF4zTr+NiXgXMw7asyRrHm1j9nFJhxt4LjlOp7GxMU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <667ED9260BB42F499A31D72A2A4386AC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4ddb78-2b8a-4601-f4bd-08d76454c4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 14:05:54.1461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CK4i/xWxrGnzQWu4rF8V5m/py/YfyXp55dxtUbtomKV3XjsEIn+6VKHjGBlrt5Q/g/qrSrJcyg8IO3vlG4o2oigFs9h9EM4fFGnMth7DS7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3761
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.131
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTEuMjAxOSAxNTozNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBXZSBuZWVkIHNvbWUgd2F5IHRv
IGNvcnJlbGF0ZSBRQVBJIEJsb2NrUGVybWlzc2lvbiB2YWx1ZXMgd2l0aA0KPiBCTEtfUEVSTV8q
IGZsYWdzLiAgV2UgY291bGQ6DQo+IA0KPiAoMSkgaGF2ZSB0aGUgc2FtZSBvcmRlciBpbiB0aGUg
UUFQSSBkZWZpbml0aW9uIGFzIHRoZSB0aGUgQkxLX1BFUk1fKg0KPiAgICAgIGZsYWdzIGFyZSBp
biBMU2ItZmlyc3Qgb3JkZXIuICBIb3dldmVyLCB0aGVuIHRoZXJlIGlzIG5vIGd1YXJhbnRlZQ0K
PiAgICAgIHRoYXQgdGhleSBhY3R1YWxseSBtYXRjaCAoZS5nLiB3aGVuIHNvbWVvbmUgbW9kaWZp
ZXMgdGhlIFFBUEkgc2NoZW1hDQo+ICAgICAgd2l0aG91dCB0aGlua2luZyBvZiB0aGUgQkxLX1BF
Uk1fKiBkZWZpbml0aW9ucykuDQo+ICAgICAgV2UgY291bGQgYWRkIHN0YXRpYyBhc3NlcnRpb25z
LCBidXQgdGhlc2Ugd291bGQgYnJlYWsgd2hhdOKAmXMgZ29vZA0KPiAgICAgIGFib3V0IHRoaXMg
c29sdXRpb24sIG5hbWVseSBpdHMgc2ltcGxpY2l0eS4NCj4gDQo+ICgyKSBkZWZpbmUgdGhlIEJM
S19QRVJNXyogZmxhZ3MgYmFzZWQgb24gdGhlIEJsb2NrUGVybWlzc2lvbiB2YWx1ZXMuDQo+ICAg
ICAgQnV0IHRoaXMgd2F5IHdoZW5ldmVyIHNvbWVvbmUgd2VyZSB0byBtb2RpZnkgdGhlIFFBUEkg
b3JkZXINCj4gICAgICAocGVyZmVjdGx5IHNlbnNpYmxlIGluIHRoZW9yeSksIHRoZSBCTEtfUEVS
TV8qIHZhbHVlcyB3b3VsZCBjaGFuZ2UuDQo+ICAgICAgQmVjYXVzZSB0aGVzZSB2YWx1ZXMgYXJl
IHVzZWQgZm9yIGZpbGUgbG9ja2luZywgdGhpcyBtaWdodCBicmVhaw0KPiAgICAgIGZpbGUgbG9j
a2luZyBiZXR3ZWVuIGRpZmZlcmVudCBxZW11IHZlcnNpb25zLg0KPiANCj4gVGhlcmVmb3JlLCBn
byB0aGUgc2xpZ2h0bHkgbW9yZSBjdW1iZXJzb21lIHdheTogQWRkIGEgZnVuY3Rpb24gdG8NCj4g
dHJhbnNsYXRlIGZyb20gdGhlIFFBUEkgY29uc3RhbnRzIHRvIHRoZSBCTEtfUEVSTV8qIGZsYWdz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBibG9jay5jICAgICAgICAgICAgICAgfCAxOCArKysr
KysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggfCAgMSArDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2su
YyBiL2Jsb2NrLmMNCj4gaW5kZXggNGNmZmMyYmMzNS4uMDY2NDMzZjNlMiAxMDA2NDQNCj4gLS0t
IGEvYmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC0yMjI3LDYgKzIyMjcsMjQgQEAgdm9p
ZCBiZHJ2X2Zvcm1hdF9kZWZhdWx0X3Blcm1zKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCZHJ2Q2hp
bGQgKmMsDQo+ICAgICAgICpuc2hhcmVkID0gc2hhcmVkOw0KPiAgIH0NCj4gICANCj4gK3VpbnQ2
NF90IGJkcnZfcWFwaV9wZXJtX3RvX2Jsa19wZXJtKEJsb2NrUGVybWlzc2lvbiBxYXBpX3Blcm0p
DQo+ICt7DQo+ICsgICAgc3RhdGljIGNvbnN0IHVpbnQ2NF90IHBlcm1pc3Npb25zW10gPSB7DQo+
ICsgICAgICAgIFtCTE9DS19QRVJNSVNTSU9OX0NPTlNJU1RFTlRfUkVBRF0gID0gQkxLX1BFUk1f
Q09OU0lTVEVOVF9SRUFELA0KPiArICAgICAgICBbQkxPQ0tfUEVSTUlTU0lPTl9XUklURV0gICAg
ICAgICAgICA9IEJMS19QRVJNX1dSSVRFLA0KPiArICAgICAgICBbQkxPQ0tfUEVSTUlTU0lPTl9X
UklURV9VTkNIQU5HRURdICA9IEJMS19QRVJNX1dSSVRFX1VOQ0hBTkdFRCwNCj4gKyAgICAgICAg
W0JMT0NLX1BFUk1JU1NJT05fUkVTSVpFXSAgICAgICAgICAgPSBCTEtfUEVSTV9SRVNJWkUsDQo+
ICsgICAgICAgIFtCTE9DS19QRVJNSVNTSU9OX0dSQVBIX01PRF0gICAgICAgID0gQkxLX1BFUk1f
R1JBUEhfTU9ELA0KPiArICAgIH07DQo+ICsNCj4gKyAgICBRRU1VX0JVSUxEX0JVR19PTihBUlJB
WV9TSVpFKHBlcm1pc3Npb25zKSAhPSBCTE9DS19QRVJNSVNTSU9OX19NQVgpOw0KPiArICAgIFFF
TVVfQlVJTERfQlVHX09OKDFVTCA8PCBBUlJBWV9TSVpFKHBlcm1pc3Npb25zKSAhPSBCTEtfUEVS
TV9BTEwgKyAxKTsNCg0Kc2FmZSBlbm91Z2gpDQoNCj4gKw0KPiArICAgIGFzc2VydChxYXBpX3Bl
cm0gPCBCTE9DS19QRVJNSVNTSU9OX19NQVgpOw0KPiArDQo+ICsgICAgcmV0dXJuIHBlcm1pc3Np
b25zW3FhcGlfcGVybV07DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBiZHJ2X3JlcGxhY2Vf
Y2hpbGRfbm9wZXJtKEJkcnZDaGlsZCAqY2hpbGQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpuZXdfYnMpDQo+ICAgew0KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9ibG9jay5oIGIvaW5jbHVkZS9ibG9jay9ibG9jay5oDQo+
IGluZGV4IDFkZjk4NDhlNzQuLmU5ZGNmZWY3ZmEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvYmxv
Y2svYmxvY2suaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4gQEAgLTI4MCw2ICsy
ODAsNyBAQCBlbnVtIHsNCj4gICB9Ow0KPiAgIA0KPiAgIGNoYXIgKmJkcnZfcGVybV9uYW1lcyh1
aW50NjRfdCBwZXJtKTsNCj4gK3VpbnQ2NF90IGJkcnZfcWFwaV9wZXJtX3RvX2Jsa19wZXJtKEJs
b2NrUGVybWlzc2lvbiBxYXBpX3Blcm0pOw0KPiAgIA0KPiAgIC8qIGRpc2sgSS9PIHRocm90dGxp
bmcgKi8NCj4gICB2b2lkIGJkcnZfaW5pdCh2b2lkKTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

