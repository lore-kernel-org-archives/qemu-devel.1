Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C8FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4782070E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mqlgJM2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4782070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewhJ-0004lV-Rt
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jewgb-0003lW-GG; Sat, 30 May 2020 04:17:45 -0400
Received: from mail-eopbgr10132.outbound.protection.outlook.com
 ([40.107.1.132]:29001 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jewgY-0008Sm-On; Sat, 30 May 2020 04:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDuv82R4UBFow2UWh+Pw5acSNgaXKWOk9er2k2y3+gydCoTTJkZRpFuH9hZVdCumlvglhgWJ+T1cDc80FbAJquZoJFwi4AefE9hnBHFVrPcYa+kEruemGNruFVYfRs8YwI2T9xlQRHSqt9pxZpg05+ASBmS8dZbhRPTBbazTtqCvwPSiN8WAFYfPvEqLSrR1wgx4uZSDBdj+HiVQuXO+1Z/WYP8A27ic5wL6a23HwIMB/kuBThbSx/gRlwgsMANmlLKUw5TLN/L0OnuVd+KfRKeItVkvkyy8GKUiBKyccl2w48FpqPrk8KjESV8Rz/bf10kifx4/L9/bRsywHO8KbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orIXvvjRyhmMGZbyc13KHCZytvYwH8/p/9yILsDVd0I=;
 b=UtnXY0AOhXZS6owoW+zy0xCLkseNhbtVwba6cUeaCDlnKytZZHCnSb6FlZl3rJyoGKtLX0JVOkhZuWEX1Ge3kqzRd0z0cJGmuco0muS8qIUHrRpCSZV+nPPMrTr625uChKXLwV4fI9EJ37xrmT8hrl5yt1XIc9mSKWdkwwlqjQDUgkKvQlw8BFft6N0wrx8Pr8wkBf3wAfH79kuA/10AfIhmEKiF6DCwWyOGvaUvS3szrpehDy1xJwgJc40yRCAtxCyPMOv78w23mxCDQ8AZkVEaNZBynSmN0e2TfPQkzG5QcYw5D4zgbmuzKrt+XhEIS+9f4hTLZa6f/5ZqXB27fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orIXvvjRyhmMGZbyc13KHCZytvYwH8/p/9yILsDVd0I=;
 b=mqlgJM2NqK5hpApLzNT87eNX4mAu47YeySsCkrOdC9NR2g2uchCNvOw7gSB24L7hD8kMXMM8kBOG+/H+VtoFN/xYqQzOnSMEaUOW3GdnafwZF05LcB5A8aaXfbDX+jbXT6mjnD1InA7nnK371GgMZtcSKwf+yeKsQLfZv2SF4pw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sat, 30 May
 2020 08:17:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 08:17:37 +0000
Subject: Re: [PATCH] qemu-img: Fix doc typo for 'bitmap' subcommand
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200529144527.1943527-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9abea376-32e0-c483-f965-ddab9aa9cc50@virtuozzo.com>
Date: Sat, 30 May 2020 11:17:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200529144527.1943527-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 AM0PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:208:136::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Sat, 30 May 2020 08:17:36 +0000
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4219fa-a8d9-480e-9c0a-08d80471e9a4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381988FB4D49F076CDF3217C18C0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 041963B986
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoS1G6u84xmvOcqUdb0B6bW1047WMf3y+oejKqHUURjvnrnEb6gkOaWlV8qQjKEB7zabVzJ0yXDwbCODV/xcOqrU2iN8jeAlfA/dCLYQnqGNS3XvZqmK34kWr7rreo3iaV9Zy/eHGaQPNW30cylPc1tyXgxnnI0draldRJ1FYxsiuekpYDguhaFdtdgo2qYByy9mKRJ3pvNR/zQEQpYDNnOxxEUJAV7r1NOeqdR5e+7YmehC1Fw3hkaIW4U22dzOTkPcs5b3AXWDmZ7RM9fvHWl0ZyHwxbRi/dp2rbIwZ7e2qwjN4/BGFub5L+F0eJiJzMUmfLNgHlFaL7IkbKzlLi/ORfE051I2UpN8IP69/ezmwY+lnOWHNG1tuNfTbVHk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(5660300002)(478600001)(36756003)(8676002)(2616005)(16526019)(66946007)(66476007)(956004)(31686004)(2906002)(26005)(16576012)(558084003)(4326008)(186003)(52116002)(316002)(8936002)(86362001)(31696002)(66556008)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EfB2YFLQW9CnG0jo8zLIbzh1aNeLCSkcmeM+F2wImFOUDdwS/cAuxNnaToylJcJ4S/Z9zqPUjump4fbXX3bA1MaoO+iQLlQ05D7SrWaPl62NlefxFDLMw9iXBZfQAnwm0+MAQfHp0fpNTcpsVS1JP2O5E3L3yP1rv5VZBUMONHQHBFdqECzABKaR5IC2G6zGvDVjxaAMd+sVdYgaAxCQmbvhrTdVullKB7DdMy0/5z4AD23Y8JGFFiR2TY+ug66CG3fhtG9Pf9Fzt/kCD5N2Bkl6KUUPWx2PSx9LvOl6sGOECfgv5X9bFhGjw0KpE8R5eiMtwfS1n1nbHU6igX2jS9LAtQwudT7SwhIyL3S3VptjRY0DPt9OEd5cwnuDAbCB7xIn9RKTBl4So5Ea0KC+NJ8SutoTf8T6vH+KOWfPDCGxYswmRaOlNQL33BcpevIYFosJl5E4Yv+gFTrdtRFTxLqjiDTFS2gIwlFkbzgInkpB1yWMtjzP03k38KD6N00L
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4219fa-a8d9-480e-9c0a-08d80471e9a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2020 08:17:37.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bap6hr+LXFOaQmyHMwiF4V5ZNHtYMxw73WDaNoCtc7EV+jupr3u5fv5uygehTzrn0v8KKSTorQYOs0RtnCgmuKTOytgGrnNkCpkTizHnZEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.1.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 04:17:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-trivial@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.05.2020 17:45, Eric Blake wrote:
> Prefer a consistent naming for the --merge argument.
> 
> Fixes: 3b51ab4bf
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

