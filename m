Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB20120872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="StStUVuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjip-0002FS-1D
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjhs-0001jC-Qx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjhr-00058v-AO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:29:00 -0500
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:48865 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXjhq-00058c-Ix; Thu, 21 Nov 2019 05:28:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fccf1+puPch2CpeqpwdHiITU9BNEGeoKKVIbgU0d/63wOqxyyttgBbvcqZa3F43ESKcios16FIIJmndmi8EYtALVllh2TMfyO47JfwMyExxNtHhmssd86seOJ7JUr1tU7RhT/033JeJZ67gNKz/ju5IEIJ7//coniqsPRiyM5gMmkkT162Riq90TFrGiPj3Q7RRxGevFEzRY37WE/ynFSXP+dxje/CZzkni9lzZeKIvaawudb+7tKQWo074dX64TkZJV9hgLcG6lyFZGCPBixvuTQ5cSW+7iqikc4zXBKtcShERc5TuIrQ2toW0V+aDn2RkjSAzTf20atFLsR3eIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At+6EYdJ7gBTFcRT9eYGnjCciNCIAWXR6Zds5DjvdTE=;
 b=RTAcdIX+dhzFn94ilB3mpEezmah5avU9GK0pSUkUMNGJbWBNy5tzOxU/IYBseidXy3IYekjI35q/VQiKB8GBonkeJaoolhLCsjhcASSMUw0sFp+KppkpezbeqOAQ7wMxXdjg5XF7kNfb73o+o4KOcGMnTw+8jxolD2T5zimLO7/ZWEMSzxISV3A1836WK1Z+Vu9MTzbFA3SfE/lKhaldS+QXhy+afaFBi4u5cR6t1eLNuSaB6cE9Ytn5lRAU2c29DQHzRL5C85Xa1ihDx0RG2j6Hk6NrToh6xqbVhTzjUuAUBVhYh0nbCDeAM3n4HLUiPPZp5REvUPP2SueFFtDjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At+6EYdJ7gBTFcRT9eYGnjCciNCIAWXR6Zds5DjvdTE=;
 b=StStUVuDChn4Mq2pm4Psp5+tpcxIG3fRLd9DSWaylQcVXEZmf0WeyHvePhjavvsr54vcNy3bPc1W77IQv2J5vPRSgAc+UOEMA6PVx9HHPIXJAeqlUGfYKM3jXhbYA03qID5KX2eLc1oMAUnPFK0n2SpI0/Cf/kAheg4HnLuioLQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3320.eurprd08.prod.outlook.com (52.135.165.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 10:28:56 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 10:28:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn9KxRltA7uNPbUqM02ssz4EKHKeVbU0A
Date: Thu, 21 Nov 2019 10:28:56 +0000
Message-ID: <832ab7bc-07a2-bbe0-a567-71d416f8c1d3@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
In-Reply-To: <20191120184501.28159-7-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121132854217
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d08cdda8-438f-481f-7043-08d76e6d9cf1
x-ms-traffictypediagnostic: AM6PR08MB3320:
x-microsoft-antispam-prvs: <AM6PR08MB3320A9F42BD1B23E3DC8F32CC14E0@AM6PR08MB3320.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(316002)(81166006)(2906002)(102836004)(81156014)(25786009)(4744005)(86362001)(31696002)(256004)(14444005)(446003)(2616005)(66476007)(66556008)(186003)(66446008)(64756008)(26005)(14454004)(99286004)(8936002)(305945005)(8676002)(66946007)(7736002)(6246003)(6512007)(478600001)(66066001)(5660300002)(76176011)(52116002)(2501003)(229853002)(36756003)(110136005)(71190400001)(71200400001)(3846002)(6116002)(11346002)(31686004)(6486002)(4326008)(54906003)(386003)(6436002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3320;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihOLi8wm0udgGWdpPtlG7s7Y3anbcRF0/lIcMG1BSt3hScLEGZL2UjxwQqN6LADJTNvU7EUwIE/G3jSa50KQ0DySLEuwxGQAY/2cN8QZWBhB6HFFOx7CVVvVh5ehwbro4K+GLoIVx9Sk5XnjAgdIX3eouSvdpSf7mnUgycrQYD9p1EEfHtim+ABh4cDIdQovZrhLT1e+zGQ2o/TE5Ub4O2K6YRcS/05BNlws5zpu5xzTtDnS9onX+k1Xso8vRyoO1oLCqofM8Sv5Nv1RxsmTptnV85B8zCp4Kk7tpE+mkL5nCzWyY5KpYNGkK5/FdCeGLx2esvfkNK0p4i3n9qTKHgvWatj8E3m9kC2KUdKnLr7DBA0DXgCNEiErmzwdRnlCrn1k+n3UQnPXEnCVPtgcaGNulQEYqy/ovuTg/QCQPLJLg00kMRkMWB4LYhghCcTU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B99F01C58BCCEA49A2642A01501AFDA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08cdda8-438f-481f-7043-08d76e6d9cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:28:56.1123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNnJrSK90gTl4PVI8tdUJpFxP3PbYtdI5H8iNX8+vNef7mLmd21tllxP0C/q6bhcstv3GslgzQe1FWwA9qg+uZ7J1yehDWQwpMT0cYMcDDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3320
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.115
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

20.11.2019 21:45, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Hmm, allocating 7G will break tests on small disks, for example,
on my 2G tmpfs.

So, we probably should
detect "+qemu-img: Failed to resize underlying file: Could not write zeros =
for preallocation: No space left on device"
errors and skip test. (better skip testcases, but it's not possible for tex=
t-comparing tests :(


--=20
Best regards,
Vladimir

