Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E58C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3506C21D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FoA4aEy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3506C21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVi23-0006JC-55
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVi11-0005bf-F3; Thu, 22 Oct 2020 17:20:55 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:51808 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVi0s-0007uE-OB; Thu, 22 Oct 2020 17:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLziVPjC4oVA/KuE43Wvl7Xa3l80mglKsnG6BkQ1w0nIGLPoEu4cVHcekpQ687TFQ3lkzPnJ+fw9LDvskQ1jD5qmvYxJ5uFLq0rlpT0Li4tRe/AdtglP9loX8p51Axlo52UCb6MYtJdYqdyldYKUSBjT/hTcie1d888JUt+jF5IB+Y3fNPzD/7p7KzfgxpVUT/FsoEynAZAx5p7aQvmiPE6rdMCmMK1w0V6c/4wHn139kk3cJjWX1JL9re0EpO2bmaDRmz9rc9nUmjp/8xwQ46i8+RvGF89df9a+/YwncdOvTLc2M4Cv+oUWZgZqJrbZB4EgdtQjlLjz5etKsFXUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfMOR/XmMfUx1YNHQ219b1phx8VF7GcZx9F47an5vtI=;
 b=hsFOl08cJu2uQd7gYbu8mW4P7TFqIELogQB9WFe+ajaL7GPSpnuB5wAERu7BhCJZC2TVSwZ7CtN2Rd2JAH/3vpGsvofDHqKkbPkvp0bjQ4a201vxnDU8ibTxc+PPFJTPwDtkYcwT3EbTqeRCOmrgssAjgByHpUW6KmDzYolwankUsxYYYQpd3ICtO95pynD/WSHI3Ok9gQbu+qhhtI3Cpz9MuhKnvAcwMxbyCCK92Nql9Vzmz6LV6GGoTPURVGiDwfy/p4CR+U23tkQl4uh3gmJmRhHztXWZkpQJ15yUDZ+R0k4tAE7R9dmYzBKFW+cpJCivAVD/nZC7YXFmDntRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfMOR/XmMfUx1YNHQ219b1phx8VF7GcZx9F47an5vtI=;
 b=FoA4aEy2ch2KSyiUqcZ0/ES70jjlB0nTE6tc3oHbmpL+wFQHSkqGArel7oZnPhdC3vn7Rgw4cJDqrJXIaQ0uIIg5zK3q1muKrnueWjNdfPDBJ+8baLtyFPkE7QDIeRPAPqfPFtW7EHmM/GuaPVN3VmRsCC4ulU79jAZThYoqS38=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 22 Oct
 2020 21:20:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 21:20:41 +0000
Subject: Re: [PATCH v2 15/20] iotests: 219: prepare for backup over block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-16-vsementsov@virtuozzo.com>
 <9d29163a-5fe3-f97e-594a-abe5be016310@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a33c6c4a-7524-9924-13e9-4a96354ad2eb@virtuozzo.com>
Date: Fri, 23 Oct 2020 00:20:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <9d29163a-5fe3-f97e-594a-abe5be016310@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Thu, 22 Oct 2020 21:20:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70aedf81-0263-4562-d63a-08d876d05439
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5334E2C2EFC2C5299116C08FC11D0@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb9C95N9pVJEfIcSi2jljrmAIjAr1imDuxejBnWfMgzAk09e91UHgzbmNnKkAcmkolNdknqAWTLVnfu91dtxpL0KY7MgCoD944AHiqV2W/erffORrsJnq0jxwFqwIx6wBbNwwzPCz51kE6BbNSvuKbpMMg2H2DWgkhqo4d0S9TXsIAOFwlhFwnL+gHXJNqMqhg96HXeWed+6KRXw+Eqf5v7zE/zvq1BXxEaqVd3kBDHl5D1lJqAnmgvJftXtZAkOZOX5qsvZ+j0efC9SI8Dl86nkjunISsQpeohC/bJVewQI7w3OcZRVCUtC2o4AnXxk2cIiu8SJiLWjTcGaJxIT7VtWf5PYy5lrd2wRG9abTZd6H35VCqTDi4++NqFrlssU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(346002)(136003)(396003)(36756003)(186003)(31686004)(5660300002)(66556008)(52116002)(8676002)(26005)(8936002)(66476007)(16526019)(4326008)(66946007)(6486002)(107886003)(86362001)(316002)(31696002)(16576012)(53546011)(478600001)(2616005)(2906002)(956004)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XupAJiAWC+/Lv1LPvDpoD5AfaoaUZnlgBoRH2sAIuodb9+EbZZmaac5No0ID3Kgv9S5LzKRJpP5WWBRDJf+Wxc7Af0HIGiDCybhf9yLll43/6lXLsPGeD1n2qNryYKpW0JqSS/WPA0cSEqyP2XVe3pMc/8fjYmqzhmoOVvtvMdxj3rrRE70/yZdyhMl5MojSVgH/hwH3ezxMNZSPzhtAzlHFk/8rMDD87aUorS5XRul3pGANT5Rhq1599TroNseHTdCN+Zx0YlzPAS9G51TC7nK4Tv4D1csL3jWbuyYLLSIPe/ZjF/LWGo9ilpsYGvQrrV/lo4RVW/r7mo9bN2yysCDA2Yyj50iQX8DK1unPt4ndp9R7sbHi1K+FyA1/mAP+mGUIeLGcdP4/Uz5y85rwCyzrMvXdnNc/bDjfTglUgMhpzJqQ8tm22/N50nYMjZYQvPeORnK3ibMrRmm0JPLQhfBRyaYl2b3B87AfHhGq6V8hKjsoz1xRzOM4m31s4q6doVw4TIk8qMCDmJgCLITV6llrSWQ0mW1uxHXmC9rshChAQJIm4Ft8PHciy3kFA6YIvjWxwyAikO9SVtzmw68NDlfypsawy3SecranTc8dMSGKgUdWGugtLAFBFoTj98X1Q3uHAXYBQtEBtjkURwpoaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aedf81-0263-4562-d63a-08d876d05439
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 21:20:41.2770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhVlzEx43/4TLWwKq1iSZNumhc8DqHuIiKaciVT/zuKUuYMpPHLmgeZJPYpF+N0CNHZbVWutiQHZGJg7s6i7Y+RWaLPhVi1kii8HtbQ/dac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 17:20:42
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

23.07.2020 11:35, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> The further change of moving backup to be a on block-copy call will
> 
> -on?
> 
>> make copying chunk-size and cluster-size a separate things. So, even
> 
> s/a/two/
> 
>> with 64k cluster sized qcow2 image, default chunk would be 1M.
>> Test 219 depends on specified chunk-size. Update it for explicit
>> chunk-size for backup as for mirror.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/219 | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
>> index db272c5249..2bbed28f39 100755
>> --- a/tests/qemu-iotests/219
>> +++ b/tests/qemu-iotests/219
>> @@ -203,13 +203,13 @@ with iotests.FilePath('disk.img') as disk_path, \
>>       # but related to this also automatic state transitions like job
>>       # completion), but still get pause points often enough to avoid making this
>>       # test very slow, it's important to have the right ratio between speed and
>> -    # buf_size.
>> +    # copy-chunk-size.
>>       #
>> -    # For backup, buf_size is hard-coded to the source image cluster size (64k),
>> -    # so we'll pick the same for mirror. The slice time, i.e. the granularity
>> -    # of the rate limiting is 100ms. With a speed of 256k per second, we can
>> -    # get four pause points per second. This gives us 250ms per iteration,
>> -    # which should be enough to stay deterministic.
>> +    # Chose 64k copy-chunk-size both for mirror (by buf_size) and backup (by
>> +    # x-max-chunk). The slice time, i.e. the granularity of the rate limiting
>> +    # is 100ms. With a speed of 256k per second, we can get four pause points
>> +    # per second. This gives us 250ms per iteration, which should be enough to
>> +    # stay deterministic.
> 
> Don’t we also have to limit the number of workers to 1 so we actually
> keep 250 ms per iteration instead of just finishing four requests
> immediately, then pausing for a second?

Block-copy rate limiter works good enough: it will not start too much requests.

> 
>>       test_job_lifecycle(vm, 'drive-mirror', has_ready=True, job_args={
>>           'device': 'drive0-node',
>> @@ -226,6 +226,7 @@ with iotests.FilePath('disk.img') as disk_path, \
>>                   'target': copy_path,
>>                   'sync': 'full',
>>                   'speed': 262144,
>> +                'x-max-chunk': 65536,
>>                   'auto-finalize': auto_finalize,
>>                   'auto-dismiss': auto_dismiss,
>>               })
>>
> 
> 


-- 
Best regards,
Vladimir

