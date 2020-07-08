Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CE3206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="in4zJlix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CE3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEFV-0002Ud-Pg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEEt-0001zH-8o; Wed, 08 Jul 2020 13:52:11 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:58130 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEEp-0008Cg-RZ; Wed, 08 Jul 2020 13:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kheehnz6iO5EZWHvzlCmPIiOfuu4LQLyOYVWuy1VU3/b4rlfk4/8yxwN3fiG6vGoJ+TXPoP1OYTiXZKCxDXZHc3KgJZpI4bpOtRoMdUgGnwuee3+vbRCPi38kBIwu+pgTnTu+q7Z2u8/fUWqIMpz1O2P3NUw/LyrZYYKckFNqT1DWNN2XjoUciR4cbc/bGg8A8z7vLS1Mmwu2c5zMwGviWEpC+SZaWdNVquoazqKO7gMPUnZtfQFxa6l+7l4ttwbaWCvvXqg7wC+pKoYprpOmjCOyHW98E+E1MK7IMKluxRYYVtU1lnAxGWuA89YV/c4yU+vjIDFtZwuSzl2x8yAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhKHH5oOSOHeZDOagNyQiHWa7wgy4IXD7S8+Ty9WAu8=;
 b=GOUH+Lr58EKQm03qciaT27RouiO6mn9vD/Tnn2wUfsDNmkPV/4V637qvzs55Et2fex74JmTAcaBBBvclg8XK9MICXOjPoHrSWLsksaL4xdlweF3whKjut5DP0y3xeKKCu+oPiaYesM2NRLTkraOaa9omwHmM0r3jzYWWk+eWR2us2BqEXtnluj1yB3muQzb64mTguD3+L50kv8CRDFzCDIbUw+f/NukWAzzXw2ckS2aCqcLnHW6/bm1B5b1czkKF4ABx9Byf7qDEJ/4aOiLHDdGzJwrSMPHeJB+fFmpzRI3CEdweXRoDsOqYQldQQ+4A4GeAnrgEDkz2umLlQQq6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhKHH5oOSOHeZDOagNyQiHWa7wgy4IXD7S8+Ty9WAu8=;
 b=in4zJlixu0+rEIADPowomG9LnwHcksZG4LVlYjakNepD+kD/5UG7Q9QaSejLRd7ut0cMjeENYzNarL0Piw2lFZputiPn0Yh8gjhPDdDvBrOi7GXP0RtQdQcV1C99BeAnKKxL0gd7fwvPGh7CVvbqe4Z6XGio99IY72wPoR2ysFk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:52:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:52:04 +0000
Subject: Re: [PATCH v7 08/47] throttle: Support compressed writes
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-9-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f998c19b-33a8-250f-16d8-8b37588dce8a@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:52:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-9-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:207:8::20) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR07CA0134.eurprd07.prod.outlook.com (2603:10a6:207:8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.12 via Frontend Transport; Wed, 8 Jul 2020 17:52:03 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3970ad1-2cf1-4f5a-8867-08d823679f95
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53841945D443F0B55A08A1DDF4670@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ee7kvkwHrlKeIUeorK2inFu72iF0g3TPWbDTj21ATVvefQ3tFL1BAIF5S2dZfqkRMM44DtBs9XaTMhFR6KvviR4nTlnTKbIyAwp6s4MPJRDUiN7RX9kPZqNbQL4Y2dZNZpV7c7/3+3a578patB63rWuBwSQdd4YsR8B/XdUHng6vX+CJAlbtzwtqD+oPCzKyU5PgfY/xPmlRU8wQKvlncoojWvJFWuzClgr02bQC/lPsV8G11UU7Uka0pxakJbb74+ZdwwOiTq6/2hiRB9zrZdnzf9wLkfcsV8liDT6E6VM3Oy0sWYOe/NR5RiveiLj+EezBqqwFzyDVDAbcpfWGE78kjc2n42DU5uwB+xkeMp+8p/8JlHwliDfbrlnCEmwk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(316002)(8676002)(956004)(6486002)(2616005)(44832011)(8936002)(478600001)(66556008)(66476007)(5660300002)(66946007)(31696002)(16526019)(186003)(36756003)(52116002)(4326008)(26005)(6512007)(54906003)(31686004)(83380400001)(2906002)(53546011)(86362001)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Xd4rB/D+TVf2vyYVl4hNvbjndHcikS09/iNuRSpWmCqC9ofD7CKFMiimvRs30aFYvfdT8x3DBcQMn/OdZq25P9mKny1V3Pf2qZZ37Mvbx5MOPdabjVBarhdIIojg44ixQXJAxDbRqNl9zLhUI8jdnqmmhtGeJextqVI68lIj1U2raniXgL/ZeQ/6YuCOgznTDDRtDKmcTwH9W1f2Mq54qcaOQd5FaKyA4lEHaxmU5V+PdIP0Lt468gT/WWl5Ikf3pLe3Xwva5DPJAJN8Cax/RKAtugMljOac18F2/qEhxtt36eNTMWXkdooWU6AcDO/IWJtO3MhnfrQOLfutFcNJo4XVCtzY8R5CVDMmY5BuOIht6rKXopTdQz466G0a5JPHMQLt9A2qYE3o7+K9ocR28sB2m8dBztO2fkPzkYcfPoxeQlsumC96okX3wh30GRiW0cdt4a4MBSUmU9XQxd/YAVGgc2mQNFi35SL9Ysxg/cE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3970ad1-2cf1-4f5a-8867-08d823679f95
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:52:04.0904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk/16qLLXhMnF3Nr7b8OQ84c/pSFueYisIW7mrK5BkhWK6VpCaV/i1KtPJZa87jENmbIiF0J3R8jWEMXOTtuCOaH0ytOKs+f0hcJ5ffXvu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.13.98;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:52:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/throttle.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/block/throttle.c b/block/throttle.c
> index 0ebbad0743..f6e619aca2 100644
> --- a/block/throttle.c
> +++ b/block/throttle.c
> @@ -154,6 +154,15 @@ static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
>       return bdrv_co_pdiscard(bs->file, offset, bytes);
>   }
>   
> +static int coroutine_fn throttle_co_pwritev_compressed(BlockDriverState *bs,
> +                                                       uint64_t offset,
> +                                                       uint64_t bytes,
> +                                                       QEMUIOVector *qiov)
> +{
> +    return throttle_co_pwritev(bs, offset, bytes, qiov,
> +                               BDRV_REQ_WRITE_COMPRESSED);
> +}
> +
>   static int throttle_co_flush(BlockDriverState *bs)
>   {
>       return bdrv_co_flush(bs->file->bs);
> @@ -246,6 +255,7 @@ static BlockDriver bdrv_throttle = {
>   
>       .bdrv_co_pwrite_zeroes              =   throttle_co_pwrite_zeroes,
>       .bdrv_co_pdiscard                   =   throttle_co_pdiscard,
> +    .bdrv_co_pwritev_compressed         =   throttle_co_pwritev_compressed,
>   
>       .bdrv_attach_aio_context            =   throttle_attach_aio_context,
>       .bdrv_detach_aio_context            =   throttle_detach_aio_context,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


