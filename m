Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB96C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B65B206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aZHA6KF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B65B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVDol-0008OH-L9
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 07:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVDn7-0007ml-Qo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVDn6-0001ru-D1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:00:01 -0500
Received: from mail-eopbgr40138.outbound.protection.outlook.com
 ([40.107.4.138]:10660 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVDn2-0001pU-C4; Thu, 14 Nov 2019 06:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMzNV1aeABcZVxSpgTZ50nRGgh/OfnQTTCCsbWtESR3aWe03Wi9+fCencVlOb+zV9hUaC8Eunkgvp63OmbUTsSUAN8416gYYhrY/5fgbukOUKpp3Wqp5KeQBrjtRcUnkwyuLD/lQGa4QDSMqZbYPDTVb6WIz3FKJXCWOcTt59sasmbJwDHZQwWkN3t1C7mBQMDrQgmMXLsnK6CRuMJeJqgZcPi58f61IIcnTpZ8wTaBsxcqjMglMvUc2lD+AnJhhEDJzF5z5GZpnGad/Z8+/BhvHaTZHFJVQiz6xn92BDucUZvR5Jkrt7WIcg5/lWOA1IMeUXOaYXodjKFkL+rlgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucCbofreo7MLQppRQz64ZOZEKCbuGu5vreQmNbRKbGI=;
 b=BNNHTcabvkETXC/u5EEh5NfwVOUFXPnK7uJSC6Ua+9uc8gqq8k7v27fHvcj+Hfmr7TRQDw/ZHjnxbZtWZJNxgWc4B49PpkkQxPNQQI3dcZqu2TI8i+hUcDaZAm8fOfVC9nSFEBgFopSxs7022HlyP7J3wB+e1D/lfRhKFzP7PnD5l6cRGCLV8D8J2te0kFR48VjXaebmUPAz10DcYX2d6kIsELWTmoW3KX2F8YtUiad3ZtCMSaM5JzpOEPjsQuCWU+vHLCPLUbH3y65p+UzwE6iMwa6XkvWpo4ZKyzzpt4mEjnkuSz8IqIF5Pe6u6oe5bJvKUO63iXfqgel6L/tVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucCbofreo7MLQppRQz64ZOZEKCbuGu5vreQmNbRKbGI=;
 b=aZHA6KF3eCslFPDJ083wcGM9/OZFxJ4YbjcNxsXRk+LOLTD3QkhMs1nDpAwPAM6IyfEBYShvMjgKvF0+w9Dlw2Bt18lAt+YAyCZYFUEzg5Wv1RW/QR9O82PBBFbVpFZcenLFGViSoPFaffFVFaKvoSykB+7RrYNh8/Xw7L/CX5A=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4247.eurprd08.prod.outlook.com (20.179.6.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 11:59:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 11:59:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Index: AQHVmlI7eO4+ta1idUecy2WkuY5gm6eKiHMAgAAI8QA=
Date: Thu, 14 Nov 2019 11:59:52 +0000
Message-ID: <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
In-Reply-To: <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191114145950181
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c8dabf7-2568-4179-8f70-08d768fa288b
x-ms-traffictypediagnostic: AM6PR08MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4247496EDDC7459494B23BF1C1710@AM6PR08MB4247.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39830400003)(189003)(199004)(81166006)(31696002)(4326008)(107886003)(110136005)(6486002)(2501003)(316002)(86362001)(229853002)(54906003)(99286004)(52116002)(6506007)(6246003)(2201001)(5024004)(6306002)(6512007)(256004)(76176011)(53546011)(386003)(7736002)(8936002)(36756003)(305945005)(2616005)(102836004)(476003)(11346002)(486006)(2906002)(446003)(26005)(186003)(81156014)(6436002)(66066001)(6116002)(3846002)(478600001)(5660300002)(71200400001)(66556008)(71190400001)(64756008)(66446008)(66476007)(66946007)(25786009)(31686004)(14454004)(8676002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4247;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2iQ8zveqLu1M/HgPZOS9AfJfua8guLPiXNResXaAMw8aITlOQ98l097bHzF85ZmCSbTcoOJr/Di3uL23a284p9xYB2ZFXqwwz+/yRLw8H8Db3R5KanT+5ZXQH3HcuKLkTkTG3KSGuqygzLyphiM9JhShan21AaxKZsaZsZE71vmSLymPYkFAmAF86CQ/eh1LSjPIY2O3AyaUuRsqqZRT7RD6ZhhnOkqsUgjLBA/7o8cno2mbkJ8K6+p5XpUfgdFv8KmCVUSg4abNoiY9CzcUV2i8dEmUIcRMV+ZQnfPwGQLTWIKyLuVUkmKv3cHM9HJ9k1ZFwZB1dstd+M9fdXnk7SQHK6nO9Tx0l9OydmjPuivYnKxpYgAaUP0TSXZoaMoSVK4j3ejYZcA/3BfyNJwNh1Ioin75GPS0JD2Io0aV9poW2jAIvcxKBIfDL6h6Eh/
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BC035349A00A8C429FD9D2E162711D9C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8dabf7-2568-4179-8f70-08d768fa288b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 11:59:52.9740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rypnwm6o086oj1RKXKxb/EZUeH/qCAzF4ryvvRvE9EFS3aJZb6AOvBCwMHj2aoaB8q0K7+E0Rp7UwAo+BrF7XHvUD6IlFFJuFGK0jzR6NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4247
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.138
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
 "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.11.2019 14:27, Max Reitz wrote:
> On 13.11.19 19:43, Andrey Shinkevich wrote:
>> Allow writing all the data compressed through the filter driver.
>> The written data will be aligned by the cluster size.
>> Based on the QEMU current implementation, that data can be written to
>> unallocated clusters only. May be used for a backup job.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/Makefile.objs     |   1 +
>>   block/filter-compress.c | 201 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   qapi/block-core.json    |  10 ++-
>>   3 files changed, 208 insertions(+), 4 deletions(-)
>>   create mode 100644 block/filter-compress.c
>>
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index e394fe0..330529b 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
>>  =20
>>   block-obj-y +=3D aio_task.o
>>   block-obj-y +=3D backup-top.o
>> +block-obj-y +=3D filter-compress.o
>>  =20
>>   common-obj-y +=3D stream.o
>>  =20
>> diff --git a/block/filter-compress.c b/block/filter-compress.c
>> new file mode 100644
>> index 0000000..64b1ee5
>> --- /dev/null
>> +++ b/block/filter-compress.c
>> @@ -0,0 +1,201 @@
>> +/*
>> + * Compress filter block driver
>> + *
>> + * Copyright (c) 2019 Virtuozzo International GmbH
>> + *
>> + * Author:
>> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> + *   (based on block/copy-on-read.c by Max Reitz)
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 or
>> + * (at your option) any later version of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "block/block_int.h"
>> +#include "qemu/module.h"
>> +
>> +
>> +static int compress_open(BlockDriverState *bs, QDict *options, int flag=
s,
>> +                         Error **errp)
>> +{
>> +    bs->backing =3D bdrv_open_child(NULL, options, "file", bs, &child_f=
ile, false,
>> +                                  errp);
>=20
> Please don=92t attach something that the QAPI schema calls =93file=94 as
> bs->backing.


Agree, it's a mistake. If we want backing and user set backing in options, =
it's opened automatically, I think..

>=20
> Yes, attaching it as bs->file would break backing chains.  That=92s a bug
> in the block layer.  I=92ve been working on a fix for a long time.
>=20
> Please don=92t introduce more weirdness just because we have a bug in the
> block layer.
>=20
> (Note that I=92d strongly oppose calling the child =93backing=94 in the Q=
API
> schema, as this would go against what all other user-creatable filters do=
.)
>=20

So, are you opposite to correct backing-based user-creatable filter (with b=
acking both
in QAPI and code)?

Do you think, that if we make backup-top to be user-creatable, we should mo=
ve it to be
file-child-based, or support both backing and file child?


--=20
Best regards,
Vladimir

