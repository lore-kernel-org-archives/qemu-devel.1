Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D731D2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GTDiTzcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D731D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAD8h-0005lY-Jj
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAD6d-0004t4-8S
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAD6U-00007W-2Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:01:15 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:15791 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAD6H-0008QB-25; Tue, 17 Sep 2019 09:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHq+WNLhz6GEOHD1fAHE28clkIq7cXv87igetCMIBY3J5UpHekufvwu3jsqrC8F0G3/InTGOjLwUG4sHrSSY2OaYW7b0Yux7AUZ4D33z5e/2+wGC3nvZf85w8FGsPGTBs7x3YKcU4vejQz8FgyYn9VuvxfttM8nF2YoE++CDCcBH9bQIx1dsoMeqbWi+e5FPqSmgc7oT5s1H7OtpxeAMSBWJwt/Gz6NskGg5Tzo7XlRYdWB8iM54J8wcaDRH3jp2Lz/W63scwVp5YT7D3igV/01ow8MLTyFnk1R5P8U2bc01NKx83tGuoBIm0NQJThbD1cXyAxj2EL0NPEE2/nIVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvVkcRgft27pMQ3XHv30IWZy96mjqmGtt+krQLTsZ14=;
 b=PnMjq+aZSIVRibT3mhZYg9MTw19oIsiusN56fQ7o+guWk06xu5yqVbwkUMMFIfPczofnfJEr3Q01NTF+2Irib8fpMHemSkKuZuq8f67z1oAFUCr5op5eWarfR8DVzAQLcZnpZcrZiw2EZZr2fg9BKiFSJ//tDTgpWhUxPCKmmMn6fvN1RHozLSMuAJtlb162vqapKT9ymMCTwKpR88/7xEaEF+tb4bm6Z3RU3APSJnahcj/OVEY8LBuldguLaTnkyPwDSh7gYZvKZw4b/6lEPqR4KDr/Uv+XjMGG1wIGgd9M31Ms3flXaaEyCfkt2psABTi4QZAmzoEDIk9xY18Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvVkcRgft27pMQ3XHv30IWZy96mjqmGtt+krQLTsZ14=;
 b=GTDiTzcs3Ujl2TWzgTYKI/fdETuMjsB/dJabFpsxF1thpRRXEhAhBqeXUHi+gyxMTCUnn4GWTGLOJisSWeERQnB+9YENw4T6bus+Cpm1hHbHxnXaIyhHvWPol9o4DPeuhhDAoYBfIJv8cGP50W7SHIw1BhDQ4BthbeKBiKZ1rWg=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2586.eurprd08.prod.outlook.com (10.175.34.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Tue, 17 Sep 2019 13:00:44 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 13:00:44 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 3/7] iotests: Use case_skip() in skip_if_unsupported()
Thread-Index: AQHVbTkk51ztto6JhECZ0KYmFdPUcKcv1VeA
Date: Tue, 17 Sep 2019 13:00:43 +0000
Message-ID: <63beb503-20e2-9326-6184-fbea96ebe0ca@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-4-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-4-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0229.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::29) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5904df6d-0bdc-4e17-1b7b-08d73b6f0cb6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2586; 
x-ms-traffictypediagnostic: HE1PR0802MB2586:
x-microsoft-antispam-prvs: <HE1PR0802MB2586A1FB0D79BABCF84B767CF48F0@HE1PR0802MB2586.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39850400004)(376002)(199004)(189003)(66476007)(71200400001)(6512007)(66066001)(6436002)(229853002)(5660300002)(31696002)(44832011)(6486002)(446003)(476003)(11346002)(31686004)(86362001)(486006)(25786009)(478600001)(110136005)(54906003)(36756003)(4326008)(186003)(14454004)(316002)(2906002)(6116002)(3846002)(66556008)(102836004)(81156014)(64756008)(8676002)(256004)(7736002)(2616005)(26005)(6246003)(305945005)(66946007)(386003)(76176011)(53546011)(52116002)(66446008)(2501003)(6506007)(71190400001)(8936002)(99286004)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2586;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S0vkOGh3fUgoOipaDrqs5Xwqb+UavUhiT49SKAd9+YOGlvbwXTZg+JdyPQ0jJ+E3NC+kdXNDzCjgaant9FlNj8NZOtyhTItf+86WFOfYHS3tnfLQOGRKzcSFABIVK/6h1+27O/zlTXaCVLpb3xGuq3QbI0a5w89E3PtbklSW9CwebkK1eVgLLv79LqC/84sApTulYWysLtGMHHCRI5J9eRL/cz5wYuOhmGm405nb5UUI1vI6jXBcX5/pbYN0z2VSGBIz9djgjh4W2cV8NQYITn5/CpsFl2vvqUZenZuPKl5ArgAbkkhhS2vTIieVLpo/cMbiYWfa0+XKLJkA/u+CvHo4yhQySp5b8JdOYHwm9vLUhkfyEtzUjcTe53xpRffS0i+p8h+Dn+mQQguh3k6mkKbu9VR2JOFGDch6tdZTVdo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD497894F646A74E96C5D072D43F65EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5904df6d-0bdc-4e17-1b7b-08d73b6f0cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 13:00:44.0222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ku06zvHv046YWyDyYkMZkw08usqo9j78PNfRclP8zL0Htk0pp+coocWN4/gSYsLFiO6rUGaNS/iHbWbDrMvHXtrvHKdQNf2ZzTwBR0d1PMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2586
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.139
Subject: Re: [Qemu-devel] [PATCH v4 3/7] iotests: Use case_skip() in
 skip_if_unsupported()
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

DQoNCk9uIDE3LzA5LzIwMTkgMTI6MjAsIE1heCBSZWl0eiB3cm90ZToNCj4gc2tpcF9pZl91bnN1
cHBvcnRlZCgpIHNob3VsZCB1c2UgdGhlIHN0cm9uZ2VyIHZhcmlhbnQgY2FzZV9za2lwKCksDQo+
IGJlY2F1c2UgdGhpcyBhbGxvd3MgaXQgdG8gYmUgdXNlZCBldmVuIHdpdGggc2V0VXAoKSAoaW4g
YSBtZWFuaW5nZnVsDQo+IHdheSkuDQo+IA0KPiBJbiB0aGUgcHJvY2VzcywgbWFrZSBpdCBleHBs
aWNpdCB3aGF0IHdlIGV4cGVjdCB0aGUgZmlyc3QgYXJndW1lbnQgb2YNCj4gdGhlIGZ1bmNfd3Jh
cHBlciB0byBiZSAobmFtZWx5IHNvbWV0aGluZyBkZXJpdmVkIG9mIFFNUFRlc3RDYXNlKS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgOCArKysrLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgYi90ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weQ0KPiBpbmRleCBlNDZmM2I2YWVkLi40MjdjMzQ2OTdhIDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvaW90ZXN0cy5weQ0KPiBAQCAtODkzLDE0ICs4OTMsMTQgQEAgZGVmIHNraXBfaWZfdW5zdXBw
b3J0ZWQocmVxdWlyZWRfZm9ybWF0cz1bXSwgcmVhZF9vbmx5PUZhbHNlKToNCj4gICAgICAgJycn
U2tpcCBUZXN0IERlY29yYXRvcg0KPiAgICAgICAgICBSdW5zIHRoZSB0ZXN0IGlmIGFsbCB0aGUg
cmVxdWlyZWQgZm9ybWF0cyBhcmUgd2hpdGVsaXN0ZWQnJycNCj4gICAgICAgZGVmIHNraXBfdGVz
dF9kZWNvcmF0b3IoZnVuYyk6DQo+IC0gICAgICAgIGRlZiBmdW5jX3dyYXBwZXIoKmFyZ3MsICoq
a3dhcmdzKToNCj4gKyAgICAgICAgZGVmIGZ1bmNfd3JhcHBlcih0ZXN0X2Nhc2U6IFFNUFRlc3RD
YXNlLCAqYXJncywgKiprd2FyZ3MpOg0KPiAgICAgICAgICAgICAgIHVzZl9saXN0ID0gbGlzdChz
ZXQocmVxdWlyZWRfZm9ybWF0cykgLQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
ZXQoc3VwcG9ydGVkX2Zvcm1hdHMocmVhZF9vbmx5KSkpDQo+ICAgICAgICAgICAgICAgaWYgdXNm
X2xpc3Q6DQo+IC0gICAgICAgICAgICAgICAgY2FzZV9ub3RydW4oJ3t9OiBmb3JtYXRzIHt9IGFy
ZSBub3Qgd2hpdGVsaXN0ZWQnLmZvcm1hdCgNCj4gLSAgICAgICAgICAgICAgICAgICAgYXJnc1sw
XSwgdXNmX2xpc3QpKQ0KPiArICAgICAgICAgICAgICAgIHRlc3RfY2FzZS5jYXNlX3NraXAoJ3t9
OiBmb3JtYXRzIHt9IGFyZSBub3Qgd2hpdGVsaXN0ZWQnLmZvcm1hdCgNCj4gKyAgICAgICAgICAg
ICAgICAgICAgdGVzdF9jYXNlLCB1c2ZfbGlzdCkpDQo+ICAgICAgICAgICAgICAgZWxzZToNCj4g
LSAgICAgICAgICAgICAgICByZXR1cm4gZnVuYygqYXJncywgKiprd2FyZ3MpDQo+ICsgICAgICAg
ICAgICAgICAgcmV0dXJuIGZ1bmModGVzdF9jYXNlLCAqYXJncywgKiprd2FyZ3MpDQo+ICAgICAg
ICAgICByZXR1cm4gZnVuY193cmFwcGVyDQo+ICAgICAgIHJldHVybiBza2lwX3Rlc3RfZGVjb3Jh
dG9yDQo+ICAgDQo+IA0KDQpSZXZpZXdlZC1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5z
aGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFu
ZHJleSBTaGlua2V2aWNoDQo=

