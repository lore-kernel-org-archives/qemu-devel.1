Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA189206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ViwYYmGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA189206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRKp-0002Wa-U1
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRK2-0001kh-LM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRK1-0002Sz-OQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:51:10 -0500
Received: from mail-eopbgr30136.outbound.protection.outlook.com
 ([40.107.3.136]:35750 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXRK1-0002SM-IC; Wed, 20 Nov 2019 09:51:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+zrGCQWNBkS44UQweoSwhVo4khhN1DhEAxmh2qKlfX7NMgjMcdGx0jGR5frt1/nTwogERHKlqjFNDncKX+kwZDec74yW6BpPcZGWPPbVxElXVrJ+O/5v/lO/x7fZuaFpAdHYiZ5lS5yQ844fSLm1V7LpOp5Z92EwHiHojmDxsoZXn48W0qwTze2Tt3w9q5et1RIluO88qH8Q5JpJNFCiZ5vo2rMhnTxTpOUY2g+oVv9TQeYBI3dKICW838Zn53LUYjB7Yz7Sf73lHLkOCpEfXu6/px1cC894PTbPcc+C116dqqDIpwBolDgJ3Sp0hlPwuCf3LiIqIldTJmV9Qb9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THOeHyrqfJhPdoansE7cetBpOz8Bba4xWQOMBlCjjVk=;
 b=X/X2LgI+lto59a1j5w1eyUkbgkd7nv19phKuEO71jN8TwtQs6tQvuJOOjdYSy8kpLpn9VitBG+tYRwakt7rfb5pXA6XaAxR19Z1udpRsEp+C4YGcmomszyn65HLaQ0ISkltu13z0QvnkaY/HVscmBNOOtE7mri/m+lQ/h/OGnq992naaPfucfvwoZHbSkQo9dhZYBPx1dVEiZIxMSmEtUwAdcY+qBRR/burCFe9D7W31mOAWtqKmuSR+k4zndO1eWJ8RwS80Fr8OwXsRfIl/xyYbnZhouwJlQZ3PdYU42Lb7ztCs5RxuTg6DdPG6q0WWal/hW4VGAJprEVFEuSYelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THOeHyrqfJhPdoansE7cetBpOz8Bba4xWQOMBlCjjVk=;
 b=ViwYYmGO4lvAPIeqJqhW8aVCGeDVS5t5hR7IHoLGqMX69qs+mO3a7jO3G19n5ZB08Z9LYsB21HZGWqXVDWfQweKfHfjft/EZFbsNebEjIvJup7CHTvWpHcoR1eOWDj/FCytF8nT5tc53xWbg7HGTl5ftlowX6wiXh1iZuiUveKE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3127.eurprd08.prod.outlook.com (52.135.162.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 14:51:07 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:51:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 4/6] iotests: Fix timeout in run_job()
Thread-Topic: [PATCH 4/6] iotests: Fix timeout in run_job()
Thread-Index: AQHVn6taAcZI9MWJg0eOlSLbLcHrhKeUJIeA
Date: Wed, 20 Nov 2019 14:51:07 +0000
Message-ID: <07d82471-6499-ba37-3925-4a28cf91ab9b@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-5-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-5-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0087.eurprd07.prod.outlook.com
 (2603:10a6:3:64::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120175105613
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b1321a4-4ef2-4220-7fc7-08d76dc91332
x-ms-traffictypediagnostic: AM6PR08MB3127:
x-microsoft-antispam-prvs: <AM6PR08MB31279CCC80786A315BA77EFFC14F0@AM6PR08MB3127.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(189003)(199004)(71190400001)(71200400001)(2906002)(229853002)(66066001)(6436002)(4326008)(31696002)(86362001)(6246003)(66446008)(64756008)(66946007)(99286004)(66556008)(8676002)(66476007)(81156014)(6116002)(3846002)(36756003)(5660300002)(478600001)(2501003)(476003)(2616005)(305945005)(7736002)(446003)(11346002)(486006)(26005)(6486002)(8936002)(31686004)(558084003)(102836004)(6506007)(386003)(256004)(81166006)(6512007)(52116002)(14454004)(54906003)(110136005)(76176011)(25786009)(186003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3127;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXOzD8TqJWxQukSkI6EDI371RdN77mfiEf5+4N7aG1D5iaoyVZ248M5SVzz2/AQbta3x0+d/UZYla8JSYtQpTyfHT9Mn+40vNk8ofNbT4P/Rgnog3ibH623ZM4AJfr7+MRbxDefl+1k6TnF6zH6rufPceVxoSoMetAAs6H6+SXXMXWeHVfmNUhPc8rH/yw+6PCMpJJnIe0TlDgYrOEisO/A5d0co2Y++a9RzimHTrYkZm4FebsaU7DYDwEwqlN9ZlT+4Qo0ArYJ7256vrt1yJrN+IWaQ+J13J+oNNjFYK7sbYnhEdZB9iryXwMTkDrQOrlGYnqmNjtD8BiCljvXyzBpoqibNaucZ4rEsW842uUIA21YVqB3M2wpnhKce084nu6sCEh7chM+TCl444UM1pGc2K4QsXQjpJDinGYW/DSO2OH9W5VW3TlDGpKRZKz93
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B1F9CDF14A758340BC2F42E4A999B317@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1321a4-4ef2-4220-7fc7-08d76dc91332
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:51:07.5564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8koL9uLmdXzl5gDOUC0fY+TPHLV/Jc57mnJVS2lGhZwsDUeyxsgzEvazA7J8pL7p/GMeAKVQzOSgVpLF+EuiKuSOOezBXnJyYgmsgQSR1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3127
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.136
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 17:03, Kevin Wolf wrote:
> run_job() accepts a wait parameter for a timeout, but it doesn't
> actually use it. The only thing that is missing is passing it to
> events_wait(), so do that now.
>=20
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

