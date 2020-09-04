Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD12C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDF52083B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TJ3jh7Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDF52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECGF-0000bQ-Iu
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECFa-0008KW-NP; Fri, 04 Sep 2020 09:59:34 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:29479 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECFW-0008Rw-SY; Fri, 04 Sep 2020 09:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3RDOBUxmotf7FBs4UXevoqAgJfZNvoa8BIbzOIhOP14/Jx2vE4anhxZGXCMhBjRGqlstpTAd4JujYeyymVL7V633xkI25IUwPYHxaC/QY+RkiHyqyp0+KjGcmAgTiaC1NpeUcCl4zBf4CyVdaVWJZ+bHOQqRAtWrhe+Jcmdvm8bVsNkj74ANwssVxxQ5IHTxmp8ll1cWPuOCRLZrkRydREHyob9QOr+LxtHJDP7Wu50c2ydcWU1gMf9S0tS0Rq5nK5q23vWO6Kd7nRjJut8Bgouoho8vW9NAR6QhPFwivum88DCuSkv9FiK8AzvCambGHZnisrTsw7Kbt9uphgLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7SQ6eBTQ9VDZmc8qGrzBj3M+EWQIVWkav42itzTbH8=;
 b=cOjP4mnUKCEZhC+tq0AJKNZMLKwqDZ6yiL1U6ib/GuzUeR31ryptWxmgTLo+Z1ObaV94tDaHdu5KQQctJkcSrjkZPtfrJhDZJPIqNS8vk3dw/+td6CIKEPrcLWHS5gKbl0+Bf4GEmHPoqzbYmGmgsn5UhQVZMBF+Rqirq2ga6t1d5K2aBxa62ZzPvDXkYpZZNpQRfheIV3h8si5XVxOYEZbI5W+aa9qQdErxlMjftEEugCHIhjmBe8gaIEBP9jp571icKWhpnZgPwZGNF57kkdQxPessACufi2qyUPoTwejpLlHPRaJ7uG+JP8MFdLLubTX5Ap4RuyDH6GzdHDoKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7SQ6eBTQ9VDZmc8qGrzBj3M+EWQIVWkav42itzTbH8=;
 b=TJ3jh7QbcbEsW1p7J17PGoJE20lh2iVtWoGYwjzUzNY1VSGXuWB9CbeKwDXfvHn9qzeWwhTq2/x6i7JPRf2P/pW5XWIVZTYN/+FHwKcy5GTHQ0ydLsEHsoHVfPdP0NcS0c1mTZEHIcZcx2wPFot+OOPT2jyI6gJjJw8qEPYRK2g=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 13:59:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 13:59:23 +0000
Subject: Re: [PATCH v8 5/7] copy-on-read: limit guest writes to base in COR
 driver
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <667dbbb4-b4b3-1e18-6c9b-466b75cbd00c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <716e4f2e-b15b-6094-badc-84d3daf9f8ab@virtuozzo.com>
Date: Fri, 4 Sep 2020 16:59:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <667dbbb4-b4b3-1e18-6c9b-466b75cbd00c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.143) by
 AM0PR01CA0171.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 13:59:22 +0000
X-Originating-IP: [185.215.60.143]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec028d3-988f-44a6-add0-08d850daba27
X-MS-TrafficTypeDiagnostic: AM6PR08MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4408FB4DE536A9A3C0EFE756C12D0@AM6PR08MB4408.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvkLJ6F/P/At3kJJDiogwA1oawQOg24J3s/a6JbYKAlg3fkJQuhkBa4OXQIc+C0OxRSiR+Y9DPzijhOBbMKabMPvW1/4mav8QuhJdtP0boV/1rVSNbzdFG0qAuhBVfJBXCk2xhCPoDvLA7cokbM4QktV7spLqVGReIS5xkZlijsJFTM4xhS+D968/RU6MBXeirwdZC6Yg6dm2KtJjHGgcleqibEeQ4v5ZcHmzYq6f+L5aX8NndHkh8ndZss3OYd2YzlNxjbVws/vzIse8E5vqUYkqk+F2BfaM1OcRvAVgfOBBs49gyj/Nz5CO0pVkF2ESOgZKCn6uR0R7mGfIlLMcH26Z/6rZRdj+gDFvko8tzqjJzWM6bDufFMNcgqV7JN+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39840400004)(366004)(346002)(396003)(52116002)(66556008)(66946007)(66476007)(31696002)(53546011)(186003)(83380400001)(31686004)(8936002)(5660300002)(8676002)(16576012)(26005)(316002)(4326008)(956004)(2616005)(36756003)(16526019)(86362001)(6486002)(110136005)(107886003)(478600001)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BCZ5nKNXPYgY2Dm/icGyTjXCl/UwqvtQD+XGlIwJjwoEhgaq4AAVTnwv+KiKhEtobf8VdrnzyCeQ04WTL6J/dzEUaGuoReBv+jqPWSfkhHCO+JqCspt8wFUF9bfjo34utNc2D+0M91av9UqSIhMHHNTVQrnftKnZgIs7WrTwWmazg4UCydnCmXgnih+RFxNM0DdvyEyDOJOd23G5/zUQINuHnEDOysPn00qN1Dz1yX3fgrg8LTU9K6JoWfW1PIjetEo7AJSbED71pVBDa9czMkFsIkEiTO3KVCTU52NF8albpXAjW98kFz4oyEh6b44Y7MeVyM6IAp8ISWfSjWJojG3W8VBSO+l0zi3zHGPbZJ9ArLXfCSqFHx+f0Ynp2i7G3vmoBerbkVF5Tw4bQOdQsbzzRj7wUSmfSszeihckvEHnav9uYxNiFsFEa7prbBVhlynEDyZ453idtvwb9xqI2W1+PA1SD88DveSNfPMGU+vdkASAhY+L9qNz7T4cN3fZ0LzCoEgfFnSyhuVTHR0H6Z7gqSlCmOBTmfpNvdb1eMtecNy81BSzlfj3rmLV36aJEhw448zz9IFrxUpCbHPH3zw9Rw6CzcE518EiIKmLeAPgYgtWfQGK5lXR5NKFPE1wvIcB4IomucvoZ3J5w/FZXw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec028d3-988f-44a6-add0-08d850daba27
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 13:59:23.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50AUTIHottGOLuEu8FBWj6V6lGFzqqOthw4SiIw/a+FhuTQ+G2oHiu3s+ovkfDviGnKMHQga22+mh4mYR6UucSD2hWfhLL9dDDux3nH5bFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Received-SPF: pass client-ip=40.107.1.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 09:59:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001,
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

04.09.2020 15:50, Max Reitz wrote:
> On 28.08.20 18:52, Andrey Shinkevich wrote:
>> Limit the guest's COR operations by the base node in the backing chain
>> during a stream job.
> 
> I don’t understand.   Shouldn’t we limit the areas where we set the COR
> flag?
> 
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index 1f858bb..ecbd1f8 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -57,6 +57,37 @@ static BlockDriverState *get_base_by_name(BlockDriverState *bs,
>>       return base_bs;
>>   }
>>   
>> +/*
>> + * Returns 1 if the block is allocated in a node between cor_filter_bs->file->bs
>> + * and the base_bs in the backing chain. Otherwise, returns 0.
>> + * The COR operation is allowed if the base_bs is not specified - return 1.
>> + * Returns negative errno on failure.
>> + */
>> +static int node_above_base(BlockDriverState *cor_filter_bs, uint64_t offset,
>> +                           uint64_t bytes)
>> +{
>> +    int ret;
>> +    int64_t dummy;
>> +    BlockDriverState *file = NULL;
>> +    BDRVStateCOR *state = cor_filter_bs->opaque;
>> +
>> +    if (!state->base_bs) {
>> +        return 1;
>> +    }
>> +
>> +    ret = bdrv_block_status_above(cor_filter_bs->file->bs, state->base_bs,
>> +                                  offset, bytes, &dummy, NULL, &file);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (file) {
> 
> Why check file and not the return value?
> 
>> +        return 1;
>> +    }
>> +
>> +    return 0;
> 
> “dummy” should really not be called that way, it should be evaluated
> whether it’s smaller than bytes.
> 
> First, [offset, offset + dummy) may not be allocated above the base –
> but [offset + dummy, offset + bytes) may be.  Then this function returns
> 0 here, even though there is something in that range that’s allocated.
> 
> Second, in that case we still shouldn’t return 1, but return the
> shrunken offset instead.  Or, if there are multiple distinct allocated
> areas, they should probably even all be copied separately.
> 
> 
> (But all of that of course only if this function is intended to be used
> to limit where we set the COR flag, because I don’t understand why we’d
> want to limit where something can be written.)
> 

Agree to all.

1. Write path shouldn't be changed: it's a copy-on-read filter.

2. On read we need is_allocated_above-driven loop, to insert the flag only to regions allocated above base
  (and other regions we read just without the flag, don't skip them). qiov_offset will help very well.

3. Like in many other places, let's ignore block-status errors (and just add the flag if block_status fails)

>> +}
>> +
>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>                       Error **errp)
>>   {
>> @@ -153,6 +184,12 @@ static int coroutine_fn cor_co_pwritev_part(BlockDriverState *bs,
>>                                               QEMUIOVector *qiov,
>>                                               size_t qiov_offset, int flags)
>>   {
>> +    int ret = node_above_base(bs, offset, bytes);
>> +
>> +    if (!ret || ret < 0) {
>> +        return ret;
>> +    }
>> +
>>       return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
>>                                   flags);
>>   }
>> @@ -162,6 +199,12 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
>>                                                int64_t offset, int bytes,
>>                                                BdrvRequestFlags flags)
>>   {
>> +    int ret = node_above_base(bs, offset, bytes);
>> +
>> +    if (!ret || ret < 0) {
>> +        return ret;
>> +    }
>> +
>>       return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>>   }
>>   
>> @@ -178,6 +221,12 @@ static int coroutine_fn cor_co_pwritev_compressed(BlockDriverState *bs,
>>                                                     uint64_t bytes,
>>                                                     QEMUIOVector *qiov)
>>   {
>> +    int ret = node_above_base(bs, offset, bytes);
>> +
>> +    if (!ret || ret < 0) {
>> +        return ret;
>> +    }
>> +
>>       return bdrv_co_pwritev(bs->file, offset, bytes, qiov,
>>                              BDRV_REQ_WRITE_COMPRESSED);
>>   }
>>
> 
> 


-- 
Best regards,
Vladimir

