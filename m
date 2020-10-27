Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD8C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B54206E5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SuofO6bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B54206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQY5-0001sO-RV
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQIq-0000Et-E1; Tue, 27 Oct 2020 10:50:24 -0400
Received: from mail-vi1eur05on2130.outbound.protection.outlook.com
 ([40.107.21.130]:25952 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQIo-0003i0-7E; Tue, 27 Oct 2020 10:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2xqMBQfRRYjLtWU4Rd0GyXtxRVawz8ZfjDmqvkuMhwSgWmCQztvePH5x/s/VNZeeGH1gJOcO3x06fevE7r5b+LpY5O7mAbiSBw1lQ+1FusUw9MOMAg3lTcNOikYIBbteZcHflQzqlB7qtJERzwsG0BPHh/ni/WgZBXP0oCuGpqpO1WZlJjCv7wuNQ6t9QGQW6QCGE4dBz/U0loswsPkszHMl8c38rtckel5gCYdiaGOpSP0MVOIFG3JW489Wq282L2NIXUbdHPSla6+bvAhonPpHqSqNVfNsTEpReQVhF2i3GN+GQX++KeMkDqTtmUmy0RfXb8utN6Hin8uIW1+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+qM3af6TPFe1XDQ3Q8qfQZ7ZiXEAFOp+0EFSTcYjGI=;
 b=M807Xd5vcM5K3Yh7zPtlaObppXeTZCKubqLjLZWGPAiKcDsedm1qgGVvfx2vnH/VF1+Ep/NTHPcPzXdeddlTIIhhFMpIHr3WZ3hTyTfAHvxgGh9fj2wJz9GjcaEwkur4ZJr7PWR4CFGblLfhVk39JJjDFgHDs3W6oCdtP6mnWToXABoeLLIYQ6DGwm5LZGIRQIODH8156jQlSJK/SVrtw90sUzMxLQWOs1V78I0cOoqcHSC1F5i3G3zF4ItIxEBtuXpe0y3/j1vOu8jqBfy0fo48G/p8HEEu5SsDnsn/Gg1/KEi7L8NGUJJjWuA2hCIFj7XhbendCa6UWOUzDhuPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+qM3af6TPFe1XDQ3Q8qfQZ7ZiXEAFOp+0EFSTcYjGI=;
 b=SuofO6biukx2b1Fz0FXzFtiF8oIqNo8jL1J5ke+fh36bBRdQhwGpCOyKAl1Vbd5LvGummDjT4fCZflv+oiYBJ91rFAyFNP/4M5apVogXAKwoVl3RgFlSDOfO7cQb4tZcdfFvLzP7gIu2LJ2/KSIGhE8YfmJid6hShlcvDrtt2Jw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3310.eurprd08.prod.outlook.com (2603:10a6:803:4c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 14:50:18 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 14:50:18 +0000
Subject: Re: [PATCH v12 10/14] block: include supported_read_flags into BDS
 structure
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-11-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9ebf69c2-b6a9-cbeb-7aa9-f3162b67ac8c@virtuozzo.com>
Date: Tue, 27 Oct 2020 17:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-11-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:208:1::21) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:208:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 14:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b7141b-ac34-41bb-f130-08d87a879f2b
X-MS-TrafficTypeDiagnostic: VI1PR08MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB331040686400C6ABDA04A537C1160@VI1PR08MB3310.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gOn9evNuYJdd5anfQP23zWuUyac+JhPFzijtsdgy7a+L7ECq77vgoAzmFJMx8/4kw0GVs5+kmILVb10NkBYPXCrcnDBw6rMmx350MUziZqfbcY40EnBzN5racf0ybVB+yICNEc3VszWUYDJgwHdB7SpIyfFKWL3pjQHZSm3S5nhs4JsHlSZXLhEungIe2oBeQ3TY+Q6WQSjX6d7t87sNrVZ7Jkb8BSIEyP3diRHvMuUXl7n3lVAcpm++wDGw8mjAyXl5t0s+6qUWPk5yoS1RQxVs9Z/Q+/Mgoa+WrsHLUG8dmRJVuqTdsCRV1cmSyNqaPaFs+3mY90a+v3et/NdzFACerfL5OAMnkz0CA72m9kYPeZi/mQ7a7Mw8jIerQtk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39840400004)(136003)(346002)(16576012)(31696002)(36756003)(26005)(8936002)(956004)(2616005)(66946007)(66556008)(66476007)(186003)(16526019)(316002)(4326008)(52116002)(107886003)(2906002)(83380400001)(5660300002)(31686004)(478600001)(86362001)(6486002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2FxhmDvz+tLa12C9GEXXWBwN/FQWi7irkeRjvxxSa2SWN1gjTqrzrYVj+fukbxdPTpLifoscFEY18zwVcuN/Yi3SM1l7rKj6/7FNlC9L1mrADqIh3O7Y/COvb/+ftwnDz3Jx9jsIoedspvPFRwSPQYtZ7GVkF8PwfGntsptmaPwW2Fn06+byRks1abeHRQPzssazBG/rHCPXgrW1SD16suZZM2TwjrPRX1afdEYRSH+VHD1gMRUnEU2Mu5M1VJJdrdgUdjVKrlQfr1h0ACpfVYa42ospOUCCH5LgKej2+oMBEy1dSn6JYeGjK5D2OjgWyRUGWvheKeiJudysnIY4h/NGWdPaixUrO0ECwte8PM1DB4fXRWJboREuV+BSMSsnrdlrokqU7Ajn1kN0Xyzn/zYkFDbcrYbHo1QnVGBofy6n3ih3c1TLd5LoICdNHJbGfqkzbC5Cd+4b8ECsDeNQG1Euo1WGgH+GR7+jTB+6ghTd/6GzMGtMFEaifFEeqx0627L+YdypkNCxWm3+5f1+hhdEB9qSbuuxO+lY8It/sZ1jeWB3YRsYljS1+ke69QuVY46Wb4q94ogwYeuXULxsA+LYerPaPOqDKSpBD+qLo9kibGOMWSXg/yTU2geAqWnxHkfWk+zTx8/9y7aZ1VmXQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b7141b-ac34-41bb-f130-08d87a879f2b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:50:18.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf9pEzDNiyT3O01b8v6YjJeYx2cjXgYuk9UQKSAZes5Fl0FkKYG+yjHPgHiIjddaHEMBv8nV1VU4WhIclv6obGh/sbAwqnz9nEwA+rxpDFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3310
Received-SPF: pass client-ip=40.107.21.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:50:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> Add the new member supported_read_flags to the BlockDriverState
> structure. It will control the flags set for copy-on-read operations.
> Make the block generic layer evaluate supported read flags before they
> go to a block driver.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/io.c                | 12 ++++++++++--
>   include/block/block_int.h |  4 ++++
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 54f0968..78ddf13 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1392,6 +1392,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>       if (flags & BDRV_REQ_COPY_ON_READ) {
>           int64_t pnum;
>   
> +        /* The flag BDRV_REQ_COPY_ON_READ has reached its addressee */
> +        flags &= ~BDRV_REQ_COPY_ON_READ;
> +
>           ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
>           if (ret < 0) {
>               goto out;
> @@ -1413,9 +1416,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>           goto out;
>       }
>   
> +    if (flags & ~bs->supported_read_flags) {
> +        abort();
> +    }
> +

So, you decided to be strict with all read-flags passed to driver, not only PREFETCH.. It makes sense.


>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>       if (bytes <= max_bytes && bytes <= max_transfer) {
> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, flags);
>           goto out;
>       }
>   
> @@ -1428,7 +1435,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>   
>               ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
>                                        num, qiov,
> -                                     qiov_offset + bytes - bytes_remaining, 0);
> +                                     qiov_offset + bytes - bytes_remaining,
> +                                     flags);
>               max_bytes -= num;
>           } else {
>               num = bytes_remaining;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index f782737..474174c 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -873,6 +873,10 @@ struct BlockDriverState {
>       /* I/O Limits */
>       BlockLimits bl;
>   
> +    /*
> +     * Flags honored during pread
> +     */
> +    unsigned int supported_read_flags;
>       /* Flags honored during pwrite (so far: BDRV_REQ_FUA,
>        * BDRV_REQ_WRITE_UNCHANGED).
>        * If a driver does not support BDRV_REQ_WRITE_UNCHANGED, those
> 


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

