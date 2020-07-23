Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A3F2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W1GwwncT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A3F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyeqf-0004Ud-3C
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyep9-0003ON-IR; Thu, 23 Jul 2020 13:16:03 -0400
Received: from mail-eopbgr30137.outbound.protection.outlook.com
 ([40.107.3.137]:60160 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyep5-00007H-M5; Thu, 23 Jul 2020 13:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma6kCNe3B8iPE2F1kF7QEyLBiF5tJVp+4gnxJqMKOjlvcdQUDiYHvtKUTPugJi0qgNFyOSGX63KeorfxdE+lGTKsj5xsigtSWGNb+A4TQ1p2JyyPOxpen4unS8RXY5X70FyAMCICX/ms5Tuph+JnKdoFP5DkrGqzguaT6eI0RcmvhTH6P8X1xuGtD+7PNjXxzlLTjS5bYlWdwlC+WZXzSd/OnzqRmaJ7B9tVj/90zA5q2A2waBxEpSHQ1lUEHOa+KzF9v0l+sSVN8KUTa1fDIuAhKzIzx4QlUrYZzOxFe0Qxqt4L+u6t/FktDLi9X6qPRPA+JD08AO4czpHqD/hWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACQSfldUP/wL+WzC/E+gspzRrDim4+eKPVBGKkZgi5c=;
 b=HxPLUQzqIKlKJdulHIO+xW1Cx3XQLcRzcdeCAGzeldw6uJ6SKZKX1hnluSBZ90vctfAmm1I+RLBksBEOHTPkKCcBHqF/adpFzCFW3u4Ziobh4SGPkc36h5cd+rXIMBvwpagXBCU+5IQ3bczl3mEyps6fI2YUZvipQkR53h5cTgLS2gl9NxYiE7gfSABHKGKT99LbINGLy7KJJcwFvSZZzn8qmdchWKoZjOoQbs8KYUQiZGm25z9yUM5DX2N4Zl5pqM9e8XmpXng2K9/hkpPGKDpCJk0dam2bgUVoUHoGqPjUAF/eJCW9z0R1i1ht6r9mWORZ/45tRsMxF0mbaFsF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACQSfldUP/wL+WzC/E+gspzRrDim4+eKPVBGKkZgi5c=;
 b=W1GwwncTIHegdL5BLpYStBcu+sgZ/MZyh0t6TBJD07DqnkTj/sG4k/YpUlJ+8sGZOzA5MFzDXNYrGH5JsUtFTCuo4HDt/Z7s9cJmruwX3CJqx1ZhNCPekp8IowwSrSwzHwhFBR4/CBh0oJAwt8ijKPu40In50l3f/C1mIzvas2g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1907.eurprd08.prod.outlook.com (2603:10a6:203:4a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 17:15:55 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 17:15:55 +0000
Subject: Re: [PATCH v7 35/47] commit: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-36-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <1aa26d4f-c15f-bc68-f71a-341b6a391ce6@virtuozzo.com>
Date: Thu, 23 Jul 2020 20:15:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-36-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:207:5::21) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:207:5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Thu, 23 Jul 2020 17:15:51 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38328bab-e666-45d7-d6de-08d82f2c0f17
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190776F26FF23CC12655B480F4760@AM5PR0801MB1907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phgrE51KCzvcM/flqQ0xgUGaQPzMUPVSuv84cfszg3JZpltE4G19K56V/w34G5vggi7qnSz8KNvagv+5Bhfdd6vE+IYs85lsxiS9f1MkMdvNOVav+xIFQZY3y97E2vTUVfqjaUwR3YkDjd/vxLxibOR40XekICoCretnLhoeZDJ/aKIPHvK5LhCeTIudzJ1g8Q2KpDJF0GayrwiTIvjXGsr92hLgGzv9y75q5/tA0xJugyZ7pNcfMcCGIsRytVhQaNwjpjgv7uoTHDCo2/FP/cR4rxqb7hg7/1EIQoYCqsXIqm9Ga/BmN2uXsQ0jxrVl8w2C8Z3VTx8joxSH18o4m5W3lvS7KWRDLqQaiN1y3GBBCXNww+PHXqAFeWPvfAVzWjI4ZqCC/FKHXn48h5y59Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(31686004)(86362001)(16526019)(6512007)(26005)(36756003)(8936002)(53546011)(52116002)(6506007)(31696002)(66946007)(4326008)(186003)(6486002)(8676002)(83380400001)(5660300002)(2906002)(956004)(44832011)(2616005)(498600001)(66556008)(66476007)(54906003)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C5m2+tqLIWXFnN4cqFDprOvruEyL3a2zlABrhXaLjXSOliQ/AYT2aMnU7D2BIBU7t5mSeUalqrrlc93YFwrGt1xGGeKrKhWFp5mVqtAKjweJ4JKCsjSrI4N4+tS94hFhRGJd2WvEjmKmNNVU1fHLQZWbztzQKLWn2febzJittevWpvmgYJXg0Xd85odn/CO6sZW5nvYGUKeMf5n3bLpRNB5w8vhBGe7abZDFjZbY4iOc8ruMJLkry04BWmJgY61KPTUZBYG5nUIceGplCxhUHUGp6g3JwD4/tdsBlasbhPR3gz0LsRXjIgmfSTl4V7o+MmMIIflX8ftaah7SefywDP72ltHqTmAs23Asbt4Hq189RNLVs3lxQoelrB+KyS8/e3kCZ48qU/g93p/NM+L89k4kZ7HHtZqyX/fqBgFL4BRcU3G5XLZxshuUgwh0Lupb0s5XLWQorhsKJ2OiELeGrVw+6g4e1T6RQC5m/EzQsaxzDS4SamBYUi60EHlqyV+I
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38328bab-e666-45d7-d6de-08d82f2c0f17
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 17:15:55.5359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH5IGtTKXWUL5G+b5KJegorvv6jjHVAniJcMq61SGLRSS3pl3VNEs7AFhTIF6X9MdP+PGoHKm/mV6ipgqwCbPauV/PB0uxVJxuMz4imyUJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1907
Received-SPF: pass client-ip=40.107.3.137;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 13:15:56
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

On 25.06.2020 18:22, Max Reitz wrote:
> This includes some permission limiting (for example, we only need to
> take the RESIZE permission if the base is smaller than the top).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/block-backend.c          |  9 +++-
>   block/commit.c                 | 96 +++++++++++++++++++++++++---------
>   block/monitor/block-hmp-cmds.c |  2 +-
>   blockdev.c                     |  4 +-
>   4 files changed, 81 insertions(+), 30 deletions(-)
>
...
> +    /*
> +     * Block all nodes between top and base, because they will
> +     * disappear from the chain after this operation.
> +     * Note that this assumes that the user is fine with removing all
> +     * nodes (including R/W filters) between top and base.  Assuring
> +     * this is the responsibility of the interface (i.e. whoever calls
> +     * commit_start()).
> +     */
> +    s->base_overlay = bdrv_find_overlay(top, base);
> +    assert(s->base_overlay);
> +
> +    /*
> +     * The topmost node with
> +     * bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base)
> +     */
> +    filtered_base = bdrv_cow_bs(s->base_overlay);
> +    assert(bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base));
> +
> +    /*
> +     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
> +     * at s->base (if writes are blocked for a node, they are also blocked
> +     * for its backing file). The other options would be a second filter
> +     * driver above s->base.
> +     */
> +    iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
> +
> +    for (iter = top; iter != base; iter = bdrv_filter_or_cow_bs(iter)) {
> +        if (iter == filtered_base) {


The question same to mirroring:

in case of multiple filters, one above another, the permission is 
extended for the filtered_base only.

Andrey


> +            /*
> +             * From here on, all nodes are filters on the base.  This
> +             * allows us to share BLK_PERM_CONSISTENT_READ.
> +             */
> +            iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
> +        }
> +
>           ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> -                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
> -                                 errp);
> +                                 iter_shared_perms, errp);
>           if (ret < 0) {
>               goto fail;
>           }

...

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



