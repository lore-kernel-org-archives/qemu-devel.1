Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1050C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C53F20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ejzz7J7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5z3-0006IW-GC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jU5oU-0005XW-Nw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jU5oT-0003dG-Of
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:49:02 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com
 ([40.107.1.99]:61837 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jU5oQ-0003cj-Ag; Thu, 30 Apr 2020 05:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD1qQDn43Jj1UqBLk6RUX/VySFOsLb3WuXef94QHoxKd1csi2qM/XeDUkJ/eees0iJw3tLUcbBaqhq7jUN5/dRXWKxSIZ+ZAGs78NplK4yoq0DOhpaw5xzTHk7PEIXAO9sDUdFld1FvD20immYbJ+FtqRCjSMmbyyUPWLCMmhXUM09R1fMs6YY57iLE6r0R6s70PSKwJ4dFiT9qmKWs3CbPqZoLG2ASx8hHWDNHOMBH0vvMbaKJE8XoVpJA/YSd01JhraXwupEvWRmBSaYHLeGh7nXnkadvNoiRA5iK7LCdRj8xOBPjYpZcdKqhfH9KauSds3iOgJubYMMjuRpIRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtfgPXGmIqnV6BkiJuWWLgLHSS2OQA3E8Uzjnndsxqc=;
 b=iNk27Q02zLUaYPp4C9EEPpoRKim4EN5reBJ9pftYfIeo+2WFpPPXNp7M1FTVkpKeLH1fDd8n2F1Z6HjTSWiQObXpcVnI9J1l6b0KfpsIZwI1RnvdvqmlyJXfdPkNTQ0dd789dYDPpkfPzJSIDtPYE79JwImUm4ICTfsgacyV21Z7KH2cpBoC7K3tFCDA9ISOws1t+vS7zIiSs7+/xcyKjgxReGaRPMuJlIfNWNx3A5Gr5Q/x6DZ/nSDXph2zTk1nw7uJo0qpiMheFnt6iezfyJChIAINbJglFB8PW8pKMsnaXssaidGurv5iXTvT5RPFF6V6HdpXGAQ45bdRV5ar8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtfgPXGmIqnV6BkiJuWWLgLHSS2OQA3E8Uzjnndsxqc=;
 b=Ejzz7J7CeVVxv+xYVHLsLX+wzj8YpVwHya7wg6+u1LU16rTyK2Z5ClRjgcaqDJZvHm/Vew3Kfdy3BzMtKOSWvLgQJzmv1kA3T+TawY4HF5ds8LS7qQso58h5AK0jHAepdXMEk9U/Za2gK5D206LU2WYy2N7DkJi+OTqjy2NlJP4=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5442.eurprd08.prod.outlook.com (2603:10a6:208:182::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 09:48:54 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 09:48:54 +0000
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
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <477e76fd-ff73-ac34-c636-c8d9ae6be30d@virtuozzo.com>
Date: Thu, 30 Apr 2020 12:48:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <73ebc101-7148-2b38-492f-538d4bf8c8a4@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 09:48:52 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5acf64af-4804-412d-c84d-08d7ecebb18d
X-MS-TrafficTypeDiagnostic: AM0PR08MB5442:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB544272A4FF8DEC78893E0627CFAA0@AM0PR08MB5442.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSNIWT7cyWy6rMmg8dOxVHd51t9WSwIaYP7U7ZG8EtpordSZB98TDwS6xw5q+kQkz4fkqePK8wnahmQ9UfC0W31JnkoNNDG8aztjUXherXpfR9beg9t85Lmsyr1Yy0r/LXQQ1TFbOXHKx77K5MqWIDrtF3Wm7n2gv4HiSYiDAemX9Bfy/GZdGxPWHy6NUYw7F6h/r3ty0pTPwrVNArmu9RtcVnF+xXeexsot+yV6MKDr3728bCsPtLthI35TwE5YxlRhOXaXoptoiuFt9gVEHS99Js/41vfueMBcx2oqjOK3vLuWb2FFwYKcfgLCtDA3wsG1/WlljEgqw9UIh08BW8lHhGC1hWLMyZgWcGtEZHpETcOefiYh1+1rPQKecAfyoht7IBIm+v9DcrCab/laYPHBWwvR9TCxlC191iNM4Whv8J63ka87Y7M7aW+FoRJE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39840400004)(376002)(5660300002)(6666004)(316002)(31696002)(8936002)(86362001)(16576012)(52116002)(66556008)(66476007)(110136005)(8676002)(66946007)(53546011)(186003)(66574012)(36756003)(6486002)(478600001)(956004)(4326008)(16526019)(26005)(31686004)(2616005)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /CRNgyJr/mXweVgEporubi3aZzubg+9xfkRj92+iwfoKFoP2pTHxDBf2y6KG+LDstF2zVlm2+EtD8AJYbar7ac/yXDPHbd1RIh77rQ8CT0/pzNPg0kXAphqEeCL1HK/9Ebo4VsAT1h+ACjwWEkrbhdc8kuK7wYT4wXJjSLNbbGNTzkDMyzKFgDMhMDp4FeNlobqnLqGqAgoOvTK1tYnFEu4VlkAozrlm6b8b04UTEhJiKoFr5m+rLzrHqYY896s5wTfHVvmNTtG/fpmOryT/+wqOQlrRwrWk4iYXcK6Wou055oA6SOog8m53QPPeCe2OzVNlqzl2ywGSRvzkHizAdNAkaco0gTgCLrnEORkkcnj4nww82J8Un0GhHitHfDh/wFiWpf9uRmta+K+Bq1SPSg643qA6GoWr9uM82+RBxRJ++UgRVMqQVck0rnmg/jjP+42TESlWgXyW+/ZfiBddblXAQrGhRfGu2V36uyJOROY04QcZe9kTfUtH3ZnzOcG23490AOrZUdzA3DKeqsdBvejWVAyupn+jTXbjUr/HTMU6J5DdqgQYtoZU3AiRu1aMM78L6+XBY8meiRwuTubuUa7h+QSjbexNQiyFPdV+WHjVE3/cmVycZghYgP3owusLF5GjfDBuzwGjB+tYPZkamoZMqaSlJZx6BA1IehMt/HnWQi41/q8SOcODN5VEI/bcLF9hFlCO0GUTBYzw6sIxhk0rOwg6db90ePBhtzFqVFK5WsjODXU2OKDScqXs3PA6soRqv/XBW/OS1IHTb0/gfuy/Kd2aLI14yv4rh+lHWwM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acf64af-4804-412d-c84d-08d7ecebb18d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:48:53.9371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uifjRAGSg1oe9IXxH2Vxbcgt2e+mWvxoCOLOaO19wtpxk6vmYK2OUq9iUI5x4DfWBmcfDoYOtOzBZMFX+ffVQmWwrheTJWF7bPQ1ieyRo1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5442
Received-SPF: pass client-ip=40.107.1.99;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 05:48:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.1.99
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



On 30.04.2020 11:26, Max Reitz wrote:
> On 29.04.20 15:02, Vladimir Sementsov-Ogievskiy wrote:
>> 29.04.2020 15:17, Max Reitz wrote:
>>> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>>>> 29.04.2020 13:24, Max Reitz wrote:
>>>>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>>>>> zstd significantly reduces cluster compression time.
>>>>>> It provides better compression performance maintaining
>>>>>> the same level of the compression ratio in comparison with
>>>>>> zlib, which, at the moment, is the only compression
>>>>>> method available.
>>>>>>
>>>>>> The performance test results:
>>>>>> Test compresses and decompresses qemu qcow2 image with just
>>>>>> installed rhel-7.6 guest.
>>>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>>>
>>>>>> The test was conducted with brd disk to reduce the influence
>>>>>> of disk subsystem to the test results.
>>>>>> The results is given in seconds.
>>>>>>
>>>>>> compress cmd:
>>>>>>      time ./qemu-img convert -O qcow2 -c -o
>>>>>> compression_type=[zlib|zstd]
>>>>>>                      src.img [zlib|zstd]_compressed.img
>>>>>> decompress cmd
>>>>>>      time ./qemu-img convert -O qcow2
>>>>>>                      [zlib|zstd]_compressed.img uncompressed.img
>>>>>>
>>>>>>               compression               decompression
>>>>>>             zlib       zstd           zlib         zstd
>>>>>> ------------------------------------------------------------
>>>>>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>>>>>> user     65.0       15.8            5.3          2.5
>>>>>> sys       3.3        0.2            2.0          2.0
>>>>>>
>>>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>>>> compressed image size in both cases: 1.4G
>>>>>>
>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>> QAPI part:
>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>> ---
>>>>>>     docs/interop/qcow2.txt |   1 +
>>>>>>     configure              |   2 +-
>>>>>>     qapi/block-core.json   |   3 +-
>>>>>>     block/qcow2-threads.c  | 169
>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>     block/qcow2.c          |   7 ++
>>>>>>     slirp                  |   2 +-
>>>>>>     6 files changed, 181 insertions(+), 3 deletions(-)
>>>>> [...]
>>>>>
>>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>>> index 7dbaf53489..a0b12e1b15 100644
>>>>>> --- a/block/qcow2-threads.c
>>>>>> +++ b/block/qcow2-threads.c
>>>>> [...]
>>>>>
>>>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>>>> +                                     const void *src, size_t
>>>>>> src_size)
>>>>>> +{
>>>>> [...]
>>>>>
>>>>>> +    /*
>>>>>> +     * The compressed stream from the input buffer may consist of
>>>>>> more
>>>>>> +     * than one zstd frame.
>>>>> Can it?
>>>> If not, we must require it in the specification.
>>> Actually, now that you mention it, it would make sense anyway to add
>>> some note to the specification on what exactly compressed with zstd
>>> means.
>>>
>>>> Hmm. If at some point
>>>> we'll want multi-threaded compression of one big (2M) cluster.. Could
>>>> this be implemented with zstd lib, if multiple frames are allowed, will
>>>> allowing multiple frames help? I don't know actually, but I think better
>>>> not to forbid it. On the other hand, I don't see any benefit in large
>>>> compressed clusters. At least, in our scenarios (for compressed backups)
>>>> we use 64k compressed clusters, for good granularity of incremental
>>>> backups (when for running vm we use 1M clusters).
>>> Is it really that important?  Naïvely, it sounds rather complicated to
>>> introduce multithreading into block drivers.
>> It is already here: compression and encryption already multithreaded.
>> But of course, one cluster is handled in one thread.
> Ah, good.  I forgot.
>
>>> (Also, as for compression, it can only be used in backup scenarios
>>> anyway, where you write many clusters at once.  So parallelism on the
>>> cluster level should sufficient to get high usage, and it would benefit
>>> all compression types and cluster sizes.)
>>>
>> Yes it works in this way already :)
> Well, OK then.
>
>> So, we don't know do we want one frame restriction or not. Do you have a
>> preference?
> *shrug*
>
> Seems like it would be preferential to allow multiple frames still.  A
> note in the spec would be nice (i.e., streaming format, multiple frames
> per cluster possible).

We don't mention anything about zlib compressing details in the spec.

If we mention anything about ZSTD compressing details we'll have to do 
it for
zlib as well. So, I think we have two possibilities for the spec:
1. mention for both
2. don't mention at all

I think the 2nd is better. It gives more degree of freedom for the 
future improvements.
and we've already covered both cases (one frame, may frames) in the code.
I'm note sure I'm right. Any other opinions?

Denis
>
> Max
>


