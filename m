Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF096C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7932621973
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WNA7eDAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7932621973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMJq-0007RN-Mn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvMIY-0006FO-H2; Tue, 14 Jul 2020 10:52:46 -0400
Received: from mail-db8eur05on2090.outbound.protection.outlook.com
 ([40.107.20.90]:48788 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvMIV-0004h4-Id; Tue, 14 Jul 2020 10:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH+6iT1lkZ73lscrE6HiSLdPpJUqyUhGqxSFfpt3VVt75LS6fVJ8Mbk92tRSmI0JdLDiMkJWUNBUU/1nhb/B+rknBCBUXfoFBLPPaSpQOxqiWJA7W4yBHLpXqNlTPhdQPNCMhj1KSW1Hg9C6E3loP7g1s4BLWkgyMX75sAzKHifOOg563Vt5XJsC1Gprm9FUyOa330eUh+qWPVkeEXCnH1FGYUjHQwacSyGJPjFmvRXIaeVQV2Vk8doWUM+Ym/6qTvE6f26MfvD6prgpot9YYREiI5f3rx4FYuGFWWzX99YZGQGRr1aajOFu6a+/UM4astKm/jUjlZFMtlBuM8kt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSrJwW9MPSuzjUVSjBhxcglKzR/emejhXaRa/OKs20s=;
 b=k8YnHf8fGcySk/A4WZVGXoqYrFE4zcR5ZpHW0WRKZjEd63vSRQYuetsHm77g9QHFxelCvpd9wawxZTYEKrORa3yE9Ul8TOgOU2VuY/RLN1aqfKCCKpcqRgbP+dBP48NyCrBr6Rd8VWrSI7ZQbhbmnaxKv3Lqu0j3Njjcj3W5SlOAOksyxVutf+PDKL387NhhnGNlnMcxqFIZpL6wvy7WUEd9qWYlyddAcZRLnT/xYnZSSrBADVPT3xyb6Avd3UWVmJ4DtH7DWmRn5ORKLm/y2P0pga5DAg2dxnQ8lvdkkEXsidz2zYOvPNkY2wk4DTnyBa0vQJi08c5xYRaj7sj5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSrJwW9MPSuzjUVSjBhxcglKzR/emejhXaRa/OKs20s=;
 b=WNA7eDAuVhGJioGdv0/l0fcpPtIRDBuniSOdWfo90as+Yrvt+bFoAcv1K9u8DFX9rgtxhLK3PPCjzL+IghPg78aXnZlxXcsyp//0W3buDI2o20bw2KEaI5RAwnXtuZGSB5/ZbG+qFQWtmvHuSJZjnAFS5aVPmBGb02yYbuI9Kow=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3717.eurprd08.prod.outlook.com (2603:10a6:20b:8e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 14:52:39 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 14:52:39 +0000
Subject: Re: [PATCH v7 19/47] vmdk: Drop vmdk_co_flush()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-20-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <da609c95-f48c-90c7-8a4c-d53c69441c4c@virtuozzo.com>
Date: Tue, 14 Jul 2020 17:52:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-20-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:208:be::46) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:208:be::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 14:52:37 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14006773-1374-4e38-3665-08d828058e17
X-MS-TrafficTypeDiagnostic: AM6PR08MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37177A8563F080009DD52945F4610@AM6PR08MB3717.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rb8EFXlw/wpxBWNhi0/GvSoKYWGKMCn3zzL8xkedIfvchWziQNNYYlQBaPs3+lt7ft7f5vcVBn9YEO7ZsL2hcMEADmuVHwecfAv1nlJLsT+SuiZ4tLY+8iTmjFPDfZSdSp3TM1fis8+cpgrv+ixhybgN2yAG2lTqp+OsJ4y2OI2xUU+ZW4Bp+M7EVpdMNddelGSFV7dFis9H4MzosjOGnQXBkeM+28X/0M2IsW7ySucH37sogVpv1d/J1cg66TaErgOQJ6bQc8p4ka2DgvWK8D2VnD7OiwlkuhyW83ENw/z78jGpi37C15r1bCLomOFd0Jq7RhrXXC03D84L1iqWshjdKVvCTO0QcA7yBx2cEj4qFNXq7aOgKPdXoS0Ve60v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39840400004)(136003)(66556008)(66476007)(66946007)(2616005)(4326008)(53546011)(52116002)(6506007)(26005)(186003)(16526019)(6512007)(956004)(5660300002)(44832011)(83380400001)(6486002)(316002)(478600001)(86362001)(31696002)(36756003)(8936002)(31686004)(54906003)(2906002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tdy1RSdgy6WEVT1QFrM9uCQZizGwl7L3E3k67TiUmy/U6YE/nQEtkkenzxtr1Fpq0PZ/o8onGoAy0aHt72WoVgRV0QIwIOyTZnEBnKi/bZ8Ack3iQzcDHiAE5tjRE594K+J7+D5fsPsD45yiNvyo56ajlBbr2iGET1BcBDf94XgoDjfRu+kftuzAZ3iaFeHoMs/xhpdZ6vmOCFQmW5UJnLmNJbv5clBrAGSYU065ZEOGj9eow62tJu/NzzuzuNKNiiLKDpjR6A9KEAG4EY2YzwEEjtlM7pPDjl3zX2g96cQZqXuNwiPU9mGbnpTaDz+/xfuu9/hcRwBYfdngM5OHyMQJzsAXbUWD/jJ2KOWNEZDjHex+CG+4GuhuuCEqveOAoT3GC3rGqcObK888RQ+Eplf993wlCWcoWFqzYuEJ7GUxoD4G6ZIkf+r7PzdwJDBEsGD8vLn1EC+18MEg98hvSxagjNbTqq61i+AyzsiCBcr9VoaEoYKkO4TMwqeq4Bx4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14006773-1374-4e38-3665-08d828058e17
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 14:52:39.8787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CfMH0b7F1SF+XEQFt2xMl1LgWdQuIxQKZOrLkBPlfyj7n8SDBLIs18VmshwIpJSz4InbMNk3Y5ag5TLe3hDXJPRv9ncw/w4uDEbqOlEaNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3717
Received-SPF: pass client-ip=40.107.20.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 10:52:41
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
> Before HEAD^, we needed this because bdrv_co_flush() by itself would
> only flush bs->file.  With HEAD^, bdrv_co_flush() will flush all
> children on which a WRITE or WRITE_UNCHANGED permission has been taken.
> Thus, vmdk no longer needs to do it itself.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/vmdk.c | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 62da465126..a23890e6ec 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2802,21 +2802,6 @@ static void vmdk_close(BlockDriverState *bs)
>       error_free(s->migration_blocker);
>   }
>   
> -static coroutine_fn int vmdk_co_flush(BlockDriverState *bs)
> -{
> -    BDRVVmdkState *s = bs->opaque;
> -    int i, err;
> -    int ret = 0;
> -
> -    for (i = 0; i < s->num_extents; i++) {
> -        err = bdrv_co_flush(s->extents[i].file->bs);
> -        if (err < 0) {
> -            ret = err;
> -        }
> -    }
> -    return ret;
> -}
> -
>   static int64_t vmdk_get_allocated_file_size(BlockDriverState *bs)
>   {
>       int i;
> @@ -3075,7 +3060,6 @@ static BlockDriver bdrv_vmdk = {
>       .bdrv_close                   = vmdk_close,
>       .bdrv_co_create_opts          = vmdk_co_create_opts,
>       .bdrv_co_create               = vmdk_co_create,
> -    .bdrv_co_flush_to_disk        = vmdk_co_flush,


After HEAD^ applied, wouldn't we get an endless recursion in 
bdrv_co_flush() if the HEAD (this patch) had not been merged into HEAD^?

Andrey

>       .bdrv_co_block_status         = vmdk_co_block_status,
>       .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
>       .bdrv_has_zero_init           = vmdk_has_zero_init,

