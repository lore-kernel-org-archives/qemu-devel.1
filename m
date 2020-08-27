Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72805C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B191207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="b6kPASEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B191207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBErI-0000gV-Gw
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kBEqT-00089I-D5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:09:25 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:46477 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kBEqR-0000iW-8q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBohqYKvwWMHaidsBqlkYILTop3AXy4FQd2JFHvqtUNb1sWhVbRjE1h80LBZz8BPMwxw44Z6wypg7FodwfgCLmjPxDk4guXzuhZa9Yw3MZzXXkd9GKY9ZuEBvMbcnOzr8oi7hgYKJPlTx9YmqXMybZov8sEeuqeAyZxB+5KnmUj9dRkjIE41MiFKIAkFNY869f0Wln29nls0GdPDMXC10TNvtUGdAMZ95Pd9wCRMOCt6FSMLoe6ur3iAaSgxNSK80QEyP+IMNmx3ZrCVQRgyhT5mL8gLlXpweCRXB+Et9JAga9CRlCmTcQTDvpHM9d62Xrj1mpCdMTYTvAFHCM3roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQnL0z9xXKJrr86Ei9arf487d5r3MxuLcVA/31GIhPk=;
 b=Sxad4YuUh6S/nRsz6u+fnlHoB76xR2g0OxQDscg+kWFvM/lQL+muJ1Eak13uPjMO9sZCYLU5nEpv6piThos/8ODO5ygGLQOcK+wVCTyOeOtvShTbbbsWFCqzS4e81dcXqgIXdz8kmV2M5F3s8y45ZkE96FV4KpfF9Ds5VXQuvvSYElZlxMiz58c1m48bs1hgW13zrZ2hWXb/YNEtYgG7aKRRIEWmt4GmFmzzth4WSQLs0vkcePlGHvKUxiWwrblza5yoBP1PjKssBiA5Yd0U2ML2hNX1TXbN2PyRrNr0Tfu7WoZUzd85lVIO++faz7lIQ3kL8g2PDm08GZ0KZKV3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQnL0z9xXKJrr86Ei9arf487d5r3MxuLcVA/31GIhPk=;
 b=b6kPASEUZYe7u1FZC8yilpK+BFslzipaH9hHCI5vBwhYyQ1PE5n6gT8vlyQcQF6E7Pt/Fd456hfS4asMANt8dD+KZyCRDZUiQKtVbm57RRpPp1sIwkYD2RFpjphH2BwjNa21aoGdmKWf7pGrzpWVcc5kbgMqVfvlXBcwLYNpTr0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6461.eurprd03.prod.outlook.com (2603:10a6:800:17c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 09:54:17 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Thu, 27 Aug 2020
 09:54:16 +0000
Subject: Re: [PATCH] linux-user: fix target_to_host_timespec64()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200827070449.2386007-1-laurent@vivier.eu>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <70b20fc1-c8d6-957f-fd21-37c61c9be7a6@syrmia.com>
Date: Thu, 27 Aug 2020 11:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200827070449.2386007-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (147.91.217.238) by
 ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 09:54:16 +0000
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb20b6ca-5fc3-4041-5cc2-08d84a6f2935
X-MS-TrafficTypeDiagnostic: VI1PR03MB6461:
X-Microsoft-Antispam-PRVS: <VI1PR03MB646195BDFD5E1A25D0FDB6B4EB550@VI1PR03MB6461.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ihKXXrXmihsfoOw5Hd3u1BhwOrUYYXK8uA/KTV32Ka9U5Pgptyq1k05zDUt0vFKyqUA41x63G5FUuUQucQ5gRg8AzbvhHYxtZscbSf6vfXjpqGjFdAiTjAjiUNx1VuKjQgOaXDZFPTEGeu94k49F3nbZT5h/1eDd19oVoynAEUPM2pYxrPyVHk/SJM9skCJ8iCxIzD8j6pti60LFEQ1r4BrogXn66cKs1ewC2m+Jciak4W61dwZLgEbwooHOFUv/I8psOL95on/6MGbKUz54unTE3K1Jcz/2ZPArKPddNY8n79MoPJNlKTIlngLbQMC/Bbm4oWnVHUBtqctdO9hgOjeSnni43D9S392BTdxFy6wiYXS+mdzmCG5ld0HCXDZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(376002)(39830400003)(346002)(136003)(6666004)(2906002)(66946007)(16526019)(66476007)(186003)(5660300002)(316002)(31686004)(66556008)(52116002)(16576012)(26005)(6486002)(956004)(31696002)(36756003)(478600001)(2616005)(86362001)(8676002)(83380400001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5Jr80duy9gg2OHAHkekW3thpUb3lYYQ7ik2xNtmb8XVlI8Nd9BtLyuzOncAmF1Fsdd3gKG6Gr1Fb8+tHFo+qBO0lcwzZOXcv4DXSJxjqSE1HemhRhFRcfKaqzRtDqi0EEpZhQbXOP3V6SdCfHzbTeo0vppQTta80Ru+J7ujP5Px+UXftBgKuiVF+l0/ogOPbjsnXzIZsfL87RxXds5J3BdLFDd3eUNOlIQYwyhANieN2uhr0/tqKESoo6iMFOvAXLiYrnrGlmgFkxYF4EwPznSoMk4QmvNBf3wpLZjfgt0PCnMLgMDIlHYRUBBfw53AhGGzrGBSzIgxRQff3Zsda5uppy00KRbr2K7FtPX+AwzZLplGcjKf74/h4VR3muTSij/f4I3CT0ckf+vNPoJBrb2UV5vHXDOItHP+lpXKI4dlXe9mTC2RoD5UfHiCeMouPIQ8pFEA1YgUMS1y1RGs26JcVB+fQ/Bl43SF/0yZ5BOcrOyP0S8WeJyV3T3272O9bJoH69knAOXXYEmslKT5h5qXSvrwobSGTHYaCujSQWUCjHcOMcZd8THZpHDOOwQjUQKhrSeylvBQ5m4N3l9dajiar8+7cIyoJgdJyyk8R/0Nt1ywS2jHpxAtycvmWfkVKTljVa43f3LyqYVZBJlCX0w==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb20b6ca-5fc3-4041-5cc2-08d84a6f2935
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 09:54:16.7972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHZK7YU/lLgy/gr6uNNfF37t9OoDROpSpzBOw7Q4k+YgplTSJebiaLCTzl/eE2gSeyWmu/YuIOpCxqRk3iNaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6461
Received-SPF: pass client-ip=40.107.3.101;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 06:09:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
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

On 27.8.20. 09:04, Laurent Vivier wrote:
> in 32 bit mode, drop the padding in tv_nsec. If host is 64bit and target
> is 32bit, the padding bytes will be copied from the target and as the
> kernel checks the value, the syscall exits with EINVAL.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c82b73e03234..9d7376734ad4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1253,6 +1253,8 @@ static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>       }
>       __get_user(host_ts->tv_sec, &target_ts->tv_sec);
>       __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    /* in 32bit mode, this drops the padding */
> +    host_ts->tv_nsec = (long)(abi_long)host_ts->tv_nsec;

I tested this with sh4 and the nsec conversion seems to be working fine now.

Just curious, why a double cast is needed '(long)(abi_long)', why not 
just '(abi_long)'?

>       unlock_user_struct(target_ts, target_addr, 0);
>       return 0;
>   }

