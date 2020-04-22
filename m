Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B5C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D7F2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tDcbacao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D7F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGQD-0001EH-Rf
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRGOT-0007Vp-2K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRGOR-000468-IR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:30:27 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com
 ([40.107.4.109]:61006 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRGOR-000437-4b; Wed, 22 Apr 2020 10:30:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXRL7zmQuE/PO08E128AYOV01j5GgkbiyKPvx/6eKtJjWzEVlWmQf/B6U9YUOYCuKjos9+TpKXFJ1JgYv7/EmVFxtoriJ2ABKa9BpaANVduRBa2jmXLRSvgBtC4bcZpjBjimBivHJ/A5bhJZ/MeJ61FWjcni9WAXPeBxDvqBKUPafoedsLOGO8sNf+ZxfiLzMsFHlVFx4CkPoY9xS0ElgiKWnu+AqQf2bgOX84cXVzL2sJD9Q17E0bgU9+CIlHFGVHAcC/w/+fvsw55CLOqjN9JNNwGAJXdIUFHbm01tXQ6gS1Dwgn/kUCWehCSzc6pHM+2JVmPy3eSpxh918L6NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnl1XQQMWhPPIvFzunvYadsa3YUSFsgZA8bVn4ytLLI=;
 b=TAgiQpyufogQMtTZrsJnHJRnR6/In6d7qH9o7OwF4Q1leu2aGCiEcF+o1jY18krv+UMCeGGHqDF7YhKRpAPN17ROZsTt8MbIDAVfXaM4kYJoaP+rvcTkPYmAPOqbeSNRIY9rkcbXnh53aKQgbhZg4/bdRMf8IlDiD8iN0Ym3tFGrFLyv1+UQKe4NwR7XCZIkfeKzd5G5V4o4ZM6xWEJWgfY6WY+xQ8QVwmPyD4UpzvIzpcv6quBA0FYjhh+gRHob7hZ5C8WwBSwXG5N9wRMKJcC04vpzNlCVe5qjQ5hzGN3WDQUHK/DFOcVEhYlRkAdzJ+R+mM9yS82TwdOocZxiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnl1XQQMWhPPIvFzunvYadsa3YUSFsgZA8bVn4ytLLI=;
 b=tDcbacaoil0Y9uqZgxx3pD1kjlCh69Xlf/u9wwbwwlOs4iB1ymU49Mg8Ob8GmAujQp3SePiRbWHWntn2itYegrCPivtxbIci7FZc8MOi2HQoXqGL1wI+iQ2yQbgSxQRIMKx3UZUf+Apwldk+MizplfuXkXuy9zg8bh1DZjgWmLQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 14:30:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 14:30:25 +0000
Subject: Re: [PATCH v2 0/6] block-copy: use aio-task-pool
To: qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422173023523
Message-ID: <1679ca14-d4ab-a05f-98af-ed0ba0b130ff@virtuozzo.com>
Date: Wed, 22 Apr 2020 17:30:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 14:30:24 +0000
X-Tagtoolbar-Keys: D20200422173023523
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e87033-2acf-4f55-0a2a-08d7e6c9b238
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511EFA118E7D12DB1E23B43C1D20@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(186003)(81156014)(5660300002)(66946007)(52116002)(2906002)(66556008)(66476007)(31686004)(26005)(8936002)(4744005)(478600001)(316002)(16576012)(8676002)(16526019)(86362001)(36756003)(31696002)(6486002)(6916009)(956004)(2616005)(4326008)(107886003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6blyjEOBG1Yyqdm3o8+RbNCTzb2Q1UKmFbsJazuT3c4j1euxL0SxHz+dvE1HZyH8V55Jm2H8ViSPHYI8gWWS8B1BKN68pbYyHFFH7j0yUvF5zPvCAY1gABtVSB/VN/u1+LxLPs+O3nWMVu1o7sO5HeMtvHEEuhRgFjBjSCCUh0BpQZf+ewQOegtBkA92rczb5sLAYpvD9Ps815PplvNpXN88p4a8LDthxPn8F7kF6QJX0lHZTzB0EhO1x/mh1da0K2kLpMkACqPkWCQqGIuhvGYE3wKyzeVPNqyHyA2aMQNSnUvkT6e8L0CsiBJcmzhpA8jyXEZSVOSmlCLCGzN1nQyNUx6cLdtuoatuTLFE2P4ep6pubyJcmgMD0YToicQaKRL/1rbp6gS6Il8Mdi58uAa+F+jJwSfKCRV7cU07M/t4L4+b0m9YLHCUfIz56S8
X-MS-Exchange-AntiSpam-MessageData: rofZJniids+6kAhk6rvQ7Ik+Fdprom5LZS9vBSsT/+urAhKB6QD07clGijoO0+Tuzoe3gtGowunB+yvUN6CLOXdXVPcCPMt8GyTam71/xW4v1P+rGwlhyyLx17ydtCLs6zdyT6sR3+ZqviZ9fkVHOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e87033-2acf-4f55-0a2a-08d7e6c9b238
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:30:25.0380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT89/XywJ1NivWUaHb3x/+2gRuMgYCzfDpygcmvugdwpiHmDdByesYRV4CatFh6fpMOEJfq7CvMwsBXfQrMZhbegUwG16Jaol8hX+VFqL38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.4.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:30:25
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.109
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping :)

25.03.2020 16:46, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> This is the next step of improving block-copy: use aio task pool.
> 
> Async copying loop has better performance than linear, which is shown
> in original series (was
> "[RFC 00/24] backup performance: block_status + async", so this is
> called v2)
> 
> Vladimir Sementsov-Ogievskiy (6):
>    block/block-copy: rename in-flight requests to tasks
>    block/block-copy: alloc task on each iteration
>    block/block-copy: add state pointer to BlockCopyTask
>    block/block-copy: move task size initial calculation to _task_create
>    block/block-copy: move block_copy_task_create down
>    block/block-copy: use aio-task-pool API
> 
>   block/block-copy.c | 250 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 168 insertions(+), 82 deletions(-)
> 


-- 
Best regards,
Vladimir

