Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA71C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4DE20659
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nId5TTT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4DE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc6SA-0003dd-Vu
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc6QW-0003Br-OR; Mon, 09 Nov 2020 07:37:40 -0500
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com
 ([40.107.21.122]:23648 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc6QT-00047D-Fv; Mon, 09 Nov 2020 07:37:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wnnh4ikmaLBG/HeFSeeJELWQJ5etsv22E8H6KX1wBDecEJAy57T8FYyc5DaEyyENasqmuks0Lwww0jUXpOi4hKCbR38xiPd0lYWA4T5jNKLRtglzDpIqRVEHqc8InyukrKmoH1YRlVnqfMDr0DyvThmqu9GUTSyRaW9Jr/cClxKJ45RkIUhcDyJgbMJZ05+cp7ooTXmj8CMG7b2hdpmTpEZQKh+TcAXDslUCwu8vEN31Ad4O+FRDBdfPKYmocJM/skip0y1tzSbn9O0OvdVeByjtcVoqBkU/I1oK2g7C4rl3KXt4JXsUpvDXlvKp/PvCaxiq7Ci6uSU5JLlbW04zSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mruZBVR/PIsIbFSYiPWNp9NIEsc07TM4swU/1wi1R4=;
 b=dvlf2myRVlfVojaMAWMPN7IYwYHQPjHjR6BhZbA2hMaPCFh5zvkMloRr8CNuvh500KowJC1sDZbXUh8nJAzGqNwG4KI7UV40z4NzekJrEi/B5a/HIom0n/K3GdU5iQkES+3gWIi3WOt7xdkf1elDHr2poF47McPLkzKxxqMsfwrhkytv1vxoVISNi76R3yrDEX1pOyvLVqFgF9e5Tl7NVp0UhIYU6l91XcvP162ZQ6yvLIvPFti3jFr2owCWbQ5EsGAJhklf7HrjSb1snlDOQ0fpRb3BlTIDU/4Qa8KbJNHOtmDciZ+rsNDRrahGg7emy3RT5OjsV1+zvW7QXoJHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mruZBVR/PIsIbFSYiPWNp9NIEsc07TM4swU/1wi1R4=;
 b=nId5TTT4NZraN1fBNJcKt6hewkUemcDbl1svvmM0XwnoqGX1K0b0oDszJRn49zJ40bSMF+Q9j0xMTiSD/yQqzoLe01fCJhyMvBKfE/9Kxav4MWK/Z7ReOxhV2a+WYi/I3/+odcbuUhTlhpE9OXQL67B4S6wTt7q8UFCJB7Ur6ik=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 12:37:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:37:33 +0000
Subject: Re: [PATCH v2 5/7] block: bdrv_set_perm() drop redundant parameters.
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, den@openvz.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-6-vsementsov@virtuozzo.com>
 <fd9af13f-cb2d-f9ac-dee5-7168be6f04c0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3b189e68-daf1-09e5-a3e5-5068c2b8ace8@virtuozzo.com>
Date: Mon, 9 Nov 2020 15:37:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <fd9af13f-cb2d-f9ac-dee5-7168be6f04c0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR03CA0107.eurprd03.prod.outlook.com
 (2603:10a6:208:69::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR03CA0107.eurprd03.prod.outlook.com (2603:10a6:208:69::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 12:37:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b09bc36a-4cc4-4b81-cd84-08d884ac3b0a
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB525303D786BCEDB56786743BC1EA0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpBJnqVUdbaA8PtivC93UqILnE2CX2sZ0lmBjLbHxLQ9kwvEkFocPKex9yj4gfAZ1r2WXPJrZwmirDtOY+7/wkMVQUYdjmJupKbv02R4mX6awax8hu77Toq2jK0DguGNfQSNqkkpEiPQVsrEPXAPzdL32AnbTJotcylhtWA0f3HPI2HxxiPxiLlzwiDbAgsKvFV86P7hju2TWiyqD0/WhT8WkLWHo3L2LR400adNlAKuZdtnjCrtNiQck/pWG+Wo4pTw94r5VWHzrkpuPwuKFco21ZbL8hbwsGnBAhldZwrmJxDdlPpfAq5n5A0DIwN1/SaC8bXw9AKRkSgsMEtKhSZ1sfyBulLzohWo3h4bVvilWLnn27RMQ0adK6ETLSOv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39840400004)(366004)(396003)(5660300002)(66476007)(31696002)(2906002)(16526019)(186003)(53546011)(4326008)(2616005)(956004)(316002)(16576012)(31686004)(86362001)(36756003)(66946007)(66556008)(26005)(83380400001)(107886003)(6486002)(8676002)(8936002)(478600001)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3fmyFS+6v85sRSCqTjMXZih34If5fLHg3XWQfjW+pKoCJ8FlBlJ2B5FCW1wswd49L68TVjwOagqOkQgRJV3HufB9ISjpO/78SMeEwfG0nQsPWW4oVXpgwNwfltxoKO95c9gqBZP9Y1yB+cXkaCg2X3Gglj9JqYymrD61J6RICB46pP4RvOSdL/58Opy6aLI7Tn4f4P7bxjHfOkiB5K42ZBi5rdHQUg3HxRnLODB1uSW7dlJIMokbqsPb933ZGD9Q92nzar5CF/sdQ4JOrOZUEaC5LcIQrEqpNEWD0z/gZeUEeJf7xWpiOwuyyCyjv6i4SEl1yCBoUDnCBVMp12bjblmlpqojRMYSAhr5ayDRHV4lTxr+Rvpmc66iZMG++/RvoGTlnOPu3qMtpJ1iYaVNexWrj+p52+xmM/HEb2eYKWIK4UaE3bmuPjEEEDpRu3pTrjKVTRxMfE3CJ94yZ9D05dJeF7ajZbV3fBhIm2CZocF3u7WaQdf/psqlm2GvPJgJEzz0BLUrFbhv9RK+iyWnUYQgPDthshxiuyLdSP+ui6aTMIi39rP8ySvMRMcFCe8Ht6ZJCnO9lhVh/Rdx0ddT4O4RkSWhoBrQS2X2U8Q4CQJYJejpWS4nPyKN/nHAMKOOofQeeVdCYZL7ewWfTh1NEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09bc36a-4cc4-4b81-cd84-08d884ac3b0a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:37:33.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9POyj/6SZJoe2iB+5dKLHtW8t/6UdeprLHE/QDt96swI3yOHJY/DORU+n9IR+pn0dTdbuVepDMV1+jDM/en0sLFGz5UW4opcPJ7nRVphfE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.21.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 07:37:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

09.11.2020 15:20, Max Reitz wrote:
> On 06.11.20 13:42, Vladimir Sementsov-Ogievskiy wrote:
>> We should never set permissions other than cumulative permissions of
>> parents. During bdrv_reopen_multiple() we _check_ for synthetic
>> permissions but when we do _set_ the graph is already updated.
>> Add an assertion to bdrv_reopen_multiple(), other cases are more
>> obvious.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c | 29 +++++++++++++++--------------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> (Perhaps bdrv_commit_perm() might be a better name then, but I’m afraid such a name change might be quite invasive (because AFAIR *_set_perm is used quite often).)
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

Thanks for reviewing!

Actually, I plan to split and organize in a similar transactional way graph-update operations:

  - aio context change
  - child replacement
  - permission update

So, we'll have a chance to discuss final names later. I think about prepare/commit/abort too, as it is more common than check/set/abort. Also, check now actually do set permissions in BdrvChild, so it isn't "just check" (and the fact that we should do "abort" after "check" was always a bit odd).

-- 
Best regards,
Vladimir

