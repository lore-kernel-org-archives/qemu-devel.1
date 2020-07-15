Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF102072E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KwWMCDQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF102072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvpCu-0003WV-LF
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 17:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvpCA-00031k-Mc; Wed, 15 Jul 2020 17:44:06 -0400
Received: from mail-eopbgr00119.outbound.protection.outlook.com
 ([40.107.0.119]:33858 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvpC7-0005q9-7e; Wed, 15 Jul 2020 17:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu8un8HPsaAQ7WgFB9LGclln8SFD8nM37Y8sTH/9Jn5Wp+3kAvXYcnVKwTZaxvRySYDbWssavcal9OdpbKOayKjXuqjaVPeDuc3IbUu/pFCahgeDU9qIKGrV9oXKGi+JzcwjrVgZQb86CAjnQYrrfMGi7xc8RTLEnE7Mv9bGJXOSfvkUpGgwgglPTgY+twqmwJBUgyXqxRF/UFJF/kpzhF0l/5VRLCB0klfm2jQBv+3Ae4zezYBlBpKZRo+kyTPjYfx2+Xpaqmx3XwL2JkZ8GmY4iqmrlcym4G4hPGPz9guuL+5wqOdxehWx26tMOOMWRSs49E7zlJYYl0CuJsUxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJftVOTv0RfvsipeihYQvmVdOW97adYk7vm2Deubovg=;
 b=b9Q6y5/iAx/gqYCGyB4ENQGFbRx7C0tTd6VDI8CUWfQOpT9aaye6Fzjvy466q41Y/3JV2hos64pjo3L6yb8FJx8PNqU+86q9Wns+WrB6qd0RVGArvhsfYC1nlhcymiYeKAaLKUXaIckB2PfS4JGdceUYDCMIFPkqW2qQutU4WAQJZG/VelKP20+ASmX6gPmdsYkvbzeOFWBPZzuHeaOo/uuPe4WA241iB1X7CWmWIN125WlP9W+XSq1oRCEXbPsh6Tkwz6b5nFIkBSAiU+xHLaUia2CiO4eRBNzwLqFNrLiYWf3I/2KRJpxsGI/oXKVTK4fmt86XNNoCFLh3IxpAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJftVOTv0RfvsipeihYQvmVdOW97adYk7vm2Deubovg=;
 b=KwWMCDQZA7kToIcHYkl7Pn1Fl1/aDbI87TDwhhtTBjVY2uXSlonFwG/CzSouQqitT7LqMaiZvkmHOvbezYWh2uQvgoPq2Me7KvPgf0LKB1hChGPeFUlgDPMwGXswtdwKmlTL6vY8rBc46y5qbaaxuLmOeb2Qzp3wn+itnjiIDWg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 21:43:59 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 21:43:59 +0000
Subject: Re: [PATCH v7 24/47] block: Use CAFs for debug breakpoints
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-25-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <18a1e3e1-12d5-4689-89ce-a677fca6a3b5@virtuozzo.com>
Date: Thu, 16 Jul 2020 00:43:55 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-25-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:208:122::46) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0033.eurprd04.prod.outlook.com (2603:10a6:208:122::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Wed, 15 Jul 2020 21:43:57 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa02f6f-7f17-4da6-aec2-08d829082e8f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48495F2D88621951DED9C9AAF47E0@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1MkfV9j/THz0te6xuMOF9xghdMtvxjjiVApRooFF3aBlWx5e/RbO7TmqRkW0ydRKa6zc1TnJZI/cWXrhl8UBu0qiOkBJDlPnqIYlPcZ4L0lwfIl2i3UbJfuL7LbAOnFrLvGxtWG36Or+vmwGgSp6lNbAnQkZkrA2+/jMqVqTBXLCF8JcAKkyfEuFUiKE4XfDhMCCmZWgFgtPX+4lOWaV1wFpZzAuPkVrx0FiQMQiz48XfFvxeHqVEtsWjGWcUnkwHkN+foTBUaoWOSas1ZAOt83prQ4NZYZdoNwFflkET7wduDc8kODhmyjEUemDFl/KXPf5rtzsuQ00IXGAroYKESrDK3nocO1nEebb0B4NkcLBSDlR5IUOAit1e+z4gtF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(376002)(136003)(346002)(366004)(316002)(66556008)(66476007)(36756003)(6486002)(66946007)(54906003)(2906002)(478600001)(6506007)(53546011)(44832011)(6512007)(31696002)(8676002)(956004)(4326008)(86362001)(2616005)(31686004)(52116002)(16526019)(186003)(8936002)(83380400001)(5660300002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YKwmt9WL10lfqJJfDYOTnn27S5APc03dkRfjv2vqHHU5a/aKW3weywEGlnOw6+htE6/i2HGgPdvNuKYVIFFS5hOx8TT8BDZCB2XUghQcALAP4F+7nIP/BAHQwXy2GjF4xZoNVHmFqrKrd3r18rlDqTJNkcUwPA7TIYb1lwjHZeeKCDZanj3IHkr5o/Gy2BihzvY+GLPIfmPp8xXiDeIemkllOvh/xoIWVMneDbvv8MsmwJ+G5kdfXeF7nFt4K1sRhVFLZr6nujYjdncVhz91sXy2ZiJmIkncBmh21JCgPH/dl7UoLKXyi9H0S9Nm1PD7D2iNbDIXIMk29Inxr8H9PKK2AsK0i94p4Edpp/vMjEhTakz/tJb+rxSzRQm5CCCh8KiUdYxEbFIxCZVfwVm0+BiA9k/PGSnohBxWo/rzq5BfaGvElRwqsMMCtoAURW/WmCAbdJLTADWGJrfye0UpOqqN46GmdSKdKLQxysjjFkQG98PpDIibiYGfBs0I9Pdq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa02f6f-7f17-4da6-aec2-08d829082e8f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 21:43:59.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KirnOlZ/myEPI3us7BOhrolUcJMbKuefePgqyyGM2reYUDFlxklfqToyqivNZenHefgQpvHSDogP/5BeAMUUMUZS8ToR+SEijxVkQo/1vFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.0.119;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 17:44:00
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

On 25.06.2020 18:21, Max Reitz wrote:
> When looking for a blkdebug node (which implements debug breakpoints),
> use bdrv_primary_bs() to iterate through the graph, because that is
> where a blkdebug node would be.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/block.c b/block.c
> index 7c827fefa0..1c71ecab7c 100644
> --- a/block.c
> +++ b/block.c
> @@ -5562,17 +5562,7 @@ void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
>   static BlockDriverState *bdrv_find_debug_node(BlockDriverState *bs)
>   {
>       while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
> -        if (bs->file) {
> -            bs = bs->file->bs;
> -            continue;
> -        }
> -
> -        if (bs->drv->is_filter && bs->backing) {
> -            bs = bs->backing->bs;
> -            continue;
> -        }
> -
> -        break;
> +        bs = bdrv_primary_bs(bs);
>       }
>   
>       if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
> @@ -5607,7 +5597,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
>   int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
>   {
>       while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
> -        bs = bs->file ? bs->file->bs : NULL;
> +        bs = bdrv_primary_bs(bs);
>       }
>   
>       if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
> @@ -5620,7 +5610,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
>   bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
>   {
>       while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
> -        bs = bs->file ? bs->file->bs : NULL;
> +        bs = bdrv_primary_bs(bs);
>       }
>   
>       if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


