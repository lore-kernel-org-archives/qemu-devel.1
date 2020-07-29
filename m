Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140292076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="Enq8iKwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140292076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jwc-0000mO-9C
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k0jvB-0008Ep-It; Wed, 29 Jul 2020 07:06:53 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com
 ([40.107.8.132]:56740 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k0jv8-0007Hc-S7; Wed, 29 Jul 2020 07:06:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH+p1QlzV3uuoAeWc1IXywzvWAeG2mGeB0de30/1qkPp28QvroxCJFtjRsuZImYBtCVq9Z5ICjqaygbKi3cykKQHqxCKz2ROoElbgIESKTfRHp135kyzdtg416lciFIRgUgjhIqZEgqJLBri5rHCjNuX1OZF+2mHWxuodkPPuxQsUf3vQTHoNUHA5PcCc6iFWRfLwd4aawGhr84KATrVuTNr2ggAP9ceizDYGfsCGerXNq/+xegvEUh68LipPbi5YWWVqYfLKKnJ3CwPTER3QMWrLPX4K4z5astVd2WJIm8BSYBCu/OLj7B/x5Gg5gPkkE/mmYCbyPikgtFMV+njQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPqU7JwXpbjlvfzI8UGJKIqn0LoyOX8Wvi7EFZUglgw=;
 b=IyGajXfbuqDki1nwALLey8ue34oVwxtt5aCIG7oI04m7lZFQkQZR7brH9iIWXBUu5s2WG0lDbVQ6NKaToO8cOFE0TyU5/QMFb4wohoTehIKn4xKG4Ty7uWxZfiK9GEr0EdvF5Dwgt3//xkMqTcybEHkNY7PQ5207RAJ2cGFBMLpnloY5pE3Hsp6CRlg5rWSOQQhVmoOAoW60U33VooYj4wcMqzpl/t/t5MEjTZGYi1zidj9ZF0g+Poonblpls66XhdlJG+ptAWcpBZrfXYewkylO6P6iX+IZLQvu+OF6DU9g8n4pdaFQdp/RjMtZLEYlSOvv1K2CidXYx8W7jyFmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPqU7JwXpbjlvfzI8UGJKIqn0LoyOX8Wvi7EFZUglgw=;
 b=Enq8iKwuUF/VpyF+lGkmWjebg044LnbeB1oaFy8Eh7/3DBfkUdt1RGSor0hHgE1ArqtDtLfBD/Lig2/mqGvtlsycujAf1e4B0oW4wet60tZt7RFFWrMsBTk7s6BOechaOe6F0V8uZn8mRoEnoeUUQ+bscslETIoKvEHuSuXf3mg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 29 Jul
 2020 11:06:46 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 11:06:46 +0000
Subject: Re: [PATCH 2/2] block: add logging facility for long standing IO
 requests
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200710172711.8059-1-den@openvz.org>
 <20200710172711.8059-3-den@openvz.org>
 <20200729103029.GB37763@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <914c161e-31b6-b7b2-2cc7-788c1e6f8f98@openvz.org>
Date: Wed, 29 Jul 2020 14:06:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729103029.GB37763@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0501CA0040.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::50) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0501CA0040.eurprd05.prod.outlook.com (2603:10a6:3:1a::50) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 29 Jul 2020 11:06:45 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e694d29-698d-4be8-6579-08d833af7bc0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB533474F3C3B8753D2A047370B6700@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIs7R7Rd3Cl9RNOwL2FWYw/YkilniElzUNzMEDG69XYfcKBCBqi46xkn068V6gKEub40lwbh1CDms/wdnsi+jwy265UCkelK/4XDLpCcxZXut5F5Mit+uKGsLT8aKE3XzZ6MLzB3ym7+FsXEvmZ+lX1gXRMI7ROVMRR3uiz+MU8SeEkD1H1rcAXPpH0evVBpFBkAhGPwMzShvExv95EcYQsz04259EqUd2kAyG+3JhG1fc6dVjDdzFT1kS4604rbNo3LQEQL3wfAi2f72SZl/HPphE9E3enI3VHxyl1oBRhJMT76j+X5TEAYKJzdvMcV808IKy3h1g/Ifrh+8VIOGrHvB/TJy3wz2lcuQ+W28BL+uvFAY9yW9/mAXwDWU8l6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39830400003)(136003)(366004)(376002)(5660300002)(66946007)(2616005)(66476007)(16526019)(186003)(26005)(53546011)(66556008)(956004)(52116002)(2906002)(478600001)(54906003)(16576012)(8676002)(4326008)(8936002)(83380400001)(31686004)(316002)(36756003)(31696002)(42882007)(83170400001)(6916009)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zLJVOsMehcYp9p/M888EepZas4o1HDIxL6FxBXYbSXek+yLo7KkgkawBNV+kNUap586iM3swUEWwjQHURRIC/otePTZmsnwKzoxcpUACQbw7ub5WZZlBwbpaW79C+y+1jSyBC8tZ7fZWK/Svsfl7LiCRo74FHXILOdYl6EEigGPTou9Y3H53js7DizREBvYRrSp2jiLqnmtaP4l2Kyy+KkzDky4hk+xcqS3eA8cRDegbsuXbO/UXA7d5mG6g2uBlERxsTPQctSwcKEw1dGZ+t860RcUAdzT5358yUtnH2GWSqYNVOfEWUfZs3rYrMPwzI1W0DK8km8ATz0ETvimRiChN1meo0F8gC9gG8U8dq1Y5TB+sWUPiSe6RA1JSt944A4X6OrasAAPG7p870v0WSj6VonXAKUXLDmPzQZ1Vm+Y5+/sgpsr/nij/yCu3xod5hy2TTHqcEtyejCZ7zAysgZ1sJ6oT/yMKw2r/GkWbypz40TlWlGueSKI9QrdKqqA5IS1EdKkGRUrqXwU6eSd1J4Kqp+MFMuUIXna0qs3gY7HrHnsdGb+l+p4r5SGRGtJ/2MpNUHqRnmItkpiWhrPss19Xd2upQmy3qu+VYq1oll1DwwufacR+J7SDB45wjHLbd1dj458QXRQladysh9Ky4Q==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e694d29-698d-4be8-6579-08d833af7bc0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 11:06:46.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkI9q4Fn+fLc13ggP3x/8+UkrgW0TJYVGeeeY0hDh/1PA+78novIpqocW+20EIUdO1QdhxESBun8PaIPSmuSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.8.132; envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 06:18:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 1:30 PM, Stefan Hajnoczi wrote:
> On Fri, Jul 10, 2020 at 08:27:11PM +0300, Denis V. Lunev wrote:
>> +static void block_acct_report_long(BlockAcctStats *stats,
>> +                                   BlockAcctCookie *cookie, int64_t latency_ns)
>> +{
>> +    unsigned latency_ms = latency_ns / 1000000;
> Please use SCALE_MS.
sure

>
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
>> +    start_time_host_s = cookie->start_time_ns / 1000000000ull;
> Please use NANOSECONDS_PER_SECOND.
sure

>> diff --git a/blockdev.c b/blockdev.c
>> index 31d5eaf6bf..d87260958c 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -625,7 +625,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>  
>>          bs->detect_zeroes = detect_zeroes;
>>  
>> -        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
>> +        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
>> +                qemu_opt_get_number(opts, "latency-log-threshold", 0));
>>  
>>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
>>              blk_unref(blk);
>> @@ -3740,6 +3741,10 @@ QemuOptsList qemu_common_drive_opts = {
>>              .type = QEMU_OPT_BOOL,
>>              .help = "whether to account for failed I/O operations "
>>                      "in the statistics",
>> +        },{
>> +            .name = "latency-log-threshold",
>> +            .type = QEMU_OPT_STRING,
> QEMU_OPT_NUMBER?
good catch! we have this parameter on by default (10 seconds) and never
passed it from the command line :)

Thus should we keep this off be default or on? :)

Den

