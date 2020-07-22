Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830CFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7F220714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GD1N66lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7F220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJXi-0005cA-Go
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyJWx-00057A-CQ; Wed, 22 Jul 2020 14:31:51 -0400
Received: from mail-eopbgr150100.outbound.protection.outlook.com
 ([40.107.15.100]:25505 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyJWu-0006gN-MF; Wed, 22 Jul 2020 14:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc7mx+PCQaIceiWGapcFRJWE/HfBwJrV4orTLNYU/z6PgJ8m01Fua4DuFuZj/1RNxFdYnaK4W74pZkybsLH8ECAbNemlqtTXls7oYJQqLLAdWvRl0302wP/xQLtU1M0yWCC85+qI30vmuBX3weewdcn4i1d6CRXPWW5exm88wcL3cuWFKNVQNee3tuBMqgGBM0uYq0/SUOHgRrbEZP2efxuSeo3WAQVnTS5xvwTnr67/rnav6rheMTSIAaQNLbSMPdpiXmD+87xpY6vj1U9vFEVzz5oO31+v/+SqYUiVdD1hqYRggQ4CtS3kVGoMoOo2c/px6qoE6wwH6M6ok6vgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqKzp8YWlo/SLHIBvbXzhHzR3JqlUQ6OWYjbH519lLs=;
 b=Mw8GTv97Y4TZxBuq3WwIsszaW/vx+s2amMiqnSqBjQPkhGksR75JwicM5N1qz9dq9eHrpFJk1oydSnk0VLJ1od/aH+8XLS8TdcJz3UCe2z1taUyJMX+1Nea2ucYJavPKj18PxIreGlG+OYDUVMrNDEMs2bzaQnVWz45jCdk1i189wThCBDgv1jFTE6NnGQjSBGwKLBn35OVle/WqGiHOJ4IST2py9y/ifvbVIc/GxsigzGJ6y2EXOWsq8vdoirRq1oBjQbiTDVo09pgbxUJkUQYq0yWGi5++ZqnuXT2a5LT+Ug+bAOh+Iw4PnS3EM4G/tRYz4jYPNZZRheE9xcqkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqKzp8YWlo/SLHIBvbXzhHzR3JqlUQ6OWYjbH519lLs=;
 b=GD1N66lXkItafKNwDk0jNxRIR8ggoURyzRGf28DEBdZegdf8rNUM9Gsu7VayV6k7ZMcB+3Y6kq0jS6t+8Tn51oBmRtxPCZiD33p0qJx418l7W3mKenzWlxzSZEXWIohwKaeDie7LPZfroZucvPYfUfOFW2y1Uen4Lxw27w5BSN0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 22 Jul
 2020 18:31:44 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 18:31:44 +0000
Subject: Re: [PATCH v7 33/47] mirror: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-34-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <b69b871a-4cc5-a09d-c20b-deaa7438afda@virtuozzo.com>
Date: Wed, 22 Jul 2020 21:31:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-34-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Wed, 22 Jul 2020 18:31:43 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d387981f-603e-406d-a2ee-08d82e6d7c1a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB434286CEF2F01A27E0BDD8F3F4790@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twsoN6YjNl243VTzS7qWHyPf6d2XyvUHuhsTM6TWxzVs4dD82e+pjUOnGPwrpwPnlmdDH6J+YuLTKnppmcsuFikC6MpVgQZzE2Zgxp7NS4vgFOTXBDrdH17XKXJ0vaDZk6q3/nUp2peqIg+vQfZbXKnkW9rZuSWWFG6M+jiBfemaO3Q0VebB8VHDnxcBOy2+LngUw3QbssSbahDcgNNQjWwi8FQy8LEzeiCXOXXqXgxBntBf9vllZiw+A51e/of9n8e6FvBHLU6JMYMBc8e2YCg4fnCAmVgzbRMELdfP0xIorUWW/abinLtfXaR/lsBwvUPc2VcWrHKzSW8bNrRiK5r2eswuIC7XKaP4yGjVNKmQX2tX6cMh2E1gQ9JGYTSNQ751rvxaXVZzWkL4oAGCNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(346002)(396003)(376002)(316002)(956004)(44832011)(2616005)(2906002)(54906003)(478600001)(5660300002)(66476007)(66556008)(31696002)(186003)(52116002)(66946007)(86362001)(31686004)(6506007)(53546011)(83380400001)(8676002)(4326008)(36756003)(26005)(8936002)(6486002)(16526019)(6512007)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6YnzSG+XaYjgxuTd2+8AJler42boE5eN4bCExG784G/CwZwylhDWjeN5KbnJi0/TsrDW98VosZcoD+ThuyyR9V7xytc7Pl33vo5hlhW7H++O/8RubnVwy88zoCVy0tu6OMH8Lk18De48EE3aQZSMx63wn61CFV1edUMrYsReP4dzvBGX/XWW6PEN8HgMFcl/WKqF9FRgam4rFdzCfrAUNXlmC414xw2HiJxm2uYJqFStF3B/ffVASF+t3upufjhdVBxoDtUzJxZIj/tyZe7NN60c/Pasg3B3YKCvAOncMaRYJiuRYyUCIVz9fBR6Tg6D6XjlFrG/BYrHbHKe/x+bW59y+kqaAvd+4LV46AbiYLnOh7DyVObiv5tREktPdLa+UznvPFGzJ6QALu72tnVzxUBkI4P7zoqZEGwH62MSXVbCqjyZCNvcgwnHbCoK3Bq7WpkpDyuRABdVMCMOMOdKxLH8U/deVEVaLcYf3rEHxL4YAbYJF+HSdqiFq9f9L2XY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d387981f-603e-406d-a2ee-08d82e6d7c1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 18:31:44.3737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUxlyQuRhtH29Kedmp72SHkPe1heUaDa/ceYzKeoZ78I2HX0fXnnXnD1X+QBQUuin/+vLKVSOCkgcpawMm+d6eid6qNyfajHDYrIZ4dbALo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.15.100;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 14:31:45
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
> take the RESIZE permission for active commits where the base is smaller
> than the top).
>
> Use this opportunity to rename qmp_drive_mirror()'s "source" BDS to
> "target_backing_bs", because that is what it really refers to.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json |   6 ++-
>   block/mirror.c       | 118 +++++++++++++++++++++++++++++++++----------
>   blockdev.c           |  36 +++++++++----
>   3 files changed, 121 insertions(+), 39 deletions(-)
>
...
> diff --git a/block/mirror.c b/block/mirror.c
> index 469acf4600..770de3b34e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -42,6 +42,7 @@ typedef struct MirrorBlockJob {
>       BlockBackend *target;
>       BlockDriverState *mirror_top_bs;
>       BlockDriverState *base;
> +    BlockDriverState *base_overlay;
>   
>       /* The name of the graph node to replace */
>       char *replaces;
> @@ -677,8 +678,10 @@ static int mirror_exit_common(Job *job)
>                                &error_abort);
>       if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>           BlockDriverState *backing = s->is_none_mode ? src : s->base;
> -        if (backing_bs(target_bs) != backing) {
> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
> +        BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
> +
> +        if (bdrv_cow_bs(unfiltered_target) != backing) {


I just worry about a filter node of the concurrent job right below the 
unfiltered_target. The filter has unfiltered_target in its parent list. 
Will that filter node be replaced correctly then?


Andrey

...

> +        /*
> +         * The topmost node with
> +         * bdrv_skip_filters(filtered_target) == bdrv_skip_filters(target)
> +         */
> +        filtered_target = bdrv_cow_bs(bdrv_find_overlay(bs, target));
> +
> +        assert(bdrv_skip_filters(filtered_target) ==
> +               bdrv_skip_filters(target));
> +
> +        /*
> +         * XXX BLK_PERM_WRITE needs to be allowed so we don't block
> +         * ourselves at s->base (if writes are blocked for a node, they are
> +         * also blocked for its backing file). The other options would be a
> +         * second filter driver above s->base (== target).
> +         */
> +        iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
> +
> +        for (iter = bdrv_filter_or_cow_bs(bs); iter != target;
> +             iter = bdrv_filter_or_cow_bs(iter))
> +        {
> +            if (iter == filtered_target) {


For one filter node only?


> +                /*
> +                 * From here on, all nodes are filters on the base.
> +                 * This allows us to share BLK_PERM_CONSISTENT_READ.
> +                 */
> +                iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
> +            }
> +
>               ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> -                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
> -                                     errp);
> +                                     iter_shared_perms, errp);
>               if (ret < 0) {
>                   goto fail;
>               }
...
> @@ -3042,6 +3053,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>                                " named node of the graph");
>               goto out;
>           }
> +        replaces_node_name = arg->replaces;


What is the idea behind the variables substitution?

Probably, the patch might be split out.

Andrey



