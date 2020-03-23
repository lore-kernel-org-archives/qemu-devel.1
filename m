Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF4C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D70020736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vdqK3EA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D70020736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIi7-0007Pl-AD
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGIhO-0006u4-4y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGIhM-0002AR-Ae
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:44:42 -0400
Received: from mail-eopbgr70119.outbound.protection.outlook.com
 ([40.107.7.119]:62031 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGIhE-00027w-K1; Mon, 23 Mar 2020 04:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BovnhP/dEmIBfCl9EBhSXCG4+LZxmcXfBl0/FCs/c8Q6B7mJqNo/ryZDS9qjrk2f70Whu8p1ciexCULIzLRNTgWQax8XQtVbqwA6vih66qX+NTd47QqwB+3NKwZFunoWBCxtvMBJYhAV6YRnvvLrQifZ9uGwyE9Fmfc/n0N5RFlfDg9b3x8TT++2UKIE0fXbUcp8d1kemlSnLgoFa2vBl5dNQgHkMwzd4EYMvDnXtt6+xfUFf58EcuYoyxTGDTzO1JVSLyHF3l/bHucKOt/BJ1JPFNo682VP2ZbZhFlBpYmDsANFcUr9h9AOsKuY1T24GO+pzH5M4ojDf05nw18+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilZm3W51DlCjU8ZbxwQorHOzYhgTvqD3HRl6bw+afO0=;
 b=cr7TM92V7qDY7T499IwFoNaalDZjMgsEq86iIesRQwZYJPTGZBLmRV4V1xKk6W/Kl8bog75GWSus9STGWnu5IrlKSL7OGoLNZLb+7U5udQLCzFmZbJwHlSm2Rm+Z0IlOjXc3Lwhr0omtWm+uBeOCpiVzoo9dmgclMzqqn3+Nkg7hCWITogZTHbHc0WSJYRkdmytyIP3aPojsSbOkPKKec44A4w8EXEsEy+LWJUKsvAgEINTizcuZM/EA/LGmvhTVtfkgSFEgRg9pvfTW2xqfvGi0+f0Jptju4dM8dDfoez+dWNx8/BDF1E+r1HR8U/MI5ssBjunCC9FMLaES07flUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilZm3W51DlCjU8ZbxwQorHOzYhgTvqD3HRl6bw+afO0=;
 b=vdqK3EA/LAByZ/RFMX3myDAJmSSjN5uY6DdeYRy4c0u5g4COMJr69XOT4/IRtG813QEWBRU/7wYOlVMMuGYnQCCfSfIaoJ5ngTk+PeEccSLFd9QdzsRMrK1rCbWcm9pqJtXF21MCPFszHa95UwtRolpzM9RupbtllGKsnWm0S6w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5447.eurprd08.prod.outlook.com (10.141.173.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 08:44:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 08:44:30 +0000
Subject: Re: [PATCH v8 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323114428002
Message-ID: <a1830b65-bd38-c458-d382-1f3981355d2e@virtuozzo.com>
Date: Mon, 23 Mar 2020 11:44:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200321143431.19629-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.183) by
 AM0PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:208:ac::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 08:44:29 +0000
X-Tagtoolbar-Keys: D20200323114428002
X-Originating-IP: [185.215.60.183]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908173d5-092a-4f00-dc05-08d7cf0666b2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54471338C866E422A7E9B391C1F00@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39840400004)(346002)(366004)(376002)(396003)(199004)(2616005)(2906002)(956004)(6486002)(4326008)(16526019)(66476007)(19273905006)(5660300002)(186003)(66946007)(26005)(66556008)(36756003)(81166006)(81156014)(8676002)(16576012)(52116002)(316002)(31686004)(86362001)(31696002)(478600001)(8936002)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5447;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JQWJVfk4h1HImym505wolrB2tmgApaJURRMXDZsNvl0jCctLyf5pSLeqZhvpEfaowc2DuLIk00EyLpSRIuLzo154hBZW45W+hhhcdnniv5BqdTuaQqFwFL9oKxi/xBYrdjo7G1Mz2CmDWH0p98lKjKa3if7i5XrwXJYTqbZMvz+s/Xfw+941LSNW+4HS9oQrS0a9LXCcZee/XPXaU6bE0GQhbGYsLcIcHp69vOJY0ah04WMXrR8XFqOw2ZbzrUOzJHUarKb3KDV0FZwgAWK2ICidbVNNXpB9yR/+AUanv9hTOn79V0kymMHatwJ+0yuQ4iOQRc1ncO8l1O/SXfi+lvRh6krANALiM7nGsP2EPs2XWUy+nyebk+Yy+6+IL3ryU2bboNYZHP5ptyuj1gpv9d+qhpDxSmcweKsPLLmgCUcxpnBB8c0FXyXu0OyejbCZ9uSgPm5oYKmDROtISemOn52MfeYaZJIAq/PRzOzT3RvcJAE+E4pGInNfePuOfEipI9ADU7G0bNxOA5/T1h5uhNsrXW14453BeENjULxCQE30HBeXahSHlT7BcWJlu97
X-MS-Exchange-AntiSpam-MessageData: X6rj7STybevXO4JqhU/BcDhODiQZH0iBW7oKGhkzzpDLz0SG50XsNU53eCMRmzQYQWGPPNFCiSVxvaQfsrMdSgeI9kqZbAGIEbj609j1cPr8qSYdLScIX9EcQ5+18sFjJvuIfuNzlb2WTHuDcUYlRQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908173d5-092a-4f00-dc05-08d7cf0666b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 08:44:29.8783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu/veBVPqri9ZG+CbzyJc7zs5iTvi4+Kog7L274n3Ednwm2EjlBeluHU1rBJotxh5GsC/DzwMdwsN7avBSCNEAqAoEQpx4raypXubq83X2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.119
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

21.03.2020 17:34, Denis Plotnikov wrote:
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
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>

You forget to drop signs, patch is changed significantly, including algorithm.

> ---
>   docs/interop/qcow2.txt |   1 +
>   configure              |   2 +-
>   qapi/block-core.json   |   3 +-
>   block/qcow2-threads.c  | 129 +++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   7 +++
>   5 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 5597e24474..795dbb21dd 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -208,6 +208,7 @@ version 2.
>   
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> +                        1: zstd <http://github.com/facebook/zstd>
>   
>   
>   === Header padding ===
> diff --git a/configure b/configure
> index caa65f5883..b2a0aa241a 100755
> --- a/configure
> +++ b/configure
> @@ -1835,7 +1835,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     lzfse           support of lzfse compression library
>                     (for reading lzfse-compressed dmg images)
>     zstd            support for zstd compression library
> -                  (for migration compression)
> +                  (for migration compression and qcow2 cluster compression)
>     seccomp         seccomp support
>     coroutine-pool  coroutine freelist (better performance)
>     glusterfs       GlusterFS backend
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index a306484973..8953451818 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4401,11 +4401,12 @@
>   # Compression type used in qcow2 image file
>   #
>   # @zlib: zlib compression, see <http://zlib.net/>
> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
>   #
>   # Since: 5.0
>   ##
>   { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>   
>   ##
>   # @BlockdevCreateOptionsQcow2:
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 7dbaf53489..ee4bad8d5b 100644
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
> @@ -166,6 +171,120 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
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
> +    size_t ret;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +
> +    ret = ZSTD_CCtx_setParameter(cctx, ZSTD_c_compressionLevel,
> +                                 ZSTD_CLEVEL_DEFAULT);

Hmm, looks a bit strange.. Isn't it already default by default?)

> +    if (ZSTD_isError(ret)) {
> +        ret = -EIO;
> +        goto out;
> +    }
> +

Hmm, strange that we need a loop, but zstd spec directly requires it, possibly we need to make a comment from it:

   "ZSTD spec: You must continue calling ZSTD_compressStream2() with ZSTD_e_flush until it returns 0, at which point you can change the operation."

> +    {
> +        /*
> +         * Instruct zstd to compress the whole buffer and write
> +         * the frame epilogue. This allows as to use zstd streaming
> +         * semantics and don't store the compressed size for the
> +         * zstd decompression.

May be not "to don't store", but to "decompress without knowing exact compressed data length" or something like this. I mean, make the comment for people who read the final code, not for those who review changes from version to version.

> +         */
> +        ret = ZSTD_compressStream2(cctx, &output , &input, ZSTD_e_end);

extra whitespace

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
> +    /* make sure we can safely return compressed buffer size with ssize_t */
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

But consider corrupted image: it may contain any data. And we should not crash because of it. So, we should return error here.

> +        assert(output.pos + ret <= output.size);
> +    } while (ret);
> +
> +    /*
> +     * If decompression went fine we must have the compressed
> +     * cluser fully consumed and flushed

cluster

> +     */
> +    assert(output.pos == output.size);

again, it should be EIO, not crash.

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
> @@ -217,6 +336,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
> @@ -249,6 +373,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
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
> index 899b5541f5..6420d27a6d 100644
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
> @@ -3454,6 +3457,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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

