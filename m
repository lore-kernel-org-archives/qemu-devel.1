Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C675C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C3208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DoqQw31x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlQn-0006J0-5g
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWlPw-0005NC-E8; Thu, 07 May 2020 14:38:44 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:38020 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWlPv-00009Z-Kp; Thu, 07 May 2020 14:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZiMaU2voPC0E44eE7Imx7lv/3uGIfRfnY5faqpMAw/BgczXE6dn6/eWJhcWigWB7hg6v/3Bhp+hRqZ5bYLeZIDG+wPb+MxWclBgT73vc3MmEQYcwzMyVx2UEwIpVdQsQccwHp6g2rtszC0mtxRgGiiMesXsTMcXifiLpJSoaYZO70qZlYIUY3uIpTqLFrsU8492wO0P/vpgb1fzIcEE5GsSTq405D7twWhMF3aw1gkZZPtReeoQSgefH9F/fmlGQXMPbSDeTye0j3ltpxkcFaj+scmp9W1eynUrCPxCL0uPoc/V8e2OZ2oVMhK2XnWb20YOZh/9NlPNjkQO/P5ncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFZGMlPKi7+VQ5k8Tl/CVz4xQ6qGm4H8nUrR+sMor/A=;
 b=b5DMj+DQtnJQL5ZUgfYjS17Q3fWVHcDw1v55GOCQr4Y0ZLGMP3bPlS9OrIEK6hygnm5z+SQdf2sQlMs8JjFvdlM4GHpay59TpLgoxUCjfS/N9sp/yQ+k9Ec+4gVMewl5rOu27s6f5BRjMh8+22PBaEZIZ8U6/4HmD7BciqO8f/4fHER+cKzxlxjnblXLDbZjVi5j0pdMT3ln25uPVa34MlkX8zjROfZvFfYTM044PUuO/es/Tj+uOuxxXQKSNaGiUj01slZWtfHQI6wBaHiMIuDfkMIWtfDa4YwDg82UOYCILlYhOQwGj7TH4IHZtXa/pXFMJIBVy4+au7+DsXPh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFZGMlPKi7+VQ5k8Tl/CVz4xQ6qGm4H8nUrR+sMor/A=;
 b=DoqQw31xQQlBmxcqzugPq9iVrgAbgpPLk9kgbyK8WIRyeWBuiIlPirAqt8YZ0CqWRTLrrJAxJhtUtYJbdrHmlGwbbkoaRBxJbnXh+KOLcvu3pgQzrk+QXiiV6cjK/bnwPj3AN+AL/XHLGb6+snR831R8dJEZzu/uxCR2vkYhr3s=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 18:38:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 18:38:40 +0000
Subject: Re: [PATCH v4 5/5] block/block-copy: use aio-task-pool API
To: Kevin Wolf <kwolf@redhat.com>
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
 <20200429130847.28124-6-vsementsov@virtuozzo.com>
 <20200507155300.GG6019@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507213839009
Message-ID: <9570fd98-d809-d56a-a2a6-ffd2ed0f2675@virtuozzo.com>
Date: Thu, 7 May 2020 21:38:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200507155300.GG6019@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.30 via Frontend Transport; Thu, 7 May 2020 18:38:40 +0000
X-Tagtoolbar-Keys: D20200507213839009
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d7a3be5-9b48-4382-a21c-08d7f2b5dccb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494A25820FE6C95E69908A6C1A50@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:77;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5LPYYQc641TgH0NAivHPCS8AkRYWsC5/60BrSYvEqobNGHSicBkKBtcIoPobgN2y6iF9cztXp0hOi2+qkDgQQKcv6KmekxdnBol+ic3L9C41ztYEVyfhnYyIncTtrk+Tg49+9wtpEImpSEWcU14XUSmvikXxVxE3Qn3gChTOb/5oHV8rSaqIUk4zraEHaS65C0WddWlq+caPWfOnVVY1iny6FxCHZQFOLBVreW3vsjoUKKOHYVrz3oeR1Rntd62IDMVZOU3LzTHWC2k6xecmXd3h3IQst8SZJi3pu1VPhIIbcey58/2iDqlQWtjkXBgcFTYLHyZjzltoRO8inETSCkB4SkrrzOVOFbmzNY3qaHmEy0IPo4XLLXwbons1AXRi9WzG73zbdmHaX7bt8NRyKoVxJMYSFNM5SLpMe2wxlN33K8xKoFKZrS894VVd+VPwG2TsPHTGH3pq2e83nIwS++E4qysPux+aWvgx6jRTK9ooX33/JJXCopAyvnho9Wy8n4UDWKDvYcChFbfCTE4DHRWIuO7NixyOcoYjxlKQvKQIwXlq5AP5UdQcaGWMfjg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(366004)(33430700001)(26005)(5660300002)(66556008)(66476007)(33440700001)(6486002)(186003)(16526019)(956004)(16576012)(316002)(2616005)(31686004)(478600001)(2906002)(36756003)(52116002)(66946007)(6916009)(83290400001)(8676002)(86362001)(31696002)(4326008)(83320400001)(107886003)(83280400001)(83310400001)(8936002)(83300400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: algvIh1W+bFgTFnsOOgu592n56P8FE/9nDmU9zyyOLt0LaT4LyKqTOsgoUfcBc1ojaDg2zbSRcPjyiT2meBZdhdXWURkBOSel4brttME2O2S9XrMS4y3uum2bDM5oLFyBn9+7KQ+fDVBX3YkTa/4Ly5jOu50qG4jLeNGlvFJ+DQg8ZAr59sahiEWBOeNZC1GmfAelu+ilGrojZlOWt+D5Ae6WyJAtYxWp3vc6t2pPbGX9LlhKctM6jv7jIl9Kb8WxgWiase8LRu2hVGQqFCCSjjzgz9t2Pje8rVQ5XtVithA4d4vp9Wo2i7myZ4AcSPtDLBsKEOz8jZiWEAeHkUM7jc7Nlhatii6ZzUNK1w4+dPqO8csxE718igsG3KH6T7tquYcE8rXO+NMetrpWk5wb76WdBjPbknkoWADycBP9BuGTNd6r5MRyHfe+Juvl7pJrBhWh/SuHGpq4VWEjhDb//MoJl9C5u8NKmtk5hTIwyopIUOJ0fDa4VIRNBwvTUKaOC/L+NMS6YIKpQJKaZ9mzKtJbbvvVqpXb0rnCBw6A6izO6c4dPFcQYtpKDCT77hmPDiUJpa/saHYIWEdZAipUdnh76ZSdiVPBY+whk0eMBJgxFHHlvJGnLOebkB6+MnlZXhnmGDeUggIBByw6NLHklREsf4DrIGGtv/cwd+8TXU7RjSTVm8JgefEbMZbSynLRZtgVmZ/73Jz/U25m2l4jsLx03SL8xmJ67fVSxlMvOA/sOYuyLwT0rW2pmm2q7T5a/bOvxzsKKzNrqKGHX9k+8stErGFaF5nu6vfXG12Rho=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7a3be5-9b48-4382-a21c-08d7f2b5dccb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 18:38:40.4505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbzG3PBc/z9k/SVRxXJGYcAXmyyuJo52CTXKPHSwFGnc8KKBi99hbWDXTKXGnZU27D7gAGASz3o3HkulQRA7Jtij8fE4WP241JivpBKeli0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.7.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 14:38:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 18:53, Kevin Wolf wrote:
> Am 29.04.2020 um 15:08 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Run block_copy iterations in parallel in aio tasks.
>>
>> Changes:
>>    - BlockCopyTask becomes aio task structure. Add zeroes field to pass
>>      it to block_copy_do_copy
>>    - add call state - it's a state of one call of block_copy(), shared
>>      between parallel tasks. For now used only to keep information about
>>      first error: is it read or not.
>>    - convert block_copy_dirty_clusters to aio-task loop.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
>> @@ -519,6 +591,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>>           }
>>           if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>>               block_copy_task_end(task, 0);
>> +            g_free(task);
>>               progress_set_remaining(s->progress,
>>                                      bdrv_get_dirty_count(s->copy_bitmap) +
>>                                      s->in_flight_bytes);
>>               trace_block_copy_skip_range(s, task->offset, task->bytes);
>>               offset = task_end(task);
>>               bytes = end - offset;
> 
> Coverity found this use after free for task. Please fix.
> 

Oops. Done. Sorry for that :(


-- 
Best regards,
Vladimir

