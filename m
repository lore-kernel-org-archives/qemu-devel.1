Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEBDC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C692072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uE/KYG4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C692072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJy3-0000WG-6x
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iiJwT-0006pN-6X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iiJwR-0007FX-OE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:11:49 -0500
Received: from mail-eopbgr140138.outbound.protection.outlook.com
 ([40.107.14.138]:40321 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iiJwN-00075x-Ts; Fri, 20 Dec 2019 10:11:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtBzFompYmyaI5EMzqP6APmA0DBvRAxo2/XdaVmeYQBjjOD/nMPW6uBuagsBjgg+Uj6Zc9nqIkDQlg84YqhtvWRhKcFwa3rtShh9i+bA6EwaY4OYA7x16LyiI6V5KOf2gZU49ADHbKXs3buJAZ1ZTGbgwKJftsiry4+7hooz0wC4xk6C07PWQxp4gCL/79QuuQvXlJBrzfc3F0ULZhIy2OXfJ4aFIKeiTTQyLgm/aioLq7LOWlpFhedJYT817ZyRLtNKRw5xsMYM+DcLvek/82KeR4XWgY/BBaH+HP7/9DsEr68WGaYOLN3lKPKCQ3XXj+QxirAKfXEA+5qkIczsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmVscH2e0iETGgVpC/Cq6QC9ozQec/bow/n/08ApMD0=;
 b=VuWcN61zsudl6u6PWesuTVi5FWkuwpGqmDvxg+9AE9P1Ytv05AH4rsE/T2I1NC3+P8oRMlxjtA9YjNc/OHkTeaUrg3IiSo81vcyl3sWT1pakIYCQqkF8Fg5s7TCdO2cnu1akIVhBjKEROH5M8xgRgpooHb5EZDzeXgz79QPeCJmQAoYLjOkX7Z4JzOJH13+xbi7lWSsk0yL6JQeHCBTh+9K8ZEfndZEO3eKSziPXyg77jqUF7SeuNfbt2DAUpsZewCUMFzxSF6iuj0ytorOw8qQwMzbpoQDLVhCKdX+Lkd9H/jnOI6Ldlx26Q2EeWQs5u1xwXUNseJKj0wtKVdl6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmVscH2e0iETGgVpC/Cq6QC9ozQec/bow/n/08ApMD0=;
 b=uE/KYG4m5pBztkVWqp6jfgNdDEP95uN/EA8RzA52GupZEbbNbe4O8vN4yOfSvlrZY6X2qU7QH02eNVSdMNgczAz1waAwkOO1lQ3UGYPajtjbX0i/KeIShxM9NByK4dobT64mIuTQJpeceCSdiqJGLW7aGUu5k7+hsUGDSVfoAW0=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4913.eurprd08.prod.outlook.com (10.255.99.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Fri, 20 Dec 2019 15:11:39 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 15:11:39 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v12 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v12 1/3] block: introduce compress filter driver
Thread-Index: AQHVqQoqZl0EPV0QuEmkKsougkLlgqfDODUAgAAFQoA=
Date: Fri, 20 Dec 2019 15:11:39 +0000
Message-ID: <569ca08c-6718-3914-f875-d96794b02b01@virtuozzo.com>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4c0f2379-7baf-7aa3-ab5f-a7046793d730@redhat.com>
In-Reply-To: <4c0f2379-7baf-7aa3-ab5f-a7046793d730@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0079.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::23) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e8a8862-0899-4cea-ecde-08d7855ee9e7
x-ms-traffictypediagnostic: AM6PR08MB4913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB491343A2D4E303B440674B54F42D0@AM6PR08MB4913.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39840400004)(346002)(366004)(396003)(189003)(199004)(8936002)(52116002)(66946007)(186003)(64756008)(478600001)(2906002)(44832011)(26005)(8676002)(81156014)(6506007)(53546011)(81166006)(2616005)(5660300002)(6486002)(31696002)(4326008)(107886003)(86362001)(6512007)(71200400001)(110136005)(54906003)(316002)(31686004)(66476007)(66446008)(36756003)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4913;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ca93WmI1kTZo7RDKMZkzq1zBuRDlKGW6yOoiuGPF7riFMtCgry32kntR2NqFuZtz8U8dImafQaw867f5FzhtPak2BzBrn0PVxd18LKHkYFpooGZ4GgONPbsr3F1zgR8NQ+2Qt6pf0cycvQZ7JC2eK3i/i3TUmtfnEiiwYwp464woqEJd3m5k0qHo3tVkImQCCMPNb769UAs8fBdeJa6gal4zDWUIGGzojyRGmrAW2VkWQluIlB+LOKIpNvB3Fgbang/bImg3NZ58i4BTSJctUHlhFAkKTaOo+inIZ6YAlhlpuDzKvSo0vsMLLjiyrMybrTVCWaMUKha3eZQ+dgx/H0KiQ199I5ipGbjfEXmFxhXkuQa1b0msWciaXu2WdtFBohyTTxCU7NT/oxpjlC+WCs3Kb3GWo2z3QMx6Y7BiKW4VsW90iL4d7w63tPEOlxM5
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EA7E083B1974194CA9A175A4F49F0AC0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8a8862-0899-4cea-ecde-08d7855ee9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 15:11:39.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f80iAskM+uPgRL+faUKgia9IrdkZFRmKViXpG03M03/GpqVzQQq9MYapjnDfCpP6qKHDiCp53n/DITlg9Uo7aw8u0hTo2NiFIT6tlr5cGew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4913
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.138
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 20/12/2019 17:52, Max Reitz wrote:
> On 02.12.19 13:15, Andrey Shinkevich wrote:
>> Allow writing all the data compressed through the filter driver.
>> The written data will be aligned by the cluster size.
>> Based on the QEMU current implementation, that data can be written to
>> unallocated clusters only. May be used for a backup job.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/Makefile.objs     |   1 +
>>   block/filter-compress.c | 168 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   qapi/block-core.json    |  10 +--
>>   3 files changed, 175 insertions(+), 4 deletions(-)
>>   create mode 100644 block/filter-compress.c
>=20
> [...]
>=20
>> diff --git a/block/filter-compress.c b/block/filter-compress.c
>> new file mode 100644
>> index 0000000..4d756ea
>> --- /dev/null
>> +++ b/block/filter-compress.c
>> @@ -0,0 +1,168 @@
>=20
> [...]
>=20
>> +static int compress_open(BlockDriverState *bs, QDict *options, int flag=
s,
>> +                         Error **errp)
>> +{
>> +    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file=
, false,
>> +                               errp);
>> +    if (!bs->file) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!bs->file->bs->drv || !block_driver_can_compress(bs->file->bs->=
drv)) {
>> +        error_setg(errp,
>> +                   "Compression is not supported for underlying format:=
 %s",
>> +                   bdrv_get_format_name(bs->file->bs));
>=20
> bdrv_get_format_name() returns NULL if bs->file->bs->drv is NULL.  I=92m
> sure g_strdup_vprintf() handles %s with a NULL string gracefully in
> practice, but I can=92t find that specified anywhere.  So even though I=
=92m
> well aware I=92m being a bit stupid about a minor edge case, I=92m hesita=
nt
> to accept this patch as-is.
>=20
> Obviously the solution can be as simple as bdrv_get_format_name(...) ?:
> "(no format)".
>=20
> Well, actually, I can be a bit less stupid about it and just propose
> merging that change in myself.  Would that be OK for you?

Yes, please.
Thank you, Max.

Andrey

>=20
> (The rest looks good to me.)
>=20
> Max
>=20

--=20
With the best regards,
Andrey Shinkevich


