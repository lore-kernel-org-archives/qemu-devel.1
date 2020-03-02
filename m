Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B022EC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD5320863
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kHpLkqA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD5320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kjd-0004Jn-PA
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8kih-0003nM-7O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8kif-0001NB-Sj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:02:51 -0500
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:33766 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8kiX-0001HV-Rm; Mon, 02 Mar 2020 08:02:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE4jEYThD9Y3WNdnG949Bolq2SrZSpUjmy+L/CMZROSmGKEVYepQ1G0i+49tb3lrrAbHIwPpchoeATmbvM27en/FKV38i6dHRTrWNpYmdsEXVvH+ET9jkkYZmnHtycudJqR4qClQzTg+R3qzIxsyygs56SzDImQBHIJ3P1L8RVgpNzlvsklLNB/+K6l5VJFMRrkmdS3omeXfpc5YiEJgl7kqdpc/Kh8i4E+9WXUsbgQm469cjhVEciAXS6uz3x9KuJddQ++cBs7XuM8iMF8u3hwNAY0JTzUhPt00Ban88e0HuBMwPrqrGWCKp2KeXhVoEY4/5NQmpaQUu2Y/e2gwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHMLshnAl7DWWAcQeLuXDHo/yVHyzjLH84N9JbYwGTg=;
 b=Jg4Wj+9cckITp4hYMD4LjoDc8lOaU9q7EDGPSvScYXP6PkPIEZn/7ZCbyRf3TMterHLy4rnZF7gzSX1rGq4sUdOZpxoEy/g+sOaHmqrKbJbD3fqLk/ZcCvxcwfDrxMJASWifsRTcZ9Wq3qO1feS7DZIK9d+MiBI/WdJbp3O0hTHK6I9/yxIB6Ix40dJEjh5tyw7eI1KYJocxUjU2VdRWF7ZceeYsvPAyscKE535lqdwowhVOkaUWSO53h3Sukv/5bEgDbyfy43gcSZpZhd93nmMQ5MHHFvd5h1iN7tvFacusx9UTi8wi8eWzXEjHm2b7TAKLywjdJ7fKsZbwsCIGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHMLshnAl7DWWAcQeLuXDHo/yVHyzjLH84N9JbYwGTg=;
 b=kHpLkqA9Wv+x1X+yzgsykxxp2WivvcAa41HpBIhOUhhKobuY10lJ2Lg0XywSAjmwpa21JFywXbBU/Ns8SjhnEmLy/ldiiVYa6qkKcnf/+oLjNCFdCkbxlNIibKd54Baay/FYJkZuDuYYZFRr3qXtiQ8bpgdT72v7fGQp98CLBwg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3365.eurprd08.prod.outlook.com (20.177.112.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Mon, 2 Mar 2020 13:02:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 13:02:39 +0000
Subject: Re: [PATCH v2 2/4] qcow2: rework the cluster compression routine
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
 <20200302082111.21205-3-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200302160236893
Message-ID: <ee9870ef-ae7b-15d5-4229-bf2565b3fd38@virtuozzo.com>
Date: Mon, 2 Mar 2020 16:02:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200302082111.21205-3-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:7:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.9 via Frontend Transport; Mon, 2 Mar 2020 13:02:38 +0000
X-Tagtoolbar-Keys: D20200302160236893
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac201589-f341-4647-8ef4-08d7bea9fc5b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3365C1227149A4C38404AD79C1E70@AM6PR08MB3365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(136003)(366004)(189003)(199004)(316002)(16576012)(2906002)(31696002)(86362001)(6486002)(36756003)(2616005)(956004)(26005)(31686004)(66476007)(66946007)(81166006)(66556008)(8936002)(16526019)(186003)(8676002)(81156014)(52116002)(5660300002)(4326008)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3365;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBfxLvcSduTkacz//BmAk/jyOYW0gWFFo169Ne8tZitnm4AUW5veZbu0u0BjEziTIDydCKoRypGh1d3HziOePvj2WxJtN2CLstnYPXSzHvxLmhNsbi44rXf/Sye8du6M14zZiZ6+6kKPOqO+dDMDAz1Gi5kNFd5x8UPD9oE6GHi8JJZeTEZtTubXa/2PV4Xb1UAwRxqAT81EoGn7WymUH3xaXzt0vkFavmzM3ty3valfELq9MWgMJWqNn2eeGZHyWcmBkesgaKh8aOrzq90wtd85QVgx+LEwfKlfgtnrMGhYvu8dUw5hTX3hIOiSYlG8NOjwbqHdFYgzQE6Rb9y8TqjAA4OZs1TXTzIzrjMKeIR86/esPk942rhYgjzGfjJTGmes4J9w3pOg3pa4/2A5XfGMr+2tpritGqKZRMEwTFgdbS3351y8XZ8Z0/mrJmwK
X-MS-Exchange-AntiSpam-MessageData: wrpvOo9pX8Qe8JlSfUcgXlPDBETgPDcfKt0Leu6VTjSB5rjv612Ghx5SNYEy0jXFLPDZe5ZG2TRq/8DI9AokM2ynLRRcyUzrDrQJ+aVE8bJ8tKcnevTMEB6oy1Z1xQVfzTrBTJukV9JWIBkjM29VjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac201589-f341-4647-8ef4-08d7bea9fc5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 13:02:39.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI6PJV5SNV/kHb+Mherfwi1C6flAWoMIG/OLMfDZwvGgE12TM24Vf3UBTV0reatGkntmp5BGznqUAtRnesNqyMxYhZQ/i4V5mrlDN5M+Hik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3365
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.101
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

02.03.2020 11:21, Denis Plotnikov wrote:
> The patch enables processing the image compression type defined
> for the image and chooses an appropriate method for image clusters
> (de)compression.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/qcow2-threads.c | 77 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 77bb578cdf..9288a4f852 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -74,7 +74,9 @@ typedef struct Qcow2CompressData {
>   } Qcow2CompressData;
>   
>   /*
> - * qcow2_compress()
> + * qcow2_zlib_compress()
> + *
> + * Compress @src_size bytes of data using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
> @@ -83,8 +85,8 @@ typedef struct Qcow2CompressData {
>    *          -ENOMEM destination buffer is not enough to store compressed data
>    *          -EIO    on any other error
>    */
> -static ssize_t qcow2_compress(void *dest, size_t dest_size,
> -                              const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
>   {
>       ssize_t ret;
>       z_stream strm;
> @@ -119,19 +121,19 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>   }
>   
>   /*
> - * qcow2_decompress()
> + * qcow2_zlib_decompress()
>    *
>    * Decompress some data (not more than @src_size bytes) to produce exactly
> - * @dest_size bytes.
> + * @dest_size bytes using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
>    *
>    * Returns: 0 on success
> - *          -1 on fail
> + *          -EIO on failure
>    */
> -static ssize_t qcow2_decompress(void *dest, size_t dest_size,
> -                                const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
>   {
>       int ret = 0;
>       z_stream strm;
> @@ -144,7 +146,7 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
>   
>       ret = inflateInit2(&strm, -12);
>       if (ret != Z_OK) {
> -        return -1;
> +        return -EIO;
>       }
>   
>       ret = inflate(&strm, Z_FINISH);


more context:

     if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) || strm.avail_out != 0) {
         /*
          * We approve Z_BUF_ERROR because we need @dest buffer to be filled, but



>            * @src buffer may be processed partly (because in qcow2 we know size of
>            * compressed data with precision of one sector)
>            */
> -        ret = -1;
> +        ret = -EIO;
>       }

Good thing that you've changed -1 to -EIO, to be more compatible with _compress() function.

But seems, that there is an actual (preexisting) bug here, as we return direct ret of inflate, which is
incompatible with our function defined API. And this mean, that Z_STREAM_END most probably work,
as it is positive. But Z_BUF_ERROR will be treated as error actually.

Hmm, it was broken in far 341926ab83e2b4d in 2018.. By me of course :(

I think, I'll send a separate patch with stable@ in cc.


>   
>       inflateEnd(&strm);
> @@ -189,20 +191,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>       return arg.ret;
>   }
>   
> +/*
> + * qcow2_co_compress()
> + *
> + * Compress @src_size bytes of data using the compression
> + * method defined by the image compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          a negative error code on failure
> + */
>   ssize_t coroutine_fn
>   qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>                     const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_compress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_compress;
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
> +/*
> + * qcow2_co_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using the compression method defined by the image
> + * compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on failure
> + */
>   ssize_t coroutine_fn
>   qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>                       const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_decompress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_decompress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
>   
> 


-- 
Best regards,
Vladimir

