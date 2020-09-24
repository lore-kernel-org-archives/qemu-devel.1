Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAD6206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qp0PbJqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAD6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVH8-0008RI-Pd
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kLVEz-0007i1-9n; Thu, 24 Sep 2020 13:41:09 -0400
Received: from mail-eopbgr150094.outbound.protection.outlook.com
 ([40.107.15.94]:47430 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kLVEx-00012K-1Q; Thu, 24 Sep 2020 13:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhGeOGnp4RqX1EKaw3HqGMflUos6jiOivMAit2s4xt7t2NtpwIbo6/4197Xvvj0RP0Cqw6bXt0kKiZ0PBkfc9WxJtCGNP94417C6/P13ugsb96nOmNqPAzwi/YVLGVznAIgFdt0DG59/nvQdu5YsZJS56sTu9AJaSmke88C+KNcAXDLvxJGUDiTKZHilSfSH9uOA0d+Zj3sr5iUVqVabmcEk0c/WQjSCMAiyaRiIQSXC3LUpWkunTNGONtQJ4ghgGAl3VXtcnDG+HNJYgN5R1yN7V0yJ+VWv6TzqYrnvEcTOkInFHjeS+RlitQ3dJSfpaY8AGZuNz8Q0vy3K1CeXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsWE2NfPShY8U3Hafp1TI9eG3+lVpokQp5XW7NudhAQ=;
 b=DKw8kRs2NhFrUONgpjpHidMGuydoUkxq2dugkLy5oZxJH2F1PXOIjYFSFHxGZyA0D8Euz0pfLkBVUzM6UMIZqKM1eVjOKWu03oWy9I+B/WKJlapfs5fqSk8Z6GpV5dj3MIJ5Qeg7t/PveOh2aB1mOhjQ7SZ26q9k+hGAGqokX4AiLTtLoamMo9uy4E5BFLKge/B4nOcrCbnzPxai8ueeLLrmTjqMQflVCRGw4/dkS3pxE1UvoIiG2zarMZgQi16xqsl1FtOV5rl/0RpWTSRdI+krIyY8cZatioGYtm8VZBzHHNeXTyERvvcNvi1+Ya/0d2DSSG2fMVy31Z7yn44F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsWE2NfPShY8U3Hafp1TI9eG3+lVpokQp5XW7NudhAQ=;
 b=Qp0PbJqTg2ZQbWJNEyFssDtvQVgjfRsBsMSqNox1Q9Kpjj7TKJpeyZDVZvS8+/Cn+iHgkT5vEzpxxaOuwBLLmryzsRob4u5Rf6DgqX614NPobRiOiCgYw7XkyQ6FKQeujxZ6eEp1tkMumIMWtyocQ47gMAgFlWxuh0pbDfesM9k=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB2010.eurprd08.prod.outlook.com (2603:10a6:3:4b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 17:41:02 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 17:41:02 +0000
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
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
Message-ID: <9665c33b-c433-77d1-b725-8c5febc16559@virtuozzo.com>
Date: Thu, 24 Sep 2020 20:40:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <6388180f-ec96-d0e2-63b7-7308e6ec5bce@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 17:41:00 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb6d0ef-da76-450a-b290-08d860b10137
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2010D0FEB6D15C56CC69F321F4390@HE1PR0801MB2010.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NG++HT5Fu1FOBK74lLG3rh8vAzuoOymEoFRwKydd5QiP+fExp9776qgv7DHRQI/owWjJcqYSX2jeIr6DY4seYHor/OpBrKsmFRjfxF2r7f5Q6IP4jGfKWsEBxorQ/Pg2gBtu0F1G1s1yUJXkIluUOaFTTNhTaAU56mSOPmzONFnJ8lufjlLaOoVp/1cyU49aWIL51oiIPq7i3o1fe0FANedxUn1/2RqpS2URXCEZ0audTxtrjnzhkFmwGgeOOjLuySI4SmCM/ze9JQe9E30ex+m6rV90wx/d4wAMhXDzH4C9PlzeDwVY3Pib7SVCKxHftb39R3HcACNnvHuJL0FkRXsqT8Saqia7ACOAJBpocFR0YmHv00cmnOL/IlhCQeK0y/kV3oybQ1rJU0wbVrnOoIo4llv33EW+Zrj8HGDK6qsDut0vyw+RsaBNZs3KqMRS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(366004)(346002)(136003)(396003)(31686004)(36756003)(44832011)(316002)(6506007)(53546011)(4326008)(186003)(86362001)(31696002)(2906002)(478600001)(5660300002)(52116002)(83380400001)(110136005)(8936002)(26005)(16526019)(107886003)(66556008)(66946007)(66476007)(8676002)(956004)(6512007)(6486002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S2Hp+NphiLyzq2aCSzz12+uz1udGysnSjeGuHwZodSObeA0FYaxJm3JLJVE93fhVmkvw7a94uyI89nP89/fc9CzgEKcTg5zQpwmwn6RpszTT9gAcRzJTB0AhWSO+oKFF8ln6hkXbh/ANCyMjxEv8q31t7D5vwwrMS0W4qk4sAOSe+MThxIDkLeP/msuFsk0nPkqoymhPFxIJ0oyJDzb8Wuydypugw3vSnxh8eBZqhLAJdl3M5TkdqwnbJKANMeSFYbVXjKkYvd/cgywrWoLYnCkH89cTt0SfbzijvG3G5uBa2I2ExeuC5jFziI9IlelNGyIyGrtgJkW0hg+jzcTUdryqFFJImz2OZ/XpVKGQzBTHqQICAO/BC3e9nSkCb2u5scT1HIHIvC1RdbhLpFKO4JpLOQSH8YwJLP3sbcMXONXfW3aGdYS8byQbs6oarwfzDkFuh5xRS/Me4ijnuStWsAWifa+9SWOnDnEtjfyK4R41TGHePTukS2hyc7qGtxmlweZvxC+9gBHh8Wu2bkxZcOwI2dHdyoHgJbwkR1yt1OmmjUyZbSdjMJKeNbOkX95LyX+0FYV6QAbq5R8J2KgNX3UIAC0gJWMGl7mwYtQvlPZXQQzGIjbU+cbLCQ7Om+HuiGi6gFvbCE6hvUdVnVwKJg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6d0ef-da76-450a-b290-08d860b10137
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 17:41:02.1009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyfUtlEUowb9vDp8sST2WJvNM+UwgLZC/QAkHxDWiNN50VtiWEg3Voa5I+zu0OvrhU6XJMPYK//JzKl6SPsgmkTRkBh37+83hR4CQ7KhQRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2010
Received-SPF: pass client-ip=40.107.15.94;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:41:04
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

On 24.09.2020 20:29, Andrey Shinkevich wrote:
> On 24.09.2020 18:00, Max Reitz wrote:
>> On 24.09.20 16:51, Vladimir Sementsov-Ogievskiy wrote:
>>> 24.09.2020 16:25, Max Reitz wrote:
>>>> On 23.09.20 16:38, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 17.09.2020 19:09, Andrey Shinkevich wrote:
>>>>>> On 04.09.2020 14:22, Max Reitz wrote:
>>>>>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>>>>>> Provide API for the COR-filter insertion/removal.
>>>>>> ...
>>>>>>>> Also, drop the filter child permissions for an inactive state when
>>>>>>>> the
>>>>>>>> filter node is being removed.
>>>>>>> Do we need .active for that?  Shouldn’t it be sufficient to just 
>>>>>>> not
>>>>>>> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken 
>>>>>>> on the
>>>>>>> node (i.e. perm == 0 in cor_child_perm())?
>>>>>>>
>>>>>>> Of course, using an .active field works, too.  But Vladimir 
>>>>>>> wanted a
>>>>>>> similar field in the preallocate filter, and there already is in
>>>>>>> backup-top.  I feel like there shouldn’t be a need for this.
>>>>>>>
>>>>>>> .bdrv_child_perm() should generally be able to decide what 
>>>>>>> permissions
>>>>>>> it needs based on the information it gets.  If every driver 
>>>>>>> needs to
>>>>>>> keep track of whether it has any parents and feed that information
>>>>>>> into
>>>>>>> .bdrv_child_perm() as external state, then something feels wrong.
>>>>>>>
>>>>>>> If perm == 0 is not sufficient to rule out any parents, we 
>>>>>>> should just
>>>>>>> explicitly add a boolean that tells .bdrv_child_perm() whether
>>>>>>> there are
>>>>>>> any parents or not – shouldn’t be too difficult.
>>>>>>
>>>>>> The issue is that we fail in the bdrv_check_update_perm() with
>>>>>> ""Conflicts with use by..." if the *nperm = 0 and the *nshared =
>>>>>> BLK_PERM_ALL are not set before the call to the bdrv_replace_node().
>>>>>> The filter is still in the backing chain by that moment and has a
>>>>>> parent with child->perm != 0.
>>>>>>
>>>>>> The implementation of  the .bdrv_child_perm()in the given patch is
>>>>>> similar to one in the block/mirror.c.
>>>>>>
>>>>>> How could we resolve the issue at the generic layer?
>>>>>>
>>>>>>
>>>>> The problem is that when we update permissions in 
>>>>> bdrv_replace_node, we
>>>>> consider new placement for "to" node, but old placement for "from" 
>>>>> node.
>>>>> So, during update, we may consider stricter permission 
>>>>> requirements for
>>>>> "from" than needed and they conflict with new "to" permissions.
>>>>>
>>>>> We should consider all graph changes for permission update
>>>>> simultaneously, in same transaction. For this, we need refactor
>>>>> permission update system to work on queue of nodes instead of 
>>>>> simple DFS
>>>>> recursion. And in the queue all the nodes to update should  be
>>>>> toplogically sorted. In this way, when we update node N, all its 
>>>>> parents
>>>>> are already updated. And of course, we should make no-perm graph 
>>>>> update
>>>>> before permission update, and rollback no-perm movement if permission
>>>>> update failed.
>>>> OK, you’ve convinced me, .active is good enough for now. O:)
>>>>
>>>>> And we need topological sort anyway. Consider the following example:
>>>>>
>>>>> A -
>>>>> |  \
>>>>> |  v
>>>>> |  B
>>>>> |  |
>>>>> v  /
>>>>> C<-
>>>>>
>>>>> A is parent for B and C, B is parent for C.
>>>>>
>>>>> Obviously, to update permissions, we should go in order A B C, so, 
>>>>> when
>>>>> we update C, all it's parents permission already updated. But with
>>>>> current approach (simple recursion) we can update in sequence A C 
>>>>> B C (C
>>>>> is updated twice). On first update of C, we consider old B 
>>>>> permissions,
>>>>> so doing wrong thing. If it succeed, all is OK, on second C update we
>>>>> will finish with correct graph. But if the wrong thing failed, we 
>>>>> break
>>>>> the whole process for no reason (it's possible that updated B 
>>>>> permission
>>>>> will be less strict, but we will never check it).
>>>> True.
>>>>
>>>>> I'll work on a patch for it.
>>>> Sounds great, though I fear for the complexity.  I’ll just wait and 
>>>> see
>>>> for now.
>>>>
>>> If you are OK with .active for now, then I think, Andrey can resend 
>>> with
>>> .active and I'll dig into permissions in parallel. If Andrey's series
>>> go first, I'll just drop .active later if my idea works.
>> Sure, that works for me.
>>
>> Max
>
>
> So, I am keeping the filter insert/remove functions in the COR-driver 
> code for now rather than moving them to the block generic layer, 
> aren't I?
>
> Andrey
>

As a concession, we can invoke .bdrv_insert/remove driver functions 
within the generic API ones.

Andrey


