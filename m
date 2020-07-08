Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A6DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078CD206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DK8Yx3Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078CD206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEHp-0004S8-80
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEGr-0003VN-B3; Wed, 08 Jul 2020 13:54:13 -0400
Received: from mail-eopbgr130104.outbound.protection.outlook.com
 ([40.107.13.104]:49892 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtEGp-0008Mf-QQ; Wed, 08 Jul 2020 13:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWrijCeIESlXk+tv7C+aOeZaKx9t3ATMLAnw4CEI1N8BY9F+jVc01We7Qo3g9IYHasZxLfY1qU8MEWn6WOyhZo1pGaa6JOAlVBIJHAnlEuraBo9vh6WWB3MZutRg5sri/h0O1TzJ/mG6YZVc4VvfaD8cIhVUcd3TBpWh+NiPBIFrfynNrfc1U7Gh6HFqLckQW5zTAdk15s4Lw3sfDcQDytr1Jq6mel2hONvltYv+3fdltmAAFuYkaVcu6rZoizdU9JaEua1yIsVTtKx/24/gyz1lc2/mDo6gz25OgNE6MjE3yVlPUU1MpZuJOub3FLEgrlCWsevg5w5g2dZdqm1vlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGPnjBXzPITzCFYKxGVvsxz/ivHBJ7xofArNVdz1tGY=;
 b=U/Qs5p1dT5eEc3baOAA+ZGBmF36PoPy/TJ/h7halUk2RWC50w8QFGhq3ZFSszTZljY6Ef4aGdxVQLVNgk7lcRA4dKKsiN/tePnoB4OxDOj3P9/GJsPs7K6eJJJiQeXNZeAxxI/sYwcAqQakAycrdRhUpYWVE5gFae/fkSDxhM5kNW3UKR4v/OlKiGQXRWEnTb46iNlLK1W9H2JmImv7FJdMPA7oso8w6gLTF6Jr1M8VVlMcJkBDY3GQk9X/AuAGcMXxCA9BJ8BamL0eqjjSYZBNImk321kfdTvm12qN7eTssVvoZ9C1tBvDZeSr9FTFyqt59zpXB+YMluOWy416VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGPnjBXzPITzCFYKxGVvsxz/ivHBJ7xofArNVdz1tGY=;
 b=DK8Yx3YvkivwT97tYkU0Jt7s5wLg683fDS3kNnUAxcsYqDLPS0WsyX/s/qXRTFe10x3/ighpu4vKo+HpREfybQg0A5+dgRo1gcFnk8NLfKpJhpVUAXS071WwY5rfk6cisV9I37+Ppn8CN90I/La6BcUzxQfUnsPj9Dolk2k4G/A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:54:08 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:54:08 +0000
Subject: Re: [PATCH v7 09/47] copy-on-read: Support compressed writes
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-10-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <4475d114-0042-ff02-b368-6820b03f7950@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:54:06 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.14 via Frontend Transport; Wed, 8 Jul 2020 17:54:07 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42943b9d-c90a-481f-79df-08d82367e9cd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5384EBAA61806E389A18D158F4670@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ2nF4FL1h0Wclrqx/NmEmgUIObVog7W54Ubnw0DDNVdOsPBn42nvWTwUqn3GAuYxIBN1OsG3TFzRCEzzJFJp89HvREAjqPWZrG4pIH0RLJXcywFR/NcC1uofRUa2FQDANXmUyB5oeNz+8hJt4uBkM5sb3BK3iCQP+HgdEvjMNk2KRJZaTmI4XkIs5XUaQVl3dvGln9/uCjYOxlkhYJsoZQp2SYqgy6ANjOpVKRD9lON2sAv8u8kvWH1+esDpL6HIxp99NSHVfFyuvnYstTYYKQOUDhXAro7x3ommqGfgOHJQ/QvaKnlG6egwFY7TZdziMNogOfKuiz1fqc4yhq+mX0s/oQX7DiasejH1oYyb51rX09uGz995GA+Xu93QLTB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(316002)(8676002)(956004)(6486002)(2616005)(44832011)(8936002)(478600001)(66556008)(66476007)(5660300002)(66946007)(31696002)(16526019)(186003)(36756003)(52116002)(4326008)(26005)(6512007)(54906003)(31686004)(83380400001)(2906002)(53546011)(86362001)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wdXE1pCYvUdKGjqxDXRWikSD3LU2E9JQxZziaCMi+p5e9uk5WEBUSJNNt2xRrS0FjkWr+ma4YXDDbET1rkU9Bz98bskXv00rHH2oCJYDoDRU5uPpRRPbXOZ8HMpOOu+UgGAhlJsXBaeRdX9H0AnW0+bBwag6Kg0KYgPVf6ZD8e3sTXIarE5fyX37ObS+cFMQLVcOtGx1SSwQ+o01O1fvN/RbEdf96c9M9t6IPCC3jgyBzjl7z/MqmgxGk9ARqyyYZryhLf5pBVP6Ha/LhAnq5LCsbSdd3CQcm5jVR9FjP7SshZWO97gWzAlJ31OtToBNYtfTS4u+vHhcBzReGTi4hH5nH3Y4afCTLDi6+LYxscr3JQcwqikdeCWAzffBosVWythznyjWf1r6xeo/nYj9zpBfgwsPmIKaVBWFSGRsnabw/xj5JImEI9TD9sqymnBsk3w45qOW/mvOzT2jqTnnlDf+qqt7gQbKcPzVVzDNb2rMiy7lg0puPPyUbPx5Smlb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42943b9d-c90a-481f-79df-08d82367e9cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:54:08.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoj/6eYkRcZHIVdDO+4ok0zZriUy6rbjXILcXTXk+GRxMI3JX/FcwAUxsXEf9ZG5e7b3aDUplmrshKEE/YLqNIDQAKlJ40GwtrfkmLpSLoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.13.104;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:54:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/copy-on-read.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index a6e3c74a68..a6a864f147 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -107,6 +107,16 @@ static int coroutine_fn cor_co_pdiscard(BlockDriverState *bs,
>   }
>   
>   
> +static int coroutine_fn cor_co_pwritev_compressed(BlockDriverState *bs,
> +                                                  uint64_t offset,
> +                                                  uint64_t bytes,
> +                                                  QEMUIOVector *qiov)
> +{
> +    return bdrv_co_pwritev(bs->file, offset, bytes, qiov,
> +                           BDRV_REQ_WRITE_COMPRESSED);
> +}
> +
> +
>   static void cor_eject(BlockDriverState *bs, bool eject_flag)
>   {
>       bdrv_eject(bs->file->bs, eject_flag);
> @@ -131,6 +141,7 @@ static BlockDriver bdrv_copy_on_read = {
>       .bdrv_co_pwritev                    = cor_co_pwritev,
>       .bdrv_co_pwrite_zeroes              = cor_co_pwrite_zeroes,
>       .bdrv_co_pdiscard                   = cor_co_pdiscard,
> +    .bdrv_co_pwritev_compressed         = cor_co_pwritev_compressed,
>   
>       .bdrv_eject                         = cor_eject,
>       .bdrv_lock_medium                   = cor_lock_medium,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


