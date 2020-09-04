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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8042C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECD92084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="usfs3EjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAp8-0007sA-AL
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kEAnt-0006fx-IQ; Fri, 04 Sep 2020 08:26:53 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com
 ([40.107.3.135]:17646 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kEAnq-00033u-By; Fri, 04 Sep 2020 08:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SusiyCLUbtU/1bcrq1ULToMVS9vqckpu6TFUIB+MEocYn0DHpvW6KUNzQhZvFTZxp4VK+WDPAV+1Xh9Zk/mHHBvXeI7PBBpVFDPhteCSzy59vVymM+fqhPSzJuvuqEHh1qdHEgE4QGWoHanFOiEUW7W2o3Iay6/8U11enH4FMRAeoQlebBqOukGYPcd9i1nUxRnd84xhV6LIT0yevgnsVjcgW6OJtyCJKlm7LeeGCuTHdSAh+kkkIwBtplHOo1ia2SKsk/fDsIInr9t4tzUFrEt3fwI/z9XNbX+mg0vNFKGdHZvqoRo5itxgJ0NJ9VpPKBRsP53satcLx0NUoqL31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyE52T9DnqN1Wa/hkndSH4vmicqoawW/wieBa9tEcpg=;
 b=BohYh5Ny0SbhsUq5VLmwzrWEOej09QoEJnIEmiLYAh63d2fRyp+6zz1buBsW5B6GOa034ZK0yRGHbLSWQZXEdPiAlLlGmRCys8z7PW8aWFYTnG8pYPcSZKcdmqFmBizF7kelnxfHkzR+Ko+oel5mn7pM/nr/auAms3oOHTkymD4DVmvKUbVcFALCfY3XxeDO/olnf8ld7ZS9LFCLGYMN5q9nTA17PNQCkA4nPWibHxAAI4L3xx1UazUApUq/zx1oQ17AUvI8E2rGxmXXwdanDi9i0OLsGSv5cV8HFXdEgVL1IiPW1R5s0BkllMqwSdT9AC1V7gCeKQ1Y7Fe7C8HYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyE52T9DnqN1Wa/hkndSH4vmicqoawW/wieBa9tEcpg=;
 b=usfs3EjTQGlqeC2jSPAaJev1YbQYV+TYUMezUG5Mi+8v4LqvExXOuHrT6tK8oOSRwObAiOqVXbQPKQrtIjXx+ey9/+29E5a/+/mpyooEhTkbFvQBHK4+hJy+Xep6vsC3CAne6/W4omEP7JSTKxCvI6S1lnST471NO5PLn2IuWzw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4785.eurprd08.prod.outlook.com (2603:10a6:20b:d2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 12:26:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 12:26:45 +0000
Subject: Re: [PATCH v8 4/7] copy-on-read: pass base file name to COR driver
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <15dbdc16-8d4d-3830-01af-8cc149ffd79d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <94df17fe-545f-3e08-1189-fbbf311c8326@virtuozzo.com>
Date: Fri, 4 Sep 2020 15:26:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <15dbdc16-8d4d-3830-01af-8cc149ffd79d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.143) by
 AM0PR01CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 12:26:44 +0000
X-Originating-IP: [185.215.60.143]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d67e7dcf-ad31-47d2-2dc1-08d850cdc984
X-MS-TrafficTypeDiagnostic: AM6PR08MB4785:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47851431EA169D3A25F296FEC12D0@AM6PR08MB4785.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vv5ysq4agiNV99mg38cLAKBEGFu7ZbHc20tbN+gnIEi6Kl1+h2uRYQwNkVn5y1o7ZkXD+XJHRcK2f4zUUApcU3ppMpoEkQBMInlTAZ/NYf/7btT0f36jiBJSON/5opIgta/s8tXPvYzA1sAIasrFSEEm3ulDdWbGDOFoKYCovku3Ea28hDlW05RxkOHliJ/WD+ra850hH6zjYLea5YCTEIC9ZorcqTbE/ooArSKIk6QkLHPck4bnM43JnBdqAMyEeavCY9XZfUezfHn54zWl+kc4nUC9Yi86IijxohuU9VDeLF2wCopWP6RcUfiru4K00mZECQa3kBqfoo2yqYu7imo+dtfMt7enmAyYe3SwFZjpsggJfEibjHym44vsODzf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(8936002)(107886003)(36756003)(2616005)(956004)(4326008)(8676002)(66556008)(66946007)(66476007)(478600001)(2906002)(16526019)(26005)(52116002)(86362001)(31686004)(53546011)(186003)(316002)(5660300002)(16576012)(6486002)(31696002)(83380400001)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rXhzE5IPSxVqG9K4xPWHH37C8uGeDTX5ih4gK47xpCT2sobM3lcfnliqU17Gre16jA6SCY/mtb7K8p9r6hIX1mZ5MFt7vxjUYgbe4NuK6NAN2NecZK+0mp5zESy4MUPWwX+YnaKzT0D0LqP7K9cfdExIqn1ovoPYwgLAB/jTPLJ//UWSwGLkgeSqQ2RJh1h3QjpykFrOBsYHghChVshV3Bl6TNY4Y2oAZBYfnvO+ZRpUrUgKLPlQoIdi3S1af5SbzS8A/x/tS4AFtdUzvm8FH2dY3N7UICb3S2B8fzANmUR2a0KkVUFg2twC4nAJkh/rTeOniGCcqQolnOI4IRJUtRsSqb8T/TfLKB0GKyc6ozqUjPrFNZSQHHfRCwNCZKg7fQns0k8qi5vaJ3cgF2MqhBQDxPjM2bYBCu3Z8AEGWGaZydarCg6LakI3S6pr5Wjp9WjN/gAY7YE/7kbHr9Du7+iyCrMoQyRdeV+9v/zCvj+y83+R1CnAVg655daz5S2TqVjRR1GfIqu5PckFdpQpUvSemEiMYDdLu2b/JXosJHWdHUP6F3cnqf5RlwDQ4O7lm4bumuVwF3bS2d7SWkmBYUFKc3Dkruwy77BAsK8P5glX3LvKATHMbXu0ltLqZiIRxvtpTqCKnP75ClzUpXUNgA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67e7dcf-ad31-47d2-2dc1-08d850cdc984
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:26:45.3789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa1V5hdNu2TjT8IH7h+X7PuFYo/HcMxj9CZdttjLAHsmmDovZMlSjHVbKpdDbqDT1W8U3N8eexmGu9tezmnc0hKfeEUitRMwiHPaIKKsrUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4785
Received-SPF: pass client-ip=40.107.3.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:26:46
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

04.09.2020 15:17, Max Reitz wrote:
> On 28.08.20 18:52, Andrey Shinkevich wrote:
>> To limit the guest's COR operations by the base node in the backing
>> chain during stream job, pass the base file name to the copy-on-read
> 
> Does it have to be a filename?  That sounds really bad to me.

Agree, it should be node-name. Filename-based interfaces is a headache.

> 
>> driver. The rest of the functionality will be implemented in the patch
>> that follows.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>   block/copy-on-read.h |  1 +
>>   2 files changed, 41 insertions(+), 1 deletion(-)
> 
> Furthermore, I believe that this option should become an externally
> visible option for the copy-on-read filter (i.e., part of its
> BlockdevOptions) – but that definitely won’t be viable if @base contains
> a filename.
> 
> Can’t we let the stream job invoke bdrv_find_backing_image() to
> translate a filename into a node name that’s then passed to the COR filter?
> 
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index 0ede7aa..1f858bb 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -24,19 +24,45 @@
>>   #include "block/block_int.h"
>>   #include "qemu/module.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "block/copy-on-read.h"
>>   
>>   
>>   typedef struct BDRVStateCOR {
>>       bool active;
>> +    BlockDriverState *base_bs;
>>   } BDRVStateCOR;
>>   
>> +/*
>> + * Non-zero pointers are the caller's responsibility.
>> + */
>> +static BlockDriverState *get_base_by_name(BlockDriverState *bs,
>> +                                          const char *base_name, Error **errp)
>> +{
>> +    BlockDriverState *base_bs = NULL;
>> +    AioContext *aio_context;
>> +
>> +    base_bs = bdrv_find_backing_image(bs, base_name);
>> +    if (base_bs == NULL) {
>> +        error_setg(errp, QERR_BASE_NOT_FOUND, base_name);
>> +        return NULL;
>> +    }
>> +
>> +    aio_context = bdrv_get_aio_context(bs);
>> +    aio_context_acquire(aio_context);
>> +    assert(bdrv_get_aio_context(base_bs) == aio_context);
>> +    aio_context_release(aio_context);
> 
> Er.  OK.  But why?  Isn’t this just guaranteed by the block layer?  I
> don’t think we need an explicit assertion for this, especially if it
> means having to acquire an AioContext.
> 
> Furthermore, I don’t even know why we’d need the AioContext.  On one
> hand, we don’t need to acquire a context just to get it or compare it;
> on the other, this I would have thought that .bdrv_open() runs in the
> BDS’s AioContext anyway (or the caller already has it acquired at least).
> 
> Max
> 


-- 
Best regards,
Vladimir

