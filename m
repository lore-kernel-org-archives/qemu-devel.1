Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CD1C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F9120733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eRiQEjPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F9120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuG7-00085H-Rt
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIuFJ-0007WX-G2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIuFH-0002XJ-DG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:14:29 -0400
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:34016 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jIuFB-0002Kr-Et; Mon, 30 Mar 2020 09:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZFwcRgVENLuVy57MVB/thZtV22rqd6BTAhYEEKqZVPO/MnQ95NcN3LfoTrJQaOpRLSLGkxMzh3WmexHXUe9dQuPF/MkT/i/C1Xr6j028kCQVTqaJ+hRXvP1Pckd+sEtKOEuE1E/eMl+BWP+bZZKp4PmdI3EWF6yFm735FdrC20sXLDDHTVq23z+3cLu3jBocs0nOela7pOmjbN7i4YHsgSYNHNQpOPIFSQFq3ZRF9bUyvaDDyiklruMFOID8DRDBFLPHYdhA9ADfNaiZgdITXzogAdAgEJS5Mt19VBkY0IG1GcHddyOCLf1mAAD55ltGIf0nocroX4SyWmh/TJ7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKptc27ey3Dg4FVIHwgvmoJBlwkrqc0pb9d1KTLPQmI=;
 b=jdQ7waMR0bevI17h1VFUj/N4RZ5cBwSRKlDxqK5xU0hl/HrZZ3jJGT4fMJklZJlRZzKN0DTBWQKjH14rzlU9PCAWrErV/GkvAM1FgNQherISfrf/UG8v1EMT/1eurPl/hBOU8ZUD/K5JBcu0Uf/o3fM8bcjnFR8GkvE/caNLRdYx/fv2vpbCzPZczFx41/mSrwjYePY5Qksm5XJNr0aSN+A0UWjIRYt6tL/v+H1EMHc6z50KT61AComxaAvF/AKp1IqL6QqRMe+ZyZhLstJNq6e8n+we8TCj4vDm4p1GQ1ZdOlrfLWPQP234R1gUgnbEn4d3rvrdO8KJ+A00QQvV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKptc27ey3Dg4FVIHwgvmoJBlwkrqc0pb9d1KTLPQmI=;
 b=eRiQEjPDTdXa3WCr6CxP0eFD0TCV8la3t98R3NwgkhhOmVDD0mXN5GYctnsZjLCDyUklKXYkaVKcVRRpiLmVMoIdGKi0xqD2JVLIRBFrwSKzpdAFLHToJHCuQKp9/+C6ubw1XVS6rQ4nSFZCzKBryndMMhTZb/l2iFdHozK6U5E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5317.eurprd08.prod.outlook.com (10.255.191.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 13:14:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 13:14:15 +0000
Subject: Re: [PATCH v11 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200330095429.26974-1-dplotnikov@virtuozzo.com>
 <20200330095429.26974-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200330161414132
Message-ID: <3c367b69-0db7-bac6-6ea8-915114df1e01@virtuozzo.com>
Date: Mon, 30 Mar 2020 16:14:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200330095429.26974-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.14) by
 FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 13:14:15 +0000
X-Tagtoolbar-Keys: D20200330161414132
X-Originating-IP: [185.215.60.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a2abec0-5203-4a71-d77b-08d7d4ac3f34
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53172C885BF3A85D9360ECE2C1CB0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(478600001)(26005)(52116002)(81156014)(81166006)(2616005)(66946007)(66556008)(5660300002)(66476007)(19273905006)(31686004)(956004)(6486002)(8936002)(16526019)(186003)(36756003)(8676002)(2906002)(31696002)(86362001)(4326008)(16576012)(316002)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxApDiECRdQUkr70lEWJvGZG3+eQIIapjMuYou7NzCA3U0MZAKIgAN9lv56bl77mDpQujcHG6P9mvDVSOZy/jZDNYqDrfe/cspehf7SAATSAUrrRR8456AcIpTlg5nicKMXoEzgDtLdl1RPiuKn630GNRXj8fLLDWf8tVb3oWiTW08k/xe4YYD2JkJxKvRgH/JdeOT/93RVsg99he3twmiZ8JhBo0leCc0dt4ASPknFOByYFE4CUr8jMLHbtJWTr8aao2WwY5UOLdw0tD23NfoHlsJ4Xp3ScQVVKcVPM9iLogu0AQVK+3bByqPOaqVLm90MiaLey2KeOCpbgGbONeNUOANVuSiIeXy3Ensa71r32i1z8d5+LFLouTJgvgC4AVyTeIZrKWq0+HMn0nKPp6dUXJk01Dj0TVdXAGVvzvcfKiebPpWIEBTrl4nO+WV1mIeVbkWroDExyIAGi1ivUddrWFtjs270vZ18nq1TP1ITcvQi1VAesaELTGefpponSuctTVyEhEClOQq+IPWcssVJmp8CjoUdH2oDNrpW9i4irrnmCCZnGuLYaKkYJ0uug
X-MS-Exchange-AntiSpam-MessageData: Kf0m/3InFvmXAZi1UVa3Z5Y/qWVXBzaXDsZP9Pq8+6s/fS5HSulqFs/Klw1gG2dtVeUZic+MD1oQTm1VvU9FVc7e6OuEsMk4hSi7OHJhMp/GuTTwdf9MOWil+3WHnKG6Ts2O/NIXA7S19Lys4hZf2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2abec0-5203-4a71-d77b-08d7d4ac3f34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 13:14:15.7857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyJzCiJMeFYaZ5CJlrKubTfeREgTjDF1HtGUy0BlWyFf+YL1GQAb+vR3y8JHBkq02UCgjbBIdOEPTmr1pm0SrmHuP5tG+i3o/XaDXhlbuic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.117
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

30.03.2020 12:54, Denis Plotnikov wrote:
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
>   block/qcow2-threads.c  | 138 +++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   7 +++
>   5 files changed, 149 insertions(+), 2 deletions(-)
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
> index da09c35895..57cac2abe1 100755
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
> index d669ec0965..44690ed266 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4293,11 +4293,12 @@
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
> index 7dbaf53489..b8ccd97009 100644
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
> @@ -166,6 +171,129 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
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
> +    /*
> +     * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +     * with ZSTD_e_end until it returns 0, at which point you are
> +     * free to start a new frame".
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 can potentially finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {
> +        /*
> +         * zstd simple interface requires the exact compressed size.

on decompression you mean

> +         * zstd stream interface reads the comressed size from
> +         * the compressed stream frame.

compressed size is not stored in the stream. I think, that streamed
interface just decompress until it have something to decompress and
have space to write output.

> +         * Instruct zstd to compress the whole buffer and write
> +         * the frame which includes the compressed size.

I think this is wrong. compression size is not written.

> +         * This allows as to use zstd streaming semantics and
> +         * don't store the compressed size for the zstd decompression.
> +         */

Comment is just outdated. Accordingly to our off-list discussion, I'd
rewrite it like this:

We want to use streamed interface on decompression, as we will not know
exact size of compression data. Use streamed interface for compression
just for symmetry.


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

Here you use "@return provides a minimum amount of data remaining to be flushed from internal buffers
             or an error code, which can be tested using ZSTD_isError()."

I think we can safely drop this check, and wait for error from next ZSTD_compressStream2.. But it should
work anyway.

> +    };
> +
> +    /* make sure we can safely return compressed buffer size with ssize_t */
> +    assert(output.pos <= SSIZE_MAX);

Hmm. I hope it's not possible for cluster. But taking the function in separate, it _is_ possible.
So may be better to assert at function start that

   assert(dest_size <= SSIZE_MAX);

To stress, that this limitation is part of qcow2_zstd_compress() interface.

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
> +    /*
> +     * The compressed stream from input buffer may consist from more
> +     * than one zstd frames. So we iterate until we get a fully
> +     * uncompressed cluster.
> +     */
> +    while (output.pos < output.size) {
> +        ret = ZSTD_decompressStream(dctx, &output, &input);
> +        /*
> +         * if we don't fully populate the output but have read
> +         * all the frames from the input, we end up with error
> +         * here
> +         */
> +        if (ZSTD_isError(ret)) {
> +            ret = -EIO;
> +            break;
> +        }
> +        /*
> +         * Dest buffer size is the image cluster size.
> +         * It should be big enough to store uncompressed content.
> +         * There shouldn't be any cases when the decompressed content
> +         * size is greater then the cluster size, except cluster
> +         * damaging.
> +         */
> +        if (output.pos + ret > output.size) {
> +            ret = -EIO;
> +            break;
> +        }

But here, you use
"
or any other value > 0, which means there is still some decoding or flushing to do to complete current frame :
                                 the return value is a suggested next input size (just a hint for better latency)
                                 that will never request more than the remaining frame size.
"

I'm afraid that "just a hint" is not safe API to make a conclusion from. So, I'd prefer to drop this optimization
and just wait for an error from next ZSTD_decompressStream.

And therefore, for symmetry drop similar optimization on compression part..

What do you think?

> +    }
> +
> +    ZSTD_freeDCtx(dctx);
> +    return ret;
> +}
> +#endif
> +
>   static int qcow2_compress_pool_func(void *opaque)
>   {
>       Qcow2CompressData *data = opaque;
> @@ -217,6 +345,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
> @@ -249,6 +382,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
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
> index 643698934d..6632daf50b 100644
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
> @@ -3461,6 +3464,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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

