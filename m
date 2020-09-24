Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF7C4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5452220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TSkG9ESt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5452220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLScG-0006oM-1J
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLSax-0005yT-9R; Thu, 24 Sep 2020 10:51:39 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:34858 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLSar-0007N8-M2; Thu, 24 Sep 2020 10:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz44UfmknESv85l871oa+bb7T3Q0ptndkurLERsweJ6Jmwp7p28tgI9jYQpCSLnjnDqPSQr6H+nGiUKO6vZjuHDnLZIsPso2U47pcoN6a6127ZUJ55ujb5h2uBscjN8x6bBI1iHuOgoxTKZ87HupfpJZzSja3Cal2e/qK4cu9FTkw9JfxDzoAfp+lJg+gCEPE5tJvaZ0Dmx5uSK+PTf+9UeFOi+mHzLiaRIbguOKzNejNZKzhjxJ4gHeHpgD7L6mg8FyREhKjuoLreiKmwWDKQagAvI0svPY7sNBqMnKmN5vKThf4YU8VlyaqcNwgs2WxoRf77eA99X2OZJzIXyamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAOsUhRcLR0EWPPXsfkO/iI4w34y4LeEDEe+Any/Z4c=;
 b=kiOHgMxN5ViKCjk/zFVkFQy/zw2q/PyVMqoKcgp+7lhWTSnMDy5yz/psejSa7D1/ZYsuvFdQWXpPAvk9g5Wh0ltbjtCxnwouY/3nUMXw7HLMwPUArEWtu8EYKHtxKJcFmGES0koRHsOKTgi/oZndWHe2oqS00x3zy00Vm/FZTbouSIEUgAXXq0onPjy2y1xQiJpvmeRjjiXKhvgKdmslOFJJvi2Wu2AJxesWaPg+Q2Y2W8DXZ87ZlwfCxZQArtSxL+/l+dV0e/a7c31MKvEqXbT4HUunS+q8Cyb0yYda/ypdf69/SePmL68qiHOmT0kVxVRkPaE6hchqI4H80Poc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAOsUhRcLR0EWPPXsfkO/iI4w34y4LeEDEe+Any/Z4c=;
 b=TSkG9ESt/H4ubWk4zjRTTRSr5dY5a89LXXnKmcAL9RXQrWjDeuYPM8mH8DpPXvKW3EplBaOwHRbgDjwrb8aKlEmdSePdYvbTz83/tVhf4meEiwUANh187BeSiXF3ClmKSnqNflFi930in/ml3hQeCjhPZOe6mxVZH2tfIIIg8zo=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 14:51:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 14:51:28 +0000
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
 <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
 <1508198c-d52b-08b3-602f-97ff3e83eaef@virtuozzo.com>
 <9fd6c10b-0d37-30fe-5aad-bc50a0bbdc55@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b0481dc9-ff26-25ca-ecb0-ea5c0fb4dc06@virtuozzo.com>
Date: Thu, 24 Sep 2020 17:51:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <9fd6c10b-0d37-30fe-5aad-bc50a0bbdc55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR01CA0120.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 14:51:27 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc28afb3-75b6-4ece-f699-08d86099513e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3224B42BE2F45D4FEF896A62C1390@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7hrRCnRBVVAW2D7LbjL4d3GaCh65tJdDbEJS4uVKAxhVKLT7vnTJVJ456Xk8ynB9CP795r79ZyaWgJ1oA4UkG3tmnM04iR9JdNm2Yv2Gs85MEvo6PqsQlTShzmIvDPAdXx2XNpOe42XMwL5+shgxD4EA9tr8IiVyq5hmgJDdqdxzKpn9C8SgfTgl/sGDu3W+/hadyX/YlfIZD2McXtsoMBK4jl+/JL5gTRaSxFVhmX9vrJg55BM/NESFawpZhEZ1MAtTdzIjX6FcvVKC0shdjtE7KvMEsjycoK6zYKOSXfLBVKKakF+IH5pPOkrIv58YXcbArod9quP5CvCe/WMOjypNT8fCWDBrI4HP/izl1vt/KNSQJHvme/1K8WdwonT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39830400003)(346002)(376002)(136003)(66476007)(66556008)(2616005)(956004)(6486002)(2906002)(8936002)(16576012)(316002)(110136005)(53546011)(107886003)(26005)(31686004)(186003)(16526019)(4326008)(52116002)(478600001)(36756003)(5660300002)(66946007)(86362001)(83380400001)(31696002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ihKJRN2kMRM82RrpDMR9Lv97YcawwiMSA3PWbgsj3SdCcj8FCHE4h2djxS4Y5GFP73mrNyTWMpoj9H7UpjjK8yFeLoXXOq/nMsGLnTAt85M511DmYoqF/h0SS2M9HBBt7ey8u+KLU6ulvAJ6Xa+hGIacr1tthbcn4SoXjWnb/97bs+gDvsoD3w8w/WudiruoVak1iIY94BlU5TztELbsha9sisEnGfaZkOPcbsFxst9pmmnpqEuuRiQ0BsS2vraQIw/GYetRcTx40M/Q6T6xcOcwtW2fbrusfBjiVgraQWDVo2JJ/9C6Cx4uZomo+GEmU7bQ8N0Hvu74khc+8r35X457PmZbHXeymB9FmhCOFPiAS7RYoDlN1zhhHuzYo3O3jrptUDMxPI/K1/GzGRoNwt78CkY60JUUb9vvxf5jS9LTLESrNy5/RLMUBH7E96igSsRbZlPXavkM8DvP9cn/xODu23DaSJMgmIsKocibONH6IGWyU1WvzQJQtIqKTjNzxXFb13xWMXjGxlaaYCOBx2WPwrskFiU1/8fd+RsxhIpuyLAdioi8TZ/ieAV58sATtevn6voUev9tWRIcEpMu377tU52HFpDuw7Liv/YhIcxTuznSwGREvHiSS4J0q8RX17EukRz7GczzICKkFb1JGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28afb3-75b6-4ece-f699-08d86099513e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 14:51:28.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynPEod6OXGleA2jfjp5uvryGFKxmw8n+/JMfXp++egK2AB1lBtr8vkeZVG3U0RkzQuCvppl1JmE6TTJLLkeU6gIcUiCpVjqQBt6nhNGmRvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:51:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
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

24.09.2020 16:25, Max Reitz wrote:
> On 23.09.20 16:38, Vladimir Sementsov-Ogievskiy wrote:
>> 17.09.2020 19:09, Andrey Shinkevich wrote:
>>> On 04.09.2020 14:22, Max Reitz wrote:
>>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>>> Provide API for the COR-filter insertion/removal.
>>> ...
>>>>> Also, drop the filter child permissions for an inactive state when the
>>>>> filter node is being removed.
>>>> Do we need .active for that?  Shouldn’t it be sufficient to just not
>>>> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
>>>> node (i.e. perm == 0 in cor_child_perm())?
>>>>
>>>> Of course, using an .active field works, too.  But Vladimir wanted a
>>>> similar field in the preallocate filter, and there already is in
>>>> backup-top.  I feel like there shouldn’t be a need for this.
>>>>
>>>> .bdrv_child_perm() should generally be able to decide what permissions
>>>> it needs based on the information it gets.  If every driver needs to
>>>> keep track of whether it has any parents and feed that information into
>>>> .bdrv_child_perm() as external state, then something feels wrong.
>>>>
>>>> If perm == 0 is not sufficient to rule out any parents, we should just
>>>> explicitly add a boolean that tells .bdrv_child_perm() whether there are
>>>> any parents or not – shouldn’t be too difficult.
>>>
>>>
>>> The issue is that we fail in the bdrv_check_update_perm() with
>>> ""Conflicts with use by..." if the *nperm = 0 and the *nshared =
>>> BLK_PERM_ALL are not set before the call to the bdrv_replace_node().
>>> The filter is still in the backing chain by that moment and has a
>>> parent with child->perm != 0.
>>>
>>> The implementation of  the .bdrv_child_perm()in the given patch is
>>> similar to one in the block/mirror.c.
>>>
>>> How could we resolve the issue at the generic layer?
>>>
>>>
>>
>> The problem is that when we update permissions in bdrv_replace_node, we
>> consider new placement for "to" node, but old placement for "from" node.
>> So, during update, we may consider stricter permission requirements for
>> "from" than needed and they conflict with new "to" permissions.
>>
>> We should consider all graph changes for permission update
>> simultaneously, in same transaction. For this, we need refactor
>> permission update system to work on queue of nodes instead of simple DFS
>> recursion. And in the queue all the nodes to update should  be
>> toplogically sorted. In this way, when we update node N, all its parents
>> are already updated. And of course, we should make no-perm graph update
>> before permission update, and rollback no-perm movement if permission
>> update failed.
> 
> OK, you’ve convinced me, .active is good enough for now. O:)
> 
>> And we need topological sort anyway. Consider the following example:
>>
>> A -
>> |  \
>> |  v
>> |  B
>> |  |
>> v  /
>> C<-
>>
>> A is parent for B and C, B is parent for C.
>>
>> Obviously, to update permissions, we should go in order A B C, so, when
>> we update C, all it's parents permission already updated. But with
>> current approach (simple recursion) we can update in sequence A C B C (C
>> is updated twice). On first update of C, we consider old B permissions,
>> so doing wrong thing. If it succeed, all is OK, on second C update we
>> will finish with correct graph. But if the wrong thing failed, we break
>> the whole process for no reason (it's possible that updated B permission
>> will be less strict, but we will never check it).
> 
> True.
> 
>> I'll work on a patch for it.
> 
> Sounds great, though I fear for the complexity.  I’ll just wait and see
> for now.
> 

If you are OK with .active for now, then I think, Andrey can resend with
.active and I'll dig into permissions in parallel. If Andrey's series
go first, I'll just drop .active later if my idea works.

-- 
Best regards,
Vladimir

