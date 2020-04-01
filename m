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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41565C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB38020CC7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FA6RVnOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB38020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfRC-00062R-51
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJfQC-0005G7-PO
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJfQA-0002Yf-LD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:36:52 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:38592 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJfQ1-0001pw-Nu; Wed, 01 Apr 2020 11:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asJFouAZBLGs1hmYsFO/PvKhQkGxc/H9sZJtB/Zy3tx7dHP4BhdNEENgl6J84dof1iHKepNry9h1Qw8rczRSJCwmW9U+ajTgOZVThdFzLTUxhML1uxEjZF1X4+a9CuSC5Ge+oeRF9jYLg7bLbdvJzmBKuLQfE5XdDZ8SP1wg0jvyFqimOnLaEYea44v/gh1khkaFaxy+bZATvdh+KgQ7zrv0DPvdd7ftBkxqr1yixBeUW5UqLzwuKJNa0oXvDaTOw5RWzorwX2NiH0g4T45eQRht1jFxnwSGusrOSp0CZSfeK87sXuvu3BVUocKZaRM3oifdcog4qaQW6WcSld+clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVT1a8Mcdc0dPbYLtmEkwZLyNsyFITPX+o611XsRn7I=;
 b=H3YYrMPQaFlCqjjIx44WFMC0hwPybzZKOTwvxKqtsPTDnuZuRAtcqdW3U6J7zHqN4dTdMUXlbLa7hWAGTAq2utvESVCm9b3VJxNZVLwFrAFb1mgJSrTo5rQ720PaJcThkFR1mdRTRG2pu3YXp8ipc9JC259sYeea86JIWyi+aKEloX3hJSQh7ld049iYt2NJAPl6Ae5/jdLESB5UYIyLTVfIgQa9s+fcPo6mafruQ89YDvWQiD1GivW5KTYagheaf4J/usay2e46SVNPnTk6QJ6ed6GtZUrKmBRuDZVVXLboGzZD+7c7Fntvs2n20Gt7FGqwN3TfkZnvUHU81Su+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVT1a8Mcdc0dPbYLtmEkwZLyNsyFITPX+o611XsRn7I=;
 b=FA6RVnOoslnX/hlcdyedhMTaNX+2nhWYXe4QGHGDjE7y0YPIc0P84BiCwg7huhBWjv8icGWy70oENMCQh77UKgauM5qJkwf/iV4XxkaqOXRGK98SMOR0TQ/Jur5kj8ZHENKlOAP+4UMjjWMA86UwGS26lSvhmpBFgNtCE0YQXHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5462.eurprd08.prod.outlook.com (10.141.173.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 1 Apr 2020 15:36:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:36:38 +0000
Subject: Re: [PATCH v16 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
 <20200401143719.21639-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401183636902
Message-ID: <2fe8c114-48da-d4c4-6463-65ea36f1d5a5@virtuozzo.com>
Date: Wed, 1 Apr 2020 18:36:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401143719.21639-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR0102CA0009.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 15:36:37 +0000
X-Tagtoolbar-Keys: D20200401183636902
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc65ba3-0581-4370-f662-08d7d6527812
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462EE594E5500B3DCF1AFAAC1C90@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(346002)(39840400004)(136003)(366004)(31696002)(66556008)(16526019)(36756003)(86362001)(8676002)(81166006)(8936002)(316002)(6486002)(4326008)(81156014)(16576012)(30864003)(2616005)(19273905006)(66946007)(26005)(186003)(66476007)(5660300002)(2906002)(52116002)(478600001)(956004)(31686004)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jonnf0wb2bjAT4lfFdSoiCEmDh9FA4LtjV6Oc3lCVpe+LDS+s2t7axMYcJUsm+DQML1ylOMOpPmXglKwU6TqT+KMRMu2aUPzTl8RLb+mKgGBANOI+YQyAxHfI1DeD1DOF+oviu3UWiqdc5cggsA2dIjj78W0crzuJL6bkn5VJXpJbWRP14zM2czZUZwHru66YUW4uuXuhWaEVXBQqbY5Ea+Va9wq0/Zkl8IhDUBxUTRezCN5Ak+4KLd5KIyw0ZzsPWFwKZEyTTikaLkbRrqEzVKxla17kSOvuXGYZgKSIUSnnDfxyqjyGYRkFVrZwNGykEMhkuUZxsUFCIuJ1Tmy9jilLzHxuEdRpKrnYye+UAMfEx2510SeX8TdXp4TGe482XzETkn2/aYu/qqHMCBZTh8Loa5JMa/+LzFjC7GkKyWtvR2t/BT96vipILedDP/696JxLyBpZ0fW1r5b4f19Ggc6L6l+jm9duYfXCGK9kxA8bnkimnKzhgfRpRzxaE94JPKqivCkuifrdMG1f2AeFWqenSUT163JXdplJgcQttlRSfTzyUK86iBW5v4+5XCz
X-MS-Exchange-AntiSpam-MessageData: 1urj3AD7NGRQCBo4gM8LP0EIsbQiQsmifNNdwgMNwtTYVMrl1GdCUz7pD04rTE3bJ7jJiiMD/Yz0vgyxoEHqnLtAvBB1d9Q+DCyyPWNRhMosY1wMCxJseFWTFn4JlIPedIt8rWAjWOkXxk8G33oEHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc65ba3-0581-4370-f662-08d7d6527812
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:36:38.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMZM8uIaRLaDEmPManrViIMfc81QlLyZlazrbVFs4lhXVviOLHrEPNk7Z9KNhEhuCVpWvcn2iYotCuGwqE8L1G/JeshH7ecS9vZfIpSOJsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.118
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

01.04.2020 17:37, Denis Plotnikov wrote:
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
>   block/qcow2-threads.c  | 163 +++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   7 ++
>   5 files changed, 174 insertions(+), 2 deletions(-)
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
> index 7dbaf53489..aa133204f0 100644
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
> @@ -166,6 +171,154 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
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

dead assignment

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
> +    size_t zstd_ret = 0;
> +    ssize_t ret = 0;
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
> +        zstd_ret = ZSTD_decompressStream(dctx, &output, &input);
> +        /*
> +         * ZSTD manual doesn't explicitly state what happens,
> +         * if ZSTD_decompressStream reads the frame partially.
> +         * But, based on our tests, if we don't fully populate
> +         * the output and have read all the frames from the input,
> +         * we end up with error here.

Hmm, based on my test, that's wrong, see below. So, I'd drop the comment.

> +         */
> +        if (ZSTD_isError(zstd_ret)) {
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

As my test shows, it's not paranoid. It's really needed. So, I'd drop (or rewrite) the comment.

And, with dropped dead assignment and these two comments:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
> +    if (zstd_ret > 0) {
> +        ret = -EIO;
> +    }

I still don't believe that we need this check. Experiments shows that yes, it returns 0 after each frame... But experiment is not a guarantee.
But OK, if you want, keep it.

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
> @@ -217,6 +370,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
> @@ -249,6 +407,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
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


----
test:
#include <stdio.h>
#include <assert.h>
#include <zstd.h>
#include <zstd_errors.h>

int main() {
     char buf1[] = "erbebewbwe";
     char buf2[1000000];
     char buf3[1000000];
     int ret;

     ZSTD_outBuffer output = { buf2, sizeof(buf2), 0 };
     ZSTD_inBuffer input = { buf1, 5, 0 };
     ZSTD_CCtx *cctx;

     cctx = ZSTD_createCCtx();
     assert(cctx);

     ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);

     printf("ret1: %d\n");


     input = (ZSTD_inBuffer){ buf1, 5, 0 };
     ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
     printf("ret2: %d\n");

     ZSTD_freeCCtx(cctx);

     // Now, we have written at least two frames.

     printf("output.pos: %ld\n", output.pos);

     ZSTD_DCtx *dctx = ZSTD_createDCtx();

     input = (ZSTD_inBuffer){buf2, output.pos, 0};
     output = (ZSTD_outBuffer){buf3, sizeof(buf3), 0};

     ret = ZSTD_decompressStream(dctx, &output, &input);

     printf("ret: %d, input.pos: %ld, output.pos: %ld\n", ret, input.pos, output.pos);

     ret = ZSTD_decompressStream(dctx, &output, &input);

     printf("ret: %d, input.pos: %ld, output.pos: %ld\n", ret, input.pos, output.pos);

     ret = ZSTD_decompressStream(dctx, &output, &input);

     printf("ret: %d, %d, input.pos: %ld, output.pos: %ld\n", ret, ZSTD_isError(ret), input.pos, output.pos);

     ret = ZSTD_decompressStream(dctx, &output, &input);

     printf("ret: %d, %d, input.pos: %ld, output.pos: %ld\n", ret, ZSTD_isError(ret), input.pos, output.pos);

     return 0;
}

compile:
gcc -lzstd -g a.c

output:
[root@kvm zstd]# ./a.out
ret1: 1
ret2: 1
output.pos: 28
ret: 0, input.pos: 14, output.pos: 5
ret: 0, input.pos: 28, output.pos: 10
ret: 9, 0, input.pos: 28, output.pos: 10
ret: 9, 0, input.pos: 28, output.pos: 10


So, as you can see, last two decompress'es shows, that we still not fully populate the output, nothing more in the input, and it returns not-error... It returns 9. Interesting :)


-- 
Best regards,
Vladimir

