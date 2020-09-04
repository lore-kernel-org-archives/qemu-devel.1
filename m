Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5136EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DDB20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ttFXEgvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DDB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECHk-00021d-7Y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECGa-0001BG-4J; Fri, 04 Sep 2020 10:00:36 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com
 ([40.107.6.125]:14977 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECGX-0000F7-U5; Fri, 04 Sep 2020 10:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MME1Pv3Is7cqe+jziDgMWsmHH75lIMmlLyV0hEzthzThONnjp4WBHoLMw73Bk5Yxy3Cg2fAiz0VhnN5dsNHO2ruXzP4oHoB9mXU2VuWATeC5mvgv81nFgWJOWofpbikovRelVkAQGNivtVKhu40R25JyS6Sty5sRBB+rJkeZ8YQdLWSatMPI2mD7VJrPk2kuekZtYdYf85bjaX1wSbJ/HoEZFqXxwJfB3xpdTLb7sSVxUV0GZIDqUcd/p30MvgRibG8pdSyO5mnraltX06K40BBCsYvU1CNzw7vPTl8x4xma/T5QeMqn6f96iS9MFamZJAvAF6tvdXnx/iM/SoMrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIfrNqDOV2Yv3SwGAj52sSViAiU9q0rQKmUeo9HtoTw=;
 b=Juh0Bd9GbLfYs//iLHtcyT5098gu0xjxpUOosljPRfRojXVowkwR4SUHTLLEW6zS3F1a2nG2S16pwI2vZsjGlGi+JcYekANa3yhFy/E7Kg/9QzxvdL3ysJDIvGp4qLprWpqx3BR1NuOz2ER8zIRWda/aiWixmW0UrrpRvvtT7FCaSZXliPhXoY7oND1qEB1n1xUs8JomKW4FlqvfUWhsMK6wOuZvIWyWHJw9Lox5BG3wVK0g/nPCowKcBQ16joovzvyaM5IF/+5AMPa0NF54xSuU0/UW664P7TzEqF+16jTjQMCTMP7y8StoDTivUZX0bkh8mY6IrxWYBQWwFBcUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIfrNqDOV2Yv3SwGAj52sSViAiU9q0rQKmUeo9HtoTw=;
 b=ttFXEgvjU4tuLAm2/4yqogWPSCUcBgiPtBpzcK2arMKKKBDYV7/Xv61oyHMf9CfIKxiwl+0BKKkT4MYvdQUYsO9XT5jMrFzbkdYHz1hMOGWO8phi0i8xWzocPk4+R3G8knttZFXIk66L2vLDdweQxZPBZ8ZEtJ6Mj5d2wSn9X7U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 14:00:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 14:00:31 +0000
Subject: Re: [PATCH 0/4] nbd reconnect new fixes
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <159922632826.11986.14148820580932678804@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <46f47ebb-7a77-25a6-8da5-ac42668963ad@virtuozzo.com>
Date: Fri, 4 Sep 2020 17:00:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <159922632826.11986.14148820580932678804@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.143) by
 AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 14:00:30 +0000
X-Originating-IP: [185.215.60.143]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16a1e0e-9b71-44e5-22f8-08d850dae2b9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44085974E299F46883C1CC4AC12D0@AM6PR08MB4408.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2RaHkEffEu61LHkPrJchgNusGy0RoccXXJrEbk7vAPGJVSIQuftNNJ5B6NdxTF+esLq+9Sw48NikmFPOysoykFiM0DG2i8BD8jRmF9S1L9G2fke/1UvnJdFo/qnBGP8oix+n5m+ssMB7JDNpw5P+4FvsHASV5zOWf0SknB2f+s5Ss85nQ4qNWAQZCGoJMdAGLZCwn9pQy07PS3O8QvTnfbieGOhPTi9/aNCB7z63gOG0+1FqreIvviBAtqGgGALjpTykDGCNjFGu8n/1Zg0jNXGo49P9JQhDeRD2A6GzmvIUGuj5u1rzu8irQs4OnbShoybZ9Szm17bQ+cf7698gxjsIFFdsboP4X1ottfbQIUkpcOXlH5S9Ja1p6K+G2nV7SpU50nexRE6nOIG4ZOGCj5B2AbDPM73spxP+ttJMWJqRS3jIlGDDEMjzlwdIhCFnpaLzNbOEwuWWH8W6X/6dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39840400004)(366004)(346002)(396003)(52116002)(66556008)(66946007)(66476007)(31696002)(186003)(966005)(83380400001)(31686004)(8936002)(4744005)(5660300002)(8676002)(16576012)(26005)(316002)(4326008)(956004)(2616005)(36756003)(16526019)(86362001)(6486002)(107886003)(478600001)(6916009)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2iJqZFibI3apBxcMG/B90Zu2Kc7uLDtchvII1wuKSh5TNgUZYYMnCtetrGkSful96BjqbPE+w5OHKqhw041aTsOloif/Zb4LPq72u493eIokGRVbm1vWuEtY/WxJKPVy4v6QDn3c4nXPHRL1LyUk5lXMU3/bbz/TnXDNhX2r5PlM33AXcyG7NGaoird/8AZEvl0DBQCcxcDOKUd8nAEnoZ91epVpK5Oxzs5z6OK/qw03LLCyCP4arKgJ0fieb1fQ5T39mNAWNBT3n94pH5y/q+QxReGcFHC0wtnoR83lK7k9iWOu/sBdRrRNfhg1pQbUd/PH6ZNsCI2liq0Z4kXF72fRgCZe4JkGsv13tjBOx/Y2XXZ2kKC3Lmj3++385ECKfjkmW4JdWmkb2gPVjh45YUzt0A43Xzj9K0d2GTd9qZqsGRGl0cgmIpupAgT0wfo4DA6of02CfyG9raNrZ4ja993JAzWehZvO8yb3eVaBK7iTDZMtYIYK72CQkPZbu5ePfDrLRTwE7qD79sj737OZUIgrybofIf7M84Xa6uGtS0FkmtLB6X1tY4D1pVJd7p3TASQebVB9CpJEr2CboHBrPRjE0FrJNt/ppULAkD6zA3WoPtXNWnIx6iGQPunYVBU3x53KXsjAXBA86et0QQnmrw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16a1e0e-9b71-44e5-22f8-08d850dae2b9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 14:00:31.0548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KX1G93idIGxGL1UpFVyy9P3l8FSqq3HeN3Z9SRHZ406uQnJz8YEJxVF6BwylHS81LtB0L6Jdi6cbxTkifUNSYwD5I4J95kWyIdrLJLC7Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Received-SPF: pass client-ip=40.107.6.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:00:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_LOW=-0.7,
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

04.09.2020 16:32, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200903190301.367620-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed build test on FreeBSD host. Please find the details below.
> 
> 
> 
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/20200903190301.367620-1-vsementsov@virtuozzo.com/testing.FreeBSD/?type=message.

bad link. it shows:

N/A. Internal error while reading log file

> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

