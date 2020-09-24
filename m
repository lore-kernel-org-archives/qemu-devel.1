Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8ACC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD56206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ER4QXvtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD56206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVOG-0003fI-3E
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLVNF-0002pg-49; Thu, 24 Sep 2020 13:49:41 -0400
Received: from mail-vi1eur05on2135.outbound.protection.outlook.com
 ([40.107.21.135]:28256 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLVNB-0001uR-Q1; Thu, 24 Sep 2020 13:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJsQ21DuNl2LtwZuCd17xP1aCcpV/aNeo3lITlv/KIH8hwr+aUsieAaIrKevv6Ixjm2o7LboEVNsaHPnS7yYAG7N78zSpvggzGpwN2rbIwpHcsce1AXZdpsmkLfK+F2E22HjrFh9uPmTqMDzQ4N5eKh3ZHOoL45D2mXF1etKS2p+4u4RcK8fqCFSSs1idRN+oP4H27fSH4NLxdK5J14oANAeM19yrqP1MoywdXoy2w4Co3QkjW/AxrDH/3s6UuOQmcbrnnJjceeZ7Hl9bxiDVt9N0y3DOe14kYilaWzqck45owspiKpXZFcI7auhJLcrc2ynBTHI3bIPgim0dmGdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZlGjgv7few4RZ9q6/N7vS33/wmRveLpPNQWjU36wu4=;
 b=ikVsDLBgcRLI+z1H52hT/j701mfUgBSyLv7KRNuMd0l1GijuLYczfumiJOhJ1FUwDFKeN/N2FdW6oMhFA85sAyrhXUjh7+HK8Y93mLEB6XxSIVuU45VrRJY+MjgLLzB2cgXABuLvSmJmAA30Qz77s7MdVLbFO2zmTEX9dWRYVlmqQEMq1R/TUxqBM9KrY9mgBvBXeXqA4J1lFRIQXeZ2TKbh9CN+VI6jweBQLuNooLF9cL07JW8YdOWFar3HHqcNeMn6BGNbPgsPQb0zfkjHQZ6zEEAjxpvQDZ67xDOiFgEMujWlBLmM67pmDDa0jan9EE4KGs/L/Txel+UqZyFssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZlGjgv7few4RZ9q6/N7vS33/wmRveLpPNQWjU36wu4=;
 b=ER4QXvtghuwUgvpld39jPLHGKdZq73bNoQcs+ry9OFTjYXnzr1YxA6BflJACGLnc5wmN2ZHLlEZQ280oB3S0WvnQFhfrdAG2Jpih+aLUdtrzd0AvJcegiHVFjMXcByQ7eo3n3ALVMrp+8fazfj/+IXVQJcpGbYtTzZZxk3qTvRo=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3960.eurprd08.prod.outlook.com (2603:10a6:20b:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 17:49:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 17:49:33 +0000
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
 <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
 <1508198c-d52b-08b3-602f-97ff3e83eaef@virtuozzo.com>
 <9fd6c10b-0d37-30fe-5aad-bc50a0bbdc55@redhat.com>
 <b0481dc9-ff26-25ca-ecb0-ea5c0fb4dc06@virtuozzo.com>
 <f06a1ce5-4ae1-2af3-ab19-61061b8091ec@redhat.com>
 <6388180f-ec96-d0e2-63b7-7308e6ec5bce@virtuozzo.com>
 <9665c33b-c433-77d1-b725-8c5febc16559@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ff7841d4-fde7-3848-7387-8842be8f12b4@virtuozzo.com>
Date: Thu, 24 Sep 2020 20:49:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <9665c33b-c433-77d1-b725-8c5febc16559@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0007.eurprd07.prod.outlook.com
 (2603:10a6:200:42::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM4PR0701CA0007.eurprd07.prod.outlook.com (2603:10a6:200:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.10 via Frontend
 Transport; Thu, 24 Sep 2020 17:49:32 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8679b3e1-1eec-4f6f-e8fe-08d860b231e6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB396074D4149DA6A20A3C2A3BC1390@AM6PR08MB3960.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmX+2n1jjxONcIl1G0pAH8s++DOz1mYrqfAvYhvKozf8kwdyDHvSFx+W42UyEWVK95obxqz+e7tWQbtKoDSafF+msICeUQnB7LgoBCg99/7uPDI6SUVdOiTeyK6ndOwwMcTWaBw5+ktUmBkv8tspgMVkZCzXxFHCMi4LwurGGuuvregManXGdtfSalD7djZFsAOZY50R+MbQ++zjH4qkJLSHyR3B0nzz/eR/pSiwHWu7IJcyvzAAcUpx30f1vgP/o+A2kvM/pNdsJLwZCHWfO3SGOg2sJQJMwXIdmoZ7v3MJESYryOHaydESheeuyG108uebyGelcBQE+zsmxTAi9lMuovnc8UmlVrLQJO2W2472tqPY7Vg/Dg5d+PG0CUBUnc3npf3kARhPB98o33PQ49T++kX6WmEdIi8sZiNKuFP8VTBDJ6LCIJ5ppkRJTETL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(16526019)(107886003)(66946007)(83380400001)(86362001)(478600001)(36756003)(66556008)(31696002)(6486002)(53546011)(52116002)(4326008)(8676002)(8936002)(110136005)(316002)(2616005)(26005)(66476007)(186003)(31686004)(16576012)(5660300002)(956004)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tn1IlFKYYouSJCMx17+wnt1kbbI9VXIC9mAj1xEl45hYIweeeF9G526dBNtw8f8uSAVFaqnWFu9Iz+0fw1vqmxtmEW7XR0ZAFh5UJzYxaSEdsD/Jax8IoUbbK6mevFpOb4LVhNIDPSO2LyOoUflHfpNCXvCjME1qYmLfwPW1kwRQfZuKF8r75UpIA/7CTlqjapNHGhRvULNf+Ra38FdsArNbIYTgWy4wW3v4Ksn6ph2XaCAAUuL8LXu78yIKuo7AD+ZQ/17QFTSYyETb3PL+huA6Y2QYK2entB/DZ1n+sLDi2wU2YxYieVOBePneqKrM0nfRGmlNUjSSzkodBnEbOXer+YGp05+QHDCb/jShI5rjhUVFZ1942V+tEN5Oe+jJS6+aXkLTe4lPjYAuVCA9cp+VmuOMezfUjgLDn+yKy0Q5D4LII0acaF3dMsaLQg2bnwMQGou/WnEpuKzunIhMxueBwuHWik60frc7yWh4RaGFI5clhoo5geIH1DeVkO92WbmdJ/3/C30RrXmTkkb6r3oU/5ca36klkB/MGWXnJ0fk7Kl2ag3XZ3o7RdDf1r0N/q93/SlUVlD3DmvTsIvXEBGaIluQGOW5BslGPpzUDvPzGXRduUD0CTze3J3hVTAe/KQSfT7KRyzzVoDN5yiFXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8679b3e1-1eec-4f6f-e8fe-08d860b231e6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 17:49:33.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpbNDErBWBGLShSaFeddGpKEskjIMStfeHwocanpB3rPUfiqpG3e+DmcAHb8NAtVjBAH5kqg2O/KGRvDIuLyyth/hp4dlG05HmBRBRNoXnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3960
Received-SPF: pass client-ip=40.107.21.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:49:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_LOW=-0.7,
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

24.09.2020 20:40, Andrey Shinkevich wrote:
> On 24.09.2020 20:29, Andrey Shinkevich wrote:
>> On 24.09.2020 18:00, Max Reitz wrote:
>>> On 24.09.20 16:51, Vladimir Sementsov-Ogievskiy wrote:
>>>> 24.09.2020 16:25, Max Reitz wrote:
>>>>> On 23.09.20 16:38, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 17.09.2020 19:09, Andrey Shinkevich wrote:
>>>>>>> On 04.09.2020 14:22, Max Reitz wrote:
>>>>>>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>>>>>>> Provide API for the COR-filter insertion/removal.
>>>>>>> ...
>>>>>>>>> Also, drop the filter child permissions for an inactive state when
>>>>>>>>> the
>>>>>>>>> filter node is being removed.
>>>>>>>> Do we need .active for that?  Shouldn’t it be sufficient to just not
>>>>>>>> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
>>>>>>>> node (i.e. perm == 0 in cor_child_perm())?
>>>>>>>>
>>>>>>>> Of course, using an .active field works, too.  But Vladimir wanted a
>>>>>>>> similar field in the preallocate filter, and there already is in
>>>>>>>> backup-top.  I feel like there shouldn’t be a need for this.
>>>>>>>>
>>>>>>>> .bdrv_child_perm() should generally be able to decide what permissions
>>>>>>>> it needs based on the information it gets.  If every driver needs to
>>>>>>>> keep track of whether it has any parents and feed that information
>>>>>>>> into
>>>>>>>> .bdrv_child_perm() as external state, then something feels wrong.
>>>>>>>>
>>>>>>>> If perm == 0 is not sufficient to rule out any parents, we should just
>>>>>>>> explicitly add a boolean that tells .bdrv_child_perm() whether
>>>>>>>> there are
>>>>>>>> any parents or not – shouldn’t be too difficult.
>>>>>>>
>>>>>>> The issue is that we fail in the bdrv_check_update_perm() with
>>>>>>> ""Conflicts with use by..." if the *nperm = 0 and the *nshared =
>>>>>>> BLK_PERM_ALL are not set before the call to the bdrv_replace_node().
>>>>>>> The filter is still in the backing chain by that moment and has a
>>>>>>> parent with child->perm != 0.
>>>>>>>
>>>>>>> The implementation of  the .bdrv_child_perm()in the given patch is
>>>>>>> similar to one in the block/mirror.c.
>>>>>>>
>>>>>>> How could we resolve the issue at the generic layer?
>>>>>>>
>>>>>>>
>>>>>> The problem is that when we update permissions in bdrv_replace_node, we
>>>>>> consider new placement for "to" node, but old placement for "from" node.
>>>>>> So, during update, we may consider stricter permission requirements for
>>>>>> "from" than needed and they conflict with new "to" permissions.
>>>>>>
>>>>>> We should consider all graph changes for permission update
>>>>>> simultaneously, in same transaction. For this, we need refactor
>>>>>> permission update system to work on queue of nodes instead of simple DFS
>>>>>> recursion. And in the queue all the nodes to update should  be
>>>>>> toplogically sorted. In this way, when we update node N, all its parents
>>>>>> are already updated. And of course, we should make no-perm graph update
>>>>>> before permission update, and rollback no-perm movement if permission
>>>>>> update failed.
>>>>> OK, you’ve convinced me, .active is good enough for now. O:)
>>>>>
>>>>>> And we need topological sort anyway. Consider the following example:
>>>>>>
>>>>>> A -
>>>>>> |  \
>>>>>> |  v
>>>>>> |  B
>>>>>> |  |
>>>>>> v  /
>>>>>> C<-
>>>>>>
>>>>>> A is parent for B and C, B is parent for C.
>>>>>>
>>>>>> Obviously, to update permissions, we should go in order A B C, so, when
>>>>>> we update C, all it's parents permission already updated. But with
>>>>>> current approach (simple recursion) we can update in sequence A C B C (C
>>>>>> is updated twice). On first update of C, we consider old B permissions,
>>>>>> so doing wrong thing. If it succeed, all is OK, on second C update we
>>>>>> will finish with correct graph. But if the wrong thing failed, we break
>>>>>> the whole process for no reason (it's possible that updated B permission
>>>>>> will be less strict, but we will never check it).
>>>>> True.
>>>>>
>>>>>> I'll work on a patch for it.
>>>>> Sounds great, though I fear for the complexity.  I’ll just wait and see
>>>>> for now.
>>>>>
>>>> If you are OK with .active for now, then I think, Andrey can resend with
>>>> .active and I'll dig into permissions in parallel. If Andrey's series
>>>> go first, I'll just drop .active later if my idea works.
>>> Sure, that works for me.
>>>
>>> Max
>>
>>
>> So, I am keeping the filter insert/remove functions in the COR-driver code for now rather than moving them to the block generic layer, aren't I?
>>
>> Andrey
>>
> 
> As a concession, we can invoke .bdrv_insert/remove driver functions within the generic API ones.
> 
> Andrey
> 

No, such handlers will not help I think. Until we improve permission-update system we can't implement good generic insertion code. So, I'd keep the patch as is for now.

-- 
Best regards,
Vladimir

