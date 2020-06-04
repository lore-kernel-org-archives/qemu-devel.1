Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAF9206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aq9YONpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAF9206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgkg9-0007LU-KL
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgkfZ-0006qP-7N; Thu, 04 Jun 2020 03:52:09 -0400
Received: from mail-eopbgr50139.outbound.protection.outlook.com
 ([40.107.5.139]:9027 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgkfX-0006Zq-36; Thu, 04 Jun 2020 03:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODkRuXAvjqlR1JIIe01RZCsH3JjQVlGkESWzsSzHM2S28RCphDGs+Aa6cZ4NZS5GY+mIfELXHyQ8cGmwt0ZVWHe4DMvGEW9di0eucQGgj+zKlUaPBCbyHZH0h42W9gMIq3IYDbcY+nvXkWwoKJK/lIMz0KFhdE0YGUBRb3NEDvECs5topXz3rTg78PX6cI8X8aIOrGCn+4b3MRxGjCX4jCFGeM8kmUCLRWUrbOq9rodTIlrPqFAYLfOYWciwU64wJQXWRpDioC2urdy4N+J0LIlQ6uqK48FbkKULtFEQ1yQCJuJi1WOMNjCSKuGfT0+iEMwJORnaK5vn7j0kJ7mV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV85FPsBlOIa7irfSrQrkkIu2z/C0LrG3OGxsICwulA=;
 b=kO4aRn7eunLl6ut5oRg8M4dWK7WJyBmwFwRJbBzuVKNRz2uY1Zs9JsKSR+vVaX+Fx7xIJ23PPGwmnVnDm6uh1t0cxGLxXvb8wv1a96ibD+Agr6fNNcH553a4KajirGKLnT2H0Qdrt6svsx0yIvGZz4GXN41T9kWW85CX3HmX4wIgGNDfKNgZyvrj6IeUoZeE4xFG7i9e8BvX2xZiTeRUYFaQjqFjrKiC/2w4LkEFtQe5cOwEzIU/X0VdnZHxYdcAU7yR1OPJ4aPJd5qUWHz5DYE6iyBhpm95Rd/zgInRu83s/DxgxcuUNv6w5SDxTy1gvjV5+AKsOi0bkVsE+98ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV85FPsBlOIa7irfSrQrkkIu2z/C0LrG3OGxsICwulA=;
 b=aq9YONpVVDksHi8rUYzKPUVFmXcbtedZsPkegxoV1OuO9CUQfiF4X7JvWIXxsKk2XtySntjgyaSdoVxe5fozAABeYuKIG99iIQb9QwqLT0tB26TIe6qjfT6oCSSodRLPwqQUGwErSe1vz6HQLBPU3Oef2/AhphEZ5igNivAUyaM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5413.eurprd08.prod.outlook.com (2603:10a6:20b:10a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 07:52:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:52:02 +0000
Subject: Re: [PATCH v4 4/6] iotests: 194: test also migration of dirty bitmap
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
 <20200521220648.3255-5-vsementsov@virtuozzo.com>
 <8954b780-614c-421a-cca3-992f68d24812@redhat.com>
 <93c99c0a-2c79-c62f-4c38-50c5c23ea4eb@virtuozzo.com>
 <7a9d8094-574f-5622-0624-37982181d0a6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ee39000a-8a35-04af-8e38-c6aeff59dbd6@virtuozzo.com>
Date: Thu, 4 Jun 2020 10:51:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <7a9d8094-574f-5622-0624-37982181d0a6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.190) by
 AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 07:52:01 +0000
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23735413-1552-46e9-94f3-08d8085c2a93
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413D775F5E28CB44A3E8C69C1890@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiZMfJEXaM26NU7GCIIQYPBvYR6RuvGHl2ucUY0qby5bIADT31D+Irex6Bu0bW1SZYa68z1HJmfIc9zHYmgDIewdDqUBVaGhTqdZTKvxEhnJ6MPh7FdsNp8+fqj6zpZx+NXh6VcG07xRRIjM4yP2zubYfuHF4hf1r+YoN2r9oHiInZORceB6Li0fS/wR597paSfe3vlaS3Tysy5nhe773rKyRXjIeur0Juw6IpzbEPLekEXhtXU3XxbyzcIUZH/MRtwi0FnyCWvEGM3PBo7QGcprYSrgrSK+xaaEO1migDDHgNaYSjfzjWthNkGiHGlC+fe07RQBcDHCDkwsgRMbMdBRTivC07f9Raqglnb+VJhzRVtHKM8oQAoeau4UI4pb99lZggnWomXDzbixmzl/lLEQ/ECT0OmUapOtj0uAfVQw/63RtJBPysoKj65SDRBxR6IVdRxtm6OKSYRw1E/ysJjR2G+2h1CTKFnrbKaooBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39840400004)(396003)(186003)(7416002)(966005)(52116002)(6486002)(478600001)(4326008)(2906002)(316002)(16576012)(5660300002)(36756003)(86362001)(83380400001)(31696002)(26005)(66556008)(16526019)(66946007)(31686004)(2616005)(8936002)(8676002)(956004)(66476007)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: x/eUei/eaPFgD42L0NnuQx1XOQrcP5O1tZbrR7aOA4WOvG4pplmHGvedZnk3DgtWFpA3FVSnp9wXegxco6d867ZBZgzlTx2/5pu21+bcR7WiA7/nbIP0W3HLit2FhBV4usMGHQZYlH5LiQBnO5EaZycFAUvs2pZWiF1pVJU/woYjf+ALy6uMFYPeO7vDJz5+fXZcEClapG566ynRhIu+PUH50CWjVZaYKJFEDHDo/XwpHmMvNY5TM2A1vO8W/N/rxi7WK/+KvP5qLausuhqyWKWHqG/mjW/LgiHZsK7Pw7+dHJYt6fSgVschfjRkP7EqxbciK0qFdIAttNc0the0To4n67I1bBQ3xEX0dDwdVd7rXN6GBWQ1y0c0eHqQ04dOTFvm9QUAnKvf34q+st9bIUYqbpWR8pFS6yTaeiXWOhz3xT/dmQ76ReTdsgSPi77Y6rIaAnKqdJfe5A5fpnY7dxQO2JJ1Oom/YrPJQ/b8RUsOHvgKfX6D3TwNM8l45ZhT
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23735413-1552-46e9-94f3-08d8085c2a93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:52:01.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxVPpcw/yNuJDqW2SsUjjX8HmOUL0kJVjRChxDBFmqpm3OZd+pAbA8I0lSI7TyXK2VTTz5FXQ/VDQKlwfCh466NebJRb/Q09ioAK5dG0D9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
Received-SPF: pass client-ip=40.107.5.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 03:52:03
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.06.2020 10:21, Thomas Huth wrote:
> On 03/06/2020 10.06, Vladimir Sementsov-Ogievskiy wrote:
>> 03.06.2020 10:52, Thomas Huth wrote:
>>> On 22/05/2020 00.06, Vladimir Sementsov-Ogievskiy wrote:
>>>> Test that dirty bitmap migration works when we deal with mirror.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>>    tests/qemu-iotests/194     | 14 ++++++++++----
>>>>    tests/qemu-iotests/194.out |  6 ++++++
>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>>    Hi!
>>>
>>> This test broke the iotest in the gitlab CI:
>>>
>>>    https://gitlab.com/huth/qemu/-/jobs/578520599#L3780
>>>
>>> it works again when I revert this commit.
>>>
>>> Could the test be reworked so that it works in CI pipelines, too?
>>> Otherwise, I think it's best if we disable it in the .gitlab-ci.yml
>>> file...
> [...]
>> - Qemu aborted. Not good. Definitely is better to fix it than just
>> exclude the test.. I can't reproduce. Could you provide backtrace from
>> coredump?
> 
> It aborted in block/dirty-bitmap.c, line 295, that's the
> "assert(!bdrv_dirty_bitmap_busy(bitmap));" if I got it right.
> 
> Full backtrace here:
> 
>   https://gitlab.com/huth/qemu/-/jobs/580553686#L3638
> 

Aha, missed it, thanks.

Hm. in 194 iotest we wait for migration finish on source, but not on target. I can assume, that in your setup target shutdown occurs earlier than migration finish, so we have busy bitmap on shutdown.
It's known bug (at least for me :), patch is in list:
[PATCH v2 00/22] Fix error handling during bitmap postcopy
   [..]
   [PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on shutdown  (https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04288.html)
      If target is turned of prior to postcopy finished, target crashes
      because busy bitmaps are found at shutdown.
      Canceling incoming migration helps, as it removes all unfinished (and
      therefore busy) bitmaps.
   [..]


Still, of course iotest 194 should be fixed too, to wait for migration finish on target too, I'll send a patch.

-- 
Best regards,
Vladimir

