Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CBD2237B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mLwusTql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CBD2237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVKzl-0001oJ-FW
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVKxp-00013N-MV; Wed, 21 Oct 2020 16:44:06 -0400
Received: from mail-am6eur05on2131.outbound.protection.outlook.com
 ([40.107.22.131]:42689 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVKxh-0005Dk-W5; Wed, 21 Oct 2020 16:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cznr6fUeuAwOmJig2gXwkYMCSDK5iXp1s6eN9Xsr4DVBsljCBwfeYEPjX9TaYKKMj1Vdl8Qt94/cDRvCUaj9fgwoTMdHbuEAa5mcTigcLRt211r8oDPTRI0ZPPVc4OgUziJ3FMScCaS5Lp4o7bhdZuKIhkq9DOnoYN4XqJMlOPRmwx7dM9GgxIt7Agx7wQmzJnyX1dYgP10xhHE6DKumO1NXlruZ46mgOnYWFHL3BOomfEl9+IUztHcQGnKp0CoDbsvIsoCFp7aRC9HEjSNl3m8366LSLUttUHRsXOcx/xyQPGPLXYc81vz18Ef+2WogsTJpsSLRKwjOwDkX+U4QgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5q7X2M6HZTc94jc/11zbzYbX/qopeZBXxQyP46iEGM=;
 b=GZzpistBibkgk3M8vYx9FHb9379h4ng4PyVLuQkbP57XlLAVBOy3HY56qf9nBWI/Pc7qCE9c56GQYGZQcTrnFtyWYq3auZ8mBmIZQvDqK01Q6qYotBS7sHG9S1xI8xvqDwfZ5Jys1D+j7PEV0goPKvL5y+yUqDvyaHjN1xSsItIJwqxfyVb3md10E62qVvJOEw3U+OOhOUUv9b8QbbAMFBX5+9EQbs2q4FdHC/WguVMxzgU5qk9tVSrM0LNi8EQnLyMZFo9QT2+oWWgvRM8TikUZl0fSN60XamVsu+/1RJi1ADGqx64wFNkwGzuzn5IPyNx2CLapm0B3wsVZrTJ0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5q7X2M6HZTc94jc/11zbzYbX/qopeZBXxQyP46iEGM=;
 b=mLwusTqlezW1DXpbFMfykChmPFjETN8T+vFURvKyBMvXT8+xneIKneq7XMgtb0dCoaGicE5l7BNmwY7xT6aSwKo7kJn4mnAC5AWZOxOrGO9Sa02XOftV+YwV5Y7/By9seUnb4Hs3QrTbt8EzLG4OGQ7+aKZIQBCJkKRt8D7N8p4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1673.eurprd08.prod.outlook.com (2603:10a6:3:86::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 20:43:51 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 20:43:51 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
 <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <519fd52f-cb9e-0ab1-6d50-a9b3004d86fe@virtuozzo.com>
Date: Wed, 21 Oct 2020 23:43:48 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM3PR07CA0098.eurprd07.prod.outlook.com
 (2603:10a6:207:6::32) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR07CA0098.eurprd07.prod.outlook.com (2603:10a6:207:6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Wed, 21 Oct 2020 20:43:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04f3b6f4-eef8-4e31-a5bb-08d87602048e
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1673C70F45C93F2AB182B537F41C0@HE1PR0801MB1673.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pw0AG+NwRgvU7GoQnxW5mxkoV4hHLOrDtgs/1a6RLYOdSBVVPKbsF9ksj4mjGrbsWClj6KYABw33pR/Xheec9QOG4xAg0hcq0PRQRp/hHfr9Ir+p5AD2Ej4uOUPnaxJJRp/RhbbWbr1I3tT1rW4y+H6AN11htSJ8+R6GtYy48ZkuO3lyeoC4F2ZN9ZPtIclojrneNXd1rizCWneJyq+pjO7v/ZQJ1++M4bM9vLeOY0XbJ3MnQsod7U7FNqlkMhJUUFyvZCVWA8GzU7/eofM9gtyGct4w8x02PHHrnb9XuueJCti5AESCSwYorqdMALP28v27Y9tvwD8cqgCRXhTfXQgEqHaRzJGeyoNIIDmFG1KMRHFnOaTEKHqZTiRjTPOe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39850400004)(66476007)(2616005)(66946007)(4326008)(956004)(66556008)(7416002)(110136005)(6486002)(31696002)(5660300002)(86362001)(6512007)(83380400001)(478600001)(31686004)(186003)(2906002)(16526019)(8676002)(107886003)(44832011)(26005)(6506007)(52116002)(8936002)(316002)(36756003)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 57bLXrtULoVzrlmahDe+1YOZVkkBKHCbkeE12OFXVokOnVKZ9OC8AOyT9Ahli/VKIHshsXebtOWRkGvmErIDG3lXRQj1RSz4heXyTwHackX7wB9jvvhxbqUjErZEQcWa6EsYS5ZCu+s4YF31wy0DuQfYPYg9mV6zSKEETtebVnBftYJyrm+Jkq89jNZylkCK+5yfO8IXsBI3cDWysRMsOjBmQEZMs1LFgFSpMR0pTawYbDyE0Zv+mL2ajUhg57UJ/Ry2sT4lppkmlxjlOMwJu9eGETT2yxeA78ZgI7FYv6xpLM6cRzi0el57QOhEp0gapRtAwT2hQmNBXvo3E8ICm6dM9Wf1Z53W/TudGg1dN8krqn4zmhmlsXoZZNcbelgMKBJz8aw6cYAkrH5ozUp4/VB5GeWpvJGQQw/dvHAnQFHDqxWjFDR8RlPjvi/I4hXcDIattpoYFmc8gCLw/ip0QgtVUoevD0mx20cxRJPtiOKkFtfwRag0zUuzvPOe6H/vRlsRZ43dXlN0Rahm9ER71GmzSXGSux7Ugh/F4+F463rP6RfNrXXldQSE3E12AAyHkFHoYWZM5CBhQ612t+4gwjgFZDJveeHDBjuVAHEnp6z2RZXgSQBFuZh+qrdPl16FiOKR093yl33940tbTSlA6A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f3b6f4-eef8-4e31-a5bb-08d87602048e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 20:43:51.3893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXGxlkC+mHhJsE01P91/+U/H9EpqeQU/FE63jAK3ewtx+a9rb7SU6HVvJJ7r9vaK7dUAjIU/K3Oy/BHcrvVdi4GCyJWfIVotRSmyyFGedl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1673
Received-SPF: pass client-ip=40.107.22.131;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 16:43:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.10.2020 18:22, Vladimir Sementsov-Ogievskiy wrote:
> 14.10.2020 15:51, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>> COR-driver to skip unneeded reading. It can be taken into account for
>>> the COR-algorithms optimization. That check is being made during the
>>> block stream job by the moment.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 13 +++++++++----
>>>   block/io.c           |  3 ++-
>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index b136895..278a11a 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -148,10 +148,15 @@ static int coroutine_fn 
>>> cor_co_preadv_part(BlockDriverState *bs,
>>>               }
>>>           }
>>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>>> qiov_offset,
>>> -                                  local_flags);
>>> -        if (ret < 0) {
>>> -            return ret;
>>> +        if (!!(flags & BDRV_REQ_PREFETCH) &
>>
>> How about dropping the double negation and using a logical && instead of
>> the binary &?
>>
>>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>>> +            /* Skip non-guest reads if no copy needed */
>>> +        } else {
>>
>> Hm.  I would have just written the negated form
>>
>> (!(flags & BDRV_REQ_PREFETCH) || (local_flags & BDRV_REQ_COPY_ON_READ))
>>
>> and put the “skip” comment above that condition.
>>
>> (Since local_flags is initialized to flags, it can be written as a
>> single comparison, but that’s a matter of taste and I’m not going to
>> recommend either over the other:
>>
>> ((local_flags & (BDRV_REQ_PREFETCH | BDRV_REQ_COPY_ON_READ)) !=
>> BDRV_REQ_PREFETCH)
>>
>> )
>>
>>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>>> qiov_offset,
>>> +                                      local_flags);
>>> +            if (ret < 0) {
>>> +                return ret;
>>> +            }
>>>           }
>>>           offset += n;
>>> diff --git a/block/io.c b/block/io.c
>>> index 11df188..bff1808 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1512,7 +1512,8 @@ static int coroutine_fn 
>>> bdrv_aligned_preadv(BdrvChild *child,
>>>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>>       if (bytes <= max_bytes && bytes <= max_transfer) {
>>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 
>>> qiov_offset, 0);
>>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>>> +                                 flags & bs->supported_read_flags);
> 
> 
> When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should be) 
> NULL. This means, that we can't just drop the flag when call the driver 
> that doesn't support it.
> 
> Actually, if driver doesn't support the PREFETCH flag we should do nothing.
> 
> 
>>
>> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
>> why it isn’t.
>>
> 
> 
> Could it be part of patch 07? I mean introduce new field 
> supported_read_flags and handle it in generic code in one patch, prior 
> to implementing support for it in COR driver.
> 
> 

We have to add the supported flags for the COR driver in the same patch. 
Or before handling the supported_read_flags at the generic layer 
(handling zero does not make a sence). Otherwise, the test #216 (where 
the COR-filter is applied) will not pass.

Andrey

