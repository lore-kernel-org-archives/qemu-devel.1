Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C474C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073782073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qa9wOre8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073782073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrqo-0002oC-BF
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxrqC-0002CR-4u; Tue, 21 Jul 2020 08:57:52 -0400
Received: from mail-eopbgr60134.outbound.protection.outlook.com
 ([40.107.6.134]:11014 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxrq7-0007o6-Sq; Tue, 21 Jul 2020 08:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmpKHg1PZYvW858930D0MlzveJorLMT6eVJ3tP8YEb15lxmfFGw07s2XjAhzqUSi4m/itCrob95vMkcdz7FxfelPG2Gsd6h1NQ3D65uMhygT9tCI3Xg3mRqOtM+DVYpkHiGMhX+Yi72fHRcVxWMf4P9Mq0JAJ9N1DcHZBWFZucoQWDfxhW9M0tZZSX4QNijbbrig1jLVqk8f89wHM8jfn9MqAkqT2Any0VCwIDlJdIUn6vVN43Q+xHWkDetPTlArdzUP8bmpJlvltTBhlndI4JZRDB66nYFjmYxnzQr2J1rcyYI8CvAwmj2C7KhliG/xgGz7uNW2QB/sUNmdLpl25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTABr+V3DEJws/Ov0X9eStwcVxCCzKVaCcglsiJL284=;
 b=U+qM4b+/aQ5zhJJpcs+6/e4w26vgWfLShGloPLPGoULDamsz4LSlJVw+uPbjeX2/UbZCcxn9tDd96YMLadPzRx1ruQ3C1FASecN62mztmX8TpX+qOSTFGjou5jZ1u0SQlA1npPaMRoNKoKkGVFuR8ZhHgW09ckFIq0JvttO0N0mdtqZK7wflqvQ5S+oIKp5+ptrtiXztkv1Zmi/Zc9XV4yZWimThMoQ+Cvq1Q+S6mPblZxwLbR/SvDWsKuCxRi8urw5FfwTBJ4zajX7rW5Hx8nedixXyQZCloF7a5FvPG6u1uobgd1S3rvXKx4gxdcnDOjIKdZT5UU8XFr8oYjSvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTABr+V3DEJws/Ov0X9eStwcVxCCzKVaCcglsiJL284=;
 b=qa9wOre8IFQYnkj40Cw5BvDvjEehDVHQvEow2O2KO391r/lnR7zxgys/8wRAbEeDQR1TNzadVU4aL1QpQdNgswjDrSplBUT78QenmPJdiV9Fj2uzHpquzSMfYhVlXXGlPn7DJWRBih/MQYj8sjLXQl/XyPtImacpQqlImeqjioE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1715.eurprd08.prod.outlook.com (2603:10a6:203:3c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 12:42:42 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 12:42:42 +0000
Subject: Re: [PATCH v7 32/47] block-copy: Use CAF to find sync=top base
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-33-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <8814f53b-5d8c-26b7-a02d-88f325741fea@virtuozzo.com>
Date: Tue, 21 Jul 2020 15:42:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-33-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 12:42:39 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f0a4b6-9101-43d2-517f-08d82d738f6e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB171593E822235A98E70587AAF4780@AM5PR0801MB1715.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bfpjrrlg+mrUbOua8Sj85D0C69DE8+CNjoHtA+njILgR/aru8vttR1qZT20zksFrXeZyYOo4Q+q95dS+ANYtLlO5BaZJi0JySXKXtXGFFlqtD1y5upJc9t222MRGQ51qekj23fujfv5maSQnVDtggZ0XvU7MqMPQWHBrvkvHl73UWYd84vkm+YiYLm8wXmayWGqdzbBqDXMDbzVpQPtyTT5ulXay/I4Evw0t57ueGE+eyykOVly8OYCHQAItXHVSgmhkQqXk1HHvGaTsA2d6RZ8rTAFN3zVMZqr+d9VEJin4KNcBklS4E4P2tn5eAK5XZwwxrBYXJ9Xdb/ZYTN4Sx/9P7J6/G1d2NnWTIxAKno7YWsbtZXvmUZsMoOWGsFrrdywnNb0yJgm9qEA5Cwv3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39840400004)(136003)(396003)(8676002)(5660300002)(6506007)(316002)(53546011)(6512007)(2906002)(31696002)(4744005)(83380400001)(8936002)(52116002)(4326008)(86362001)(54906003)(31686004)(6666004)(66946007)(66556008)(66476007)(956004)(36756003)(478600001)(2616005)(6486002)(186003)(44832011)(26005)(16526019)(37363001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BqWQDsDOgIJ9PAzCSxz7X1xYZxBoyLzJaO9uAaB46Sl4GnHT4BAdXNwcmWoiVZM4JJ/aKJRcUNN1eEUhb9/XzaZHKzGyWOZdK3LvLk7NIoONmW6yeNkuiSQB2hv6sb0l9lXNZXfeQagDxtsjqBcjp9IUqnZoPFVS5YVkPDqFRGof5ZYLXQEjDFfSALzQ8MNUyDSZvaMO/2wogX/0a2/f/Afr1uMGk6DxDgkaUXACJlS5ByhU4iIt5rEmE1nWws+i87ZNTT/hCE10epTtuKDhWFTct8c/GFBbVS/ulwoW8799OiP3ilgno3YSXR2xGbUb3NIEiRigMjFhtKE+ebIxbwAxWC5ksin7Ud++1R43wagEbz9jv/4Es2pqmIBLukWfg516unlLJ2OvQHCCDOXyYYWznMPYNrvIp19k1KMr3Apz/XPlmDzmkHBHbVUHk1ikVTVE4GsfkfCqX4fdTj9U1OcjB/w9B75N1Iv75m+4qLMM6OpMGSauFArtJ1hZ3a51
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f0a4b6-9101-43d2-517f-08d82d738f6e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 12:42:42.6214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhgFy994Vb4sL81ac9sdfTWlCjtyqfrNBKBJr8Kzu31jMQhZRkgHMUDaK5/ZqpmASgTtwr6wa9+KgLEBaYKGcv9JubVD3M4a/DULmc7Fwuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1715
Received-SPF: pass client-ip=40.107.6.134;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 08:57:45
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

On 25.06.2020 18:22, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/block-copy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/block-copy.c b/block/block-copy.c
> index f7428a7c08..5e80569bb8 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -437,8 +437,8 @@ static int block_copy_block_status(BlockCopyState *s, int64_t offset,
>       BlockDriverState *base;
>       int ret;
>   
> -    if (s->skip_unallocated && s->source->bs->backing) {
> -        base = s->source->bs->backing->bs;
> +    if (s->skip_unallocated) {
> +        base = bdrv_backing_chain_next(s->source->bs);
>       } else {
>           base = NULL;
>       }


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



