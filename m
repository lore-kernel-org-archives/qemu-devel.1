Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71192C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E206206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zpx2Jyx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E206206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8be-0001As-Eq
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic8IT-0000PI-Ey
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic8IP-0002g9-Il
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:32:57 -0500
Received: from mail-eopbgr50121.outbound.protection.outlook.com
 ([40.107.5.121]:26222 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ic8IN-0002Tm-HF; Tue, 03 Dec 2019 08:32:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB4zRe8mNwsMnNRxE9xLydU4MXZo/ERfNwfzt6IVSj6fMDmZdXB5s/oqLvIoBR4QKHUo7n0LoPs/f+1HUOW7wE6PD6HCwjShgu1rluq2kOkj9ZMTQ37eQu/SbGawluO/MpqX0UXfD6yVOHj9EMIWz6yoCf0sJIc4nVt6KQXk1H5lzgTtA3T1Ty6GzM06sCb70J9NXSne1J5VjPdEq5zG6N2Z0BQGTIx72NAj6j4xAJFQ9Xhj1kCecfhg+Tb8y6z3L77O+GgJWOv5b7k8KE6UaUmHJjyWtK9OL3E1//HELNpuFRDjs27Er97RmL48u0mkEwVW3GxP0EK4lVvsB9aRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCN3CBQfYkkiDkYXMUhmdWZ7wocaOP4dqkqH0E7KKw4=;
 b=Cq9QfBYdubWxkzRfXwGwybi9Uf5Xbj4ZHywpbvkHymokJUrJoYCWNRZloCFOdkYDcuzUD+/x2YKMVNV8J4Ksw3l1dVFPrWoy8mOTGxC660pjNvLvioBuNFMOKVCRSM4dTszf7eQ1qGCw3RmL+8Se5QiKisTxDkhc5BA7nVYNvdq0sg/jaOaQzXmK1SqQcGw5G5Tfn+vnj8+vg5dDGHYds4A25agmyOLkdD4SIJvj9m27gnUH08PspbdzsVWNPktaSOFivrVyzFaePhgGXwjUKLnZIo3qMVePMbMovbIh7YWsowwuf5Bo3BmKFqTI1YMTetO6lwghmKR63XyYuKvdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCN3CBQfYkkiDkYXMUhmdWZ7wocaOP4dqkqH0E7KKw4=;
 b=Zpx2Jyx7ieDzbov2RBXg4mI+FqnIy6xjt1SqlTwkvK06ArALZF/C4iCPfrqSaPhYPGhfTcwfLeLxAxX16QZgT/o/F1fIKKL52U3v77C1Gfwy5GdJGx2qTyyx8RBpS8UTB7NZWxI5d66sPJdFxD+IoCWz9aGD1ApeDjo5V6kAfqI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3656.eurprd08.prod.outlook.com (20.177.116.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 13:32:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 13:32:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Topic: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Index: AQHVmKmNmeJL6G4US0WS+6Oh5cK+GqeoivmA
Date: Tue, 3 Dec 2019 13:32:48 +0000
Message-ID: <2416e1d8-c1c3-4c88-6e7b-52670eb23c0e@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-20-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-20-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203163247306
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d53bb2cb-2457-4388-e7e2-08d777f549f0
x-ms-traffictypediagnostic: AM6PR08MB3656:
x-microsoft-antispam-prvs: <AM6PR08MB3656BF62281FC7752A7D096FC1420@AM6PR08MB3656.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(376002)(136003)(346002)(396003)(189003)(199004)(7736002)(25786009)(186003)(305945005)(102836004)(6506007)(386003)(558084003)(26005)(76176011)(52116002)(478600001)(5660300002)(6512007)(6486002)(2616005)(71200400001)(2906002)(6116002)(71190400001)(4326008)(446003)(2501003)(6246003)(11346002)(3846002)(66946007)(66556008)(86362001)(229853002)(31686004)(31696002)(14454004)(8936002)(36756003)(66476007)(81156014)(54906003)(110136005)(256004)(8676002)(81166006)(316002)(6436002)(66446008)(64756008)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3656;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPgcER2VRGSmAxPQ5bGAU7Ec8KImcGcEsntEeKUKYjOBB/C5PdAcETeQmg0bFpvqafDYvZuAMdYzE/7kbcRCPAj+AxCfQVLSn7lWA3OSldc9AxvGrH+61VuU1utmB+dMVfU3Vp1gyHULdGqgGUjRffkGqWVhPKxRy7MuDuffFH4VZrIJ2NWD7opDYbdWx/iewy6OrIjcjPtAafGOZq8ouXizvxw2RA83pwNGNeKCZs6vJt4SLoBIrvzOot252nwW83oPXIOWZhqu7kuKTtIivjgf1lhnSCQrBJ+z6uGd/63rp+wfhanal4mLS5Fxavui7D3DSL4CnT2vI7gJCX1cZYzVphj/eVEHvC8Z2Ge9Xdr51ecwI0UK1fkpx4o2/QhW5X3EPGbya0bhuIA4bPOwDb+n95T02Y5RzEvY1LAstaTmyEZcuP8YqUuyb4dv4ain
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <15097CE222F8284998E9AE35B4A0F58C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53bb2cb-2457-4388-e7e2-08d777f549f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 13:32:49.0060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCqyp3grHl6vfluwLQmIbISlobTcU48qVwx2StaVgjIw+OzFLjayfLD/fMXFrYOH5tF0vXMUuMxCcUxd+EljiqQGw8b3M3VpRxxUc6y11AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.121
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

11.11.2019 19:02, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

