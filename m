Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB8C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A6F21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vK/Tkv7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A6F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5lc-0000LV-3o
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5jd-0008C6-MJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5jc-0002qc-HX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:45:29 -0400
Received: from mail-db5eur01on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::703]:37185
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5jb-0002pz-PO; Wed, 25 Sep 2019 07:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgqAsv8j3iB5UKnrc5m7B6T6I45cbU5e4PMMmsb5HZH3OUAiPlwMJUdYMtnyD0v0rTzvd2+P8G9qRthO+nkPNYi8G6YQITujwh2E/G/EeGwHFin0t3ZMerJAtiY5VSjDEgkIWxDmMrVkuapuA1Wwkfb7FZqm1gjKqS8z6DEITXLzCWDREnDJRXJVfihu3yWuNQ2EJArSmqK0rP71gt6gZTgV6PghKsLPzQanrslV+xUWHNd1g+RCZhjQmeCoJhS/JtO21ivA3wXfZeyhQFJ9KqBzhlITMoFhGODcQ/QiIGRuzyDFY4bycqOm5zS+SHijY8rCwcNhb3qWLqmasekaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ6uu+OKxktc/rVteoDNcnFi5Nf5ICAl62T39fw1lB4=;
 b=XH/N+7UnJ445S2+t3zAAYYA5C96FHBhYtSqjKPayVZ+FS59xOqev2WJGpJmVRXUCyPlRh8+JYdIwq1oauu/ZoqOxPLZfdk2Ag6XmZEkdTCKz3TWflSfOrG621z8LgA20jI73GDSggqFPpN99poyJUzXdOzGwAIpGcDYLDBzpcwoeAVXnc0geVn5G7mN3oIU/adaK6tagx06JOCpKGRuEI8iQSIUkc7FaKFhn61di+rariABs+UlJPvy0D5yl5eNGCBSbBZ1hQbWYQYfI4XZZSxIaoWLBAISJpaNic4V3b3J8eWSL55JGH+xxmksMU2ftyR/mzERm5AgiTlPwfuIZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ6uu+OKxktc/rVteoDNcnFi5Nf5ICAl62T39fw1lB4=;
 b=vK/Tkv7AkrmKgLjSU5D4+nDkwEoX9YYG6AJVR/UCCh4FNLdeAHI/BYhEU16RSkh6XuDIBdFiT9ah54yIt0EDxZQVa4pwg6qRj+mchJ5XT+UemVbCrEa3w8KdflLGB+/uCmTC4Q2Th2s8VhefDpWXivUi6U552B5d+n9rMcoF4vw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5242.eurprd08.prod.outlook.com (10.255.18.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 11:45:25 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:45:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 01/22] blockdev: Allow external snapshots everywhere
Thread-Topic: [PATCH 01/22] blockdev: Allow external snapshots everywhere
Thread-Index: AQHVb8piyCNjVghvNEuKJp3kSoS5SKc8TdUA
Date: Wed, 25 Sep 2019 11:45:24 +0000
Message-ID: <7c50e29a-7d41-b186-7777-85bbd4fb8b8b@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-2-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0241.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925144520925
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb873ed-2e5d-4a5a-5b80-08d741adda88
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5242; 
x-ms-traffictypediagnostic: DB8PR08MB5242:
x-microsoft-antispam-prvs: <DB8PR08MB5242003643FDC394304EACA0C1870@DB8PR08MB5242.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(346002)(136003)(376002)(189003)(199004)(229853002)(256004)(54906003)(110136005)(25786009)(31686004)(486006)(4744005)(2616005)(446003)(11346002)(476003)(86362001)(5660300002)(99286004)(6116002)(76176011)(52116002)(3846002)(36756003)(316002)(386003)(6506007)(102836004)(478600001)(66446008)(2906002)(14454004)(64756008)(66556008)(66476007)(66946007)(71200400001)(26005)(31696002)(8936002)(8676002)(2501003)(186003)(6436002)(6246003)(81156014)(81166006)(66066001)(6486002)(4326008)(7736002)(6512007)(71190400001)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5242;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UqyAw1Ka+7wHOsVoT+93sQrKq7YMzHRqJn1VUvckpq0rGxeE9VtzKlicH4tzl83ggZh+ZoXEC6ZI9OY1BLWNFFGk5trDU3RzM2RQGV3HNHKM9bQQ5hpPVX9fv0sT1y8kN/zMczzb73C1XWNn0ZEJrgj46ZXnD00MsUrUkSWpuqdIi4DtkrOpf9UeuzKoMQ6ig59/hCcTPaHtajKOjVX3t8XoWSdFrX0QPVXvlZ5aOTJ6NKSpYL2sLOFAjWnlaZI1SujFrGZsYRv84ZKk1/r2xQPk/jGYX7EUrqaubDEzxpkBKPvZ33SJLiR37gd07wCvfoH0OZd9SZGjIjrfJQo2F7ZZhuz4ftABfNvLHRLDkrCMSrGokHNjbcpaLhAS0KO6d1EhhTfGEAExsGClVnSNUinOx14GKcF8KT2qhGZPq0Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5230B25E3514224697200CFD147E66AE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb873ed-2e5d-4a5a-5b80-08d741adda88
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:45:24.9462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TDupKOs54unNnLF5afbir79IiZjfd7OV/lSJg/uwKlZdjHVhUEykH43c82UtNv8BE8gJxV/JKyKLepaRR4BF9jzOuOUQQuGtE7tTAKEYbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5242
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::703
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

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGVyZSBpcyBubyBnb29kIHJl
YXNvbiB3aHkgd2Ugd291bGQgYWxsb3cgZXh0ZXJuYWwgc25hcHNob3RzIG9ubHkgb24NCj4gdGhl
IGZpcnN0IG5vbi1maWx0ZXIgbm9kZSBpbiBhIGNoYWluLiAgUGFyZW50IEJEU3Mgc2hvdWxkIG5v
dCBjYXJlDQo+IHdoZXRoZXIgdGhlaXIgY2hpbGQgaXMgcmVwbGFjZWQgYnkgYSBzbmFwc2hvdC4g
IChJZiB0aGV5IGRvIGNhcmUsIHRoZXkNCj4gc2hvdWxkIGFubm91bmNlIHRoYXQgdmlhIGZyZWV6
aW5nIHRoZSBjaGFpbiwgd2hpY2ggaXMgY2hlY2tlZCBpbg0KPiBiZHJ2X2FwcGVuZCgpIHRocm91
Z2ggYmRydl9zZXRfYmFja2luZ19oZCgpLikNCj4gDQo+IEJlZm9yZSB3ZSBoYWQgYmRydl9pc19m
aXJzdF9ub25fZmlsdGVyKCkgaGVyZSAoc2luY2UgMjEyYTVhOGYwOTUpLCB0aGVyZQ0KPiB3YXMg
YSBzcGVjaWFsIGZ1bmN0aW9uIGJkcnZfY2hlY2tfZXh0X3NuYXBzaG90KCkgdGhhdCBhbGxvd2Vk
IHNuYXBzaG90cw0KPiBieSBkZWZhdWx0LCBidXQgYmxvY2sgZHJpdmVycyBjb3VsZCBvdmVycmlk
ZSB0aGlzLiAgT25seSBibGt2ZXJpZnkgZGlkDQo+IHNvLCBob3dldmVyLg0KPiANCj4gSXQgaXMg
bm90IGNsZWFyIHRvIG1lIHdoeSBibGt2ZXJpZnkgd291bGQgZG8gc287IG1heWJlIGp1c3Qgc28g
dGhhdCB0aGUNCj4gdGVzdGVlIGJsb2NrIGRyaXZlciB3b3VsZCBub3QgYmUgcmVwbGFjZWQuICBU
aGUgaW50cm9kdWNpbmcgY29tbWl0DQo+IGY2MTg2ZjQ5ZTJjIGRvZXMgbm90IGV4cGxhaW4gd2h5
LiAgTWF5YmUgYmVjYXVzZSAwOGIyNGNmZTM3NiB3b3VsZCBoYXZlDQo+IGJlZW4gdGhlIGNvcnJl
Y3Qgc29sdXRpb24/ICAoV2hpY2ggYWRkcyBhIC5zdXBwb3J0c19iYWNraW5nIGNoZWNrLikNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0ejxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

