Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF69A2065E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NTNgktOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF69A2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYMM-0000tO-35
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxYLZ-0008U7-9h; Mon, 20 Jul 2020 12:08:57 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:46470 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxYLV-00031f-Gs; Mon, 20 Jul 2020 12:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0s6Xl1Zaedulhm/vsevkyLMwtseV7XOoeboqeK4hs/QY3hnvU+HXu+sxKRVaZX2GVe/oZkm+K/QempNdJzzy5E+khehMqRfCqt5eiN8kEQ2bat7HqdiEjlLO50iNJDbkXgYdjLoMI1fUTxrE4EkrUCwOlnmo4y3l/zrkzwrP7mosDFUUyp8kGPygGSpSuN1Iz4ZdL11V11a/SCc2ssjvkCR0EX/za0IYI1RW9Kr571BwtH0l3njgYvyFaaUcilprIBc4ywPH5MIyoUZP9vVWdfa0OHadkQ3c+6A4uCSAEyWbHhSaI3ON1ldJfFvh/y9Ckbm0+uEKmZateITTwAebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJZHt+O1lDzt7Q0charwNqJxjL/sVc3fZuR8HoIyilE=;
 b=CDsTM1JWdKtKexpBpUhVAO6fEZTCKZn0SXutpGTNg6FgvLPxcodOisESoLbuYoI0WsM2jEddYIT5kAttSDHt6/cbdQTMYpLLrQyAVbQ4NHwCwgqJIEqJDPvzJYgzwoYBRFwxEtPoxfitPcQ2UnbNQu9gVwMSNwQs5AXZVqm+/VZO4dhxunLsV4++46LFB1RAvEs4P+wKoQ20jUIhfySpMMDJaApKatGJgj+7mPIqed8aICSt/g3S1RM20cyWmDEp/Z/73/kmBF8pLFL1CX6qXp51LiC/zTWLYEB8UzMb3qk5Jun7bUxzlyD67EkF3Auu4be5Ouqy2lDw/0AaRYa64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJZHt+O1lDzt7Q0charwNqJxjL/sVc3fZuR8HoIyilE=;
 b=NTNgktOxCkDGsqBm4YMiVuGGQm5F6/xJp5uvi3qpZ3H7aw4l6WWfHm03FEq/dQAueXKNLkPWJNP2HvNAG0U56/Ovm7g1YIgCpBU1j6iebYe6iofeK0g/Qib8LWL7uk56R1ED4EP0S1yK6KMaep646TbSVoUq2++9L0joKAJD8a4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4469.eurprd08.prod.outlook.com (2603:10a6:20b:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 16:08:48 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:08:48 +0000
Subject: Re: [PATCH v7 29/47] blockdev: Use CAF in external_snapshot_prepare()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-30-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f89e95e4-10c8-f5ae-f085-2da4d936c043@virtuozzo.com>
Date: Mon, 20 Jul 2020 19:08:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-30-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0101CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::47) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0101CA0079.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 16:08:46 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f1b6af-9c25-406e-f398-08d82cc72f60
X-MS-TrafficTypeDiagnostic: AM6PR08MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44692B4C5598755992DF53E8F47B0@AM6PR08MB4469.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZoptUi3o7G2jBnNWmaQAYNzkbgASf2+95HApOy7h3qjKuYd2tEgxWsvrkKy+y7k+C5uZNMc+H/fd+jtZYjNtaY9EemEx6c2uH50UaDtGx442K2O77R2bRWUpfSDZiiQnymq0ctQ4F8LzQGYasa1MXQcinI2OFPnie2EPY3ah3xB+TjYh5IVmkf7DAPa55X8O7d+23ASRc2D+rG8ONvXy9+AKxZ0GeJ2lVL9NLPI6ewlx158ibp7hYK4YGpfSKUsaQY0yUWgnIwvNwXiXxN4TE1b5TruRgUTJpGU5KbzRpcQ2wJdvDOk07f/2o16Hd4TBriKcEP9X2+SFbtgq4ooax2uo8VO7Gmueed91iEfDyamUVFe7HfZc9eT0OH4/+nm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39840400004)(366004)(6486002)(26005)(31696002)(36756003)(8936002)(478600001)(2906002)(66946007)(6506007)(5660300002)(66556008)(66476007)(6512007)(86362001)(53546011)(186003)(83380400001)(52116002)(316002)(2616005)(31686004)(8676002)(956004)(54906003)(4326008)(44832011)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WKHSS4MeCVIGYlp/ScJXfl10YUw3cDC3ENTk369/GGs7blXPpycAcXchdmSztg5VoS6cgotPWLA9LjcbyixMRJxmo+wmeRLbOGAO97JUJpjFGbEOWB9YFthBbR77wwwg2P5VXKW8Dt1deNLEWznLjvtf83jaWYVLEksoC5RPY8N/X/etgTkbwrP9146v9ktH3CFYRS9wtk+br36Ju3q0Cvxxz2JG6/M+xvypDRGzf93xkBLPPhuiLywN5EWh6tzwpU99+4fvTjm/tULRktGQ94FSYLnRNXX8Euo41d+wmQp/wR8MEGBzAO1sorQq5TzjMbGd8eXN7RWH4NycTiAQzP0u5ZlNT9cS4spg2yr6mLyuOYTkCltD/uocRgzYu8kBpIUJu1HrkVpa7jrQW2lyrbgxb++ogkH7kfbyKYuYTgTrMAusJDTvHD4Zij0+hU7C+OvCMP1iBq3QolHz1pYr63P6h5oF4/IZ+4+3UJQGBqF1hxVGkle43ZSUM0giLmqz
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f1b6af-9c25-406e-f398-08d82cc72f60
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 16:08:48.0520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c1kZh1HalPdsrqknXPCtTMtSWSmtt4ttERcwhm2EQg2lYl7/EXVMK0YlQfYKu6z9oImR7LDqwIHEe1ZmlZhq+fmOLhaxp/fCuWayxdfUWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4469
Received-SPF: pass client-ip=40.107.8.101;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 12:08:51
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
> This allows us to differentiate between filters and nodes with COW
> backing files: Filters cannot be used as overlays at all (for this
> function).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   blockdev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 1eb0fcdea2..aabe51036d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1549,7 +1549,12 @@ static void external_snapshot_prepare(BlkActionState *common,
>           goto out;
>       }
>   
> -    if (state->new_bs->backing != NULL) {
> +    if (state->new_bs->drv->is_filter) {


Is there a chance to get a filter here? If so, is that when a user 
specifies the file name of such a kind “filter[filter-name]:foo.qcow2” 
or somehow else?

Andrey


> +        error_setg(errp, "Filters cannot be used as overlays");
> +        goto out;
> +    }
> +
> +    if (bdrv_cow_child(state->new_bs)) {
>           error_setg(errp, "The overlay already has a backing image");
>           goto out;
>       }


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



