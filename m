Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A9AC3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6471246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f181UCa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6471246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7b7n-0002pl-0C
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 03:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7b6k-0002Ch-83
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7b6h-0003ZF-QJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:34:54 -0500
Received: from mail-eopbgr80123.outbound.protection.outlook.com
 ([40.107.8.123]:35313 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7b6d-0003XQ-LX; Fri, 28 Feb 2020 03:34:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSnLQ+TR4f004J73U8spT4rd48RTDmyCOWn6jHH1JMP2xZfFCS+PI8lXKIzDc4cu7SJDxXH/1spsbjVtfueJD0f7silzsOlrV7fWo5hQxGI4VHb+JIPReQCzFFX+X/d+Gjvf7j3VJ5LfotTsg15GfzlF1iLD3Vg9vMcHCJtER5BlL6VLrUk+EyiVBcx9dXQR/47xVRzGhKy5dShtP5XKi6ojLlSJD3uygYthjZiuUNofhHReairOpuZWBcsZsUGfke/7vbMEsCwahvqvJAgz0NcdewAi+571dhOWv74Q8Qb629pyRtVSVL6qxUFPnX7ZR5yTEKD5icADIJhqgayVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kamC0eFXvwtiBXOB22upD+B0Fk1h+5AFADRBdNV2aXk=;
 b=TYM8/s3UzoaTaUM+qMVJlpDW3wq9WwLbnedhdyOEuSnu8d1qPDXDd+WvZIi9p4KUTQEPE5a1w+PS6CosxgxlPIawE2iX3Gb5sAw72M6m3reLuZGzmfDBHUL+oezvC0gOyKjfAS0buHwzZsu1AKC03xRwDOjsItH15HLMw+WqtkpbcrqQ27X83tBxLre3ONY4cKvfSBG42PZbWcDsw2zpQ3EVeY22L1TMHNOMjAvopvVGWN/6lZF14eS/vcT3tLYlCYYurA5ifaD8Q73S/O6lDE04maLy1vE1UYrJKF4tXxCD5YAcVh5Pmx6U86gnjTj5z8U1p0z2K2NnDhFkJRkH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kamC0eFXvwtiBXOB22upD+B0Fk1h+5AFADRBdNV2aXk=;
 b=f181UCa8X636kwLran0S8OLkzIbx6FhTNmtrmeTAoDCCsg1bJ4fkmY0jv/YZrBEK7FroDU6x1le0MHOkHzmZaqrYX+G2Y+aWvla5ovw6BsZ9vjrlDutaWhkmcI1vsFjwQ/IhdBSJhrJCwUwAapwAS/Idz+iPXfEXk3l/ZurkX+Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3618.eurprd08.prod.outlook.com (20.177.109.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 28 Feb 2020 08:34:45 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 08:34:45 +0000
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <80b3d37d-9b20-de09-c8f4-9ac1a37c847f@virtuozzo.com>
Date: Fri, 28 Feb 2020 11:34:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR07CA0047.eurprd07.prod.outlook.com (2603:10a6:7:66::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Fri, 28 Feb 2020 08:34:44 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1df2ee-f8fa-4b7b-d9b2-08d7bc29107a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36185C0F89547B0B0733CD70CFE80@AM0PR08MB3618.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(186003)(956004)(316002)(16576012)(2616005)(26005)(66476007)(53546011)(66556008)(66946007)(52116002)(30864003)(5660300002)(2906002)(16526019)(107886003)(86362001)(4326008)(6486002)(36756003)(6666004)(31696002)(478600001)(966005)(8936002)(81166006)(81156014)(8676002)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3618;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kVnr7QQw6yZbRrzwJ9N1ufhn1D2Zj3fe7nR8TafB0jFefKJeWKowhaf5X5IwyjoIrWpkGGILzzdfvfzYZsEr1ucKzpiUVHNGEfdBsAb0bJRHOoGatgzG4ewZTkzxOupNvib8uUjIJ3U+9zvIJy1ybsfq7dFgPYtdeksmNur/TYiQnM+vSocYIybr75zp2BbUTxIpDyKQTYqi2reKbQnyniiQYVCg0vjZJjzNSmCwj54Dn4uhMxX1E2cSJOltW3My0+AVMNOxhBpVaK55o4njP/i5BtYRGpW/0JoyyB8vh7vvrMh8/QOf6Vs9MvOUiW5q2SWFJ6I4MZdVcjNOnwzzBH+QyCKXVykzRRBk40tVcD+LEbxc14HkCqbQLPN5Wej51F7qDHl0F4t00frvhg+H9vihmxwqlSXzT9R6a/M2b2zKvbAkq7htUtzVUoa/W8EkyfxyIaAEYSX+6Z5TbVoDjspQUZODNkJUEka5nFKil5vbGPNFAASwPsXi9ZTEbf7NybZbOg0gISHdhK5FKYD1w==
X-MS-Exchange-AntiSpam-MessageData: r2qHzFsj3v79mxDi3O4yXeYCvp6YK0LIBoXF3mB9n45nIzMmE7P7j8dEgtzxPXEEyCEByHzCTl1N21d9slzCfWAsnlEwIgOgMpzIe+zxig5Tw/wcy11cbV+UifzYo/SRq5+Kw6w/+SD1c+SS7QsScQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1df2ee-f8fa-4b7b-d9b2-08d7bc29107a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 08:34:45.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cudil7OqzQu6N9okOZ7s8ld2/7DNW5Kl3MkhyvrhdeWA/2gqa85TGz9h/W7KUBhDMyWEUTpZKOQqdW6wCPcIlZRBAu9F1fSZ8T/OmV8/JjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3618
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.123
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.02.2020 16:48, Eric Blake wrote:
> On 2/27/20 1:29 AM, Denis Plotnikov wrote:
>> The patch adds some preparation parts for incompatible compression type
>> feature to Qcow2 that indicates which allow to use different compression
>
> to qcow2, allowing the use of different
>
>> methods for image clusters (de)compressing.
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
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 105 ++++++++++++=
++++++++++++++++++++++++++
>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 31 ++++++++--=
-
>> =A0 include/block/block_int.h |=A0=A0 1 +
>> =A0 qapi/block-core.json=A0=A0=A0=A0=A0 |=A0 22 +++++++-
>> =A0 4 files changed, 150 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 3c754f616b..2ccb2cabd1 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1242,6 +1242,50 @@ static int=20
>> qcow2_update_options(BlockDriverState *bs, QDict *options,
>> =A0=A0=A0=A0=A0 return ret;
>> =A0 }
>> =A0 +static int validate_compression_type(BDRVQcow2State *s, Error **err=
p)
>> +{
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Sanity check
>> +=A0=A0=A0=A0 * according to qcow2 spec, the compression type is 1-byte =
field
>> +=A0=A0=A0=A0 * but in BDRVQcow2State the compression_type is enum sizeo=
f(int)
>> +=A0=A0=A0=A0 * so, the max compression_type value is 255.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (s->compression_type > 0xff) {
>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: compression type value i=
s too big");
>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 }
>
> Hmm - I think it may be worth a tweak to qcow2.txt to call out:
>
> 104: compression_type
> 105 - 111: padding, must be 0
>
> or else call out:
>
> 104-111: compression type
>
> and just blindly use all 8 bytes for the value even though really only=20
> 1 or two values will ever be defined.=A0 Of course, that moves the byte=20
> in question from 104 to 111, thanks to our big endian encoding, but as=20
> this series is the first one installing a non-zero value in those 8=20
> bytes, and as we just finished documenting that the header length must=20
> be a multiple of 8, there is no real impact - we can make such tweaks=20
> up until the 5.0 release.
>
>> +
>> +=A0=A0=A0 switch (s->compression_type) {
>> +=A0=A0=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +=A0=A0=A0=A0=A0=A0=A0 break;
>> +
>> +=A0=A0=A0 default:
>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: unknown compression type=
: %u",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->compression_t=
ype);
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOTSUP;
>> +=A0=A0=A0 }
>
> Having two checks feels redundant, compared to just letting the=20
> default catch all unrecognized values in that field.
Looks like it is.
>
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * if the compression type differs from QCOW2_COMPRESSION_T=
YPE_ZLIB
>> +=A0=A0=A0=A0 * the incompatible feature flag must be set
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (s->compression_type =3D=3D QCOW2_COMPRESSION_TYPE_ZLIB) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (s->incompatible_features &=20
>> QCOW2_INCOMPAT_COMPRESSION_TYPE) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: Compression =
type incompatible=20
>> feature "
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "bit must not be set");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0 if (!(s->incompatible_features &=20
>> QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: Compression =
type incompatible=20
>> feature "
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "bit must be set");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>
> Matches what we documented in the spec.
>
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> =A0 /* Called with s->lock held.=A0 */
>> =A0 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict=20
>> *options,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int flags, Error **errp)
>> @@ -1357,6 +1401,26 @@ static int coroutine_fn=20
>> qcow2_do_open(BlockDriverState *bs, QDict *options,
>> =A0=A0=A0=A0=A0 s->compatible_features=A0=A0=A0=A0=A0 =3D header.compati=
ble_features;
>> =A0=A0=A0=A0=A0 s->autoclear_features=A0=A0=A0=A0=A0=A0 =3D header.autoc=
lear_features;
>> =A0 +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Handle compression type
>> +=A0=A0=A0=A0 * Older qcow2 images don't contain the compression type he=
ader.
>> +=A0=A0=A0=A0 * Distinguish them by the header length and use
>> +=A0=A0=A0=A0 * the only valid (default) compression type in that case
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (header.header_length > offsetof(QCowHeader,=20
>> compression_type)) {
>> +=A0=A0=A0=A0=A0=A0=A0 /*
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * don't deal with endians since compression_ty=
pe is 1 byte=20
>> long
>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>> +=A0=A0=A0=A0=A0=A0=A0 s->compression_type =3D header.compression_type;
>
> Changes if you go with my suggestion of just making the=20
> compression_type field occupy 8 bytes in the qcow2 header.=A0 (And if=20
> you want to keep it 1 byte, I still think the spec should call out=20
> explicit padding bytes).
>
>> +=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0 s->compression_type =3D QCOW2_COMPRESSION_TYPE_ZL=
IB;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 ret =3D validate_compression_type(s, errp);
>> +=A0=A0=A0 if (ret) {
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 void *feature_table =3D NULL;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 qcow2_read_extensions(bs, header.header_leng=
th, ext_end,
>> @@ -2720,6 +2784,12 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0 total_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>> =A0=A0=A0=A0=A0 refcount_table_clusters =3D s->refcount_table_size >>=20
>> (s->cluster_bits - 3);
>> =A0 +=A0=A0=A0 ret =3D validate_compression_type(s, NULL);
>> +
>> +=A0=A0=A0 if (ret) {
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 *header =3D (QCowHeader) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Version 2 fields */
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .magic=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D cpu_to_be32(QCOW_MAGIC),
>> @@ -2742,6 +2812,7 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .autoclear_features=A0=A0=A0=A0 =3D cpu_to_b=
e64(s->autoclear_features),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_order=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
cpu_to_be32(s->refcount_order),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .header_length=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D cpu_to_be32(header_length),
>> +=A0=A0=A0=A0=A0=A0=A0 .compression_type=A0=A0=A0=A0=A0=A0 =3D (uint8_t)=
 s->compression_type,
>
> Is the cast necessary?
s->compression_type is enum, I thought it would be good to explicitly=20
show that in the code.
If it's totally useless I'll remove it.
>
>> =A0=A0=A0=A0=A0 };
>> =A0 =A0=A0=A0=A0=A0 /* For older versions, write a shorter header */
>> @@ -2839,6 +2910,11 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bit=A0 =3D QCOW2_CO=
MPAT_LAZY_REFCOUNTS_BITNR,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "lazy refc=
ounts",
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QCOW2_FEAT_TYPE=
_INCOMPATIBLE,
>
> Ordering: please group all the incompatible bits side-by-side (this=20
> should come before the lazy refcount bit).
>
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bit=A0 =3D QCOW2_INCOMPA=
T_COMPRESSION_TYPE_BITNR,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "compression ty=
pe",
>
> This change breaks iotests; at least 31, 36, and 61 need updates (I've=20
> got a similar patch pending which fixes the fact that we forgot the=20
> autoclear bit [1]).=A0 You'll need to squash in fixes for those at the=20
> same time.
ok
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08069.html
>
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D header_ext_add(buf, QCOW2_EXT_MA=
GIC_FEATURE_TABLE,
>> @@ -3401,6 +3477,7 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_offset=A0=A0=A0=A0=A0 =3D cp=
u_to_be64(cluster_size),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_clusters=A0=A0=A0 =3D cpu_to=
_be32(1),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_order=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(refcount_order),
>> +=A0=A0=A0=A0=A0=A0=A0 .compression_type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D (uint8_t)=20
>> QCOW2_COMPRESSION_TYPE_ZLIB,
>
> Is the cast necessary?
>
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .header_length=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(sizeof(*header)),
>> =A0=A0=A0=A0=A0 };
>> =A0 @@ -3420,6 +3497,26 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_be64(QCOW2_AUTOCLEAR_DATA=
_FILE_RAW);
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0 if (qcow2_opts->has_compression_type &&
>> +=A0=A0=A0=A0=A0=A0=A0 qcow2_opts->compression_type !=3D QCOW2_COMPRESSI=
ON_TYPE_ZLIB) {
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if (qcow2_opts->compression_type > 0xff) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -EINVAL, "Too =
big compression=20
>> type value");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 switch (qcow2_opts->compression_type) {
>> +=A0=A0=A0=A0=A0=A0=A0 default:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -EINVAL, "Unkn=
own compression=20
>> type");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>
> This should probably be an assert that qcow2_opts->compression_type is=20
> in range, rather than a switch statement and error_setg.=A0 Callers of=20
> qcow2_co_create should not be handing us unknown values.
The intention was to express what has actually happened in the case of a=20
"bad" image to easy the problem investigation.
>
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 header->compression_type =3D (uint8_t)=20
>> qcow2_opts->compression_type;
>
> Why the cast?
>
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 header->incompatible_features |=3D
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_be64(QCOW2_INCOMPAT_COMPRESSIO=
N_TYPE);
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
>> =A0=A0=A0=A0=A0 g_free(header);
>> =A0=A0=A0=A0=A0 if (ret < 0) {
>> @@ -3602,6 +3699,7 @@ static int coroutine_fn=20
>> qcow2_co_create_opts(const char *filename, QemuOpts *opt
>
>> +++ b/block/qcow2.h
>> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>> =A0 =A0=A0=A0=A0=A0 uint32_t refcount_order;
>> =A0=A0=A0=A0=A0 uint32_t header_length;
>> +
>> +=A0=A0=A0 /* Additional fields */
>> +=A0=A0=A0 uint8_t=A0 compression_type;
>> +
>> +=A0=A0=A0 /* header must be a multiple of 8 */
>> +=A0=A0=A0 uint8_t=A0 padding[7];
>> =A0 } QEMU_PACKED QCowHeader;
>
> You're changing the size of this struct, which WILL break iotests (and=20
> even more than just the 3 I pointed out above for the feature name=20
> table).
>
> /me looks ahead
>
> Aha - you even noticed it: patch 7/8 fixes test 80.=A0 That fix needs to=
=20
> be squashed in here, where the change is made.
ok, but the patch will be pretty long
>
>> =A0 =A0 typedef struct QEMU_PACKED QCowSnapshotHeader {
>> @@ -213,16 +219,20 @@ enum {
>> =A0 =A0 /* Incompatible feature bits */
>> =A0 enum {
>> -=A0=A0=A0 QCOW2_INCOMPAT_DIRTY_BITNR=A0=A0=A0=A0=A0 =3D 0,
>> -=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT_BITNR=A0=A0=A0 =3D 1,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE_BITNR=A0 =3D 2,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DIRTY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1 <=
< QCOW2_INCOMPAT_DIRTY_BITNR,
>> -=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_CORRUPT_BITNR,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE=A0=A0=A0=A0=A0=A0=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_DATA_FILE_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DIRTY_BITNR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 0,
>> +=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT_BITNR=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1=
,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE_BITNR=A0=A0=A0=A0=A0=A0=A0 =3D 2,
>> +=A0=A0=A0 QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR =3D 3,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DIRTY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_DIRTY_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_CORRUPT_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 1 <<=20
>> QCOW2_INCOMPAT_DATA_FILE_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_COMPRESSION_TYPE=A0=A0=A0=A0=A0=A0 =3D
>> +=A0=A0=A0=A0=A0=A0=A0 1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
>
> Uggh. I hate realigning =3D just because we added a longer name,=20
> especially when you then can't even keep things on one line because of=20
> length.=A0 If it were me, I'd leave the existing lines alone, and/or=20
> switch everything to just use 'BITNR =3D ' rather than trying to align =
=3D.
>
> Bikeshedding - since the new name is so long, can you get by with the=20
> shorter QCOW2_INCOMPAT_COMPRESSION_BITNR (drop the _TYPE)?
Good idea, I'll certainly redo that part, because I don't like ether.

Denis

