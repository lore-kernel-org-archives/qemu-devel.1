Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5922C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9034821D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pDLJGhp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9034821D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5mY-0001qc-MR
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5kH-0000EH-TV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5kG-0003AJ-Vc
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:46:09 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com
 ([40.107.7.91]:27842 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5kG-00038Q-No; Wed, 25 Sep 2019 07:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8/ZIurAYcg/IBkjXWuYgKy81YeWSQKDK7zhL8Hr3S+9wgIyT7JBaA8SUx9/DpuR9vkvLAeFQq6G/F6sxdTjDpVjV8YPM/Ft5LDmbeWzE90TudEuUy1oua+lV1lyHc7oRNlFI3OIWu/jJFgQCMq07JZseW1/y16WcwGp36TEo4uKRJH044PzmmW+xAr+0W/XCjRC/bPTCZDqjxZ/lKY//8sBGX/6/jklhdfE4hLOTM21gdiein0l6DLArthjBezd/sIIHj6k/EwhzvzOQXOfPphHfr+Zu3yOZ/UknOH/hKlYSAi0H1EdLtgvpp2WnI9xmAV+wgu1W4akwiYvnLuiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GEnkFY0buPlTJr5N6x0vdpqDo6VhPkMrveqOx9UP8s=;
 b=lKE8hUW5JIIzP8nym4PZdF/Jt8CJaRsuRbmduuBodrOqMVjH1Fh/9bA5C/bcU6aJiELg2s9tQxJ82XA2Sxm0jiUd3n0CnjpTjdUbp3MSmQMCIYbJJPcmP9h/TeQS8dh0uVxYy6xNcih+L/U+WvwUc20j3JyPYEm0U3/v0ytrlTdhCBzAulstJlU2uNU85nFe3yyuGs1XJl6c8bEVAl4+OPAztfJweshV0CuHfzbuRx3FM4br8R+OSy2pcMzPF8IaA3AHpOgnolTmlPFmXornikMS2gWAlCXShWRCrSnNnix5zCLCjwkIO+hwoj42JBy4wcKw5V9lrojg3huZTW80Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GEnkFY0buPlTJr5N6x0vdpqDo6VhPkMrveqOx9UP8s=;
 b=pDLJGhp7Fjt67zrvyfiY0mwSREvX2dJTVi/sWJ9WPXk1DeYADZhxDydWEl+Ow6I3Zpq/dVxfNxzF7v02Q3wVrSdMhbUM3aWlpx8jYbiekZpq9UAtKfCwXgccZqLWaNIlBoCSOVlZftgtHTSFDnwoipzgUGjb5dSV1Sd4/wp511k=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5242.eurprd08.prod.outlook.com (10.255.18.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 11:46:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:46:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 02/22] blockdev: Allow resizing everywhere
Thread-Topic: [PATCH 02/22] blockdev: Allow resizing everywhere
Thread-Index: AQHVb8lIJ+XCK0hnnkSP304nb4f4rac8TgwA
Date: Wed, 25 Sep 2019 11:46:06 +0000
Message-ID: <fe97b4b1-1099-6b0d-45ee-b85a3aad959d@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-3-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0240.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925144604336
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9ddd869-d91f-46cf-7ff3-08d741adf348
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5242; 
x-ms-traffictypediagnostic: DB8PR08MB5242:
x-microsoft-antispam-prvs: <DB8PR08MB52428D1A90BC21527A999E63C1870@DB8PR08MB5242.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(346002)(136003)(376002)(189003)(199004)(229853002)(558084003)(256004)(54906003)(110136005)(25786009)(31686004)(486006)(2616005)(446003)(11346002)(476003)(86362001)(5660300002)(99286004)(6116002)(76176011)(52116002)(3846002)(36756003)(316002)(386003)(6506007)(102836004)(478600001)(66446008)(2906002)(14454004)(64756008)(66556008)(66476007)(66946007)(71200400001)(26005)(31696002)(8936002)(8676002)(2501003)(186003)(6436002)(6246003)(81156014)(81166006)(66066001)(6486002)(4326008)(7736002)(6512007)(71190400001)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5242;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 21R+uJjrmqxGVkXX5Wq2QmDAG5XKdfUFwNxWgvW92/8KZUxFov1xVDGxbXqC9MdCeWbUlIYhNaZ2DM/RrLZKJQzZmHvxfRyWVBCyY9tKDpQXmEDddLm7RAhLQ+NiXsvHBdzHjSmWBKd+9VA8gp9hbWIVDzmvGTF2+eQ9JgwBxDXUzcTAYVnVv/gnprSzPwV1ZxYiNqQdhc39rXnXJPL5kYEFkI6ALq7SsQf/5XR9Te5s6XGYz3CQ1LFnMzvfqJTHR8oSBW3A556uCZ1715AApq85qX2Pd9QOSslu3X1YZoJj9KtsSd/pErsanS1od66SZFybm/m6iWGWZgdLGKK7R5Zh3nVZh3JXWoeq4t0gHlfhLW/ZOscrxpqWFskEAlpXeY1wcGyRa3cS5t6VQKRCL/zso2Imr50uw1x8xlyIFaI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D116B26FF832449A484B79117F39B7E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ddd869-d91f-46cf-7ff3-08d741adf348
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:46:06.4668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q18mgYaabdsXpJNYMkMXaPhUnVHXxKXtmi2NscIArf+C+GFUnQwI+Xu2Fv694gm3OQAiXyH2DLOpLk9xNPsr3jN0rb1VOPlzMSUA3QGpwlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5242
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.91
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBCbG9jayBub2RlcyB0aGF0IGRv
IG5vdCBhbGxvdyByZXNpemluZyBzaG91bGQgbm90IHNoYXJlIEJMS19QRVJNX1JFU0laRS4NCj4g
SXQgZG9lcyBub3QgbWF0dGVyIHdoZXRoZXIgdGhleSBhcmUgdGhlIGZpcnN0IG5vbi1maWx0ZXIg
aW4gdGhlaXIgY2hhaW4NCj4gb3Igbm90Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6
IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

