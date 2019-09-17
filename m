Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790AFC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7A720678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l9jwmULo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7A720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAEQt-0001n8-Cu
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 10:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAEQ2-0001KM-Ke
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAEQ0-0005ZT-Mt
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:25:25 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com
 ([40.107.3.105]:36930 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAEQ0-0005YL-4h; Tue, 17 Sep 2019 10:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIZgxwPvjgRUE7QIFYrwKh6aOcksZxeilPla6NXadUmiaUMVjAT1EIy9DFd1tId8cZ0ebwcffQceBQ0MJqjNjC8hV17s1RhaQpn5djsdA5H+okr+mUXtL1ri+r4W69S3Oab4Ojm4SfcKVeNKJ4NISH6QUmd06O1cZ9ChW1rg3MhXByRbP5672cfHvt/l3lNKhL5dVAopOI53j/xG8/BCdACWCBjluME+OBdxlsxJzpaKL5UM3vgn/4f/um91RlaggIJh1J1MAKasGBFkorq64RcAvRzMe6b2qBzB/R+FpE4R7QSEBN4Ia15i5B9u9XPkDfEMTgybWy0t4pn2pdP+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qkfPcxRZyvljToBodfyQQTBg//roqCUUbqpPopVpy4=;
 b=B7ReR98M8RAKHLW9Dvob5Z+3wg6lDLTgxc4JqSOb/ZE5F4bau7Rnuof9pq7vjLrOVZlAL57vvBCnV6z0o7R2+VRhAccaMV0NDenTE1JzriOU+tOwzhsCNbiOYMx0stB4IalNpNLx9HvrGxzD9Q2IvNB/tpcZ94+sbZhT9+Ajw8vq7zeWud3ZGT9XlrRaGuJjGZnKH8Z+1V0KoVC+qqvBuCcso+GUAyq2Bj+HMi3TMmmihAGqbRGFCuZhj/NcjP1svC+Ru6z8GlwMO4APNI2LY2HwpvVph/gMuT+SdQK2bcmq/oA+glwMKRVQbmWtOUw1GXjykXKlTcckL4HWwvYQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qkfPcxRZyvljToBodfyQQTBg//roqCUUbqpPopVpy4=;
 b=l9jwmULo2mI9/uA7wKCf4bEjsivIj2RpMr7tDhTzwjOrsSPmH0wG90r/ve8gO7uzoDOXwt9Rdc+c8MPHG1BoMFfVE/Mfy77kkipbIGMV6PTdpnxkklH/ZQZfE9tRLRQHWFanIJ4gyitF/Dzll0ew3k/LPjc1Sn/e5+FBEENXETQ=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2249.eurprd08.prod.outlook.com (10.172.126.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 17 Sep 2019 14:25:18 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 14:25:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 5/7] iotests: Test driver whitelisting in 093
Thread-Index: AQHVbTkpPYQu7ydmKEWdRwl8TyK6I6cv7QAA
Date: Tue, 17 Sep 2019 14:25:18 +0000
Message-ID: <fb3673f7-8694-2be1-f843-8786167049c4@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-6-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-6-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:7:67::23) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b3e8bf2-1498-4152-12d4-08d73b7add4d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2249; 
x-ms-traffictypediagnostic: HE1PR0802MB2249:
x-microsoft-antispam-prvs: <HE1PR0802MB22492DB230A18982DB6493E4F48F0@HE1PR0802MB2249.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39850400004)(199004)(189003)(25786009)(54906003)(31686004)(316002)(3846002)(6116002)(2906002)(256004)(71200400001)(71190400001)(110136005)(66066001)(36756003)(66476007)(64756008)(66556008)(66446008)(229853002)(2501003)(66946007)(6246003)(5660300002)(76176011)(52116002)(26005)(7736002)(6506007)(53546011)(305945005)(386003)(4326008)(478600001)(186003)(8936002)(99286004)(102836004)(446003)(11346002)(476003)(2616005)(14454004)(486006)(86362001)(6512007)(44832011)(31696002)(6436002)(6486002)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2249;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bcVmOm3Qz2TjDSWU/+akzv6i7u3yf3Ze0pKtYjJWEKT7AAZJD4Inh4eY/WCfMxCOBhbLkY6i3+3WfUfaiZ/yKyUcnQhR1ka6hfd51uu+QrNkkN1NJIW/uOxs7Ys0/2RjCc6+Zg26bTP7fKNm3OdI3IJROBXNXj5q+wQjdzECZ7m0aCgeh9X1dxTyR3qIoBGS2JJYZFNf+u5EBAi7g25jCUaCRjtIZZ9VNPn6Ih7LRNfuyOgRCEGSKYSib9MW4ckyEBtP7Pbi8RnC3o50fDYO/7EVlrkW3+WVXHPUZ+o1xfw7FVPu2wsZAkySOkUCIGHIx0lcMpypTY/nECcrNCwr6uu7ZtL1VfDTRRPch50jQH+RR+esapwptqjGMEQa12zcMIw5m/1zJjAu3bdI5Prjsv+4Id7z56Dw95dJ+JvBYKY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <32254C41906B464B8C2A8538D53887EE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3e8bf2-1498-4152-12d4-08d73b7add4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 14:25:18.2548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwdLLZdEIp//vJ2e9yr63nEwTMe8Y2c6Dadq8YU0Qnpntp+FP5r1lvZ9TmKURIZOuPEDjHK05u1O9wTi/kweX71D0FSXQ1VwJRdljwX9L0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2249
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.105
Subject: Re: [Qemu-devel] [PATCH v4 5/7] iotests: Test driver whitelisting
 in 093
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

DQoNCk9uIDE3LzA5LzIwMTkgMTI6MjAsIE1heCBSZWl0eiB3cm90ZToNCj4gbnVsbC1haW8gbWF5
IG5vdCBiZSB3aGl0ZWxpc3RlZC4gIFNraXAgYWxsIHRlc3QgY2FzZXMgdGhhdCByZXF1aXJlIGl0
Lg0KPiANCj4gKEFuZCBza2lwIHRoZSB3aG9sZSB0ZXN0IGlmIG51bGwtY28gaXMgbm90IHdoaXRl
bGlzdGVkLikNClRoaXMgc29sdXRpb24gaGFzIGJlZW4gcGVyc2lzdGluZyBzaW5jZSB2MS4gTmV2
ZXJ0aGVsZXNzLCBJIGFtIHN0aWxsIG5vdCANCmNsZWFyIHdoeSBub3QgdG8gcnVuIHRoZSB0ZXN0
IGlmIHRoZSBudWxsLWFpbyBpcyB0aGUgb25seSB3aGl0ZWxpc3RlZCANCmRyaXZlcj8gV2lsbCB0
aGUgbnVsbC1haW8gYmUgc3VwcG9ydGVkIGluIGZ1dHVyZT8NCg0KQW5kcmV5DQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMDkzIHwgMTIgKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0
cy9xZW11LWlvdGVzdHMvMDkzIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA5Mw0KPiBpbmRleCA1MGMx
ZTdmMmVjLi5mMDNmYTI0YTA3IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDkz
DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wOTMNCj4gQEAgLTI0LDcgKzI0LDcgQEAgaW1w
b3J0IGlvdGVzdHMNCj4gICBuc2VjX3Blcl9zZWMgPSAxMDAwMDAwMDAwDQo+ICAgDQo+ICAgY2xh
c3MgVGhyb3R0bGVUZXN0Q2FzZShpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gLSAgICB0ZXN0X2lt
ZyA9ICJudWxsLWFpbzovLyINCj4gKyAgICB0ZXN0X2RyaXZlciA9ICJudWxsLWFpbyINCj4gICAg
ICAgbWF4X2RyaXZlcyA9IDMNCj4gICANCj4gICAgICAgZGVmIGJsb2Nrc3RhdHMoc2VsZiwgZGV2
aWNlKToNCj4gQEAgLTM1LDEwICszNSwxNCBAQCBjbGFzcyBUaHJvdHRsZVRlc3RDYXNlKGlvdGVz
dHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgICAgICAgICByZXR1cm4gc3RhdFsncmRfYnl0
ZXMnXSwgc3RhdFsncmRfb3BlcmF0aW9ucyddLCBzdGF0Wyd3cl9ieXRlcyddLCBzdGF0Wyd3cl9v
cGVyYXRpb25zJ10NCj4gICAgICAgICAgIHJhaXNlIEV4Y2VwdGlvbigiRGV2aWNlIG5vdCBmb3Vu
ZCBmb3IgYmxvY2tzdGF0czogJXMiICUgZGV2aWNlKQ0KPiAgIA0KPiArICAgIGRlZiByZXF1aXJl
ZF9kcml2ZXJzKHNlbGYpOg0KPiArICAgICAgICByZXR1cm4gW3NlbGYudGVzdF9kcml2ZXJdDQo+
ICsNCj4gKyAgICBAaW90ZXN0cy5za2lwX2lmX3Vuc3VwcG9ydGVkKHJlcXVpcmVkX2RyaXZlcnMp
DQo+ICAgICAgIGRlZiBzZXRVcChzZWxmKToNCj4gICAgICAgICAgIHNlbGYudm0gPSBpb3Rlc3Rz
LlZNKCkNCj4gICAgICAgICAgIGZvciBpIGluIHJhbmdlKDAsIHNlbGYubWF4X2RyaXZlcyk6DQo+
IC0gICAgICAgICAgICBzZWxmLnZtLmFkZF9kcml2ZShzZWxmLnRlc3RfaW1nLCAiZmlsZS5yZWFk
LXplcm9lcz1vbiIpDQo+ICsgICAgICAgICAgICBzZWxmLnZtLmFkZF9kcml2ZShzZWxmLnRlc3Rf
ZHJpdmVyICsgIjovLyIsICJmaWxlLnJlYWQtemVyb2VzPW9uIikNCj4gICAgICAgICAgIHNlbGYu
dm0ubGF1bmNoKCkNCj4gICANCj4gICAgICAgZGVmIHRlYXJEb3duKHNlbGYpOg0KPiBAQCAtMjY0
LDcgKzI2OCw3IEBAIGNsYXNzIFRocm90dGxlVGVzdENhc2UoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6
DQo+ICAgICAgICAgICBzZWxmLmFzc2VydEVxdWFsKHNlbGYuYmxvY2tzdGF0cygnZHJpdmUxJylb
MF0sIDQwOTYpDQo+ICAgDQo+ICAgY2xhc3MgVGhyb3R0bGVUZXN0Q29yb3V0aW5lKFRocm90dGxl
VGVzdENhc2UpOg0KPiAtICAgIHRlc3RfaW1nID0gIm51bGwtY286Ly8iDQo+ICsgICAgdGVzdF9k
cml2ZXIgPSAibnVsbC1jbyINCj4gICANCj4gICBjbGFzcyBUaHJvdHRsZVRlc3RHcm91cE5hbWVz
KGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICBtYXhfZHJpdmVzID0gMw0KPiBAQCAtNDI1
LDQgKzQyOSw2IEBAIGNsYXNzIFRocm90dGxlVGVzdFJlbW92YWJsZU1lZGlhKGlvdGVzdHMuUU1Q
VGVzdENhc2UpOg0KPiAgIA0KPiAgIA0KPiAgIGlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+
ICsgICAgaWYgJ251bGwtY28nIG5vdCBpbiBpb3Rlc3RzLnN1cHBvcnRlZF9mb3JtYXRzKCk6DQo+
ICsgICAgICAgIGlvdGVzdHMubm90cnVuKCdudWxsLWNvIGRyaXZlciBzdXBwb3J0IG1pc3Npbmcn
KQ0KPiAgICAgICBpb3Rlc3RzLm1haW4oc3VwcG9ydGVkX2ZtdHM9WyJyYXciXSkNCj4gDQoNClJl
dmlld2VkLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpv
LmNvbT4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

