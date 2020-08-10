Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81A6207BB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fcDqVM62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A6207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k58PD-0006Pp-Uh
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k58O9-0005Wk-LE; Mon, 10 Aug 2020 10:02:57 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com
 ([40.107.3.129]:19316 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k58O4-0004iA-Ul; Mon, 10 Aug 2020 10:02:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyMptF/kKKjprXzwCTg+krc/PFw9FJj64ewla/X5Djc1G9l22vyOvz7HgkQS6g27SJvELd3bjbfvhU+lmHeARLXcHI+Ivc/BuZXAEPh1+A3Rjsnc5onBMoJSNdJ0tcAsPOvY9XXXTGnYh6orWHh8CUcku6vcKU4vkBlc63nZt1ZYbyTPobHSjDveJWUYbAeOh2pd3ctCR+YqGnl9UqssnxrdqWPbaf7uAsZDyCGsR2xfP7x1oklf3IrqP7QgnjY8Z+j14NVR7OicBIWSkzOQx8LlqZCm8nQmt1+Cn8UAOUE4wCoZA4Q6v5xrou4dCequ/VggUD5WNgg+UwefFSIhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU3VJIV+WJnYI8ZxVh2ly8TEAfisV6TNY2mr80tDJXw=;
 b=EnQoQPGK+CoTlPkHUWiuzc1FD05MVg4lM+U60X7PiO6NjS4+Y2/Gfk9WEQNEprbx8kNIDMLRYeMxxR0R5Xsr2pSdfMBnkbbT0abqq5XUwUvPrvPYPaYd+WZewowwtrfcg4PNwfhLc8JMkJoWp5r0p2IT9j9M3U8Aajck9e7bfGI2nDuTk9mV9Bl+uqGTjpdwmLcmNVkErDBddgpmWFU3CHlWRbt1syk3Usi1h4OYsLTazqgVLejN6Zc7BQZ/SS+NtQ+5gIh3LKpY26c7k59BY2p9FbUE0UJROU9m2pednLk5IMn+ODOcSC6asZhS6CZ4nGlPS+j4OvAIOu4hHxuB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU3VJIV+WJnYI8ZxVh2ly8TEAfisV6TNY2mr80tDJXw=;
 b=fcDqVM62ZgM9oju9me6bvkQtoIS52HPBGfclVU8rsxvw4hyBBsPtBYUxFhiXOn7j2Di7dyO0SuvpYkhM2Tbo7Wn3837/FNJhgUZr9jaSpmRVQ0eotgOIHC5t3OD4uMelttkR5UmLyd8noEWRx+FhGWZdnMft0TX2WKrc2dqLQVY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3861.eurprd08.prod.outlook.com (2603:10a6:20b:80::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 14:02:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 14:02:48 +0000
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200810123555.30481-1-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d87985bc-1f09-dcb7-3ed9-3d54a21c4da9@virtuozzo.com>
Date: Mon, 10 Aug 2020 17:02:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200810123555.30481-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0015.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.170) by
 AM0PR08CA0015.eurprd08.prod.outlook.com (2603:10a6:208:d2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 14:02:47 +0000
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae7b855-5549-456b-dffa-08d83d361011
X-MS-TrafficTypeDiagnostic: AM6PR08MB3861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3861E771646E762FBDBCE470C1440@AM6PR08MB3861.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TnbRfOtc49C+91t05BocIwVNCjwlY+m55CNM6ciLIMo+8XSsdSMo952dn5lUy1aHbq8y0E0CyVVJLocvKIbiyKDwWRw9ruInOxKfKCiu39uk0xp7qXMBrHLH1mXx/0JevUtxWJPUhudBMHZCsvnsBR1l00Ppshbhw/QNzDZkToa2FJ4oj7Kix64U9o9/NJBWyj7q9UxcWjGSIIpQhfCwdbD32xQolZwpzfeHqvxcRbccQSHq+nIlQWSSlS0J1WTS3IfqFWhaNjcaivuZSbbQKahkRo4ewVmC2byw/s/P/+835PdDRB/HEGNouNH14F0Zqln8iYLsw7c7s3xSQgjdUk8/I3PMCzlb1/ehejK8vxSMwpa0f6DbkQuoSp4MUfD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(396003)(39840400004)(346002)(186003)(5660300002)(26005)(66946007)(66556008)(66476007)(31686004)(86362001)(54906003)(52116002)(6486002)(316002)(478600001)(8936002)(36756003)(16576012)(4326008)(2616005)(956004)(8676002)(31696002)(16526019)(2906002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NG0XgExs7jx/MyFGx/lRqDEUZUf1kbmL10hVSi+v3FFtFkrRUEPCncGyJAXeJmQlkJtbUturBzPm9CJp4RzSknb5yhrHXTPyjxPW5e2XqMJRly5TD6BEKzpm+n0BzdxgazEDEYcLuIQ/fDxAz0+4wdmXwtKGsEXCY5haxxxC77QWYSS1ZDQF/8TwtrB1Qu+CFfwsHx+MkkiJ97TrykSKRYaStOXiXFz8BljFF/qqA45A3XrclkYImptL9MWAg2KCs0tskmfP1lKmxezpmMdHMxCdqfUN9PxwYkWmGKKzEX87h6Iderp2qBH3Dx8+8clK6cPCslzMyCPcpAZD0zY2JUGUOrKphvpFpUp4QxsCvISUnHV3m1maSNGCxkDl2vaET9S04J74JPrDG0tLpthuFgJ1ZkZyg0W7xPT1E0cd/sn8XZOOEwWMkh3etfuFeuPKbMrwl+6wk1ROF3qAYNVlOjkHYMZUaIamTHFc4jnplzaGGs3QaqLIZCdlbgyeS78wsKsFt+WS+ACvp/31FHYu434WU+qfK2qdwuNmptlrh9vukZaXBNbhRZE11MhlhJkLkjfwRiivweQvQ0QaQcjZGx663ZTjPxb+bYqbi4zTIoUeCywyzVgneM2d6OO1ecllpOB6kT6dRTacDEe1jONIww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae7b855-5549-456b-dffa-08d83d361011
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 14:02:48.2171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yCuW0qs2QknvT+Nt7NlDzkOWZgA85gmI6KSDLLZsug+1GJRgXqJ3gjLR62RVLDj+AAqE2XIDejTDcjs1ZF1KamipwQF1P+QDzowztPDlis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3861
Received-SPF: pass client-ip=40.107.3.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 10:02:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.08.2020 15:35, Denis V. Lunev wrote:
> The problem this patch is trying to address is libguestfs behavior on the
> appliance startup. It starts supporting to use root=UUID definition in
> the kernel command line of its root filesystem using
>      file --  /usr/lib64/guestfs/appliance/root
> This works fine with RAW image, but we are using QCOW2 as a storage to
> save a bit of file space and in this case we get
>      QEMU QCOW Image (v3), 1610612736 bytes
> instead of UUID of the root filesystem.
> 
> The solution is very simple - we should dump first 256k of the image file
> like the follows
>      qemu-io -c "read -V 0 256k" appliance | file -
> which will provide correct result for all possible types of the appliance
> storage.
> 
> Unfortunately, additional option for qemu-io is the only and the simplest
> solution as '-v' creates very specific output, which requires to be
> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
> much more intrusive.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Richard W.M. Jones <rjones@redhat.com>
> ---
> P.S. Patch to libguestfs will follow.
> 
>   qemu-io-cmds.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index baeae86d8c..7aae9726cd 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -718,7 +718,7 @@ static const cmdinfo_t read_cmd = {
>       .cfunc      = read_f,
>       .argmin     = 2,
>       .argmax     = -1,
> -    .args       = "[-abCqv] [-P pattern [-s off] [-l len]] off len",
> +    .args       = "[-abCqvV] [-P pattern [-s off] [-l len]] off len",
>       .oneline    = "reads a number of bytes at a specified offset",
>       .help       = read_help,
>   };
> @@ -728,6 +728,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>       struct timespec t1, t2;
>       bool Cflag = false, qflag = false, vflag = false;
>       bool Pflag = false, sflag = false, lflag = false, bflag = false;
> +    bool vrawflag = true;
>       int c, cnt, ret;
>       char *buf;
>       int64_t offset;
> @@ -737,7 +738,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>       int pattern = 0;
>       int64_t pattern_offset = 0, pattern_count = 0;
>   
> -    while ((c = getopt(argc, argv, "bCl:pP:qs:v")) != -1) {
> +    while ((c = getopt(argc, argv, "bCl:pP:qs:vV")) != -1) {
>           switch (c) {
>           case 'b':
>               bflag = true;
> @@ -777,6 +778,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>           case 'v':
>               vflag = true;
>               break;
> +        case 'V':
> +            vrawflag = true;
> +            break;
>           default:
>               qemuio_command_usage(&read_cmd);
>               return -EINVAL;
> @@ -869,10 +873,15 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>       if (vflag) {
>           dump_buffer(buf, offset, count);
>       }
> +    if (vrawflag) {
> +        write(STDOUT_FILENO, buf, count);
> +    }
>   
>       /* Finally, report back -- -C gives a parsable format */
> -    t2 = tsub(t2, t1);
> -    print_report("read", &t2, offset, count, total, cnt, Cflag);
> +    if (!vrawflag) {
> +        t2 = tsub(t2, t1);
> +        print_report("read", &t2, offset, count, total, cnt, Cflag);
> +    }
>   
>   out:
>       qemu_io_free(buf);
> 

I think -v and -V should be mutually exclusive, as combined output doesn't make real sense.
Still, I'm OK with it as is (as well as with -V renamed to -r). I can suggest also -d (aka dump).

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

