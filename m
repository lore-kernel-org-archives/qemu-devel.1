Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D630C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA0D246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qtCjMQR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0D246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e17-0005Ow-4N
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7e0F-0004nS-A2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7e0D-0006HK-R7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:40:23 -0500
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:49606 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7e05-00067W-LK; Fri, 28 Feb 2020 06:40:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URlSNS8taVWYZfbidAvBLo82TZfryEZvS4BhFId/kjRNVOrnHTZavzTOiBa6m+pn/bUKcJe96Vkgu0XQ0tuVSsY4UDyHHe5SgSAWdRYDNUV0bbIqIuhk+90pWFGKuB2VVDW4j0x9XanuWfAJfPPvG/wDfiTP/rfcyO0GrlCyKMZYxxOmnQDcd+5WCaqK/ZUOzZSuRl0BZzgguRw+gXTbOleculJgbyoe1pish55qgA1NPg0BnSoE+moANBRtvbvcOUIDe5Zo7BScGGy0V1uuyvv/z669tLgagA5zMOkkeJIOMtghQJBUujkXEDlbQWG5zPIjpgNv3v6LCNvMR0y+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgRe594Cfk7Uf8Tqsu1Ln3CkAcAfhX5NgHhaPsKPIBI=;
 b=V1ecrExtwcm89naNPrXWao8TXc0VF+hPKDg+nfItvtQbhw8LzTueWJ8c7sRYYkTKtngjoxL3a+tHQ66PvHdZDUB/9qsD0Ll9mbvlfGRTZVp7SzClHphKGGD6bAXsyBiIz8soXH3SzkiVcJlbLcHmICmtw+iIeSLlkYOqb2u7OhMa8Y8NtQLslOnD1ZboQp5sqKuKgurfBOsdq+N//eQ75Ja/mSXxBx5d87XPwxi7h4iOPKtE6eOv8ogR4TE8BOPXvl3QjIKNtV5Zo6fR//ViPKGgNoxT8vTaexLMNFVAJG9rOUF1IGlC+ahBqDuxsoXOOIoS5dkAPV0sSc1J68fbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgRe594Cfk7Uf8Tqsu1Ln3CkAcAfhX5NgHhaPsKPIBI=;
 b=qtCjMQR5wBBjiAegx9H3LvJyB6g0x2jxdqtmdEIxonc1d08bM5wZemj+F3sP8KwcvxenfTH3/MXshklMl4E8H8VERR5wk32mV192F1DhBYA6ThTrod8m8XcGsk+3r16EcF+HcDn/fql81XFhU3ZRcMMnpPB7JNESGhTSI+HpOqo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3202.eurprd08.prod.outlook.com (52.134.90.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 28 Feb 2020 11:40:10 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 11:40:10 +0000
Subject: Re: [PATCH v1 3/8] qcow2: add zstd cluster compression
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-4-dplotnikov@virtuozzo.com>
 <6b9b3f63-5760-c0a1-b330-b92ac894970a@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <8345724b-63c7-7d12-3fe7-38fac5e087b2@virtuozzo.com>
Date: Fri, 28 Feb 2020 14:40:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <6b9b3f63-5760-c0a1-b330-b92ac894970a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::32) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR0402CA0022.eurprd04.prod.outlook.com (2603:10a6:3:d0::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Fri, 28 Feb 2020 11:40:09 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bded8b5e-7125-4af6-9e60-08d7bc42f76e
X-MS-TrafficTypeDiagnostic: AM0PR08MB3202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB32020357B8A6B351227FBFE8CFE80@AM0PR08MB3202.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(376002)(39850400004)(136003)(189003)(199004)(26005)(6486002)(31686004)(316002)(186003)(4326008)(5660300002)(16576012)(81166006)(81156014)(2906002)(107886003)(8676002)(478600001)(31696002)(66476007)(66946007)(53546011)(956004)(66556008)(16526019)(2616005)(19273905006)(52116002)(8936002)(86362001)(36756003)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3202;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqnnbPCNjHCMyoaFUUQA5Hi2S0r5w4mJbzSStPE4/AcltYcT3jTvz0B1u9D0K54dclS4ylho1zj0Q02EXlsi9aLHo7FgpF7UoFEi/a9K0p8M99MDziKs3CfIXJwJmrDVsUo1D1AKk9+H4G7aut1x8AJc44IYBd6vnenZaEi7wZlzNEZK3Vw9m4/I6QmuMA/tJQkEjOSa1bg2bvC+8bITM3yEQIXCRxqAMOdbquRvz3INpdncvcc4We0f5fCKsfUzYMxpMdQoYINsoxajbCCvhklwc4NmS6uVRScrdup5UQLWX/Tf8cYekjZAtgltCjDQj8wi2QaPM5X2Ei8GL/JO/GgQFEEKYr7nUbqN8Szw5IJCAj7YJQuqD2sEHByAgne36aOKtlwCfHentiEHqH7FTOjZcK/2Bw9CkwXFG1TH2XV/Q60ZanXGBNa0TsM4NGfTlx+DqqwxfF79d/QLvE+FP0MjlH8zGOMrAR/h97XGSbhDjse8Gb6x2oMmNAKLy4ZUt2mf/E1TAGTk35S6cg/U+L1Yv54X/QdYrR7opDQJjHVXCb0HrESVeDAhfs93oApk
X-MS-Exchange-AntiSpam-MessageData: chP21Vah2ANHArAqxlqToXJDx8xofY9HcqgqjySoWOUjjTM6DBXPWYMHN7gjykNE7S8ZZqrCxwq+Cvt69OevSDJ+uG/JsGSpmHdYSUsL6wpmmu3RyBcsfFFY9V4oTKId34VPi9pw62WE+cxamYT4xA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bded8b5e-7125-4af6-9e60-08d7bc42f76e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 11:40:10.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogu3okFlTttCIOsnyaz298VFWrJWZH4qnx6V+vdkAetCEh0XOnLMOipUJqQUem8bi83WGUPDe5vj4fC3b0VAG9S1VIX+Z+5Qg56T57TD7nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3202
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.124
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



On 27.02.2020 17:01, Eric Blake wrote:
> On 2/27/20 1:29 AM, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t src_size)
>> +{
>> +=A0=A0=A0 size_t ret;
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * steal ZSTD_LEN_BUF bytes in the very beginng of the buff=
er
>
> beginning
>
>> +=A0=A0=A0=A0 * to store compressed chunk size
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 char *d_buf =3D ((char *) dest) + ZSTD_LEN_BUF;
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * sanity check that we can store the compressed data lengt=
h,
>> +=A0=A0=A0=A0 * and there is some space left for the compressor buffer
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (dest_size <=3D ZSTD_LEN_BUF) {
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 dest_size -=3D ZSTD_LEN_BUF;
>> +
>> +=A0=A0=A0 ret =3D ZSTD_compress(d_buf, dest_size, src, src_size, 5);
>> +
>> +=A0=A0=A0 if (ZSTD_isError(ret)) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (ZSTD_getErrorCode(ret) =3D=3D ZSTD_error_dstS=
ize_tooSmall) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 /* paraniod sanity check that we can store the commpressed si=
ze */
>
> paranoid, compressed
>
>> +=A0=A0=A0 if (ret > UINT_MAX) {
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> +=A0=A0=A0 }
>
> This is pointless.=A0 Better is to ensure that we actually compressed=20
> data (the pigeonhole principle states that there are some inputs that=20
> MUST result in inflation, in order for most other inputs to result in=20
> compression).=A0 But that check was satisfied by checking for=20
> ZSTD_error_dstSize_tooSmall, which is what happens for one of those=20
> uncompressible inputs.=A0 Namely, zstd will never return a result larger=
=20
> than dest_size, and since dest_size is smaller than UINT_MAX on entry,=20
> this check is pointless.=A0 But if you want something, I'd be okay with:=
=20
> assert(ret <=3D dest_size).
Taking into account that this is "just in case" and I'm trying to=20
protect the first 4 bytes of the buffer from the overflow and
I can't imagine the situation when we deal with cluster sizes greater=20
than UINT32_MAX but the input size is size_t which can be > UINT32_MAX=20
on 64bit archs.
I'd rather stick with
 =A0=A0=A0 if (ret > UINT32_MAX) {
 =A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
 =A0=A0=A0 }
as Vladimir suggested.

I'm not sure that the assert is good here, since it stops the system=20
operating and this isn't potential error but a limitation
Does it work for you?

Denis
>
>> +++ b/docs/interop/qcow2.txt
>> @@ -208,6 +208,7 @@ version 2.
>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Avai=
lable compression type values:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0: zlib <https://www.zlib.net/>
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=
: zstd <http://github.com/facebook/zstd>
>> =A0 =A0 =A0 =3D=3D=3D Header padding =3D=3D=3D
>> @@ -575,11 +576,28 @@ Compressed Clusters Descriptor (x =3D 62 -=20
>> (cluster_bits - 8)):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Another =
compressed cluster may map to the tail=20
>> of the final
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sector u=
sed by this compressed cluster.
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 The layou=
t of the compressed data depends on=20
>> the compression
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type used for=
 the image (see compressed cluster=20
>> layout).
>> +
>> =A0 If a cluster is unallocated, read requests shall read the data from=
=20
>> the backing
>> =A0 file (except if bit 0 in the Standard Cluster Descriptor is set).=20
>> If there is
>> =A0 no backing file or the backing file is smaller than the image, they=
=20
>> shall read
>> =A0 zeros for all parts that are not covered by the backing file.
>> =A0 +=3D=3D=3D Compressed Cluster Layout =3D=3D=3D
>> +
>> +The compressed cluster data has a layout depending on the compression
>> +type used for the image, as follows:
>> +
>> +Compressed data layout for the available compression types:
>> +(x =3D data_space_length - 1)
>> +
>> +=A0=A0=A0 0:=A0 (default)=A0 zlib <http://zlib.net/>:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Byte=A0 0 -=A0 x:=A0=A0=A0=A0 the com=
pressed data content
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 all the space provided used for=20
>> compressed data
>> +=A0=A0=A0 1:=A0 zstd <http://github.com/facebook/zstd>:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Byte=A0 0 -=A0 3:=A0=A0=A0=A0 the len=
gth of compressed data in bytes
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 -=A0 x:=A0=A0=A0=
=A0 the compressed data content
>> =A0 =A0 =3D=3D Snapshots =3D=3D
>> =A0 diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 873fbef3b5..4b6e576c44 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4401,11 +4401,12 @@
>> =A0 # Compression type used in qcow2 image file
>> =A0 #
>> =A0 # @zlib:=A0 zlib compression, see <http://zlib.net/>
>> +# @zstd:=A0 zstd compression, see <http://github.com/facebook/zstd>
>> =A0 #
>> =A0 # Since: 5.0
>> =A0 ##
>> =A0 { 'enum': 'Qcow2CompressionType',
>> -=A0 'data': [ 'zlib' ] }
>> +=A0 'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' }=
=20
>> ] }
>
> The spec and UI changes are okay.
>


