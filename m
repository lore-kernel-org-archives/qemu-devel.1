Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B85C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376B22078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O/VXS0Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B22078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6uG-0005C0-83
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kT6s2-00043f-9Q; Thu, 15 Oct 2020 13:16:54 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com
 ([40.107.4.109]:33410 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kT6rx-0004w0-GJ; Thu, 15 Oct 2020 13:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9+EFli7QAb7tba9S+34YFPhlkYI+0SvZ7OFy8Iy6Y0MAhr3ToV2qavIRWdUn/lVhJYwmTtTePerALI9lhoBEc9ca/Iai2b50T2yiYrlNcciYm/lp2+wTAr1kcRZi3LAwDm0C7Mv7Nax3YZ0QX1RqDN4M24PMYHHNE483sTnpFTqeoVqillDpYsa0YYRFna/gU8zkf5O6gzsitAmI6etQtbE9EzhVLJnB29IjeA/NrLa0t0eWlOiJgCj75z3bpy72snakjGT3x9J6SUoluq49HOuDONrDEaNgmJCFImzMatjJZkarXGrP+Uyz8F0BdsGTqhm9T7ltd+maB4V46O18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH8NQeTg2SE+E7KhYYbdv8W0KQYHK9EM8zAqEQhWlrU=;
 b=CAt/7wKnnUfUtV/t71CCKSZB8v4wfm8/pz9GjtIFZvzja+WrKTkQtThplEycXjZpEkPh2G4WVwitc8ZOQUUYjZeIrXDKcinbw5805w+aUEi37GASu4NtmGqX69rUwHh2O2jClaaKcI+AlCTPH8xHZfBUsaEGL+Ei7QMHQYv//yyegcvCm+lJWF/Yl8tijvQ+PLO72g4hi6uDrPAHxLeo11SlZpTCYh0hlqWPA2Z2giTgOT/cs9hjeUqPRYSGJRQNkbrxBTDLogOyaFzWW8QpSxEIWwnOMJ7+ccHZBP9BD8TXLg4ToW9oLX23q06BvVzWiq9qfK2elM8s23Hpsk1DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH8NQeTg2SE+E7KhYYbdv8W0KQYHK9EM8zAqEQhWlrU=;
 b=O/VXS0WppRjkGOMeaOQFgJUI0PfmOnoAMVjTrNviupf5r5G24eMEXyD8f3BbiqkXlNjGiHqvmh0dH5b92uk4QQj5AdxISlqTkCGU5xUX9bZsIFIRxXSen+AKzHzVxBOXSqPAhh2kc/iISb8VF24UrLTBkpITUWCxM0kq2MShvE0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1770.eurprd08.prod.outlook.com (2603:10a6:3:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 15 Oct
 2020 17:16:44 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 17:16:44 +0000
Subject: Re: [PATCH v11 13/13] block: apply COR-filter to block-stream jobs
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
Date: Thu, 15 Oct 2020 20:16:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::17) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Thu, 15 Oct 2020 17:16:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402bfb8b-7df2-46e3-2af2-08d8712e16b5
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB17704C1138C8079EEFBBA059F4020@HE1PR0801MB1770.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23eakZSDboSueOwh72119v3NhehqIclcgVI+J068Q+8ll813oUGCgT2eX2L/ti//fHomPbTKRczTJSkE5da38TPCbb2OZoJMoUxYO3GyaVf76fSqcaaag2KIO8IsV+D/K0TBUxWObwG0h0hIqmUOJgS1s5deLFcyYYN4y5dygq74ASto+i1QBtkhV2SKBdJs5KnyUFy9+WLsPpi0cMgpGmw0XV540JaQPxIWjvBK1ypSO+WeSABfjX1t5GniqJqf+c9G8+CaEPgGkc8eVeTlo3oOVUKI5Ak4cN0Ij9E0li49Ob8Mzcm124qPj1LfShLdXQbKsamX7/lZULBzigkavAe0rVai4uXoG77JmBdgGU43IpRHkJVN6AVM+7R5HK/cVi3PqlXFjyiJTVmY3gG0sI+aHshFuPdn2w9+WbLpR0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39830400003)(366004)(53546011)(52116002)(6486002)(8676002)(36756003)(66946007)(34490700002)(2906002)(186003)(66556008)(66476007)(83380400001)(7416002)(16526019)(4326008)(26005)(2616005)(31686004)(478600001)(107886003)(6506007)(31696002)(6512007)(316002)(44832011)(956004)(5660300002)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 60LqWoIDNI1ScJgU0BFNP9c0vTIh9HsJnj5RSsgp1ly/9uzK+Mn2fgXAWBuP0qipokg/GHsrr1B+CFiM3dMLxZxvPIxJMUtvf62Hx1cLxOTJSg9+NP06+CH1I8V3wl8hMTjPBUSfc6AZZFQvHY34r9iNNtJDsd3f/xBMZTg/+lxb58XHI9/32iZ/uGZCNN6KyVjqaAAsVI0pXB4OWbKJWRbT7r1wkTeVQSCtSvW8xKlpHtQ0bV01hFLiK3q9XFGjy06x8Pmu17YnQQgxr4ZpEznVF7410ou/XcfJnx0tJGEOSD1LtYtv9m5drLHOGWeFpPSMypaE+DJ7rt4+a4LCd+jttIzBiBG7cyhVer6O4Ld7JSCmWVoRwZOpBGiHXEwdkmx4hbEhvsSinxeHSmT428hZOzgauDZ7HseOsj9VAtX5x9lh8MOJOqsjEma3d9G5dTG3yisWV+De/MawtAtLtBSRQhtLyHSMecwPKV/P2l5quG3mtTf3fQX5lvhjXbasBgUc1rTIrFIvPPx1LPYe3/hAfsqF2cHsGQOAgm8bci+GvUDzM00yEF/SIqzCzhva2w6VSaS66v0yR5mOrDlNP59aKWEBBiGvMXSTknyTc8GH/napczhpGAF68aQ6FMqrwWTDn7eF2loztdzNcX5q9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402bfb8b-7df2-46e3-2af2-08d8712e16b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 17:16:43.8660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JO5ipShS7WQkF6Lf0qSlqSprsX+xIBiK1SsQZXknNOKRNkNmNEwBxCIlpoqPT0oJOZ15xRq5CdRs5vgbg31UjPWB2vf3tXIGuTRfRR1xmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1770
Received-SPF: pass client-ip=40.107.4.109;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 13:16:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_LOW=-0.7,
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

On 14.10.2020 19:24, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:

[...]

>> ---
>>   block/stream.c             | 93 +++++++++++++++++++++++++++++-----------------
>>   tests/qemu-iotests/030     | 51 +++----------------------
>>   tests/qemu-iotests/030.out |  4 +-
>>   tests/qemu-iotests/141.out |  2 +-
>>   tests/qemu-iotests/245     | 19 +++++++---
>>   5 files changed, 81 insertions(+), 88 deletions(-)
> 
> Looks like stream_run() could be a bit streamlined now (the allocation
> checking should be unnecessary, unconditionally calling
> stream_populate() should be sufficient), but not necessary now.
> 

That is what I had kept in my mind when I tackled this patch. But there 
is an underwater reef to streamline. Namely, how the block-stream job 
gets known about a long unallocated tail to exit the loop earlier in the 
stream_run(). Shall we return the '-EOF' or another error code from the 
cor_co_preadv_part() to be handled by the stream_run()? Any other 
suggestions, if any, will be appreciated.

>> diff --git a/block/stream.c b/block/stream.c
>> index d3e1812..93564db 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
> 
> [...]

>> +
>> +    cor_filter_bs = bdrv_cor_filter_append(bs, opts, BDRV_O_RDWR, errp);
>> +    if (cor_filter_bs == NULL) {
>> +        goto fail;
>> +    }
>> +
>> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
> 
> Is there a reason why we can’t combine this with the
> bdrv_free_backing_chain() from bs down to above_base?  I mean, the
> effect should be the same, just asking.
> 

The bdrv_freeze_backing_chain(bs, above_base, errp) is called before the 
bdrv_reopen_set_read_only() to keep the backing chain safe during the 
context switch. Then we will want to freeze the 'COR -> TOP BS' link as 
well. Freezing/unfreezing parts is simlier to manage than doing that 
with the whole chain.
If we decide to invoke the bdrv_reopen_set_read_only() after freezing 
the backing chain together with the COR-filter, we will not be able to 
get the 'write' permission on the read-only node.


>> +        bdrv_cor_filter_drop(cor_filter_bs);
>> +        cor_filter_bs = NULL;
>> +        goto fail;
>> +    }
>> +
>> +    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
>> +                         BLK_PERM_CONSISTENT_READ,
>> +                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD,
> 
> Not that I’m an expert on the GRAPH_MOD permission, but why is this
> shared here but not below?  Shouldn’t it be the same in both cases?
> (Same for taking it as a permission.)
> 

When we invoke the block_job_add_bdrv(&s->common, "active node", bs,..) 
below (particularly, we need it to block the operations on the top node, 
bdrv_op_block_all()), we ask for the GRAPH_MOD permission for the top 
node. To allow that, the parent filter node should share that permission 
for the underlying node. Otherwise, we get assertion failed in the 
bdrv_check_update_perm() called from bdrv_replace_node() when we remove 
the filter.

>>                            speed, creation_flags, NULL, NULL, errp);
>>       if (!s) {
>>           goto fail;
>>       }
>>   
>> +    /*
>> +     * Prevent concurrent jobs trying to modify the graph structure here, we
>> +     * already have our own plans. Also don't allow resize as the image size is
>> +     * queried only at the job start and then cached.
>> +     */
>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
>> +        goto fail;
>> +    }
>> +
>>       /* Block all intermediate nodes between bs and base, because they will
>>        * disappear from the chain after this operation. The streaming job reads
>>        * every block only once, assuming that it doesn't change, so forbid writes
> 
> [...]
> 
>> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
>> index e60c832..940e85a 100755
>> --- a/tests/qemu-iotests/245
>> +++ b/tests/qemu-iotests/245
>> @@ -899,17 +899,26 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>>           # make hd1 read-only and block-stream requires it to be read-write
>>           # (Which error message appears depends on whether the stream job is
>>           # already done with copying at this point.)
> 
> Hm.  Let’s look at the set of messages below... [1]
> 
>> -        self.reopen(opts, {},
>> +        # As the COR-filter node is inserted into the backing chain with the
>> +        # 'block-stream' operation, we move the options to their proper nodes.
>> +        opts = hd_opts(1)
> 
> Oh, so this patch changes it so that only the subtree below hd1 is
> reopened, and we don’t have to deal with the filter options.  Got it.
> (I think.)
> 

Yes, that's right.

>> +        opts['backing'] = hd_opts(2)
>> +        opts['backing']['backing'] = None
>> +        self.reopen(opts, {'read-only': True},
>>               ["Can't set node 'hd1' to r/o with copy-on-read enabled",
> 
> [1]
> 
> This isn’t done anymore as of this patch.  So I don’t think this error
> message can still appear.  Will some other message appear in its stead,
> or is it always going to be the second one?
> 

The only second message appears in the test case when I run it on my 
node. So, I will remove the first one as the bdrv_enable_copy_on_read() 
is not called for the top BS on the frozen backing chain anymore.
Also, I will delet the part of the comment:
"(Which error message appears depends on whether the stream job is 
already done with copying at this point.)"

>>                "Cannot make block node read-only, there is a writer on it"])
>>   
>>           # We can't remove hd2 while the stream job is ongoing
>> -        opts['backing']['backing'] = None
>> -        self.reopen(opts, {'backing.read-only': False}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
>> +        opts['backing'] = None
>> +        self.reopen(opts, {'read-only': False},
>> +                    "Cannot change 'backing' link from 'hd1' to 'hd2'")
>>   
>> -        # We can detach hd1 from hd0 because it doesn't affect the stream job
>> +        # We can't detach hd1 from hd0 because there is the COR-filter implicit
>> +        # node in between.
>> +        opts = hd_opts(0)
>>           opts['backing'] = None
>> -        self.reopen(opts)
>> +        self.reopen(opts, {},
>> +                    "Cannot change backing link if 'hd0' has an implicit backing file")
> 
> Does “has an implicit backing file” mean that hd0 has an implicit node
> (the COR filter) as its backing file?  And then reopening isn’t allowed
> because the user supposedly doesn’t know about that implicit node?  If
> so, makes sense.

Yes, it is.

Andrey

> 
> Max
> 
>>   
>>           self.vm.run_job('stream0', auto_finalize = False, auto_dismiss = True)
>>   
>>
> 
> 

