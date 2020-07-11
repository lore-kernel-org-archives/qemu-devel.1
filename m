Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DE2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E27320725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bID/NPui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E27320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juCoe-0007SJ-CD
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juCnu-0006yK-4f; Sat, 11 Jul 2020 06:32:22 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:55476 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juCnr-0002XA-84; Sat, 11 Jul 2020 06:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awIZ1n2Tr4pYBfvzjix0zmjVyaPla2NutmMN+DY8mZLGAUtRyCP7rdhuR7ONf6au7aXwZ4hrWWt/NJWP4I/SwdTGHqcmJnl3pW75z65/m5lM7PRclcokG3l8JVVvPsF4v24s4SKWY2be8fqrr4PdFWipYPBheVIQwaXCqFX21A3Io6jwfwBhV9FuAmLY3InjzUohNOkgLIeEhb+ZdptMg9okqy/1uuypKLzOtynhpSIb1X5SKzG9Kmk1ZYvJqRf6IspXzHB0Rt8Ipaw2tgHI6/SiaYCkk2fXQJ1fTJa3IGEjRpPIXXQdIZl4McF/6oSGP+zOmAqkb1l3P4ZzV0XF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRK4B5b0tOq5nCtSsmQOIlN2zT91TMj2bDlyvJ97mII=;
 b=O2G/DjObdjhgIb2lbVMnoUyrkDpbAG/p5ft/hQHnhOATYjTRfMYG7ma26w0yh09ixHNUjYMKB0zzkIF/w3o2EnvMyJPg1iyL7H/+vVK5i02h2k0altqkaG6bFBAfMTGo+p8KQ+vc3/3/1x8CqRJya6upKBhPJAjFZb9xEcK/Qa4O/InyzBAGyMRQliAjQTTblQtDLgMggGiufcgAbld/A0XfOnOJJwYwmEfrh9CzhsceMwqOKx2wmXAiiIsb3CMAt30JY+H9oeea0+nxjvFU1fQj/VPbbo5qPial98BfWQv4QzE0JbM/B5yyjOHASbfir+OGDgGyI2+E23kmquZJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRK4B5b0tOq5nCtSsmQOIlN2zT91TMj2bDlyvJ97mII=;
 b=bID/NPuiHBtMV+o+EhSakpfyWrBE4XaQ0LpJf5dNlqe0pMdtZII+fC50EML/TJgWG+Bta6u1IGFQGp/x2j7OUts5EFjcrBP6slWsxsnMx557QHYN1alLJNoFYED/zgS620bz1sxHdISuIjCA7pffb61BFZVs+29JWIdSssO2WCU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3094.eurprd08.prod.outlook.com (2603:10a6:209:48::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Sat, 11 Jul
 2020 10:31:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 10:31:55 +0000
Subject: Re: [PATCH 2/2] block: add logging facility for long standing IO
 requests
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200710172711.8059-1-den@openvz.org>
 <20200710172711.8059-3-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8d1f0265-5e7b-7743-3579-dc5aac6340cd@virtuozzo.com>
Date: Sat, 11 Jul 2020 13:31:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200710172711.8059-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0086.eurprd05.prod.outlook.com
 (2603:10a6:208:136::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR05CA0086.eurprd05.prod.outlook.com (2603:10a6:208:136::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Sat, 11 Jul 2020 10:31:54 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 229e4ae3-e833-40e7-db62-08d82585a1ec
X-MS-TrafficTypeDiagnostic: AM6PR08MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30947A0102E8443B0F0AB56FC1620@AM6PR08MB3094.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpclgiCBqYUPDDBtPVToBfsS2QXIjePnr38ywy0Uw7jFQC5riZYMysPIZrJ76+ZJ6gh5vSTe8cL+UdB8lcQMbIywgKxkPnQdLhvKoJfLThQlH/FvAwiI2fmZbTOptwp1Keojc2OJY4iO7MOF633QmuWq9+Xh4lcDM2EdeDk53cVzSrOUxHvshHzz82zPzjmLpmUaowiqWKLCA1psc6EuCtHFi3I0tmROY1+Nqt1L/xGpTpqEYIl5NtvosG/zb5+C3XD2kIN18Tz/hfthXoOIKTvBwBkDIOp6adNqKZFb2plnScTOd66ps/YRkDvCjHPXF/RXjEJ0ell4dwL59ItP5jhIKp+aiJHl4KGGFQQwDWli4oM4ttQX7vTY/PDkMqf2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39840400004)(52116002)(16576012)(5660300002)(316002)(8936002)(83380400001)(4326008)(2616005)(956004)(8676002)(36756003)(31696002)(478600001)(54906003)(86362001)(26005)(66946007)(6486002)(2906002)(66556008)(186003)(31686004)(66476007)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mLMuRjd58IemqqKYVi7tyA57VlGP3y4MVG9NYFsfIq2IEsvOVpb6lipt/2KKHgTOFNbvKIho1e69Xyk/kS9PV14vqLLSv2qkR/JxmQ+xuZrlP9CXmtbDmtiwggeQfU4yWnpykHow12yvch5en/J0iXic4QUekkNkjXnBLxDZ6gxqb9H1t59PI+6qngy6dcNOnmMgqiN91X2wkrehFlLfCGAe60jezCvVUN/L8mioDDjmD/iJi3EG1JXHZR+WexcYmkdcirt2dSoK3PPHCN572HQGgFQy8bKDoVQirOpeePox9krsUJs4to3QRhdeN+TbIC1DrqQyqRrnPNU0D91WzNjUFztQ99qjUwe+5EGikkqE8ddpP1IMak50PMRvPrjfWptdkOTNnRmCr9oGCNRaXaiDfuE0DOxO7me9B/wl/1BWZwzCiohwa9/cFBpXmfKqFrRX83wxCv3viWIF8f/ibkBFCf7xMzspLBkMIyriizIO+W/4axKe2gPeTXU5c/pX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229e4ae3-e833-40e7-db62-08d82585a1ec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 10:31:55.1702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUCpovmNvQz1BpuvykAR9d/PV2xafvFub7Zel2oKTYdo3VtjucanB5BaGraGlEY3zhs8goa/JPAY1LLzEHXxKwqZZRle8cXrnxekz2PZHYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3094
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 06:32:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.07.2020 20:27, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
> 
> Such reports are very complex to process. Some good starting point for this
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>   block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
>   blockdev.c                 |  7 ++++-
>   include/block/accounting.h |  5 +++-
>   3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/block/accounting.c b/block/accounting.c
> index 8d41c8a83a..3002444fa5 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -27,7 +27,9 @@
>   #include "block/accounting.h"
>   #include "block/block_int.h"
>   #include "qemu/timer.h"
> +#include "qemu/log.h"
>   #include "sysemu/qtest.h"
> +#include "sysemu/block-backend.h"
>   
>   static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
>   static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
> @@ -41,10 +43,11 @@ void block_acct_init(BlockAcctStats *stats)
>   }
>   
>   void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
> -                      bool account_failed)
> +                      bool account_failed, unsigned latency_log_threshold_ms)
>   {
>       stats->account_invalid = account_invalid;
>       stats->account_failed = account_failed;
> +    stats->latency_log_threshold_ms = latency_log_threshold_ms;
>   }
>   
>   void block_acct_cleanup(BlockAcctStats *stats)
> @@ -182,6 +185,58 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
>       }
>   }
>   
> +static const char *block_account_type(enum BlockAcctType type)
> +{
> +    switch (type) {
> +    case BLOCK_ACCT_READ:
> +        return "READ";
> +    case BLOCK_ACCT_WRITE:
> +        return "WRITE";
> +    case BLOCK_ACCT_FLUSH:
> +        return "DISCARD";
> +    case BLOCK_ACCT_UNMAP:
> +        return "TRUNCATE";
> +    case BLOCK_ACCT_NONE:
> +        return "NONE";
> +    case BLOCK_MAX_IOTYPE:
> +        break;
> +    }
> +    return "UNKNOWN";
> +}
> +
> +static void block_acct_report_long(BlockAcctStats *stats,
> +                                   BlockAcctCookie *cookie, int64_t latency_ns)
> +{
> +    unsigned latency_ms = latency_ns / 1000000;
> +    int64_t start_time_host_s;
> +    char buf[64];
> +    struct tm t;
> +    BlockDriverState *bs;
> +
> +    if (cookie->type == BLOCK_ACCT_NONE) {
> +        return;
> +    }
> +    if (stats->latency_log_threshold_ms == 0) {
> +        return;
> +    }
> +    if (latency_ms < stats->latency_log_threshold_ms) {
> +        return;
> +    }
> +
> +    start_time_host_s = cookie->start_time_ns / 1000000000ull;
> +    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",
> +             localtime_r(&start_time_host_s, &t));
> +
> +    bs = blk_bs(blk_stats2blk(stats));
> +    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, %s)\n",

Better use PRId64 for cookie->bytes
s/.03%d/.%03d/

with this fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


> +             block_account_type(cookie->type), cookie->bytes,
> +             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,
> +             (int)((cookie->start_time_ns / 1000000) % 1000),
> +             bs == NULL ? "unknown" : bdrv_get_node_name(bs),
> +             bs == NULL ? "unknown" : bdrv_get_format_name(bs),
> +             bs == NULL ? "unknown" : bs->filename);


may add blk_name as well

> +}
> +
>   static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>                                    bool failed)
>   {
> @@ -222,6 +277,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>   
>       qemu_mutex_unlock(&stats->lock);
>   
> +    block_acct_report_long(stats, cookie, latency_ns);
> +
>       cookie->type = BLOCK_ACCT_NONE;
>   }
>   
> diff --git a/blockdev.c b/blockdev.c
> index 31d5eaf6bf..d87260958c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -625,7 +625,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>   
>           bs->detect_zeroes = detect_zeroes;
>   
> -        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
> +        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
> +                qemu_opt_get_number(opts, "latency-log-threshold", 0));

Could we use non-zero default, so the option to be enabled by default?

>   
>           if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
>               blk_unref(blk);
> @@ -3740,6 +3741,10 @@ QemuOptsList qemu_common_drive_opts = {
>               .type = QEMU_OPT_BOOL,
>               .help = "whether to account for failed I/O operations "
>                       "in the statistics",
> +        },{
> +            .name = "latency-log-threshold",
> +            .type = QEMU_OPT_STRING,
> +            .help = "threshold for long I/O report (disabled if <=0), in ms",

I'd say if ==0. Anyway it's unsigned..

>           },
>           { /* end of list */ }
>       },
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index 878b4c3581..c3ea25f9aa 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -91,6 +91,9 @@ struct BlockAcctStats {
>       bool account_invalid;
>       bool account_failed;
>       BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
> +
> +    /* Threshold for long I/O detection, ms */
> +    unsigned latency_log_threshold_ms;
>   };
>   
>   typedef struct BlockAcctCookie {
> @@ -101,7 +104,7 @@ typedef struct BlockAcctCookie {
>   
>   void block_acct_init(BlockAcctStats *stats);
>   void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
> -                     bool account_failed);
> +                      bool account_failed, unsigned latency_log_threshold_ms);
>   void block_acct_cleanup(BlockAcctStats *stats);
>   void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
>   BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
> 


-- 
Best regards,
Vladimir

