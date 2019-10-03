Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B8C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DB02133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l2NzmsZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DB02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2xU-0001G4-Q3
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2vi-000096-Ii
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2vO-0003QP-Ef
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:22:10 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:46048 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2vO-0003Pp-8H; Thu, 03 Oct 2019 11:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN6XXLTZHaROcOn07l/viV234TKhTCIpDaPGGDSnSFTAYOQ/NevZR2pSGw2hrKQS64JH2M9R0BOhLGH9JuqtnlHy8FIrKHrntYdAVHCoTh7HgeoHow2/fpoliwqnrDBWfeYFAon2SxELZ6Zea9/QsSXnpt042Rflaj/XqgNSjHXlGnRAIdzlj5IgLeRNxjxZ0ZJ59FcRLCjZGALWlTDgPS9keGSYGIuP000OIeHj0qktk+LYcSUaFxHQezNlexuldDymp2m8fAEw3if51MRs5eesth588HKaYef9XQ6IkEGuVOhC69aFUKuzWVOb2JjI9uak4Au3Qusn761e7e34Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXAaKSNKPDxkhcLqa9MqqFoIDpIg652JT9I6TIR9la8=;
 b=i5YHg9PTwMht7X4Prqq900PwOpSg6lz8uw3DiLZ7/TwSjQE6yN/CZQvH9LFNmi8bzXPZRNjqi8WRNrp9hL/Pcz1zPWByZEZUGkdKT8Y0w5LsEMQNuqoz7xs6m5m+fg/84MM4u+f7b/+I/+6F7lF4Qm75sYy7MvTg/Vqo4E4RIa404lfmsH9hQqg/VIPuJ2L/tQClGjw6Xc9szew+97f5UqT/sslAdhP14jO6/65Yl16pVCoh645fsm17sj343C9gs/CgKtdceI9LoznUdwsOe8oApO1KMaQcYBvKgShLWSu+a3B7qRB5VGDD+Fz5kuvUQEZwLmTCQJgAOKw70RqGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXAaKSNKPDxkhcLqa9MqqFoIDpIg652JT9I6TIR9la8=;
 b=l2NzmsZS2TisgTnqX+8vCddfOMKZ3X4NB7UQUYKnnfpHWISO34/H8VR5HzbfqJ/zGc68X1l39/dQNjS8RNGEm7FhndgONyLXlmeo+sqiJV+kwnSAm1JzYD9Mhe08XnDHkX4gzr+1uW99h1IZ7rKJ7YXYED5ua/DabvvLDLc307c=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5515.eurprd08.prod.outlook.com (52.133.243.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 15:21:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:21:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 03/67] iotests.py: Add unsupported_imgopts
Thread-Topic: [PATCH 03/67] iotests.py: Add unsupported_imgopts
Thread-Index: AQHVeJMDYeoT1SlOuUOXjPlTbQ+bdqdJC2KA
Date: Thu, 3 Oct 2019 15:21:47 +0000
Message-ID: <0a408ce2-f94c-3874-2dc8-f66f0c5e0bde@virtuozzo.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-4-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003182145775
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b5062c-7f76-446d-1021-08d748156832
x-ms-traffictypediagnostic: DB8PR08MB5515:
x-microsoft-antispam-prvs: <DB8PR08MB55158663C7078F814B5E8B29C19F0@DB8PR08MB5515.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(396003)(376002)(346002)(39840400004)(189003)(199004)(386003)(6506007)(86362001)(478600001)(14454004)(305945005)(256004)(76176011)(102836004)(25786009)(52116002)(14444005)(31686004)(316002)(7736002)(71200400001)(71190400001)(26005)(31696002)(36756003)(99286004)(54906003)(186003)(4326008)(110136005)(5660300002)(6246003)(6512007)(66476007)(66556008)(66946007)(11346002)(229853002)(6436002)(3846002)(64756008)(66446008)(6116002)(6486002)(2616005)(8936002)(2501003)(81156014)(8676002)(66066001)(476003)(81166006)(2906002)(486006)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5515;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tyxiiubqCfWjs+1QzIOqbfx8y0U9cp/k0dYBf9trddnEngI4sotdQAUSEpiDgBu5qeMJ0cPiFgcmHUwzJShBobFnsAWtP7weF/HJG7IqtaoKmE0bGtUpRZeLSV6ejv+FUbJlCwXhsgTbL6JPcHRjx071cRNqWmSJWNuU3jAkH3OS9RPSf0Cge0QPAImLDK5kwAqfDF3dm3q/vdf3HVNwYs1DFlU+bM3dalF6ZzKxoLzR/Mbbm1Xq4xnz2dlnBHf9fv5xtq1of152KSthRbHce0NbBQJ/qy0LthKe95pgj3pGgJzc+Av/S8YLl4cTWKh5I6bZD0fkQXW1XWeKdnwXEXRMI9Fbj/BrLxD6ISR9IrIymspXOVWP0DX6dklnzJgQ+EtQHxyslRNMoNxd5uuM/jDJVp9Mw2e5RbmN9QTN0g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C6792C5E833BA4CA23B53F88D03BC0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5062c-7f76-446d-1021-08d748156832
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:21:47.7520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFy29TOXDb/iS7sR7unHBJDqeamhaxjuTugwmn3QHaqJgw9tg7VhksU9SWNOG/b36gxInCDDwlCwqOeCwtkXUL4Ok7Abz4ciCtFu2erCG1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5515
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.96
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAyMjo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weSB8IDcgKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IGluZGV4IGNkY2I2
MmM0YWMuLmI1ZWE0MjRkZTQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rl
c3RzLnB5DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IEBAIC05OTgs
NyArOTk4LDggQEAgZGVmIGV4ZWN1dGVfc2V0dXBfY29tbW9uKHN1cHBvcnRlZF9mbXRzPVtdLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRfY2FjaGVfbW9kZXM9W10sDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc3VwcG9ydGVkX2ZtdHM9W10sDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN1cHBvcnRlZF9wcm90b2NvbHM9W10sDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zdXBwb3J0ZWRfcHJvdG9jb2xzPVtdKToNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnN1cHBvcnRlZF9wcm90b2NvbHM9W10sDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zdXBwb3J0ZWRfaW1nb3B0cz1bXSk6DQo+ICAgICAgICIiIg0KPiAg
ICAgICBQZXJmb3JtIG5lY2Vzc2FyeSBzZXR1cCBmb3IgZWl0aGVyIHNjcmlwdC1zdHlsZSBvciB1
bml0dGVzdC1zdHlsZSB0ZXN0cy4NCj4gICAgICAgIiIiDQo+IEBAIC0xMDE2LDYgKzEwMTcsMTAg
QEAgZGVmIGV4ZWN1dGVfc2V0dXBfY29tbW9uKHN1cHBvcnRlZF9mbXRzPVtdLA0KPiAgICAgICB2
ZXJpZnlfcGxhdGZvcm0oc3VwcG9ydGVkPXN1cHBvcnRlZF9wbGF0Zm9ybXMpDQo+ICAgICAgIHZl
cmlmeV9jYWNoZV9tb2RlKHN1cHBvcnRlZF9jYWNoZV9tb2RlcykNCj4gICANCj4gKyAgICBmb3Ig
b3B0IGluIGltZ29wdHM6DQo+ICsgICAgICAgIGlmIGFueSh1bnN1cHBvcnRlZCBpbiBvcHQgZm9y
IHVuc3VwcG9ydGVkIGluIHVuc3VwcG9ydGVkX2ltZ29wdHMpOg0KPiArICAgICAgICAgICAgbm90
cnVuKCdub3Qgc3VpdGFibGUgZm9yIHRoaXMgb3B0aW9uOiAlcycgJSBvcHQpDQo+ICsNCg0Kc2Ft
ZSBzdWdnZXN0aW9uDQoNCj4gICAgICAgZGVidWcgPSAnLWQnIGluIHN5cy5hcmd2DQo+ICAgICAg
IGlmIGRlYnVnOg0KPiAgICAgICAgICAgc3lzLmFyZ3YucmVtb3ZlKCctZCcpDQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

