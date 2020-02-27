Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DEC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4AB222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f1ns+DpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4AB222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FvX-0006QH-QL
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Ftl-0005PU-Kw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Ftj-0006L5-Ge
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:56:05 -0500
Received: from mail-eopbgr130139.outbound.protection.outlook.com
 ([40.107.13.139]:14295 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7FtZ-00061B-Kx; Thu, 27 Feb 2020 04:55:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGJQW4/k/U2lJNktD8AdvQbRufXhKXJPt3/isE5izdM84OgKx6P2Pu2Dt48PtA0OhzUjSsNlEiy6q+oyET6YG0Vo2JTiuTT9DBQQ3gdsykTkmjYsMgqX63ZR2shf80+dTmFidoZbVbWpsDTgagMb5VAahlB17+PXRVW9pAwq2sTMK7vsxK0PQQE9wVzIQD/PdvfzhuwF0g0UxLREsxyOqg9sg/Tf3mYNtvsUBUrfhi+36LqV3KVTVepF9P6Xf2kG1/0nSZxls0UDD9yTNm18GTcsvbGNBIHOvZSY+bw0FopmG7x56dKTnRpfOQl9GKj13dNue5BBVPaVxMZSpyZJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ5Fim64mkulncKqysuxVnbezb1JMI5Oo2eyZ6dlXKE=;
 b=lcjx6h/GA69hI3/RPw7UDunrFLYMCN1KcXLxtJO5MFdYepMoUVfEPfdLj0ZYv4zlnIi0FOyTcgKo3wWp+6FtqeO/LJcnU4uBW50XYGE7k+vgqetk/qB0vw5nn5lUKVrLsVdJx0HhcJUFMWAP4F9/FaBr8fRao3JMrywQicjriWymPzbKMh5NngbwkM8AR7QDzv0lTHMk2q+r58BVnGDhEKMeeOsBeXLc4lbxAUmUUmuMYGEVEja04jRqnmVACW+KqidDPUzQEVXkQzT36LoPX5njeXpbUKxjNbT/5OQLTncNktb3LUHa1O53xBD7/Ivhssa9ZCJVJodWNxp8bsY1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ5Fim64mkulncKqysuxVnbezb1JMI5Oo2eyZ6dlXKE=;
 b=f1ns+DpGJs51avJlNjWnYVj0HacPI9+Kspb4iU046eMDtjwVYkvQgFKhvIDsS9nDX1lsH4gDwVGNdrqRLW3Y3wbFXhO4GtM3WUZ0y1/VKwyzLowOial7cXAsZURnvGqQP7mtPr5Psd4qPzzaCTeOo2BvPefP+XOKNn/hv6fFMMc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3118.eurprd08.prod.outlook.com (52.133.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 09:55:48 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 09:55:48 +0000
Subject: Re: [PATCH v1 3/8] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227125545657
Message-ID: <d1486527-8469-18f3-20ba-969a8232aafb@virtuozzo.com>
Date: Thu, 27 Feb 2020 12:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0332.eurprd05.prod.outlook.com
 (2603:10a6:7:92::27) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0332.eurprd05.prod.outlook.com (2603:10a6:7:92::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 09:55:47 +0000
X-Tagtoolbar-Keys: D20200227125545657
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e767fd53-f07c-4a3f-cdcb-08d7bb6b38a1
X-MS-TrafficTypeDiagnostic: VI1PR08MB3118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3118E348AAC0CA9E487CC421C1EB0@VI1PR08MB3118.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(376002)(136003)(189003)(199004)(31686004)(31696002)(66946007)(66556008)(66476007)(19273905006)(5660300002)(16576012)(2906002)(478600001)(2616005)(36756003)(956004)(316002)(86362001)(26005)(186003)(52116002)(30864003)(8676002)(81166006)(8936002)(16526019)(81156014)(4326008)(6486002)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3118;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0F1adHuXcfyUS0qJW8wGpHPKrPGVhvD9ePnBfLw86gCowwJq0LTp02Ai6IIL1nXm/1X04tfqIEpaqSi3YtrgYZzkywpPcOiFVZKhUhvs1pi9oseWI61GpcS6TRuSacHcoUBDyM+4QZWlPGBCzw5gNl+LAglrfsTs4koFfmn8NvDAbGN6nbEhM8dmgJZczHMITT0LIUH/q0bzhWX0GtxPvK5a+vWhfGNcliGqSLyTOYaHUiDpoSNpYQsGTGpXrtBebNTV2/Y3sMoVvjWGWtAjvgKPw94p/F7TloOFA/QEMLBHT38KBfVxDDccE8K6IGcXbwon7T1JzUx7gHhjju4o6L6pN6xYTFM1gkl5xBgWC6pajbic6n0lWbd3Fr8679Y36tvxNS2QXmFpa84TF6qW5nl648tdQH8R+FBk9XJ4cRHIOSNMTaP1nGCpMKmKEMIbGhd7J3QFGus2xxyO0PFIJB5j/l59ECVQGn4wCTaanLU6uRsU/p0mQrOgT7Bhwd7XLeerKIAtgqt1F3xUo3xkUB6oaIwVEz4ST+bXi8KKDpePpSxKvYtB4gJUEpMoK7I
X-MS-Exchange-AntiSpam-MessageData: 1kYJLzmxOWl3mRSgsB0Pv1FSXysD8wcHFnbWNP2Rh0kZCV0trMDG8thRyTun9ZKmJIBCgXdg+QKTwXkWcMD6WcmfDjh9gYFLXQkDNvTo/b+ZUhys7UnlZOx7+L8ZcbD2J5bYE3RfhKd9qxeoz9k+WQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e767fd53-f07c-4a3f-cdcb-08d7bb6b38a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 09:55:48.3586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8g3XYJsNKGuVjHyMZotPU10Q68KHp9C2qZwY7p0YYHHoTZvcG9LKtzNd4bDXnU/sgwgXqLB0RnVk2SOU26jayT8O81RNoBunOWw9dsPIg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3118
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.139
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
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
> ---
>   block/qcow2-threads.c  | 122 +++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   7 +++
>   configure              |  29 ++++++++++
>   docs/interop/qcow2.txt |  18 ++++++
>   qapi/block-core.json   |   3 +-
>   5 files changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 1c128e9840..e942c4d7e5 100644
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
> @@ -164,6 +169,113 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
>       return ret;
>   }
>   
> +#ifdef CONFIG_ZSTD
> +
> +#define ZSTD_LEN_BUF 4
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

This doesn't match qcow2_co_compress definition. You should return 0 on success.

> + *          -ENOMEM destination buffer is not enough to store compressed data
> + *          -EIO    on any other error
> + */
> +
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    size_t ret;
> +
> +    /*
> +     * steal ZSTD_LEN_BUF bytes in the very beginng of the buffer

beginning

> +     * to store compressed chunk size
> +     */
> +    char *d_buf = ((char *) dest) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can store the compressed data length,
> +     * and there is some space left for the compressor buffer
> +     */
> +    if (dest_size <= ZSTD_LEN_BUF) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -= ZSTD_LEN_BUF;
> +
> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall) {
> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /* paraniod sanity check that we can store the commpressed size */
> +    if (ret > UINT_MAX) {
> +        return -ENOMEM;
> +    }

I'd use UINT32_MAX, possibly even more paranoid)

> +
> +    /* store the compressed chunk size in the very beginning of the buffer */
> +    stl_be_p(dest, ret);
> +
> +    return ret + ZSTD_LEN_BUF;

return 0;

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
> +

extra empty line.

> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
> +{
> +    /*
> +     * zstd decompress wants to know the exact length of the data.
> +     * For that purpose, on compression, the length is stored in
> +     * the very beginning of the compressed buffer
> +     */
> +    size_t s_size;
> +    const char *s_buf = ((const char *) src) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can read 4 byte the content length and
> +     * and there is some content to decompress
> +     */
> +    if (src_size <= ZSTD_LEN_BUF) {
> +        return -EIO;
> +    }
> +
> +    s_size = ldl_be_p(src);
> +
> +    /* sanity check that the buffer is big enough to read the content from */
> +    if (src_size - ZSTD_LEN_BUF < s_size) {
> +        return -EIO;
> +    }
> +
> +    if (ZSTD_isError(
> +            ZSTD_decompress(dest, dest_size, s_buf, s_size))) {

hmm, it fit into one line actually

> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
>   static int qcow2_compress_pool_func(void *opaque)
>   {
>       Qcow2CompressData *data = opaque;
> @@ -215,6 +327,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>           fn = qcow2_zlib_compress;
>           break;
>   
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_compress;
> +        break;
> +#endif
>       default:
>           return -ENOTSUP;
>       }
> @@ -247,6 +364,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>           fn = qcow2_zlib_decompress;
>           break;
>   
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_decompress;
> +        break;
> +#endif
>       default:
>           return -ENOTSUP;
>       }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2ccb2cabd1..9c8ad9d580 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1257,6 +1257,9 @@ static int validate_compression_type(BDRVQcow2State *s, Error **errp)
>   
>       switch (s->compression_type) {
>       case QCOW2_COMPRESSION_TYPE_ZLIB:
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +#endif
>           break;
>   
>       default:
> @@ -3506,6 +3509,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           }
>   
>           switch (qcow2_opts->compression_type) {
> +#ifdef CONFIG_ZSTD
> +        case QCOW2_COMPRESSION_TYPE_ZSTD:
> +            break;
> +#endif
>           default:
>               error_setg_errno(errp, -EINVAL, "Unknown compression type");
>               goto out;
> diff --git a/configure b/configure
> index 48d6f89d57..4690a7ea9f 100755
> --- a/configure
> +++ b/configure
> @@ -444,6 +444,7 @@ opengl_dmabuf="no"
>   cpuid_h="no"
>   avx2_opt=""
>   zlib="yes"
> +zstd=""
>   capstone=""
>   lzo=""
>   snappy=""
> @@ -1371,6 +1372,10 @@ for opt do
>     ;;
>     --disable-lzfse) lzfse="no"
>     ;;
> +  --enable-zstd) zstd="yes"
> +  ;;
> +  --disable-zstd) zstd="no"
> +  ;;
>     --enable-guest-agent) guest_agent="yes"
>     ;;
>     --disable-guest-agent) guest_agent="no"
> @@ -1829,6 +1834,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>                     (for reading bzip2-compressed dmg images)
>     lzfse           support of lzfse compression library
>                     (for reading lzfse-compressed dmg images)
> +  zstd            support of zstd compression library
>     seccomp         seccomp support
>     coroutine-pool  coroutine freelist (better performance)
>     glusterfs       GlusterFS backend
> @@ -2453,6 +2459,25 @@ EOF
>       fi
>   fi
>   
> +#########################################
> +# zstd check
> +
> +if test "$zstd" != "no" ; then
> +    cat > $TMPC << EOF
> +#include <zstd.h>
> +int main(void) { ZSTD_versionNumber(); return 0; }
> +EOF
> +    if compile_prog "" "-lzstd" ; then
> +        LIBS="$LIBS -lzstd"
> +        zstd="yes"
> +    else
> +        if test "$zstd" = "yes"; then
> +            feature_not_found "zstd" "Install libzstd-devel"

to correspond to style used around: s/libzstd-devel/libzstd devel/

> +        fi
> +        zstd="no"
> +    fi
> +fi
> +
>   ##########################################
>   # libseccomp check
>   
> @@ -6668,6 +6693,7 @@ echo "lzo support       $lzo"
>   echo "snappy support    $snappy"
>   echo "bzip2 support     $bzip2"
>   echo "lzfse support     $lzfse"
> +echo "zstd support      $zstd"
>   echo "NUMA host support $numa"
>   echo "libxml2           $libxml2"
>   echo "tcmalloc support  $tcmalloc"
> @@ -7559,6 +7585,9 @@ if test "$plugins" = "yes" ; then
>   	    "\$ld_exported_symbols_list should have been set to 'yes'."
>       fi
>   fi
> +if test "$zstd" = "yes" ; then
> +  echo "CONFIG_ZSTD=y" >> $config_host_mak
> +fi
>   
>   if test "$tcg_interpreter" = "yes"; then
>     QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 5597e24474..aeca2ddebd 100644
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
> @@ -575,11 +576,28 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>                       Another compressed cluster may map to the tail of the final
>                       sector used by this compressed cluster.
>   
> +                    The layout of the compressed data depends on the compression
> +                    type used for the image (see compressed cluster layout).
> +
>   If a cluster is unallocated, read requests shall read the data from the backing
>   file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>   no backing file or the backing file is smaller than the image, they shall read
>   zeros for all parts that are not covered by the backing file.
>   
> +=== Compressed Cluster Layout ===
> +
> +The compressed cluster data has a layout depending on the compression
> +type used for the image, as follows:
> +
> +Compressed data layout for the available compression types:
> +(x = data_space_length - 1)

Note, that term 'data_space_lenght' is not defined in the spec..

Hmm. And it's not trivial to define it correctly, all we have is offset and
"number of additional sectors", and may be not all bytes of final sector are
occupied... What about something like this:

In the following layout description byte 0 corresponds to byte at host cluster offset,
as defined by "Compressed Clusters Descriptor" paragraph above. The whole layout occupy
space starting from this offset, using additional 512-byte sectors defined by
"Compressed Clusters Descriptor" paragraph, not necessarily occupying all of the bytes
in the final sector. Let x be number of last byte of the layout.

> +
> +    0:  (default)  zlib <http://zlib.net/>:
> +            Byte  0 -  x:     the compressed data content
> +                              all the space provided used for compressed data
> +    1:  zstd <http://github.com/facebook/zstd>:
> +            Byte  0 -  3:     the length of compressed data in bytes
> +                  4 -  x:     the compressed data content

Maybe, note that x+! == 4 + length, where length is value of first field of the layout.

>   
>   == Snapshots ==
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 873fbef3b5..4b6e576c44 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4401,11 +4401,12 @@
>   # Compression type used in qcow2 image file
>   #
>   # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>   #
>   # Since: 5.0
>   ##
>   { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>   
>   ##
>   # @BlockdevCreateOptionsQcow2:
> 


-- 
Best regards,
Vladimir

