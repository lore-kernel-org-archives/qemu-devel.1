Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1872C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B212064C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XmT+MlDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B212064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYIF-00026j-MA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtYFA-0008Fb-Bd; Thu, 09 Jul 2020 11:13:48 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com
 ([40.107.22.111]:20416 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtYF7-0000SK-Do; Thu, 09 Jul 2020 11:13:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7qVJufr03XoigFvAO0ijgA4D358Sw7PY7zquP/k8tpVahGCTO8IQA69RAyPG1lI/Zpp3K6itlqOlgtRpdrT27iWeSubA+XHOUwzWaiFplJL6Tu6PmWlEUPnrGJbtuspUDJX8JU+Hmyp8bWi+WghdEDrgyQHMyNfeBrQHxogrw6UF62C1c3Mj0IN9fIZiXMaTrw5aafBaPS6q1947/o8Xyod2bm4yfExXq63RXxr//ZGvZSvlApx4Gw6wi7Asmu0bqKULq2M0bUznMu/QKDHqRqxWD+PIlnKa1ybADwKdM6fces7gEMaS7cp7ZzEQYNi1du+M6dg9tt4TzL+S4/H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmIrLUFWM2cFJFhxvVV+06jS6+mtpcheiJXvrVUX+IE=;
 b=bTLNbAQZg0CUPkxK71ymMhUmirVWJI2h6BFBsPP/AaRsE7L/GYJDSah18k64NAHHHK6TpNV/aBzcQb4lMFdZ3Evc6lOJ8AJYO11TU+SKrGmsst7PPzrttFsjEIQsr7XIda+df6vUFW7f+jxjwhOJZh3P7foWeZVZjOZHYPMGJ2Xi+tnU6xWHML3W/Korw33ZJRX8G6IioWmh3NnW15o5sFiYa6w1+GoFWkS+xCZjv5U17EBRVANaVgZ1s+ss1TP2/BHcWoRIfU4I/FTrgUzIGSSmJh80OOIs4Hr/aehT7cTMKx4xAHn1P/tMGyzMjwv2ecedbf314QSI6gJSO6HiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmIrLUFWM2cFJFhxvVV+06jS6+mtpcheiJXvrVUX+IE=;
 b=XmT+MlDcszG7ve10h7tMChT4su49irdFqUu8Nq4fSANxrEl30t3ZFRdIDlzaJ/tYpBwv0sokGGJaTibki0dqaPif3oJ7n4YdL49/HOrLrz0YOv3NRWPac453FGfzl3xNnosD8a/3cWzCNDYuCob6leiEQvyDk6xHnnTtS/oWy3k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3720.eurprd08.prod.outlook.com (2603:10a6:20b:8f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 15:13:42 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:13:42 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e8aa1eff-ba6c-d8f0-58a6-d7c9ddfe090e@virtuozzo.com>
Date: Thu, 9 Jul 2020 18:13:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-15-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:200:42::27) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:200:42::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend
 Transport; Thu, 9 Jul 2020 15:13:41 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b196caa-0a74-4409-1d19-08d8241aaa90
X-MS-TrafficTypeDiagnostic: AM6PR08MB3720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3720B6C76661C8FD0E3BC02BF4640@AM6PR08MB3720.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvkeRt5kignZbdUfC/qvA3Jm8LWz1HYbAYtUqAIiqcwr3sfZj9qDti4n81Nk9r65ifURqBMRa/Gv08YZbwDnISS6Pf4JobmCFoGPdbbPM/41ka20JYu9hVmSAs5ouQLZddi6xjGtmcFLglFVELkFN5LfTJueiGW2TeKqo/rZYk7FTblJwC8H1YOSKDHWtzFqhhgJuvYUvyEA+h3S27UWTXe8wWHr/uPMCpSGZ9Ayet5iwaZcNTRjUXuC8idkZgz4aMxT+oA9qMD9McOo4xl1F57lCbcYTe68J9iYaPWUOJjuSC9Ic+wqes7BTbCR89htJmn8a8KbP6vgruzLsx/ltTGnrgdtxsKDI3kHomYBu5dtv6rVbP5HKoqYmI5toXFS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39850400004)(366004)(376002)(396003)(5660300002)(6506007)(26005)(8936002)(478600001)(66556008)(66476007)(53546011)(316002)(6486002)(66946007)(4326008)(186003)(31696002)(44832011)(86362001)(6512007)(83380400001)(16526019)(956004)(54906003)(2616005)(2906002)(36756003)(31686004)(52116002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9MtX7hjfpzG1RZmtPrv29ifm8pMDOOyS7xf7EG13OOEdv+X6ZDNsMH/5GmM0cn2MNHgZRoHoxPM7FSQBwWYWq0n0n3vfYJN/zSXW8SMC1qkeggG5kCfUtOu8yZZjT5tJG7QQA6/NC5KSo2U3TL3SyXXBnTTKxk+uPp0US1MlzUYZc82qL3myz0m3knIHvMw7q8NA3w+d+5IsQbWHMkD6Qz0aRBHcVXEY/q8OhFWhpTOkjr0azLZyd2xy4l6j+j5VqHED/T6oByO5QiSm0TGp6j7yptHkWncUC/8GHQsC9DC6ec6Z1Q28XY3Zu/b2VtMNfrMeG4RZwQAv2Bd12EQ/fcEf5Ao1FE/YlQUkCUOU3+wCx5RlrWX7WDqALf7HdY6Yv+Ro0wFxUHt49IivoT5Ww/wUncrUzzIkIDMK71l31zDrxb9bixENfwInwWrX4iNEZQ/wh8Nq1mrFq7KnGwztS3UeQlk/1w7eeLvvJVOCh+XSEImN2nMxGbxlRuEvahEX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b196caa-0a74-4409-1d19-08d8241aaa90
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:13:42.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1QQl7B8Q6KtDXKjyv4lCmYXeQA0B8UMESA+cNo/BnvPZsxT9KpvbG0Eqtv0QL+Jlm1YjyrwtCka1lOIVAwcRqoqUO/cSCwfZ8cfMwGIlbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
Received-SPF: pass client-ip=40.107.22.111;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:13:43
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

On 25.06.2020 18:21, Max Reitz wrote:
> Because of the (not so recent anymore) changes that make the stream job
> independent of the base node and instead track the node above it, we
> have to split that "bottom" node into two cases: The bottom COW node,
> and the node directly above the base node (which may be an R/W filter
> or the bottom COW node).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json |  4 +++
>   block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
>   blockdev.c           |  4 ++-
>   3 files changed, 53 insertions(+), 18 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b20332e592..df87855429 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2486,6 +2486,10 @@
>   # On successful completion the image file is updated to drop the backing file
>   # and the BLOCK_JOB_COMPLETED event is emitted.
>   #
> +# In case @device is a filter node, block-stream modifies the first non-filter
> +# overlay node below it to point to base's backing node (or NULL if @base was

Forgot one thing. To me, it would be more understandable to read

"...to point to the base as backing node..." because it may be thought 
as a backing

node of the base.

Andrey

> +# not specified) instead of modifying @device itself.
> +#
>   # @job-id: identifier for the newly-created block job. If
>   #          omitted, the device name will be used. (Since 2.7)
>   #

