Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55501C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFF62073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KuUj85vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqlu-00051D-5m
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxqlE-0004W3-D8; Tue, 21 Jul 2020 07:48:40 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com
 ([40.107.1.108]:3556 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxqlA-0005zi-Vh; Tue, 21 Jul 2020 07:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JphRuGqs5IhHOksGl+CN72z0cDefxFA3hRaxSetFpH1C+9zVLlTk8n83QLHUphHFXhh8pdcS9H5SAtk97SaCkIBFQLlUF+B/hyota2Yth6/Et2zzZksXrFQd7RzA6Ufbu/dp7SxjzikdhgQmNUa+fIYqNeoZyfoTftp3PmRcIwbUnQ2nFQtCf0wF6o7bk1PCyGxNabHQC3r/2eD0vPcpjFw+9AKJn5pLbHsuad0Qr7P718hG+m1TFNQswCZNtHAbWL1kJa1qQXgcMkExYgwwxJkeIU7B/i3Fr2axPoH/L1vPBb2uO+n17yU6Ku96KLBqIJpPVgGb/X2nTlVHgqvgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcI+Cx1GnRfsZqCfaoJRMGf2MqlRtlOmUvkFR0zk3lQ=;
 b=gDsgWc52Ohhnd46U6WxbUt8PHdacP7ZYTAbIFspcERaGQz5akV2h08vBahF07VUFtCEVQxnEhP7y+MnNhRBa+E2ppoheE/goyIarzW/xhSeS+jHSJIYdJ/JOiM3c889DqeJbuMxUF7KqBvgXqsS2QtqTVTMsFFgonD+wcI3idczd1u6QJrv+OPuK0JNxZhZuEfPfvmocHr+9FPeqw4rVYWM59RljCIC9+sYN9fRGaWGMWAdOO4CMlDd9kt8oOapu5EYdjue/DyM3kEVIdTdwI1IgZLw7k2rYJlsRPWdzIuw1nv3EgrsjTMxwStar0bEE7QaLTCNRv+tGVcl5mHE0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcI+Cx1GnRfsZqCfaoJRMGf2MqlRtlOmUvkFR0zk3lQ=;
 b=KuUj85vOxaCzu65yIQuPIq8AApwYwwZs+O206J6WGyAUFLs9vhOPdTFRbgb+C/RXIp8b3cWKszDnlaQuPU2peRfHGX66wj9bpECXgLEOiP9WmRftMWOXiH/uDUwHst2tl20ezJt0DCx+TOfrphqN8/mJyr+xudybpAdYWuLvMNw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 11:48:32 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 11:48:32 +0000
Subject: Re: [PATCH v7 30/47] block: Report data child for query-blockstats
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-31-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <7fa01094-d032-f228-572c-681abe69632a@virtuozzo.com>
Date: Tue, 21 Jul 2020 14:48:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-31-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.14 via Frontend Transport; Tue, 21 Jul 2020 11:48:31 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9bfda2-5dfd-4b0b-da57-08d82d6bfe74
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3959D68056416B43E3E5D9E3F4780@AM6PR08MB3959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tAiPc8Bvc4xHAyArhMe2i0/QXiK63MuwPwobwCZ6pdWM3tiSlMfKJJti2y9lPRrYijd9f3nR8xqYXj+Lc32NvImoCjJkoBT5SbuLmF7tdDvYKP3fnYMDOVcR0BA4yLI2tIoCIlbXRVxUdjxn7qq0gifix5BBf2lbvTLQPqTqX7SpkdzC5w7VXJlVDywij5ZKn0zqj5lD9/vU+hgfvQMY5IUHGvSiE3KCzjppHvbMpa4ew3DDWbfOOqbaBBAx4Q8vQUknFT0F55ikfpFl6AJ3e8SnzZJbwvP/zbrFKPTnw2v6/OHhd1uz0rOOgwwrwI4HFpzZSaocVzxRq2rSgj+3bjjdKgZyW9c40xbWtl8P4fYsJyUoNlCjNXt1K25DtX5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39840400004)(366004)(6486002)(31686004)(44832011)(186003)(66946007)(36756003)(26005)(956004)(66476007)(16526019)(2616005)(53546011)(478600001)(83380400001)(6666004)(6506007)(5660300002)(66556008)(52116002)(316002)(8676002)(2906002)(6512007)(31696002)(8936002)(54906003)(86362001)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +pNyNaBrYTJzrc6ky+4Vd3nW3AzE3I4Vb3wDy5LW4EVTgR1yGjr0zcqxYYCRE2/8fqWCnUObdMAkxO+k/wxEa/6DDVD2nT/SrjLfaA+OEcAl+//kAKcTQj28/FpKybWNFYs3FnpH+shioKoerbnHysKiXdN387RkfurGG4PlhE7JmP+KSdzDd8atL5Zy7N1yPBGm2w0hSqTdMv1UyMC3JnzvoWyB8MS+q1RSt9VP1kxmHENyxLUuXRN8TH2BHq9mCB4UtVMYjrIRZ3cfqzIPc8cRCE33F8JyTxj/fshV8gpgSf/aHTGyQPLBsh4cqwFo1p8IhIGukfFom6Mvv7/SYWpAXfa+di7886cdSbgNVw9yjpuG0n2QhnrxClJ5g3wDeBMyl77WLad/vHq6fArExha0SGGaj4FNcox29tJt4S6PF+7RTnR2KyVHx9icVuEMlcVPwQ5B/+ugUbAWBVbdEKrOzzwU8BKlazTEsfmsfoP20/ZBLG3nHWu/77kDbXcj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9bfda2-5dfd-4b0b-da57-08d82d6bfe74
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 11:48:32.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j36a8HyuyjY3+tdm8fjOvHknERQqFEpfEKEuEB3zgxBl6jgqzmsJiA/BIP9DcFPh7I2X1WVh+GijJUea1q0lk5BAYZISokK3zRPbYYy6eLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Received-SPF: pass client-ip=40.107.1.108;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 07:48:34
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
> It makes no sense to report the block stats of a purely metadata-storing
> child in query-blockstats.  So if the primary child does not have any
> data, try to find a unique data-storing child.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qapi.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index 4807a2b344..c57b42d86d 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -526,6 +526,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
>   static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
>                                           bool blk_level)
>   {
> +    BdrvChild *parent_child;
>       BlockStats *s = NULL;
>   
>       s = g_malloc0(sizeof(*s));
> @@ -555,9 +556,35 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
>           s->has_driver_specific = true;
>       }
>   
> -    if (bs->file) {
> +    parent_child = bdrv_primary_child(bs);
> +    if (!parent_child ||
> +        !(parent_child->role & (BDRV_CHILD_DATA | BDRV_CHILD_FILTERED)))
> +    {
> +        BdrvChild *c;
> +
> +        /*
> +         * Look for a unique data-storing child.  We do not need to look for
> +         * filtered children, as there would be only one and it would have been
> +         * the primary child.
> +         */
> +        parent_child = NULL;
> +        QLIST_FOREACH(c, &bs->children, next) {
> +            if (c->role & BDRV_CHILD_DATA) {
> +                if (parent_child) {
> +                    /*
> +                     * There are multiple data-storing children and we cannot
> +                     * choose between them.
> +                     */
> +                    parent_child = NULL;
> +                    break;
> +                }
> +                parent_child = c;
> +            }
> +        }
> +    }
> +    if (parent_child) {
>           s->has_parent = true;
> -        s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
> +        s->parent = bdrv_query_bds_stats(parent_child->bs, blk_level);
>       }
>   
>       if (blk_level && bs->backing) {


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



