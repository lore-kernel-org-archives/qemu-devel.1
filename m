Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EEF206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o6SGXNJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EEF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoEe-0004Ul-9v
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoDy-00044T-B6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoDx-0001Co-51
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:25:45 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com
 ([40.107.8.105]:11006 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQoDw-0001AP-DR; Tue, 21 Apr 2020 04:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjRAazfov72V/n7W6SqVLVYce2QJ6r09BUCqX23nYkHh/gxHqd7wiZzA8PJkMyqdgrz4lF/cPwV6jqzyS1eOnBhmYf4bjZYTjpu+MSTVJ53cGB+d2Podk4da2lU3JDG2XRjWlNQUoJSj1J9TJmlPJbgS313smkyQV6BWkRf6xI6fs0YrOQovy4MajjWwrfLF7k/NJT0kCVyTr2/k9tM5XNwBgleIkJUU33e5RkULsqPWe17BC7I3Jff4dT4XDduuvtFpaQLx0IOEFDVi9yMnHP1A2wzyidFBfOmSNwV9d01Hp3De/3fhtuX4xz2P+9EbLhmzaBEhG0tG/hpH5FiGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op56URYBy9Ue00QC+SHBj4649f54378dD8LsSRZV/3w=;
 b=hTa8BBhHFz8wunwWHbtsU2XlO9/nbnyOBy2yH/NpbTaYps3ABvo7ARae9BuqjGzlyDL3WsYJb/33VtQd7+9A0qINubtLiQCekbYMnQlVFDqzPubjsAEABJukU2fingK8GaIXlS5y+x+8rpaGIw+RwF9k2xnp6wCk1ISGFc1W+SNVVkRU+vdquTTWDZaUoeBWHaOhLMxLg7khF79F4NknT2jCn2frF7ESl+l697+bo2XAAXkB5CAz7gfIBokDfiHU8bISvIwJpQeAM4W0tdVSTxmFKRgOrwbH1nz/5MFIiaedDICGB169Ti7bLP8FmcbrE/N62Jh/5x/PDNWbV32VzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op56URYBy9Ue00QC+SHBj4649f54378dD8LsSRZV/3w=;
 b=o6SGXNJNC3+X+ZKnPpHdkQThradoS1VFh53bbvzWc/Oidk1ODyJqEG8cKaLK2FG7F2fpTUhqpNxbYvWeFGW1BQJLfvFd6EnBChY3+gIyAf9BQ9fishDlub78UN1/L/UVSJn0mSL8Z9jWh9LCQUxKAi9j/mG/Hnh3xMWzgrRGYEA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 08:25:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 08:25:40 +0000
Subject: Re: [PATCH v4 2/9] block: Add flags to bdrv(_co)_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421112537133
Message-ID: <8964e423-36f3-77d2-dbf1-ed5490e911b7@virtuozzo.com>
Date: Tue, 21 Apr 2020 11:25:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:200:89::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM4PR0202CA0009.eurprd02.prod.outlook.com (2603:10a6:200:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 08:25:39 +0000
X-Tagtoolbar-Keys: D20200421112537133
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914bbc32-1288-41ab-5a46-08d7e5cd933e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-Microsoft-Antispam-PRVS: <AM7PR08MB549327882B6E5A2BA2B1EB33C1D50@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(4326008)(956004)(8676002)(8936002)(2616005)(5660300002)(81156014)(31696002)(316002)(478600001)(86362001)(16576012)(186003)(31686004)(16526019)(26005)(36756003)(6486002)(2906002)(66946007)(66476007)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihx62PrKOH+i9vG0dvLLihlpFMAazHDx4Grn737fK643NlqBOS/xjWrL+yblNINcGretYFDctK2YfCJ4toC5a9eBkmSQXqV6jLQ5Mx1te1A9SAKIT+YgjHW97vuYs5hvk1COw3nYX/D7QksCzV9xwTOc52EP+nPPvMrcIAEJhkmr0/YQfXql4sawNXXCp4w1J7hhUr3GmxQ4x0KCDc5elj91zw+n1DsbDtCOwpa5z5QcZ1J+fEpqdZ4OkPmioFrII6gG/nNTvWnKVK9Bk5Xp91eGTXTcGWCVxAwAAHhEXKnMtokcLLiD3OueO2mBnpiitRxZimty8j6ibhG4/4iMt2O3MpM7LCzi1t6eqDAeylrLhljLPJWSv0/99r6+5jevSz1cyyFrZk9F07j6Iz2qbeirN2BFHbshmUA5Ly/N4LvmyTUkPPtuKr++NSIZrnuI
X-MS-Exchange-AntiSpam-MessageData: fuZjwn47MWChaFH3tZv/mAc4xgzvSF48pLs1KZLGO/GGVjk0aTDoP/lckw+s9Z21rF9VyRkU41FIblYMYTGiY9EpVENweRA0CnKGsAehRkIT5+YhJrvoX94NOSpMMJQA2WtIj4hGQ2qWf8AMAZrTrg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914bbc32-1288-41ab-5a46-08d7e5cd933e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:25:39.9300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj5wM0dFbhb9Flv/E3gD6ufteiogSWk7X0On4MfF9aBtqbl0k3zZsznMvL0HCvIenNUOk8vA/WPJKkvo4syImkH8r98sktFWlHEL/sHOnXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.8.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:25:41
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.105
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> Now that block drivers can support flags for .bdrv_co_truncate, expose
> the parameter in the node level interfaces bdrv_co_truncate() and
> bdrv_truncate().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---

[..]

> @@ -4169,7 +4170,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>           new_file_size = allocation_start +
>                           nb_new_data_clusters * s->cluster_size;
>           /* Image file grows, so @exact does not matter */
> -        ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, errp);
> +        ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, 0, errp);

over-80 line

>           if (ret < 0) {
>               error_prepend(errp, "Failed to resize underlying file: ");
>               qcow2_free_clusters(bs, allocation_start,
> @@ -4348,7 +4349,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>           if (len < 0) {
>               return len;
>           }
> -        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
> +        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, 0, NULL);

and this one



-- 
Best regards,
Vladimir

