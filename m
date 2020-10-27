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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47035C5DF9E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC0E21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gzD9pdw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC0E21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQbm-0007Y3-H2
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQCx-0001Pd-Of; Tue, 27 Oct 2020 10:44:19 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com
 ([40.107.15.109]:12110 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQCu-0002wt-4K; Tue, 27 Oct 2020 10:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEF7X2dc6yHDRhEy4crEpKWKL9UM2OXW8p02pbJ5PNUexKeZmP/0Nd3OCXo+Bmsv6RQJH8flQSrxjC1JZpLqXJ7j1UxNJDSwvQmlfYCzePg+T9/saw6nyR8bKn+ZEte3GHJFKtSkUgzH2RZO/+ib0My5Ba0TCVi2m1rFN367UcXj0BBUFeamHOki/rNBXr/jVQZMnTFFesnrhflvCkiG3qjzklHCjwmNlbUVo1KevccSUrIxu00t2m1n/3oappQQNixcGNArfaUN/guVTJZpH5qqspu5lZ9ybEt2keByrdDiDZM51gggehpBVpqzIsLJGqDxCiH4D/vxhMzNOiOTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kXjYlf7AoVa0cARw65cr2m/i3CCOGehxMjKxtKfbeM=;
 b=URHAk32FqPeSZKFbQ98NpWHtDVCwUsE819+qNjycFqJulv7GqcVDMRXYismpmVZdZEwIgXGfFGZeRsSRN7VvtTJJ+iAE3qdZZ6T4K8ELmr4bD5TmHe3BOsJ9TZ9xV5Vs1LTZ7dPplhXBZX4cELwgU3H3Ny/ILgGUnVFi/3L3KcBlCgI/fxQPwwZ+4zWVlbFPQwKLJeWhyTVW9+fzb6kd1RPZ4ogTaCh9hh0yahnleLPLyQlJfdO/xn2FdflFVeu7l89EIvlW3Kg0I7XprVxFSxlaBIY6jRSZWJ2vpGt+foLZMjKkJyxjpRm8+pwhTuKZDNBGJt/PhYH13WSvog7epQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kXjYlf7AoVa0cARw65cr2m/i3CCOGehxMjKxtKfbeM=;
 b=gzD9pdw33EOK9Q5n6ESS0xPnAaqUMSOdsIaMup2uLZG3qItegleod4F6P6HChksfO/3oseI0kfT++n9etFjc/3hYD1IWnz4y1AOlLKqZWovviO2xB62VUcVP6bVH/3foEhfniEBr2s7YwAwLYB8oqfcGRcwDr3HgLIk5ChSSe3U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4046.eurprd08.prod.outlook.com (2603:10a6:803:e4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 14:44:10 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 14:44:10 +0000
Subject: Re: [PATCH v12 09/14] block: modify the comment for BDRV_REQ_PREFETCH
 flag
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <72dfda6b-a5a1-644f-f0d9-263a74272cca@virtuozzo.com>
Date: Tue, 27 Oct 2020 17:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:208:1::16) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:208:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 14:44:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036d65e9-4aea-4910-ada0-08d87a86c3a1
X-MS-TrafficTypeDiagnostic: VI1PR08MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB40466E0206C8738650D15482C1160@VI1PR08MB4046.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSSVPHglNgcThXQ7YNBzuAo6pIjyVN3ZrxI/5rjgiEG9UItvZ0FFXWi6jDwt6+UATpwjjegVHv+e3Kf4UCAByDyeep0inGVf/0LXrLnmVfs7RDztStb47CFMcY/TfSSzE2r4wNzpCLsh8q81+uZaQNGni2Bbt84HXPOdrAQm3ds52sTKwXlQJGCKP0XFKFRFmXl3auKADCefMlc2x02e/H9H416ecDlKcHP2bQhu9KOs56ocop6JTmaBNzPUDTE4B6eNrbEsomj6HZeh9RrMi+RYepRhu9iBm0Ex4FdP4mthAzFoHF+wGBVX1jXY6IPyWMyhuMLPatjYhd36gPUhWD2/vv0fTPzwLIGruazkN4FuoF/Xd85xXd8vdjwoRoH8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(5660300002)(31696002)(8936002)(36756003)(16526019)(16576012)(956004)(86362001)(478600001)(52116002)(8676002)(107886003)(316002)(186003)(26005)(6486002)(2616005)(31686004)(2906002)(66476007)(4326008)(66556008)(83380400001)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dIYk4kaXhAk5JTYhE8xD2+zwwbziwMwQSKaT2i/zxodoyKvZxFUIBsqqM77zqzra3ogN06C7n5kChOnrZFCqBo+jhk4p2dAubQ64dTYOmdxfF3mOuK7GxcbtN0nFS4WkVi7OnFDsRaJObKV5D+GazMGLvR7WEII7AAERHfn0wAvJmJ0Gskdh68grPc9usOT6IiFDKp+acfuQbm/eBSqlefCYAGtbv+jdE9nMYw1HwZwUX6I7LPGNpCwZLEzHLBVlhtTKuBiQtbRp2xNrqTWiP4xZPPbsyzZBOYoxmJlh6tXtF2YIulGqXy35bfsl746ogVgJHt7FajmJ8LpGwzk/OXETPpSKUTR+XQ60EYq6XMFXP5LrSWERTfpWrUqtU6guEbdJFP8Kg9stCsP50W8iUewgWm9Vz4RBz3Yd4AK3Hy0xiPkZUuKJjefRdZHjBCIreN1a1TF3eRNBdekYv2z/AwdUBRTe9wKLNnaRae7WKkTJG9EA6JGQvyL8P/PEUWonGwte4UjKQxQNO4VHkf653wKl+Uikwms1G2Obzs77evJT+wuVex0Or9Z+yvO/djEtc3e+0qWWLSLSTdVYery09qXyoEjlqbSoQ9r7qqQDuJsH3BBsiDannY1Yi6wbg9rm1p2a4q60VUGTGcac3zVG8g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d65e9-4aea-4910-ada0-08d87a86c3a1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:44:10.2609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Nv00ohFFoM9R4N9J6fp7F8gdKtk+talPJM3tPr93Z4I0nsVcdGV8D5QTC5Pbjd7+T7e/ubCtiKFkrSn6HfOwtzpPUIH/65sHBLmcGxvwYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4046
Received-SPF: pass client-ip=40.107.15.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:44:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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
> Modify the comment for the flag BDRV_REQ_PREFETCH as we are going to
> use it alone and pass it to the COR-filter driver for further
> processing.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   include/block/block.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index ae7612f..1b6742f 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -81,9 +81,11 @@ typedef enum {
>       BDRV_REQ_NO_FALLBACK        = 0x100,
>   
>       /*
> -     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON_READ
> -     * on read request and means that caller doesn't really need data to be
> -     * written to qiov parameter which may be NULL.
> +     * BDRV_REQ_PREFETCH makes sense only in the context of copy-on-read
> +     * (i.e., together with the BDRV_REQ_COPY_ON_READ flag or when a COR
> +     * filter is involved), in which case it signals that the COR operation
> +     * need not read the data into memory (qiov) but only ensure they are
> +     * copied to the top layer (i.e., that COR operation is done).
>        */
>       BDRV_REQ_PREFETCH  = 0x200,
>       /* Mask of valid flags */
> 

I like the wording.. I think this patch should be merged together with 11 and 12 to make sense.

-- 
Best regards,
Vladimir

