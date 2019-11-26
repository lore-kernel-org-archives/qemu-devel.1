Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B24C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B37520659
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l8bVQ/cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZVHR-00035C-Gs
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZVFu-0001qA-13
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZVFt-0006CW-22
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:27:25 -0500
Received: from mail-vi1eur04on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::711]:54941
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZVFs-0006B3-Rr; Tue, 26 Nov 2019 02:27:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYMuzmBDP1Oi/UEwAgUAbdXOZf2zjDr0+zWiL0kFhqYasMahsgXAT4gYliea6bBjL1qyrdRuDF4Utm0CA+qzC0Yvhyq7MCxxC1BHq9mPEeSGXxob8sUtXDHOIui0TcdKEWswF92x6q6Zad1CtPr0re+kr3zzkvHSuBVr8yDBnXx3K2oUBJsdJ49zxUN8hxwshLuqPMGZu7o7HystNtMWw2PilTuKC5C1kY7Wfk5pEt6D8yECKrxhVgUcUSWKQ+HTmaWGX6CmA2+x4EetEuJugOAgyktRABQ/8SaiJ7ZhJImRL4xysNEUYe4LgjZfN2O2iuE855AVXoELOOkK07xnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8ba6ebTKRYRvKm+xw3WzXF+IzNEs3+B1OCM2JZHb/U=;
 b=SHtpw0tOPRaONZMAkIGC1Pzgd2UKwoZijYP9Rrp1WBbyzc3wJL+XJk6aO3VOfpxdMWFIMw5+lPtJcKEE/zS6GzwRucswd5/LLmtAL2Ls2UZM5YUTTXaVncL8b4+mspy/uF8fYO4A36V7afHKo4nbo4Gi4bLvofJqxYykQjeLnXyo2q3GcqqCfp5AA0Nw0ggNCEZZi9pv+TWdra+Y5Fqm3YhzuuSvAkNiSu3FVh7GNOyxVL3kRvPinMmnH8stbGbeb7KS0EfZxh5jZYQDDVG0NVzLcMRFvp4/a5mKgy6oqnTP/+UtNL7wiPuoRKXHbeSUwK263dJqUGql9F1i+nF42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8ba6ebTKRYRvKm+xw3WzXF+IzNEs3+B1OCM2JZHb/U=;
 b=l8bVQ/cnqJ4ZIagzvp5xGTNNRWg1Ncr7gpQgWlC4Zf/QYEoIrU20WrbR9fOaPUoq77wffaVI1CZdfdn3oqQ8jowzSsbUIhaPsAP0umshbbvD3wM6mSwEBsViVJPNOtKC0g8xJiUkR2jjEjXVaRnc8yGOIqRQPcTY4ENtOt+e9yA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3398.eurprd08.prod.outlook.com (20.177.115.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 07:27:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 07:27:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5Keb6aCAgAAsM4CAAQbTAA==
Date: Tue, 26 Nov 2019 07:27:21 +0000
Message-ID: <9d5766bf-65de-1087-70d5-58e6997f9002@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <4f6f9488-8ec1-85bf-5584-bac5b0f8ce92@virtuozzo.com>
 <20191125154637.GC4638@linux.fritz.box>
In-Reply-To: <20191125154637.GC4638@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191126102718388
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7104906-161d-4de6-7448-08d772421314
x-ms-traffictypediagnostic: AM6PR08MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3398AE44E5782E755E186F56C1450@AM6PR08MB3398.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(39840400004)(376002)(189003)(199004)(4744005)(11346002)(31696002)(86362001)(2616005)(446003)(229853002)(305945005)(6116002)(3846002)(7736002)(186003)(66446008)(64756008)(66556008)(5660300002)(66946007)(6246003)(81156014)(8676002)(26005)(36756003)(66066001)(52116002)(8936002)(256004)(478600001)(102836004)(81166006)(54906003)(71190400001)(6486002)(6436002)(71200400001)(316002)(14454004)(25786009)(2906002)(99286004)(386003)(6916009)(6506007)(66476007)(4326008)(31686004)(6512007)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3398;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGYOclrjvsyfek3x7JlQKMpVhyPszNtCqsSBdk2PjZt8vhc/bFaxUg+2pKz7jTlNVU6l8B8OPOeWrWCnayxBlONF5saiYHKDIqMavuqNxFrWnHdBgFFB2ZLoC2dGlFdYjvXh1zfjQP68Z5ylwfvDjHbpQIh8qlyv9SHmfan/xl96oNv0sfj3WnCJthVwFRCXnaoZ0etgZVFXux2Irp0hkzIqz7E1rkYqtuHSMZM7P6gJD0GStDjcGbZ/w+AGg4WcVF0PwcJqyHgX+l8RBXET6fc6gPBSNay53VBFyFSuVGVbb4ov/HUYnAyYHE9qmTBcusuRks1iaJVtQGggvyPTFrvvOxHZr4dwj5TLQXqMLDgYtgbU0RzUWK75PKB97GYHdoEj/4NNA89S97Zs4vterTxIvyBylAtd1PFTvd3ED1hbiFWspyRPy8wTRuU7BIAc
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0EA0E6B22FFF4692EFDEBBFB27C3AE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7104906-161d-4de6-7448-08d772421314
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 07:27:21.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVeqmhLGkzd77jc+u/5KjXBqlM6S1iZ5tK8B7gTDI1JuccDqW/TJQe8UHc9K8e90leG5cCH9oywROeRQadOclF74E/QUrKvM7buG3ST5aC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3398
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::711
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
Cc: "fam@euphon.net" <fam@euphon.net>, Alberto Garcia <berto@igalia.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMTEuMjAxOSAxODo0NiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjUuMTEuMjAxOSB1bSAx
MTowOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IFBp
bmc/DQo+Pg0KPj4gSGkhIFdoeSBzbyBzaWxlbnQ/IFBvc3Rwb25lIHRoaXMgdG8gNS4wPyBUaGlz
IGlzIGZpeGluZyB0aGUgc2FtZQ0KPj4gcHJvYmxlbSB3aXRoIGJsb2NrIGNvbW1pdCwgbGlrZSBL
ZXZpbidzIHNlcmllcywganVzdCBjb21taXQgbm90IHRvIG1pZA0KPj4gYnV0IHRvIGJhc2UuLg0K
PiANCj4gVG8gYmUgaG9uZXN0LCBJIHRoaW5rIGJ5IG5vdyB3ZSd2ZSBmb3VuZCBzbyBtYW55IHBy
b2JsZW1zIGFyb3VuZCBzaG9ydA0KPiBiYWNraW5nIGZpbGVzLCBlYWNoIHdpdGggYSBub24tdHJp
dmlhbCBmaXgsIHRoYXQgSSBkb24ndCB0aGluayB3ZSBjYW4NCj4gaGF2ZSBhIHJlYXNvbmFibHkg
Y29tcGxldGUgZml4IGluIC1yYzMgd2l0aG91dCByaXNraW5nIGJyZWFraW5nDQo+IGV2ZXJ5dGhp
bmcuIE5vbmUgb2YgdGhlIHByb2JsZW1zIGFyZSBuZXcsIGluIGZhY3QgSSB0aGluayB0aGV5IGhh
dmUNCj4gZXhpc3RlZCBzaW5jZSBkYXkgb25lIG9mIHJlc2l6ZS9jb21taXQsIGFuZCBub2JvZHkg
aGFzIHJlcG9ydGVkIHByb2JsZW1zDQo+IGJlZm9yZSwgc28gdGhleSBjYW4ndCBiZSBoaXR0aW5n
IGEgbGFyZ2UgbnVtYmVyIG9mIHVzZXJzLg0KPiANCj4gU28sIHJlbHVjdGFudGx5LCBJIGhhdmUg
dG8gYWRtaXQgdGhhdCBib3RoIHNlcmllcyBhbmQgd2hhdGV2ZXIgd2UnbGwgYWRkDQo+IG9uIHRv
cCBhcmUgcHJvYmFibHkgYmV0dGVyIGtlcHQgZm9yIDUuMCAoYW5kIDQuMi4xKSByYXRoZXIgdGhh
biBhZGRlZA0KPiB2ZXJ5IGxhdGUgaW50byA0LjIuDQo+IA0KDQpPSywgSSBhZ3JlZS4NCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

