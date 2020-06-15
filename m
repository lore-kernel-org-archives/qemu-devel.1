Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FEF2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ukXfgkOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FEF2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjzj-0003zG-Vq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjz7-0003VU-O8; Mon, 15 Jun 2020 03:56:49 -0400
Received: from mail-eopbgr140135.outbound.protection.outlook.com
 ([40.107.14.135]:55782 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjz5-0001Ef-1R; Mon, 15 Jun 2020 03:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+t8AVJV2VHOEWUKX5+O4zdIqZIlWoCBxUoTqTVrpWORIjFagsPTMd/OeBjkUWOWJTOysaSVibufBNYWijVQ6pWQcnVSPsfNq51cjScutXq9tClZMdViZFECAct7TkH9jLNcxxXb+yt5p4/4dUYvuz92cwGaaxRjgZpXBupr2xE2EWF6GS0hreZIx29skZex5R0lmPA1O7C0awN3m7gPaX6TcrHjvWKYahxvwF/d8tUWHaIL1Tx+KLOItjjfbWgwOXffZbFpJtcIzrOLAfGHidRE4IR/g1Wt4egSJPaHSVkCzsVthDVaIBJJVFgyt4vjpkKuvNHBJBIZ6JJgMEMvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+SW4vvjlBLjcffX1Gh1WGx0C1KAJnNnFyNmQ5PrGqY=;
 b=O7v42F/2U+ISqpjS0nBzEkF/LGKUqCAMM470Q74z4FoW7H3PU7lk1gprDqaoB9QRiHuLzxSf+XlemI5v8HMRu66Obg0Rvi6DWjC2SLp7HJGrXY/BJDEhkZtMxxSVj/+cLt0L/9nXhjxxHCcPZ8kK4HedkP3nNItO8/2hDEmGlQuJyS++JwpHDPxU+PBskD36+sLVxBzC278dubELtgNc53GsvTPG+CoTccDHm7HCKpeEKO1OIjTNT392runAdJXd26qn9h6FnmmmEE91/+aOhpTYCNPYmdmfH2sxt4tXQ7ghqNaf/U/LWcxB9QSGwSViOJljcqtn2iXBY4EPnWw7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+SW4vvjlBLjcffX1Gh1WGx0C1KAJnNnFyNmQ5PrGqY=;
 b=ukXfgkOWRn63lS8BR8XXityL+swKFxaLJ7nFdN0GItYsxqCDuGd/JXdQBCUnqENPfIipnoebuvmc6z7dCJQp32qo/2J0CqGLRdp7eb2f7M9HiHEg/PL5BE5mBKXOnoZxASwHqiuao26yKzHjMPF8m2yc5kH9IE4+wX6nLoEx55c=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 07:56:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 07:56:42 +0000
Subject: Re: [PATCH 3/4] block, migration: add bdrv_flush_vmstate helper
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-4-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b68a7005-9e99-eea3-faa3-d754c33a1b4c@virtuozzo.com>
Date: Mon, 15 Jun 2020 10:56:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611171143.21589-4-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Mon, 15 Jun 2020 07:56:41 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f80e9ebd-63ef-4888-89d5-08d81101a46f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5333F0A9C9112D0C626D6765C19C0@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Erq7RzESZgGD7GMw2LH+/ON4ttQU9vL8OZg+0ATuQfb14F6buXmWdYC5/pfgikZNBmDQxEd2BDd5i+Ggqwi37nODMFkVJDsp3VsC9EhFII+i00ZYTXK0K7JiRRaCf1eYI9TJ/AIx8YrWl1bryWX623/o4NyXQk1YEtaB2usq7hFk28D0Z6gpYv3O2DUNRLBCAGQ41DG5EUqQtVn1/PRm+tzgMR4uAnvgUf348u+/m5Cws6mww+0S9M27qhA+lgditAR56Uhjs80W/ONUCDmEP0162eadsYsS1ShDzgGw1jo9VYNwf6GL7xp/55BVKfPdRbrRQOiJCU3pq/5iYhtKIHLn+WiRj/Cct5Qc7OtIZZssDR59cqSxROooZgO3Ka3A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39830400003)(136003)(376002)(396003)(346002)(36756003)(478600001)(52116002)(956004)(31686004)(26005)(16526019)(186003)(16576012)(8676002)(107886003)(54906003)(316002)(2616005)(2906002)(8936002)(4326008)(5660300002)(83380400001)(6486002)(66476007)(66556008)(86362001)(31696002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KeOeFbRtCow0P+yw6Bjx7lVGXT3+5Hv2ZBtfrRxxZ0OoxBD6njklUIGPSjAJWlQchtP3N2bv7MK3qY2tIjaRJQ5eUkSIwDIsQJagveLXH+zKZob0Ol32sY/SaXsIPZkvO2/rpSA1DRKlwEaO+LIWmtGO8B3Hq5OHSlCWeB4g8tGauPjVJFJOzMzV7pbmVrSA9b1q6mVRW8SNVKGkbvoMdtAnt+zQjblRd2HV9xmIGW5N6vuLD6t3h+8pFaguo78g7OZ05y2w+IvtwocXiF8hW5TCQehxRf2MfUWbwf0yO2IJpnn7ThwhxSiViv5BEOSwuDq/bntbCcu4QV2mx/uaUShbdegY41AXhBWeGjPNbydfMGDdvpadAUefncPOMgaf09+KXliOUt21Lgq1Kh0rGp9WePbxCG7E6a+g7RU6iV6EPBG2jLBm0GI6QTWv+yb+oxdFKvCUitvNl+jZn+Xn0StUF1JTZG+l6BvlPgEDXFlbqePtxe7OBt2PUTclEORD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80e9ebd-63ef-4888-89d5-08d81101a46f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 07:56:42.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdQ3UTTnnywOS2p7T7OsohtOLFNT2eU/AfE/fJnN54lUHKIjo32BysQfR3s04UjrKMT8P4+p5zvqq65QTj7ligxEt0AzB3I2wjuWwnh48T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.14.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 03:56:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 20:11, Denis V. Lunev wrote:
> Right now bdrv_fclose() is just calling bdrv_flush().
> 
> The problem is that migration code is working inefficently from black
> layer terms and are frequently called for very small pieces of not
> properly aligned data. Block layer is capable to work this way, but
> this is very slow.
> 
> This patch is a preparation for the introduction of the intermediate
> buffer at block driver state. It would be beneficial to separate
> conventional bdrv_flush() from closing QEMU file from migration code.
> 
> The patch also forces bdrv_flush_vmstate() operation inside
> synchronous blk_save_vmstate() operation. This helper is used from
> qemu-io only.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/block-backend.c |  6 +++++-
>   block/io.c            | 39 +++++++++++++++++++++++++++++++++++++++
>   include/block/block.h |  1 +
>   migration/savevm.c    |  3 +++
>   4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 9342a475cb..2107ace699 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2177,7 +2177,7 @@ int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
>   int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>                        int64_t pos, int size)
>   {
> -    int ret;
> +    int ret, ret2;
>   
>       if (!blk_is_available(blk)) {
>           return -ENOMEDIUM;
> @@ -2187,6 +2187,10 @@ int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>       if (ret < 0) {
>           return ret;
>       }
> +    ret2 = bdrv_flush_vmstate(blk_bs(blk));
> +    if (ret2 < 0) {
> +        return ret;
> +    }
>   
>       if (ret == size && !blk->enable_write_cache) {
>           ret = bdrv_flush(blk_bs(blk));
> diff --git a/block/io.c b/block/io.c
> index 121ce17a49..fbf352f39d 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2725,6 +2725,45 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>       return bdrv_rw_vmstate(bs, qiov, pos, true);
>   }
>   
> +
> +typedef struct FlushVMStateCo {
> +    BlockDriverState *bs;
> +    int ret;
> +} FlushVMStateCo;
> +
> +static int coroutine_fn bdrv_co_flush_vmstate(BlockDriverState *bs)
> +{
> +    return 0;
> +}
> +
> +static void coroutine_fn bdrv_flush_vmstate_co_entry(void *opaque)
> +{
> +    FlushVMStateCo *rwco = opaque;
> +
> +    rwco->ret = bdrv_co_flush_vmstate(rwco->bs);
> +    aio_wait_kick();
> +}
> +
> +int bdrv_flush_vmstate(BlockDriverState *bs)
> +{
> +    Coroutine *co;
> +    FlushVMStateCo flush_co = {
> +        .bs = bs,
> +        .ret = NOT_DONE,
> +    };
> +
> +    if (qemu_in_coroutine()) {
> +        /* Fast-path if already in coroutine context */
> +        bdrv_flush_vmstate_co_entry(&flush_co);
> +    } else {
> +        co = qemu_coroutine_create(bdrv_flush_vmstate_co_entry, &flush_co);
> +        bdrv_coroutine_enter(bs, co);
> +        BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
> +    }
> +
> +    return flush_co.ret;
> +}

In block/io.c, since 7d2410cea154bf, these coroutine wrappers are using bdrv_run_co() instead.
I hope, it's an intermediate state, and my series with auto-generated wrappers will be applied, still, now we should use bdrv_run_co()-based approach for consistency.

Otherwise, patch looks OK for me, just add a new interface, doing nothing for now. Still, would be good to add a comment in block.h, that bdrv_flush_vmsate is needed after bdrv_save_vmstate.

> +
>   /**************************************************************/
>   /* async I/Os */
>   
> diff --git a/include/block/block.h b/include/block/block.h
> index 25e299605e..024525b87d 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -572,6 +572,7 @@ int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
>   
>   int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
>                         int64_t pos, int size);
> +int bdrv_flush_vmstate(BlockDriverState *bs);
>   
>   void bdrv_img_create(const char *filename, const char *fmt,
>                        const char *base_filename, const char *base_fmt,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0ff5bb40ed..9698c909d7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -150,6 +150,9 @@ static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
>   
>   static int bdrv_fclose(void *opaque, Error **errp)
>   {
> +    int err = bdrv_flush_vmstate(opaque);
> +    if (err < 0)
> +        return err;
>       return bdrv_flush(opaque);
>   }
>   
> 


-- 
Best regards,
Vladimir

