Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C359CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8357E206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ftu8MPdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8357E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDpY-00087k-R5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDoK-0006uT-Kc; Wed, 08 Jul 2020 13:24:45 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:57664 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDoI-0004v9-SK; Wed, 08 Jul 2020 13:24:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2PmGNnumOKKc2KeJaYIgmDXWN0d2CjgPs4Avmlg2oTQE9gt6JKKejfRyiZTz6WJbMl92zRllWyah7vMk/YePIXaUa/y4zTxMwcSAJJC5LSpDzgndlXk0pNyGeWasamdViWDACKsAahNotUCavqxiyWmsaPIz/htwkJ91hmL7CM0QXvEODUdg4PnNeUgUb9a/WYKai/wmQAMXqc+KTuakmKpGSxIzBLuw7B8aEKbHexl6AgwAFIZe7ZLBvBbTL2DMMmcDKwcCt0QFdl38aMGzgbMadahtN0rwiPnXeDLAUvKgra3QFjyWMMXNiH1ALs+TSXwcR32ntpzhIqcUWNn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuTPtbLmD/s39rjDn63FDiPdOO+qEWciuIlxAHMEUqU=;
 b=Or4wxKYAZHKVIY0SMlE/PsKpyMTMpNDaS7pwoccenoYLhlSyW6xHAgd4+N3Teihe1m1plNF0xKmJtFOl2PAwNG2SgXjqiNtmv7sKbBVHraw4DnkQqzv+TL1qSDsjlv0a+ffZHX8Y7262P1d7RH0Rv4vrlvKi03f1vdlmLkOQ2M6Mp5+WyCf/DDO+cI0WqxqBJw5vr5eNfd+NwgfIEDBUcnb0CdQ4y+rWjhyVPt1lGIyRTnCp6ly8uMSIbsvDTV+dofWIgzBCykBOyXCFB9Tv3dEbnhO1a9XES46bRg8b59WuMlWHv6kvuEWRrzj3yk89Wc0p5bjBiwXHDWRMKcBgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuTPtbLmD/s39rjDn63FDiPdOO+qEWciuIlxAHMEUqU=;
 b=Ftu8MPdzwBHa+qkoIndYC7SBA24NWPxOBIL0Y5ErSWEXCwEe/ijhXbbzONFGjWlo7dGPLjkH255ukxfGjU3Jr+WArYe9But/hGONh4A56JkZDTzzyOVEWI1KDJu+T2ZlcgFlTNAd7ZNJ7zs0eBVSucFa1QSlglSjfdLcegejA50=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:24:40 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:24:40 +0000
Subject: Re: [PATCH v7 04/47] block: bdrv_set_backing_hd() is about bs->backing
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-5-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9b61c710-175e-a681-ab8d-2680299aff14@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:24:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 17:24:39 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e05a85-eb41-4c1f-1be7-08d82363cba9
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984E55FE678B025C13194C5F4670@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8XuQQyxZsdn719DrblE2a83rHDDpIPlzMVV9JnSS6l65eO7IPix4lsebR5X783pclvFGBR3cJ9fu5VjA1apGHBHKTL80Kib63Tx6Ox8npQZBzM63tVO0wvqjnlgwZdB+nEuLDSatRMwe268UjpqpjySazZnyzMuU5pa/oqjxwe12QhcSwNn7crQNaEznIfpTcsH9sQLjPXw2mk5w+xLsRO3b2YbyuWdoxkd4N30GlMsa+ZJbmT3SV+rlasEpmqvkBE/hmB5aUOVFPGj0JX1GN4AmmmDw9bqroM7xMT7adTzsjlZoOfzPH+iHHCW1NnrVaI3NFSjeiNNH/LWM7rHD1xFhi/8ElyuhLExXCV5IRBHBN2CXC7RUBYhdcs7B/TS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(8676002)(16526019)(956004)(6512007)(2616005)(8936002)(54906003)(26005)(186003)(44832011)(31686004)(2906002)(53546011)(498600001)(4326008)(5660300002)(66556008)(52116002)(6486002)(83380400001)(86362001)(66476007)(66946007)(6506007)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DkASfvMr9kRHBII1ncvAwIGQHkuod4dAGKBomYj2xZ/PBxgFhsxLJ5DTkOqtDtNhcE3oiLRSkxeYcM3o7GUBW8MPd5HJWUxWvYLusXeWAyMn5u0X5SjMbAXpmm1p2MUgn2nwhnd3EeNMDvDSTAhzE3q9C2lijpU7jUSxLvHZ7kzXtZdZRpOb+k1qCc4TXTR3bpHk6jN8MfeGImQGEjG3qdzixli9rNXU2FT3sRVIC77P/nmT89FY6FT8c7/iegsDknZVGxnS+rxwABTq4D/KQ4qVCggxQgStdhEi35OprSaS20ZS1TtFmdLYIadFf9smKwB+I6XG1h8gLFfqhteXomG7H8C03OvYRBX7klkFGxu3sCMvdlkQE/IaxaQvaaMw4ENfi62SlI7u3FeHctE0O/T0ByKraDJWv8b1fgtaI3E9owMPlJCBGliudu444U5kI+AXHOUC4eMAdLdzwplF4r7zVCTx85lTY5529y8u4t4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e05a85-eb41-4c1f-1be7-08d82363cba9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:24:40.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kI2gugAdRGhMBHOsp+BLXYRFOTIk51vAxbXpGvHRZcXsOFin5kf0ee5aFyc3TKR23kDPU+0Cl0XRJcGHWgYF4YgKdq0FsxHui1pYKnp1Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:24:40
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
> bdrv_set_backing_hd() is a function that explicitly cares about the
> bs->backing child.  Highlight that in its description and use
> child_bs(bs->backing) instead of backing_bs(bs) to make it more obvious.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block.c b/block.c
> index f3e2aae49c..d139ffb57d 100644
> --- a/block.c
> +++ b/block.c
> @@ -2846,7 +2846,7 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
>   }
>   
>   /*
> - * Sets the backing file link of a BDS. A new reference is created; callers
> + * Sets the bs->backing link of a BDS. A new reference is created; callers
>    * which don't need their own reference any more must call bdrv_unref().
>    */
>   void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> @@ -2855,7 +2855,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>       bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
>           bdrv_inherits_from_recursive(backing_hd, bs);
>   
> -    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
> +    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
>           return;
>       }
>   
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

