Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE45C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3386D20747
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u7rnrzYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3386D20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpev-0006m2-Af
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLpeG-0006Iq-6Q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLpeE-0001Jk-Q6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:56:19 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com
 ([40.107.6.118]:65346 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLpeE-0001Il-2i; Tue, 07 Apr 2020 10:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDncmTBYCRcAvjtvz54FTfrAjzM42xqr6Ero1koy68kFZ/tDomfwbFvmReKxZb4YX7fr0jz2uNb2BrC9LgUYmWI+mUEKYNjwRnju8ksM225YW4YAlTzMH6xJKT12k9hTh3nfVHUrLyBRqfB1WHV85d6gQRpX2ZECeT0vfYJ8gIKfaMXceWqocFIpSXscaJTG+3Ag3dpQqVjjsqvM6/DIy2Jq8RVJmedyyk7xOzwOHcyaM4fU5ScQDukGiEtsaywcHUM1QsWd3n2iwW0XXl4sSPZcZgUdTTxGLTcwjI4WKdEq5qk5xURXFeDam5R5pBFlvrEpsQe5fj6/3/o38Aeo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u+aLio+yQJst1uBEGdfJBREhL1iQPfcEua18MVXoas=;
 b=ewSAJX9asvB1qY7VL9JBGay8iY8Jaw5SJ1uJz83jZijHKN+Bu/uYj6YiXmXCQe07j7y1Nk+Qp/u4lqXtqNA1u7+XrxHFrpMelQ8kE1HAsbNyNYv7M7vXX547X7UmLOgS1zv09nxwxfKX3aLSWsbbLHDRMhzdlfPgA9Y0NOlcM4zkFM/pjQAygXZ9K+X5NfJqUe4md9KYwffDprOqcGMISajAoYDdEK4zjURiktuoCA+Sw+qlecQRlwULhYbnNAWkiW2Ec9idZLZRckUvzomslPRNGNzsiHJqtyUwp2dxzr8eAPMj93aKgCEXEI4p8wRN7C+FIMU7HsQM7oNSs7iJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u+aLio+yQJst1uBEGdfJBREhL1iQPfcEua18MVXoas=;
 b=u7rnrzYDFk4j2Oihj6y6hQkUkdWy7XaJ+GU2Mp+P9D8JiTcnBs5r957eAazbtSdMvOmtk72HaJlTZftSdhuacrVzP/zb2DWe3VqaO5C7yNDn4Wg74igWXu58TuuB+3A7FdlJIqRw6xHxx7BCLlFwzIK1nUgHz5vwxPesr56erlk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5413.eurprd08.prod.outlook.com (10.141.173.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 14:56:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 14:56:15 +0000
Subject: Re: [PATCH for-5.0 v3 2/3] block: Increase BB.in_flight for coroutine
 and sync interfaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200407121259.21350-1-kwolf@redhat.com>
 <20200407121259.21350-3-kwolf@redhat.com>
 <2a1985c1-5d36-6537-86f5-e95baaca7416@virtuozzo.com>
 <20200407144212.GG7695@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407175613801
Message-ID: <399cb66a-528e-b92b-546f-a712608bcc14@virtuozzo.com>
Date: Tue, 7 Apr 2020 17:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407144212.GG7695@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6P192CA0020.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19 via Frontend Transport; Tue, 7 Apr 2020 14:56:14 +0000
X-Tagtoolbar-Keys: D20200407175613801
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2617e06-4d9f-4b95-f8c4-08d7db03d229
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413D265727509BE41DA1FB8C1C30@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(39840400004)(346002)(136003)(4326008)(86362001)(6486002)(31686004)(52116002)(36756003)(26005)(478600001)(6916009)(2906002)(81166006)(81156014)(8936002)(16576012)(66946007)(31696002)(66556008)(16526019)(186003)(2616005)(66476007)(956004)(8676002)(316002)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4Ne72HL/gCllex0LtxYGF35bxV+xD0LS9DoFRxYjh+joZj45R1cOcmkS7eUTIf2a6KrmtF3/z+FdSq0EXdyQkSg6GtLFV2n986IrjdkCemctwBNjMrgySsQKIBkztnAgh6A4hDhKz4ZfGBUu9+2sFSY0h9ZO6xwgXCC/CQ6+XVVHnJdsmCDP+0CwGNWg5jBc9OsQN/oTAago22KDt1/p6qRgIo5k9KkjawSysSB5ieDY3iXQHA94jTDxY6TyBvdw3cgWPiJ8C65hPTthJYLQPblQo7opx1t065cAQCe+t65GvrSkvNb7LMcMT7XeP7AI0iIrfKr+GY+Ak+mR/cPdOr4xAR4FubZ2L1a68k8A7J9/IfjWE6px26UgO9wMuL3KlcH+90oRBGUYcMv8eGfRR8D70fUZko4vBXb3nW3dqW0ZDHkf0HgurJXDNYxJ0qM
X-MS-Exchange-AntiSpam-MessageData: EBERu9ix6MjdfW0LNZVrnJs4LtuR1/tLEYvQSCOe3YfuA94qfp4vhnNkx5Xv9lR38uWagMCiZW0fAcSGZBBptPOH6OeyuxxDKjB4Ny8l7KNWDlivE1Y/Co5Ddx3TsLBg+JvIMUjooirBtajkBMtAGA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2617e06-4d9f-4b95-f8c4-08d7db03d229
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 14:56:15.4949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N93OBxho9HKu1JexzS/G6AQhH9oJZqHfQ8RoiGYQjtp4VUtzhkQM3zqwOmE9WRhTtTRg3JzA111LuaDlm3ddTF/TrgxdEuFK65PNbLtLBpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.118
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 17:42, Kevin Wolf wrote:
> Am 07.04.2020 um 16:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 07.04.2020 15:12, Kevin Wolf wrote:
>>> External callers of blk_co_*() and of the synchronous blk_*() functions
>>> don't currently increase the BlockBackend.in_flight counter, but calls
>>> from blk_aio_*() do, so there is an inconsistency whether the counter
>>> has been increased or not.
>>>
>>> This patch moves the actual operations to static functions that can
>>> later know they will always be called with in_flight increased exactly
>>> once, even for external callers using the blk_co_*() coroutine
>>> interfaces.
>>>
>>> If the public blk_co_*() interface is unused, remove it.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> side question:
>>
>> Should we inc/dec in blk_make_zero, blk_truncate?
> 
> I don't think it's necessary. They call into their bdrv_* counterpart
> immediately, so the node-level counter should be enough.
> 

bdrv_make_zero is not one request, it does block_status/pwrite_zeroes in a loop. So drained section may occur during bdrv_make_zero. Possibly, nothing bad in it?

blk_truncate may do coroutine_enter before incrementing node-level counter, which may only schedule it..



-- 
Best regards,
Vladimir

