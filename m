Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65852C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171A72074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OX7D9/zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171A72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJWGc-0003V4-90
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 01:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJWFp-00030e-DG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJWFn-0006DT-VQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:49:33 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:21235 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJWFi-0005vc-HI; Wed, 01 Apr 2020 01:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdu6Exvqrh32O6+39FzQw0yWDHTNFJ7cVWuUksoyAkwk3+TkHCdS/WUp/WgZ4DmTRh6bgD27fP7A4/HP+grn1p7zxjVlGx+jZBCyn22WxCd538vq8fJ65hHmVlPTk5LGojzagPDYoARr8cUaPBZTYyfEnj1p6RNVvPWWe/L9WEg7YLMAe33+o7Y3uG+UFZvwUe5JxWOAnQP72H6jKZcuL8FktExnGmrxCNmVudyfhxt0RpUp+XwfC18lG968l9PV6oEi99dSzOlcPFOGd+G9JwLwImqEoQc5MAmalXYZm0eScZmrueQjxbW+62CxkXMoUAhKNAphfNEGlS5fAbGFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KDBx925ldtk3dvq0HwEmpOiRT9iVYZElPaGKmiSD8k=;
 b=EgPlH7hcjYEUCttIPCVN/3CrXRIkALOFpU5plm2S1yFAnwn5fRxWRxaWdrDMmBl7fMBumTCwscB7j5/f5+I1jg6/Thj3eD5fTvPnnGWc21c1du4WdwxWBN36jTIzYn8uXB0Qsd7apNnSyiJDMouPG33PCfSa8gzyKJew5goCGRzuqEoDFxDU6iOkypKv6xQYbFBWxq8B47SbrgmrRLsXE38q7WLZ47/vrOcKUj2R55rIrcDsUiq6UX9jvaMTC6y+47LsNfC7FCAr3Hzvg1AWh9flyJNJJUXd4RZCTR/DQK/PnDSuYOp8ebnFHepnS5JoQJ1ZwQvCaI7HBG7TMEd9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KDBx925ldtk3dvq0HwEmpOiRT9iVYZElPaGKmiSD8k=;
 b=OX7D9/zO1WJLGBuuPJ7/IyuJIwiMayk7w/iXwmzXRjdm0EMFiRbEM3Xkf4ySI0DBwVEw7ATCPetUB4Jav2pB89yCdiUFGT3gQX2X9sGpHnaBw9L6oNWGrJhxQFCdBOWYpbVHdBm4UpDvayrzd05oO0HOfFTD02RDfOk48rEP1I8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5528.eurprd08.prod.outlook.com (10.141.175.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 05:49:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 05:49:23 +0000
Subject: Re: [PATCH v14 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401084921757
Message-ID: <434f359a-998f-1c60-ecad-fa6cb25e9374@virtuozzo.com>
Date: Wed, 1 Apr 2020 08:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200331174455.31792-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0013.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 05:49:22 +0000
X-Tagtoolbar-Keys: D20200401084921757
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 411c4369-48cb-4501-87ac-08d7d6006e29
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5528748EA7FDB38CE513DB09C1C90@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(66556008)(316002)(4326008)(31696002)(2906002)(66476007)(478600001)(8936002)(66946007)(52116002)(86362001)(81156014)(2616005)(956004)(81166006)(186003)(6486002)(36756003)(8676002)(16576012)(31686004)(16526019)(5660300002)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8y8EVj9xlcuvcS0ZqdFvrHpu1+KDi19VvzG947mkzCoEDxzhN0WB7E9Yav+AFooSfWteY3z1ZNpqazJn08O2jmpGlDBSkxUVH2GhHUN4OmWms2TPhH6dUAPp7YaRhWujPujbpIKF0IeHpmmLL0ZEwKOceIYeuPA1EZ6yCMh2W3Ct6bW+sxxWk7P8uAwWgjuFwhn2Tib276cSBWkiaj6NA6zNXidqqQ7vq1HGIMIF+Db2+XtnDliIFEmrPDM+i7tLYsd8Gq4oEkdU6ZBAh2E/F4HfyeO9kQpkERckFtgFZcvxlwl/GkOlav9RKvJEvXpJ5ClWDVyoD2+HbowpO/MfzstYYL3RZgGs/Hq+X9GhL82Gq7zLfgVXb06wiBOo4XiQ3Ic5oSXtzG9F8ci0BfqqG5VyzWCE2vyGQas3rH4V+1y/YUbPYqU5NbmgqX1Ry4Wn
X-MS-Exchange-AntiSpam-MessageData: /YbGQ2SG9Mdnmee0YW7tgmLzvwWXYu2iLGNtVasDKLWAaubs6KEb33svh0nJ2Skx0OlzO3FC3GL3YiXPUmTPQ0PrBXWIWg0KtN3QbYCxru3ZIdbJEXRJKqyLZmq27XTfAyGQs9oEO9tLfiWMDvrDVA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411c4369-48cb-4501-87ac-08d7d6006e29
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 05:49:23.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAescqUU24Ughz4IQd6C29SLPDni8KYb8TXP9IXNaCwIlP95dkoqLFwGTOwsKqJ08fhMJffJL6pNEue0PkLck5PaZdIFKR/EgMG8JL8eYjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.95
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

31.03.2020 20:44, Denis Plotnikov wrote:
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

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    size_t zstd_ret = 0;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * We want to use zstd streamed interface on decompression,
> +     * as we won't know the exact size of the compressed data.
> +     *
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 potentially can finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {

zstd_ret may be defined here.

> +        /*
> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +         * with ZSTD_e_end until it returns 0, at which point you are
> +         * free to start a new frame". We assume that "start a new frame"
> +         * means call ZSTD_compressStream2 in the very beginning or when
> +         * ZSTD_compressStream2 has returned with 0.
> +         */
> +        do {

Hmm. Why did you decide to use nested loop?  Ok, it works too.

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

You forget to fix ret here. ret of the function should be ssize_t and for
ZSTD - size_t.

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
> +     * from zstd docs related to ZSTD_decompressStream:
> +     * "return : 0 when a frame is completely decoded and fully flushed"
> +     * We suppose that this means: each time ZSTD_decompressStream reads
> +     * only ONE full frame and return 0 if and only if that frame
> +     * is completely decoded and flushed. Only after returning 0,
> +     * ZSTD_decompressStream reads another ONE full frame.
> +     */
> +    while (output.pos < output.size) {
> +        size_t last_in_pos = input.pos;
> +        size_t last_out_pos = output.pos;
> +        ret = ZSTD_decompressStream(dctx, &output, &input);
> +        /*
> +         * zstd manual doesn't explicitly states what happens,
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
> +         * As ZSTD manual is vague about what to do if it
> +         * reads the buffer partially, we afraid of case
> +         * when we stuck in the infinite loop, because
> +         * output isn't full and input has read partially, so
> +         * ZSTD_decompressStream returns > 0 waiting for
> +         * another input chunk. So, we add a paranoid check
> +         * that on each step the loop makes some progress.
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
> +    }
> +
> +    ZSTD_freeDCtx(dctx);
> +    assert(ret == 0 || ret == -EIO);
> +    return ret;
> +}


[..]


-- 
Best regards,
Vladimir

