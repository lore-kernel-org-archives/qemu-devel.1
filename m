Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F367206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KFNhCY9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F367206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2A4-0001ZN-Iu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg28x-0000k5-4w; Tue, 02 Jun 2020 04:19:31 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com
 ([40.107.8.105]:53747 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg28u-0008DB-Va; Tue, 02 Jun 2020 04:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0jyYTkv3o1LgQg+WBeKLPFLy6j/yzVkBGGAKUA9LLN7xNb7QjjTFz+SG/LtEmhl9t1ig3vRnMaRYjs+HeQ7ZTmBC4+yV6tQeWaYxsNk1KcQ63VaOAejY513QEWir6LrYLpUqq8ntc4nLgi6HeDSmYOWPiedtTqOEBgug3JDIgFdf5JWfrqPzKtDb0oqJyJLoKIs57JI3kYqdcHB8USBV7FpQdXuK67AAhQa+gkDBQkGmJfTsIBZCQsVssFEJng3ux96WQKO1f+Wb7ut0TAD80L7d32UHI8CypRGWoD8ebtP/rr8GivAZFtEhheAlkuIVKgNg39oFyJ7PudRStCMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynXL3kXIY3YOzF1ZQwN5gS8njfddnbOt5bXbNdsmQCQ=;
 b=YdDvvaKsJ5qtX6GgcJ414wUYSsyzKsFZbKsbr32+WCiP39jKNXG+h90uuaSokPiNF3BQf+skCqv4S33rASSE3Uhm0XNkcTCitqzeyeNrOKmGrv47NWz4K+iyS17L9eeBBmMwMJdg3P4Gt/bqbFTpEcXe0f9CKkRySd2vqR9X46RD6Kzn1wzIr116HpEQOEQcLYa1amitLue1CJAVqFiaVVUre/FSl2SXDLI1xFE2YE4CvxYdLAZ0ImIVFot9bDp1yBNM80n8RvHbDPiXb76c2ERgnwNoeCD8fgAsunZ5/rzU+92u/accPvEvs7P1WzIWwp04gk5K45ibi53n2vBueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynXL3kXIY3YOzF1ZQwN5gS8njfddnbOt5bXbNdsmQCQ=;
 b=KFNhCY9SlWxxQYxGKyIQN97KzDAC8GHa6FsiMMfw+hpNEolsIW1ymOml5orR6KWwp3Fw2Vn8tK9pk8ybf+VnR+X6x2EpR4cJttjExXpaEbrNie3YrPa+UrCWCt5LjBNpRKrkO/yYq00ouPY0rkZWT+yOPnTJ99SEjg0dX+4rgdI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 08:19:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 08:19:25 +0000
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
To: qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4a197548-7f7e-f5d0-5956-79be7bd922ab@virtuozzo.com>
Date: Tue, 2 Jun 2020 11:19:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200601181118.579-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:208:1::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:208:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 08:19:24 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2f7211-1486-4ea7-3441-08d806cda970
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511F82D9AC0C87F443058DAC18B0@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Liq8+n4F0C5PVtSKsjNYjq2R+yYpXfsPoNZircAlKs6QNaMYLn8y4FtGbllJ32PdsmgsC7JKZ8P1nGr85vsSaNs85e3VbkO4faH73sgaeoe9SLokdAgjguc1g3GG3mvtb2DDbHbTUoPdOsdyefA2JV8xfaa84mqwYaYIma7rllqVxm4NkED0OL59bt/wr9aB9QfPGuH8A8upwPqFRi4e0uXFE0j/hSa5Xa5PxWVrKZ+JN6VX6LdYD+7XAHE0xunYbKpRgCfXsOpxXalmlr/BK0w9kdLdDd7laTN6c/N3KMkXbrVtXRL+3NT/s4NXxJTEuenti2JgBaHpkgff/ssaOFPrtjRyga/uijJ4M+LztPnW35E7dGaDOgGXNukJ7U/3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(83380400001)(478600001)(52116002)(6486002)(4326008)(86362001)(186003)(107886003)(31686004)(16526019)(26005)(8676002)(16576012)(2906002)(66476007)(66556008)(8936002)(36756003)(5660300002)(6916009)(316002)(31696002)(2616005)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rndd7NAyb3pq4hgJYZhqhiu6CFBRfTpePEa8+ca+OdXAov7tR/Eyp7/Axl1gkwcvpZ8TzfpHIDv2MOEieLuAp262tD4+HHCF9meLBQ9Yhr0It3fgS5WHJVpjr40h6bzr7iZwLjyXpxHSN9qfTVVi4cwwa/siNPPCTWRtbjr+M9gvY7uG4R+GpLwEBrrQfw0vjTbQm6kFAHq8EPQ+jJYDeuFr5W16ks3bCf5ZbeTfCQMx8/2f75CPi6uLOMepuZthMJ/eZBgjYII+/4OyTYfKwuZiMWNri4L42xpq5YfKJHx5YvHV1XotZecfuiCuVdwsp/p7b4/WaN9m//wm24WJDShPdTiW7HdYmwu0OpiP+N7hOwrPsecOpcDcoO0Upx4PPuzVyjiQJE+T6gNjEnKNSZPUaPv8FdYxDb9/A2W3kSyJkmwsrzBi2P7h5IaQGlmIDVVL/8TOl2DOB2oMivYa3u82CWxSEbZXJ4To9/6ujmg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f7211-1486-4ea7-3441-08d806cda970
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 08:19:25.4979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b97M0P7+KXZnwQ7tTZkSFBtmcqW2lh8wLDHo5epcI7NH97bR4dS2gDxtIb65Sg+O2NJ/k2VBxIZ0CTrvuBXkTfgFUYorioSA7D2uQg8JkqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.8.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 04:19:26
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.06.2020 21:11, Vladimir Sementsov-Ogievskiy wrote:
> Add new parameters to configure future backup features. The patch
> doesn't introduce aio backup requests (so we actually have only one
> worker) neither requests larger than one cluster. Still, formally we
> satisfy these maximums anyway, so add the parameters now, to facilitate
> further patch which will really change backup job behavior.
> 
> Options are added with x- prefixes, as the only use for them are some
> very conservative iotests which will be updated soon.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json      |  9 ++++++++-
>   include/block/block_int.h |  7 +++++++
>   block/backup.c            | 21 +++++++++++++++++++++
>   block/replication.c       |  2 +-
>   blockdev.c                |  5 +++++
>   5 files changed, 42 insertions(+), 2 deletions(-)
> 

[..]

> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -563,7 +563,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
>           s->backup_job = backup_job_create(
>                                   NULL, s->secondary_disk->bs, s->hidden_disk->bs,
>                                   0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
> -                                true,
> +                                true, 0, 0,

must be true, 1, 0, to setup 1 worker.

>                                   BLOCKDEV_ON_ERROR_REPORT,
>                                   BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
>                                   backup_job_completed, bs, NULL, &local_err);
> diff --git a/blockdev.c b/blockdev.c
> index 28145afe7d..cf068d20fa 100644


-- 
Best regards,
Vladimir

