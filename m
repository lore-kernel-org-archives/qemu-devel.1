Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44352C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAF322B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p1Vt5/ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF322B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXSa-0002l8-AY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXRd-0001l4-G7; Mon, 20 Jul 2020 11:11:09 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:53951 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXRb-0002yR-0O; Mon, 20 Jul 2020 11:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2IaLQu65p30Q9pBzrnMY0gMFclmm7NiTD7KpToP3Zwm64sGR74Os6vo+rImvihxHIjLsm/3BUycJ26IvAfKG9hqfqFBdYEdbKpckxD6+QE01HM+p66C8hYIM2/roRKaTB/pccY26UbpOKNcv6F2WrqMWiEVp++W7hDIm63yvlFHPKQAu4EY1BWuXgjo/WRTGk1cPs87UNQGodKaJRWxgzOS7nhZNleWQBHNKY7DffengHL06NLiq/fbJ6+QuLtyqCoZJJj/dHJTck4hpmOV2w0IIXjU0g3BcvQcbnFGvLjsR42jYm7hVETXIjmQuIHdhQOB+SbxWBs5hWxtzNtbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUJLpKFaE/BTypZnbHrSVzeKqP/ppTFPp/PCukNr4OE=;
 b=dQPLmj1x3B2HfJoMcj7pm73X4S2swV4DFI0dMtVNAO0Sc8CSN3OMJZsIbkHzJsiykY4sD0gRYxbqmS8LHK74PTOGKU3awbDOqwPd2W0zVRv2n3M8teC2rgmVq7J8QjpOl8ku02PbZ9Sfs6r+rwr3tkyf9WK5ipfRgqombCZwgCTUwuZauSTVix1YB01LjmkGpH1lByQWXBmQUCZJBXx0BOga7qtUC2DDDXw6VIMMJP0WWlff3v8uiLidzSZLaH08jaHVf8+uYG9B05B9+2rcl95Z6BLnGMpKRlQsWGlJzRLT/nXA18xeCE9RxmPhnzGee8tHjY4EObkxuGDcV0Ekrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUJLpKFaE/BTypZnbHrSVzeKqP/ppTFPp/PCukNr4OE=;
 b=p1Vt5/ftyED2S6STpXJDoKk3tjbKbIxwp1GNkjcAXzg+eDnDf/jbzH2SorKB+RHBijKVQtronJ9QJGGlJ4JxnAssuja+xyfLiJv2UbrzIhm1TafuBO0vYg1VPZCPQbv6mckLLb1c3dN97j0Kga8fwrWAHbQovQzv9uV+S2TcWP8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3030.eurprd08.prod.outlook.com (2603:10a6:209:46::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 15:11:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 15:11:04 +0000
Subject: Re: [PATCH v7 27/47] blkverify: Use bdrv_sum_allocated_file_size()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-28-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <30e3d597-fa50-85dc-dc6e-37e252221f85@virtuozzo.com>
Date: Mon, 20 Jul 2020 18:10:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-28-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 15:11:01 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4da06de-3d6d-4bd3-461a-08d82cbf1ec7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303055B393625873A57EFBF5F47B0@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8HclhKMF8LwaRvxfMh4vVlHUV0OV2vJu3a5p1UOOxFzo1mCh/19ys8iLRkGMVITwBPAQtm32MgCEOFBOgX3z5fVV6A3bIwzgs1VRs/MPa+w381+seoLLv/yYjpJhcyk2s5b5g5TsHEaKP74iP8vlGhse70x7gfMted03outcXFzGfG4v2fs8etfGs7qJJkNEEXaHdlXsyNUd4Jrt5ASlUaMBPodFChZA5jtRVuplC8MJd9phRHuPRLxhaWvMzy19e5il5sLBSXYBBCZ310NX8x93kagojGVGXLc35gshid0vkFEL4oPgFTcvFxhgJD6Tcjg3tCr2OML5xWPJRWI2ISf9syesO5w4KTmSIWFSAuiHSeuZqyZiUs35A9nvOr4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(346002)(396003)(136003)(376002)(316002)(52116002)(83380400001)(186003)(16526019)(44832011)(54906003)(4326008)(956004)(2616005)(4744005)(31686004)(8676002)(66476007)(5660300002)(66946007)(66556008)(31696002)(6486002)(26005)(8936002)(36756003)(2906002)(478600001)(53546011)(6506007)(6512007)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: N5Qeuv/rKoy6qf0OMnOOszrDzwYjM64l5RPifFs9KiItSymlkpryKJIl4sceCUjn3vgbl1xZ8JFh9D0Rt7yixwEWpmcxNw1GCa59jsTxZJsuBGbWXYyrYEEjozIcPmhlMOaCFVgwY7LsWxLP2Oiy+lhD7Rpmx5tC4as06MMimSLeRR0v4mAHlljvDMMkWF8LewbLgEyRps1xOq2eHRh/1JC+OPVeoQtjs0Bv6BMr6XZafXya8mwGVa2Rq4SJpx29eta578wKiwZtJLFE/hXrrkrh8PRnxMhjaUG+3eyUeRDZzFMRZZ2ip6XBDxZLd5s/XH20ADSmafLHKSA4IXDI8A/dye5PUj/uX5VlrRMkvubuC+UebCCdsDMA2pqNmLLCaEHCaGa/tt5gSz75J/C3vMNZg+NNTB2ut6j/HpXWK5zYeE4VyVAGmwdlEUm+EBavJu99SFrdcwxDgj4El6U4XyRyot+70xGjLHzVgJnQxuMnhu62R2bzYoy/JQv8P3YO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4da06de-3d6d-4bd3-461a-08d82cbf1ec7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 15:11:04.2455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtdASD//MVfBtSx5ZoQ6trrG7vN1j2+nhQW14qEtAiywHagjtROIOAP69e5/FhSgxoSJCbkiqNWv/H7w4SQ2YSRHZ8UqoDU1SQva+tymLYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
Received-SPF: pass client-ip=40.107.8.91;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 11:11:04
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
> blkverify is a filter, so bdrv_get_allocated_file_size()'s default
> implementation will return only the size of its filtered child.
> However, because both of its children are disk images, it makes more
> sense to sum both of their allocated sizes.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/blkverify.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/blkverify.c b/block/blkverify.c
> index 2f261de24b..64858c8df0 100644
> --- a/block/blkverify.c
> +++ b/block/blkverify.c
> @@ -323,6 +323,7 @@ static BlockDriver bdrv_blkverify = {
>       .bdrv_getlength                   = blkverify_getlength,
>       .bdrv_refresh_filename            = blkverify_refresh_filename,
>       .bdrv_dirname                     = blkverify_dirname,
> +    .bdrv_get_allocated_file_size     = bdrv_sum_allocated_file_size,
>   
>       .bdrv_co_preadv                   = blkverify_co_preadv,
>       .bdrv_co_pwritev                  = blkverify_co_pwritev,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


