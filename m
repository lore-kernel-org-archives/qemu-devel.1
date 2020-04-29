Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F9C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B0621775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VZGSVozT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B0621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmRf-0004b9-Q4
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmQJ-00036O-Hh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmPc-0003ks-JN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:06:47 -0400
Received: from mail-eopbgr40091.outbound.protection.outlook.com
 ([40.107.4.91]:45023 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmMR-0001t8-Df; Wed, 29 Apr 2020 09:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy5OZNG02qcynFcXCvhsTg7V7PA+BtkI6yqk+KKp0feVVRrqjH/Or9crQcU5+Jrk295ola3668GBLnOS1kngE3LO5fxUVmyht2sB+EPsfeJELsHCk7AT649Wx5PLn//tciIKimTCv6jZWliMz1wfT/JXfVe4tHru+L8WYClPrnL0b7aGd8Q1AUH0VaBWegfdNVVcYmdm+d3vHyiC14VMokqPFoxAG7qTPxyuZq5mfh7u6i5a0eN7B1ufZESCh8U0rbQPeLSSMEC08knV+RFbZfiohSs1rnhDITaXV3sDA8dQHukemQRAXpiRfjDITtHrtP+ZWipJ0aT3GQBUQNXE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELnOI1xoUvac9LsWpskTFUqmN7RXfv5AF5690P3kAy8=;
 b=EAA9ZS15r/JGfUNx6WvTtaayKXbfb8ZPm7yHoBvnsit6ayS89NkGp8uxrbPc6XdvOtVG93Y7qg9J9L3QCk8a/LvZELP9cFcgv7b30mP7sbqg2wfZms2xKbP+l/2Tl+8OLE4gCZ2zs8v0hyhwwMsZcxNmLymMxcbQg2X36ayz/rO8JYqUjV8vLLRwYNjhlii4mvllgY1aAn/yax477bUcO6G7q1y/x3fyE5ULSeJMcmtZUUtcLT0uc9Lh9su1b1mKw9hnV7VxYI2iIdFFwAIW6roUbSUBf7qH5Y2uy6EV5UlEQYsf+CXbUffT/uYuhlv9fVY2iwwPfwINKG/z/mLFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELnOI1xoUvac9LsWpskTFUqmN7RXfv5AF5690P3kAy8=;
 b=VZGSVozTl1nu+vjp9SOH/rgQBCwe/pX5SC2xLDqpqwXile6iGLWzS08V5Fnn2hu+WrB8FmvyXNnZRUGzbNzTgF4ZAIXy1tjgbRvJyr+kgCmaLZZP0go7FEXVL0AhhXcIr0k8UOhhIg8V+W7MxOPLF1tHmcifklrn2y+EvmU6sX0=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:02:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:02:44 +0000
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
 <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429160242570
Message-ID: <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
Date: Wed, 29 Apr 2020 16:02:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 13:02:43 +0000
X-Tagtoolbar-Keys: D20200429160242570
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02415450-458b-4e48-695b-08d7ec3d9b7d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54466174678C59836A25EA70C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(16576012)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(53546011)(26005)(4326008)(956004)(110136005)(66574012)(478600001)(31686004)(86362001)(2906002)(31696002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vf3cTeD8Lkz6xsBhKKSD4wKGFf1/L41wHL/ey+Ti1JSxFE/lsCdzusgw2qmySqBG+FGR05bLB8XLX1PYQrjaFHN9/KZeN+J39i8nt1tM7k9Nw1lXTRdy0qEICADG9jX3Xzve+Xq6nn5sMYBD+d50uZORWe34mJpV92DZlOUa+DKwJraNqICrpmid6VbZbqFqgKTLaK2S4Rx8b6GYyT9rWs0XzE5jBfhI3hTkDVLthZ+BQuqAd9eVkFHlAJRRzxif37i1Qylr182edu+sNKlOWWnziIBW1SzLSubwIhgzshazoAR7+/Bkvz02xfTUrtaErhjwlx8WbOcaqHDkSKXok15/0AySXB79TROhbcBXe8qG7d12wogchGE8teSISXg0eefaRbvTyRAG96so4W3J07VkRTPmNzHMEj7MgtIkQIZE1cWTGe7KOq64fXppxPu
X-MS-Exchange-AntiSpam-MessageData: COxrZC/2zLxcdcNDznAQ1oDek+1kQrxeFsM8jBMqiLf2mnfKYVBm924epbW87qKuyOke9grNhbxynewia6EmU4X5KjQKx+NXolqaYag5Zc5SYZYwTa2nqqJ3HPnl7E8ub4QMIVnDnIl3SrYQDBHobMJuxK/yGtd+/nqyE+BhDZlp7owIda8V/E7R2X0sSj89cecp4eAC0GpVBjKCaklRfgE3sWckj5yLJ2zGotzYtROLJOQW/bkj/SpOqJs/W/uAHZlXY3Tt9p+Tl7c+tp8GyAIr4xe+RA+c3f7JJVx3l3chOQWCkM3vKIErQzo5QhJ0NNh3v0CE1ZGHXUUAG4JOaoUyrJcsgPZ6Mmlp7v1NciYL0gRRKqLyFihG5KZqMbZQWK0h5E3NrH0XIc2XreS+tGfsbIXcNTR8/ROyarYI81cz0qatdt4kbxr5xCIqOj8ioveDct0I364tcxH3Z+SDVta1AfP3etmH8FFmWMHOfP4pwGhpy986vbyDym473O/U10gIHww4y664PFL5FwEXzgzWSopkeIdj+U+nnzIZwIrwCtbOHd5AgO7e0Fc90b+/wl9lDMztuvLM7nc4aGhYGjIjPTN4+MXnkbBAvdTMyL4ByKEb1a8xxCMkQjGCIdZyvlhhzsmz5oxqFw2c24Jr0wQnj7DWtmO1qIFrr0Soikjh7N2odmpc1ZSvsbwoffO5Yj/xWMj7xABAnfiS2qUGr5qFBdY4gkjcVQnAeLI4oA9+/PaQ2EuFgmdgNrwmgLJ6SLl2VpRnrnj3i+en8/0JwNPeUUtxfsxtSrFJ2fC9GtY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02415450-458b-4e48-695b-08d7ec3d9b7d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:02:44.3555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQlhlNHQmbDZgQWUzzC55Ls8ptjDhKbbXjJHkmYsl/Fz3DnqpNdc3h8zqS0U3yfG3nAWtnCAGBEWBSYESJuwguKB1e3iTgQsnI6TqYm7tSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.4.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 09:02:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.91
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

29.04.2020 15:17, Max Reitz wrote:
> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>> 29.04.2020 13:24, Max Reitz wrote:
>>> On 28.04.20 22:00, Denis Plotnikov wrote:
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
>>>> QAPI part:
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    docs/interop/qcow2.txt |   1 +
>>>>    configure              |   2 +-
>>>>    qapi/block-core.json   |   3 +-
>>>>    block/qcow2-threads.c  | 169 +++++++++++++++++++++++++++++++++++++++++
>>>>    block/qcow2.c          |   7 ++
>>>>    slirp                  |   2 +-
>>>>    6 files changed, 181 insertions(+), 3 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>> index 7dbaf53489..a0b12e1b15 100644
>>>> --- a/block/qcow2-threads.c
>>>> +++ b/block/qcow2-threads.c
>>>
>>> [...]
>>>
>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>> +                                     const void *src, size_t src_size)
>>>> +{
>>>
>>> [...]
>>>
>>>> +    /*
>>>> +     * The compressed stream from the input buffer may consist of more
>>>> +     * than one zstd frame.
>>>
>>> Can it?
>>
>> If not, we must require it in the specification.
> 
> Actually, now that you mention it, it would make sense anyway to add
> some note to the specification on what exactly compressed with zstd means.
> 
>> Hmm. If at some point
>> we'll want multi-threaded compression of one big (2M) cluster.. Could
>> this be implemented with zstd lib, if multiple frames are allowed, will
>> allowing multiple frames help? I don't know actually, but I think better
>> not to forbid it. On the other hand, I don't see any benefit in large
>> compressed clusters. At least, in our scenarios (for compressed backups)
>> we use 64k compressed clusters, for good granularity of incremental
>> backups (when for running vm we use 1M clusters).
> 
> Is it really that important?  Naïvely, it sounds rather complicated to
> introduce multithreading into block drivers.

It is already here: compression and encryption already multithreaded.
But of course, one cluster is handled in one thread.

> 
> (Also, as for compression, it can only be used in backup scenarios
> anyway, where you write many clusters at once.  So parallelism on the
> cluster level should sufficient to get high usage, and it would benefit
> all compression types and cluster sizes.)
> 

Yes it works in this way already :)

===

So, we don't know do we want one frame restriction or not. Do you have a preference?

-- 
Best regards,
Vladimir

