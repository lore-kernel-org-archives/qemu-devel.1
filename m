Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F3E22B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X/q9eL2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F3E22B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXSF-0002HK-LA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXRA-0001Cc-3Q; Mon, 20 Jul 2020 11:10:40 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com
 ([40.107.8.107]:48470 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxXR6-0002m0-Vk; Mon, 20 Jul 2020 11:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYV84vsBbe+1xm+CRvZL5xJx/Lq8NfdslQ5actGmk337dYfwWBG3KG8Zz4nAkHNg9eI2xEHFWYGsPgvuIScl5yJ2c7H55Fcyynrr6eYLUWI74m2jV6UczxvI8W+fxjXET6clPLiY97zKjYOxmK/POgI10YrooaGtH5c7AMRBVIxp+xIVJ61s4mLo4CPlK45m3RGQ97wvnHcA6V8JZisFgkr+LN05wvSP+ZS1bhKDXFe0ojc1FgG8BMM03Q4YP25c9BUL7Krp44y65IlgpbbqgWP2hJX3fdBupCp8h+NvfPP4zA9S7rPPJst7pPHh2QvhEn4nxpTox18Bu0F6DF7zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LQfqjZw4kWfK96G8U23hmuZtLRVB+LasLhsGcNp2LI=;
 b=jZ3VzhhRfnDujdiFkrlI/YqnRW8xZ5Omww1nI3iEh4BHA7lwrakQVZZt8hccjU8rsMIJJZ7H8Gc9DytvhQtBcT1QFAMefZAP+8lQQrZIGM7j7xGRRhCSgzax54wMI5DZBgIGppmZ9s1EW37Mr44q4SIhTHzYgjXYq58+O0fFVHRm/VxxWjB1wf0qIqcYtKbtx2etakZViIkIetMH+NOtJSqR/PAajjImgMBo+gqWek9YzHA28v+fbdZnhmMChIQ1K5vS7oo5KTmlzyV4t5fB+joFI/2hCnkrm2K6ZlYlBUp3R4MyiaqJf1Uv21JgTjbr04qoRLH0z/aeXVpXBiotqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LQfqjZw4kWfK96G8U23hmuZtLRVB+LasLhsGcNp2LI=;
 b=X/q9eL2/ny/AbL9bqmnOkEos9pGcBtCzAyyUwJAvogWbOqpCGiFYIHwO/gW0T+aRrEIz+yaMQMLLalT4y2DY8Qc72BhlTooEMICcOVrapb5cbf7LMMDw+1KwI5+ai55TJSR6PdHqyiAge+LkTmK6wup/iEzOvNEMG/gluguuXO0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3030.eurprd08.prod.outlook.com (2603:10a6:209:46::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 15:10:32 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 15:10:32 +0000
Subject: Re: [PATCH v7 28/47] block/null: Implement
 bdrv_get_allocated_file_size
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-29-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <93f4b62e-78d9-af84-ab1c-95eea55bbc0f@virtuozzo.com>
Date: Mon, 20 Jul 2020 18:10:27 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-29-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::16) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 15:10:29 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00864b06-047a-44f5-504c-08d82cbf0bad
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3030D8C915A56523023AB588F47B0@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGNuy/8TUVu8naHoUgX+lBPJR+4rZ6N2CyLfY4h1AnU+6NNtL+G3nMknVHEwPukeqWVIIKr56ZLEwWU4yAPZjRill3JlAM/yNNs+pZAidfAitPD2XTat/djCSno4m7QTSm9lrUYDqbjJy1vAZYlk+H0evQyr8Wi/sbHuXN3SEKW30VyyevZZ+ThK97aBNRDBAlYOfNEP426z3WugNYyQlhPoxVyhXdpNAXNNyPXdWWTVAkfKngQ77mI/NHT9EkfBSNBSikL0hTcaqNA7PXNzn7Rd9Fiqf7Gl3DU5XdiVaPB1zIdGmTtHOTMHE8RQgqHXVrVMNXPnPoYoYo/npylHUb/RA9xVGM2DDUSlnRmTv4AMga31krr8mGrpWvn/BS+y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(346002)(396003)(136003)(376002)(316002)(52116002)(83380400001)(186003)(16526019)(44832011)(54906003)(4326008)(956004)(2616005)(31686004)(8676002)(66476007)(5660300002)(66946007)(66556008)(31696002)(6486002)(26005)(8936002)(36756003)(2906002)(478600001)(53546011)(6506007)(6512007)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AVUzUlSiHHIpJBzECYFPpsX/CZ2D/o/fosBj0s8E9s3UiGN2LNq+wQOCTi4g2MBJ2U0G4JoUlg63YiEnCWqysUMLl6nplX3Up8KjBVO2auZbivGDhrGJIShnkWW3FRpTJ2SmJqBdZcHnTYKPbZgl4AYEHPMiswce+F+4kT69Hl1Wad5sRDJ7zKPxJeIFw5DRhoVHG9A55QtNnJvGgtUiCv/qCqxmtzuFU0C5F4Y16nsnna1H1sm8ftmUlN7qNz/bRxv6r6M8nIiOw8jCoISLkl+5JV/A7cVo3EWcB5m+ko+PzkGpB31HtuZrvRRScMipdEa0HOuL0hyaeSwDT3Nc0YM+AA0Po/2bTdqW/AahaTKnI8PYKrBZj3PuyXBvwtw9yevAJ7uQjjrHFhuWmo+LXlXFZcuGcKMMvwjLm6FZXqfY988V2eMZJXoB+zVUkSz5sB6rOKoTaDR36ETSq/oVJrXBEr+5s75CNWs7Ct5/ke4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00864b06-047a-44f5-504c-08d82cbf0bad
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 15:10:32.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRK/cqg+Rc/YekoAY3lyRHj6HRuAicXoaIDgPJXg9xOMPTsV8ypcAJHWlHfnq+2CxqhE0Fkj8zsIfCuL0NjuGx4i4vP2ltY6VJ/0Q9saxR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
Received-SPF: pass client-ip=40.107.8.107;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 11:10:34
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
> It is trivial, so we might as well do it.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/null.c               | 7 +++++++
>   tests/qemu-iotests/153.out | 2 +-
>   tests/qemu-iotests/184.out | 6 ++++--
>   3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/block/null.c b/block/null.c
> index 15e1d56746..cc9b1d4ea7 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -262,6 +262,11 @@ static void null_refresh_filename(BlockDriverState *bs)
>                bs->drv->format_name);
>   }
>   
> +static int64_t null_allocated_file_size(BlockDriverState *bs)
> +{
> +    return 0;
> +}
> +
>   static const char *const null_strong_runtime_opts[] = {
>       BLOCK_OPT_SIZE,
>       NULL_OPT_ZEROES,
> @@ -277,6 +282,7 @@ static BlockDriver bdrv_null_co = {
>       .bdrv_file_open         = null_file_open,
>       .bdrv_parse_filename    = null_co_parse_filename,
>       .bdrv_getlength         = null_getlength,
> +    .bdrv_get_allocated_file_size = null_allocated_file_size,
>   
>       .bdrv_co_preadv         = null_co_preadv,
>       .bdrv_co_pwritev        = null_co_pwritev,
> @@ -297,6 +303,7 @@ static BlockDriver bdrv_null_aio = {
>       .bdrv_file_open         = null_file_open,
>       .bdrv_parse_filename    = null_aio_parse_filename,
>       .bdrv_getlength         = null_getlength,
> +    .bdrv_get_allocated_file_size = null_allocated_file_size,
>   
>       .bdrv_aio_preadv        = null_aio_preadv,
>       .bdrv_aio_pwritev       = null_aio_pwritev,
> diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
> index b2a90caa6b..8659e6463b 100644
> --- a/tests/qemu-iotests/153.out
> +++ b/tests/qemu-iotests/153.out
> @@ -461,7 +461,7 @@ No conflict:
>   image: null-co://
>   file format: null-co
>   virtual size: 1 GiB (1073741824 bytes)
> -disk size: unavailable
> +disk size: 0 B
>   
>   Conflict:
>   qemu-img: --force-share/-U conflicts with image options
> diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
> index 3deb3cfb94..28b104da89 100644
> --- a/tests/qemu-iotests/184.out
> +++ b/tests/qemu-iotests/184.out
> @@ -29,7 +29,8 @@ Testing:
>               "image": {
>                   "virtual-size": 1073741824,
>                   "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
> -                "format": "throttle"
> +                "format": "throttle",
> +                "actual-size": SIZE


If we remove the _filter_generated_node_ids() in the current 
implementation of the test #184, we will get '"actual-size": 0'. It 
might be more informative when analyzing the output in 184.out.

Andrey


>               },
>               "iops_wr": 0,
>               "ro": false,
> @@ -56,7 +57,8 @@ Testing:
>               "image": {
>                   "virtual-size": 1073741824,
>                   "filename": "null-co://",
> -                "format": "null-co"
> +                "format": "null-co",
> +                "actual-size": SIZE
>               },
>               "iops_wr": 0,
>               "ro": false,


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



