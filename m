Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6928BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3450620679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qw6LilsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3450620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZF0a-0000gi-Cv
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZEz7-0008JX-8J
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZEz6-0007Pm-3T
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:05:01 -0500
Received: from mail-eopbgr40099.outbound.protection.outlook.com
 ([40.107.4.99]:44191 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZEz0-0007Kf-7L; Mon, 25 Nov 2019 09:04:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq5Aroj+ojY1jbyo2CvQ5m7PHC/EJFPM47I7Im9J8EwBTtHc312dhV/P60gTYqnL3t0O4n2x9ke8OhFlRhWPzLi3H9r/6OSnvUuSL2W1ukqpkC9WWBSWpEjzZNrPczcvPJmK886bQqzV2f2YD0+fASoTj8Z+UDlqNuwBfzwLUjP6AUdWc5VXeKD/Xyf8EJxQesEXGiYSwLrYcbwJIL2Rf0yGkuxW0B08wB9xrHp0nZc1UcDD3N2NSa2rF4dITPpsuSAY978Fqo8DjtPpjXHNRutYGGcJ/xR3Y6HQIC0kGGOdcETlnlcojpDMVIG6W5KEszJu1k52og2SjaaTRx/57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dq4iBuNT29NA5Vp1T27IR5mgV6s2JhV2MwXjo9kJvI=;
 b=V5YBF4OvXwJSu4Y9g1mgQWBzBl4f1USxgSbeCSdWLY8rba3AulCWOJzcWKEQSkQin14DDUScAxDqsKymNvqYL+1/T++hJxA8dFT5nGC1zON3Bolw/dSD60bS6hN1s54FgJNZ/0olpKMyTX3x6fKFN6z22XFLsDDFt6m228oItlfTHTfmbAPVyXsP7TIHuB4/g5sDl+0XXl5DKdFjy+c8kDxnkZk1Eitx/WtJPaa9yZANCrwUhxIt43i1SsUkxoU+Zg9F6wzy1gmbWEV+ta/Fk9OUOs+RQUyk5nlcBZ/29u7y6bJSA2Zlnl1BJ+dzc8d7sYMZVHpk8hckV5JcOy+7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dq4iBuNT29NA5Vp1T27IR5mgV6s2JhV2MwXjo9kJvI=;
 b=qw6LilsOTYOKlYCGubceisUa2M7a61rSX2eDXncguVOxMFLgwiuv4Zgt9stAQCByB/K5IKDMJzlj28KmXVuEA1oMZviqwclOu5aPL0JuEZ1hZ4DeBPncuRDT5+3VZQttsq3Twc2OiM5RFidQlUdFy9lJJyumMBpxTLm15rxRU2Q=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4487.eurprd08.prod.outlook.com (20.179.18.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 14:04:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 14:04:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 0/2] Fix bitmap migration
Thread-Topic: [PATCH for-4.2 0/2] Fix bitmap migration
Thread-Index: AQHVo48+ECB6ixU2UEuW+JCS6qeFlqeb54CAgAAD+QA=
Date: Mon, 25 Nov 2019 14:04:50 +0000
Message-ID: <a5de748a-65dc-20a6-e53c-3de824ef355b@virtuozzo.com>
References: <20191125125229.13531-1-vsementsov@virtuozzo.com>
 <ceefa583-5fd0-4278-d7d0-bb07be6accb4@redhat.com>
In-Reply-To: <ceefa583-5fd0-4278-d7d0-bb07be6accb4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191125170448136
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f0e99be-7a3d-4bf5-ae90-08d771b06fdf
x-ms-traffictypediagnostic: AM6PR08MB4487:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB4487B9745E0861CEF70F2FEFC14A0@AM6PR08MB4487.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39840400004)(189003)(199004)(53754006)(8936002)(66066001)(76176011)(2616005)(52116002)(66556008)(64756008)(66476007)(446003)(316002)(14454004)(11346002)(99286004)(66446008)(478600001)(6306002)(256004)(7736002)(86362001)(305945005)(66946007)(4326008)(36756003)(14444005)(81156014)(71190400001)(386003)(71200400001)(102836004)(6506007)(6512007)(2906002)(54906003)(26005)(31696002)(25786009)(31686004)(229853002)(6486002)(5660300002)(3846002)(6116002)(186003)(110136005)(6246003)(8676002)(53546011)(6436002)(2501003)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4487;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7JoctTeRGHYcSYfGc6fD+RV9QtSevOEl+bQaEy1ucBdozWyd4VCmCPCGIJhsPHCCRmWjwBmvzwBXKxSTajax1QU+dBUYAkd+ZLYUDm5oEAYxV9exSZCk2roUQEeOoZj7HmGTpy/SIC4VFxn1wVap76mIyGUHyHK4BqVf4U+6ES+US/hmQdyKJ/TLcb01auLS9nnmJD2e1FH3Y+5WW/x4br+GWqWqJEiyQJf/TaERZx1BSbsDYVjwYkxQ6mmDyT4tlTPlDwlPUzTop5Dt+W3JqdgKHONwwVhmsHCFP8Qnlo5fhOMW765lTOD3kk526TnFZxJCMKJCIPVqe92S06OoKyAh1mXWWtrxNuChEHu1vxcrKrvAmcS5Ws2o3WrRwFmARsG7QcYVb8ftgHHnfcNt0rYClMTX7Lorv1Cvbfs4nAML0TWw6ofoctheRpXaAYIOHrQzRq1i45h3GtArfjrWDxAeDkZyHhUQbUurjwXvyI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <792F906A5E0CB945BD14785FBBA43F14@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0e99be-7a3d-4bf5-ae90-08d771b06fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 14:04:50.3736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7vJLZeVaTZkI30vnBDEdW2NFI0+3t5WIwZfx3yXqUegA71HL2J/hNfAroE044INGzeNeh5h06XRj9nXXyAwT1nnrA0ps5dXU0Nh2Ttz7c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.99
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.11.2019 16:50, Max Reitz wrote:
> On 25.11.19 13:52, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> We've faced a bug in rhev-2.12.0-33.el7-based Qemu.
>> In upstream, bug introduced in 4.0 by 74da6b943565c45
>> "block/dirty-bitmaps: implement inconsistent bit" commit.
>> At this commit we started to load inconsistent bitmap instead of
>> silently ignoring them, and it now I see that it breaks migration.
>>
>> The fix is very simple, so I think it's OK for 4.2.. Still, it's not a
>> degradation, so we may postpone it to 5.0.
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    block/qcow2-bitmap: fix bitmap migration
>>    iotests: add new test cases to bitmap migration
>>
>>   block/qcow2-bitmap.c       | 21 ++++++++++++++++++++-
>>   tests/qemu-iotests/169     | 22 +++++++++++++++-------
>>   tests/qemu-iotests/169.out |  4 ++--
>>   3 files changed, 37 insertions(+), 10 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> Makes sense to me to put this into 4.2, but I don=92t think it would
> survive Peter=92s check list. :?

It depends on how much the fixed case is popular..

Actually, anyone who tries to migrate bitmaps with dirty-bitmaps capability
enabled and with shared storage will very possibly run into this bug.

But who is it, except for Virtuozzo, I don't know:) Still, I see that a lot
of that staff merged into Rhel Qemu we based on, so at least this should go
to qemu-stable and to Rhel update.

>=20
> (https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00807.html)
>=20
> Max
>=20


--=20
Best regards,
Vladimir

