Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CB5C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136B220665
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pQ0c+7J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136B220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHwU-00065P-HR
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyHr2-00008Q-2W
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyHqy-0001N8-Gt
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:39:55 -0400
Received: from mail-eopbgr150091.outbound.protection.outlook.com
 ([40.107.15.91]:3662 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyHqy-0001MF-By; Thu, 15 Aug 2019 11:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL/jxSAhMtHxiF9CeTvgM0C/ZFuiZbJrUnTc5JcHHXNkkn0sJQDdy0zbKc+bqpgrovuCW4idFFMPYJ3Qg3pmK8L+fzqnlUNQ57beCmNdtr66q5qyAxugvdGUuZlPjlUc0sfvPxzyFWdogZh1i7zNxhGjXoUWfAUS1tO46olEkq+0u07S0g73TgH1q5ufdHEhFdSi0JYHj0b4QOvY6QQnvcWhlbsMEDRntcqaFpDrS8d/yf6tWESKb6B8DBxGEdM11lNwoqNYAVONBiQykAhSgS2lMizwV24XD9DxJTIC0vJLFAu3bKagoucaLWl7WZpV0KMFXU79ycl2QB8zE0sCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IPKXr6kCUGpxkyLajhupD4JnOySyECeycD7mxnznvw=;
 b=LE0zUtfrI/Cbr55Gpq4xTIHhzqfx+A5ip5M4X6+e6o4hIuUEyFGnZ+jbzIw2v7DWaj0f4RZNAAsVdzdPDssOu2epdZRNXrm1JgPmu16nhNifof1h3EHsKRwor6LYXUTFeajTD3FpHZZTUc5iYQfm62gPwg5xSJRcRbJXwp4vIpJbL3XqEldwcEqWf7Y4Fn/GAqPDrhL/g1npLv8hIy+pQUGG8kUezX/pj82MHW72/ZYGkggM7kiZs7z87yrjJKo6wWWfnUy9WeFx0m8w/Q3j7MyVPKHOgOoBingMsoWv7JHZcRtiwPK7Uh+uKv9CZ3c6Jkx131VTRH4gGPBSd1t1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IPKXr6kCUGpxkyLajhupD4JnOySyECeycD7mxnznvw=;
 b=pQ0c+7J0elnlOB06u/XcOQa0vCTf5Ih4JmpmfCx+Xxj95hBdltdm3mcY5yTqqrtlBzeOK8/DM7oxvbYrMIwG+bwkDPcVAyu7MAHtUuPupTN3iy+HtQehnk0CKSGAWEdFOaFQX5Hxku5N/YZjcshrFWVzOk4VbYTbGLVrH96Kqnw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 15 Aug 2019 15:39:50 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 15:39:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 0/4] qcow2: async handling of fragmented io
Thread-Index: AQHVU2J5fEq8y0bXA0+IlUQwrVWabKb8P0eAgAAZSgA=
Date: Thu, 15 Aug 2019 15:39:50 +0000
Message-ID: <8c259ef0-ccce-5fd0-6c88-4f0a2109715c@virtuozzo.com>
References: <20190815121042.121309-1-vsementsov@virtuozzo.com>
 <ed48ba6b-f90d-abe6-c77e-34c4a6bfab8c@redhat.com>
In-Reply-To: <ed48ba6b-f90d-abe6-c77e-34c4a6bfab8c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::11)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190815183948043
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2be7185-b3c2-4e87-e729-08d72196cf61
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5387; 
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB538732CF8BC668A1135F11FBC1AC0@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(53754006)(76176011)(52116002)(81156014)(54906003)(256004)(53936002)(2906002)(305945005)(66476007)(81166006)(6506007)(8676002)(64756008)(66446008)(8936002)(7736002)(102836004)(14454004)(6512007)(66556008)(386003)(6246003)(4326008)(6116002)(66946007)(53546011)(25786009)(86362001)(110136005)(3846002)(478600001)(99286004)(36756003)(316002)(4744005)(11346002)(5660300002)(2501003)(186003)(486006)(6436002)(31696002)(446003)(31686004)(229853002)(66066001)(26005)(476003)(71200400001)(71190400001)(2616005)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZM+B6dmbzTFRaEdrWetihc0DQQuoIPxw9pmmHZpHdQ6KTHu+b7i8E6GEHRQQkn2/NV44yZIN2ZISBj5BPvnSqSvTOuoCv16t28D3C5DFwIla4n4bhtrnQDmZnJWepjqWytUAIVsBUecu20Ywwo0eW4zJU3MJcECa5cIvrnYlGIhkFqVKD4XeuYFbMMId1hjtNvst9Y8+Svy+g2Ar91UA2kILC8LWKPhvchBU3zB0Xf2HbvZyQkKnfanKJ3CyfcMzKhI1PwL6QHUX3/QICWhVgvTaQTQxlzxPAH5NjnxUE2st8diTYZ4n4KgGs9lNwYBWBTluswcb3iupitci8LSFyzXvRBK3qungoUFzOv3h/Ub+PnlwEmWKyzJndxmK8Pc8gOdjKksYUSgycgbqo0jhGHWdOor4K1t0cul9V4958UY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0D93A3D867C54585E93E41389CD39C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2be7185-b3c2-4e87-e729-08d72196cf61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 15:39:50.5986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjYg16oSpq6QOuKbz8Wdh6drueg3PJhlqpiszHy/x9DwW+uNJqnxYMwJ9rNSd5e7vj3jqCCRw+I77DkKo6/1D0Y4T6hUtwlDvyq8Tew8aXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.91
Subject: Re: [Qemu-devel] [PATCH v3 0/4] qcow2: async handling of fragmented
 io
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDguMjAxOSAxNzowOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNS4wOC4xOSAxNDoxMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBI
ZXJlIGlzIGFuIGFzeW5jaHJvbm91cyBzY2hlbWUgZm9yIGhhbmRsaW5nIGZyYWdtZW50ZWQgcWNv
dzINCj4+IHJlYWRzIGFuZCB3cml0ZXMuIEJvdGggcWNvdzIgcmVhZCBhbmQgd3JpdGUgZnVuY3Rp
b25zIGxvb3BzIHRocm91Z2gNCj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4gVGhlIHNl
cmllcyBhaW0gaXQgdG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+IGxvb3BzIGl0ZXJhdGlvbnMuDQo+
PiBJdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBmb3IgZnJhZ21lbnRlZCBxY293MiBpbWFnZXMsIEkn
dmUgdGVzdGVkIGl0DQo+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+IA0KPiBMb29rcyBnb29kIHRv
IG1lLCBidXQgSSBjYW7igJl0IHRha2UgaXQgeWV0IGJlY2F1c2UgSSBuZWVkIHRvIHdhaXQgZm9y
DQo+IFN0ZWZhbuKAmXMgYnJhbmNoIHRvIGJlIG1lcmdlZCwgb2YgY291cnNlLg0KPiANCj4gU3Bl
YWtpbmcgb2Ygd2hpY2gsIHdoeSBkaWRu4oCZdCB5b3UgYWRkIGFueSB0ZXN0cyBmb3IgdGhlICpf
cGFydCgpDQo+IG1ldGhvZHM/ICBJIGZpbmQgaXQgYSBiaXQgdW5zZXR0bGluZyB0aGF0IG5vdGhp
bmcgd291bGQgaGF2ZSBjYXVnaHQgdGhlDQo+IGJ1ZyB5b3UgaGFkIGluIHYyIGluIHBhdGNoIDMu
DQo+IA0KDQpIbW0sIGFueSB0ZXN0IHdpdGggd3JpdGUgdG8gZnJhZ21lbnRlZCBhcmVhIHNob3Vs
ZCBoYXZlIGNhdWdodCBpdC4uIE9rLA0KSSdsbCB0aGluayBvZiBzb21ldGhpbmcuDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

