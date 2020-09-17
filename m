Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1ABC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D1A222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="gg2FJFIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D1A222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvr0-00033n-2u
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kIvoi-0000ZR-0Z; Thu, 17 Sep 2020 11:27:24 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:9742 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kIvoe-0006Oa-EI; Thu, 17 Sep 2020 11:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De0/sBMBezsidSeiAIZxE98MLZ0KSIIrCUuOmCNIddKFRLsH69cB8GCSZPzNiXGfJ4NTPNmeTZiP1wKtRNioCei0x3agZHJRTJb6VPYBIZVabUXrMBtXFN75lHP1OfMsZdDdYyRMW9FDOSN5DNMDZcijNsyMqeuA4QX0jDAYqBZ7eJY4XKOwSMzUGLWZYtQeO/P3plXFAuM9aGbP10A3JOoOWHuibQcVTp+4nVmRpU/ft4wMo756giwywRKn+EfmCWxh3L6JRZQH/OKmNp4neerHjvrdBEGWCYUiMRxqB+TGXSdaTtlcR2Ie7Q3ttOQ0xGeo+sCWLWtpgOenE1i0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRhKfhJB7xXCLyn01NX8MS2VG29TAVEh5G7kdbs7Jzg=;
 b=maY97qM8J411n8d88DY4Gliak0jUf6sNxD37pwepGS/qcFIwy+Ki24wKYllWJQvHWNKSaOSkouhB7DD2E46Kgew6s22/Xra1vyx37Z//BOtkrUwRHK+UyV7+4G4IRprJjv2dO+DGqTFlarOUIKaML13dcZxXdwKKBkybmNj4f4RfcVTscmSihWwm9giPQp8/TB2doEkH0SnoJFvk4OPTxrnqdEP6ygsNqX2/Ok0l9Xq1s2YSgGSNWDcyg5EuiIf2S/Ln7E2qC9Ne8iJzNtPWzNvqi4/SE8AM+7LGXOcQPSUTjVDlNLfA5BHvZcG7UluTcNAM+Zdk77DCRCmK14aCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRhKfhJB7xXCLyn01NX8MS2VG29TAVEh5G7kdbs7Jzg=;
 b=gg2FJFIsuq66BbQtgR0jhKdTZprAdO2/THM4jZ+738IQ4cTj1RrK/a69lUF/yKJLgY6XJC1B42k3W/k1qRX5c8wT8jP/C/BEWdd3qDqmJzSWLHxPrNSIedjvSQHHkDcU7QPPxf59iIwP/Mq9iLieVMThGl7H+wacUw+pMZQcF1I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3621.eurprd08.prod.outlook.com (2603:10a6:20b:4b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 15:27:14 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 15:27:14 +0000
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200810101447.7380-1-den@openvz.org>
 <20200810101447.7380-3-den@openvz.org>
 <1971fbff-b255-d0c1-bc07-553242512bcd@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <063e05ed-a942-a8f4-354e-c88dcabd2663@openvz.org>
Date: Thu, 17 Sep 2020 18:27:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1971fbff-b255-d0c1-bc07-553242512bcd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0258.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::34) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0258.eurprd05.prod.outlook.com (2603:10a6:3:fb::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 15:27:13 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5125d5d9-c60f-44ff-7303-08d85b1e2763
X-MS-TrafficTypeDiagnostic: AM6PR08MB3621:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3621C5FC199A019EBB4C571FB63E0@AM6PR08MB3621.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmIkBQpVTmVB8dqvqTidcLp+uWj9+342kdjETaiDo4jhA2fRpLFE6mjoT0mNc5NfHOWI1UqWdZ8TNrf9WXHuMNzk4XP2CAc2x4Sr/mWiZ3IOJ7hwpckKckiB5SoyEgSREdNBq1fwRTYk+a+dBJauwTxfBS44W8+XQkaNMFFyfqWN3ijUavZ2sH250vCTKbxZA+ZpQ/ZxAxIWqirp2j60Dk+DOhGJ1VdMieKgqhHmJ5xvcRvrfXfH58v1+QIDx/NbwzjCP3Hl1yiMvUEKTOzBJRoo6N6bayCp/Rc6RlX0Zwj5VOC4YufNf46KJYdVK4uNBkezfGN9LfGj/zTppvODDOhjRaPp4SruAI/mPNGwgJ900KrGWF2gGJ56XrKs3+Eqfey8yndGlGUuTzfLnZKgr/gM16Jx4ReacwnB+3w3Fxhf/pbPgkxUCsmtFYwQ8lGG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(366004)(346002)(376002)(956004)(6486002)(4326008)(36756003)(54906003)(53546011)(52116002)(5660300002)(66946007)(66556008)(66476007)(2906002)(8936002)(2616005)(83170400001)(31696002)(31686004)(16576012)(83380400001)(478600001)(16526019)(26005)(316002)(42882007)(186003)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5gOiJdvbHZmnNSQ+XhQLHwnpR4K6diLb7CfW2TpjnmNJTEeHUyujfintPK0NITOToXAb4PAfyOXZs8VZ81+K0+rG3BKEBpRM7L6gw6LpRiFdZet1ZA7Bym4zwlxyFw+fx3IXB4fANZxtgCeUxlP6jzT1V5cTeaQjHZoktVoYgtiyqyaRC3WpU54rVUW8nkb2B2rFqFVXJ0QsUOg+ec28/Zu3BIhSPldGEn/ETF1F3nwlQqxS/Enw0QjLGdDTRpg4ByadznMpTyua0JFvLJKOl48b//ig/jQpPvZuAoXhY6RcCnqJJ50VM+U9oKvFyRKKPPeDgxHoOPg91UL3idB3MrjNAPTvOj7PJ/cwCU/ALlCLzqv7SvnTS16ma+T2JGF4XXi+KOYnmILyUjTRwX8vY92deZkigYWghpAyOj62rNKnsDnkhBjukgCm4V3WyJehA+oXvfwUD3h1TVW7CAorYPg/PiezbP1BaayTs4P2GB9Z0ZyryNqF6lpIluKWpmDrAgIOoONEVhFpqhmMHDXs13k+GanQ9cBeglwi3JPKIwTWTmc0V8LP7uhHUNY01yp44fO9XVAhUzy117f5DH+iLpjhj3hHzMtzcv/VdgY/ur+lg++mFfjZG3MrwctIVzipTCiQ8bjB52xT64wkP9Pcvw==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 5125d5d9-c60f-44ff-7303-08d85b1e2763
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 15:27:14.2219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99v1vYzgIQqaK1vBoTwi8A0LPOBltrucQvVJw+GtuMcTHbw6FZfTbVsxxVrfbeSRwLZ8z5TgHQj8RuJHLeAYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3621
Received-SPF: pass client-ip=40.107.8.102; envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 11:27:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 4:56 PM, Max Reitz wrote:
> On 10.08.20 12:14, Denis V. Lunev wrote:
>> There are severe delays with IO requests processing if QEMU is running in
>> virtual machine or over software defined storage. Such delays potentially
>> results in unpredictable guest behavior. For example, guests over IDE or
>> SATA drive could remount filesystem read-only if write is performed
>> longer than 10 seconds.
>>
>> Such reports are very complex to process. Some good starting point for this
>> seems quite reasonable. This patch provides one. It adds logging of such
>> potentially dangerous long IO operations.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
>>  blockdev.c                 |  7 ++++-
>>  include/block/accounting.h |  5 +++-
>>  3 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/accounting.c b/block/accounting.c
>> index 8d41c8a83a..24f48c84b8 100644
>> --- a/block/accounting.c
>> +++ b/block/accounting.c
> [...]
>
>> @@ -182,6 +185,58 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
>>      }
>>  }
>>  
>> +static const char *block_account_type(enum BlockAcctType type)
>> +{
>> +    switch (type) {
>> +    case BLOCK_ACCT_READ:
>> +        return "READ";
>> +    case BLOCK_ACCT_WRITE:
>> +        return "WRITE";
>> +    case BLOCK_ACCT_FLUSH:
>> +        return "DISCARD";
>> +    case BLOCK_ACCT_UNMAP:
>> +        return "TRUNCATE";
> I don’t understand how FLUSH translates to DISCARD, and UNMAP to TRUNCATE.
>

Ha, seems I have made copy/pasted and missed this.
Nice catch.

>> +    case BLOCK_ACCT_NONE:
>> +        return "NONE";
>> +    case BLOCK_MAX_IOTYPE:
>> +        break;
>> +    }
>> +    return "UNKNOWN";
>> +}
>> +
>> +static void block_acct_report_long(BlockAcctStats *stats,
>> +                                   BlockAcctCookie *cookie, int64_t latency_ns)
>> +{
>> +    unsigned latency_ms = latency_ns / SCALE_MS;
>> +    int64_t start_time_host_s;
>> +    char buf[64];
>> +    struct tm t;
>> +    BlockDriverState *bs;
>> +
>> +    if (cookie->type == BLOCK_ACCT_NONE) {
>> +        return;
>> +    }
>> +    if (stats->latency_log_threshold_ms == 0) {
>> +        return;
>> +    }
>> +    if (latency_ms < stats->latency_log_threshold_ms) {
>> +        return;
>> +    }
>> +
>> +    start_time_host_s = cookie->start_time_ns / NANOSECONDS_PER_SECOND;
>> +    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",
>> +             localtime_r(&start_time_host_s, &t));
>> +
>> +    bs = blk_bs(blk_stats2blk(stats));
>> +    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, %s)\n",
>> +             block_account_type(cookie->type), cookie->bytes,
>> +             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,
> Why not just latency_ms * .001f and %.3f?
I personally dislike floating point, this leads to
a bit strange output.


>
>> +             (int)((cookie->start_time_ns / 1000000) % 1000),
> s/1000000/SCALE_MS/? (But I’m not sure whether that’s what the SCALE_?S
> are for.)
yes, you right.

>> +             bs == NULL ? "unknown" : bdrv_get_node_name(bs),
>> +             bs == NULL ? "unknown" : bdrv_get_format_name(bs),
>> +             bs == NULL ? "unknown" : bs->filename);
> Now that I’m writing this response already, I wonder whether a QMP event
> wouldn’t be nice.  (But considering that accounting apparently just
> doesn’t with -blockdev, I suppose that’s not that big of a worry.)
may be. Why not?

Though there is some note. Usually after the stall there
is a bunch of requests completed at the same time
once the storage is unfrozen, thus some aggregation
would be required.

I think that this should be made separately.
>> +}
>> +
>>  static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>>                                   bool failed)
>>  {
> [...]
>
>> diff --git a/blockdev.c b/blockdev.c
>> index 3848a9c8ab..66158d1292 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -622,7 +622,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>  
>>          bs->detect_zeroes = detect_zeroes;
>>  
>> -        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
>> +        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
>> +                qemu_opt_get_number(opts, "latency-log-threshold", 0));
> latency_log_threshold_ms is an unsigned int and so this will silently
> overflow for values >= 2^32.
>
> (Or for user-specified values < 0, which are wrapped around.)
>
>>  
>>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
>>              blk_unref(blk);
>> @@ -3727,6 +3728,10 @@ QemuOptsList qemu_common_drive_opts = {
>>              .type = QEMU_OPT_BOOL,
>>              .help = "whether to account for failed I/O operations "
>>                      "in the statistics",
>> +        },{
>> +            .name = "latency-log-threshold",
>> +            .type = QEMU_OPT_NUMBER,
>> +            .help = "threshold for long I/O report (disabled if <=0), in ms",
> Because of that overflow, negative values will not necessarily disable
> reporting, because truncating them to 32 bit may make them small
> absolute values again.
>
> In any case, I’d just say “disabled if 0”, and not mention anything
> about <0.
will do.

Thanks for review!

Den

