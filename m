Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95EDC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F682166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NqKmsR5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F682166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jI8-00011B-J3
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8jGb-0008SN-DA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8jGZ-0007Uz-Fi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:29:45 -0500
Received: from mail-ve1eur02on0730.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::730]:11798
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j8jGV-0007TO-An; Mon, 02 Mar 2020 06:29:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M66yGC/upUXvUPSg+02EviqH399nF/AhrwkYHPBxyPO+AW5L7LNgG9N/etuvOOFxoE6APirSWaewS3TqZdYVZeRkG7qYREKJ9rFRhiGRsWv5o2YZM4adDBBKFsJHZZtSL8ScXib9wbgBKv4jcu58vObOX2RRp+D1PIBRSx7sLdCmw6WxOGImgQWJWsG/GTyHlX2ROY9Bzp21kjRiwbPQP05VRscMACaLCscksIx92UMbnqLjGPP+6Hr1o4fTfPP6ZYP2Ze5UK88vRAYw5DYPy7hIne4CqJZE4x0EDZwi0yU+XZEWDMFTnlrzSin6kVe8cGkMmb3p9PvghUTU5S8iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odk9I3BvcNcrXdP6AnZ++f7rJUQyJyyhFl6elpgUOTE=;
 b=N1+IcOJLE/VrPdyxo9b5YBVST/qECMbiJXdNru4RuPKY7HxdFg9QNVjOP9Zn87PwlpIGuj3gOYg7S3IWqTJbzudImVpNcxTmHTe59qwauCuCXKp+NLOyF78oXD4PZ/fr6wvfOBI+ClgKgu6U85DYE6WVZX7QQstYgAfLYMcL7X0TBieYWuRA+oe4GZ6eMDtwa5MxY2mkRZfOvG1uFEuFEe5nD0+CxXAmv+1gipxERy/s+DRh83kQjrU9vl861ne2SxW8G/820qOMIVC9iYKVVwPU2RT9fSL22CZX+pXZ2C0+8ZWoUawMMQvqmxjPPJ8AKyg5ouhbCUJLyjnHnMxL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odk9I3BvcNcrXdP6AnZ++f7rJUQyJyyhFl6elpgUOTE=;
 b=NqKmsR5zHEqx4KvcnVunTDKPYgauukEgTjv0froa57Eavwb8RIMB5jJACiYzLx2WUftQbAv45kqtIh2duKoKFfX22Cjv8iatXEjCQ2aHwYX823aY/4TJZFcDF/EimuQuYExn3MiCwyf8cZTN55TUAxW55Dp2m5ciMrGjCBHoAHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4498.eurprd08.prod.outlook.com (20.179.33.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 11:29:35 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 11:29:35 +0000
Subject: Re: [PATCH v2 1/4] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
 <20200302082111.21205-2-dplotnikov@virtuozzo.com>
 <6190af16-d08e-fb0b-f090-a3d64986a960@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <93ef1524-5243-42a4-df09-27230cbda186@virtuozzo.com>
Date: Mon, 2 Mar 2020 14:29:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <6190af16-d08e-fb0b-f090-a3d64986a960@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:7:15::17) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.179) by
 HE1PR0902CA0028.eurprd09.prod.outlook.com (2603:10a6:7:15::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 11:29:34 +0000
X-Originating-IP: [178.34.150.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88e68a0-eced-4ca2-299f-08d7be9cfc15
X-MS-TrafficTypeDiagnostic: AM0PR08MB4498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB44987C251482FCF50E3130EACFE70@AM0PR08MB4498.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(39850400004)(366004)(136003)(189003)(199004)(19627235002)(316002)(6486002)(2616005)(8676002)(81156014)(66476007)(478600001)(66556008)(66946007)(81166006)(8936002)(6666004)(2906002)(86362001)(4326008)(52116002)(31696002)(5660300002)(31686004)(53546011)(26005)(16526019)(186003)(16576012)(956004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4498;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IBYpNPmNlDaJWPY+Ql6a9krUXKfhhGBWwknJ7YCCkczlAYHTB6spQ5NAqqSg1E+GgjgMWMgEWmayFr3e0wnuHi3h5aSVmEx6+whXv38ukLZFa4sZDdnnDrksELPd3mO/Xl7w2Y1SBiEdSCfNL7OO4ySh8+04wDcB1r2AYMHdKMM3/My8QFGCNzdMY6+w2HqMbReSDV22j5Pyu2/KChLJtEoioyNzQPJTTpdKM+Dkqujr1JsPTbRxZZYJ0TEgnkqSbMHeZYX6N4v6TixL28w/Fa1jloDXaIynJWH7+D27dW79joo4mnUpzpWVAsug/yTnZBbXIsBpGdK+DW/FKqOVHqvWk6Wye6LazK0KxRcNEW6fMFw5EzT0d/sxJPzdWBfrg7Nv8kx3ggrFT1C+FZ22Sf/udn6SaS3Bj67YM459dA8/bDB4vXQW6Ktb9BMAvNs
X-MS-Exchange-AntiSpam-MessageData: foGXLZoKBWk3DY4/MHP/n4kNoXIuGYoQEOlAwICSlU3st9P6L29XLcBgO3RI/Nex+dIdZ0HVcDlJl4EjkWfwyHOQOeQQIRxms1i1SsqoLlw02Y3PvPUXGKp/uzgu1v7ymTzBUa6fyAEDJ3b50FSw9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e68a0-eced-4ca2-299f-08d7be9cfc15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 11:29:35.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0XUqbfiaUTvzA1dKJeBiaX5vIcIgGVfGTYbTHnkPn1nybETdCwzOQK/uMlqaNhwb7gc0E2Woy3bCBraGWIP9pAyezzXr/VNMZbdtOoJmc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::730
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
Cc: kwolf@redhat.com, den@openvz.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.03.2020 14:24, Vladimir Sementsov-Ogievskiy wrote:
> 02.03.2020 11:21, Denis Plotnikov wrote:
>> The patch adds some preparation parts for incompatible compression type
>> feature to qcow2 allowing the use different compression methods for
>> image clusters (de)compressing.
>>
>> It is implied that the compression type is set on the image creation and
>> can be changed only later by image conversion, thus compression type
>> defines the only compression algorithm used for the image, and thus,
>> for all image clusters.
>>
>> The goal of the feature is to add support of other compression methods
>> to qcow2. For example, ZSTD which is more effective on compression=20
>> than ZLIB.
>>
>> The default compression is ZLIB. Images created with ZLIB compression=20
>> type
>> are backward compatible with older qemu versions.
>>
>> Adding of the compression type breaks a number of tests because now the
>> compression type is reported on image creation and there are some=20
>> changes
>> in the qcow2 header in size and offsets.
>>
>> The tests are fixed in the following ways:
>> =C2=A0=C2=A0=C2=A0=C2=A0 * filter out compression_type for all the tests
>> =C2=A0=C2=A0=C2=A0=C2=A0 * fix header size, feature table size and backi=
ng file offset
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 031, 036, 061, 080
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_size +=3D8: 1 byte compressi=
on type
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 bytes =
padding
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_table +=3D 48: incompatible=
 feture compression type
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_file_offset +=3D 56 (8 + 48=
 -> header_change +=20
>> fature_table_change)
>> =C2=A0=C2=A0=C2=A0=C2=A0 * add "compression type" for test output matchi=
ng when it isn't=20
>> filtered
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 049, 060, 061, 065,=
 144, 182, 242, 255
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>
> I'm almost OK with this patch. Some notes below and:
>
> Seems, new option should be handled in qcow2_amend_options among other=20
> unsupported ones (otherwise qcow2_amend_options aborts).
>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 ++++++-
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 =
++++-
>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 109 +++++=
++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/031.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 ++--
>> =C2=A0 tests/qemu-iotests/036.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/049.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
102 ++++++++++++++---------------
>> =C2=A0 tests/qemu-iotests/060.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 tests/qemu-iotests/061.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 34 ++++++----
>> =C2=A0 tests/qemu-iotests/065=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++---
>> =C2=A0 tests/qemu-iotests/080=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/qemu-iotests/144.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/182.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/qemu-iotests/242.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 ++
>> =C2=A0 tests/qemu-iotests/255.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +--
>> =C2=A0 tests/qemu-iotests/common.filter |=C2=A0=C2=A0 3 +-
>> =C2=A0 16 files changed, 255 insertions(+), 94 deletions(-)
>>
>
> [..]
>
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t refcount_order;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t header_length;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Additional fields */
>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 compression_type;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* header must be a multiple of 8 */
>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 padding[7];
>> =C2=A0 } QEMU_PACKED QCowHeader;
>> =C2=A0 =C2=A0 typedef struct QEMU_PACKED QCowSnapshotHeader {
>> @@ -216,13 +222,16 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_DIRTY_BITNR=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_CORRUPT_BITNR=C2=A0=C2=A0=
=C2=A0 =3D 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_DATA_FILE_BITNR=C2=A0 =3D =
2,
>> +=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_COMPRESSION_BITNR=3D 3,
>
> checkpatch complains. I think, you can just use one space before '=3D'=20
> and don't
> care about alignment.
ok
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_DIRTY=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1 << QCOW2_INCOMPAT_DIRTY=
_BITNR,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_CORRUPT=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_CORRUPT_BITNR,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_DATA_FILE=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_DATA_FILE_BITNR,
>> +=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_COMPRESSION=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_COMPRESSION_BITNR,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_INCOMPAT_MASK=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D QCOW2_INCOMPA=
T_DIRTY
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | QCOW2_INCOMPAT_CORRUPT
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | QCOW2_=
INCOMPAT_DATA_FILE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | QCOW2_=
INCOMPAT_DATA_FILE
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | QCOW2_=
INCOMPAT_COMPRESSION,
>> =C2=A0 };
>> =C2=A0 =C2=A0 /* Compatible feature bits */
>> @@ -369,6 +378,13 @@ typedef struct BDRVQcow2State {
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool metadata_preallocation_checke=
d;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool metadata_preallocation;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Compression type used for the image. Default=
: 0 - ZLIB
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The image compression type is set on image c=
reation.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The only way to change the compression type =
is to convert the=20
>> image
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with the desired compression type set
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 Qcow2CompressionType compression_type;
>> =C2=A0 } BDRVQcow2State;
>> =C2=A0 =C2=A0 typedef struct Qcow2COWRegion {
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 6f9fd5e20e..2c6bb9dc99 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -57,6 +57,7 @@
>> =C2=A0 #define BLOCK_OPT_REFCOUNT_BITS=C2=A0=C2=A0=C2=A0=C2=A0 "refcount=
_bits"
>> =C2=A0 #define BLOCK_OPT_DATA_FILE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "data_file"
>> =C2=A0 #define BLOCK_OPT_DATA_FILE_RAW=C2=A0=C2=A0=C2=A0=C2=A0 "data_fil=
e_raw"
>> +#define BLOCK_OPT_COMPRESSION_TYPE=C2=A0 "compression_type"
>> =C2=A0 =C2=A0 #define BLOCK_PROBE_BUF_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 512
>> =C2=A0 diff --git a/block/qcow2.c b/block/qcow2.c
>> index 3c754f616b..fc5232a5d6 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1242,6 +1242,50 @@ static int=20
>> qcow2_update_options(BlockDriverState *bs, QDict *options,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +static int validate_compression_type(BDRVQcow2State *s, Error **=
errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Sanity check
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * according to qcow2 spec, the compression typ=
e is 1-byte field
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * but in BDRVQcow2State the compression_type i=
s enum sizeof(int)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so, the max compression_type value is 255.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (s->compression_type > 0xff) {
>
> This code is unreachable, I'd prefer assertion.
Hm, it shouldn't be here. I'll remove it.
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "qcow2: com=
pression type value is too big");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "qcow2: unk=
nown compression type: %u",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->compression_type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if the compression type differs from QCOW2_C=
OMPRESSION_TYPE_ZLIB
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the incompatible feature flag must be set
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (s->compression_type =3D=3D QCOW2_COMPRESSION_TYP=
E_ZLIB) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->incompatible_features=
 & QCOW2_INCOMPAT_COMPRESSION) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "qcow2: Compression type incompatible=20
>> feature "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "bit must not be set");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(s->incompatible_featur=
es & QCOW2_INCOMPAT_COMPRESSION)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "qcow2: Compression type incompatible=20
>> feature "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "bit must be set");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>
>
> [..]
>
>> @@ -3379,6 +3453,27 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (qcow2_opts->has_compression_type &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcow2_opts->compression_type=
 !=3D QCOW2_COMPRESSION_TYPE_ZLIB) {
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (version < 3) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "Compression type is only supported with "
>
> Hmm. "Non-zlib compression type is only.." would be a bit more honest :)
valid.=C2=A0 to be changed.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "compatibil=
ity level 1.1 and above (use=20
>> version=3Dv3 or "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "greater)")=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (qcow2_opts->compress=
ion_type) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "Unknown compression type");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compression_type =3D qcow2_o=
pts->compression_type;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>
>
> [..]
>
>> --- a/tests/qemu-iotests/065
>> +++ b/tests/qemu-iotests/065
>> @@ -88,23 +88,25 @@ class TestQMP(TestImageInfoSpecific):
>> =C2=A0 class TestQCow2(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 2 image'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D0.10'
>> -=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits'=
: 16 }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'refcount bits: =
16' ]
>> +=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits'=
: 16,=20
>> 'compression-type': 'zlib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'compression typ=
e: zlib',=20
>> 'refcount bits: 16' ]
>
> over-80 line (and several below).
>
>> =C2=A0 =C2=A0 class TestQCow3NotLazy(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with l=
azy refcounts disabled'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Doff'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'lazy=
-refcounts': False,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts: =
false',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression type=
: zlib', 'lazy=20
>> refcounts: false',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcoun=
t bits: 16', 'corrupt: false' ]
>> =C2=A0 =C2=A0 class TestQCow3Lazy(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with l=
azy refcounts enabled'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Don'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'lazy=
-refcounts': True,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts: =
true',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression type=
: zlib', 'lazy=20
>> refcounts: true',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcoun=
t bits: 16', 'corrupt: false' ]
>
> [..]
>
>


