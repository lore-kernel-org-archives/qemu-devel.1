Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E89C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64E52222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L+skkXLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64E52222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlzc-00067O-Ni
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSlyR-0005VD-Pb; Wed, 14 Oct 2020 14:58:08 -0400
Received: from mail-eopbgr40101.outbound.protection.outlook.com
 ([40.107.4.101]:15165 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSlyO-000737-3Q; Wed, 14 Oct 2020 14:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guyx62t+5fK5dzudYGJo41B1spiAXHBT3wglQyfgz882O7PBWnzm8HpB10LXfAOqcDibfLSczChFZSALDPkZkBSaiVOBGNFgIJVISoiPthEIY+24tY2s8Q8LHjCeG6XEejRD7DQRnoAHNVqu7qBw+5QVzwD6yfd6dzgFBh/u0t6Vhc2876UadhF/RG+7nTl9Jn3/hzEI7V037Ei1pV1+HfciG+1yVElQz476N8g7Xnqj5NBkwGDCLzUeI6i43jMiYpw38o3rFpGKbQyNavqveRj2qiBdMt2I5kEKZzUK/tpnmKdNc5ykGjpo6pgWZW6ElAF4ekZGR2dy6lVu0apvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyHNQFfA76YBXXOLjp4P3Rg+m9Cp0GUtr28f6z/WYLs=;
 b=S8c9vaI+RA9kVDPbkPLt7UemrmOX067k5u7ZM/3lU0qV/DZudKLm9CW3OvE5d0/F7wnfBnM+ZpLmwVy3vppKeoDQ55idooR6CNeDsQgemC9Amj8m0RNyRiMwEmaFY6ysAzFT+3nHcwdLxdNeXQxQ02SzADTe3rMFZq4A1KvLSTKwow4j3Q/R12tEp5gyeLYQdyXBjOhnelyTIAoM5EnyEnCwkYy2UiO+7Hn1bId2Y/h2H+LujH+x1ggvGgn5EMMQE9N/bROlvlkRtDrdoVudR7Y0RJPCkw87jFvZf865BPqsULFoOU3+D/h+9wAs9VRun65P9IATD83blZDkwovjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyHNQFfA76YBXXOLjp4P3Rg+m9Cp0GUtr28f6z/WYLs=;
 b=L+skkXLRbHUPBIBdYdd9qfJ6LOocZb3bZNB47aqiJ9iZvJhM5sR0vxsKNXtYqDPBryCYSI/Cs0y8wQhmimjoP/fm2uVJ8y7l3GK1pkwvmeCQoEfe7g066I1Xv9NEZ1UpFs/HIcfrCeHg7b5wT5M1GgAlLprfwwg6fAe77WGROGU=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2218.eurprd08.prod.outlook.com (2603:10a6:3:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 18:57:55 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 18:57:55 +0000
Subject: Re: [PATCH v11 05/13] copy-on-read: limit COR operations to base in
 COR driver
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6dc38263-ad9c-f238-7197-68e920b6080d@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <7b649922-6c4d-7d5f-fb52-c97c1c34b7d8@virtuozzo.com>
Date: Wed, 14 Oct 2020 21:57:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <6dc38263-ad9c-f238-7197-68e920b6080d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:208:1::45) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR04CA0068.eurprd04.prod.outlook.com (2603:10a6:208:1::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 18:57:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9f3da6-5f99-41d8-2f31-08d870730ee3
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2218C554A349FF668156A02FF4050@HE1PR0802MB2218.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMPK7HB9hKn7RLW8enLJoC/rS/JdzhY9PyZiDhHqKhpcBY/nerOH9hBcKDliFme8fh0/gwbkW+gtAtzXuVASoihp4Tdh2jSc9Fmto3bQe/0mXFTI0jO87VB24ezGO17sJQpIVBuHAYcC/27eZC9DUlzjtqWBYneFiLEf1QvkfSRN5zsYx75T2oe0zmJfo+rxmfIe1jOXcRNVngnDoSS54B0n3Rv6LAlN4lcp4CKvjJcZKjBzd5VK1oLO66uoZrYbqcYFxyzk+/UyItX13O1I11urvpWni+NbW63Ki6Zh0rxbXL0bGi9uNXdmx5dd9n4fpF11IIng8XCBNHBOId3d929dRotWt4X5MJEDBCuZXVMnUQdr5p3j5luqrs1gPIqw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(66476007)(66556008)(6506007)(6512007)(2906002)(66946007)(8936002)(16526019)(83380400001)(86362001)(186003)(2616005)(31686004)(31696002)(53546011)(26005)(36756003)(7416002)(44832011)(956004)(316002)(5660300002)(52116002)(8676002)(107886003)(6486002)(4326008)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bcqDq90qmJwgtbDLzoZyvNoDZfN/8sisoyziuTJqljqgjMRhjFtlGvQz5T3tzGWOF1XsKirQEb9/nDdGQh9zFrkNTB2NgvCzZJ0ojmN0zoSTUB3g3imH8hRjXFJ5PxQAfAQnMgphnqLru2DzcrWua4hKWDlnBadC+WxUMrVcZ+a/HWxNHz3hQTY26b6HCGcWBbq7A6dzimYymUG4lXM/DuUYYU0bvVeCLZ676kPDbz+6yE1FC4SskzOhEQJzsWCP9Zvb/9OL1j5OXDN2VMv6NkVkoEMzNEpR4FZEA0/i54sa/7BAmSmnuYfVswvVV2gJmUWJ7ZpzrU3ZEwAm/JcozHecsOjKEA0nA8tFVS792xrwWiImsGZu5hkuswGXdkBcO5fC02ECqQRQFEBwvOA++Bb3CjQFKfKmzLdGuulfxV1wW7TJ2RR75b9SUX5yCfUzrdmUBUVMtKviSJhWf4+dNQceAZ6M+UUbsi5h3qhXYiO4lcaBt/51Wp9Yo2rbQBBIWsnN9vMGkPSMsIYChiIVL594S2MUFJcaTCaU5F/miStKs0niW+jgaVVdU/mi0h2xGQ8yHeLL79ongjTKk9Dr/FXcMDjz31kqnGIxQASlbDMeEGa4CsFZCMA+klAoZ17YW/xVusNnAQwKvcYj8fB0WQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f3da6-5f99-41d8-2f31-08d870730ee3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 18:57:54.8513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL92X1hf6hrsD+C6GZxjCkj0x1wvqPeajF/4Eeh4kJAT/jpk87yU+f6Pj19j1jntHYpDYDctdpI9B5ZDgBCN1otElSJCEFRik1cPUoMfptU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2218
Received-SPF: pass client-ip=40.107.4.101;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 14:58:02
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

On 14.10.2020 15:01, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Limit COR operations by the base node in the backing chain when the
>> overlay base node name is given. It will be useful for a block stream
>> job when the COR-filter is applied. The overlay base node is passed as
>> the base itself may change due to concurrent commit jobs on the same
>> backing chain.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index c578b1b..dfbd6ad 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -122,8 +122,43 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>>                                              size_t qiov_offset,
>>                                              int flags)
>>   {

[...]

>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>> +                                          state->base_overlay, true, offset,
>> +                                          n, &n);
>> +            if (ret) {
>> +                local_flags |= BDRV_REQ_COPY_ON_READ;
>> +            }
>> +        }
> 
> Furthermore, I just noticed – can the is_allocated functions not return
> 0 in @n, when @offset is a the EOF?  Is that something to look out for?
>   (I’m not sure.)
> 
> Max
> 

The check for EOF is managed earlier in the stream_run() for a 
block-stream job. For other cases of using the COR-filter, the check for 
EOF can be added to the cor_co_preadv_part().
I would be more than happy if we can escape the duplicated checking for 
is_allocated in the block-stream. But how the stream_run() can stop 
calling the blk_co_preadv() when EOF is reached if is_allocated removed 
from it? May the cor_co_preadv_part() return EOF (or other error code) 
to be handled by a caller if (ret == 0 && n == 0 && (flags & 
BDRV_REQ_PREFETCH)?

Andrey

