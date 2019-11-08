Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE878C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F8B21882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SVXu3mb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F8B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6I6-0005qR-GO
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT62W-0004ro-GB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT62V-0004SP-1r
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:19:07 -0500
Received: from mail-am5eur02on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::70f]:12990
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT62U-0004RM-E3; Fri, 08 Nov 2019 10:19:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5e//UB3mZsznpwK6kM5A1MAtJCLO/Tv3CLUq0QRBWRp/vWBQNQKr8+RvO/O0g3rV6nd4IKXfCv108csw06O53/yB5YfeLPxjnu5YvnYmwNcbK0W9ul8C46R3/icMyqFG9wrfz124xd0MdNoFtNz+by67iuGQKviJk6Y1gRggG++l0fInC28hrMLFpucE2tFaGuPhFLW4DN5llixH0vKjf7NgnDB3KiQaYm1nAymmLCKPDoWBZsECpyyaLI2bFipx7supRe90J7gUBTHdXPDCWoOf5aY/AycEzaMQ7ziU6Tj69Q1YdoNDm8bvMVHr6zjmFQn89YdMxgBVZXug2GSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMZCXZFf8efRwxO6D8q3hkvo32Adv9wECSvihmaZP7Y=;
 b=kQnhQMicNfqPPS8JnBhvS/+fULUk8wgZJbq9U47CQyG4EVPo2AQexEh0cOGETfuU+GHMeCNZD1StAZwJ8qoJuktWcuHf75NtfHUHSpB94w8lHqz92OmqMFjSr0lmUh3n238iccXmHseLyXrMzEdW9lvd9PLGaZE56GUi8y5pUDr5IWB+Vqx+QFcTYnwo0hkVKYFVdcm5xsvUbdFA9hvZFhMm/4CYeK5OJ21EvDi9sDoBo2c+9nuDUvCvbAk9dIaphkk33CQbgDYJBcUJm+MhCPr2gbgSw9i5uCCMaRdHugLXcr94m0HmygyjnBhc01Z2MkWXuedZrvq1QHq1/ZxjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMZCXZFf8efRwxO6D8q3hkvo32Adv9wECSvihmaZP7Y=;
 b=SVXu3mb1qFh103d/VeXj1uI/QDwGwJncNCpiVWXvFPU/eLjKNW3Kiw8xFczG2kf81iulpdkDOcVWiVoeFC+XiGTQyiUytenzb36CeWFxVNwg2Ida0IA/oezKMmuuA4mO5TLRwVDFawljSlY2frJjTi0BICzQAm1hLcHqQvcLV0s=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4387.eurprd08.prod.outlook.com (20.179.34.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 15:19:03 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 15:19:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v4 3/5] blkdebug: Allow taking/unsharing
 permissions
Thread-Topic: [PATCH for-5.0 v4 3/5] blkdebug: Allow taking/unsharing
 permissions
Thread-Index: AQHVljD7SkOSvIdoi0mJPCUs+csIR6eBY1CA
Date: Fri, 8 Nov 2019 15:19:03 +0000
Message-ID: <d1d2d944-4829-45e4-2515-251122833022@virtuozzo.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
 <20191108123455.39445-4-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108181900996
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a6f55f9-d5f7-4619-6b31-08d7645efcf0
x-ms-traffictypediagnostic: AM0PR08MB4387:
x-microsoft-antispam-prvs: <AM0PR08MB43872204138FAE49E981E546C17B0@AM0PR08MB4387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(346002)(366004)(376002)(136003)(189003)(199004)(305945005)(256004)(99286004)(229853002)(5660300002)(54906003)(3846002)(6436002)(6486002)(86362001)(26005)(71200400001)(316002)(6116002)(71190400001)(110136005)(14454004)(2501003)(66066001)(2616005)(66446008)(6246003)(66476007)(66946007)(25786009)(36756003)(102836004)(66556008)(81166006)(4744005)(6512007)(81156014)(486006)(8936002)(31686004)(446003)(64756008)(11346002)(478600001)(4326008)(186003)(7736002)(31696002)(8676002)(52116002)(386003)(6506007)(476003)(76176011)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4387;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: naQG83cma38uru5aYo5Norps5lkoZdNI6Bq/7QqiXAIE3IwfACQVNk75wRYmRkyNI4OuTYVdc8lOiq3M9pBx5udK7RjcoyH5ApBh3SalZJldEmFLPxGMk5kLHbNzUdLZGPzIZFEXErEN4sK45nSQ+ribKu+xPb6UA7VO0DiHK1aoUXOFnPzJus23GCv0Rw51M+aLa45507e4K5IrCzqeghxnXRyhZv/HDFYbXV3vUe1OISHq9ZzsVrAIkTVSfsAE3cHJtY/iq3Xddc28ysZqTnZJe2WC8C3dKLQECqjb08FohgINlxY0datdny7qQNvDgHiVl1fV+H5TRPrL77Tq5nHdGfC8R8zY/Efu1PtJqO6bdO5ex85/KLc28WrDdEP1vSFytR8wSqg+r5icqXWuQbwbqwGwrRTxfIrxgTq0k8v45AA84lPl57b0fx8pR03w
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <71CE55F02DE5F449BF85F4530317823F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6f55f9-d5f7-4619-6b31-08d7645efcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 15:19:03.0871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRkTAS3w1p4chrNh1ZutbfvfRd0ll0FdAmb6mUsDgjWH5ncBZxSoGU4OFxVwxhgoA6JcG9ATLBq/Yj/+Efu+zlA9HKoDzY1ZUgENJkmhM2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::70f
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

08.11.2019 15:34, Max Reitz wrote:
> Sometimes it is useful to be able to add a node to the block graph that
> takes or unshare a certain set of permissions for debugging purposes.
> This patch adds this capability to blkdebug.
>=20
> (Note that you cannot make blkdebug release or share permissions that it
> needs to take or cannot share, because this might result in assertion
> failures in the block layer.  But if the blkdebug node has no parents,
> it will not take any permissions and share everything by default, so you
> can then freely choose what permissions to take and share.)
>=20
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

