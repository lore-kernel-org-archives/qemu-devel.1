Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65411C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CA02071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m0l0KBm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CA02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydWs-0005Bc-Gv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jydVY-0003dn-Q0; Thu, 23 Jul 2020 11:51:45 -0400
Received: from mail-vi1eur05on2127.outbound.protection.outlook.com
 ([40.107.21.127]:56289 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jydVV-00057U-6R; Thu, 23 Jul 2020 11:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmwnacxYIzwo/MGVOqcbz5NogQG9HSxHpSgYg4aTJ8y6ciC4zzbf1MSLmIGXA2iycOfFsKuyPNvKKhK3e/AkM1r5ph80vObmPOWAdoLtahUp29Doh0yH1Z5VFU7v1utS24486F2q+AX5XTWF77bKAKirz9jSFyTrQ46t0A1HyZZLiCkDV+YY5t9fq5978Wc4zaJMgglir/LcPb2fKHihJl+63R9NVSUpD+YI6K2kKu8thD22qI+mG4O/ebxxAiE6q+/NctjJpfi27u81ovi4MdxEH07IQAKsxNuOMzsLVYLnbgyMBqJa1albjpLLGyc9viooMBHr03xzEZO+2ye3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LldV9IB+k4FahNaMapfdVfXh986ElA8CCkS6AmUcJsg=;
 b=enUYLBbrpxCpUHBQiEQv5N5B+rpaX2zy3vGcp5KAszJ0xSbzwjl3/6VQZbZRkSCteje68QeD9MEtDq3zs9phRqGUydLgLfow0lN4z45mT2n/kjVC/awdi+9dOwEycCckJ7n+A/lCBRFAagbW/KR/AyV75+AcM5XJ9zxOwVRxHFTbmjEKZrFZfAHeE6XGau2C2/Yc/KknCT7T61r+XYxyKCLEkHNWfiuPbeu46kbG6JRVKkyEuq01+6nc+8O6h9AOt/i4nReKS4y4TdpkvDJFMBC3fNPo38KVRy0dmos9Yg/7laZFm6B03yMfxb+Yt66c8YMfImdR8URd2Sqbz7MPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LldV9IB+k4FahNaMapfdVfXh986ElA8CCkS6AmUcJsg=;
 b=m0l0KBm8ttQAFUE2JBaP6fqngxmFsUpbmGPKoqVTH8ysNT3ghepxQ7oJPeeE0qFpeduq0/oDXaaLiDibbDuSgRCRK+2eTaoHxVwmn0MYj5VhhD8yvPrxQZzy2PrkQOwhzrGtJ0AQxv4X3V0Nfe187q9DIe9X5TFqmUVQ/KZ4Oew=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0802MB2611.eurprd08.prod.outlook.com (2603:10a6:203:a2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 15:51:37 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 15:51:37 +0000
Subject: Re: [PATCH v7 34/47] backup: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-35-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <be4213b2-75b9-c1e1-69d6-171d704013ea@virtuozzo.com>
Date: Thu, 23 Jul 2020 18:51:30 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-35-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.10 via Frontend Transport; Thu, 23 Jul 2020 15:51:35 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf4a9dd-267c-420d-42ce-08d82f20487e
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26116B4CB4200746C47BF7FAF4760@AM5PR0802MB2611.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rffGCvrsPVQ+DUBFHKBIGnaY3GNb9beDuXZ9mHQxDxSWWVVH9yBeVxgQ1TV93h7OxHsn6L3V8whWF0MNmBS3OtmcTVPcnadNqPLCeIwtZXKyuqcl07r3c3428JrhwKoj92oC8ecFc3nX1I+v2DTonHTr3iaRq1BxWjjMTTUl3+XmrtLYlRF+FFeO9f6ZBlkGHwku40LYfBTa7etS9aylfEWPbxfwKCK6xoiFSowf5HOHSk+Uy7iKaOGAfn/0l0XT8r1t6PLV1jC9sJQI1PKIHQIXZJMXX+/GK/ZdFp7ejxOE1wr84tKa1DgMux7IPs2g3NGY3HBg04KeG0vSFIqRWV6KaOlRqBqXJi/ti9IJVpc71A2OZjs+zJnkwDAWGBMR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(4326008)(6666004)(31686004)(66556008)(66476007)(36756003)(5660300002)(52116002)(44832011)(66946007)(956004)(8676002)(6506007)(2616005)(6486002)(478600001)(54906003)(31696002)(316002)(86362001)(186003)(16526019)(8936002)(26005)(2906002)(83380400001)(6512007)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: g8/H/NzorTEoeImPDdShWYljAj9GxMAme9pYXXP9jAPgvC6V2ChyC5XBZdQftL2SaJabLMpsH11M5f7w6iwegk6xtgmIB1yDdVHTkHh8gere7/FHWeQ6m+N1vssA1Xka3C0jTiGo4s9PPli4o5F8uK4LNj5iM2pmBlLP2kM1BzwQOHcxKOzPV4DlT6lH2flB8/PMQY3AbkMJpyUOym9vagpvFe69EsO018foaH8OoU9i+fpnoWPla/mPNqquAz0cPHB9wO6tpGRcIK7qJq7fAUfyF/teEStRx0vGIul1XkYCwTvU4N9R+3X26k5lvBPfOmGgcnV3W/mNS9HmGREZhjFDlA95vXGlq0yO8Gso03Pqvi7Hf6eTyczSvYbn2AFqNMq+cajlxWZNZAppgTrF3bbUaATE5GCrAwToYIZ2dRgDo/INofGWWT0fXUNxJUBcvY/Fvqg8RaQMP61O57FhBRDj3IYdSEBROHs2QBMW9kLM6Oa7eV5JhfwxbYVRE1ce
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf4a9dd-267c-420d-42ce-08d82f20487e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 15:51:37.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joU6ikqIcsSETSkXWNlLPpDvleRJjdt3NFgExCLop5MN/ck/Y/0+3O+LbJ/1hdurhbK7kopSdQR/XeunvhzMm/J3g5yqmikglvGXsGAQ9EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2611
Received-SPF: pass client-ip=40.107.21.127;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 11:51:38
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
>   block/backup-top.c |  2 +-
>   block/backup.c     |  9 +++++----
>   blockdev.c         | 19 +++++++++++++++----
>   3 files changed, 21 insertions(+), 9 deletions(-)
>
>
> diff --git a/block/backup.c b/block/backup.c
> index 4f13bb20a5..9afa0bf3b4 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -297,6 +297,7 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>   {
>       int ret;
>       BlockDriverInfo bdi;
> +    bool target_does_cow = bdrv_backing_chain_next(target);
>   


Wouldn't it better to make the explicit type conversion or use "!!" 
approach?

Andrey


>       /*
>        * If there is no backing file on the target, we cannot rely on COW if our
> @@ -304,7 +305,7 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>        * targets with a backing file, try to avoid COW if possible.
>        */
>       ret = bdrv_get_info(target, &bdi);
> -    if (ret == -ENOTSUP && !target->backing) {
> +    if (ret == -ENOTSUP && !target_does_cow) {
>           /* Cluster size is not defined */

...

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



