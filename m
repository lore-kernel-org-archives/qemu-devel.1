Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D6C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F20421926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OgeU+lYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F20421926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHmz-00075T-CL
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49313)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqHmk-0006bq-OP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqHmi-00022x-Ul
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:58:26 -0400
Received: from mail-eopbgr50106.outbound.protection.outlook.com
 ([40.107.5.106]:55172 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqHmi-00021y-6i; Wed, 24 Jul 2019 09:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF/ZFXp8TokvUpWhEzR5TYTRyF0rkrG+DgNIK64pjmxDoUwAJ6vfQiTZf0OW+XoEm2dRoVQe0jWxEPkNEorOEbEcf/huDkpld9W29tmnUG3+sFGHeteUg4o2Byht3H7uTj6KvcS3/nohXzkS+KkJS1jKsgOCHV/Zlbr9MNBfgsMPmFGNBbHRi2iunYUbtprtw31lpTkgM7MxzsRfy8nPn7H6GSec4lfyVc5AnefQrA3hxJIpiykT7xdQweA/P0l5GzLdIXnaLB1RuYP2Rg8gjwM1YIc7FjFMUDifBs0yWVE/oqO3/KmdKGEuNE0az+Nc95yJWU5br20StyTJuAIpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=munZ+uwBGO1zK/Mt0Nw66f3glG3mEbqxWDyqWMWvCTM=;
 b=neHYP3IHhE5TgJnT3bBFNwDOcLT/xDCZ6+xXufczf8+rD0jicACpIMuZIYWwB3Y2fZSCtUcUl3vAv1NXoDg+UKm2grv6d3HtJshmCSi2IB1h8paslsfHHbdVKrvoMHZkYmRbpb5kUnQPoKTSkodRaTaZ952lE9dzbr1QYzCLiymFC0tljvx45BbBwmHhqRMXA/vjNI9vHCsAq1bLn6HFDst4il+Bi5BPK4t3hP31OPDrJ7QQ7Zq9ep0NLpamXdZUw9cQvuPKXXhxxuXpNH/fnqQs9XsVYxWDxUy07IgWz8yWpj1k+1vIM7mwvfNcPWA3SK7PEUpx61ZuhbTDvTerBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=munZ+uwBGO1zK/Mt0Nw66f3glG3mEbqxWDyqWMWvCTM=;
 b=OgeU+lYEcski8zhjWBWmxwccGDpu8QGoPjTi26HkX7yvNk8Jq9KpSBruN8vIbetR6Z82EnhCyA529tuOlU0ONlmnXmwNR4vm+mKSeqYUNI8Q71uYriLEKiQI9zpTd+8OfWbt7pIsKK0MfhtkmQClJPte28udzb86wH3Dalgi7ZM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4121.eurprd08.prod.outlook.com (20.179.10.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 13:58:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 13:58:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 2/3] qapi: implement block-dirty-bitmap-remove
 transaction action
Thread-Index: AQHVNdk5W2fShE0KD02ClQ8whPZ+4abZ4/4A
Date: Wed, 24 Jul 2019 13:58:22 +0000
Message-ID: <47b79140-e9ee-d469-fa60-76044671f80d@virtuozzo.com>
References: <20190708220502.12977-1-jsnow@redhat.com>
 <20190708220502.12977-3-jsnow@redhat.com>
In-Reply-To: <20190708220502.12977-3-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724165818684
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5d7cdb-bad2-4796-13d8-08d7103efd44
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4121; 
x-ms-traffictypediagnostic: DB8PR08MB4121:
x-microsoft-antispam-prvs: <DB8PR08MB4121C8B3024B890EB803BE10C1C60@DB8PR08MB4121.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39850400004)(199004)(189003)(52116002)(76176011)(316002)(99286004)(14454004)(64756008)(66946007)(110136005)(54906003)(66446008)(14444005)(256004)(3846002)(6116002)(66476007)(66556008)(478600001)(2906002)(107886003)(66066001)(6246003)(7736002)(71190400001)(71200400001)(305945005)(6512007)(25786009)(81166006)(81156014)(86362001)(31686004)(8936002)(8676002)(11346002)(31696002)(5660300002)(2201001)(68736007)(229853002)(6486002)(7416002)(53936002)(6436002)(26005)(4326008)(486006)(446003)(386003)(186003)(476003)(2616005)(102836004)(6506007)(36756003)(2501003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4121;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V0Psb4S+noX5QlpywgqijpK5rjMJJrQXcYU4jgSrNkkydoJItTmzdi/sLX0EjQFJ2uDlnX6WSLhhuiD1M9MBznPFZ5feuOseniCvi4Tj0Gd9z6e/VfoOB1+S9afR4FD3jn3hVfJqTKdamsJdxDo3sNHFZpAWrsKCaQ98DIwHVxXy22H4ZPuZfVwiXej929zjZs7Si13Kdkea8s//9fztjMzL+7wOy+N3kNydLYe9bMPOj6LaslYAfIPtJ3223aFvs5Af+s3CHRXYK7vhJz4omjnoRKdh6lJ6WnbT9lt8jSWziW0X4/o+lO+DhnjehK3FyQ+pZeu8r4JOJfhg83RBewestqpwFaBheQKw3Png6mXXKJ9bzqvpOzc0XsXIYSTm9gx8yIKRdFH+BFlwKjXtVTdNaIXn5BwCVSQbJI1mXlw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2335BD81CF5774D9FCE0FE2F39BCD7E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d7cdb-bad2-4796-13d8-08d7103efd44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 13:58:22.0239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4121
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.106
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qapi: implement
 block-dirty-bitmap-remove transaction action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDcuMjAxOSAxOjA1LCBKb2huIFNub3cgd3JvdGU6DQo+IEl0IGlzIHVzZWQgdG8gZG8gdHJh
bnNhY3Rpb25hbCBtb3ZlbWVudCBvZiB0aGUgYml0bWFwICh3aGljaCBpcw0KPiBwb3NzaWJsZSBp
biBjb25qdW5jdGlvbiB3aXRoIG1lcmdlIGNvbW1hbmQpLiBUcmFuc2FjdGlvbmFsIGJpdG1hcA0K
PiBtb3ZlbWVudCBpcyBuZWVkZWQgaW4gc2NlbmFyaW9zIHdpdGggZXh0ZXJuYWwgc25hcHNob3Qs
IHdoZW4gd2UgZG9uJ3QNCj4gd2FudCB0byBsZWF2ZSBjb3B5IG9mIHRoZSBiaXRtYXAgaW4gdGhl
IGJhc2UgaW1hZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4g
U25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2suYyAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gICBibG9jay9kaXJ0eS1iaXRtYXAuYyAgICAgICAgICAgfCAx
NSArKystLS0tDQo+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgICAgICAgICAgIHwgNzkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIGluY2x1ZGUvYmxvY2svZGlydHktYml0
bWFwLmggICB8ICAyICstDQo+ICAgbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jIHwgIDIg
Ky0NCj4gICBxYXBpL3RyYW5zYWN0aW9uLmpzb24gICAgICAgICAgfCAgMiArDQo+ICAgNiBmaWxl
cyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPiBpbmRleCBjMTM5NTQwZjJiLi41MTk1ZDRiOTEw
IDEwMDY0NA0KPiAtLS0gYS9ibG9jay5jDQo+ICsrKyBiL2Jsb2NrLmMNCj4gQEAgLTUzMTYsNyAr
NTMxNiw3IEBAIHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiBiZHJ2X2NvX2ludmFsaWRhdGVfY2Fj
aGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIGZvciAoYm0gPSBiZHJ2X2RpcnR5X2Jp
dG1hcF9uZXh0KGJzLCBOVUxMKTsgYm07DQo+ICAgICAgICAgICAgYm0gPSBiZHJ2X2RpcnR5X2Jp
dG1hcF9uZXh0KGJzLCBibSkpDQo+ICAgICAgIHsNCj4gLSAgICAgICAgYmRydl9kaXJ0eV9iaXRt
YXBfc2V0X21pZ3JhdGlvbihibSwgZmFsc2UpOw0KPiArICAgICAgICBiZHJ2X2RpcnR5X2JpdG1h
cF9za2lwX3N0b3JlKGJtLCBmYWxzZSk7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgcmV0ID0g
cmVmcmVzaF90b3RhbF9zZWN0b3JzKGJzLCBicy0+dG90YWxfc2VjdG9ycyk7DQo+IGRpZmYgLS1n
aXQgYS9ibG9jay9kaXJ0eS1iaXRtYXAuYyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+IGluZGV4
IDk1YTljMmE1ZDguLmEzMDhlMWY4NGIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2RpcnR5LWJpdG1h
cC5jDQo+ICsrKyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+IEBAIC00OCwxMCArNDgsOSBAQCBz
dHJ1Y3QgQmRydkRpcnR5Qml0bWFwIHsNCj4gICAgICAgYm9vbCBpbmNvbnNpc3RlbnQ7ICAgICAg
ICAgIC8qIGJpdG1hcCBpcyBwZXJzaXN0ZW50LCBidXQgaW5jb25zaXN0ZW50Lg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSXQgY2Fubm90IGJlIHVzZWQgYXQgYWxsIGlu
IGFueSB3YXksIGV4Y2VwdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YSBRTVAgdXNlciBjYW4gcmVtb3ZlIGl0LiAqLw0KPiAtICAgIGJvb2wgbWlncmF0aW9uOyAgICAg
ICAgICAgICAvKiBCaXRtYXAgaXMgc2VsZWN0ZWQgZm9yIG1pZ3JhdGlvbiwgaXQgc2hvdWxkDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vdCBiZSBzdG9yZWQgb24gdGhl
IG5leHQgaW5hY3RpdmF0aW9uDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IChwZXJzaXN0ZW50IGZsYWcgZG9lc24ndCBtYXR0ZXIgdW50aWwgbmV4dA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnZhbGlkYXRpb24pLiovDQo+ICsgICAgYm9vbCBz
a2lwX3N0b3JlOyAgICAgICAgICAgIC8qIFdlIGFyZSBlaXRoZXIgbWlncmF0aW5nIG9yIGRlbGV0
aW5nIHRoaXMNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYml0bWFwOyBp
dCBzaG91bGQgbm90IGJlIHN0b3JlZCBvbiB0aGUgbmV4dA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKiBpbmFjdGl2YXRpb24uICovDQo+ICAgICAgIFFMSVNUX0VOVFJZKEJk
cnZEaXJ0eUJpdG1hcCkgbGlzdDsNCj4gICB9Ow0KPiAgIA0KPiBAQCAtNzU3LDE2ICs3NTYsMTYg
QEAgdm9pZCBiZHJ2X2RpcnR5X2JpdG1hcF9zZXRfaW5jb25zaXN0ZW50KEJkcnZEaXJ0eUJpdG1h
cCAqYml0bWFwKQ0KPiAgIH0NCj4gICANCj4gICAvKiBDYWxsZWQgd2l0aCBCUUwgdGFrZW4uICov
DQo+IC12b2lkIGJkcnZfZGlydHlfYml0bWFwX3NldF9taWdyYXRpb24oQmRydkRpcnR5Qml0bWFw
ICpiaXRtYXAsIGJvb2wgbWlncmF0aW9uKQ0KPiArdm9pZCBiZHJ2X2RpcnR5X2JpdG1hcF9za2lw
X3N0b3JlKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwLCBib29sIHNraXApDQo+ICAgew0KPiAgICAg
ICBxZW11X211dGV4X2xvY2soYml0bWFwLT5tdXRleCk7DQo+IC0gICAgYml0bWFwLT5taWdyYXRp
b24gPSBtaWdyYXRpb247DQo+ICsgICAgYml0bWFwLT5za2lwX3N0b3JlID0gc2tpcDsNCj4gICAg
ICAgcWVtdV9tdXRleF91bmxvY2soYml0bWFwLT5tdXRleCk7DQo+ICAgfQ0KPiAgIA0KPiAgIGJv
b2wgYmRydl9kaXJ0eV9iaXRtYXBfZ2V0X3BlcnNpc3RlbmNlKEJkcnZEaXJ0eUJpdG1hcCAqYml0
bWFwKQ0KPiAgIHsNCj4gLSAgICByZXR1cm4gYml0bWFwLT5wZXJzaXN0ZW50ICYmICFiaXRtYXAt
Pm1pZ3JhdGlvbjsNCj4gKyAgICByZXR1cm4gYml0bWFwLT5wZXJzaXN0ZW50ICYmICFiaXRtYXAt
PnNraXBfc3RvcmU7DQo+ICAgfQ0KPiAgIA0KPiAgIGJvb2wgYmRydl9kaXJ0eV9iaXRtYXBfaW5j
b25zaXN0ZW50KGNvbnN0IEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKQ0KPiBAQCAtNzc4LDcgKzc3
Nyw3IEBAIGJvb2wgYmRydl9oYXNfY2hhbmdlZF9wZXJzaXN0ZW50X2JpdG1hcHMoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMpDQo+ICAgew0KPiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJtOw0KPiAgICAg
ICBRTElTVF9GT1JFQUNIKGJtLCAmYnMtPmRpcnR5X2JpdG1hcHMsIGxpc3QpIHsNCj4gLSAgICAg
ICAgaWYgKGJtLT5wZXJzaXN0ZW50ICYmICFibS0+cmVhZG9ubHkgJiYgIWJtLT5taWdyYXRpb24p
IHsNCj4gKyAgICAgICAgaWYgKGJtLT5wZXJzaXN0ZW50ICYmICFibS0+cmVhZG9ubHkgJiYgIWJt
LT5za2lwX3N0b3JlKSB7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAgICAgICAg
ICB9DQo+ICAgICAgIH0NCj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+
IGluZGV4IDAxMjQ4MjUyY2EuLjgwMGIzZGNiNDIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrZGV2LmMN
Cj4gKysrIGIvYmxvY2tkZXYuYw0KPiBAQCAtMjEzNCw2ICsyMTM0LDUxIEBAIHN0YXRpYyB2b2lk
IGJsb2NrX2RpcnR5X2JpdG1hcF9tZXJnZV9wcmVwYXJlKEJsa0FjdGlvblN0YXRlICpjb21tb24s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJy
cCk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIEJkcnZEaXJ0eUJpdG1hcCAqZG9fYmxvY2tfZGly
dHlfYml0bWFwX3JlbW92ZSgNCj4gKyAgICAgICAgY29uc3QgY2hhciAqbm9kZSwgY29uc3QgY2hh
ciAqbmFtZSwgYm9vbCByZWxlYXNlLA0KPiArICAgICAgICBCbG9ja0RyaXZlclN0YXRlICoqYml0
bWFwX2JzLCBFcnJvciAqKmVycnApOw0KPiArDQo+ICtzdGF0aWMgdm9pZCBibG9ja19kaXJ0eV9i
aXRtYXBfcmVtb3ZlX3ByZXBhcmUoQmxrQWN0aW9uU3RhdGUgKmNvbW1vbiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+ICt7
DQo+ICsgICAgQmxvY2tEaXJ0eUJpdG1hcCAqYWN0aW9uOw0KPiArICAgIEJsb2NrRGlydHlCaXRt
YXBTdGF0ZSAqc3RhdGUgPSBET19VUENBU1QoQmxvY2tEaXJ0eUJpdG1hcFN0YXRlLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tbW9uLCBjb21tb24p
Ow0KPiArDQo+ICsgICAgaWYgKGFjdGlvbl9jaGVja19jb21wbGV0aW9uX21vZGUoY29tbW9uLCBl
cnJwKSA8IDApIHsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGFj
dGlvbiA9IGNvbW1vbi0+YWN0aW9uLT51LmJsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmUuZGF0YTsN
Cj4gKw0KPiArICAgIHN0YXRlLT5iaXRtYXAgPSBkb19ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3Zl
KGFjdGlvbi0+bm9kZSwgYWN0aW9uLT5uYW1lLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCAmc3RhdGUtPmJzLCBlcnJwKTsNCj4gKyAg
ICBpZiAoc3RhdGUtPmJpdG1hcCkgew0KPiArICAgICAgICBiZHJ2X2RpcnR5X2JpdG1hcF9za2lw
X3N0b3JlKHN0YXRlLT5iaXRtYXAsIHRydWUpOw0KPiArICAgICAgICBiZHJ2X2RpcnR5X2JpdG1h
cF9zZXRfYnVzeShzdGF0ZS0+Yml0bWFwLCB0cnVlKTsNCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyB2b2lkIGJsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmVfYWJvcnQoQmxrQWN0aW9uU3Rh
dGUgKmNvbW1vbikNCj4gK3sNCj4gKyAgICBCbG9ja0RpcnR5Qml0bWFwU3RhdGUgKnN0YXRlID0g
RE9fVVBDQVNUKEJsb2NrRGlydHlCaXRtYXBTdGF0ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbW1vbiwgY29tbW9uKTsNCj4gKw0KPiArICAgIGlm
IChzdGF0ZS0+Yml0bWFwKSB7DQoNCkhtbSwgaW50ZXJlc3RpbmcsIEkgdGhvdWdodCwgYWJvcnQg
c2hvdWxkIG5vdCBiZSBjYWxsZWQsIGlmIHByZXBhcmUgZmFpbGVkLCBzbyB0aGUNCmZvbGxvd2lu
ZyBtYXkgYmUgZG9uZSB1bmNvbmRpdGlvbmFsbHk/DQoNCj4gKyAgICAgICAgYmRydl9kaXJ0eV9i
aXRtYXBfc2tpcF9zdG9yZShzdGF0ZS0+Yml0bWFwLCBmYWxzZSk7DQo+ICsgICAgICAgIGJkcnZf
ZGlydHlfYml0bWFwX3NldF9idXN5KHN0YXRlLT5iaXRtYXAsIGZhbHNlKTsNCj4gKyAgICB9DQo+
ICt9DQo+ICsNCg0KWy4uXQ0KDQpPSywgSSBhZ3JlZSwgZ29vZCBpZGVhIHRvIHJldXNlIEJVU1kg
YW5kIG1pZ3JhdGlvbiBmaWVsZCBoZXJlIGFuZCBhdm9pZCBuZXcgQVBJLg0KTm93IHJlbGVhc2Ut
cHJlcGFyZSBpcyBsZXNzICJyZWxlYXNlIiwgYnV0IEkgZG9uJ3Qgc2VlIGFueSByZWFsIHByb2Js
ZW1zIHdpdGggaXQuDQpNYXliZSwgd2UgbmVlZCBzb21ldGhpbmcgdG8gYmUgbm90ZWQgaW4gZG9j
cy4NCg0KSG1tLCBhcyB3ZSBhcmUgbm90IGluIGEgaHVycnkgbm93LCB3ZSBtYXkgd2FpdCBmb3Ig
Tmlrb2xheSB0byBjaGVjayB0aGlzIG9uIGhpcw0Kc2NlbmFyaW9zLg0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

