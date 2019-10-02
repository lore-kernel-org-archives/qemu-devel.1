Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31061C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA38218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pZ7Sm8+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA38218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbKo-0000i1-Vh
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFbJx-0000DK-VH
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFbJw-0004wN-NB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:53:21 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com
 ([40.107.3.107]:56485 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFbJv-0004vR-Qs; Wed, 02 Oct 2019 05:53:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0daBded4vNPnuBmGQkaIHPnjaDxrMgrYSFtOLxDJKU/01o5RbRY01Z8ni2IKH/5Inme5KNsKiiaA4LFCoz0k3poJ7F1H4UjQVebd+Y31igNsRXyr3wPekFeXNZL5H+l0HAalCl1azvh2Xh0Wc/HU09KjbiZ9ZzcojAANiHhtq+Yc4Pngr8Sk97BCnxaz1r1w2WmGTmIhNoibD1UY9X0YCg3wkNwDgGdUs0+f5WtRHksztY7+UJwe6qBNFR2V7JzPI4rxi3+lVagz82d6Q9htiJGlDjk33UYe9nz+CkBUlcUWU1DzUMuqwigZvflDK8cXwQZtFrDZGmBlOddjUID+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=168DdCT17t/BA9zOIf+P1V5PwbSl0hQr3DdH+iMYc2E=;
 b=moZfXxOSZznJJtF3tzOGLFalHsD7OGyQzFBsDnMRT8A5pMj/nWJKhsRMNRJigcaXD4hs0xdL0RQnj2of1pMJr4oiRfAKlkdNE3EmZ8iDJ/EwRT7+6yi+Fk7FwNjQcEAORgPwapXayeEo2ae8zgJ3ycSZVj4L6fCYwC9rg17h07j/cOxQNZDxvnpdceFrkN04kDk3S/i1OHitHvuStRL3dqPa4YyvvnANHAHddV2gb/ThxlpSwi70xBHt4/Tzr137JjUZq2PyBzAizsWLKEoreBg4MheqA6BrV+QgRIYCRB5oWBDvAbZKb4/D0eSqJlgUqJYnelcsKWW9hi4T+2ihOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=168DdCT17t/BA9zOIf+P1V5PwbSl0hQr3DdH+iMYc2E=;
 b=pZ7Sm8+wf086h3DeI4jQkNqLwUHZwlS53exe0oQUdva07kDbnDt1GlY/D9Lo7PpunUn/qDwe0Dle7ha5aNElsqwnCcwEPA/HNERZG/hunasf6C9QV0ANJUZoirFlOokLA0lDw1jCrrqJw4hQuEIirI6cH6YA9DInpf/oLg+dFv8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5034.eurprd08.prod.outlook.com (10.255.16.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.22; Wed, 2 Oct 2019 09:53:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 09:53:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] active-mirror: support unaligned guest operations
Thread-Topic: [PATCH 0/4] active-mirror: support unaligned guest operations
Thread-Index: AQHVaXyqlv4yAGykQ0alZq11SRxKFqdHO3AA
Date: Wed, 2 Oct 2019 09:53:16 +0000
Message-ID: <d77c8228-f8a3-eb3e-0da7-50ac48cc1ce0@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190912151338.21225-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0278.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002125314035
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 150066c1-4a16-4867-e0df-08d7471e58e4
x-ms-traffictypediagnostic: DB8PR08MB5034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5034F48F9C2933677D23B832C19C0@DB8PR08MB5034.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(66446008)(4326008)(256004)(66476007)(66556008)(5640700003)(64756008)(102836004)(31686004)(4744005)(8676002)(6916009)(186003)(11346002)(81156014)(81166006)(8936002)(446003)(6506007)(2616005)(386003)(229853002)(54906003)(25786009)(486006)(66946007)(14454004)(26005)(476003)(36756003)(478600001)(52116002)(2351001)(86362001)(66066001)(2906002)(99286004)(305945005)(76176011)(6486002)(6116002)(31696002)(107886003)(7736002)(3846002)(2501003)(5660300002)(316002)(6436002)(6246003)(71190400001)(71200400001)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5034;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKWLG6f7Nmb64AWf1B6FdJWgvyTxO4MH7AvjxVUFWKuidfmWLKYChKQFRPYftI1yND1DsgXZy9S8SLQCWdAZeWezB9N56iwMMWp7a+WQA/t9IH040e9f2wc4Z1bWQLmc0blUQkDdZXp6t83JXhFUYY5oUU5GlqfB+kB5MaJ4Y/oPR1mubHl++v+K5UW/w9EtZ63yqCUTaeRg0IAml1gmS/dlvE56IWdkkItkc9X2WQyiIxjOCLfSrHrIeLdWj3oUxSEcSJt9LLQR9JvCaZ897sed3w96JJqbRdLqs8hoZPpwQnNXjR8Y+odiX2B54NF5W062dhmgCKHJG+43RU5y+urb3y1G3DsTv3U7xX9lmDCdrkdDPiH2QV/iOjyI7FsoneLJ2xfeCt0WmyHM+iUxnA8B7NAmJV5Fg+Y/YoOL1E4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A56B4280841D2D46848988D2A3F8F90D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150066c1-4a16-4867-e0df-08d7471e58e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 09:53:16.4061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgFcfst6qvuXZRbjIryKeVKoOw1li4grcY0Z3759RQA3RRPG1Nu0NIPhpC2FGabSialAp0G1JLGO5IQL26+GJ69OF8WJF0d1PPbX9M1mXHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5034
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.107
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxMi4wOS4yMDE5IDE4OjEzLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBDb21taXQgOWFkYzFjYjQ5YWY4ZCBmaXhlZCBhIGJ1ZyBhYm91dCB1bmFsaWduZWQg
KHRvIGRpcnR5IGJpdG1hcA0KPiBncmFudWxhcml0eSkgZ3Vlc3Qgd3JpdGVzIChhbmQgZGlzY2Fy
ZHMpIGJ5IHNpbXBseSByZXF1ZXN0aW5nDQo+IGNvcnJlc3BvbmRpbmcgYWxpZ25tZW50IG9uIG1p
cnJvci10b3AgZmlsdGVyLiBIb3dldmVyIGZvcmNpbmcgbGFyZ2UNCj4gYWxpZ25tZW50IG9idmlv
dXNseSBkZWNyZWFzZXMgcGVyZm9ybWFuY2Ugb2YgdW5hbGlnbmVkIHJlcXVlc3RzLg0KPiANCj4g
U28gaXQncyB0aW1lIGZvciBhIG5ldyBzb2x1dGlvbiB3aGljaCBpcyBpbiAwMy4gQW5kIDA0IHJl
dmVydHMNCj4gOWFkYzFjYjQ5YWY4ZC4NCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgKDQpOg0KPiAgICBibG9jay9taXJyb3I6IHNpbXBsaWZ5IGRvX3N5bmNfdGFyZ2V0X3dyaXRl
DQo+ICAgIGJsb2NrL2Jsb2NrLWJhY2tlbmQ6IGFkZCBibGtfY29fcHdyaXRldl9wYXJ0DQo+ICAg
IGJsb2NrL21pcnJvcjogc3VwcG9ydCB1bmFsaWduZWQgd3JpdGUgaW4gYWN0aXZlIG1pcnJvcg0K
PiAgICBSZXZlcnQgIm1pcnJvcjogT25seSBtaXJyb3IgZ3JhbnVsYXJpdHktYWxpZ25lZCBjaHVu
a3MiDQo+IA0KPiAgIGluY2x1ZGUvc3lzZW11L2Jsb2NrLWJhY2tlbmQuaCB8ICAgNCArDQo+ICAg
YmxvY2svYmxvY2stYmFja2VuZC5jICAgICAgICAgIHwgIDE3ICsrKy0NCj4gICBibG9jay9taXJy
b3IuYyAgICAgICAgICAgICAgICAgfCAxNTMgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspLCA5NiBkZWxldGlvbnMo
LSkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

