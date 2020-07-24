Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7BC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7EC2074A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QbSQNEru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7EC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyv4u-0004DJ-Q2
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyv4I-0003hG-6y; Fri, 24 Jul 2020 06:36:46 -0400
Received: from mail-eopbgr30123.outbound.protection.outlook.com
 ([40.107.3.123]:60632 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyv4F-00021J-LL; Fri, 24 Jul 2020 06:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQXeBQ+59uplIx0JzejZqRnAKl7ByZb62I/fjek4eclas3oxhjNwkRpLDtLcbmRjW1R0GmbsHXj+0oYcFq9Uwdj7l6L0GNKoPBdz73rSyz0BjrUX2ZFeB7OHvDx0hYl9n0eu9DTMQT/a57wRIR1szpsyRueUmLk5dnQsPDkPwMp4Nwe8/pWaNssg9LtvKE5ZV2C49a4+IFnbjrdpy18v7iKGYMgABHe3wGwyhh76CjD//UfEGsIRpWVqy7zqQ5EN4Rl/X0/yDE9CSURnikHwMpxVZaFET9YbSo7v1n0g0yORHposmGdXLN+WwkkZmrYXGMnAegSykfKL94qsMLoO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWDEqbFhhoddOb7r9M/F9tC4QpgWLxpEREfG0bkO7Bc=;
 b=AfPBrCdLno4R6iM4eqEpVCTFXHicGVa2pqQVJtklfkmKLU9nB613ufroxOmpEd/zMPpzz6spA6EyEEPI4CTXyLchoEp+SCt/u2yl92BXAlSYTlI7VZ/UDw0lBvN5gK7u4CiGMMAtstslUXqF/mzWRRp5WYUCg81pChqLH7YzPKt/phXhzcWbKc/gxk5s3niLPryrKzkdKvI61hE/iFM+jlZGDA4280i2C25jgR7Aml3MacJfZetZ0NrdXUWk5YOYl4CoGDUBaRxHnldvftS1Y3/NGoodydV0nSg1D/IJrcRvUyGSECzaNAeisKEtLLu6uZc7AdvRSBxGH7wprjoZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWDEqbFhhoddOb7r9M/F9tC4QpgWLxpEREfG0bkO7Bc=;
 b=QbSQNEru8vxORSX8ACuyn3WcUa5jGHtjyaC+oKKn+NJOCvzLmqE1wktrGu+lXkVWbSRGavrG57tcpreqnNcBu4SmQvHis/PcpvTSe7hUS/X+I39U3D3uex/ho9GvNnf2r3EeVEsCzL6cXpOEGun9spETgZY3Ss6SGoUoK+URTZQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3894.eurprd08.prod.outlook.com (2603:10a6:20b:90::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:36:40 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:36:40 +0000
Subject: Re: [PATCH v7 35/47] commit: Deal with filters
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-36-mreitz@redhat.com>
 <1aa26d4f-c15f-bc68-f71a-341b6a391ce6@virtuozzo.com>
Message-ID: <12282dc6-cdda-71bf-5cb6-3d74918e23f9@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:36:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1aa26d4f-c15f-bc68-f71a-341b6a391ce6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0053.eurprd03.prod.outlook.com (2603:10a6:208::30)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR03CA0053.eurprd03.prod.outlook.com (2603:10a6:208::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 10:36:38 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d855e68-629b-405e-c7a4-08d82fbd7336
X-MS-TrafficTypeDiagnostic: AM6PR08MB3894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3894DE9038C9E23D641CAFAEF4770@AM6PR08MB3894.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6s46Z5myhkmyWGBUOgMlkGkB7CID+U3zqku7Cr8wsoSg6a/KwsoQBlgdcbeuUmxpvtS6/O/zONskC1Hud3prMgnZfmiVAZMItrngFL9J3qMpi6bsq+sc/JBY+GlrT2eoqmFejpCuVQla/H9sR19WAo2SkwccacHF/3pFhqVw+knBR7Hjcm9XNe2q4NYHneqHEepJMnoC+DgDI0C3WY/NxBRABgZr2jGZB2+wZGhZSe4Tw/6cymHSMZXSOQkUAW25Q5sL/YZJ/3X0kiqXx00dWu8ZnGqrzNPYSnxopd7K1ZiVz0Fx4xbbqbyOVRwZvG8OKluSpE7LiEX2rBgbTqx4qwcyI5nZVNs3PklihyxVaV7LghjV/nOMCOcWXF24mdqrYeZnR3FCW1IzFYoTwAy7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(366004)(26005)(6512007)(478600001)(6506007)(316002)(4326008)(53546011)(86362001)(16526019)(186003)(2616005)(83380400001)(31696002)(44832011)(6486002)(66946007)(31686004)(36756003)(8936002)(956004)(2906002)(54906003)(5660300002)(52116002)(8676002)(66556008)(66476007)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: h5+god33ZONQLxA4xpS3hldrTL1Vo+0JhUtYKTc7CoJgtI2AU7QwYfepjip19wclpAeInVJ7xSde8KnnGRGZ6x28OGXHQHlXA+180/d7qzBNtq6abdk+lkXqFpHzBgJ5LGO5xIOyA0pVa+07VaIN166vV7JJREtmhvxO/ym2UmbCkOC2yiI81Jv3OH0HKWOAfFeiDRDY60+uLcqIYMIiVhpSnbT3cNUhUlsMLeRdi1aNLtVEG9bbeTmGSz/E2zmM2IXMhULgPNJDuBe6O3x33f79yeiUWMh8gvwE831nZeugNb0O33XfVyoad1p2eQKt72ebip5f+PuKwOfXMH1WiWcnZ3gKu6evPOTTwJXrY8P69weZq6NKiaySwqk+ScXy9z7SUdf6JuRwOq0/KDOXDfECtgIZCp2GxVgVw8RytRDV2Z1QTo2nmVfZyU8SQ6RQiNXoXr2suy6RQ/DdoBraGFZC6BPQzBDBdFjWYpMhkGLOzdCxRYMfBSBQegCU5Krn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d855e68-629b-405e-c7a4-08d82fbd7336
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:36:40.2358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0LiTdXg5vj3Ext83ywKFJsCYsgSv03DU3l7+Q4u58s5DXb/0YZbbWxJ6w0vCEYL6oeMGa/uLo9fSodXyxOUUuLBBlJiNc6WgrrexAfnsq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
Received-SPF: pass client-ip=40.107.3.123;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:36:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.07.2020 20:15, Andrey Shinkevich wrote:
> On 25.06.2020 18:22, Max Reitz wrote:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission if the base is smaller than the top).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/block-backend.c          |  9 +++-
>>   block/commit.c                 | 96 +++++++++++++++++++++++++---------
>>   block/monitor/block-hmp-cmds.c |  2 +-
>>   blockdev.c                     |  4 +-
>>   4 files changed, 81 insertions(+), 30 deletions(-)
>>
> ...
>> +    /*
>> +     * Block all nodes between top and base, because they will
>> +     * disappear from the chain after this operation.
>> +     * Note that this assumes that the user is fine with removing all
>> +     * nodes (including R/W filters) between top and base. Assuring
>> +     * this is the responsibility of the interface (i.e. whoever calls
>> +     * commit_start()).
>> +     */
>> +    s->base_overlay = bdrv_find_overlay(top, base);
>> +    assert(s->base_overlay);
>> +
>> +    /*
>> +     * The topmost node with
>> +     * bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base)
>> +     */
>> +    filtered_base = bdrv_cow_bs(s->base_overlay);
>> +    assert(bdrv_skip_filters(filtered_base) == 
>> bdrv_skip_filters(base));
>> +
>> +    /*
>> +     * XXX BLK_PERM_WRITE needs to be allowed so we don't block 
>> ourselves
>> +     * at s->base (if writes are blocked for a node, they are also 
>> blocked
>> +     * for its backing file). The other options would be a second 
>> filter
>> +     * driver above s->base.
>> +     */
>> +    iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
>> +
>> +    for (iter = top; iter != base; iter = 
>> bdrv_filter_or_cow_bs(iter)) {
>> +        if (iter == filtered_base) {
>
>
> The question same to mirroring:
>
> in case of multiple filters, one above another, the permission is 
> extended for the filtered_base only.
>
> Andrey
>

The question has been answered already.

Andrey


>
>> +            /*
>> +             * From here on, all nodes are filters on the base.  This
>> +             * allows us to share BLK_PERM_CONSISTENT_READ.
>> +             */
>> +            iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
>> +        }
>> +
>>           ret = block_job_add_bdrv(&s->common, "intermediate node", 
>> iter, 0,
>> -                                 BLK_PERM_WRITE_UNCHANGED | 
>> BLK_PERM_WRITE,
>> -                                 errp);
>> +                                 iter_shared_perms, errp);
>>           if (ret < 0) {
>>               goto fail;
>>           }
>
> ...
>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>
>
>

