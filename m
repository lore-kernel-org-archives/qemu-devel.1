Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2843206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="St4PR9uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2843206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRJ9-0000PR-0j
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRII-0007n9-6E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRIH-0001lb-8S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:49:22 -0500
Received: from mail-eopbgr50132.outbound.protection.outlook.com
 ([40.107.5.132]:46709 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXRIH-0001lO-0D; Wed, 20 Nov 2019 09:49:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvO7axwbhSaE0vYl2tlWXtUCKSNOKSuD3f9SHWi4KgV/LSeaRPSKZL7L5JrGOxBkUfGY5YFhJmxYNOMq+V8fXBvZr0qje7C9wRiLn+5ft6z7rQPMYBb3fBOYkpqMI9QM3HVl1yMCzMdHr1eWfR7LxEII+nkWXqEwPq6wvLEetFQOIQZJKuaGKwWKSVsLXYGf9rBO67jFu4UXeBikKRiC5IKyWl114Xf5zcBLuQXHVDqLb+UKjLJjUiuEqFuYXyu/+DzCu4hXghBZDGAo0Kq7KLBlCrkZ0/DyYgN0ZuyzFvck1laPUJi1LGtsb0EsiK28hqzB8qeWASM0y8aaP8ge6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWYjQzWtyriTGk76aLwwcIhmRXx8LlHzd7t9hiTp1mA=;
 b=ZDDL+NjyswwwHd+lwFokonaKzEiasUju88Q7f7AyVMU7JmXEYolUhMtqk+fLvXQaAA4Qu4Qi/8ML/zHvxJmsqL3I+YG66gKcBIf81CfnIrXlvcs4d5G5DMgSg0lc7pFGUPBHvapOAURy+Q8ubB1snnnMGrwYuhteVdIVhKgIX9syfRH7VpHEcQj/qSw7z/bJEzwrLUg1Yups0pE1HyO+Q1TW/zDDySaBia/ICU4N+JiyRJZLbEF+Q0mvANn+7PnWZIXJp5fNyoSgdX7HzWnkjcjoqtwjFBjkQsacPjN6xxLRe55J3BdDwgobdEX9+5TYUMXxb1iQR8AV1fcEjiT+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWYjQzWtyriTGk76aLwwcIhmRXx8LlHzd7t9hiTp1mA=;
 b=St4PR9ukLmm6h79u5AMECBg1azON63/qq9boulF3np0e7ySn2/1FAh15R69hpQnKhynObgeeNr9BWVypTVnrzlqaI/bUFbCONwwIkTiARQ9AAEFC8FiMFh40xrs9BtjpI5p2VVyMFo78h1EJzBsCyGnecUEVfr+rINiF6vMbpTE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4215.eurprd08.prod.outlook.com (20.178.91.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 14:49:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:49:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/6] iotests: Add qemu_io_log()
Thread-Topic: [PATCH 3/6] iotests: Add qemu_io_log()
Thread-Index: AQHVn6tajVoPkANQg0ygdJ5UcnEcJaeUJAUA
Date: Wed, 20 Nov 2019 14:49:18 +0000
Message-ID: <bd69d2d5-dfc3-20c8-9773-40b4fe5b6324@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-4-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-4-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:7:67::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120174916610
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ef6f13e-4096-4558-ef86-08d76dc8d22c
x-ms-traffictypediagnostic: AM6PR08MB4215:
x-microsoft-antispam-prvs: <AM6PR08MB42154664544D46925D5C2A7FC14F0@AM6PR08MB4215.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(366004)(376002)(136003)(189003)(199004)(110136005)(8676002)(386003)(6506007)(81156014)(54906003)(102836004)(81166006)(478600001)(66066001)(6486002)(229853002)(476003)(99286004)(8936002)(6436002)(25786009)(14454004)(2906002)(36756003)(7736002)(486006)(31686004)(186003)(31696002)(2501003)(64756008)(66446008)(66556008)(66476007)(66946007)(256004)(26005)(316002)(558084003)(3846002)(6116002)(52116002)(5660300002)(446003)(305945005)(71200400001)(2616005)(11346002)(76176011)(71190400001)(86362001)(6246003)(6512007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4215;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YvBjudQ6shBJyhyrfT2NOr0XGJQ9mFwpriISPDhH3izxQ6D/w1G30jpHzFws68tl84QYYJKzVodP50bvTjxFOIb9BVvQ3v6P4F/yxrhYbpSAREmdEzV9saoyCHc1OqvGFyEpRsNsoo/AaTOvNQfhTaopYhBoYfK1d48tnFqsuKdOjMDN9fwwPQcC5oCAL08l5dvyHySykCHwxfF4XDxidEQ86sP01PJJd6LPfdrQ7bu6XqVn8BRykcqrr081ROETuUmHie2RM2bAwl0GEOd1wOdd4yYGamtaicg75hY5a3RoqFo3ASSnZxvUhq28HT1QFnexzGJpMauUAt8fxrgQ4+15Cdw8leNwNtMfOI8rSvEfURghiwY6j/eydba6Xsvy797fOlR7wu2BZXCmavdKcC5Msye4lRd7T7JSkKL6U2jquwEKkOAEs5pBTLR6ZQW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5879A4DDC93CD34CB4E68B6A7ABEC737@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef6f13e-4096-4558-ef86-08d76dc8d22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:49:18.4830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShLoiuCmU8uSRkAewKo71BnicldEe3dGG1BpqLgfCqjQDRV78A5ZVnbh04GsYk2swDr9OieDy85Z1yUBMFuKDwQaliZP0svAcii2QzhbxzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4215
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.132
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
> Add a function that runs qemu-io and logs the output with the
> appropriate filters applied.
>=20
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

