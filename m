Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C2CC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91E220775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qNNy+jPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91E220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT9Pp-0003Kn-RM
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 15:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jT9Ok-0002VE-Qm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jT9Ok-0003FU-6S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:26:34 -0400
Received: from mail-eopbgr60123.outbound.protection.outlook.com
 ([40.107.6.123]:50991 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jT9Od-0003EO-Ho; Mon, 27 Apr 2020 15:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7SIePVpCR63yRaV/oJfoTqpJYatojko3iEC/DzmmV+0/oPYCrE4owC9lVU7ncSaPJA9aVY0NUp0YIzhFU4tTW5x7TD9npuXpVSGJvoQEyYpKil2i1whsnahHK5NyXXztqUeDfTMNda6xs7wzLrL1Hw/6Hajt7b7iGockai4KGWhXkoduzdDosIkTg4BFnvPdsuxYkFZojbiQ2VAp2vSvVjdjRr7Dm78vMIKSogzNQsnFA3sUTRludP6Kbm7qCL4eQWx6XFBEqDGqk5CEJ0sKjwQ5GJdPyZQYVansY+sMVJxP6ALfip3Q8mxMC1aOJiW8kJOhjfxBL9LMCaPeswBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je9arl3OGdL8OS8yoYK9Acey5rwxFVEzuUxqwvoARSo=;
 b=nk5k41Lw+uHvnudHSLvADyTs+mc3EJ4/oAmNz1NXBw5+bxR3HwRZ1PzaIuqpWMaVFYocV+hH54X74ZXOEC3kxGoHtOScvxc3iNArzFFlfGwNgspqkeYSAnwvxbkqI29u0YF5330ats7F47a2UZwY9VEn2YnTxkBIpBQEzm7ALsCshy2IPrSvINWwVB7ojNon4NX4VS3xXdYfqRf5CMzsDBcoetzQrv86UhJ5pmjEfN/dFBL4LMLFZ4zpVG2pyr+U98GtA8ZdYqs9ZMMuecVq978NOJ5R1l82ptamQAJ4KHkY4foNhtGDcBxtoif2ACovuYjN/o+DSSUeh9W9ozb8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je9arl3OGdL8OS8yoYK9Acey5rwxFVEzuUxqwvoARSo=;
 b=qNNy+jPX4QXKsu0oF5mEuVDvE5i9e1KhXFVkzgjbZbDzFYTMNqkTLohNP43ZvnNBZWRSQ8I6KKXDy+x9XkFluNV/ym4gRqiUX3LFLA7wRJ1LRq6heKSN1prPUuuwCk8GJWg9+P+74Eqi4QWthW63fuPjW7BwobAs2mFCRld3xr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4340.eurprd08.prod.outlook.com (2603:10a6:208:139::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 19:26:23 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 19:26:23 +0000
Subject: Re: [PATCH v20 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-4-dplotnikov@virtuozzo.com>
 <f8b52ed6-9532-ff65-5c18-0b5142c3b550@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f34a5b59-a323-4d63-e4c6-2fcd505b58b1@virtuozzo.com>
Date: Mon, 27 Apr 2020 22:26:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <f8b52ed6-9532-ff65-5c18-0b5142c3b550@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.240.57) by
 AM0PR01CA0111.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 19:26:22 +0000
X-Originating-IP: [94.233.240.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7530dd-7362-4f82-d614-08d7eae0df5d
X-MS-TrafficTypeDiagnostic: AM0PR08MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB43409EA3F9F9C811A8F670CBCFAF0@AM0PR08MB4340.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(956004)(86362001)(2616005)(478600001)(186003)(4326008)(5660300002)(16526019)(66556008)(52116002)(26005)(66476007)(8676002)(66946007)(2906002)(316002)(16576012)(53546011)(36756003)(6666004)(31686004)(31696002)(6486002)(81156014)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf+RCwIMadR3hTy5A/T2l+hZMgofizXlQ3Rht+quohJWbCMcZfuEIH+i/MWF0DFV98d/Xa4LvkcS8TUbwKeWZ9vqpi2B4HZrls5NDwN/c3Ya4o/5J07CFe4r/33sPTHya+0lK6CTd39dH8vi+yGoILRAGHR/GyX2YlSziyihEZJDaT/1MM+p/kP+KAhGMGrNyJ38oxFxyj/rYPHq3rQnsTSN6ldqca5Kg7okphOphkLQMtOgERn5GcblEOuSAElgtl6qAD6lJW9p+U2WPtZ9GlC+dlKs6RaH7OmktbtJc0Yx3wVejE5vumVKy0qnqvtr/PiViL6t/0n9VjEcnXBnsfUDild53WMPg9KfDzJUTA/nmieK4S9SGhC93n8A4O7wNKZ+6u1RaV5DrP9TkbwRfAekiE9P3MMEku5uMaj9+I2kul9+95X+5sIUVuWcEkBk
X-MS-Exchange-AntiSpam-MessageData: VWPzbcmSVsSZWW5nIQMGKOQW8Y5bUBJAZ3lzjEtdB1nwoipypsYnsezHuNVTjPlqKo1L3iuwK8Up+nZMJ4Gq/faQFObyx24vOXtB+zG/fwure2Rc3pAtVimkmfZqUy6A17nLxJ6/PKk2jASnmetRQGfLed7ORM8cglZSiwqEUSH7/dz3MQSgL3MW2YEwImrUayO0nbONhEwefE0io7/olrqDpxJ9ZplfJQoeVoucREWvQeFSPkeA/HlSgRwPTjlK4uZfgxsUfbDK6xVCA10L/wHxt1uEvgmQ2e+xBNo6TW+N4UGoioW1im9ewJQxLs+ZzY3m8N0CDqbFYedQp7hbQ1OBkaDK10RL1Sq4yDYWjhZ2tPkfnb9Dd/9thOTvgVbnH4ZKdf9FqFGSqlcssJ4zzLHEO+f4Xxnbpvf5FrTAjlkojtfBSkb7CK/ImhZSnhYoxvqWOzG/tzzxby+e7guIiCnvYgzRbNumR4M4aHyESqeuPNIA7EnqtsajPhsOQI1B8ymubF27xuZo3fuaahyLbftz9BVMZFnq49xPInTSv24hqeFCZjivx/sztZhiKcTLIJivPbosVxN9LeRqQOR35h6yI6ShHGyBORGQCILL9NNha3FrQL+CDyzHcD4OX+H2dgaOoxrk+jNsFtFOqn49n1MVTSyvbovDFmWPOLFsiy5zPOccM6NoOsTaCFxZvsse8wvvtpYfvHmYFGI8ny4tyuTIANJpgg2d1nYxvHx5wkbpquLGCKU4sTr/5Vx5tpfbFRSi9KJV1iZ9CGzbYRSTf2RDvQ2N9Jzp7YPAiuRhTi8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7530dd-7362-4f82-d614-08d7eae0df5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 19:26:23.9186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCGxs8xEtry40fqCsV4wz+H0V8CwKL4a9t5TdXHar/VbyaSTGMpoLOgdAaUJxDEue0FfcU0mQfQyO5/tv8tDUbXWLA7rpVuQ74GGRtF4aQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4340
Received-SPF: pass client-ip=40.107.6.123;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 15:26:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.123
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
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.04.2020 15:35, Max Reitz wrote:
> On 21.04.20 10:11, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>>                    src.img [zlib|zstd]_compressed.img
>> decompress cmd
>>    time ./qemu-img convert -O qcow2
>>                    [zlib|zstd]_compressed.img uncompressed.img
>>
>>             compression               decompression
>>           zlib       zstd           zlib         zstd
>> ------------------------------------------------------------
>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>> user     65.0       15.8            5.3          2.5
>> sys       3.3        0.2            2.0          2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/interop/qcow2.txt |   1 +
>>   configure              |   2 +-
>>   qapi/block-core.json   |   3 +-
>>   block/qcow2-threads.c  | 157 +++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c          |   7 ++
>>   5 files changed, 168 insertions(+), 2 deletions(-)
> [...]
>
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 7dbaf53489..0525718704 100644
>> --- a/block/qcow2-threads.c
>> +++ b/block/qcow2-threads.c
>> @@ -28,6 +28,11 @@
>>   #define ZLIB_CONST
>>   #include <zlib.h>
>>   
>> +#ifdef CONFIG_ZSTD
>> +#include <zstd.h>
>> +#include <zstd_errors.h>
>> +#endif
>> +
>>   #include "qcow2.h"
>>   #include "block/thread-pool.h"
>>   #include "crypto.h"
>> @@ -166,6 +171,148 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
>>       return ret;
>>   }
>>   
>> +#ifdef CONFIG_ZSTD
>> +
>> +/*
>> + * qcow2_zstd_compress()
>> + *
>> + * Compress @src_size bytes of data using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: compressed size on success
>> + *          -ENOMEM destination buffer is not enough to store compressed data
>> + *          -EIO    on any other error
>> + */
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +                                   const void *src, size_t src_size)
>> +{
>> +    ssize_t ret;
>> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
>> +    ZSTD_inBuffer input = { src, src_size, 0 };
> Minor style note: I think it’d be nicer to use designated initializers here.
>
>> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
>> +
>> +    if (!cctx) {
>> +        return -EIO;
>> +    }
>> +    /*
>> +     * Use the zstd streamed interface for symmetry with decompression,
>> +     * where streaming is essential since we don't record the exact
>> +     * compressed size.
>> +     *
>> +     * In the loop, we try to compress all the data into one zstd frame.
>> +     * ZSTD_compressStream2 potentially can finish a frame earlier
>> +     * than the full input data is consumed. That's why we are looping
>> +     * until all the input data is consumed.
>> +     */
>> +    while (input.pos < input.size) {
>> +        size_t zstd_ret;
>> +        /*
>> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
>> +         * with ZSTD_e_end until it returns 0, at which point you are
>> +         * free to start a new frame". We assume that "start a new frame"
>> +         * means call ZSTD_compressStream2 in the very beginning or when
>> +         * ZSTD_compressStream2 has returned with 0.
>> +         */
>> +        do {
>> +            zstd_ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
> The spec makes it sound to me like ZSTD_e_end will always complete in a
> single call if there’s enough space in the output buffer.  So the only
> team we have to loop would be when there isn’t enough space anyway:
>
> It says this about ZSTD_e_end:
>> flush operation is the same, and follows same rules as calling
>> ZSTD_compressStream2() with ZSTD_e_flush.
> Those rules being:
>> Note that, if `output->size` is too small, a single invocation with
>> ZSTD_e_flush might not be enough (return code > 0).
> So it seems like it will only return a value > 0 if the output buffer is
> definitely too small.
>
> The spec also notes that the return value is greater than 0 if:
>>> 0 if some data still present within internal buffer (the value is
>> minimal estimation of remaining size),
> So it’s a minimum estimate.  That’s another point that heavily implies
> to me that if the return value were less than what’s left in the buffer,
> the function wouldn’t return but still try to write it out, until it
> realizes that there isn’t enough space in the output buffer, and then
> return a value that exceeds the remaining output buffer size.
>
> (Because if the function just played it safe, I would expect it to
> return a maximum estimate.)
>
>
> OTOH, if it were actually possible for ZSTD_e_end to finish a frame
> earlier than the end of the input, I think it would make more sense to
> use ZSTD_e_continue until the input is done and then finish with
> ZSTD_e_end, like the spec seems to propose.  That way, we’d always end
> up with a single frame to make decompression simpler (and I think it
> would also make more sense overall).
>
>
> But anyway.  From how I understand the spec, this code simply always
> ends up creating a single frame or erroring out, without looping ever.
> So it isn’t exactly wrong, it just seems overly complicated.  (Again,
> assuming I understand the spec correctly.  Which seems like a tough
> thing to assume, because the spec is not exactly obvious to read...)
>
> (Running some quick tests by converting some images with zstd
> compression seems to confirm that whenever ZSTD_compressStream2()
> returns, either zstd_ret > output.size - output.pos, or zstd_ret == 0
> and input.pos == input.size.  So none of the loops ever loop.)
>
> Max

So, what should we do?

1. Rely on the test that there's no need for the loop:
    * make one ZSTD_compressStream2() call
    * make sure it returned with zstd_ret == 0 and
      input.pos == input.size.
      if so, return with the size
    * if not, check that zstd_ret > output.size - output.pos
      if so, return with -ENOMEM
    * if none above return with -EIO

    This should cover the majority of the compressing cases

2. Leave the loop as is, because of the documentation:
    "You *must* continue calling ZSTD_compressStream2() with ZSTD_e_end 
until it returns 0,
     at which point you are free to start a new frame."

    This fulfills the documentation requirements.

3. Any other option?

Denis


>
>> +
>> +            if (ZSTD_isError(zstd_ret)) {
>> +                ret = -EIO;
>> +                goto out;
>> +            }
>> +            /* Dest buffer isn't big enough to store compressed content */
>> +            if (zstd_ret > output.size - output.pos) {
>> +                ret = -ENOMEM;
>> +                goto out;
>> +            }
>> +        } while (zstd_ret);
>> +    }
>> +    /* make sure we can safely return compressed buffer size with ssize_t */
>> +    assert(output.pos <= SSIZE_MAX);
>> +    ret = output.pos;
>> +out:
>> +    ZSTD_freeCCtx(cctx);
>> +    return ret;
>> +}


