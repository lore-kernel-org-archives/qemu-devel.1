Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C4C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD1F207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rvbDJJyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD1F207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6lZ-0007XI-AM
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6kC-0006ta-9v; Wed, 07 Oct 2020 06:32:24 -0400
Received: from mail-eopbgr20124.outbound.protection.outlook.com
 ([40.107.2.124]:21218 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6k9-0007lX-6C; Wed, 07 Oct 2020 06:32:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEGJEt9iQ13V3LhGnIOE0lahMG8cpUsQLTWR88JfbwrXang9RAZ4f2aK0ZyJXZ25NQLBX9YMGKc1RY47hE2S6BR8LuDivmmO1ZB1ICC1YqZI50A++Vz7/fauw4+L+QWmpwH1JaHbIdudO2OxKESqKtQVP+3jmX4rA4irNQu7IwmnrNir9kzVJak4FpmoYFNXRAq+ckhYgjMouZw2AnR7YZA/nHCCI4wrqqipPL8vGYEUEGWwYgRhOSU0ltKelazM+htsvxPvmuX8vvfsASv2jFH09XgxlMbV67jg8UwLqSFUFYuhTaCAZjlO+O62vpAICi6xNcURWzJ8dSx6CpoqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uazWx1A7LEfBKqDt04RHMX25pjALJajQmprB7TCWJF0=;
 b=hXxvhvEfl0q0QkYvzym0S4Prv9/v1pUG2GPwhUfwdodoroVFukQ1CbUZseeSc/xEowM0weCJZoVdHqf+BU/tuNZuyf3eypmYQoqfzo1OU2gzSTcPC2HiSbL/RViHvDQhlYg6CRI4vJr3QlDdnRouX5FLcAdm5I0Vncwg6AiayxTxOKM1csou9TCpMpCWj7MmN8ssZ3w4nwf+OUHxdk0vboxnUSJJssa7/+Dj3SpRrqYB9KR/rjhXYIISMips1RsOB48ATx331qr10QpUC8P+gaMcl4opD5BiA6BJwxrb8lPYqdH6yC2Xw8EQA7VNPf1mwlNmg1kLSHvftpG7cv1xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uazWx1A7LEfBKqDt04RHMX25pjALJajQmprB7TCWJF0=;
 b=rvbDJJygpxWDTddVOQEX3KV5h9Zkt3KkdkTJTHjSQ0hhPewkAoUzX94RepP+M/is8lDTIjChhk4CKBqLzBSIOiRA8tqicFOWjl/r314EqQH7QcfHZp1DpGK5gXK0nAClfxxYawGtCoI1SLGOPxByyJ53B5QxGQVutmbRyFfcpUo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4088.eurprd08.prod.outlook.com (2603:10a6:20b:a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 10:32:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 10:32:16 +0000
Subject: Re: [PATCH v2 1/5] qemu-nbd: Honor SIGINT and SIGHUP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>
Date: Wed, 7 Oct 2020 13:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200930121105.667049-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.14 via Frontend Transport; Wed, 7 Oct 2020 10:32:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dfa1d84-ade1-4204-639c-08d86aac4325
X-MS-TrafficTypeDiagnostic: AM6PR08MB4088:
X-Microsoft-Antispam-PRVS: <AM6PR08MB40885B0AECE1F49D471D8399C10A0@AM6PR08MB4088.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxRb05+E0gdh28MbVO9+xFx4PGRDSt52D5g4NKlJ2Lwg2BEumhyNlchouRQpEeGTV1yqrUbBv8Fx7ABsuggDytGdxHYR7XMKboAx5IuYMB4+PL8EcpP94lydXqw9B26+CWUBI2jeaABeprQiw4JTikeWaX+i+Ar77uXa8SAe4jzZYljQF159cj5cWLUEytQwAC4u/PykBFFsD8cCptHWC/ZUP4zfiola4Kvd317E0tnKN7Jnk2PjxufqUzz53jUKHpsNjxJNj0Z7UrtqFhrKOCir36XCjE51wmGuTp/1BgB02rsqeZcP2rIr3zO0gb03s0l4EZuUqo+hVLNcG9gzKw7I2LUW0Bycwuv8Fpdt+ruzKdnv4IHgQVhQ5zJA53cz8+zvRf4Dh6DlEM/BktSCnkVkIsBx6lN6Z4cEaxxoMeQ995bVoGHtduTcgB10cT3oPzXnu8qcUhZLE/tnhyVrrefgvIQFXftRicbzfYPwwe4v8WA/7px/m7LD07f79ngh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39840400004)(136003)(376002)(86362001)(6486002)(52116002)(8936002)(26005)(2616005)(83380400001)(31696002)(186003)(16526019)(83080400001)(956004)(2906002)(31686004)(16576012)(5660300002)(478600001)(316002)(8676002)(966005)(4326008)(36756003)(66556008)(66946007)(66476007)(43740500002)(16193025007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oWuKQj58q2a70m6R7f+5kyu6D88/mvdsrRQrG0T7YMaO4mvUznR9ys8jJG/ZrjWiLHhjFCoVvBL9+lKb6ZQvadRnJpktO/rDByDKKfP5SizAZwCCLyzX8w0LpCp5Tca1DUyCZA05zkQCzFBoGKwoUULGGGRByU5p/QK72aF/hcwqbR1V5agO0uajMt+Gp85cx2TTtRSso2wEn2onKE25AWsE9HwOkedwjkEaxC7RHQBivuDXFd8D1+iw0iKx9rAr+wixLkG5gNm011IW7YJDv+O7qR4GBU8yCSC2ilWuhDn9yRUxVf0GWZzCBpBQePdImVdWPWDbBvEIhi7eF9m6CHLhiAjg12W+a6EgPnwDhx0KWwCphglKq8rwzGVHmZ0U0HYuBDiur3AH41jYOX7IicvvPZSx6+h4H6QCb0peNcynqMxfrokMeauf2U14jdzlHCed+K4wZoid0ynJ76froiGajSqDf17aoVblVPRUiMMM7uSl6LFXMzlkL62kVClqB7MlTkDvAxm7Ql8LHMbWvaO1coWADSam43FV9dPJGzP1/MTMTbn2jNHNCzTUngTb1qZ66y6DiaIAHdNRg5ZLIuqoyBdDbtmIBrZstw6R8ehz4yfPeSC/5w74V/lQ0do7CNxgsv3izzPmnCDO88xhCQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfa1d84-ade1-4204-639c-08d86aac4325
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 10:32:16.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ4DmIw0bXwYxDzFnnJmA13gvGcPrncn5K9Z9PD/7QFHsZAK3kvoJjvBfWG3zqdHyT1MyxsYF5ldGzM64PdixvKSO4X0m+r19XkroY2oXSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4088
Received-SPF: pass client-ip=40.107.2.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 06:32:18
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

30.09.2020 15:11, Eric Blake wrote:
> Honoring just SIGTERM on Linux is too weak; we also want to handle
> other common signals, and do so even on BSD.  Why?  Because at least
> 'qemu-nbd -B bitmap' needs a chance to clean up the in-use bit on
> bitmaps when the server is shut down via a signal.

Probably not bad to update a comment [*] if you have a good wording in mind.

> 
> See also: http://bugzilla.redhat.com/1883608
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   qemu-nbd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index bacb69b0898b..e7520261134f 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -581,7 +581,7 @@ int main(int argc, char **argv)
>       const char *pid_file_name = NULL;
>       BlockExportOptions *export_opts;
> 
> -#if HAVE_NBD_DEVICE
> +#ifdef CONFIG_POSIX
>       /* The client thread uses SIGTERM to interrupt the server.  A signal
>        * handler ensures that "qemu-nbd -v -c" exits with a nice status code.

[*]

>        */
> @@ -589,9 +589,9 @@ int main(int argc, char **argv)
>       memset(&sa_sigterm, 0, sizeof(sa_sigterm));
>       sa_sigterm.sa_handler = termsig_handler;
>       sigaction(SIGTERM, &sa_sigterm, NULL);
> -#endif /* HAVE_NBD_DEVICE */
> +    sigaction(SIGINT, &sa_sigterm, NULL);
> +    sigaction(SIGHUP, &sa_sigterm, NULL);
> 
> -#ifdef CONFIG_POSIX
>       signal(SIGPIPE, SIG_IGN);
>   #endif
> 


-- 
Best regards,
Vladimir

