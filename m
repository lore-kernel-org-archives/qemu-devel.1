Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35911C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB34206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZKXngLZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB34206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRPX-000055-2m
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kTRJ9-0001xN-83; Fri, 16 Oct 2020 11:06:15 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com
 ([40.107.8.127]:9383 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kTRJ6-0005vJ-Gq; Fri, 16 Oct 2020 11:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLD9Eq3k3QeYQ8y+kXZrdzviC46gIDDbCgbliwblQlSrURA4wawdXEnKRD487mvMNJsKrXE0mSVqdNi/MYoUm3KGRFU+HNf9xKfyzb71QoioSbo+D7IvFDWnoWcDjVpVR/xf6139W4ImYUG5ducvbhhVchixIZM4tLjbVgMmkIJO3kpDEZiLoElpMLUvmExzuZ8/ir9DYWc3TbpdoDot3or++DEaEiAODGk2qbcRHBCVbFSU4bvanHq9UXet3xGKUkZhxvs06fu/PRhs3cFgwx3P2Kl1ONfKalpNKtSfjQRfqQP1R2ZWgooSlbH/RMbQWMziRPK5fR8q457ylNEUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA60jf9nxB5COiEQph4SzpPtqK2Cc9cDhy0HeNEmQfU=;
 b=k5j2u4FYqXJ4uXhBbBpoabx7PEBj1rsqQcNeQinBeeApoHramcEoZoLLCzXaLnnDYSxg7+4kkKCB5NYg6NyO94F0cqAuJlmYuleK6PTZt7Lpg6LaOw8XkNNNNCGb5iKXGwiiv2i14hZcEyp15IQy8U4vqMHurr0iaiTMz398UfWNU6z3nV150qBDPqTUnV8sR27EnYX1uPcsHikLIF3FzqVdcCbYR/8uldqgs+hTiywQLTRcugH4KGQddzwtyuCQiofAvmlTokt5C7nmpGGVNOirorOy/2NOOihBuU9JTVH4awY3EX2yGjmJB4QGlUcS50dmYO7190zoaFh7wZpy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA60jf9nxB5COiEQph4SzpPtqK2Cc9cDhy0HeNEmQfU=;
 b=ZKXngLZxVyFvwRR/i+jYDrtFtOP0KH5vJ3/Vp+x9vXiHAtdxhIy+eS9gzfrRsCpLkVtKO+KbyeOVeoJeqyXNPMUzFRPPQDanFvm36yTtIe2J6ugUTrqI2WRSaFsGqI+ZlMSgZFNzZtrvNlqXzBWzC9zjpk6PPsq7YiiJS6nBmlw=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2779.eurprd08.prod.outlook.com (2603:10a6:7:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Fri, 16 Oct
 2020 15:06:07 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 15:06:07 +0000
Subject: Re: [PATCH v11 13/13] block: apply COR-filter to block-stream jobs
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
 <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
Message-ID: <ac6a8865-9dca-681d-ec5a-a1d5c217a18f@virtuozzo.com>
Date: Fri, 16 Oct 2020 18:06:03 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Fri, 16 Oct 2020 15:06:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb482411-abfb-47ad-2c54-08d871e501ca
X-MS-TrafficTypeDiagnostic: HE1PR08MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB27798676950FEE6D92F78EFEF4030@HE1PR08MB2779.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JibCXlaNjtzxth3aF7NE8uD/+BvnKtSrhvwzafvl2cCroQykV4iEFz+6BejlczQ92zqGyOwwnooAx9Y98ZtvhQi1No6NXsLnGyGsYd/c2VXyQdv3C63e9A+SWRyFviUJM09YwAWVgYueYtESzHUS3BZS+v7rJOD0JSRqpQTYMqdSQPjDdfxC9V+2iLnn+Z8yXkRcxkyPNwt4XHzKgITZdf8damsM2YoNPtB2ayYrokZMPFP8xbGzLh13RSWTh0iLuRQLU9gaqwcmNN41ZwaHZseNkL77JmrCoKC4vSGlvGVPVRMH+PlRssiKlvocg4CmIoXlpPAeT1t1mxgp/hQkseq37BnMAKbndl/lo2ANLnTL7Dxg5fvgXpIWmWFR3hbims5mucCtthzQp3uqdSJFGZ50kszeZQcSLgMRJg4JmtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39830400003)(366004)(36756003)(6512007)(44832011)(52116002)(6486002)(31686004)(53546011)(8936002)(6506007)(8676002)(31696002)(86362001)(2906002)(83380400001)(478600001)(66556008)(66476007)(66946007)(107886003)(5660300002)(34490700002)(2616005)(956004)(186003)(7416002)(26005)(16526019)(316002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TBndeE1sGX2TDCYsa7vOPqtMdI0/KuVlX6ZXM/GF4pccmSS3Rkhr+cvAKIDlmw/Ag9sG4rc2bd/gugO2EzKLrguFyX1joMipQQINOarCedGya2iP7z7o2ZVeCWKJ0Mv9/HLAqOgFYiKso8VOFuQhyZ0XY9bK98+FD+WLab/9V8jpbQoGkYtMBW/ocuCEb/+CmUEC31iZVb0ONNu7z3MUnhQCHzNqrNPgCVR821Vtz47X5gOri03PQ4E/iJq8LiiiEP27PHS7kWvFTDYMRkE/aRioBNFN7ZQHJbdT8rZai0RtaqBpJ7X+3Oxl6HqI/Eb9MRG3uRxvQFylGuvYFPMStFgrfi9uZw2pZnFigRUCCYmWoVOL3drXBu8haeRdY/LCkGWPLVq77KF/Dt9fka7WDpDOsTO20jAdVOkGnZzO+KFzfLijaXhZ/vhPny37WP97RmZNeaLJIyEYtxhaHD+p10e7HSGfNV7rceSH7oX6sCXJvg7M86/qGBnr3hQSRADuIwXHUf8nmeVr6I2rw7EEjnmJFG9afzd/kiG4vqZKLxgCDaP8SPZM3bhZmBwBebgAS9klDQJizRSG5QmahGBVh1UzeIz3aKrrbb5h6sbJfrfvYzG4/d5TSTEnSXFHmAHx9HzEp3PYMm/IC7TqxdbdCA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb482411-abfb-47ad-2c54-08d871e501ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 15:06:06.9918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzUxLvaK8HAvydj6tcnUteeXM0yf4Bdyk9qImud9lMkcZKeuHYMxh4aJnC38wHW+Q6N7YEQfbO1jEODTkgoCaYIPDofLCm9iodnvSgmw3Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2779
Received-SPF: pass client-ip=40.107.8.127;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 11:06:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 15.10.2020 20:16, Andrey Shinkevich wrote:
> On 14.10.2020 19:24, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
> 
> [...]
> 
>>> ---
>>>   block/stream.c             | 93 
>>> +++++++++++++++++++++++++++++-----------------
>>>   tests/qemu-iotests/030     | 51 +++----------------------
>>>   tests/qemu-iotests/030.out |  4 +-
>>>   tests/qemu-iotests/141.out |  2 +-
>>>   tests/qemu-iotests/245     | 19 +++++++---
>>>   5 files changed, 81 insertions(+), 88 deletions(-)
>>
>> Looks like stream_run() could be a bit streamlined now (the allocation
>> checking should be unnecessary, unconditionally calling
>> stream_populate() should be sufficient), but not necessary now.
>>
> 
> That is what I had kept in my mind when I tackled this patch. But there 
> is an underwater reef to streamline. Namely, how the block-stream job 
> gets known about a long unallocated tail to exit the loop earlier in the 
> stream_run(). Shall we return the '-EOF' or another error code from the 
> cor_co_preadv_part() to be handled by the stream_run()? Any other 
> suggestions, if any, will be appreciated.
> 
>>> diff --git a/block/stream.c b/block/stream.c
>>> index d3e1812..93564db 100644
>>> --- a/block/stream.c
>>> +++ b/block/stream.c
>>
>> [...]
> 
>>> +
>>> +    cor_filter_bs = bdrv_cor_filter_append(bs, opts, BDRV_O_RDWR, 
>>> errp);
>>> +    if (cor_filter_bs == NULL) {
>>> +        goto fail;
>>> +    }
>>> +
>>> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
>>
>> Is there a reason why we can’t combine this with the
>> bdrv_free_backing_chain() from bs down to above_base?  I mean, the
>> effect should be the same, just asking.
>>
> 
> The bdrv_freeze_backing_chain(bs, above_base, errp) is called before the 
> bdrv_reopen_set_read_only() to keep the backing chain safe during the 
> context switch. Then we will want to freeze the 'COR -> TOP BS' link as 
> well. Freezing/unfreezing parts is simlier to manage than doing that 
> with the whole chain.
> If we decide to invoke the bdrv_reopen_set_read_only() after freezing 
> the backing chain together with the COR-filter, we will not be able to 
> get the 'write' permission on the read-only node.
> 
> 
>>> +        bdrv_cor_filter_drop(cor_filter_bs);
>>> +        cor_filter_bs = NULL;
>>> +        goto fail;
>>> +    }
>>> +
>>> +    s = block_job_create(job_id, &stream_job_driver, NULL, 
>>> cor_filter_bs,
>>> +                         BLK_PERM_CONSISTENT_READ,
>>> +                         basic_flags | BLK_PERM_WRITE | 
>>> BLK_PERM_GRAPH_MOD,
>>
>> Not that I’m an expert on the GRAPH_MOD permission, but why is this
>> shared here but not below?  Shouldn’t it be the same in both cases?
>> (Same for taking it as a permission.)
>>
> 
> When we invoke the block_job_add_bdrv(&s->common, "active node", bs,..) 
> below (particularly, we need it to block the operations on the top node, 
> bdrv_op_block_all()), we ask for the GRAPH_MOD permission for the top 
> node. To allow that, the parent filter node should share that permission 
> for the underlying node. Otherwise, we get assertion failed in the 
> bdrv_check_update_perm() called from bdrv_replace_node() when we remove 
> the filter.
> 

I will add my comments above to the code.

Andrey


[...]

