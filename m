Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9219C2076E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nPNiwLAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9219C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRy8-000667-B1
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPRwa-0005JI-Jp; Mon, 05 Oct 2020 10:58:28 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com
 ([40.107.5.133]:42598 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPRwW-0008N4-8p; Mon, 05 Oct 2020 10:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikl0HQZNqEQk+9hoW91zdali8cWYw1M0QtWcl/YosR8vA4OyPrLh3gn9Rgxozn+t4VP/MwDVoQXu3+gIB8MzzZnV8sR9QNOJt7bpptPZvXdrJVyfNTq2Vxbv1IgPgx0amPYyEOUCpcKYz7z29FMtHxFtdF5LBy3R0DsaJnjFxrjg2mm9T4/JKQRYx8pe8oUjXoE8jzKyOqTVenZMpNiPmDpXzw5+YJvEPXXJS3/SP3pZ7K/KNJQEBx4x6H0yDSrMmyChoKPqDjUSL4wa8qVHAC7I/mT+001/Ng/r6uUSWSJ3DXiK+jNiVKwU410iasRp/OcmqMZ8nYsO4TFxOl0oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqCcN7hiIjOiv1QBFXhdPWzO6oqaFSIAU2xI6hqqWPQ=;
 b=TixLRbxwaEKQPRG6IhCU5eMg0mlGGBN64KTP8PS74PfTLhBiIvQC+nmLRBNgGEvkrTv05/1Olg6ku5gfeVp8CCB/QLs6w2WuoMFA2qGHeRFpVcuaxM3OKqbglrCyxN3PpLjmPfTURf7gp/4uuk8TaW3hvC9f/qdTxempE+zaXZE+sZZtqUAMH2IGXyTAG4pvVtZCQJH5l9lBNaoH4dfQx4BdsHLrlT1CtMhMpfh7U7QVuu4/myCTfkHt0cCM0CkGV13Snyn6hZyIziHX6rx+vSJY4EYBBQB1B8r8S2NZlviG1BbBkcdMRtPeIpSgESdMIZylX1pGPpDWZua4XBCM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqCcN7hiIjOiv1QBFXhdPWzO6oqaFSIAU2xI6hqqWPQ=;
 b=nPNiwLAVJskpsmu+0h3vmnrRoueGufy3c8lJ4MXbWQNUJooABkW3tAeIPYxRVjRoZ6A4LbvLz2TbN2u7XhzgV6x+lHwD7sy46p8KkUL9p4lb9YFGr2xuItBCvodSyXragi7PooSY+vsxrvgC5dYt5fQ24TKfTV5Yevzfdb94Mjk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1970.eurprd08.prod.outlook.com (2603:10a6:203:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Mon, 5 Oct
 2020 14:58:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 14:58:18 +0000
Subject: Re: [PATCH v10 5/9] copy-on-read: limit guest COR activity to base in
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ab11d5f1-0832-ced7-cee7-c791d65b7131@virtuozzo.com>
Date: Mon, 5 Oct 2020 17:58:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.116]
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.116) by
 FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Mon, 5 Oct 2020 14:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6058693-d116-41ed-483d-08d8693f184e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1970:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1970E79404FFA777FE5A2D3EC10C0@AM5PR0801MB1970.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy5EZ0i38JsSIo5WalAjjvvcSc5OWcuM0oFu/LyikqXxQ0HawEzLhH8nerOnBJNJtHIC+AcLucncaPChPuvruTM+bsWqn48GoAJcsOy9VwUHxp9osfRdRqQdCdbEncM8TkASEJXsu0n/tOt8TtctImqzPISOWq6DWqFUIby2Q1fWF0bCfCjHkjQCxpFPGbSvDkkI/5TdsgrGy3WRGzDGSx3hMor6HpdD0LgfRO0AX3S7H3EujiT8ZV8yFE2dlO9NWdXBPcGF2EUbf1Jj9e2c5UXmHcQcxOGTY4UzwkAmLKp4pS/wDavJOPc8LGSTc2QeI5XJpNxIfyWLCvz1vDOjbGMKWQl3PlLUyO3WJLzBN50fS3cJrw8UMlU342PClg2C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(316002)(4326008)(16576012)(86362001)(5660300002)(36756003)(31696002)(107886003)(6486002)(8936002)(66946007)(26005)(66556008)(66476007)(16526019)(8676002)(52116002)(186003)(83380400001)(2906002)(478600001)(2616005)(31686004)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cTch55DpdVOdVWq6yTKedmdhjbvb/AICeKvlCC4vOE6z3jHeD0OKxnniQq1lqj8FJv47RKcHiVlM3ZIuIY6hwLr/DvJibIMbd86/iU4tUqsAsPtwnpLp9SElJwOhCB9MBNQpsCwR0Gs4N0u1SAiKTci9GN+BdWht7vyzlLwaQzLlbIjLMD/ViFGP6ex7ZkBWtEg2o/9z8EYEqE2QjcxAh4a9W+soJRxxzt7XXlpcoEWSXhdAvoQNs+aMHiBkU2v47sp6Omghtrt/Y/kNogTsKGRLtNu+0E3Ey+Sof7b80ciW7TGl3YUEEWJ6NZ7bFMiO8/AiVJ07mLsMqEwtWwD0RrwmCR4XcxyXM35bhZnklgzv0RI7a7x1prtEjheUw8/RZeI8FVm4wG+dZRRPtg6Qg8JKx0UMVRfZGRPOoPmhXc2F3/9hzUQqoTIuL8EPZrdcGM7QowqF+7G78SKDf1TEVyGGaNkCF02VJGkPAXoc5nHxrs9Yt6nbGn0WXyVwcRQIMQISr9zQ+CcDFLeiA7x//tC2Ia2b5T9b9Zcg9gqYVPUL5alExXSqtu1wL+ASVUpyStM+WovzDlSOfbY8pFBTNveD4A10dAAoy/8V0vyAhDPubl7arCLwPsZfMYZ4hslF8uLvx7QhWWV28wtGwXi9lg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6058693-d116-41ed-483d-08d8693f184e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 14:58:18.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/XphITUiJKz6A+6Re0eBEMt8UMSkcJd2i1ZSYZPzC0tKzaj0BJi6FaJl+4rlI+cOTHoxhq3wa3PEvX1pulzy0WKJuu4TkCUjLepatD1xB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1970
Received-SPF: pass client-ip=40.107.5.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 10:58:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

29.09.2020 15:38, Andrey Shinkevich wrote:
> Limit the guest's COR operations by the base node in the backing chain
> when the base node name is given. It will be useful for a block stream
> job when the COR-filter is applied.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index e04092f..f53f7e0 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -121,8 +121,42 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>                                              size_t qiov_offset,
>                                              int flags)
>   {
> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
> -                               flags | BDRV_REQ_COPY_ON_READ);
> +    int64_t n = 0;
> +    int64_t size = offset + bytes;
> +    int local_flags;
> +    int ret;
> +    BDRVStateCOR *state = bs->opaque;
> +
> +    if (!state->base_bs) {
> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
> +                                   flags | BDRV_REQ_COPY_ON_READ);
> +    }
> +
> +    while (offset < size) {
> +        local_flags = flags;
> +
> +        /* In case of failure, try to copy-on-read anyway */

But you add the flag only in case of success.. On any failure of furhter is*allocated calls we should set the flag.

> +        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
> +        if (!ret) {
> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
> +                                          state->base_bs, false, offset, n, &n);
> +            if (ret > 0) {
> +                local_flags |= BDRV_REQ_COPY_ON_READ;
> +            }
> +        }
> +
> +        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
> +                                  local_flags);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        offset += n;
> +        qiov_offset += n;
> +        bytes -= n;
> +    }
> +
> +    return 0;
>   }
>   
>   
> 


-- 
Best regards,
Vladimir

