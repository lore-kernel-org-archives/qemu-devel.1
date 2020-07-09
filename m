Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF742C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBC320674
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nzP/RaDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBC320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSUl-0005nj-Pb
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSTe-0004k7-71; Thu, 09 Jul 2020 05:04:22 -0400
Received: from mail-db8eur05on2121.outbound.protection.outlook.com
 ([40.107.20.121]:17726 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSTa-0005Qt-6z; Thu, 09 Jul 2020 05:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/OeaqGwEEwwKgr98U5/V4o97HzKeN67N/2R6MyWPA8M3H9ja3DId+gATJHR8wBFk+AxYiQQFeAzSq3PZqyjFP9N8aYeLNsG5iJnu/AfJu8DKAW1VDsmJMRqQQkFF3r2VP/lPvD6hyGy4879165HxrTn6L93vje9cNukWTQIZPv4ILkny3gIHUHO3C13kqLbPKFKgU/8ZzQvmyEBQEaCLoB0ohXha5j0r+wpYCcthFyGY6lLbDfIHXQICAgT0u9zYP9GtN9SBhceY4yC6xA5n4S+WUUJsXXRcvegQvhEYTOkU5ixqSOcJMBw+rej0vEwD3eJq+4Ib0YztYj2m3rMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz20DRNVqUO7yxkWfGZZKiCc3SLjTC9oH2E53ed1j/g=;
 b=humnBSZtY1t68Vmi5qazWP2wupI86TJ60IrxYqzO+DUPUD9iAc2zlV360HUQdlDoFNBlFuUkWIqwakyoarK8QRhodVG4LIWlvkhnYTpiUPRpM40Asdbj66Eyvj7OKmLwVoWvmbSpdI6lyS3IiK8z1rdiT7eBGoBBJmjnbsYKx2/wMxTZTrAOg9pvSodChQuxtVoXlZa3zkg0HjSwnqcIQPkLQVDHnMfQq9U/UVXO/0Wun7Da73moJi7tPwX/O5ant5YMaaXaPLq63nhY/VIsdabFgI5WQMIGOYm37qBMso/xEOolaJMZy+EPbyYmINH5YUzWn7b50nbDexWha8CHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz20DRNVqUO7yxkWfGZZKiCc3SLjTC9oH2E53ed1j/g=;
 b=nzP/RaDBPp6YCdbex3/Voc564vPH77xQyVX9eIMLNiwLIbkM98RCgCMUQYDJLltzzcSYLNZJhwFnvfnufMB/9cD6ezEQxVVIO088/AJTKxWNJx6Jl3Zlj5uiAUDL8HRP/l+zw5SVimD9+v4VD8JvD3S/zSHLn3xlhEO/E8QPKPA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3864.eurprd08.prod.outlook.com (2603:10a6:20b:8e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 09:04:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:04:12 +0000
Subject: Re: [PATCH v7 00/47] block: Deal with filters
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <4d7fa326-ef87-5753-cc2a-bb26fc555864@virtuozzo.com>
 <f36f56ba-1549-1612-8b24-4e93337b2f39@redhat.com>
 <f9746566-1e3d-5b24-add0-aea49955a950@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c31f9616-bf30-a3c0-cc95-30969e422c49@virtuozzo.com>
Date: Thu, 9 Jul 2020 12:04:09 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <f9746566-1e3d-5b24-add0-aea49955a950@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:207:1::17) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR05CA0091.eurprd05.prod.outlook.com (2603:10a6:207:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Thu, 9 Jul 2020 09:04:11 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fd8327-16b1-42d6-fcdd-08d823e70c67
X-MS-TrafficTypeDiagnostic: AM6PR08MB3864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3864F309B3C39B95D74883BBF4640@AM6PR08MB3864.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ers+kMUCR0Euc/kIItGUx6s4ZAnr/7DSTJb4tKWkoUWHEIwL0ooEAc4Y947ypUR409fK4nyv2FJ5D8nUChw+Jpi7k+I7X3vwpPcSs4MhpiHUoK5DvoGYtBvFxvlHwZW5ilBogjhWdOaO7bLoYqmlCMh62ZoqOkNjWfYMnGy66UYtHepiruj5PKBeWJBigptF6YfzuOZVK7zeAXcmDv/M01KO6oms81hc69U3jp7avOK9eReXu00K9Mq+Pqxh1Avvml9tgQZqNZ03I1wJmKTY8FxMAngBPS08PHvwZbV4MhHD+zmu23hQEOs0h6lIbiY31m8Q4VnSu5Np2nPCJHwmHhGPfCypBer/ayMqShAwErjDYKj6eOWdSBB8bvyEq1AR66hsRCx6TG9l2rfQ919EArrBTH1ODjkPc1jh0QV8XTzoPl2r7ClWFdtsduWqdHf6k6dN/7jSJS+tA0hUbyJJ2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39840400004)(110136005)(5660300002)(966005)(16526019)(186003)(26005)(6512007)(6486002)(66476007)(478600001)(31686004)(54906003)(53546011)(6506007)(4326008)(2616005)(956004)(66946007)(66556008)(44832011)(52116002)(316002)(86362001)(83380400001)(36756003)(8676002)(2906002)(31696002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UZUFW+htiN59on0eJV0oNgCPVONkjZ+pCEvvk7lqesmIIvZ3/aDLTly5XQT30nBjOmZFvgAjesYHmDyT8tbWOgASv97zEHKgLJmzpWT3zmzdTOc8t+rzMxIY5jVUt242Dv+cyNvV9PVYqhpT4YHFbGAr90/lPdal3CYSi5FBDKSQELfaaucwj1G4gbDnyWe7c+IMMR1hhDSnFNmHMEsqOvS86SxdDGSJ76DG++0K4gktQl4pQUkmuTvxc/nuqQYkmNdRd63yIljwkExhp36ufsHKJ6k8oHePvoN+q9Y9p1wA9k05xpvTdl5s9ebluLuqt2cb667HvbvuKGDyrDttS4ZPSAr16vHsTI+NuhRWaasRBeX3sONpXYHd8BQWHKZ7+vPUzVBWPXpSARz6GzC5/msxLKD9RuMGYN2JH+AU9Tv1cVP3UEs7t9DeA3qHgX1m7CxooW8/n6ax26GfzO/96hyNhAhwzdAiQTvLiYiOejsfBNnlJGN/hNR2sXTiCaZm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd8327-16b1-42d6-fcdd-08d823e70c67
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:04:12.6793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aE4M49CnLb+BDuV+9rS2gNUuBOk2WcNDK/RjEYHxbzErQOh7aVb7sTjpLYMAhFqBefTkbWYsAuIA1jfIY1o5xy6fKrGfbhno8v3ETZkzFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3864
Received-SPF: pass client-ip=40.107.20.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:04:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.07.2020 11:20, Max Reitz wrote:
> On 08.07.20 22:47, Eric Blake wrote:
>> On 7/8/20 12:20 PM, Andrey Shinkevich wrote:
>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>> v6:
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
>>>>
>>>> Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
>>>> Branch: https://git.xanclic.moe/XanClic/qemu.git
>>>> child-access-functions-v7
>>>>
>>>>
>>> I cloned the branch from the github and built successfully.
>>>
>>> Running the iotests reports multiple errors of such a kind:
>>>
>>> 128: readarray -td '' formatting_line < <(sed -e 's/, fmt=/\x0/')
>>>
>>> "./common.filter: line 128: readarray: -d: invalid option"
>>>
>>> introduced with the commit
>>>
>>> a7399eb iotests: Make _filter_img_create more active
>> You appear to be staging off an unreleased preliminary tree.  a7399eb is
>> not upstream; the upstream commit 'iotests: Make _filter_img_create more
>> active' is commit 57ee95ed, and while it uses readarray, it does not use
>> the problematic -d.  In other words, it looks like the problem was
>> caught and fixed in between the original patch creation and the pull
>> request.
> Ah, sorry, my mail client’s threading layout hid this mail from me a bit.
>
> Yes.  Well, no, it wasn’t fixed before the pull request, but it was
> fixed in the second pull request.  But yes.
>
> Max
>
I'm clear with it now. Thank you all for your explenations and time!

Andrey


