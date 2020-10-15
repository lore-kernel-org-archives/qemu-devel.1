Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F29C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3C82225E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d45XBDU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3C82225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7DW-0007tu-Ca
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kT7Bx-0007Kr-Sj; Thu, 15 Oct 2020 13:37:29 -0400
Received: from mail-vi1eur05on2119.outbound.protection.outlook.com
 ([40.107.21.119]:3296 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kT7Bv-0007QH-7F; Thu, 15 Oct 2020 13:37:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGypE4EbOLl6XAl/M4iBm5pZkoVuQn7doZ1gRYf9mKPWZrq3RT/NLXy8g+eCaqqO80KR12tXQ18cWcJY5Lg/dsbKoLnGL00S6gE1zubEAjNB+DZVd0uD+CHr4hdIjIMzCjoleeOjEz/doq4doTo+uOP8eC3Zo2gi31nRg7PUNSsKZVGtJnj9nmSaj67OEEH3DUIyJkGMjicGKRjr+c3v56alJzLHhAQkbw7jnCuAMF9HjLiZ0Vixug0ZdLWfi4c279m0TrJRj/X1eE04XxXIFL/hC7+d4BiptBceIkxQPN7qVvKMBLrGhrMK+H9BfDtgtrDTIcnpbi/dtxnyIo3Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVHIdBNI1yHa4EHStP9J035eMUTrpzlbUDyien4jGMM=;
 b=HLG10QZ+26CHKL1KFkQhJ/GKRuW1rVGJ+lexpoUkiG8dZb38iyR3nODeDj/vN6ae11UcLcUVh+lYHXpt9vGZgXy+ZQcr2e4gcmGLmmhf6R9fL8ogASBubWvt8hI6q7xSCBgTTZCpkiHojyyGOcsZ3ZL2MQKVnvW1Lso4PGy9X1meVCw+rHygLT9um4T2godJ6nPmN2fx6uhKHLRya+LkT2mlc6S4eBkatCwcB7fevbAUVqVjkRa4lIvzXBAxyAhg6cbMLSWoWVNJvr9IEWkwJrIx0QqWAncF+7L6hVZIHaNlr9zzH53V97TEDO2YaSKouWi543esD8j6FyIO/iDtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVHIdBNI1yHa4EHStP9J035eMUTrpzlbUDyien4jGMM=;
 b=d45XBDU4q/BcO1iAH8KRAqzPfo+d+v+abPr1UHEMiVNjVQs7T2mNQd5V7AobUD+Qk9rCONWxTSmEKd3nnsHGEohxdIyVvaIyLoGbVHqIXNYoby+zOX4v0c58qYWeXmxpnYfgTZo2wyF8Opj/KKBaBRISqfVhO9rE2ef6+osT8TI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2314.eurprd08.prod.outlook.com (2603:10a6:3:c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 15 Oct
 2020 17:37:23 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 17:37:23 +0000
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
 <7b649922-6c4d-7d5f-fb52-c97c1c34b7d8@virtuozzo.com>
 <80f81abd-c810-c3a1-48aa-b1d94bdfda32@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <164ef641-a6e2-5482-551b-8667b6930645@virtuozzo.com>
Date: Thu, 15 Oct 2020 20:37:19 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <80f81abd-c810-c3a1-48aa-b1d94bdfda32@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::32) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:208:3e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Thu, 15 Oct 2020 17:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7da0e1b-c4e6-44ae-dfb5-08d87130f94a
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2314F458936FB4B99504B3BAF4020@HE1PR0802MB2314.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yiFbmZDZ3CN2IGk6/HUjF67unjbRLpiOJbmE5R81xgHW4KrDJwyYh7oYulKjQGXb51i7EzV1cgqJVJteL5uKwvQocNmX2K5SUYXtH+SPOUyZkj6Ekq8SbsFXlTG/NI4085TQW5wdP/u2ZZcttc9EcwcWjdo1uMVdjgTHBlWuSbL/pdlJraXvM/bIf/1SC1hPJH5sE00r/R2yqpMaXBbVCSRug8O/TVNik0YWkfJ7/L2bFpJ4rIP843s8FDxeT3kLdta81nc/eDpC0YfVxQ4zu0taxpcgPugnAsJOx9FLsCdaMlvRDcm3kTF0IM3NEHAAnIXsEk8LjqVVjGQDb9AcnT7ONFQC4DnUvi5/7IWApKJ5Aa3VrBdH+5lCfx9FdFz+N+xvisKhkCmsg3iFmUQrfYsJ/xNMPsfMbtdOP4X184=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39830400003)(396003)(366004)(346002)(376002)(186003)(2616005)(316002)(8936002)(66946007)(36756003)(86362001)(8676002)(5660300002)(6486002)(6512007)(956004)(31696002)(107886003)(478600001)(7416002)(52116002)(16526019)(44832011)(26005)(66476007)(66556008)(31686004)(53546011)(4326008)(6506007)(2906002)(34490700002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YqD0VPi93O72gEC3JNXiTgDwX/Z8Y3U2Nld89XcxreAjwBRZflQtasKQTuNGt9JrfZNFr+gIVQZF+rZLl8O4uGVCgY3rKOwsYCap3oHSQG4YSYrcu0j2zRLIelleX0AhvU/1D+MQqFh0xZHwAzX0IwF4/Cv2h7mcPQ4So84kfn6nh30SxiI48TegtbmhOghEcVVXW9I8xGSxeCLkm2vE9HUdjV5Rd0MIreSgsTouJDL/lKn3dp9IIEN1cKhfGGOMsk9FJOfbd1G2IBh2jX1iuGGRFXlH4a/+EYPsibq2T655Vn6pD/+i8MWFV7PguwUtFF2UBmS/d711GZcfq4s5Gg9Bp7O7OCh3AmDnpoauU5zvWWBiQsG8PtcymRqSV50EennoxtTH+1iCZvcDDJU+ZoO0iYxHyfo6MlozVryuhfnaKtgRTVrc8tiWjUgtHRjp95NA5unvK5f+qALNmAqyM/u70hSY+TbbcrHGPXAh2thgdy2soNg7E6vD7nFsoCQUqGIczoOou9+gxeh6M3yVpXGHKU97ZQO61j7IeGLG4A07IIM62iiprJ7gWOGJDgJ61vLgsvL1qPHwYceJ7yWRkXaDarGgRB9wfkM8prUW+KdrXHjggog3I8X7GQJ3RuGXk1NII1xgb2o8zE5HXaxIWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7da0e1b-c4e6-44ae-dfb5-08d87130f94a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 17:37:22.9796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/CJ6rFezNyXOow3SsPcHr0friwEZjlQ/WIPcHY6K2b/3kbeSVSake2lGsv7W8kYXGgbd4NL4adFUnpHWYj3p7je/1EsNZOCgP3/9I/u3qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2314
Received-SPF: pass client-ip=40.107.21.119;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 13:37:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 15.10.2020 18:56, Max Reitz wrote:
> On 14.10.20 20:57, Andrey Shinkevich wrote:
>> On 14.10.2020 15:01, Max Reitz wrote:
>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>> Limit COR operations by the base node in the backing chain when the
>>>> overlay base node name is given. It will be useful for a block stream
>>>> job when the COR-filter is applied. The overlay base node is passed as
>>>> the base itself may change due to concurrent commit jobs on the same
>>>> backing chain.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>    block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 37 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>> index c578b1b..dfbd6ad 100644
>>>> --- a/block/copy-on-read.c
>>>> +++ b/block/copy-on-read.c
>>>> @@ -122,8 +122,43 @@ static int coroutine_fn
>>>> cor_co_preadv_part(BlockDriverState *bs,
>>>>                                               size_t qiov_offset,
>>>>                                               int flags)
>>>>    {
>>
>> [...]
>>
>>>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>>>> +                                          state->base_overlay, true,
>>>> offset,
>>>> +                                          n, &n);
>>>> +            if (ret) {
>>>> +                local_flags |= BDRV_REQ_COPY_ON_READ;
>>>> +            }
>>>> +        }
>>>
>>> Furthermore, I just noticed – can the is_allocated functions not return
>>> 0 in @n, when @offset is a the EOF?  Is that something to look out for?
>>>    (I’m not sure.)
>>>
>>> Max
>>>
>>
>> The check for EOF is managed earlier in the stream_run() for a
>> block-stream job. For other cases of using the COR-filter, the check for
>> EOF can be added to the cor_co_preadv_part().
>> I would be more than happy if we can escape the duplicated checking for
>> is_allocated in the block-stream. But how the stream_run() can stop
>> calling the blk_co_preadv() when EOF is reached if is_allocated removed
>> from it?
> 
> True.  Is it that bad to lose that optimization, though?  (And I would
> expect the case of a short backing file to be rather rare, too.)
> 
>> May the cor_co_preadv_part() return EOF (or other error code)
>> to be handled by a caller if (ret == 0 && n == 0 && (flags &
>> BDRV_REQ_PREFETCH)?
> 
> That sounds like a bad hack.  I’d rather keep the double is_allocated().
> 
> But what would be the problem with losing the short backing file
> optimization?  Just performance?  Or would we end up writing actual
> zeroes into the overlay past the end of the backing file?  Hm, probably
> not, if the COR filter would detect that case and handle it like stream
> does.
> 
> So it seems only a question of performance to me, and I don’t think it
> would be that bad to in this rather rare case to have a bunch of useless
> is_allocated and is_allocated_above calls past the backing file’s EOF.
> (Maybe I’m wrong, though.)
> 
> Max
> 

Thank you, Max, for sharing your thoughts on this subject.
The double check for the is_allocated in the stream_run() is a 
performance degradation also.
And we will make a check for the EOF in the cor_co_preadv_part() in 
either case, won't we?

Andrey

