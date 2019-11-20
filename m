Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB2CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADB020692
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="veU9vp6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADB020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXR30-0000jL-4S
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQxV-0004ve-S6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQxU-0002zp-Kz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:27:53 -0500
Received: from mail-eopbgr50133.outbound.protection.outlook.com
 ([40.107.5.133]:32262 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXQxT-0002yY-UY; Wed, 20 Nov 2019 09:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5s1fLK6f+sXk2ax2vN0aY0+l9cw4GRidEypdB7dbxJLR5nMX/cv6E3gb29J4q+3i1K7032fd3Y37BbDOS/IgS4dQnWYszYyMNg+KIvvyaHYKfc7LzlseFZXrLibEVKtZoBJyiMP3owB19wqsfK8zZmzdCbgrtnNVTHR3/p41Kmw+vIGGxnWnRqE4IbTmGP5t1oEAMh6CcHy6RMbuzMSdZoTCknH0wLFk5Ib26lmuMNXlRjeTuM2SMDFCHnbFqOte4iCzGPv0bvCCF0ivBcKVsDoJEz0v7ph6Jr4CYDsxUH5n2CQRlrh/FLc4tPGMIpp+ycqaAtLKdsk1k8tynbdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw3H9ZZP3tVjElQu8qz3sfKIFB31cFjcGbfwqGsUJWo=;
 b=FocpCl9wiZmUDDuv2mXMdXKa/vsgcLMPc114ATjeH8piEAbfJAY77a1AiF7yYA6adnKXRpxDkZ4XSVd7Lc6KprX6jxgFKr8Q7jErkhjsR6EQocI18wQH/n0NQ+PqXH5ezWUQachyClKlFMuoGU4EaggutSrNakIgmWQfN/ObNi4BT78DcK5sh52PmkH9GE4xgfrdbO3waTEThzTkqLsRAIbbsyNC7DO1GtNx2a49upwP7jWAibQPWy8KQMPFxLJLHvPD8qHucJFHzykHX3VhFdVY9WjoziRssH3IrZgijuuRO4Vsa6I3udClzRWIcwnamduy+h/jOk423FqAybl6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw3H9ZZP3tVjElQu8qz3sfKIFB31cFjcGbfwqGsUJWo=;
 b=veU9vp6l8fJpupzkhBU1l5o6yF5Ob3akQ40HGLe05IP8tItKeWnERTceoCdvAlsQqsop9BYDyShLlKhrtFoqb5obgHtVDw8Ua+8VK9mwZd8nop6MeCSR8Ji+5xeW/cGbdoEYXjjbyJP4CWokjqka8KJeqYkXxsutNDkPbjVNAqA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5207.eurprd08.prod.outlook.com (10.255.122.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 14:27:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:27:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 1/6] block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes'
 parameter
Thread-Topic: [PATCH 1/6] block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes'
 parameter
Thread-Index: AQHVn6tWCoN06Rr8pECE+XALnO9chqeUHgQA
Date: Wed, 20 Nov 2019 14:27:48 +0000
Message-ID: <2d60d49c-12c8-dee5-aa0c-7b67810effd0@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-2-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-2-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0009.eurprd03.prod.outlook.com
 (2603:10a6:3:76::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120172746844
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e0405d-9f03-478f-f116-08d76dc5d177
x-ms-traffictypediagnostic: AM6PR08MB5207:
x-microsoft-antispam-prvs: <AM6PR08MB520747B961E038CFCADFAE5BC14F0@AM6PR08MB5207.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(366004)(376002)(396003)(136003)(199004)(189003)(86362001)(4326008)(99286004)(31686004)(102836004)(81156014)(71190400001)(6246003)(81166006)(6436002)(2501003)(5660300002)(4744005)(229853002)(476003)(11346002)(26005)(2616005)(66946007)(71200400001)(6512007)(186003)(36756003)(76176011)(66066001)(8936002)(446003)(2906002)(486006)(478600001)(316002)(110136005)(54906003)(8676002)(386003)(31696002)(14444005)(256004)(6506007)(3846002)(66446008)(64756008)(66556008)(66476007)(6486002)(14454004)(52116002)(7736002)(6116002)(305945005)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5207;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HL3nuH8CkBrPrgEiK5m3TcUF19v5Ep+lA5lcuKbO+UTi5Z1gfL/wfj1ocAMWAYs0qBXkv9tycMAyt4T5fIaqWNkg6qTgkez9p96096/LO5vtBZ4cCFtKP0IFCWNLRjUwIVAVGZtQWPjEydW0ZXawEUSJhupzuhxq3OKuzTVwrNWGpgP+XV6XBRCEGSuXZQV2LmKk2zXK+K/E5nWm5KJKts3VMwuzWkZOcCBJz+4Cj+Nt715BGbKKE0EoLhKXSSxmCH6aowIBH99HOIx2jBj3OzMr8bmi9p32LamT8miN9W106E/kbf/SNagcxdbsrkKkzErJXLCaAsldzsFgVk7xIjBHiBZiqC4GVrCvAMPbEopXAd8nSJJvdG3OsdECNMm/wLEC7lDt8Zo/Ob0jXzFMqymzcBPiKrdUXUCBwP8qs7guwcUcDSJkTdbLoTEmdq50
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <336FB0E67DEDA342AEA1D890E80BAB6B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0405d-9f03-478f-f116-08d76dc5d177
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:27:48.8127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vv/hTW2hMweKP91Sllqe/LPbdyhrY6LU+/nkn7lw/EiK3SQBeYctQzwoYBDEpAlqBZ4b7fmXiLxEIbAQ25k9qxGNNajQaOoNZE0K95Rl//8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.133
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
> bdrv_co_do_pwrite_zeroes() can already cope with maximum request sizes
> by calling the driver in a loop until everything is done. Make the small
> remaining change that is necessary to let it accept a 64 bit byte count.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



--=20
Best regards,
Vladimir

