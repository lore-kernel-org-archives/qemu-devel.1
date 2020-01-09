Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932FC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E662067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HBHMtshI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipW0W-0002Vh-W3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ipVzk-00025R-9f
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ipVzi-00083L-Un
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:28:55 -0500
Received: from mail-db8eur05on2128.outbound.protection.outlook.com
 ([40.107.20.128]:9185 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ipVzi-0007sA-3W; Thu, 09 Jan 2020 06:28:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffsqD5ioIPObqZg5V43zosEr2dIzHrJlyTvUHE7+37phWmk1Pqz5XZWcKlW5Q8CyU0pWu1Y7vQbhwgNmV1BmsSRJu+cgr0QT1RVHfzvShgwpKHVw3drgsQCEuiPqMrV8eEa9oE70hJ/Cg0sAlwtGaRnp6/uunFpdduAv2BYSCUvf3S/Ix/ORPALZ+eNmbPzT5rypoweMef8uCoDjxcini7QjDXFeMRot7myJIjofBh+PYHoFuTzIPtkIWchHiLi5R6mIDASQSVp+mPAb4vGqsBmOLrdwaYKNTwiky2AOH1h2kNO091SGSfDo4Qtsw5IN09D/TGRsgjZzfQZ1fvpTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQoesdx/ru8GDE/W38s8vWpR7k6+DJWjGCgJLegiyU=;
 b=UzugcP9PUqFEYMhXVQfo8v/hmRFm0Y3lGO7gqI7erP7HwM4pCEpVdgwQYohSBIJwNn0tpfjryz1LKMvbODwIEJ+QkDbhmNl1es42/mscBGzKJHp6b0+2RC6TQooyh01+kjVtBCU4M0lAhvpSIYQDVbz3OMMLpRTFmRKR2ULlF2+u7BTn8i2Dgejvc/vcDI0InfgrAWQ4Q842Syphd7i+orv6lIwYb8PW0HoG/ofMfdGnYP+VNn3FiNESANmS5t48aQHvSaRjqMVeAfTwveNBedv+S3PUUClT4M5u2LdF4T/oNq0dAGacMb71eK+cBXD/70oKQzcLCElVb5spnaMB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQoesdx/ru8GDE/W38s8vWpR7k6+DJWjGCgJLegiyU=;
 b=HBHMtshIrJ/ARfc+qxVrSelzcA1/BFuoomFEInpTk/JiR62CIDEOfAn4Fs0ga4iUhs5MJH/z0tf9EtUEEZJ1XArmWjG1Lq7KLX53SOM91KXFswcmTaNOkqmKZv+NPjHFr6zjWskosS/V646nQT3oZz/lvm6rJ4xRAf9e39tEmDU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4485.eurprd08.prod.outlook.com (20.179.7.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 9 Jan 2020 11:28:51 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 11:28:51 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0046.eurprd09.prod.outlook.com (2603:10a6:7:15::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 9 Jan 2020 11:28:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] nbd/server: improve nbd_negotiate_send_rep_list
Thread-Topic: [PATCH] nbd/server: improve nbd_negotiate_send_rep_list
Thread-Index: AQHVu8SmozQasVpF6keJrgN7HoVyoqff1GkAgAJz+oA=
Date: Thu, 9 Jan 2020 11:28:51 +0000
Message-ID: <b20e8507-8fe3-3cd8-c144-18819936f738@virtuozzo.com>
References: <20191226081521.29652-1-vsementsov@virtuozzo.com>
 <22eee419-ba2e-512a-568d-e8bd348f592a@redhat.com>
In-Reply-To: <22eee419-ba2e-512a-568d-e8bd348f592a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:15::35) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200109142849044
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 720e5c7b-d69b-4fcd-e9b6-08d794f71a0f
x-ms-traffictypediagnostic: AM6PR08MB4485:
x-microsoft-antispam-prvs: <AM6PR08MB4485ED2C94BBA93F75EE2654C1390@AM6PR08MB4485.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(39840400004)(396003)(189003)(199004)(8676002)(31696002)(316002)(52116002)(6486002)(8936002)(81156014)(956004)(2616005)(16576012)(81166006)(110136005)(5660300002)(36756003)(53546011)(64756008)(66556008)(31686004)(66446008)(478600001)(26005)(66946007)(2906002)(66476007)(86362001)(71200400001)(4326008)(186003)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4485;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0Q9oS1P4fHzAkLM8PGeU3wCI4/0j4ixrIlc6ybx6tVB/TwTb8RizYRY7CGbXJ6SVoLaaVCHjlINlajg5gEUGdSJfZ5HIm3YbmJxs8DisIe41t1iOZgca5Dvrdkm8yNXMXR2dFLzrXhaRtvOJjwJCJA/e+6WXVE8GfwZE1te8CrXYoYMiFepYDUuPyrBGZ/FXbQfzqaai1zk5OrCLAA14HYctXmxRkXFQ+YuD+mczcbygyN/3wmi8NrYzs7I2fseUk9GMDY2JS+RJdeKyVGqYIhzfSX0GPQf1HB3RAcIx7fNDHwWARpdGkSg7qg3qKJmTAWsCrLH5q0ZhZiuNzFFcBJwZFB16fKaGFzLNUwiz8TuXQkoWreHymNXZ8Rxf2eJyF8aV5ld+NNrWl4DpjFi7u6wVkaaQHkfDeAnApqBkkkS9hkvaTRk0rcSAeYUJ1YI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B2A46B4DEF92A446B8FD7749C49DEFF5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e5c7b-d69b-4fcd-e9b6-08d794f71a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 11:28:51.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs+1Z0s76Q4eTurbb4JXZ29bHrCYkFH28K0sOSJYXlXgdJFP2ZIs1XTZOhS6byJC0CEO6eg7Gn0gUObijhSLcB0ndtzO3rBW5RPxYkrrRBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4485
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.128
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.01.2020 1:01, Eric Blake wrote:
> On 12/26/19 2:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Don't try to write zero-lenght strings.
>=20
> length
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 nbd/server.c | 16 ++++++++++------
>> =A0 1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 24ebc1a805..28a915f5a2 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -392,14 +392,18 @@ static int nbd_negotiate_send_rep_list(NBDClient *=
client, NBDExport *exp,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> =A0=A0=A0=A0=A0 }
>> -=A0=A0=A0 if (nbd_write(ioc, name, name_len, errp) < 0) {
>> -=A0=A0=A0=A0=A0=A0=A0 error_prepend(errp, "write failed (name buffer): =
");
>> -=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 if (name_len > 0) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (nbd_write(ioc, name, name_len, errp) < 0) {
>=20
> What's the rationale for this change?=A0 nbd_write() should be a no-op

I looked through the code and it seems for me that nobody does this check,
so it would not be a no-op, at least it would be extra syscall..

> for a zero length write, at which point this is a micro-optimization (few=
er CPU cycles, but no semantic change).
>=20



--=20
Best regards,
Vladimir

