Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A801E206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n01Fm+6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A801E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTk6B-0003lY-T1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTk5Z-00039h-6Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTk5Y-0002F6-Pe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:37:13 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com
 ([40.107.1.101]:44618 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTk5V-0002E1-Do; Wed, 29 Apr 2020 06:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLVRIpmCp2iGiOh9Jzs/DZWPV4g45C93afhtGI29DXZNOVvqvZ0F+vzmqs+WephpldFtE0ykjgS26ZrRwC1Hv7Eyp4UdvHk3xXHS9qPcsM+MSLx92d82GybUp4FjJJ7msWMw8gVywEZ23PV29oEenRiE6mTbROjKDKdeIgMQkd1Ygj2sF+t0MnW4+R3Qo9YRS+KK15hP3B0xJ9EfXIRv9+RIm9DywvdAY6pHr3t/TBz0sGIIRg3aat9tITFQPubIDq/Mt57P3/KzjCKjzo44PtfkblO/Rf3p6rpacZAp2VzH/QpJ0KkFhMZWyrGC4A9LS3eZ2WNiohR/OZ8Le1xM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1ySPxGlEpS1NFPJ7Cr5gChlstM7jmXznfg6y5y/dzU=;
 b=GFjanHsNV7Vx2u6x4+/P9oVR/+/lFEr18eurK7W2iDZlBMWTjvHkKr9gXmi/ntpyxma8HOgmpf3Gi84cO3ArAQma/l6XkOJu9dSWqqpbjeIpkymHiychLodB7zZ5ZKop+Gx3vjOqEkc/pvsA3fGIpVSP+IOMRnYiCFA7h3KtDMZADW8Eu2E57SNH+v/pKfUJoqzXk56Zg+rYsB4KjtZQ3WjjCkCg6qcD09m8jTwHXgBUt1AuauNRs/ZRCRmpP9gi8iPnLNc84B61X1gSwm2aCG4IscwE71liHCDm6nHIFee4r537od35ztI+GwXemVA9gGWHlkBUUHl8kZyW1cHENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1ySPxGlEpS1NFPJ7Cr5gChlstM7jmXznfg6y5y/dzU=;
 b=n01Fm+6ANrsTHGOpqxEIAR25fHFUWK4RCi7EVl3xAKvsqPq3x+GAyHtRvfsi0KKDn1mYw6IDf3oHddGRGvWFOmJCBxfLhxuKL7aY9dhTV16tB9K6RaE8rSerpy52ReXkDtDpFkL3oS5PmjqMMjqv49SnarKrxEuNh7oXqM4HI90=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 10:37:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 10:37:06 +0000
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429133704435
Message-ID: <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
Date: Wed, 29 Apr 2020 13:37:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0131.eurprd05.prod.outlook.com
 (2603:10a6:207:2::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM3PR05CA0131.eurprd05.prod.outlook.com (2603:10a6:207:2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 10:37:05 +0000
X-Tagtoolbar-Keys: D20200429133704435
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb78c06-5e41-445b-8d4d-08d7ec294302
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5479EAEAA747A1073C0724C7C1AD0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(376002)(396003)(136003)(366004)(31686004)(31696002)(6486002)(4326008)(956004)(53546011)(478600001)(2616005)(86362001)(8676002)(26005)(8936002)(110136005)(66946007)(66556008)(16526019)(5660300002)(66476007)(2906002)(36756003)(316002)(16576012)(52116002)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/x9tY7RiXcsWc+jKEjQLbwAPYPMVf28xCtZTLqeP3TLooxPUNTkcDfYWXitQo7d+67HBlaV9WxmCiRzlyBDs0YADTmC6gYDLgduwwdUms6EuolWIsGtiLiJoxvFSs6uOaXJVfCfIa3zpR61CXv1Dmim3YoleOchWdSrq2HiARs+RLYzm/qgq0YyNQurEiaoLZVYdZhHvJnvV4NxFA7jA2ExVQYJcfYB48Q+YY1Lvz8HLO4GbQzrrdJd2NFg9lvQFT01xOQ6ixvMJN0IJpemNNWTx8XY/URw28g/OYEpTVUsi9N9gjFPijt5iDoZc88pbYoPycnJucq9ktd2HqGfW7aFHhM8+VIsso67tGtdFO2F/mkgJJOLk1t282nS8+QLxktXa8/dZkzYfs7mP+AZDho67gkf3wwGeS/+5y7kQ7p3hdwKdrXu+i67wjqDs5jc
X-MS-Exchange-AntiSpam-MessageData: MZEZrnn9bla67vlhVif8v3dU5CoqKYs1h9jvg2dvJ/pubYm5CxKCvQqzELmnpd4EUxpT3i6xrc8BsBvjZZeK4jD8arQFI0X7A5InYBDOJ/ANatxcSx/Ox4XDsT8BWO95tD2b74jAAIYhqe8IPoVNVeHrG9OvHEHjR90/fdt8cQyv42iCeYdTdn1t1u69I7MBv3lgiSVr1W7zTcQkgjqyaE7e/IXASmr0G+pHeqWiqpwj/5sl37A23t/s8XNnKxLSut/K+V5pdAW6fYn2RtoP0fatqlnA/WAwQTskgfguq09J1KkTiIxubnd5lks7OBTcozfvhZflglJnvHl5KbsdswZVaNpwtSbYLCPmR0mYGaKZLt1ERUqZJG11gw/GuvYwn3DxqDymRiyacBug8R84+3I/6kD9Goyz7lY/1AJj24bQ6Sj7ICRN1rbhZsHiSLW/LWTg7JXtkKBrh0efErQYKIlzizSKZ1+z4RIgtBes6QTDPhR9v5B1DoVOw0NLnFnx8nbohf2hQhOvomRXz3qb+ZqfnxOVXdKj/MK4B88i5hUGYgOS2eWaU7oEJLMY8hSnX5SWLrkxaK8W/eZzfUFic76fcw3ITfnmxzd6+1xiSo0ObA2zqM1dV+DLjB9fpxFyy7cw7y5EcmKTthHYj1RiyFtIswQIcMmuhRXFBEPFrkw1aqyR9CPw7nWKP8qkjxRMotD+0cENnrOR2iRk0c8hzzhcZmc1pczg3vpmxzdnn05O6qv37e9/unm5tS7kXzcHTyiH5yFhSXEmJYfGmSGbQRv9MW5jldoa8L4XcDeGvoQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb78c06-5e41-445b-8d4d-08d7ec294302
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 10:37:05.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVeNbnD+wGcqStUvlLocQ3YXYMz7g+LaZhAxCAsGyVZ21JoDl7GpX7eZLoB85ZioZHY+GlHb6zgedlHqe1VoArVeVNcrvUS8RMSOa6JgPHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.1.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 06:37:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.1.101
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

29.04.2020 13:24, Max Reitz wrote:
> On 28.04.20 22:00, Denis Plotnikov wrote:
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
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/interop/qcow2.txt |   1 +
>>   configure              |   2 +-
>>   qapi/block-core.json   |   3 +-
>>   block/qcow2-threads.c  | 169 +++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c          |   7 ++
>>   slirp                  |   2 +-
>>   6 files changed, 181 insertions(+), 3 deletions(-)
> 
> [...]
> 
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 7dbaf53489..a0b12e1b15 100644
>> --- a/block/qcow2-threads.c
>> +++ b/block/qcow2-threads.c
> 
> [...]
> 
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +                                     const void *src, size_t src_size)
>> +{
> 
> [...]
> 
>> +    /*
>> +     * The compressed stream from the input buffer may consist of more
>> +     * than one zstd frame.
> 
> Can it?

If not, we must require it in the specification. Hmm. If at some point we'll want multi-threaded compression of one big (2M) cluster.. Could this be implemented with zstd lib, if multiple frames are allowed, will allowing multiple frames help? I don't know actually, but I think better not to forbid it. On the other hand, I don't see any benefit in large compressed clusters. At least, in our scenarios (for compressed backups) we use 64k compressed clusters, for good granularity of incremental backups (when for running vm we use 1M clusters).



-- 
Best regards,
Vladimir

