Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C97420717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N+QTkzFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C97420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8hdL-0005pt-KJ
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8hcI-0004zD-Ir
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8hcG-0000bA-Ln
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:11:45 -0400
Received: from mail-eopbgr30118.outbound.protection.outlook.com
 ([40.107.3.118]:61188 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8hcF-0000a2-Um; Fri, 13 Sep 2019 05:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDhTkK9HOrqTTjuD/i85H/uwYvOlWIn9Z/lyVbkissZVAFpzfcBWFDD40eoxcy3044fh4b68zNZu1iaUp9Ihu5GS9yrCD0IZOfNC6m3E+lTmuYoDVvBMvCSUyB6xNeRczv4Uq2I5YLVpVi0U66wCNUydeOgOtYRnlKp+2JacgTObpjjc2l+Z5Yw3r/YBRJgqsBQPk1Ygco+sFbjos0GQRWZAse1A9wuvGhnfm28IWN4ANW6j72VMxJhC8aj5DXVx7JVF/duHxl7tr9XHgjca+pHVqRTD7AelRBWd0H1KQzKnU4IV1ja+Gc6Rti39kzZJOI6W14qHEtzd3ONdjz7kaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzj04kokzQFX/KhZcVbjrr4GJeg6afOByJBZX5DojQk=;
 b=F+fa3DsSgJa9Y70vBoh2JboPTMeo0k2OrBNGGbd5TkSRyYyM+6PZPUmMWvI1CdazWvEN1hku3JUUAnB3MASQgJq/jxN31DO+/6phqyYI9yLPBeqaADbTnhanF3LMRghiQ97ogUNW+5llzU4J9pp8TZlr9mDN+BTaDbL/GEai0f+t5zXnan+WIqqn8yZSIWCsdWi8cg4/QiK7e3cxIf355bC8fRoSzHnIKVWwW/7HYWq7eHdHHXk9eTJXdhLdXy/tC0Q5daKdLWznH0pH3JvETqAYK5Agr5Kirai5Q68YTptppxN3NvJvdWLz/qtJo30NDXYTgtbH1PNAmeqNQvX6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzj04kokzQFX/KhZcVbjrr4GJeg6afOByJBZX5DojQk=;
 b=N+QTkzFrf/sb0A70h3Eps8cmyDIWX4V8cPpbyzoKK8kggYrz5877skJBUZE9WbSX/VFdoaqgneQzv+gQGP5qqPix8lAtiilmJeQg1D4MKtpH/UcKOGsaVsZAN4uQMyQgl6lDuI7qLbFqSC7PCiilbpBsusMtqfoAQ+1JXOHSNtA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4090.eurprd08.prod.outlook.com (20.179.10.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 09:11:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 09:11:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVVEeEHwbIBHmZwU6qI+EoKXvyVacpekqAgAADpgA=
Date: Fri, 13 Sep 2019 09:11:41 +0000
Message-ID: <26cd3042-0d58-4fc4-4380-5328d3d114a0@virtuozzo.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
In-Reply-To: <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0040.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::50) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913121138660
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04a94ba0-1715-4556-369b-08d7382a63d0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4090; 
x-ms-traffictypediagnostic: DB8PR08MB4090:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4090E4542FE60D89426610E4C1B30@DB8PR08MB4090.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(39840400004)(396003)(346002)(199004)(189003)(53754006)(66066001)(81166006)(8936002)(81156014)(8676002)(11346002)(446003)(2616005)(486006)(256004)(6306002)(6512007)(6436002)(229853002)(86362001)(2906002)(31696002)(4744005)(66946007)(53936002)(476003)(110136005)(66446008)(64756008)(54906003)(66556008)(316002)(66476007)(5660300002)(14454004)(76176011)(186003)(31686004)(478600001)(25786009)(966005)(99286004)(26005)(305945005)(7736002)(6246003)(6486002)(36756003)(2501003)(71190400001)(71200400001)(52116002)(102836004)(53546011)(6506007)(386003)(3846002)(6116002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4090;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3kDmU/ML7dG9kDtn9BXWH6/Mrxyon0bj9FWBqqsYEKrl5hrnp5vCYBrt46RaaRNC2tSdCYmja8jKbXHlO5uJWwwIPdkXm+AYWkGbwRwey2LC3DK6zuVU/pGE0BN+kY4E3jj8LWcrXSiVqalAQ2zMopw2rxjufEEv7DCOyptDsSQgvBRh68iJfljIXCMtJUODEkbnbIWkULQu/nFkzLHrpZgimT3QvDhwWGSZlz478Pn3Pn4uj/sEzh/YaAajcda4rnj+vJ80QWsXFh7JXLz5szH4TJ1vYMh2Dn/eYuqvxzFT0qlP69hIUSSic4cOXESkwOm3XgB6LTJOkvfxEp4pUqzW+Zd1jm2cdJ2qVgaRPdJ7qZd7hK5ywd0hg1msP80ax03LlqJYG/7TCeleikURnh9vq0jQ0zbttVra+Hny8TM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F20F9D7E945E9478399F2D2515947BA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a94ba0-1715-4556-369b-08d7382a63d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 09:11:41.3048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWka7WmYPVJsvOlfU7dVxII9ZcLywQI7DFfX7N0mqWTHt2eecWuNIVQUnmse3jZuIWZRiv4JzXRh+mIMYVA4OHfkCtrSzI6DyiHnJsm/YkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4090
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.118
Subject: Re: [Qemu-devel] [PATCH v4 0/5] qcow2: async handling of fragmented
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

MTMuMDkuMjAxOSAxMTo1OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNi4wOC4xOSAxNzozMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBI
ZXJlIGlzIGFuIGFzeW5jaHJvbm91cyBzY2hlbWUgZm9yIGhhbmRsaW5nIGZyYWdtZW50ZWQgcWNv
dzINCj4+IHJlYWRzIGFuZCB3cml0ZXMuIEJvdGggcWNvdzIgcmVhZCBhbmQgd3JpdGUgZnVuY3Rp
b25zIGxvb3BzIHRocm91Z2gNCj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4gVGhlIHNl
cmllcyBhaW0gaXQgdG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+IGxvb3BzIGl0ZXJhdGlvbnMuDQo+
PiBJdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBmb3IgZnJhZ21lbnRlZCBxY293MiBpbWFnZXMsIEkn
dmUgdGVzdGVkIGl0DQo+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+IA0KPiBUaGFua3MsIEnigJl2
ZSBjaGFuZ2VkIHR3byB0aGluZ3M6DQo+IC0gUmVwbGFjZWQgYXNzZXJ0KCh4ICYgKEJEUlZfU0VD
VE9SX1NJWkUgLSAxKSkgPT0gMCkgYnkNCj4gICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRCh4LCBC
RFJWX1NFQ1RPUl9TSVpFKSkgaW4gcGF0Y2ggMyAoY29uZmxpY3Qgd2l0aA0KPiAgICDigJxibG9j
azogVXNlIFFFTVVfSVNfQUxJR05FROKAnSksIGFuZA0KPiAtIFJlcGxhY2VkIHRoZSByZW1haW5p
bmcgaW5zdGFuY2Ugb2Yg4oCccWNvdzJfY29fZG9fcHdyaXRldigp4oCdIGJ5DQo+ICAgIOKAnHFj
b3cyX2NvX3B3cml0ZXZfdGFzaygp4oCdIGluIGEgY29tbWVudCBpbiBwYXRjaCA0DQo+IA0KPiBh
bmQgYXBwbGllZCB0aGUgc2VyaWVzIHRvIG15IGJsb2NrIGJyYW5jaDoNCj4gDQo+IGh0dHBzOi8v
Z2l0LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jaw0KPiANCj4g
TWF4DQo+IA0KDQpUaGFuayB5b3UhISENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

