Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73570C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389E92067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T8yb8LOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389E92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaeW-0007yN-HB
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqadq-0007Lb-0P; Wed, 01 Jul 2020 07:11:02 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:53890 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqadl-0005IU-MY; Wed, 01 Jul 2020 07:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2ne7nqoTMTn+IexQyr0fMxmRnLgme1Q2tcl6ZZOCJz692GzP0gi+bAFyfXR0KghkDwysIqhui6qIm5wGXiFbosg9AW7BPEPLnZmrMNuAnH+iMKEcS5MkBUdKOv8PL73a8w7Smnft05S83UUmAzHm4UIdMOPXhB65MYzG4F+z+1StPG2LdNxlNXiMuqaFwuG9kKfT8ZJP3HXHioElQEUj4UfNWp0bLWIh5/OH56KRhKvE1s8dLcn0s6EwiRe/aCHfROS3hDUf9Af5wrCRqkH1SOshBKfXPNCdYR9MFRJ/4NvFDyTSlFADmIVYtsbOOdppwJUL5Xjg9Ap1uhCwoGrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+V8RzAcsR1noaK4d3PizPfTE6qOMfufO6SJ6K8f2Pk=;
 b=c+6EKUHgOs0DQ9kb1ctlLohymH8ulXEs+lAFkodYEPCUJO9vrsI3Z9RZPjWff3TSI1CUwtPvXVgDH5TXh1Xp63lN/RB+/AKt6gdCVpwQEayKYA4PEw1dHMgTY1L222zzjA6L1xGwt6BfJrXd50C4kacBztVE02E9T76hJTGBDrAl52NPi4k5KJhTEBpWbH58Pf1kCfOR/tiI/C0kvPjVFC1Cr7MzCDMAZqlU71kvTTYPW2hazUPLrR55L/yP7oSw8kBuKCF2b+ry2Gl4zdoktcvSqn5g4EJHcrVi/vZlloiIcHyjb1qmGjYGYf00wjsp/cPsv2+bx20fEQBmx2WP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+V8RzAcsR1noaK4d3PizPfTE6qOMfufO6SJ6K8f2Pk=;
 b=T8yb8LOZdIlTxxCK8IPs48GWMcqBJGXsPoe73Zh5+nz614FJhXjwGWHYNZH/MHHy9VG22Y0X55vQFH6bJLqkdrq8CjQ8e8SYtAv0/gYoDUf2yhKLbdZX+uOxDTAfmXKc7iJLMNU9r6Ku+Vvo7oan3p+oYWhIo4ozPJ91N+Fq5RM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 11:10:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 11:10:53 +0000
Subject: Re: [PATCH 1/4] migration: Prevent memleak by ...params_test_apply
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c2a03349-4213-a784-7aac-f5e84201d553@virtuozzo.com>
Date: Wed, 1 Jul 2020 14:10:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200630084552.46362-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR07CA0013.eurprd07.prod.outlook.com (2603:10a6:208:ac::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Wed, 1 Jul 2020 11:10:52 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10951fc7-d197-4360-ce57-08d81daf6b39
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852B4A86499F352AFC039FCC16C0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrlxvVyblhJa65dSYudZPH84pyl8OpsAVgqgfeEU7i0KiSjmlu9nAXMJc5NOnBAvkCdC8z3iaF/R/kHIR5q7Jh4miF2Y9IlgVoLDRwlc5O7KCK8hr6h43psAuLaop4itqAV+lRsSXVpFbN+GKLX+GyIGtwtV28l3VtcD6MWBpRoCO75cCDOYbWBcgMyMzVBP9V22GC3yJAB4ZGTcVtkOz5SxhEH4A43k7fa3qyrbuHcW3DoqLzO0MTORSLQZDpfw77bEjQMN3GDl/EEyHzbgHqeoXJ8TNNlwh69GRZJagzZE4w3hmhSvqUcFuHO2IJLgxiZfzGGDzpJI9mzNqkOzyMTpiJJHTsAmA5z+fIopnRYygULRucPm5fOqnrIfSRZx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39840400004)(6486002)(16576012)(956004)(2616005)(66556008)(86362001)(66476007)(5660300002)(31696002)(316002)(66946007)(4744005)(31686004)(52116002)(54906003)(8676002)(2906002)(36756003)(16526019)(186003)(4326008)(8936002)(26005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BKymsgo+dn1C6pXuXH6a0CpSJZWToa4oIO+Wi+cLeZLGkpKCXfJO8LBuf091T7cLurGiK0GWtyHrY5fNr2zeXGFyEW1TIWAAqUa835Ea142Oxki5mySJG+d6jhccnx0xsHgv5RMYCmiOKUps1MedZLOJ+/hVoxK4CJ2pYYlXVQQyECqowmrARSp9gxYprEJ8Pp2E/92JCxJSEPqe4sZKKtdVGjbIPXEBt8HTASbDCvBBg7L4vuZ2JKJw1M2KPDnGEcO7Woq8RimrrkC/h1YGxQTkUyhU4BL1xxKFt+QHee09MbAF6gacaXi30tNxiihek8tqElX9p/Ie8gRD71EXY0hKfoNlWD71cCVSJ8XsYiKgEUCTB91rhZcpkF7HYj7k/P70MMWuIzIXkK6WE7ZQoGv7ZDZrVKWUKe1GqIdg643dNZx6K7WKcA+QaqvR/3NAOLzL0gqrd1kyHM7fuwbXi2lJuBzeYXwiSh9qdOP8zoM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10951fc7-d197-4360-ce57-08d81daf6b39
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 11:10:53.1145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awBFP9fN8pJLsHrsay9x8DibDsuJxG6N8DQM/2jSANp+dmKaRH02zGh0LjTEopwhaOAUfrB3lerxotg8YwVGxKCdzn4MZ0y9G/zG5HNjZ5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.3.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 07:10:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.06.2020 11:45, Max Reitz wrote:
> The created structure is not really a proper QAPI object, so we cannot
> and will not free its members.  Strings therein should therefore not be
> duplicated, or we will leak them.
> 
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

