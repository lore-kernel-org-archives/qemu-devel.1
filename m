Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3EC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0F9206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ekzFjKw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0F9206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcJt-00057u-3s
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcHC-0003cS-4n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcH6-000684-Lg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:15:22 -0400
Received: from mail-he1eur02on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::704]:45284
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJcH1-0005x4-3y; Wed, 01 Apr 2020 08:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceAbkv9eeQzPCWMZemi85p7+92213uU7NxPHV4TfSMECsYWUpfJzdeIE0UA+tC4hHR/bX0F2sz1B2As20/QunFXw0OWV2pkKfNZ8ZxutEJIproKp1e103+/oPBb7OAO2x3gInUN+YBD2D3+fbRK+SSd2JYZ+XuIlqQ9GfmDU3ubn+1EWSfFn1ag7d18BgnmGZc61gUbnghf303D8TAZ3kaogtJyWXaS+CKrbZIslNQd21fbGQOXDOo4p9JBACvHdspj2TgrUmD1Yn3IZmXGVjPjAcfjxJtsvqYWmy/BurXgeX1/VfpJnN2Gz/gn8xiqHDUOo0MDhzy128ck3GxVlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y0Zpa86O5EzN2IrcJ3hUHLbrdeG3g+Vu7Ij0cnjHas=;
 b=XkawR3MKgHSJS75W958QZEjhGOdU2R4giqjt85oOYH1gVCcDKnOH9qh8jazZ4exrd49G9LK2sNYMYQTJCacp/SC7dON3FiQHl56BU6za87iI6hEy3g2JQPuhcMNfNigRHNSIWXjkM5qtSQ9PprPjwOZ56WECjE+kKOLzMj4UzciZj49hnKulaDRZB18rov39ZjSHFTyTEqtPgaZv+5QwKZYQ1vu2rt9+bPWRHztFfA6qZAMhsZb0d2VLouPYA/kfys0c0RWVJGK/7MOi0YGhcXa5H5K0hjjc7cF9IrdjXRGfVlGkqBql3hMcyGB/M/59Z/kVzv105MCfuWJgsnuW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y0Zpa86O5EzN2IrcJ3hUHLbrdeG3g+Vu7Ij0cnjHas=;
 b=ekzFjKw0OKjy6qDeVkYNEYDtHbw8E6VjkaWJ2VhZm4vdMMy90FYvOlcN6htK+x9oUWSlQHlNuvKC5NSoCczg7SD3oF7XvHG6x0Fq1XIUdOpkj9VmBo8nEs9eLZsBEslVcyN2nxQVY6q2Gs9AZdgvTbVt/BabR5RsT5hPkqvUoR0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5366.eurprd08.prod.outlook.com (10.141.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Wed, 1 Apr 2020 12:15:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 12:15:04 +0000
Subject: Re: [PATCH v15 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200401101213.24505-1-dplotnikov@virtuozzo.com>
 <20200401101213.24505-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401151502412
Message-ID: <52fed7de-8821-26fc-8c91-442a3b7a09d5@virtuozzo.com>
Date: Wed, 1 Apr 2020 15:15:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401101213.24505-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0130.eurprd07.prod.outlook.com
 (2603:10a6:207:8::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM3PR07CA0130.eurprd07.prod.outlook.com (2603:10a6:207:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Wed, 1 Apr 2020 12:15:03 +0000
X-Tagtoolbar-Keys: D20200401151502412
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 111cf06a-70a4-467f-7ab8-08d7d6364f18
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366ED835308F89C1D141B85C1C90@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39850400004)(136003)(36756003)(478600001)(66946007)(81166006)(81156014)(316002)(16576012)(66476007)(86362001)(2906002)(31686004)(66556008)(956004)(6486002)(8676002)(5660300002)(8936002)(4326008)(2616005)(19273905006)(26005)(52116002)(186003)(31696002)(16526019)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShX0fK6OKd6PBUgtQQB9U+zPjnPDk7epidEmgFmB7AUbOMYQh1Q/Bq3Ymled0KlOYowcm73++9JdgtZiAOVEcTZMj3rEOEfINBKK4HiXeKy7UcZuLungpVJS5VnHIMwkcItINlpyZVQs5235jdTzns4tm1IzC9mPPaJ6WMQyI6c1Qz/iFLySz1t+hPAVlJVKu2MQkVeJzEs8xhwEHTjlxYmUztkXpUJQ3v6crYGXkuWp8snTuUsV5e9e27Ig3PYfjSzKxJ1o4m9sq4pPcampB90z85Bhn7BVb81N2lqGBLpSLiKAq9vloHlCvV76B7M+fRoJGcLU/uOfY6uTVBmebaBeaET7FbaC9yc0AeM1UXzit2u45ftBZB4aUReO4m02qvksq0IShOtf4rRALqK+lkdRgoZFDbq8d1j9GyyKLwCim2eogWDp1RASPP+Q6ogWCXPOQXzBrEzrxcK+oyojBaBnOh3JklxUWabEqEIa+LF36SvdCrMo1vpgkeGuOEnW8glKLnekTx0qxDBXnArSJ5SJIz3vaztQY0Y+SeNj5e38RsNsGe6wGJiYYKve9y6f
X-MS-Exchange-AntiSpam-MessageData: 1WTs9qoMwspCUWQrD8NtKzvrRpjMgB4nVoTcbo8Xgz98GXTdUZl9wVEokVFB6atS8z5Zo/TWxkZBNgl3YONOZnsfmuDkDCTFLJHct/IuEVmsZ7vLTQvMMIgq2BFBCXLbhMGWupGRbEdFjXiAoqbW4Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111cf06a-70a4-467f-7ab8-08d7d6364f18
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:15:04.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrWC+g1cnRXywcWHRu3BCa3oCaGCB41EItQKwm6Bj21OiQ+CBg4GsCOFmdBQvQgC0a5A8T/+qdGNoxIGmdObhl5YQL85EVuWDVSM27xCXJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe05::704
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

01.04.2020 13:12, Denis Plotnikov wrote:
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
>   docs/interop/qcow2.txt |   1 +
>   configure              |   2 +-
>   qapi/block-core.json   |   3 +-
>   block/qcow2-threads.c  | 162 +++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   7 ++
>   5 files changed, 173 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 640e0eca40..18a77f737e 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -209,6 +209,7 @@ version 2.
>   
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> +                        1: zstd <http://github.com/facebook/zstd>
>   
>   
>   === Header padding ===
> diff --git a/configure b/configure
> index e225a1e3ff..fdc991b010 100755
> --- a/configure
> +++ b/configure
> @@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     lzfse           support of lzfse compression library
>                     (for reading lzfse-compressed dmg images)
>     zstd            support for zstd compression library
> -                  (for migration compression)
> +                  (for migration compression and qcow2 cluster compression)
>     seccomp         seccomp support
>     coroutine-pool  coroutine freelist (better performance)
>     glusterfs       GlusterFS backend
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1522e2983f..6fbacddab2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4293,11 +4293,12 @@
>   # Compression type used in qcow2 image file
>   #
>   # @zlib: zlib compression, see <http://zlib.net/>
> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
>   #
>   # Since: 5.1
>   ##
>   { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>   
>   ##
>   # @BlockdevCreateOptionsQcow2:
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 7dbaf53489..30c0723e5e 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -28,6 +28,11 @@
>   #define ZLIB_CONST
>   #include <zlib.h>
>   
> +#ifdef CONFIG_ZSTD
> +#include <zstd.h>
> +#include <zstd_errors.h>
> +#endif
> +
>   #include "qcow2.h"
>   #include "block/thread-pool.h"
>   #include "crypto.h"
> @@ -166,6 +171,153 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
>       return ret;
>   }
>   
> +#ifdef CONFIG_ZSTD
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
> +    ssize_t ret;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * Use the zstd streamed interface for symmetry with decompression,
> +     * where streaming is essential since we don't record the exact
> +     * compressed size.
> +     *
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 potentially can finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {
> +        size_t zstd_ret = 0;
> +        /*
> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +         * with ZSTD_e_end until it returns 0, at which point you are
> +         * free to start a new frame". We assume that "start a new frame"
> +         * means call ZSTD_compressStream2 in the very beginning or when
> +         * ZSTD_compressStream2 has returned with 0.
> +         */
> +        do {
> +            zstd_ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
> +
> +            if (ZSTD_isError(zstd_ret)) {
> +                ret = -EIO;
> +                goto out;
> +            }
> +            /* Dest buffer isn't big enough to store compressed content */
> +            if (zstd_ret > output.size - output.pos) {
> +                ret = -ENOMEM;
> +                goto out;
> +            }
> +        } while (zstd_ret);
> +    }
> +    /* make sure we can safely return compressed buffer size with ssize_t */
> +    assert(output.pos <= SSIZE_MAX);
> +    ret = output.pos;
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
> +    /*
> +     * The compressed stream from the input buffer may consist of more
> +     * than one zstd frame. So we iterate until we get a fully
> +     * uncompressed cluster.
> +     * From zstd docs related to ZSTD_decompressStream:
> +     * "return : 0 when a frame is completely decoded and fully flushed"
> +     * We suppose that this means: each time ZSTD_decompressStream reads
> +     * only ONE full frame and returns 0 if and only if that frame
> +     * is completely decoded and flushed. Only after returning 0,
> +     * ZSTD_decompressStream reads another ONE full frame.
> +     */
> +    while (output.pos < output.size) {
> +        size_t last_in_pos = input.pos;
> +        size_t last_out_pos = output.pos;
> +        ret = ZSTD_decompressStream(dctx, &output, &input);
> +        /*
> +         * ZSTD manual doesn't explicitly state what happens,
> +         * if ZSTD_decompressStream reads the frame partially.
> +         * But, based on our tests, if we don't fully populate
> +         * the output and have read all the frames from the input,
> +         * we end up with error here.
> +         */
> +        if (ZSTD_isError(ret)) {
> +            ret = -EIO;
> +            break;
> +        }
> +
> +        /*
> +         * The ZSTD manual is vague about what to do if it reads
> +         * the buffer partially, and we don't want to get stuck
> +         * in an infinite loop where ZSTD_decompressStream
> +         * returns > 0 waiting for another input chunk. So, we add
> +         * a paranoid check that on each step the loop makes some
> +         * progress.
> +         */
> +        if (last_in_pos >= input.pos &&
> +            last_out_pos >= output.pos) {
> +            ret = -EIO;
> +            break;
> +        }
> +    }
> +    /*
> +     * Make sure that we have the frame fully flushed here
> +     * if not, we somehow managed to get uncompressed cluster
> +     * greater then the cluster size, possibly because of its
> +     * damage.
> +     */
> +    if (ret > 0) {
> +        ret = -EIO;

ret is signed. I think, it works anyway, but not good practice.

> +    }
> +
> +    ZSTD_freeDCtx(dctx);
> +    assert(ret == 0 || ret == -EIO);
> +    return ret;
> +}
> +#endif
> +
>   static int qcow2_compress_pool_func(void *opaque)
>   {
>       Qcow2CompressData *data = opaque;
> @@ -217,6 +369,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>           fn = qcow2_zlib_compress;
>           break;
>   
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_compress;
> +        break;
> +#endif
>       default:
>           abort();
>       }
> @@ -249,6 +406,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>           fn = qcow2_zlib_decompress;
>           break;
>   
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_decompress;
> +        break;
> +#endif
>       default:
>           abort();
>       }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6cb000be19..3ae9624ba3 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1246,6 +1246,9 @@ static int validate_compression_type(BDRVQcow2State *s, Error **errp)
>   {
>       switch (s->compression_type) {
>       case QCOW2_COMPRESSION_TYPE_ZLIB:
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +#endif
>           break;
>   
>       default:
> @@ -3478,6 +3481,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           }
>   
>           switch (qcow2_opts->compression_type) {
> +#ifdef CONFIG_ZSTD
> +        case QCOW2_COMPRESSION_TYPE_ZSTD:
> +            break;
> +#endif
>           default:
>               error_setg(errp, "Unknown compression type");
>               goto out;
> 


-- 
Best regards,
Vladimir

