Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858B020409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bketUQzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858B020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtPf-0005ky-L5
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jDs7K-0000n7-5W
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jDs7I-0001bR-1R
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:57:25 -0400
Received: from mail-eopbgr60120.outbound.protection.outlook.com
 ([40.107.6.120]:33558 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jDs7B-0000MK-II; Mon, 16 Mar 2020 11:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXpyjB7QxgulNZIgdmingyIaRB7G8WAbYC+oMDn0sTI8ahH52VK0Pr4lZydI6J4N0E7TwZ+FaXJNNoNkPhVHGDg7n5rEBXk96SeumlKPlvOae9osi1WnTbwCepeODpTv/dOtRrzPTRk3Q9YZBAglFspE17yhX/M82tS6XAPfMMCoVPAolpjNc7nSWZLO23dAMrtQ5c4VF3mVlXP89cpqOhXHclfgXlWHFndjfMINSHeue8HqIQPC7DwNtZrZkjb7sJ8SnmWrIqA3Q00q2foOsYDR8Ue+SNXnssXjW5XHNZeaWnDDiDIf3vtbreBW4h0PSRJnezAlPM6lUL53LeyPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x82kB2DRPE7shYD/3M+Yp6nmAwhlDb86dDfBIsvytV4=;
 b=gFbDoGb40VQnAQrR/VdGwf7w1yqUb0x9V3UvNC8MAy1Rbxdn0V+Ca8gFM44k/DqWUbJSMMPhxln4eUQfLFYGXtghsdW0KhY1GTI48fmZVdDkftqnaEGAjjq8QE4AAQ6BtbIPC+rXU2RN21BRNyr0hip+mbfdA/Y9xoyUZZTB1f/rHbk2HQWFci14WtKWm0K2IMG/13I2x+FHEzz0JA2+SLaLsGRxGQRGDl/2k5OOdxxjpI68M3Da5FPF+p3EXCjwm+v0JuqKJWrDg/jKUOSz1QZnCVmFBFJq84FGC4l2f7t9uLMhi8hTRG7ZAUeAj40wKBeQ9K3FXqItEhzLW7s67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x82kB2DRPE7shYD/3M+Yp6nmAwhlDb86dDfBIsvytV4=;
 b=bketUQzwCAAu2JfThqfOGDB2hc080wBAnhyA20Qb1SWyyg7TE/JovgWkjW+rgRfXtZ86DOagQ6PEnof1ZmIbDfKnllElPXuHoPm60p/Tn6Tr3Yxfr6BVbvDeebwMlmbmR+os6Js1QC+PgUFTXoYO+mMoCDYqyQ9ElvXHk0RLxEE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB2962.eurprd08.prod.outlook.com (52.134.92.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 15:57:13 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 15:57:13 +0000
Subject: Re: [PATCH v6 3/4] qcow2: add zstd cluster compression
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
 <20200312092242.5536-4-dplotnikov@virtuozzo.com>
 <6dd9966e-e22a-b0d0-80a1-7e2c9cc9671f@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <5470e010-2091-17a5-33ae-aacd8fbfbf11@virtuozzo.com>
Date: Mon, 16 Mar 2020 18:57:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <6dd9966e-e22a-b0d0-80a1-7e2c9cc9671f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0365.eurprd05.prod.outlook.com
 (2603:10a6:7:94::24) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.240.15) by
 HE1PR05CA0365.eurprd05.prod.outlook.com (2603:10a6:7:94::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 15:57:12 +0000
X-Originating-IP: [94.233.240.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e1294f-6c62-4058-a680-08d7c9c2b16f
X-MS-TrafficTypeDiagnostic: AM0PR08MB2962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB296257F42B10DB588CC5AB96CFF90@AM0PR08MB2962.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(136003)(346002)(376002)(199004)(2616005)(86362001)(956004)(31696002)(66556008)(66476007)(66946007)(2906002)(6486002)(36756003)(5660300002)(107886003)(4326008)(8676002)(966005)(52116002)(19273905006)(478600001)(8936002)(316002)(16526019)(16576012)(6666004)(31686004)(81156014)(186003)(26005)(53546011)(81166006)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2962;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:3; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kz08GsC4eSva3eDCfGR8D6/nVm07SlhK98RIKFef/qZZaM+zJyyiBnTl9VcZKn3lFwXh6x0tHUVZeO/OJ1yOVssuduWI5j+NpKPj3voiOyFHIKoCFpn8iP8OSpCz7GV+Rc7DFlveast/3Quw5JvcvGxkJ8p9U3GE+Jj+HrLXQG12Tics5iHX/4AExbf8RaFSJO9WJO9UJzi9PPPA7aclYx62hxKcKeWIeByq892m8ehiErr4wcAs8WydNOHN0T+gQsqYYwdVvfjFymG242M2Y9zJSktGnv/6Isrp8jBaDu2kcc6umZq6ms+P2jjAyTLJUCSd0hwIWoP2jCEp5uRtwFCV0rCx+WJ+z8b3XAnRmnFUM6iGrv/MZLslUB88DQxyZib8EEhAhtD+MuKcpYaaHHnLY742bQV31cBBOIfc8mbqLsrKicz4e9DSg2Dv1Oahu9yLQomj5KD1mXHAFt5jfcpDUgUxuu1QL/k5Bqq+QYrP/VgrKhLaPCEBCOXcAkKfF8D29Lv70AJ9ADNOllz9Jbj4ogtInsBLZodF2Ln8WCypFg7itmWi3BSGhnBfuQWn
X-MS-Exchange-AntiSpam-MessageData: XzsiCS8JVwNqCFQ8WVuGawiXynPAfVPG+Ldf6VpbznVu69cpJ8MEEl0RLaWs2CVW2yUETt6qVwpLSkwBnKLCDJO14g9E1/tDKhapq+DbQVB1vsFP+VwxJ/21ZSmSzHIErLX9+KTBI4/f24I7JP/fEQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e1294f-6c62-4058-a680-08d7c9c2b16f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 15:57:13.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4yhUpq2NAQZ5H80jTtd82CP0NRxft547z8mLDSFpgfZY/P+/HNyloBXKPUhLMzzTZZRk6cSWKsgaFMlzbveWxUjjUYJaUnd3YNrgxS8fIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2962
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 16.03.2020 17:01, Eric Blake wrote:
> On 3/12/20 4:22 AM, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
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
>> @@ -575,11 +576,30 @@ Compressed Clusters Descriptor (x =3D 62 -=20
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
>> +data_space_lenght - data chunk length available to store a=20
>> compressed cluster.
>
> length
>
>> +(for more details see "Compressed Clusters Descriptor")
>> +x =3D data_space_length - 1
>
> If I understand correctly, data_space_length is really an upper bounds=20
> on the length available, because it is computed by rounding UP to the=20
> next 512-byte boundary (that is, the L2 descriptor lists the number of=20
> additional sectors used in storing the compressed data).=A0 Which really=
=20
> means that we have the following, where + is cluster boundaries, S and=20
> E are the start and end of the compressed data, and D is the offset=20
> determined by data_space_length:
>
> +-------+-------+------+
> =A0=A0=A0=A0=A0 S=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DE...D
>
>> +
>> +=A0=A0=A0 0:=A0 (default)=A0 zlib <http://zlib.net/>:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Byte=A0 0 -=A0 x:=A0=A0=A0=A0 the com=
pressed data content
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 all the space provided used for=20
>> compressed data
>
> For zlib, we have byte 0-E are compressed data, and bytes (E+1)-D (if=20
> any) are ignored.=A0 There is no way to tell how many bytes between E=20
> and D exist, because zlib doesn't care (the compression stream itself=20
> ensures that decompression stops when input reaches E because the=20
> output reached a cluster boundary at that point).
>
>> +=A0=A0=A0 1:=A0 zstd <http://github.com/facebook/zstd>:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Byte=A0 0 -=A0 3:=A0=A0=A0=A0 the len=
gth of compressed data in bytes
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 -=A0 x:=A0=A0=A0=
=A0 the compressed data content
>
> Whereas for zstd, the decompression MUST know the actual location of=20
> E, rather than passing in the slop between E and D; bytes 0-3 give us=20
> that information.
>
> But your description is not very accurate:=A0 if 'x' is point E, then it=
=20
> is NOT data_space_length - 1, but rather data_space_length - slop,=20
> where slop can be up to 511 bytes (the number of bytes from (E+1) to=20
> D).=A0 And if 'x' is point E, then the real layout for zlib is:
>
> byte 0 - E: the compressed data content
> byte E+1 - x: ignored slop (E is implied solely by the compressed data)
>
> and for zstd is:
>
> byte 0 - 3: the length of the compressed data
> byte 4 - E: the compressed data (E computed from byte 0-3)
> byte E+1 - x: ignored
>
> I'm not sure what the best way is to document this.
>
>> +++ b/block/qcow2-threads.c
>
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t src_size)
>> +{
>> +=A0=A0=A0 size_t ret;
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * steal ZSTD_LEN_BUF bytes in the very beginning of the bu=
ffer
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
>
> Where does the magic number 5 come from?
I did some tests to get the same compression ratio as zlib but do it=20
faster than zlib.
ZLIB also used hardcoded "compression ratio". Changing of the=20
compression ratios in both compression types is something that can be=20
changed with later patches.
>
>
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
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * paranoid sanity check that we can store
>> +=A0=A0=A0=A0 * the compressed size in the first 4 bytes
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (ret > UINT32_MAX) {
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> +=A0=A0=A0 }
>
> The if is awkward.=A0 I'd prefer to change this to:
>
> =A0=A0=A0 /*
> =A0=A0=A0=A0 * Our largest cluster is 2M, and we insist that compression
> =A0=A0=A0=A0 * actually compressed things.
> =A0=A0=A0=A0 */
> =A0=A0=A0 assert(ret < UINT32_MAX);
>
> or even tighten to assert(ret <=3D dest_size)
>
>> +
>> +=A0=A0=A0 /* store the compressed chunk size in the very beginning of t=
he=20
>> buffer */
>> +=A0=A0=A0 stl_be_p(dest, ret);
>> +
>> +=A0=A0=A0 return ret + ZSTD_LEN_BUF;
>> +}
>> +
>> +/*
>> + * qcow2_zstd_decompress()
>> + *
>> + * Decompress some data (not more than @src_size bytes) to produce=20
>> exactly
>> + * @dest_size bytes using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: 0 on success
>> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 -EIO on any error
>> + */
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t src_size)
>> +{
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * zstd decompress wants to know the exact length of the da=
ta.
>> +=A0=A0=A0=A0 * For that purpose, on compression, the length is stored i=
n
>> +=A0=A0=A0=A0 * the very beginning of the compressed buffer
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 size_t s_size;
>> +=A0=A0=A0 const char *s_buf =3D ((const char *) src) + ZSTD_LEN_BUF;
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * sanity check that we can read 4 byte the content length =
and
>> +=A0=A0=A0=A0 * and there is some content to decompress
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (src_size <=3D ZSTD_LEN_BUF) {
>> +=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 s_size =3D ldl_be_p(src);
>> +
>> +=A0=A0=A0 /* sanity check that the buffer is big enough to read the=20
>> content from */
>> +=A0=A0=A0 if (src_size - ZSTD_LEN_BUF < s_size) {
>> +=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 if (ZSTD_isError(
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ZSTD_decompress(dest, dest_size, s_bu=
f, s_size))) {
>
> You are correct that ZSTD_decompress() is picky that it must be given=20
> the exact size of the compressed buffer it is decompressing.=A0 But the=20
> ZSTD manual mentions that if an exact size is not known in advance,=20
> that the streaming API can be used instead:
>
> https://facebook.github.io/zstd/zstd_manual.html#Chapter9
To be honest, I didn't find where they mentioned that explicitly. Could=20
you please point where exactly?

But I found the following:

   Calling ZSTD_compressStream2() with ZSTD_e_end instructs to finish a fra=
me.
  =A0It will perform a flush and write frame epilogue.
   The epilogue is required for decoders to consider a frame completed.
   flush operation is the same, and follows same rules as calling ZSTD_comp=
ressStream2() with ZSTD_e_flush.
   You must continue calling ZSTD_compressStream2() with ZSTD_e_end until i=
t returns 0, at which point you are free to
   start a new frame

I think in the epilogue they store the same information that I did and pote=
ntially (I didn't check) some more to finish the frame.
So we didn't win any space. Additionally, using streaming API will make the=
 code more complex.

So I decided to stick with more simple version.

>
> In other words, would it be possible to NOT have to prepend four bytes=20
> of exact size information, by instead setting up decompression via the=20
> streaming API where the input is (usually) oversized, but the output=20
> buffer limited to exactly one cluster is sufficient to consume the=20
> exact compressed data and ignore the slop, just as we do in zlib?
>
> The rest of this patch looks okay.
>


