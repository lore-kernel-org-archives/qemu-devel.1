Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDDFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4C3206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fiAuD/bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C3206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3DY-0007N9-5t
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT3CV-0006rH-TL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT3CU-0004ZP-A5
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:17:15 -0500
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:20308 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT3CM-0004LQ-0r; Fri, 08 Nov 2019 07:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIi6xvwl8OcQvu8zqXwaX6WOy04PkZnkxiuX1JKU+SHKVQmt1/nOBAxV5w3ePy6z++LUyvIegBbl/WKQiUBqzAn73phlb6ftF+xUV9qOHnLSfj11YmZHZejVy0s80AWsDo7FqLytkO4VEsF7jCtomQ1/xNBHjNxaXbEn/oqo/P6NB+HbVUrwgnsxWy7EjIitzraUL10D0x7/rK52n/yRWPYXcfweNJA2EJzgBnu4YpNmb6ebR8xDFkNB66+abCzFPhPwTRdC65mcMyx+skCl9hYLA27abWViyYApf+yKV5gYXwjQiqsiS6/+d/UFYQuiEjpLCcKKX0CPCOzv+YEeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn12qx+ciusbu+kbiFlCg6pntroBgO6crq8gUozUnyM=;
 b=iUiDkGA4Li6ICBahv28GXONrLcyiv/iG0pLLHMQeQrkSg87rD7XGfyIP+98ZYnf+ylItk5SiV1sTRYpMqXrU7DC3naHlQ9wo5CaE8hbWKFaXZaIA0gt0TMAEFQFRb2nMJBgQ7b5S5TBh2Y6O46xx8Zo0GzBfxJHzfKLIe2nBlzXnOwL/uSOyTtg5nbOA4MrXnv0B2klfFybO1zEMN+PhEgyaeEC/JkQ9vnU+HQ4EoGoxApPOM/thj1Y9jYbFZ65UhXxgA7FvMZ/4Xf8xnixS1UMax3Chzxvyc0tR1NeIEILrzukN2NsZm9FqlE9dP1WGoVRrJ4VRlo9/Ke7gRXkybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn12qx+ciusbu+kbiFlCg6pntroBgO6crq8gUozUnyM=;
 b=fiAuD/bYQyJ7+m4NRriVCf4CVOvAHWmwmkvMLZIQDnqZl5VRUFx86TfnDEM/yH90q3FnwBrmzRe90ou72sUxKHT485hAEtPU4PKb1Ayi7v8OuwwJgaNS2sMr+6M9kUZzB9uvagF+VtwVaIjC94N2H5OtDxHHbqwQtiezUAYjcsw=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4051.eurprd08.prod.outlook.com (20.178.117.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 12:17:03 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 12:17:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/2] Deprecate implicit filters
Thread-Topic: [PATCH v2 0/2] Deprecate implicit filters
Thread-Index: AQHVlh2q7xLfFl1yyEGh+UsNp+NUVaeBLBKAgAAEigA=
Date: Fri, 8 Nov 2019 12:17:02 +0000
Message-ID: <7e5d3f65-1c3c-26d8-a10f-dd52a501d468@virtuozzo.com>
References: <157321444410.31898.1482127132000677175@37313f22b938>
In-Reply-To: <157321444410.31898.1482127132000677175@37313f22b938>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::27) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108151700045
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b4c9fee-e8db-4a7c-20d6-08d764458fe2
x-ms-traffictypediagnostic: AM0PR08MB4051:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB40518A5B4693EFF880F4D669C17B0@AM0PR08MB4051.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(39840400004)(346002)(396003)(189003)(199004)(14444005)(256004)(305945005)(2906002)(71190400001)(71200400001)(7736002)(2501003)(7416002)(3846002)(6116002)(86362001)(31696002)(316002)(6916009)(66946007)(25786009)(4326008)(31686004)(81156014)(81166006)(66476007)(66556008)(966005)(8676002)(14454004)(54906003)(476003)(446003)(66446008)(486006)(478600001)(2351001)(11346002)(2616005)(8936002)(76176011)(64756008)(52116002)(6512007)(6306002)(5660300002)(5640700003)(36756003)(66066001)(6246003)(6436002)(99286004)(102836004)(6506007)(386003)(186003)(26005)(6486002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4051;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9yeidG5oDbyF/VD+sEyZsZ/Wqd5a3Ul9rL0L4lfNRomv7pYLTaRDTCvuVaIkJTjYiGPvK4lti/Gh6yLQDr6/+TRo41HI+pZIdUFXwB0g4xqYDBd6DbXz5XFIucL4tWLRCkDuxR+tQoof6xP8pvxZIgHPqBf1ZEIIKssUJ/5FsD40XmaL1FaulHGkmAJzOqliucDrPJxhK3TmgkVEbVzHFglhKsVgUCZ9fcZVVDxI1fM5/hBYIjjr4GhXvADjeRHx7vceZCnA4W4kgltfPdFDLbXln2pl4fHlSC4I3xc3NlAEDuHk28Rt72CH4k6yGhqv1YBvlnJgv2Zo5AbKa2j6akWQL3o9CSH5kZU8scU4OR1XsLeqHakN21VhJSnjhnzu3WmjiscyV4NcM6Kxe1gxk8bsjK9MQZ+MGkCb0+u8Tbj3PDh3l9VOZR5tdl/OJdGwyuPIVtcpzvObk8BuOzSs6CbieYpEXhNxQShSzGGk2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06B929F3A56F8143B54BEEC77530742E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4c9fee-e8db-4a7c-20d6-08d764458fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 12:17:02.7555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gAyF3F2BOGyeOlNyy3o7P4UX7xmgvSz+5pl243muphM1jBZ1VMywrxej07s2v/rEpMwERUe9cqxnuG3YD6iISVSQf7lXdqaN1EYWwGhlGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4051
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.137
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "pkrempa@redhat.com" <pkrempa@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpTb21ldGhpbmcgc3RyYW5nZSwgSSBkb24ndCB0aGluayBpdCByZWxhdGVkIHRvIHBhdGNoc2V0
Lg0KDQowOC4xMS4yMDE5IDE1OjAwLCBuby1yZXBseUBwYXRjaGV3Lm9yZyB3cm90ZToNCj4gUGF0
Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODEwMTY1NS4xMDYxMS0x
LXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8NCj4gDQo+IA0KPiANCj4gSGksDQo+IA0KPiBUaGlz
IHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNl
IGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kDQo+IHRoZWlyIG91dHB1dCBiZWxvdy4gSWYg
eW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQN
Cj4gbG9jYWxseS4NCj4gDQo+ID09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0NCj4gIyEgL2Jpbi9i
YXNoDQo+IGV4cG9ydCBBUkNIPXg4Nl82NA0KPiBtYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0x
IE5FVFdPUks9MQ0KPiB0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVU
V09SSz0xDQo+ID09PSBURVNUIFNDUklQVCBFTkQgPT09DQo+IA0KPiAgICBTSUdOICAgIHBjLWJp
b3Mvb3B0aW9ucm9tL3B2aC5iaW4NCj4gICAgR0VOICAgICBkb2NzL2ludGVyb3AvcWVtdS1nYS1y
ZWYuNw0KPiAvdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1kZXByZWNhdGVkLnRleGk6MjEwOiBAb3B0
aW9uIGV4cGVjdGVkIGJyYWNlcw0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjk5NDogcWVtdS1kb2Mu
dHh0XSBFcnJvciAxDQo+IG1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
DQo+IC90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWRlcHJlY2F0ZWQudGV4aToyMTA6IEBvcHRpb24g
ZXhwZWN0ZWQgYnJhY2VzDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6OTg3OiBxZW11LWRvYy5odG1s
XSBFcnJvciAxDQo+IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToNCj4gICAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+DQo+ICAg
ICAgc3lzLmV4aXQobWFpbigpKQ0KPiAtLS0NCj4gICAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQ0KPiBzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTNkNDA0NDgyMjc5ZjRmZTY4ZmNiMmM5OTcxZjI0ODBhJywgJy11JywgJzEw
MDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1tbHBva3d0Zy9zcmMvZG9ja2VyLXNyYy4yMDE5LTExLTA4LTA2
LjU2LjMzLjIzODA1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuDQo+IGZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTNkNDA0
NDgyMjc5ZjRmZTY4ZmNiMmM5OTcxZjI0ODBhDQo+IG1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQ0KPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLW1scG9rd3RnL3NyYycNCj4gbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWlu
Z3dAZmVkb3JhXSBFcnJvciAyDQo+IA0KPiByZWFsICAgIDRtMTEuMTcwcw0KPiB1c2VyICAgIDBt
NC40MDRzDQo+IA0KPiANCj4gVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdA0KPiBodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEwODEwMTY1NS4xMDYxMS0xLXZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4NCj4gLS0t
DQo+IEVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4NCj4gUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

