Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCD220BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wFlYmkzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCD220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8Km-0007y4-E7
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kL8JP-0006R8-3s; Wed, 23 Sep 2020 13:12:11 -0400
Received: from mail-db5eur01on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::726]:27287
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kL8JL-0007kf-Ik; Wed, 23 Sep 2020 13:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS1VvwiTq2r0YxOFS8bGLLUOUwgkxfkpmqeiPCMH1T8upZnpFgxfGeVXnd1U+BDwHOlQxMG1u3ImTclRJia/bSjjeDT06clfLu2LCjHJqHH+xgBTsGlneoX/hFQxiXriE2Ti56poODyG+8yHK0nyDScF/OmAFGQjbLNe/l8W+2Ig/J/CsQp+9gLHuWbjHzDnhm1Y/KgoOI9HFUl90EAs/4lEnVDNFFzGK+Dd0yTZoyGBWtcXf7Y0N5Ko4DkkkS4qYDuJJfb/HQ/4wPNmnwWKjyGHO3SWgzL6l/pKTRx6qKiITN9/Yie+CWe5k0Wu07s2zWXEdiSwUldbVYvYZd8cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJD/r36fgXAIyIgXn9UenNMqneSBOf1vJj6qsOS4PXo=;
 b=hCaCVGpPhvHrNH5Nh1m/3pgxNeUkmw9YepnCcaCAFExydB6CmpXuXOTIJ43kaSTSLoVv1tm7sI6FKMz8uKy6WgummS8NC9MAiuwZu/CDUEjWgBB4PRwmA2PZQKrqrOIT0nALw+aXgcTn/fWk+h+v7bF2cw1lXF/lPEYBNzeJhpwLFoeVjLErFFNKzrWYkxEFjm7+EJcCPa4LfdtsbXyLx21N59/5uNhvuUuY4WdKDRcAiY/c58h0zKOUsVrHgmoBpmiwdF6ImcBVEI1aPW48k12uCHfiBVKsJW98LcJs3tluBRTeZNRPE765KMZk75+zPeJwf4XkkYR1RB5NROTxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJD/r36fgXAIyIgXn9UenNMqneSBOf1vJj6qsOS4PXo=;
 b=wFlYmkzpsVxv2DdzoXptQNP9QgWhmbCOdR4VCylT4LZ42fW/SnAnlnyxg9GT1MhIPVbjmyUjiblEL+G4Xv3Bsj4gZFjg6I5piJfCLJABisiNrd7gSCJmZxCzCspCs4xe9Yr3cTeDp2f97ZmPkAWXPdEPeEm7MgoLBonMauwZnQA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4280.eurprd08.prod.outlook.com (2603:10a6:20b:b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 17:11:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 17:11:59 +0000
Subject: Re: [PATCH v6 2/5] block/io: bdrv_common_block_status_above: support
 include_base
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
 <20200916122008.20303-3-vsementsov@virtuozzo.com>
 <w51tuvoa2l8.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6181089a-8910-442e-35ed-e1bca0bde3eb@virtuozzo.com>
Date: Wed, 23 Sep 2020 20:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w51tuvoa2l8.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:208:d2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 17:11:58 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe13347-af7b-48c3-6046-08d85fe3c816
X-MS-TrafficTypeDiagnostic: AM6PR08MB4280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB428080B8DFC1A0DD3E1E8CF3C1380@AM6PR08MB4280.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OibdQNC7YnYHjwbh0ZmH94DKM0Z/qP/kgQRBvt1lYQhJRW9hTb28/2126nKI2G2qEKt/qyqqPRLTNvVZoi1l6YVF570mgXCpKN6J0rOgrOZsxpCPDF2giUJO//4tZSveFRVmc/8N/Y1YPsBgRn+odl8wnBRV2DLgjiLSa8BQm5JETGvNzgj3t8ZEXmhfsYiVnOXtP86l4nhNYUQDEMElotqehmEjefvPTZm9E0IUhsMdAmE74bxx9Uq6JNj9cRC9Gw+ymTCV53czzAIFAvqbzoho4bov+TeRerko7xY3sNqXxYwWWxsUH1dDxcHrn3IFAoBFGW66JNhcCEcQKOg5SrR9mPjRxBZqqnEK1LU8fhRlE6kQLH6AiBPn1+aJc3rtDP6YHd8DiOe4TOghwQgwj8a1Ow0GmPuxI+zXTrNWmPTHIZL7vZKK05QPqVbEbYOc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(8676002)(6486002)(86362001)(83380400001)(5660300002)(2906002)(66476007)(8936002)(66946007)(31696002)(66556008)(107886003)(31686004)(4326008)(52116002)(16526019)(26005)(186003)(16576012)(316002)(2616005)(956004)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: srP0iJbJtBFRyZ1mEGtytSfX1GHswgilLq1heOKEGFaEy4sxdKrXa0OCv48SS9X97uMAiOuB6xI1V0yxDtWOVaVaYlJ3Uq4HC17TZOgfdaGmClZE8VOkt+D+LBpUq3JQq9fF0d00J6Br2f/5d20PvppKdzfQXei81rCcgavcrkO9aaF6hPI3+RncqTUX7No3PbAklNC/M1s1j9GQh+FOKcx86L+SyNXi+2L0Hpjreye8w+lO1aEhMfouNDtQleOrEMqRLXvZ6sz4yjEfOUQgrap6NZhBbkfW+L0zq/9LyoVhXbd65RXee5Ne5sxQnV35UtoMq19jJI0pLmEwFh7bvtwgVJlKsGnlwM2YEHcDUB3MU2xKbyHGBbmHsKaknHzuuqgPlcejR45PiDUs85JKWf76BnkjXvp89/IClXnk8fXHKgXCSAYTbzuGyWCfo4oUVh8rDs4QNeTfIZsY9lIRrlK33seCTf/FJ/TTxW+wm+C/D6QS/zZbh9/+xGmICyooyJfZfb8b03+2hFqbXWP6cgHA3gGn8R90IdXYPLVHhaT6o/doOoJsSeIvQHBs5l0y1nY+wfBq5SrqKAOhPw7Yefvoxgi7aS4AMDgR5IfqBIGzEKrtSRDF/+fHhXbVoAUyZYRXqyziffcjaqAgUwGkVg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe13347-af7b-48c3-6046-08d85fe3c816
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 17:11:59.3005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KDGAKRM+bgztfM+F6TWWZhaVs96HPGMUrV6C1Q27cIp+UXH66f5/IU6VGqdMOk1KfYHvvKWFqeJJuIWNysSILXCGAxLRGs7pBryzfdV6mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4280
Received-SPF: pass client-ip=2a01:111:f400:fe02::726;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, SPF_HELO_PASS=-0.001,
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

23.09.2020 19:18, Alberto Garcia wrote:
> On Wed 16 Sep 2020 02:20:05 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> -    for (p = backing_bs(bs); p != base; p = backing_bs(p)) {
>> +    for (p = backing_bs(bs); include_base || p != base; p = backing_bs(p)) {
>>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>>                                      file);
>>           if (ret < 0) {
>> @@ -2420,6 +2422,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
>>               break;
>>           }
>>   
>> +        if (p == base) {
>> +            assert(include_base);
>> +            break;
>> +        }
>> +
> 
> Another option is something like:
> 
>     BlockDriverState *last_bs = include_base ? base : backing_bs(base);

hmm, in case when include_base is false, last bs is not backing_bs(base) but the parent of base.

> 
> and you get a simpler 'for' loop.
> 
> But why do we need include_base at all? Can't the caller just pass
> backing_bs(base) instead? I'm talking also about the existing case of
> bdrv_is_allocated_above().
> 


include_base was introduced for the case when caller doesn't own backing_bs(base), and therefore shouldn't do operations that may yield (block_status can) dependent on backing_bs(base). In particular, in block stream, where link to base is not frozen.


-- 
Best regards,
Vladimir

