Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6315C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F22C21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q0wzFhEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F22C21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT8A-0001Hy-Fb
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUT5Y-00061Y-VI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUT5X-0003aQ-N4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:07:56 -0500
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:14830 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iUT5T-0003Wk-Uc; Tue, 12 Nov 2019 05:07:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWCUB3WCYDzo+2w4EGtbkzwy//oLToVHtJLtgjpK8zAnKjuKsyo1+3C9LV1XEZgkkMFSSAgH3ma+gMFpDFg1SpbHKeY6LhNtkhfrYTcH36164/RISmhWMamhxzgV5zNHXdbnSpyXyClMUHsE6xd28gzIpBlB+HD2UjshQVMujcjnod9GgeBcMCnKNtgbLq7Kx5jxWd4/jQhz2iYEX25lDBDzyVOhgMBH1CQ7NbZcZM5lIO4vPDNrmv9SHjBNdDD/3IobuJ8iUnpR1HddSBm3HvTTyhD16Yuv7UhGxMq3+m/qOlS45Py7qvqnPOyeT9gnAPrdVdS3C5rTIIdCHmO7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRwfw1e5d7VN2JFATvKXbdNjKZnU5exInJ+At2b7pMU=;
 b=MsyulkHbkKO/LSvAZV0jckInI4Oq1DzUVhjQRIVGzhiu6XyiA8l8VRUKINk8ZJKOr3/WRdNcLN8aX83an/HKOvPokKqvZ8iwmQWCy9LhLAUKZcvl59FfdO7okirTihgF/RsWB1cZzL/hSYU8ZrFphkRLtH5662nlpyZqEuC3xbLv4q/GmktMu6mLc7qI/HTAtKWY+qr/OC7vWGoj+kc6cEYR8Y2ZdrLizhzBL15qOdJHHibp6g9OQG65/BJzNjcw7vH1QnqxBP9mpabxebHgw7nJCJMvJ0W6rBFNIz+rmMgs4ZaOQnA0FyN0ML/ODf4BOi2aKECGq/6F15f3VgaV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRwfw1e5d7VN2JFATvKXbdNjKZnU5exInJ+At2b7pMU=;
 b=Q0wzFhENMW1EmBZQSoy/UZeGMSCrBfhQ8pV91y9cck2pddL1GAnU+c/jqVTdm1jGsyZaRuFTFnqBQ48GFvlrezdDw0g1GP0PGX0weVCec+YA04dWYZ0OSKWXw3ApZj231XLAO+T4ZSHI/BCX80z69bEZoXeEju/dY+YpSka6UNU=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2838.eurprd08.prod.outlook.com (10.175.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 10:07:47 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:07:47 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v6 1/3] block: introduce compress filter driver
Thread-Index: AQHVmKnAkAyy5MwXBk+X/RQ5OedZu6eHSMAAgAAH+oA=
Date: Tue, 12 Nov 2019 10:07:47 +0000
Message-ID: <9df49b41-c2a5-d087-36ac-3f31ae7f4c85@virtuozzo.com>
References: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20191112093912.GC5364@linux.fritz.box>
In-Reply-To: <20191112093912.GC5364@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0071.eurprd04.prod.outlook.com
 (2603:10a6:3:19::39) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b9bcb4a-9d25-4180-7036-08d767582b3d
x-ms-traffictypediagnostic: DB6PR08MB2838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB283877007718DD05B74F0CBAF4770@DB6PR08MB2838.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(39840400004)(396003)(189003)(199004)(66946007)(229853002)(66476007)(6486002)(66556008)(66446008)(7736002)(8676002)(31696002)(81156014)(6512007)(64756008)(31686004)(186003)(6916009)(81166006)(6436002)(4326008)(256004)(8936002)(6246003)(107886003)(305945005)(14444005)(316002)(86362001)(54906003)(26005)(99286004)(76176011)(52116002)(3846002)(6116002)(386003)(6506007)(53546011)(2906002)(478600001)(102836004)(5660300002)(66066001)(14454004)(2616005)(11346002)(476003)(446003)(36756003)(71190400001)(25786009)(44832011)(71200400001)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2838;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7o+M9lGzg48otWJhpy10fUhMKstmeherFHPBtnX0TFgxQ2/6ryjBQaqqb8HKK5lD0HhiEfFwrEuLKqbbqqf6a0xyvY96uddHOi4Thq3Kh2K8njKx7pf4xXPXV1SYhetatkFMkzoMkFW4zYyBM2rlR1DXA0psgvnlmT1lekOG54BqcRkJP7r0a95QwHKl3HIrVHK0mg74lXsCcVVOf4un6IvTL+HEs57nRZM7YuNSQx+c7czKCer+cR6aXdRl3IxATBSPzG4WsEquFoEBzCbb53Gp89zpehYQwhrLn9WAqQfTP/Hok8pxjm6jQiJzihCYDZaTogirTRbX8NkaWvxfs+XKFd5Zhe8OZNOWa9IE9cupVQRz5/ekPEDbG9zKY4lHP9wt4xpi6/yJjmf8AWGy+NoF5FJ7uMHbx8+YaHSHDBpsrr5iffwc8WRy436zNXo
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2859ED8E1D19CD4B89983519E6AE7F35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9bcb4a-9d25-4180-7036-08d767582b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 10:07:47.7981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FCnN7PYMmCxyHEiuLBa+v1Oa6BEk3zUOYZEdYxUjW4PVE6b2SWQWK58JdtIHGWMPuRMYA0fFEe12p8HxFoKnfeWE3Ke7B4yldgjcSi28c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2838
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.110
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/2019 12:39, Kevin Wolf wrote:
> Am 11.11.2019 um 17:04 hat Andrey Shinkevich geschrieben:
>> Allow writing all the data compressed through the filter driver.
>> The written data will be aligned by the cluster size.
>> Based on the QEMU current implementation, that data can be written to
>> unallocated clusters only. May be used for a backup job.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>=20
>> +static BlockDriver bdrv_compress =3D {
>> +    .format_name                        =3D "compress",
>> +
>> +    .bdrv_open                          =3D zip_open,
>> +    .bdrv_child_perm                    =3D zip_child_perm,
>=20
> Why do you call the functions zip_* when the driver is called compress?
> I think zip would be a driver for zip archives, which we don't use here.
>=20

Kevin,
Thanks for your response.
I was trying to make my mind up with a short form for 'compress'.
I will change the 'zip' for something like 'compr'.

>> +    .bdrv_getlength                     =3D zip_getlength,
>> +    .bdrv_co_truncate                   =3D zip_co_truncate,
>> +
>> +    .bdrv_co_preadv                     =3D zip_co_preadv,
>> +    .bdrv_co_preadv_part                =3D zip_co_preadv_part,
>> +    .bdrv_co_pwritev                    =3D zip_co_pwritev,
>> +    .bdrv_co_pwritev_part               =3D zip_co_pwritev_part,
>=20
> If you implement .bdrv_co_preadv/pwritev_part, isn't the implementation
> of .bdrv_co_preadv/pwritev (without _part) dead code?
>=20

Understood and will remove the dead path.

>> +    .bdrv_co_pwrite_zeroes              =3D zip_co_pwrite_zeroes,
>> +    .bdrv_co_pdiscard                   =3D zip_co_pdiscard,
>> +    .bdrv_refresh_limits                =3D zip_refresh_limits,
>> +
>> +    .bdrv_eject                         =3D zip_eject,
>> +    .bdrv_lock_medium                   =3D zip_lock_medium,
>> +
>> +    .bdrv_co_block_status               =3D bdrv_co_block_status_from_b=
acking,
>=20
> Why not use bs->file? (Well, apart from the still not merged filter
> series by Max...)
>=20

We need to keep a backing chain unbroken with the filter inserted. So,=20
the backing child should not be zero. It is necessary for the backup=20
job, for instance. When I initialized both children pointing to the same=20
node, the code didn't work properly. I have to reproduce it again to=20
tell you exactly what happened then and will appreciate your advice=20
about a proper design.

Andrey

>> +    .bdrv_recurse_is_first_non_filter   =3D zip_recurse_is_first_non_fi=
lter,
>> +
>> +    .has_variable_length                =3D true,
>> +    .is_filter                          =3D true,
>> +};
>=20
> Kevin
>=20

--=20
With the best regards,
Andrey Shinkevich

