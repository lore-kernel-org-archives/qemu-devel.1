Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D9C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227192184B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YLevs+Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227192184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oUH-0008O3-1f
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i5oT7-0007aI-PJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i5oT6-0002zh-BF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:54:21 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com
 ([40.107.4.113]:38030 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i5oT5-0002zD-LA; Thu, 05 Sep 2019 05:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTuxCWAz9UYwuG89twSpZDm9Ul4XM9b6V34oor1QH2mQ6bdtcOCdM9X8R81IN5uUXkg47Exz2iy79Yiy6Mn73L0WlaQoLDC/WgMl5s2sDYJsu7m0XKQ1WqqsGFq+Ky6W+sqDTLoVUYXKXcu87LBSo9Twvs+oXnRyONXuMK+5MTjaNZptRNKDgY4RRkRBx3CQrpqarx68KsfcI9sDbcY1RP1mYkCQ9hj+DECdKQr2Ohwk65AaeUXPWSwf01QLw+BSxBmC8wPQXyXRZ/WgooabZnSNFGRL/GT0l4S2i7ZEBxYZrGmUcDhew3/DV+UFSzhHab3utRyd99/LhuGEmlhVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIJR+pVNLu51Uuf+IcmoMKmJMTQlU2C/V2w9gtBYZ3I=;
 b=hAZwij8Mtjj/fcBp4tZh+sek9JARN7RNzWNO2lhlaOoFSdje2/1I+teVWugozTvVW59n6zv/xUo0ZChRws2TFilPB4tCICxtxTVW9P5aKHDcoyK04/9eF2znSHF/X1RQPUui3vetD4v1En9OrvqtTCbsIH9rSQJ+XAoZx4RhN+WEn5KaQw9DqgR9n3Tm7glxCWMFWAjto2BcZoxNx3RoL10oO+tRQkZysiHDHu0Aeer5LW/P5fQ1CmrUkJxVLYcvHdGE1X3pUejXcm3WczveFOarkZcdwImsIdCqYRi2QDjolE4XbVLHxgy1vszrRc/s76YGhIwUSc8PTlSFIr1eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIJR+pVNLu51Uuf+IcmoMKmJMTQlU2C/V2w9gtBYZ3I=;
 b=YLevs+ZyX6Ku48L3jpfGCXzFD+l2/3+R87VnPQyjOPXQhBa1f/ccWdIqa8Re6lW5eaOt5SG+RUuAXTd6W3vSAkXpOnPvAQeaLcw7nZFEVOMwaSY839Im+30pH9jMY/wca338nkaR8F8H6Zx0r2us8MEKPkvM2XVxcalVA4tGPyU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 5 Sep 2019 09:54:17 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 09:54:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening logic
Thread-Index: AQHVTSopPwiUxx2MOkaQtW14Kblt36cdBWyA
Date: Thu, 5 Sep 2019 09:54:17 +0000
Message-ID: <8cdac817-c444-7851-1ffb-47ebcf59e18a@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0013.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190905125415071
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26038a4a-e0cc-4581-78b9-08d731e70421
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3977; 
x-ms-traffictypediagnostic: DB8PR08MB3977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3977D47FC91B50782066EE4AC1BB0@DB8PR08MB3977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(39850400004)(346002)(366004)(189003)(54534003)(199004)(53754006)(6916009)(64756008)(66556008)(66476007)(31686004)(66446008)(66946007)(36756003)(2906002)(7736002)(305945005)(8936002)(6116002)(5660300002)(3846002)(446003)(6512007)(52116002)(14444005)(2616005)(6486002)(486006)(11346002)(476003)(256004)(31696002)(14454004)(81166006)(107886003)(66066001)(86362001)(6246003)(2501003)(386003)(6506007)(478600001)(25786009)(81156014)(186003)(4326008)(5640700003)(54906003)(229853002)(76176011)(71200400001)(71190400001)(102836004)(26005)(6436002)(2351001)(316002)(53936002)(99286004)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3977;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ATw5yBwXYUu147nS7KzRNSBfrGgVXmKzZqra164ZwCp+1+ueb3YPxkTNbCLbiBchaLWlJnNTubrxXeXHVvhXddIYdjLKvZ3fupD08qeghk7ZO2uOzelPsMirwLt7FN9N1o7hSzcfXA4NshFDD27LW+5Q7EjVwxUYq4pxnk3UIJ1W1ETnKj3lR1zbQal7mtV43ZCupE6n7Kx2G9Z0xKvCSaDCCL+carKJW29MPZrGNLvZhx7pv5mi2rHMORjj2sUPbBjGukMWi9gxmcz0n2PEWyhK5zE26+xjG2SLPjJm4dZGEmrr6U6UgoS2YZowYV2Ldoylew7EwJgDRwCVqNiI1vzBI9If0SP11UV7wX7x9Dxyp05ckAgCkGRrzgb7DOvsMh94aOGgyUp1G8PtQWmN5rtacPlLk4/aHkRS6QsrT8w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E5DC139E58AC4BABC32EDCAF9AE056@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26038a4a-e0cc-4581-78b9-08d731e70421
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 09:54:17.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKYzX82+7J6Kn98wsVdxoIGMunViS3Zzst8+R7JTalbJFQKTGNopdiE7a9Y8WeZuh215DXDvuJyPA3pZRAxgydPRyDKAS4LqFzP+3dmMERc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.113
Subject: Re: [Qemu-devel] [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening
 logic
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQowNy4wOC4yMDE5IDE3OjEyLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBCaXRtYXBzIHJlb3BlbmluZyBpcyBidWdneSwgcmVvcGVu
aW5nLXJ3IGp1c3Qgbm90IHdvcmtpbmcgYXQgYWxsIGFuZA0KPiByZW9wZW5pbmctcm8gbWF5IGxl
YWQgdG8gcHJvZHVjaW5nIGJyb2tlbiBpbmNyZW1lbnRhbA0KPiBiYWNrdXAgaWYgd2UgZG8gdGVt
cG9yYXJ5IHNuYXBzaG90IGluIGEgbWVhbnRpbWUuDQo+IA0KPiB2NDogRHJvcCBjb21wbGljYXRl
ZCBzb2x1dGlvbiBhcm91bmQgcmVvcGVuaW5nIGxvZ2ljIFtLZXZpbl0sIGZpeA0KPiAgICAgIHRo
ZSBleGlzdGluZyBidWcgaW4gYSBzaW1wbGVzdCB3YXkNCj4gDQo+IFN0cnVjdHVyZToNCj4gDQo+
IDAyOiBmaXggcmVvcGVuIHRvIFJXDQo+IDAzOiB0ZXN0IHJlb3BlbiB0byBSVw0KPiANCj4gMDc6
IGZpeCByZW9wZW4gdG8gUk8NCj4gMDg6IHRlc3QgcmVvcGVuIHRvIFJPDQo+IA0KPiBPdGhlcnMg
YXJlIGxlc3Mgc2lnbmlmaWNhbnQgaW1wcm92ZW1lbnRzIGFuZCByZWZhY3RvcmluZw0KPiANCj4g
Q2hhbmdlbG9nOg0KPiANCj4gMDEtMDM6IG5ldyBwYXRjaGVzLCB0byBmaXggcmVvcGVuaW5nIGJp
dG1hcHMgdG8gUlcgYW5kIHBlcnNvbmFsIHRlc3QgZm9yDQo+ICAgICAgICAgdGhpcyBidWcNCj4g
MDg6IG1lcmdlZCB0ZXN0IGZyb20gdjMsIGl0IGNvdmVycyBib3RoIGJ1Z3MgKHJlb3BlbiB0byBS
VyBhbmQgcmVvcGVuIHRvIFJPKQ0KPiAxMDogaW5zdGVhZCBvZiBtb3ZpbmcgYml0bWFwLXJlb3Bl
bmluZyB0byBwcmVwYXJlKGFzIGluIDA5IGluIHYzKSB3ZSBub3cga2VlcCBpdA0KPiAgICAgIGlu
IGNvbW1pdCwgYnV0IGluIHJpZ2h0IHBsYWNlDQo+IG90aGVyczogdW5jaGFuZ2VkDQo+IA0KPiB2
MzoNCj4gMDI6IEpvaG4ncyBldmVudHNfd2FpdCBhbHJlYWR5IG1lcmdlZCBpbiwgc28gbXkgMDIg
ZnJvbSB2MiBpcyBub3QgbmVlZGVkLg0KPiAgICAgIEluc3RlYWQsIGFkZCB0d28gc2ltcGxlIGxv
Z2dpbmcgd3JhcHBlcnMgaGVyZQ0KPiAwMzogcmViYXNlIG9uIDAyIC0gdXNlIG5ldyB3cmFwcGVy
cywgbW92ZSB0byAyNjANCj4gMDU6IGFkZCBKb2huJ3Mgci1iDQo+IDA2OiBpbXByb3ZlIGZ1bmN0
aW9uIGRvY3MgW0pvaG5dLCBhZGQgSm9obidzIHItYg0KPiANCj4gdjI6DQo+IDAxOiBuZXcNCj4g
MDItMDM6IHRlc3Q6IHNwbGF0IGludG8gdHdvIHBhdGNoZXMsIHNvbWUgd29yZGluZw0KPiAgICAg
ICAgIGltcHJvdmVtZW50cyBhbmQgZXZlbnRfd2FpdCBpbXByb3ZlZA0KPiAwNDogYWRkIEpvaG4n
cyByLWINCj4gMDU6IG5ldw0KPiAwNi0wOTogZml4ZXM6IGNoYW5nZWQsIHNwbGF0LCB1c2UgcGF0
Y2ggMDENCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDEwKToNCj4gICAgYmxv
Y2s6IHN3aXRjaCByZW9wZW4gcXVldWUgZnJvbSBRU0lNUExFUSB0byBRVEFJTFENCj4gICAgYmxv
Y2s6IHJldmVyc2Ugb3JkZXIgZm9yIHJlb3BlbiBjb21taXRzDQo+ICAgIGlvdGVzdHM6IGFkZCB0
ZXN0LWNhc2UgdG8gMTY1IHRvIHRlc3QgcmVvcGVuaW5nIHFjb3cyIGJpdG1hcHMgdG8gUlcNCj4g
ICAgaW90ZXN0cy5weTogYWRkIGV2ZW50X3dhaXRfbG9nIGFuZCBldmVudHNfd2FpdF9sb2cgaGVs
cGVycw0KPiAgICBibG9jay9xY293Mi1iaXRtYXA6IGdldCByaWQgb2YgYmRydl9oYXNfY2hhbmdl
ZF9wZXJzaXN0ZW50X2JpdG1hcHMNCj4gICAgYmxvY2svcWNvdzItYml0bWFwOiBkcm9wIHFjb3cy
X3Jlb3Blbl9iaXRtYXBzX3J3X2hpbnQoKQ0KPiAgICBibG9jay9xY293Mi1iaXRtYXA6IGRvIG5v
dCByZW1vdmUgYml0bWFwcyBvbiByZW9wZW4tcm8NCj4gICAgaW90ZXN0czogYWRkIHRlc3QgMjYw
IHRvIGNoZWNrIGJpdG1hcCBsaWZlIGFmdGVyIHNuYXBzaG90ICsgY29tbWl0DQo+ICAgIGJsb2Nr
L3Fjb3cyLWJpdG1hcDogZml4IGFuZCBpbXByb3ZlIHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3J3DQo+
ICAgIHFjb3cyLWJpdG1hcDogbW92ZSBiaXRtYXAgcmVvcGVuLXJ3IGNvZGUgdG8gcWNvdzJfcmVv
cGVuX2NvbW1pdA0KPiANCj4gICBibG9jay9xY293Mi5oICAgICAgICAgICAgICAgICB8ICAgNSAr
LQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2suaCAgICAgICAgIHwgICAyICstDQo+ICAgaW5jbHVk
ZS9ibG9jay9ibG9ja19pbnQuaCAgICAgfCAgIDYgLS0NCj4gICBpbmNsdWRlL2Jsb2NrL2RpcnR5
LWJpdG1hcC5oICB8ICAgMSAtDQo+ICAgYmxvY2suYyAgICAgICAgICAgICAgICAgICAgICAgfCAg
NTEgKysrKystLS0tLS0tDQo+ICAgYmxvY2svZGlydHktYml0bWFwLmMgICAgICAgICAgfCAgMTIg
LS0tDQo+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgICAgICAgICAgfCAxNDMgKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAg
IHwgIDE3ICsrKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1ICAgICAgICB8ICA0NiArKysr
KysrKysrLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8xNjUub3V0ICAgIHwgICA0ICstDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI2MCAgICAgICAgfCAgODcgKysrKysrKysrKysrKysrKysrKysr
DQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2MC5vdXQgICAgfCAgNTIgKysrKysrKysrKysrKw0K
PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgICAxICsNCj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAxMCArKysNCj4gICAxNCBmaWxlcyBjaGFuZ2VkLCAzMTgg
aW5zZXJ0aW9ucygrKSwgMTE5IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy9xZW11LWlvdGVzdHMvMjYwDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUt
aW90ZXN0cy8yNjAub3V0DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

