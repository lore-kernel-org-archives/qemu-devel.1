Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4B620714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tnSUiqr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkbM-0002gn-G5
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHkaj-0002Da-KL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHkai-0005a8-1z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:43:49 -0400
Received: from mail-eopbgr30134.outbound.protection.outlook.com
 ([40.107.3.134]:11949 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jHkad-0005NY-JH; Fri, 27 Mar 2020 04:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeQV+OxmzsvJeb9C/MyT5n9nyG3P1Wcaj+RTLg3kuQEoOKPJp7n9h95aObHVvZWTO95bPm5czaj9JyP0+H0F1FGqMl2MNvx0rC4DhPfpq/2vgHUGglZ7XEA2gtHRq9ftltaYe85t6Ozymj/z/L1dSRiKW9Udl1MwmBXzVKk+UmJd4qVU8Xkcklr+d7NqSxPFMDYnE8cL4LDh/EqKYahu5abgmbTklFC1zeF5vm+D10zEFn7CRMbsmpw7IogR/N0y53DWBHd+OtM3xBwKKA8rAaVeajnnnAB7Jh+4R6RyfUVxSBb9f9ZtkrDrjt62ULrnQyAazcjeQSXjaICnFYDH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igXwJtpN3IxFWH8oHxPERmyjQaYDoh+pCnt2ps0kH3s=;
 b=NxHz3ozizeNOtPS50EwdFy4sWN+YS1x+KVfLZ9Lrrd2SFAxUjDtwqntLDms/PBEt4Xj6OkWY/vhev62tFVieYOr0Y2C+VwrjgxTPmfFJ/yvAa1QJSdrDWzkQlozzGD7dDF4n9sY0TMLEUdmeN23VHqTruTv48dvHmiSRE8oKxNQkOYLXboU1NAc1dOKG9Qd6huzKNoZWhVlMMNDTWveA/f+3nO0nicQJwcb3tKctFtUIvNZ+5ayRAbMnmJHYflN2O5qWodgTnoWeJv3CUmSNMEWRS9H3rib+v4eomEDV+dzOJ/Z0+jR0zLmRX1xGWrza2kvnUfnwg3p1c2EOncig6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igXwJtpN3IxFWH8oHxPERmyjQaYDoh+pCnt2ps0kH3s=;
 b=tnSUiqr0SPn15Df29N1ZGwN9+IrlwaIqXUGpZLlm4+m6DRWS6wtYOkhf8Q2RYyykJHtJpyjTEzxLpX4HwJEc/o1BCkQBCnzFCFySn9HkLoxkkB8AsJV/HgZfdmqVX6wU5h8klTL4Ol/rxzvCdHrTPevboRFfKvrh/KEGhDpUzYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5479.eurprd08.prod.outlook.com (10.141.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Fri, 27 Mar 2020 08:43:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 08:43:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-4-dplotnikov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200327114339269
Message-ID: <9ad0aa8d-b813-ae3a-2d4e-d1573e9cb582@virtuozzo.com>
Date: Fri, 27 Mar 2020 11:43:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200323142558.15473-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 AM0PR0102CA0027.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 08:43:40 +0000
X-Tagtoolbar-Keys: D20200327114339269
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e003ac-f56c-41d0-f96f-08d7d22af34b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547938AABAAB3E9278F8E859C1CC0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(396003)(39850400004)(346002)(366004)(16576012)(966005)(316002)(81166006)(8936002)(81156014)(2906002)(8676002)(52116002)(478600001)(31696002)(186003)(6486002)(956004)(5660300002)(31686004)(26005)(86362001)(66946007)(2616005)(16526019)(66476007)(4326008)(36756003)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlJe4A8poA1nwnEzmV+oejOsz6CZS+S75j6qJ5sWnxJ7wX4iVks08KQs/Z685c6PyR+yemQrDHv4bYKmMERlmSLXwAzZO4whr4wlADgXI3Pn7Ye+2mr9yIb6mDpAPudIMqDdR4e6wZ8BeKTbXMC51KFgJuf5BMJAbR04u8NB1hs04voUtCuRAy65vEWPq8Z1gKGlseEdjqFONLKhK+hESzqXRXzHTcFNGvw7/7tZD2iilJCucJu+zA3Rwq9yzPtRj4LsTU213hL1folGiXgOIZTdn8nbx0x9dgrSlB3+QhUATad+AWpxcd4FlWYOYDoQ8F24UcW1eWhtmpAl/pdA3wB3CeJkGpD955ZngzAHcL1/5mwT/VNn0HSGNHOTEiSGpovHuaIn7X3c9DwD6keDKcrLwrDam7tgfd42qcUryEHxXD4jztuOubA9FBauOdyYyLzyrw9VCnMRgtwZCg1VMFrd23bjrYAzY9ufzGjAzjsifRVm0PoC39FLYzIjCDMmYrxsW0Ho5RmqLNWRWk87Lg==
X-MS-Exchange-AntiSpam-MessageData: YLR9eVJAm7GeIdRB/xNvQIYfZrhBrBVnl3JZe6IoPJXznylJQAgTu83ck+e8HEihGPsTHjqXCQ2cu1UHuOpbSSmFYhuik+rtVJSlKBDYptfvkn8TUobsDQ3X/ZAw5wPVLVCQGHOlYPNuRsjN9Cglxw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e003ac-f56c-41d0-f96f-08d7d22af34b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 08:43:40.9870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDZXQpdrz/I7wf4zmPHQwGB/uM+OaZ5K8RVt9AIkNC47HSyq9spRwVjin6NGwFBdUe9qskbnuHIYQGWBVXIZozvcecvZiomj1g5U673skvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.134
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

Should we note somehow in qcow2 spec that we use streamed version of zstd with specific end byte?

23.03.2020 17:25, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                    src.img [zlib|zstd]_compressed.img
> decompress cmd
>    time ./qemu-img convert -O qcow2
>                    [zlib|zstd]_compressed.img uncompressed.img
> 
>             compression               decompression
>           zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---

[..]

> +
> +/*
> + * qcow2_zstd_compress()
> + *
> + * Compress @src_size bytes of data using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          -ENOMEM destination buffer is not enough to store compressed data
> + *          -EIO    on any other error
> + */
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    size_t ret;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +     * with ZSTD_e_end until it returns 0, at which point you are
> +     * free to start a new frame"
> +     */
> +    {
> +        /*
> +         * zstd simple interface requires the exact compressed size.
> +         * zstd stream interface reads the comressed size from
> +         * the compressed stream frame.
> +         * Instruct zstd to compress the whole buffer and write
> +         * the frame which includes the compressed size.
> +         * This allows as to use zstd streaming semantics and
> +         * don't store the compressed size for the zstd decompression.
> +         */
> +        ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
> +        if (ZSTD_isError(ret)) {
> +            ret = -EIO;
> +            goto out;
> +        }
> +        /* Dest buffer isn't big enough to store compressed content */
> +        if (output.pos + ret > output.size) {
> +            ret = -ENOMEM;
> +            goto out;
> +        }
> +    } while (ret);
> +
> +    /* if no error, the input data must be fully consumed */
> +    assert(input.pos == input.size);
> +    /* make sure we can safely return compressed buffer size with ssize_t *//z
> +    assert(output.pos <= SSIZE_MAX);
> +    ret = output.pos;
> +
> +out:
> +    ZSTD_freeCCtx(cctx);
> +    return ret;
> +}
> +
> +/*
> + * qcow2_zstd_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          -EIO on any error
> + */
> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
> +{
> +    size_t ret = 0;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_DCtx *dctx = ZSTD_createDCtx();
> +
> +    if (!dctx) {
> +        return -EIO;
> +    }
> +
> +    {
> +        ret = ZSTD_decompressStream(dctx, &output, &input);
> +        if (ZSTD_isError(ret)) {
> +            ret = -EIO;
> +            goto out;
> +        }
> +        /*
> +         * Dest buffer size is the image cluster size.
> +         * It should be big enough to store uncompressed content.
> +         * There shouldn't be any cases when the decompressed content
> +         * size is greater then the cluster size.
> +         */
> +        if (output.pos + ret > output.size) {
> +            ret = -EIO;
> +            goto out;
> +        }
> +    } while (ret);


Hmm. Unfortunately, zstd spec is not enough verbose to understand how to use
these functions :).

But I found this in comment in https://github.com/facebook/zstd/blob/dev/examples/streaming_decompression.c :

/* The return code is zero if the frame is complete, but there may
              * be multiple frames concatenated together.

so, I think it would be safer to move to "while (input.pos < input.size)" loop like in example.

and drop next assertion. And possibly do same for compression to be consistent (and safer?).


> +
> +    /*
> +     * If decompression went fine we must have the compressed
> +     * cluster fully consumed and flushed
> +     */
> +    if (output.pos != output.size) {
> +        ret = -EIO;
> +    }
> +out:
> +    ZSTD_freeDCtx(dctx);
> +    return ret;
> +
> +}
> +#endif
> +
>   static int qcow2_compress_pool_func(void *opaque)
>   {
>       Qcow2CompressData *data = opaque;
> @@ -217,6 +341,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,


[..]


-- 
Best regards,
Vladimir

