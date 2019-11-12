Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E121204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OtvBeNJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E121204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUS0P-0007bx-K9
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 03:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iURzk-00077P-D6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iURzj-0002SE-FW
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:57:52 -0500
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:15522 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iURzf-0002HP-U8; Tue, 12 Nov 2019 03:57:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY2CRq058cakbHKhHZNt2ziYEjWN79HX9aPcBjNE5c4c0P//RqaumXJCbd9CvNr9EqS+lW5nWD8X3qfHzh06oTKkPy4KQGdRAYjNJoZFGo83h+vC1CljUbgE4oa4E27ubUd5oxl+9XRGqA8OyZ7xDusctE5IOhxLcr6qUZKSWvrXf+0YS3MKHLsPPn/fmV8+Qb8KgRDlgs6QKn+7Rwmcp4wCII3EJ8yxGNVeFjSUmVFwqa+tybH52+K6oW/360XZRzkYScoNGuEZHX0JFRPOqJEbWX+IJqVmq3tdXxS+yig0cOQmtdr/4VV9O1gxBvRU7g12GxREbDW8zLpBzaM9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESyD0KIn7MlWN/sbVolw4QsO7DdrpCUkrWbFGATgy6k=;
 b=Z39sKHqGtCRs5j8j5lD0kTyObieNfxok195nOvh6pL6EqKhLv/3/0MsbUYi277bF2zV1a5RgMejpuF5CeZIwrczUjEnW8rzPb7cI0KGH80EiGzhInw9i3m2uxjqCQsBlVHjHBTW43aQ54XEAeL0yWKMh8ejzAITbumSxZ8gvf5SeEzo+V79zczNWG5ahl26RBdasz2cUEEtyieh5UW8+b99BKJf/PcU/Q2SaJrektrDDIZG233hWSJi9hsrfIdZ0eSNM7aZyvB4JSsWS5ihgSCjEaypF1TwHC4JymDAu6udLG7O9FPY308rB0iXkNp3fvyvFtyz18fzWEFvEt+6CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESyD0KIn7MlWN/sbVolw4QsO7DdrpCUkrWbFGATgy6k=;
 b=OtvBeNJJeuyD19p5sO+x/wAOlfSYQhZunoKO3KDaz/cpLBKdQ082mPdjPZUYERYCeqmzvdmX97BVH+zkLkEWzeIb4Fxcg9gw0VtYTvcXLieMixxkybe3lXEE96Bo+m5hnCUb2lgtpRdlinXPfxHTT7qSml3Nk0alERox1fQPAkY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5270.eurprd08.prod.outlook.com (10.255.121.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 08:57:43 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 08:57:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Index: AQHVmKnAqgdeikmhBEKvDN05CFcI96eGcRCAgADMFgA=
Date: Tue, 12 Nov 2019 08:57:42 +0000
Message-ID: <7a06398f-508c-5ff4-1024-37ad30cf34e8@virtuozzo.com>
References: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <78fde14e-b573-f7e0-d211-f066c3767b7d@redhat.com>
In-Reply-To: <78fde14e-b573-f7e0-d211-f066c3767b7d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::18)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191112115740501
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d49295-c09c-48b4-50d9-08d7674e6097
x-ms-traffictypediagnostic: AM6PR08MB5270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB52701C5B6853EA65FDD9B912C1770@AM6PR08MB5270.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39850400004)(376002)(366004)(199004)(189003)(81166006)(81156014)(256004)(66446008)(14454004)(229853002)(478600001)(316002)(8676002)(186003)(8936002)(54906003)(6246003)(52116002)(5660300002)(6486002)(66946007)(6512007)(110136005)(31696002)(476003)(446003)(2501003)(31686004)(7736002)(26005)(107886003)(486006)(71200400001)(6506007)(71190400001)(11346002)(386003)(53546011)(99286004)(102836004)(76176011)(4326008)(305945005)(86362001)(64756008)(66556008)(66476007)(2906002)(6116002)(6436002)(3846002)(36756003)(25786009)(2201001)(66066001)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5270;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6nfbLm5IWqUk+7hKZTL0mjaPrBfbA6ajfx4JeTh3l3iZqbaZg901jHMfh4pvKoB6hKySypFwocj/md86+eiu3tzv8OJnN4p5Z/R91iaT8QPPrRjK825QVfDgbaAw4V/xSKmoYmJ+ZJsQR9sd7JMMTtB5Kb3sB7hTZ086ohJHsa1Mh4TeE+CivW9H0tpoK7aGU+wKEZs6bnIPmSMnpNX4UZBGkLDqKRic6ams+CEpVa5jUlxgihJGqBXGIRWNKtwC/6bkxkH3QnwnMoIbi0cHw3+A2fh+PgS76qGgWr89MciItf5ZPdJyB4mHS1/Gr77sQ/BWoWQEeEyNkzhJyGJMDzpEjnnF2p3yvu41+nIbjsZMSDbhW77oWiFCTS38L16plLn+lc4D16n2KX1anlLcOdrYQUxlLxAqBCUiUp+/iGzhtsEowKYFGPPQC/FD86o
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5F0B9D1AEA33FF4B81C6EDD229060FBB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d49295-c09c-48b4-50d9-08d7674e6097
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 08:57:42.5022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VAP4OMu2gTQpTPvgzSprZQlPKkAFrc2eVrUpeV3sM5J7xX4oSVhH/XBo6bv95hQxUM1q4RX4QnCcSfMO7vW2AXpa0xFByInn2vVw/hJqbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5270
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.113
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 23:47, Eric Blake wrote:
> On 11/11/19 10:04 AM, Andrey Shinkevich wrote:
>> Allow writing all the data compressed through the filter driver.
>> The written data will be aligned by the cluster size.
>> Based on the QEMU current implementation, that data can be written to
>> unallocated clusters only. May be used for a backup job.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>> =A0 block/Makefile.objs=A0=A0=A0=A0 |=A0=A0 1 +
>> =A0 block/filter-compress.c | 212 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>> =A0 qapi/block-core.json=A0=A0=A0 |=A0 10 ++-
>> =A0 3 files changed, 219 insertions(+), 4 deletions(-)
>> =A0 create mode 100644 block/filter-compress.c
>=20
>> +++ b/qapi/block-core.json
>> @@ -2884,15 +2884,16 @@
>> =A0 # @copy-on-read: Since 3.0
>> =A0 # @blklogwrites: Since 3.0
>> =A0 # @blkreplay: Since 4.2
>> +# @compress: Since 4.2
>=20
> Are we still trying to get this in 4.2, even though soft freeze is past? =
=A0Or are we going to have to defer it to 5.0 as a new feature?
>=20

5.0 of course

--=20
Best regards,
Vladimir

