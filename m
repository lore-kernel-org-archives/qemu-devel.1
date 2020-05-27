Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A50C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5633A207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iUcz9H4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5633A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduMI-0007kK-Jm
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jduLH-0006xw-B6; Wed, 27 May 2020 07:35:27 -0400
Received: from mail-eopbgr140118.outbound.protection.outlook.com
 ([40.107.14.118]:25860 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jduLF-0005tn-BI; Wed, 27 May 2020 07:35:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLRNSErsJ9cu05zqieFZVXocI+3QSV6Qn0rXfJYSmTEF93zm7n81BtH4fe4Y2NbmsnWggHkDnyPH0BHoyHOjbZuvBnIh4iZ1SLCZFX9NJdT/3rgZ6qQf5BXeF5iD3n8Abgs0mDPtEhJB+xKCtggLnx248tZToHIaeXfsXdeR+xg7TAVUOvilcsqv4igU225f+axugvfQqyTzxiRLmWu+8HE+iNCYZws3vTEY4N4mLMiPcmGq1LcoqOvhSnMkzj5qmHfbJv/ijG/P/3RLVHpi71s/d2pBj0+F+xqFHh28zTGTEbiP2plvJB7kfY5k3VUA2uEH1eKJ9VVYEciPL8/M5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DijwP6UcP/zW9HPHmQCPq7QCysogktLYZDVqB/7pZVM=;
 b=acbDkbxH91PU+2PF3niRTclZpgNtjK5M71q4c++ZpLMmWmQHubsK8Q/xGfaE4REy4hp4JlN5JybrT+hCJUfuDOLHqOsj3MQBUqgI+YehXTxVVv+lHw0jX+fJ6CdwfISaLEYfUpHf7nG3CnSo7j4Y1BEY8ntSFIA/FA5frGTakcm9Mvkudf0pg2Qz+Y7o0NNzwS8k8kdTkyfpaUv1H5Wj4NlY0EdY2lcKWR81YM9makZ2kZc64yO6Fqmo9+sZyKSYHr5iSaHX0dOR6nfCLYK+kX3wIGVp5UhW2Uhd2KVSehPO/Wxn1tyfauDOtjmkOHkLHg+wHS8zWXVXVy8XIt3q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DijwP6UcP/zW9HPHmQCPq7QCysogktLYZDVqB/7pZVM=;
 b=iUcz9H4QR8JveTulh3FBXdlR5GDCi0Q8UDoe4mvFcmG/bXOcbSvzIvwLX6K1i5PhASUnlp4NloPiWvdTjsLZkkP0V4RaXsL3L6G8YfIPOew5jNwnjIC52eN6bB3edzQgIdz6zqxpoN9W01wRcNF4fSdMM1CVu/yctjSZszANhxI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 11:35:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 11:35:22 +0000
Subject: Re: [PATCH v4 4/5] block: drop bdrv_prwv
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
 <20200525100801.13859-5-vsementsov@virtuozzo.com>
 <efe8d83b-6c4c-a919-44bd-8c9dbdde55c6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ae1ed260-e6b9-8ed0-931d-d25c3cdf1796@virtuozzo.com>
Date: Wed, 27 May 2020 14:35:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <efe8d83b-6c4c-a919-44bd-8c9dbdde55c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.148) by
 AM0PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:208:122::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Wed, 27 May 2020 11:35:21 +0000
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e19e10-0e82-4943-903d-08d802320a97
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544871A6CA73EB91ABE7F652C1B10@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiWyRu7a/04zNwPHu5De3RB5JGlxN6kfNZZf1F7EskGjJLWHkpJhJuwsjltkJApPbH93AcPcpZL0lovbWf5lbvuEgPqBc3NMboYWnVyVQim9hRQEJjZT8adBGpkWIHr28d1iqwcGFgFaAMdFklSkvdnyKIaYXLMNoz7aWY0Sru6XfknzM25KvRw7bUDmqup7BrXNwZoKco+QSjVpT7RyFPVw3xTrDEiH5qpw/x1FrTJHM6xCmZZgG6kAOG4ksD4r/lpAPPw0yljuaq+VphZrPzsomyrxdRSBabp1ZWjYKXP4rx++ctrMQn6g0pTYT/EuEI7eqP5jAE9mUpnAZNiAw9jR8euhzCe3Fnied3kZ05uYDJXkD6izBDW4Bbap2VfZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(39840400004)(366004)(346002)(2906002)(66556008)(186003)(6486002)(8676002)(8936002)(31696002)(16526019)(52116002)(66946007)(36756003)(53546011)(86362001)(66476007)(107886003)(478600001)(16576012)(316002)(4326008)(5660300002)(26005)(31686004)(2616005)(956004)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 07RtlOC0GVoo/3MvdhiNivDq1Dj9G6an36WmrnVSjOl0vUoPqMGwz1b+r4V9WRS3xPJBqhJci4BCpuQYb1Qo/m5CnrsBxzzbf07yiW3dOqIWa0om2LvEnNzl6UW8LcpZnmTNYs5zepw25StORpyYaw25JGJX4AcBRjsm3eZHCxv8+sDfrBpwmdUxzMr5FpNismfmQnfVl9DdjiNIHIXh+IjeCNWSJRdtbW6z48f8ScB6TkFKSKlDs3A6ljWk7+7x1tVOhPFEbxH0oJirYK6OxH0CQsUI7gCbYR1rb5RwYJxl1Pxe2HU/t9g+lUgPYuZtvgrUK8gSoF9yJoKUkWK4e6ivvq8iNzJS3t3DhVqdQHyxBn3gWZ4QWHn26Vl5zhls33BX3pGUTtB1vmcDv6PsB0Acc0ZmYheidnK3pp1PjZoO+QIlk9MNZnsm8GElJkVGXSKcGCFrxdWGCzC5ZOrP/w+HC7bU9dy4DQkxqoA13sv09S6O81ZoVMUsqncL6L+J
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e19e10-0e82-4943-903d-08d802320a97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 11:35:22.3345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/MWJoNmQTP0tN4D5+8AkYZINzvtRUF1xGQZqKc1hTFnIYBzPUctNaWiFfaYNJ72MYQJroJiXMiUlQAgaZ2lm4Csd/y4ujojphdBd8lpYz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.14.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 07:35:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.05.2020 00:34, Eric Blake wrote:
> On 5/25/20 5:08 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Now, when we are not more paying extra code for coroutine wrappers,
>> there no more sence in extra indirection layer: bdrv_prwv(). Let's drop
>> it and instead genereate pure bdrv_preadv() and bdrv_pwritev().
> 
> Typos and grammar; I suggest:
> 
> Now that we are not maintaining boilerplate code for coroutine wrappers, there is no more sense in keeping the extra indirection layer of bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv() and bdrv_pwritev().
> 
>>
>> Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
>> success, auto generated functions will instead return zero, as their
>> _co_ prototype. Still, it's simple to make the conversion safe: the
>> only external user of bdrv_pwritev() is test-bdrv-drain, and it is
>> comfortable enough with bdrv_co_pwritev() instead. So prototypes are
>> moved to local block/coroutines.h. Next, the only internal use is
>> bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
>> success.
> 
> Does returning bytes on success buy us anything useful?  We don't allow partial success, so blindly returning 0 on success is no less useful. True, we'd have to audit callers to make sure we aren't doing an inadvertent semantic change.

Not so simple.. Seems we have 151 calls in 23 files:

# git grep -l '\(bdrv_pread\|bdrv_pwrite\)\>' '*.[hc]' | wc -l
23
# git grep '\(bdrv_pread\|bdrv_pwrite\)\>' '*.[hc]' | wc -l
151

Amyway, let it be another series. And such series should probably change most of calls to _co_ variants.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/coroutines.h      | 10 ++++-----
>>   include/block/block.h   |  2 --
>>   block/io.c              | 49 ++++++++---------------------------------
>>   tests/test-bdrv-drain.c |  2 +-
>>   4 files changed, 15 insertions(+), 48 deletions(-)
>>
> 
> At any rate, I think this patch is reasonable.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


-- 
Best regards,
Vladimir

