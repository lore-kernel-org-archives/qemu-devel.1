Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019AC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2952072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e8WhmZSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2952072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMEx-0005F7-8v
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGMDs-0004TT-VT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGMDr-0001bD-Ey
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:30:28 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com
 ([40.107.4.92]:62215 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jGMDm-0001Xd-Ke; Mon, 23 Mar 2020 08:30:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfRpdCvqvchJuLdwW8QCR/x72ot1+ffzmQHuVjVAzhbHHdiiVqXMQ+lQAynsrdEt/hHDrqZpCto54YUkh2liu6rfDiFxZoZFsTcaVMsrgCWRNnt9M5QVisODOCEc2+++armIamaw8QLvKoTBG6RXZ3QfQt5y88vgcmx3ChbQsUwzST1+caBqImgFs0cCb5OdWBDuu3I514a0Wd5V7UhL6FnZmTr4b8TlGO237RKcqZbBDOuaaMxCyk+QNNW0fUQNsXZB8HZgH5Jo2HtOk4YKlsTG8kRDaUSbhZk33YOJdHqHqySaMCyj6mkG/viEpP/IEEnpPbAove7YIqS5BZNktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FolWKZtU2Hbs5IXuF50jC6ThkF8wBaBxK8nhe53tcF8=;
 b=ZA7e2EQY5VH2KmnYxc+HohjKKxojwZkli2PaK944RzEQ5C4gDziFSJ3xjlElsPRmTGkQzg/g/sfp2JwsDPtKvpobZwEh6PoIbeNj3DAE4vvs0yC3IHkPSSSUfZE+UF3yCrhrfhb4VYqZsJ7RCKykvGsCCfA4GBdtEHWyrp9jmTL6LC/d7hekzTy3ZBpk8fxNdXadL9ksXaEG2qmyRlltA8DbXr5A2KnTmzwTIxpNcurWL7yDqNZnMdKlridJS0Sx0Vl5YRubDcQu6Ynl1pY96xnWrFJElvbCPKM2H53vbM0SNO9NPs/RvigQAYBMuXuebN57wyg6tdZIQK8PjBG/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FolWKZtU2Hbs5IXuF50jC6ThkF8wBaBxK8nhe53tcF8=;
 b=e8WhmZSxNivZwkLmyR7HfFksX1IrurawhNNx7VX2wdcgE1pOYxSK9aU/2GNpzwKt5Y6PFNY9oodoeTi3/wOlwj/Sf99pKGj/Yn2pcEXDqfqv8Y9sUr++ZIniREjEk27wS0K7PK32kgAUSnW4eS4/lpLfvvXrICE5SsErvrxgyKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.80.91) by
 VI1PR08MB3277.eurprd08.prod.outlook.com (52.134.31.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Mon, 23 Mar 2020 12:30:18 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:30:18 +0000
Subject: Re: [PATCH v8 1/4] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-2-dplotnikov@virtuozzo.com>
 <401c0627-a7ad-3434-a861-69f4a5d58d21@virtuozzo.com>
 <ea557760-b2a5-db20-cb48-fa94a4a2d1e9@virtuozzo.com>
 <b263d14d-b667-898f-8757-f9363d126c29@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <274152bd-10ea-ded3-7427-50861b4585a9@virtuozzo.com>
Date: Mon, 23 Mar 2020 15:30:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <b263d14d-b667-898f-8757-f9363d126c29@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0301CA0013.eurprd03.prod.outlook.com
 (2603:10a6:3:76::23) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:c1::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.255.82.30) by
 HE1PR0301CA0013.eurprd03.prod.outlook.com (2603:10a6:3:76::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 12:30:17 +0000
X-Originating-IP: [94.255.82.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6c7f69-fe11-4001-cd02-08d7cf25f22b
X-MS-TrafficTypeDiagnostic: VI1PR08MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3277E41AB3719B9F407769D1CFF00@VI1PR08MB3277.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39840400004)(376002)(136003)(366004)(346002)(199004)(86362001)(52116002)(186003)(6666004)(53546011)(2906002)(26005)(16526019)(36756003)(8936002)(6486002)(5660300002)(31696002)(66946007)(31686004)(8676002)(66556008)(81166006)(81156014)(66476007)(316002)(956004)(4326008)(478600001)(16576012)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3277;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPg6lY6IK4ZCikktoo/oPAlb5Icm1kSjH5EC4iDcEyfmFrpUzBA09Srv9DwJY4NDmNh6kRMXbNm9sdJXnBwOWM1rTc7FNE1ulJ41K0n74NxqMInmy+r0rIGeTnhmu8IDlOljPzZOmlkno3NVHPfaomKoQNHax18KZUAG8JaPmnLzAxX/iA2YsR5e+6VM+LPbnpQRfc3XEHnxXQQmiY8+FHoGATw5ZXc1sVUZ7yH7s+ZYfFQt//gQtcqf6IQg6ye9bMBO9Ged0xxzxMyzHtq85ZuEScTpyg13Zk4LQbObwC1ExXqbgJ8UJwic4/76ou0gsAsTxoKThxOLH0740z+TDQSQ9tVZWIbObMqu6dZUELU85kaTF2S04QFGW28cAMazDZ+qFwmX+VbuAAFPqxh790Pvi+X38fGH3mxDSXCp6QCdb3ClOv+gxv1LhdmfPaVA
X-MS-Exchange-AntiSpam-MessageData: Rq72eRAX8ZCwyvg3lw3rcnvbgPQ4O09R0FaPvwK4wZu0u3Lclr+Hw57hFQ7gJqYQBmvodmsB7qHPVQCGNwoZ2vXRaaDhKjVsKFK4JE5FrpcgdZW+rtRg4K9xmwocKw84baoa8F2dS+1oaX0LlyWeiw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6c7f69-fe11-4001-cd02-08d7cf25f22b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:30:18.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTzFxMNmVjBIEgwMw3AFfnK3gbxZy/sTItNhcN4nkgYI5PKtpalVFYQ8fa3qpTJfDTS5FxSEPConBfL6BihRd1zLqAsGAVspUmYHsickrJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3277
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.92
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23.03.2020 15:26, Vladimir Sementsov-Ogievskiy wrote:
> 23.03.2020 15:22, Denis Plotnikov wrote:
>>
>>
>> On 23.03.2020 11:00, Vladimir Sementsov-Ogievskiy wrote:
>>> 21.03.2020 17:34, Denis Plotnikov wrote:
>>>> The patch adds some preparation parts for incompatible compression=20
>>>> type
>>>> feature to qcow2 allowing the use different compression methods for
>>>> image clusters (de)compressing.
>>>>
>>>> It is implied that the compression type is set on the image=20
>>>> creation and
>>>> can be changed only later by image conversion, thus compression type
>>>> defines the only compression algorithm used for the image, and thus,
>>>> for all image clusters.
>>>>
>>>> The goal of the feature is to add support of other compression methods
>>>> to qcow2. For example, ZSTD which is more effective on compression=20
>>>> than ZLIB.
>>>>
>>>> The default compression is ZLIB. Images created with ZLIB=20
>>>> compression type
>>>> are backward compatible with older qemu versions.
>>>>
>>>> Adding of the compression type breaks a number of tests because now=20
>>>> the
>>>> compression type is reported on image creation and there are some=20
>>>> changes
>>>> in the qcow2 header in size and offsets.
>>>>
>>>> The tests are fixed in the following ways:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 * filter out compression_type for many tests
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 * fix header size, feature table size and bac=
king file offset
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 031, 036, 061, 08=
0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_size +=3D8: 1 byte compres=
sion type
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 byt=
es padding
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_table +=3D 48: incompatib=
le feature compression type
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_file_offset +=3D 56 (8 + =
48 -> header_change +=20
>>>> feature_table_change)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 * add "compression type" for test output matc=
hing when it=20
>>>> isn't filtered
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 049, 060, 061, 06=
5, 144, 182, 242, 255
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> @@ -4859,6 +4949,7 @@ static ImageInfoSpecific=20
>>>> *qcow2_get_specific_info(BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .data_file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D g_strdup(s->image_data_file),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .has_data_file_raw=C2=A0 =3D has_data_file(bs),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .data_file_raw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D data_file_is_raw=
(bs),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .c=
ompression_type=C2=A0=C2=A0 =3D s->compression_type,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if this asse=
rtion fails, this probably means a new=20
>>>> version was
>>>> @@ -5248,6 +5339,22 @@ static int=20
>>>> qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "images");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(desc->n=
ame, BLOCK_OPT_COMPRESSION_TYPE)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t compression_type =3D
>>>> + qapi_enum_parse(&Qcow2CompressionType_lookup,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_get(opts,=20
>>>> BLOCK_OPT_COMPRESSION_TYPE),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1, errp);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (compression_type =3D=3D -EINVAL) {
>>>
>>> You should compare to -1, as qapi_enum_parse returns given default=20
>>> on error.
>> ok
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unknown compression type");
>>>
>>> and errp is already set (ofcourse, if qemu_opt_get returned non=20
>>> NULL, but I hope it is guaranteed by if (!strcmp(desc->name,=20
>>> BLOCK_OPT_COMPRESSION_TYPE)) condition
>> I wouldn't propagate the error from qapi_enum_parse because it looks=20
>> like "invalid parameter value: foo". I think it's better to print=20
>> "Unknown compression type: foo"
>
> No objections. Then you should pass NULL to qapi_enum_parse instead of=20
> errp. (As you can't set errp twice, second try will crash).
ok
>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (compression_type !=3D s->compression_type) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Changing the compression type "
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "is not supported");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* if this point is reached, this probably means a=20
>>>> new option was
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * added without having it covered here */
>>>> @@ -5516,6 +5623,12 @@ static QemuOptsList qcow2_create_opts =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .help =3D "Width of a reference count entry in bits",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .def_value_str =3D "16"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D BLOCK_OPT_COMPRESSION_TYPE,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_STRING,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .h=
elp =3D "Compression method used for image cluster=20
>>>> compression",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .d=
ef_value_str =3D "zlib"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of lis=
t */ }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 };
>>>
>>>
>>> [...]
>>>
>>>
>>
>
>


