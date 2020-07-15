Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F381C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951C2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jL5te5Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951C2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvheM-00055t-Jg
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvhdd-0004bL-BJ; Wed, 15 Jul 2020 09:39:57 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:47584 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvhda-0002g8-OO; Wed, 15 Jul 2020 09:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gag/zcVApOBYBa/HhSuhw9nykdWzGbOKbfBHUSf085aoOVeJHTIBIybNv+ku3f+56CnB2lnSleCx3jcy4ViN6PaKbWkCmkEeP8RavoXywWRG62c0BtIAuMiO7q7gup5JoMt6eyU552KAkyKFakoKb8q/a78CAswRlR0ugGamiywHATYEifNIZTBfv43tE/un4R3wiD3d40i9/ebUSAFmZ46boB9PDXIING3eIuhqLAzOw77oSXrJYcwRw6x3kwyqrsiqBggUzy4BGlY/nDyvZl953EBOIvxbwrI/lhAUL43dq/95p8hqtZibSnj6MJQS/TrGOMyVJ7Qhz2UBpyu51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4S5YqhIGcCetgwciNjv6ttkwEOK6Blw0HCZA+M0p/M=;
 b=TX/WSB9KIPDPrG72KhhfAMUEDcS+G6WowLYLz8XLz/9Fb7kzJ03pCYT/fQOwvcvL2KQKRhLIsQIWE2VWAmZsEwBTNxZZouBqxqOuEl8zIvrtsZwK5T7SuWNeqZ9nc8fr836hQfsfJf8OBMUEj59XXYLmlqbA2ZNpZC4dTvzasFvZWboqV3Ohe/0TZuyVZa8kYkjcKKesZfUetEns6EYIOsGapuHU4IGorDYXQ79oaOG8gt1snxIhEImMOJRm4us2EZaKBvOJe3NmDtV1ajrR9xiLx7WjBdWU/AONIWZUb5unHTb9uXozmk5oSPEUqLuuqN/bMgOLOEz5AfYkjIk5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4S5YqhIGcCetgwciNjv6ttkwEOK6Blw0HCZA+M0p/M=;
 b=jL5te5EdjMNgfUlH7iYd1Dexklx6GzJCgLXRKYcnRR/Ek22tZgq9lyha18IYZt4FTC6ikVI+96gWSjX89m96mw7yikzuy7e7YUFhaEjwH1biRyGoN3i10TflaoHgZy+LXWVkyb7IaT0XnBxo4ivtCcD10S9yYV3G/GBBjhgSJa4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4165.eurprd08.prod.outlook.com (2603:10a6:20b:a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 13:39:50 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 13:39:50 +0000
Subject: Re: [PATCH v7 22/47] block: Use CAF in bdrv_co_rw_vmstate()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-23-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <47c4a9eb-e0ef-3087-79a3-8a9df49e4207@virtuozzo.com>
Date: Wed, 15 Jul 2020 16:39:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-23-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::44) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:208:d2::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 13:39:49 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb14828-be86-4240-ecf6-08d828c48c47
X-MS-TrafficTypeDiagnostic: AM6PR08MB4165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4165D59841177CA748036736F47E0@AM6PR08MB4165.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuqaNiNF9FqQpOdUaojdoDK4hGXfqElUe93BR6wfIyM/dUxvVi8DyR0FM/lcATfo7r8wDZXqcFGPJsYvHS6/SQDnrK7GaUMRnlZV2i1jKSdl7grvo5JfzXlZ5I+gyNc3c29OMEbg6YWgT+uCGTcVmNzFffetnLViFJC5GKisUGo4n/f0sDYQy4ySMTq17OWbSbjGmucm+AmTnUUMx8PM10dbuI3HNYEcLfWxMgkSfMw0WS2YpZV51ZQD/rK6i4PN5sJmzZ4OtwMSkVKcu2W7k0STtOBrgFubwVt34+KqxYLqVKZ2iErbApTa5rxdiUUqDfMIGbK05/3QEVlvs8iupDV2ch8Wcyk0OCoK+9YmofLjpBAEtmVJ9Uqz8qw51t1X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39840400004)(83380400001)(16526019)(316002)(26005)(956004)(8676002)(2906002)(8936002)(31686004)(186003)(6512007)(6666004)(2616005)(6486002)(54906003)(36756003)(478600001)(31696002)(52116002)(86362001)(6506007)(44832011)(53546011)(66946007)(4326008)(5660300002)(66556008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WT1RJ9xU/xF/cKHLKOE44/899nXcfb5XtfUW81TY1PytDi2AD+k6BNBsqxKlot7Qm9HrTQ2yiJqAU/azeXUVXV1Ia/86LK+XSY3M8oVIxVxVQlhWCU2tu1HHp1fj6k67emhPsdzY+dQvv01AVLUP0IWhNlFRyLVll5yOzEsBkEjkLYFUqZ/F3zdtrmIMhExsXJL2bEMKJmCUlBYDAhLnZ714L6nzWFfYupskOT4fnORfRE+sFHLDiaViXLoZzSZPcBLe47e1IggIQhMeM88vRHpwx4OjZyZhpU47BDSUDXHkMYFNUY9ecP8PK+nQExhpdBDPYFugppX4B1ZhOttZN8sPfSCiCpXKehcnTSo2Cx+ZGyw4I08f1BWVd82ryLIT3p+TDAb1f8aJqHYdAla+ykJtsnzydpllmoS6nirjHRYvMHCRBnWT7gW020rWZEKIX3T+t6+E3BjfAILshCXi5ylLsCdHYJmPYX8PGyVrkEawEiDCpC32y1hnNg9YOOPO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb14828-be86-4240-ecf6-08d828c48c47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 13:39:50.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsbGhySx9SpYX0GvJviJF7wd846C6G4DLwaXlMx+4QDu2w2eJH1qhWzSGShic/561JfwgjPiixapAvPgpBCKJBKephNj9HC3aUR+dMfB3Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4165
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 09:39:51
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
> If a node whose driver does not provide VM state functions has a
> metadata child, the VM state should probably go there; if it is a
> filter, the VM state should probably go there.  It follows that we
> should generally go down to the primary child.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index 37057f13e0..9e802804bb 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2646,6 +2646,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>                      bool is_read)
>   {
>       BlockDriver *drv = bs->drv;
> +    BlockDriverState *child_bs = bdrv_primary_bs(bs);
>       int ret = -ENOTSUP;
>   
>       bdrv_inc_in_flight(bs);
> @@ -2658,8 +2659,8 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>           } else {
>               ret = drv->bdrv_save_vmstate(bs, qiov, pos);
>           }
> -    } else if (bs->file) {
> -        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> +    } else if (child_bs) {
> +        ret = bdrv_co_rw_vmstate(child_bs, qiov, pos, is_read);
>       }
>   
>       bdrv_dec_in_flight(bs);


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


