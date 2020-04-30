Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01245C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F0E2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gg099Zxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9vE-0003Gp-Ql
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jU9gf-0008Cv-Io
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jU9gd-00006a-4n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:57:13 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com
 ([40.107.7.103]:10127 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jU9fz-0007wr-AG; Thu, 30 Apr 2020 09:56:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9WqzH7SY0oX6GT2GPMdk7zECGKwGxBUjDG33eIjHP0oZYzqNMIZoVdSK6Olq4Kotbxv6EpX/XgyUlL2bYZ+LDCO8ze7GX+IH6fdVB0V6V89/skb1e6E1MucDLM+AdQ9PcJW9V8E0SdpaWlF1pw36vZibty+JRHVTQEHRk4aUkm/sSGY1vKMiujwA6fut9uHH3ImV5tOml5+ene4AFZlpZfetqW0lo8uaoI51QqM76iJ6g95m1wF2s6IVnA+6jg36DY1GlxU6TTcX4GGAS7mR4QFrEz5YW2F1xpD6/Mm/MrK2FaqGUttiE6lBYJlb5K1BW5rOC36YQPBVGUKZhkxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH5DoVla1I0qZChYY91i/M6LjjIO9KcTsCDpAeL2BSA=;
 b=OK/eJK7O+6ZdBr5rZK4K+yo9Xm+L6gPIOCfle052D1X1WJa43vKPNtorJwnrJ0QnVXg0NAMs7bqKsvBU/uemCLQmX6yLwY2zC+8fHMzKXVUAhAc4Yijc4dqLZ4iz0agXZLxRADzJ7oqeuyMwwJMNxLM9u/M6tuZ+QI+ICK7vKoVozg9d8hrqXbDBdH5YSOiWfDj0RQ2TFN0LLs1q8NQ/nP7mqV+enbPlPa1GXvB3+70QTzRvEofO5Cep1N2wDHLBvUPrRGjdzPkuXfOQejLfberY/efwIvNnb3rWb5bhRnlzA4lctTU74SCLYuk42099BfPNHdlrvkuAYdoBH3yDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH5DoVla1I0qZChYY91i/M6LjjIO9KcTsCDpAeL2BSA=;
 b=Gg099Zxy5/RTgi316nbmlXglsjqlBGygAtgf5kyOidlsHWS0U5z/YCUwBiH2/cMo31De7UvZPVvCSFdMsaL8sFnwSUtDVh3pRigu/0qo3Ug6Kakd+d4SHDblFRieSNngnRKwS0IeYoWRStK2Rvkq9zpjayGgz+578TZ2thiwy0Q=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4370.eurprd08.prod.outlook.com (2603:10a6:208:148::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 13:56:26 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 13:56:26 +0000
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
 <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
 <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
 <73ebc101-7148-2b38-492f-538d4bf8c8a4@redhat.com>
 <477e76fd-ff73-ac34-c636-c8d9ae6be30d@virtuozzo.com>
 <22b2918b-3bdd-6627-a378-baddb342dacc@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <7444cb5f-acda-6354-ea9f-81e998185f0f@virtuozzo.com>
Date: Thu, 30 Apr 2020 16:56:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <22b2918b-3bdd-6627-a378-baddb342dacc@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 13:56:25 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5519bb13-43d2-444a-f55f-08d7ed0e4671
X-MS-TrafficTypeDiagnostic: AM0PR08MB4370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4370AEEB3878F351D7FBE2F9CFAA0@AM0PR08MB4370.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcPdqWx7ZdPoOpqFdE2pMGC7u0Cay+ruXWUGsvAxOEAaTYaN8KkUs+b+cQqlnWR/cvMolOsR+5+Kv5z0hUHmDtQLavWgtap9jtw51sHXeVQe+wbtYA6p/dmSnm9uDM+YSNs2fJAjSsYCH3UZ6r1ScZOD+Dh0PPMXazvL2XaMd8zmuMzuNqGncWi2inCskSfgyPr8775sYD8dGp+FFElNID5ivZ/tN+9npiQu2gBed/6f/ndIJ4yFwRDUhWlcgkwpqOfqLA9OTpT9UAAgw6K9DlEKESZ8vUX0JLuyzbUPW3+BkuJ2pxIqiY/2ym+4ovOHXJuqC7sSg2sYNSIAMybx2J/Rj1GDeNNJCkfAGC7FtCDniDxOecV2PuVd7+QwqVPjP/TOAqpESyREOceLF/E3WfQGP2M83tGxFPXJ6D1iq77UcVmbffjJxPEdISxObVB4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(31696002)(66556008)(31686004)(86362001)(66476007)(4326008)(8676002)(66946007)(66574012)(53546011)(2906002)(36756003)(186003)(52116002)(5660300002)(16526019)(478600001)(26005)(6486002)(110136005)(16576012)(316002)(8936002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IYzox/antm3Q7wM0lQOpPFLVCSZ2aKiZdTCIy5JRFCRpIKJGPzCmKWPAWgi0wT51wx0EMew+1VvH7VZrcvUiC6QQLfEb/KXOwUB/x+Vt4Plo3AM1kjdTcPwMvYqIHjabRQmKWhm8NS3XyZrosXE23DuKmlquFUdO5UpSaR683xhuMdWitChrM9TWSYpe8N2O/bMQ+QwUa8DKuOnHFNuSIroF946MeG21f/ldkqA+xffYIjuPN+cVCqMkuUjexzl2cOTsz0Y7NsOCqBJ9X2v8M3Bx7YcTML22lS+4faHmD+g79RmWAv1qPXtUFaDVv60ncNO7abPJWJxOjgL4HlLP9gMRwaygSylz0z+0UUCFzeP1zhZVfYCH/XAamjX3rO/Wv5F4l6+DHCUdKAA/7cJ4IcSA/JXz2M0OyFqrFLyYg7FzoGuadautXGUl6IV2/FdMIx07OMrc1nBW4qjlMP/yyNbFd5irUIBGvxdgylsjQCf5R7ib98L+BImMGSsq6acd0Rz5dJ32RQ/gSA4sk7pkLGvuMuEspsgFUCtgPBcQKMXOFb5LDdJ3BjvQzpm8Ny0m2K8vz9fbimy10UM1jQaRiHW7Q4uyoCx4OMb4zGSMoR8IZ4IlmMxPf6xCJfZ6ASzLKmQi/sNQk7JM6LHIcqXGvcEdPBULx75ffSo5gTG0s+tHw8DJcsbhgCS4QwaezwX9dF5MJg8F3TXZRahJhSwOCOrdYyNzGFYWHwWQd9PZkrlYe2JxIKz23VEReF6wgxB5B5RHkGKA6omQJWWc/LUmhKH5GtJVACxkdofEMz0Q79I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519bb13-43d2-444a-f55f-08d7ed0e4671
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 13:56:26.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxVUeti7yYb2pz5+irowfkbTWG+0wjT9mnyn7VA6nzKlofwm0h/eKe9NOzzM46ldR7I6i+n2+4PwFbWZTPJq2eQSsXibZtZc+Dv/dcrgh0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4370
Received-SPF: pass client-ip=40.107.7.103;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:56:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.103
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
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30.04.2020 14:47, Max Reitz wrote:
> On 30.04.20 11:48, Denis Plotnikov wrote:
>>
>> On 30.04.2020 11:26, Max Reitz wrote:
>>> On 29.04.20 15:02, Vladimir Sementsov-Ogievskiy wrote:
>>>> 29.04.2020 15:17, Max Reitz wrote:
>>>>> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 29.04.2020 13:24, Max Reitz wrote:
>>>>>>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>>>>>>> zstd significantly reduces cluster compression time.
>>>>>>>> It provides better compression performance maintaining
>>>>>>>> the same level of the compression ratio in comparison with
>>>>>>>> zlib, which, at the moment, is the only compression
>>>>>>>> method available.
>>>>>>>>
>>>>>>>> The performance test results:
>>>>>>>> Test compresses and decompresses qemu qcow2 image with just
>>>>>>>> installed rhel-7.6 guest.
>>>>>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>>>>>
>>>>>>>> The test was conducted with brd disk to reduce the influence
>>>>>>>> of disk subsystem to the test results.
>>>>>>>> The results is given in seconds.
>>>>>>>>
>>>>>>>> compress cmd:
>>>>>>>>       time ./qemu-img convert -O qcow2 -c -o
>>>>>>>> compression_type=[zlib|zstd]
>>>>>>>>                       src.img [zlib|zstd]_compressed.img
>>>>>>>> decompress cmd
>>>>>>>>       time ./qemu-img convert -O qcow2
>>>>>>>>                       [zlib|zstd]_compressed.img uncompressed.img
>>>>>>>>
>>>>>>>>                compression               decompression
>>>>>>>>              zlib       zstd           zlib         zstd
>>>>>>>> ------------------------------------------------------------
>>>>>>>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>>>>>>>> user     65.0       15.8            5.3          2.5
>>>>>>>> sys       3.3        0.2            2.0          2.0
>>>>>>>>
>>>>>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>>>>>> compressed image size in both cases: 1.4G
>>>>>>>>
>>>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>>>> QAPI part:
>>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>>> ---
>>>>>>>>      docs/interop/qcow2.txt |   1 +
>>>>>>>>      configure              |   2 +-
>>>>>>>>      qapi/block-core.json   |   3 +-
>>>>>>>>      block/qcow2-threads.c  | 169
>>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>      block/qcow2.c          |   7 ++
>>>>>>>>      slirp                  |   2 +-
>>>>>>>>      6 files changed, 181 insertions(+), 3 deletions(-)
>>>>>>> [...]
>>>>>>>
>>>>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>>>>> index 7dbaf53489..a0b12e1b15 100644
>>>>>>>> --- a/block/qcow2-threads.c
>>>>>>>> +++ b/block/qcow2-threads.c
>>>>>>> [...]
>>>>>>>
>>>>>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>>>>>> +                                     const void *src, size_t
>>>>>>>> src_size)
>>>>>>>> +{
>>>>>>> [...]
>>>>>>>
>>>>>>>> +    /*
>>>>>>>> +     * The compressed stream from the input buffer may consist of
>>>>>>>> more
>>>>>>>> +     * than one zstd frame.
>>>>>>> Can it?
>>>>>> If not, we must require it in the specification.
>>>>> Actually, now that you mention it, it would make sense anyway to add
>>>>> some note to the specification on what exactly compressed with zstd
>>>>> means.
>>>>>
>>>>>> Hmm. If at some point
>>>>>> we'll want multi-threaded compression of one big (2M) cluster.. Could
>>>>>> this be implemented with zstd lib, if multiple frames are allowed,
>>>>>> will
>>>>>> allowing multiple frames help? I don't know actually, but I think
>>>>>> better
>>>>>> not to forbid it. On the other hand, I don't see any benefit in large
>>>>>> compressed clusters. At least, in our scenarios (for compressed
>>>>>> backups)
>>>>>> we use 64k compressed clusters, for good granularity of incremental
>>>>>> backups (when for running vm we use 1M clusters).
>>>>> Is it really that important?  Naïvely, it sounds rather complicated to
>>>>> introduce multithreading into block drivers.
>>>> It is already here: compression and encryption already multithreaded.
>>>> But of course, one cluster is handled in one thread.
>>> Ah, good.  I forgot.
>>>
>>>>> (Also, as for compression, it can only be used in backup scenarios
>>>>> anyway, where you write many clusters at once.  So parallelism on the
>>>>> cluster level should sufficient to get high usage, and it would benefit
>>>>> all compression types and cluster sizes.)
>>>>>
>>>> Yes it works in this way already :)
>>> Well, OK then.
>>>
>>>> So, we don't know do we want one frame restriction or not. Do you have a
>>>> preference?
>>> *shrug*
>>>
>>> Seems like it would be preferential to allow multiple frames still.  A
>>> note in the spec would be nice (i.e., streaming format, multiple frames
>>> per cluster possible).
>> We don't mention anything about zlib compressing details in the spec.
> Yep.  Which is bad enough.
>
>> If we mention anything about ZSTD compressing details we'll have to do
>> it for
>> zlib as well.
> I personally don’t like “If you can’t make it perfect, you shouldn’t do
> it at all”.  Mentioning it for zstd would still be an improvement.

Good approach. I like it. But I'm trying to be cautious.
>
> Also, I believe that “zlib compression” is pretty much unambiguous,
> considering all the code does is call deflate()/inflate().
>
> I’m not saying we need to amend the spec in this series, but I don’t see
> a good argument against doing so at some point.
>
>> So, I think we have two possibilities for the spec:
>> 1. mention for both
>> 2. don't mention at all
>>
>> I think the 2nd is better. It gives more degree of freedom for the
>> future improvements.
> No, it absolutely doesn’t.  There is a de-facto format, namely what qemu
> accepts.  Changing that would be an incompatible change.  Just because
> we don’t write what’s allowed into the spec doesn’t change that fact.
>
>> and we've already covered both cases (one frame, may frames) in the code.
> There are still different zstd formats, namely streaming or not
> streaming.  That’s what should be mentioned.

It looks like the ZSTD format is always the same.
The ZSTD interface is different: for some reason the simple 
zstd_decompress()
wants to know the size of data to decompress

 From zstd doc:
*size_t ZSTD_decompress( void* dst, size_t dstCapacity, const void* src, 
size_t compressedSize); *

`compressedSize` : must be the _exact_ size of some number of compressed 
and/or skippable frames.

I made a test (based on Vladimir's code) to check it:

// compile with gcc -lzstd -g test_zstd.c -o test_zstd

#include <stdio.h> #include <assert.h> #include <zstd.h> #include 
<zstd_errors.h> int main() { char buf1[] = "erbebewbwe"; char buf2[100]; 
char buf3[100]; int ret; ZSTD_outBuffer output; ZSTD_inBuffer input; ret 
= ZSTD_compress(buf2, sizeof(buf2), buf1, sizeof(buf1), 5); printf("ret: 
%d\n", ret); ZSTD_DCtx *dctx = ZSTD_createDCtx(); input = 
(ZSTD_inBuffer){buf2, ret, 0}; output = (ZSTD_outBuffer){buf3, 
sizeof(buf3), 0}; ret = ZSTD_decompressStream(dctx, &output, &input); 
printf("ret: %d, input.pos: %ld, output.pos: %ld\n", ret, input.pos, 
output.pos); printf("To compress: %s\n", buf1); buf3[output.pos] = 0; 
printf("Uncompressed: %s\n", buf3); return 0; }

And it works fine.

We use streaming semantics just to be consistent with the interfaces 
(stream_compress/stream_decompress), otherwise

we could use simple_compress/stream_decompress

Denis
>
> Max
>


