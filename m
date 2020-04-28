Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1CF206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BJjIclZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1CF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTM59-0003rk-Qs
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTLvv-0002e6-Rb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTLui-0004An-43
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:49:37 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
 ([40.107.4.129]:37080 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTKb2-0007iD-0p; Tue, 28 Apr 2020 03:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQP0MrguwHqWuAN5vgfana70HybCK+W49eFh90v9owiNQsjwq6yOgGvauX0Z6dN4uYJzJV2LDKYsJOSieRSJussgrX40KvvMLTg37zuSmvz7R6L6vL1mVAgFa188cFkpIaqHSURLz5iFzP2a3rJZj+TZYbSMDP152yMCsT8GnqTzL5skRHQyELFcSpGtLX7HuCuxNZz/JPwBsZrc6mmB4SvBMXNc5eHtNM6WepURSlp8kpAohHUMzW6bbmWElrBPwy5Ks+ZkZZBCGGQxG44BvbQ2RFcgWt15n+4Vh6I/6/rNaFtgvvHrCLg+6DYpucTmn9Ycm8phui+3msybiieX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txwedmn+1/buXVENuJfgaVDhDK/J8V4wQhnXvXorpyc=;
 b=mpKAmsu1996BQ9ZL0Wc6jeGQqNX11yEmAif9iDNOJpY3nxpvzQwd6olYqV1Q9nQ5GyNPrI9xa6CvUCJKNiT6EDZPKdbl/hWoXC/18hxjuyHm/P9pV60iCH3t09ILrZNbl+vqPZM3oLS9T45Pmx3vanrvYbg4OawNivu5mvLmnACkLri5AKa6PZ4CNqxX6VEsbeLC0OE2h5Rx2UsnTtRx5AZryfkEShHA1eBuzACyJdEfoPnG/8lgYVRujGq+CL0OUhh5abN92W6viIoQkwgCNvNAU61igDuFoKhwjJUT5vynJFEfZN96uepotINcmMy9yLKP53zXNxqfZaJbKpN4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txwedmn+1/buXVENuJfgaVDhDK/J8V4wQhnXvXorpyc=;
 b=BJjIclZyqelueq9MmuYIHj0PwDTgLArduA6rbirD6ULUbikhRvaKE7HnciGg8l2N5l85GPj71xJ53E9GrYaXF/aR6e+rPOR01mrSqo9tDZb+q+onrmU4x/wri5wsMbx2askHbNc4Bcscd082A9sofN5UjCQXcRRb7LA9/6XgG5s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5252.eurprd08.prod.outlook.com (2603:10a6:208:15a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 07:23:56 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 07:23:56 +0000
Subject: Re: [PATCH v20 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-4-dplotnikov@virtuozzo.com>
 <f8b52ed6-9532-ff65-5c18-0b5142c3b550@redhat.com>
 <f34a5b59-a323-4d63-e4c6-2fcd505b58b1@virtuozzo.com>
 <6f9049f9-4b2a-796d-d3f7-dbd9dbe720cc@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <7f239f5d-b909-b23c-5571-bd021e4e1dfb@virtuozzo.com>
Date: Tue, 28 Apr 2020 10:23:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <6f9049f9-4b2a-796d-d3f7-dbd9dbe720cc@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 07:23:55 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3092088a-d63c-44a7-60c1-08d7eb451cbe
X-MS-TrafficTypeDiagnostic: AM0PR08MB5252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5252AC7C3AFDD821343B4418CFAC0@AM0PR08MB5252.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(478600001)(16576012)(36756003)(956004)(2616005)(66556008)(4326008)(66476007)(53546011)(26005)(8936002)(86362001)(2906002)(8676002)(6486002)(52116002)(81156014)(16526019)(31686004)(31696002)(66946007)(6666004)(5660300002)(186003)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erJSV6bFq2293cHoWjl4vAvC9/hzR16XPWmFACYOi1UUs932Y6kbgz3Izh2EjI9Vlsyh28QSA6gZbJRpDCDFGwudCAZ2uybN1A4XQ7a5oGm9soHTVCOx8eb+1BDNVGawOtDz5URsECEUBwYtTz8OswaNH4vXrRaUQTluHurCCydqlFd/4GqG66N7nFZivj3mfQpTAXlY/hoTEkbdqIC3u8FmwMzy0TuWDwg+N4ZHaW8MmEFr64oDgTq88b9yGaj0TpZn06AiMxtKRzhupfHQCbguaeFdXVAHXAlNIg+JkZvvNHqivXlxEwaQxhGB2yGJEXcWJ8WnU8y66zP8LFwW7vLJ1l71x10pQA5lffHVpMSTlfriZogwPPcRCO+lNBbzjrQwWvpMjvqN/hcdnjQYXOrx6iQCU5qwv+nH8/emgoN+Am10UvFiZXiqY6E3ficG
X-MS-Exchange-AntiSpam-MessageData: MLhlQ8Vde2H4LrhkfV2wkqLg3opfL62OAZKriK/8IaWHYINaOzHBUPlygt0PvaJ07EYx3Il77nsYkWzRzC2uGEkGecgOsrg4lzJ/RoJHTHslWq4PHGfg1fy9/RQva02DlPrUwf0b0Rt8RjhIEwOjEtGFyPvaVf6bc1akShNJX9sr9vKYD5pcbuU7FAfvtrXz69Ah5LIjb4WFPxsHdAHk38ePsnZZHiovlCnxQXXHw2k+BWxu98pkXuAPzKAo2GNeqT1XoQGfwXyeKVaxdc/wiLjVnF/p6+MHy7ykWwnylyviK/10wTnosck8If5fW8B4lJ+KxreZTqHFLLZ/ftDMByoC/lsakrPPGGVP+CQTbuZG308SnXJlD8pLA2ddDHJ5rhnHw6h6IyTZVpKBC4EWjjgDFzBUoEnidcyGs+nlDG0XKg7tRSbSzMTRb8q1lQERjfhn7JT/RWx1Q4gn6eXenKH1w8TG40iw+L/5NEiDu1SR6z75h4WLFGSbaRJWWB8g66KxAYKI5xbhicPmBoSpbonTcgP8f/owK4GKcoeWQjWZKmsZAi0cCsEgo3TWsvfo7KXq/1HQBn/KbKmypUvqJt6J3wQyeNiuY4XD0UafOTmVST1brg81eiOWP52v1KrmXafnmJ4fFlOiTws+V6hNqnY5m+q6y67R/hKH0DANKiaeL3NQOs+haIyzOCOU9uGhzDHxtMUfSt/AFolVDiGMatTFQrzLK30Az65mj+XYas/Sa0n1AHdBVJeq6pxcaC4N356N3RxKnb4wFhBAn7acXZzDrHAqCqooedRkme17q8w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3092088a-d63c-44a7-60c1-08d7eb451cbe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:23:56.5163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OepK933kOrzlzkwaT3189/FP1EOXh5voD5V4LbCTqGsq5UeYLxzRwSKb213s1e+wHpy+uR1RQCr7zNmA62v5tq12DyfvwLJRuYuh8LCBBNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5252
Received-SPF: pass client-ip=40.107.4.129;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 03:23:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.129
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



On 28.04.2020 09:16, Max Reitz wrote:
> On 27.04.20 21:26, Denis Plotnikov wrote:
>>
>> On 27.04.2020 15:35, Max Reitz wrote:
>>> On 21.04.20 10:11, Denis Plotnikov wrote:
>>>> zstd significantly reduces cluster compression time.
>>>> It provides better compression performance maintaining
>>>> the same level of the compression ratio in comparison with
>>>> zlib, which, at the moment, is the only compression
>>>> method available.
>>>>
>>>> The performance test results:
>>>> Test compresses and decompresses qemu qcow2 image with just
>>>> installed rhel-7.6 guest.
>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>
>>>> The test was conducted with brd disk to reduce the influence
>>>> of disk subsystem to the test results.
>>>> The results is given in seconds.
>>>>
>>>> compress cmd:
>>>>     time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>>>>                     src.img [zlib|zstd]_compressed.img
>>>> decompress cmd
>>>>     time ./qemu-img convert -O qcow2
>>>>                     [zlib|zstd]_compressed.img uncompressed.img
>>>>
>>>>              compression               decompression
>>>>            zlib       zstd           zlib         zstd
>>>> ------------------------------------------------------------
>>>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>>>> user     65.0       15.8            5.3          2.5
>>>> sys       3.3        0.2            2.0          2.0
>>>>
>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>> compressed image size in both cases: 1.4G
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>> QAPI part:
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    docs/interop/qcow2.txt |   1 +
>>>>    configure              |   2 +-
>>>>    qapi/block-core.json   |   3 +-
>>>>    block/qcow2-threads.c  | 157 +++++++++++++++++++++++++++++++++++++++++
>>>>    block/qcow2.c          |   7 ++
>>>>    5 files changed, 168 insertions(+), 2 deletions(-)
>>> [...]
>>>
>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>> index 7dbaf53489..0525718704 100644
>>>> --- a/block/qcow2-threads.c
>>>> +++ b/block/qcow2-threads.c
>>>> @@ -28,6 +28,11 @@
>>>>    #define ZLIB_CONST
>>>>    #include <zlib.h>
>>>>    +#ifdef CONFIG_ZSTD
>>>> +#include <zstd.h>
>>>> +#include <zstd_errors.h>
>>>> +#endif
>>>> +
>>>>    #include "qcow2.h"
>>>>    #include "block/thread-pool.h"
>>>>    #include "crypto.h"
>>>> @@ -166,6 +171,148 @@ static ssize_t qcow2_zlib_decompress(void
>>>> *dest, size_t dest_size,
>>>>        return ret;
>>>>    }
>>>>    +#ifdef CONFIG_ZSTD
>>>> +
>>>> +/*
>>>> + * qcow2_zstd_compress()
>>>> + *
>>>> + * Compress @src_size bytes of data using zstd compression method
>>>> + *
>>>> + * @dest - destination buffer, @dest_size bytes
>>>> + * @src - source buffer, @src_size bytes
>>>> + *
>>>> + * Returns: compressed size on success
>>>> + *          -ENOMEM destination buffer is not enough to store
>>>> compressed data
>>>> + *          -EIO    on any other error
>>>> + */
>>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>>> +                                   const void *src, size_t src_size)
>>>> +{
>>>> +    ssize_t ret;
>>>> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
>>>> +    ZSTD_inBuffer input = { src, src_size, 0 };
>>> Minor style note: I think it’d be nicer to use designated initializers
>>> here.
>>>
>>>> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
>>>> +
>>>> +    if (!cctx) {
>>>> +        return -EIO;
>>>> +    }
>>>> +    /*
>>>> +     * Use the zstd streamed interface for symmetry with decompression,
>>>> +     * where streaming is essential since we don't record the exact
>>>> +     * compressed size.
>>>> +     *
>>>> +     * In the loop, we try to compress all the data into one zstd
>>>> frame.
>>>> +     * ZSTD_compressStream2 potentially can finish a frame earlier
>>>> +     * than the full input data is consumed. That's why we are looping
>>>> +     * until all the input data is consumed.
>>>> +     */
>>>> +    while (input.pos < input.size) {
>>>> +        size_t zstd_ret;
>>>> +        /*
>>>> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
>>>> +         * with ZSTD_e_end until it returns 0, at which point you are
>>>> +         * free to start a new frame". We assume that "start a new
>>>> frame"
>>>> +         * means call ZSTD_compressStream2 in the very beginning or
>>>> when
>>>> +         * ZSTD_compressStream2 has returned with 0.
>>>> +         */
>>>> +        do {
>>>> +            zstd_ret = ZSTD_compressStream2(cctx, &output, &input,
>>>> ZSTD_e_end);
>>> The spec makes it sound to me like ZSTD_e_end will always complete in a
>>> single call if there’s enough space in the output buffer.  So the only
>>> team we have to loop would be when there isn’t enough space anyway:
>>>
>>> It says this about ZSTD_e_end:
>>>> flush operation is the same, and follows same rules as calling
>>>> ZSTD_compressStream2() with ZSTD_e_flush.
>>> Those rules being:
>>>> Note that, if `output->size` is too small, a single invocation with
>>>> ZSTD_e_flush might not be enough (return code > 0).
>>> So it seems like it will only return a value > 0 if the output buffer is
>>> definitely too small.
>>>
>>> The spec also notes that the return value is greater than 0 if:
>>>>> 0 if some data still present within internal buffer (the value is
>>>> minimal estimation of remaining size),
>>> So it’s a minimum estimate.  That’s another point that heavily implies
>>> to me that if the return value were less than what’s left in the buffer,
>>> the function wouldn’t return but still try to write it out, until it
>>> realizes that there isn’t enough space in the output buffer, and then
>>> return a value that exceeds the remaining output buffer size.
>>>
>>> (Because if the function just played it safe, I would expect it to
>>> return a maximum estimate.)
>>>
>>>
>>> OTOH, if it were actually possible for ZSTD_e_end to finish a frame
>>> earlier than the end of the input, I think it would make more sense to
>>> use ZSTD_e_continue until the input is done and then finish with
>>> ZSTD_e_end, like the spec seems to propose.  That way, we’d always end
>>> up with a single frame to make decompression simpler (and I think it
>>> would also make more sense overall).
>>>
>>>
>>> But anyway.  From how I understand the spec, this code simply always
>>> ends up creating a single frame or erroring out, without looping ever.
>>> So it isn’t exactly wrong, it just seems overly complicated.  (Again,
>>> assuming I understand the spec correctly.  Which seems like a tough
>>> thing to assume, because the spec is not exactly obvious to read...)
>>>
>>> (Running some quick tests by converting some images with zstd
>>> compression seems to confirm that whenever ZSTD_compressStream2()
>>> returns, either zstd_ret > output.size - output.pos, or zstd_ret == 0
>>> and input.pos == input.size.  So none of the loops ever loop.)
>>>
>>> Max
>> So, what should we do?
>>
>> 1. Rely on the test that there's no need for the loop:
>>     * make one ZSTD_compressStream2() call
>>     * make sure it returned with zstd_ret == 0 and
>>       input.pos == input.size.
>>       if so, return with the size
>>     * if not, check that zstd_ret > output.size - output.pos
>>       if so, return with -ENOMEM
>>     * if none above return with -EIO
>>
>>     This should cover the majority of the compressing cases
> According to how I interpret the spec, “none of the above” should never
> happen except for ZSTD_isError(zstd_ret), so this should cover all
> compressing cases, actually.
>
>> 2. Leave the loop as is, because of the documentation:
>>     "You *must* continue calling ZSTD_compressStream2() with ZSTD_e_end
>> until it returns 0,
>>      at which point you are free to start a new frame."
> As far as I can see, the return value is always 0 or greater than the
> remaining buffer space, so this will always be satisfied even without a
> loop.  (We will always have one of three cases: (1) Success and all
> input has been consumed, (2) ZSTD_isError(zstd_ret), so we return -EIO,
> (3) zstd_ret > output.size - output.pos, so we return -ENOMEM.
>
> I interpret the “You *must* continue until it returns 0” as “If there is
> no sufficient space in the output buffer, this function will return a
> value greater than 0 indicating how much space is at least still
> required.  The caller is free to supply a greater output buffer for the
> next call (by supplying a different ZSTD_outBuffer structure), and then
> we’ll try again.”
> (I.e., retrying with the same ZSTD_outBuffer will make the function
> return immediately because it knows that it’s insufficient.)
>
> Max

ok, removing the loop sounds reasonable.
My only concern is that *must* in the doc.
Could ZSTD-lib change the logic in the future relying on the fact
that they make users use ZSTD_compressStream() in a loop.
Honestly, I can't imagine the case when they would want to do that,
but still.
Without the loop we're protected even in this case. The worst thing
could happen because of that is qcow2_zstd_compress() would return
with -EIO more frequently.

So, if I understand correctly, you are ok with removing the loop.

Denis
>


