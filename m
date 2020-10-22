Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD5C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15152417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dw996C7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15152417D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWp2-0007Mp-CX
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWnl-0006qa-Sl; Thu, 22 Oct 2020 05:22:29 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:23950 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWnh-0001L1-SC; Thu, 22 Oct 2020 05:22:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgAOyi9QOvYNrI+g+L/FKGhnKLBXagv8fNqNGJ/j7wseLM2vkwbrkAWoz9x8RPOZRXn8HvefzZCqz/x4Ax+2qrveIbPmP25LLZ1y0kyKWvLSozVhMPzdSmHcZk/0PzXWRHXcowPNKyrFZHTRHaSRPvRIUibdDU0t9NPcAOMaTSA5U7LTdEvPNoHIyWvWTmxp/uDN2lLpsJaarSuDWsGHBTxXLCByAF0y8bEeB6HtVPK4qbjJrC6CnkFiIdlQx6xq/lAtqvwdIxKwwhOQKZF15c93hpH1L/f4uGXGfBYrWA9r4IWCR+wjTxWY7f2FVCSMMsrARo7hH9sWH/y6RU/BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtVoQk2ZCfoVpS7FsNm2y0wI4goPC1rqbz5h51SwXMc=;
 b=FK6W6fmMXWlYOcsbxaBneugbPVMViAxmLow/k9BW1xAqG9dsgfNnokIzsMf2zXC2+nH/dL2bMtZggSIarWDh8smCv8Y+o5VIUQeU2G39UirqXzSXSXL6LnQFCt/cV537u85tcpDGdCpDv0q8exteAjRqM2eaL3z2sQ8uVGJn0b2oxUmmabTDv+2ZN1M1po6WscHRoCVFAvT01mtCUuYMFrJNUw2EM3SL5AnSWB5VSyPRPAnZP1d7DEUcmQnFwVQtjaTqHXFarmoGs+2ug+USQOxv+rj+WTbbEDFdnjmbsG6kmLAwNQInqLoFHTmCQ4teMM9JVqFLDKw1qx43mMmbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtVoQk2ZCfoVpS7FsNm2y0wI4goPC1rqbz5h51SwXMc=;
 b=dw996C7dudMGHQ62/f+lJDEkyxhS32RFRNp7iJmmpcd8u69vZGFoghzBPfUtF0kWeg7WFnvxuqYzFweRgSvP4/V18ZuRSIjc5/xEHF7j1trH91FxnNFryEPQc1pg582G3y0o6pbjqk34USWWRABFHLf11bfJxe+n3xwPn50eZZM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB5944.eurprd08.prod.outlook.com (2603:10a6:20b:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 09:22:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 09:22:21 +0000
Subject: Re: [PATCH v4 1/2] qcow2: Report BDRV_BLOCK_ZERO more accurately in
 bdrv_co_block_status()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <cover.1600698425.git.berto@igalia.com>
 <e12fc2535199ce30c2674132dd62716bbd6359b3.1600698425.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6c3b1566-2552-fc7f-40e8-1a4ba85fad83@virtuozzo.com>
Date: Thu, 22 Oct 2020 12:22:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <e12fc2535199ce30c2674132dd62716bbd6359b3.1600698425.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:208:55::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:208:55::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 09:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95154d0-032c-4a17-8d7f-08d8766bfaad
X-MS-TrafficTypeDiagnostic: AS8PR08MB5944:
X-Microsoft-Antispam-PRVS: <AS8PR08MB5944F475B8A64BC12BBDF261C11D0@AS8PR08MB5944.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vk04uoG1caX8NaJv083JWsRgI7vPzhqDtTc3nluO+KTcUgV3ciB6cB64l4cdxs9l7ln/DIowA9PhuBhRNG9T2/t+F9XjSsZE1DPwbbsJP/x89o10qdVkCr8I3N3E3kBpIrAAfyStnC0cYgJcBg5KOfGcM86d6+XEnJFc+nkBsQkd+4iaPF7a0BHuCmBIzKVb/vcKGNBjil194ZTcqLn3Yme3QDNBjpW8WsaBNMlkKGVGWkyon0HgtulrPmMv12d+GYweqwDKu5IqgMaT5S7LRpWAhtyB94ETE9ixYkBdL5xBENQxaes+YpvKlcM6f6Fpu2AkpGsiEqitqqWzln3Zz3BIgDaMeitPQJK7EXDXQcYWhey73TMLUKV/MFORl33
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(83380400001)(5660300002)(31686004)(8936002)(66476007)(36756003)(66556008)(54906003)(316002)(16576012)(2906002)(66946007)(31696002)(6486002)(478600001)(16526019)(8676002)(2616005)(86362001)(186003)(26005)(956004)(4326008)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GeJuzLwKwku5LJtHtIczsPacJQsv7cItjnHtyfyQy5hoBhlwcJYCTXJ0xABBI3Vl/SCAkCasJQCilrCM1yuosCKPwbextB4EmvY5ZVLMMLCIClcYDIAsrzmN1mDofkp+9pAXH6SCPKrP9POEUAMki/UmOEyM+MbwSJl6hS6H2qloDjGfCYLGt+uAw9UocsuGpj36SH7kwCE4vh4iAh0Oc0ZqgkVupXwUl6hYOThoN5g0OtM7mGBwQc69KXb/yYa5J6QMWo6ygSgM/qgVwVFyErADxQgo/giEgRGogwgyJ+IMChPXvNutoWwM9w8hO8i2/oxyOkxqiN665CxCXgpz/9rwqvcb+TihIPXDQ7skmivlhYJDzchry2PBTwXBF3StcaQo6zwRWz3BYceTVp9BFVCY+mckShtUQLHUIpJZrEa0Gs6T115IkcsqstMhTQoZrUZlhx/2kMgi4GZ+cl9D57T+2URjDVoBMXx/uo5I9vXv1bgyH/QgRmhU18BbZhlLQrJUn8cHshwVpiTLtm88TNYNXKH0miDE4r3dy1XC3hJevn7lOCk+2GRPG+9EYmOJHTy/9+CsgvO9mSGv9SjOUIboDp5J/e+75tMuM2htySHgZ0SAKztmVSsaNDi5XhIrpxhgVFgAiysa5Xa6yvvjPw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95154d0-032c-4a17-8d7f-08d8766bfaad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 09:22:21.3236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayTrqc7Ab/mU51Ktmrjb3SoSNwg5Gvu8Lyv5jQKFJsfD1+s1HTfOV7Vp8YE0DyT/qS2K9qQpk0lIUIjpt0UWgiI4MU63NYWa65MG7j4Vu0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5944
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 05:22:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

21.09.2020 17:30, Alberto Garcia wrote:
> If a BlockDriverState supports backing files but has none then any
> unallocated area reads back as zeroes.
> 
> bdrv_co_block_status() is only reporting this is if want_zero is true,
> but this is an inexpensive test and there is no reason not to do it in
> all cases.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/io.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index a2389bb38c..ef1ea806e8 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2391,17 +2391,17 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>   
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |= BDRV_BLOCK_ALLOCATED;
> -    } else if (want_zero && bs->drv->supports_backing) {
> +    } else if (bs->drv->supports_backing) {
>           BlockDriverState *cow_bs = bdrv_cow_bs(bs);
>   
> -        if (cow_bs) {
> +        if (!cow_bs) {
> +            ret |= BDRV_BLOCK_ZERO;
> +        } else if (want_zero) {
>               int64_t size2 = bdrv_getlength(cow_bs);
>   
>               if (size2 >= 0 && offset >= size2) {
>                   ret |= BDRV_BLOCK_ZERO;
>               }
> -        } else {
> -            ret |= BDRV_BLOCK_ZERO;
>           }
>       }
>   
> 


-- 
Best regards,
Vladimir

