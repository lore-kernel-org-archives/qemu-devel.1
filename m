Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6214EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7FB206B1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VwGiaBJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7FB206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlSB-0002x6-G3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jDksy-0006da-7L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jDksw-0003HN-7W
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:14:08 -0400
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com
 ([40.107.21.134]:34784 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jDksk-000131-B3; Mon, 16 Mar 2020 04:13:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF1oSuuX+AfWSKZTmDNUvY2OWSLbUgzXe18KxyBDWeDD3L4v7jLPiHuqx9BS7h5iKSF0rY+PXqqHsWiAyfYum7UXDMH2nVg0MMcnXH1KpCz0bcyxmUfBYBo6Q+9qUvw/SWoMxlTTA9Vywns2hVj3wTgee0Lf8jaMewf/xnHL3Q7+86c5eh3YaSh8jnZFMweYrClOWmPpZlAHVlG49jKgbJZ/e/ztwFAfvYJvUCZvIsPrJd72rjOHRD0tvEC1goHFqDZAOEXiXiV2vhEu/5LoAd/Lg8QLaQSRPpgJFqhecE+YfUlqpaH+gqsXd5+k7XI9ppSatfo5mupmqN7HRvs4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsYBij0BnJLoRxTj/HY6xNmJwZChr8lPOYBcL7qjkuM=;
 b=JOJDbFSEvW5pkTLGOe7OEZrqVk4g3py5teCmjdTon3R1EnkNDkuKE72AtG8CUEXMLZhIWG+Ukqp+D2tft5i0RfWZX2qJUi6/ofEIgAWkK+isq8nKFbQF/O2xc+aLSk7nVCtNcEEDApwN3rDW8HDww5b+oTprA8FhG/JKf7wT9rCsS230lSDeNVEKvixDqVJGrIvKZsBOdyPf2f/Gb2kFq/WUva3wsRq+2FJ5xa/zExyVGf8fBcMnuuBeU+Oml/qZmwe/TxNTc4htGqAHpZl2bPwh/zpQNRSncESvAIaCBn8kTin+Cz+m68LuZi122EKfi1N2JoDxDf2uJt1YVUtWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsYBij0BnJLoRxTj/HY6xNmJwZChr8lPOYBcL7qjkuM=;
 b=VwGiaBJPhaaf3OdgJ3BY1NappqIOWyEWg9L/eRyAUW8F8ROd/fYpihOkdVdSKh8XkQNkZcRZvAzGmyQFBvQWb6buH+6Tm475fMKoENNphw1CW11xI0jM1y7ays6mKdXvYkebJlKJ1hhAewqTTsphf4lO7bi7uyoeS49lsFNgf2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0SPR01MB0023.eurprd08.prod.outlook.com (52.133.59.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 16 Mar 2020 08:13:47 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 08:13:47 +0000
Subject: Re: [PATCH v6 1/4] qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
 <20200312092242.5536-2-dplotnikov@virtuozzo.com>
 <fb17996c-1c96-353d-a537-748bd05b94ff@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <dfb93a47-309b-84c0-a6b6-f85606e28147@virtuozzo.com>
Date: Mon, 16 Mar 2020 11:13:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <fb17996c-1c96-353d-a537-748bd05b94ff@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0101CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::33) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.240.15) by
 HE1PR0101CA0023.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Mon, 16 Mar 2020 08:13:44 +0000
X-Originating-IP: [94.233.240.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1ab0f34-0af8-4c28-7864-08d7c981f2cc
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0SPR01MB0023F2ED6AE32195FD268ED6CFF90@AM0SPR01MB0023.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(199004)(107886003)(53546011)(4326008)(52116002)(66946007)(36756003)(66476007)(6666004)(66556008)(2616005)(956004)(6486002)(81166006)(31686004)(31696002)(478600001)(2906002)(86362001)(81156014)(16526019)(186003)(16576012)(26005)(316002)(8676002)(5660300002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0SPR01MB0023;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4RJNGqm3j+OldbapDznpSR6pGSybuB1KzsddkITC/UFF/9gGp0PaUi4Aj7+xGd8f99jN/gIf8gAxrkO3j0tq4llJ4pXlNH/15qXx511bReMu1ixx7Xy6J0Gm/nGBRaO9skjCMsGVZsJINnJFpf/wF8h9+MO+Gxy2dovHR6OYirgh12W5M0VAsbIGk1RP3Xece0ysiIE/Q6ltWwsl7T+DlTPuQgGwpvd0psEYg1XmpjNqLoj5JBZI6eRZIdK34qqJ8EwEaTlEupR2l1xbqXvqHkXbhGk/Znm7mpp1rQ9nDGONoIOTzwsWaIpP6+OXWBV50UhJHzVGlga1S7WR9+ii7WD7Kzb5o7fUcAcZNU4GjWzUeTRH0WhvXRKvO1brTeisEdG2aCG4lICUSuapu98e10e+7cnEPWJBqJR+QA0PcVbQg+A9c+UBvphpdLbY1k9
X-MS-Exchange-AntiSpam-MessageData: A10GtieHnTHcg9qzT6MHdNtq8uM0wP6H7VnXzxpvY3cy1di6ueg1a+4d/MHscFWhv4FD2dk8gjveggl0GFaVS2S+y9E1a9oMjQ0z98rTlEh9viIguv/mmQU5HZYSrVv6dT2pxYupeyljBtOlJhhpvg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ab0f34-0af8-4c28-7864-08d7c981f2cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 08:13:47.4065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVLSH6AoIDHC42mOm3UOi6pTx+ZS+lLUodrJZmtp+nTgMUpWwZ7XWb6DHf2O7/MBvERndf3rkU4z0f+E6T/K53nRSZxzfxscHOtgmlaustU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0023
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.134
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the comments.
I'll make the fixes accordingly and re-sent the series shortly.

Denis

On 14.03.2020 00:40, Eric Blake wrote:
> On 3/12/20 4:22 AM, Denis Plotnikov wrote:
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
>> =A0=A0=A0=A0 * filter out compression_type for all the tests
>
> Presumably this filter is optional, and we will not use it on the=20
> specific new tests that prove zstd compression works - but that should=20
> be later in the series, so for this patch it is okay.
>
>> =A0=A0=A0=A0 * fix header size, feature table size and backing file offs=
et
>> =A0=A0=A0=A0=A0=A0 affected tests: 031, 036, 061, 080
>> =A0=A0=A0=A0=A0=A0 header_size +=3D8: 1 byte compression type
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7 =
bytes padding
>> =A0=A0=A0=A0=A0=A0 feature_table +=3D 48: incompatible feture compressio=
n type
>
> feature
>
>> =A0=A0=A0=A0=A0=A0 backing_file_offset +=3D 56 (8 + 48 -> header_change =
+=20
>> fature_table_change)
>
> feature
>
> (interesting that you have two different changed spellings ;)
>
>> =A0=A0=A0=A0 * add "compression type" for test output matching when it i=
sn't=20
>> filtered
>> =A0=A0=A0=A0=A0=A0 affected tests: 049, 060, 061, 065, 144, 182, 242, 25=
5
>
> Or maybe the comment above should be changed to "many tests" rather=20
> than "all the tests".
>
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 qapi/block-core.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 22 +++=
++-
>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 20 ++++-
>> =A0 include/block/block_int.h=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 121 +++++++++++++++++++++++++++++++
>> =A0 tests/qemu-iotests/031.out=A0=A0=A0=A0=A0=A0 |=A0 14 ++--
>> =A0 tests/qemu-iotests/036.out=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +-
>> =A0 tests/qemu-iotests/049.out=A0=A0=A0=A0=A0=A0 | 102 +++++++++++++----=
---------
>> =A0 tests/qemu-iotests/060.out=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>> =A0 tests/qemu-iotests/061.out=A0=A0=A0=A0=A0=A0 |=A0 34 +++++----
>> =A0 tests/qemu-iotests/065=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 28 ++++---
>> =A0 tests/qemu-iotests/080=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>> =A0 tests/qemu-iotests/144.out=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +-
>> =A0 tests/qemu-iotests/182.out=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>> =A0 tests/qemu-iotests/242.out=A0=A0=A0=A0=A0=A0 |=A0=A0 5 ++
>> =A0 tests/qemu-iotests/255.out=A0=A0=A0=A0=A0=A0 |=A0=A0 8 +-
>> =A0 tests/qemu-iotests/common.filter |=A0=A0 3 +-
>> =A0 16 files changed, 275 insertions(+), 96 deletions(-)
>>
>
>> +++ b/block/qcow2.h
>> @@ -146,8 +146,16 @@ typedef struct QCowHeader {
>> =A0 =A0=A0=A0=A0=A0 uint32_t refcount_order;
>> =A0=A0=A0=A0=A0 uint32_t header_length;
>> +
>> +=A0=A0=A0 /* Additional fields */
>> +=A0=A0=A0 uint8_t=A0 compression_type;
>> +
>> +=A0=A0=A0 /* header must be a multiple of 8 */
>> +=A0=A0=A0 uint8_t=A0 padding[7];
>
> Why two spaces after uint8_t (twice)?
>
>
>> @@ -369,6 +380,13 @@ typedef struct BDRVQcow2State {
>> =A0 =A0=A0=A0=A0=A0 bool metadata_preallocation_checked;
>> =A0=A0=A0=A0=A0 bool metadata_preallocation;
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Compression type used for the image. Default: 0 - ZLIB
>> +=A0=A0=A0=A0 * The image compression type is set on image creation.
>> +=A0=A0=A0=A0 * The only way to change the compression type is to conver=
t the=20
>> image
>> +=A0=A0=A0=A0 * with the desired compression type set
>
> Missing trailing '.'.=A0 Maybe someday we can get 'qemu-img amend' to=20
> also adjust the compression type in-place; if that's something we=20
> think we might do, then this could be better worded as "For now, the=20
> only way to change...".
>
>> +++ b/block/qcow2.c
>> @@ -1242,6 +1242,48 @@ static int=20
>> qcow2_update_options(BlockDriverState *bs, QDict *options,
>> =A0=A0=A0=A0=A0 return ret;
>> =A0 }
>> =A0 +static int validate_compression_type(BDRVQcow2State *s, Error **err=
p)
>
>> +
>> +static int qcow2_compression_type_from_format(const char *ct)
>> +{
>> +=A0=A0=A0 if (g_str_equal(ct, "zlib")) {
>> +=A0=A0=A0=A0=A0=A0=A0 return QCOW2_COMPRESSION_TYPE_ZLIB;
>> +=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 }
>
> Why are you open-coding this?
>
> qapi_enum_parse(&Qcow2CompressionType_lookup, ct, -1, errp)
>
> should do what you use this for, and automatically updates itself when=20
> you add zstd to the qapi enum later.
>
>
>> @@ -3401,6 +3493,8 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_offset=A0=A0=A0=A0=A0 =3D cp=
u_to_be64(cluster_size),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_clusters=A0=A0=A0 =3D cpu_to=
_be32(1),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_order=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(refcount_order),
>> +=A0=A0=A0=A0=A0=A0=A0 /* don't deal with endians since compression_type=
 is 1 byte=20
>> long */
>
> endianness
>
>> +=A0=A0=A0=A0=A0=A0=A0 .compression_type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D compression_type,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .header_length=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(sizeof(*header)),
>> =A0=A0=A0=A0=A0 };
>> =A0 @@ -5516,6 +5631,12 @@ static QemuOptsList qcow2_create_opts =3D {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .help =3D "Width of a reference =
count entry in bits",
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .def_value_str =3D "16"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 },
>> +=A0=A0=A0=A0=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D BLOCK_OPT_COMPRESSION_TYPE,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QEMU_OPT_STRING,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .help =3D "Compression method used fo=
r image clusters=20
>> compression",
>
> s/clusters/cluster/
>
> Overall, getting closer. I assume this would go through Max's tree, if=20
> he has time to include it before soft freeze...
>


