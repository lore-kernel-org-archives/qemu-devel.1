Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F10217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OzfhUaNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F10217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrOS-0001S8-5w
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlrNn-0000wx-Bm; Thu, 18 Jun 2020 06:02:55 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:61408 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlrNj-0000zB-QF; Thu, 18 Jun 2020 06:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Y9dFjJfxOpUXxzAvZI5T8Sjb3EtrHbW+vFmKiJC4zj5mtltAU3a7FBLXIFj9EKj8DQoDOzSF9lS7f0YAcC1Kfg32fWYeouZ/fnG0VJ2NC763iqrcKTB3ysMu8FDugMAC5L3DZexU3wY8T76nqe+E3nw7zRXFidCP9AZbyk9/wA8aiQ3DXuAlldAjsdJ19mIwyd7o2qsvpAzmDVmwHi9yd/GKJp6dGz3QA65es+z0TPvAgQOj4Pkw2ebqr9n2R+L1z1xmebTONJI/ndqAvRgTv9ZShhlqmPODwSUaCrNN2aQgt+wfT+OwQqvI030FofzeNcJX3/OBB2t6yBI+0/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvBn3ILcPygg2/paJjEmZPZKkd61njONiTIahwrlsvg=;
 b=ktKNzJkgsy7Yg+dyAj1hm2ZYonygD1lPmfb6SQlSAfAOHqb1CCCNCVd3ghZfPzEKW7H6dCDgq026C1AmfNSSia55wxuxBzmW+3Cy1/8/sIELP7/NK/P+iwcCzbobOIsaJmSY8oDXL5r7TY6+uH3Xs5zAz0uYV5j8g736ZMDHWmsCAAvkDmkSnaQRT3YljF6vSS61PrkQ3WG27cYZDMC10FCyel7gM2fiFVk6RntsRTJwsuS1UfnaPwnEAeMk+39ps9IxTqtNgFkGAbaCOhvfigHiIqy0OIewtR3CgRJCguWkEt9SUJJlbK3av8tonkdPrngPw3iX+4Y5wiMo9d4i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvBn3ILcPygg2/paJjEmZPZKkd61njONiTIahwrlsvg=;
 b=OzfhUaNISk/EWU1/IljOFQ0Thnoj/U1+gN0PKCJM+EnqsVluB5oE67CZON6W/nP77L/7o+k1AbCoqIbEtkU0xIBA5Ekjn+hnY+ATF2KbSpN5jz9lV8zRMkZHr6r2xPAO2NZI9X3DlV/66EDNX2UO9LUzs+5Yxims9S0sNldOjaM=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 10:02:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:02:47 +0000
Subject: Re: [PATCH 4/5] block, migration: add bdrv_flush_vmstate helper
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-5-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <daff71fb-2bb4-5682-ac5e-2efdb7b95609@virtuozzo.com>
Date: Thu, 18 Jun 2020 13:02:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200616162035.29857-5-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:208:14::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM0PR03CA0007.eurprd03.prod.outlook.com (2603:10a6:208:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 10:02:47 +0000
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c657b4-d503-4c83-c644-08d8136ec0ea
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53663E4290CD8D38A8FFC3E7C19B0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sjqXDEGfpk6ILmQdy8Tt+CSfjaJzYWiJ1UCFqSr7pbKQFdAxK+MyZCIXciW2afGOfxPIjAKwbaOhqe7I8a1kHmhZIdpFZdXjbJVPXdLiVriQzal9suWkrQI5T/4MxNcSHvhIfr3GB7vk/ogdovpX7lULQ857J/WMZpBpHuPZJp2Y1Ylw2lfzwfiPBvYHW4X7SWT5cArPNADY8HsOPSM8WNERAMwXIas/flAMlGUkkSkfyA7nPYzdHBEZLwi+m5q1qZg102EqwYmBFHuDGqcrSUwSWbF4pd7k8XCZWnZVViiUT6IGT9fz0eAnjHgbsslzMhNKZXnbyrUDS9L2XCgLiYDgF7mijJ/k/AmXLoqxhA/913Jb6l1SpssXwKD5TIl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(6486002)(956004)(2616005)(36756003)(478600001)(86362001)(31696002)(83380400001)(8676002)(8936002)(31686004)(186003)(2906002)(26005)(316002)(66556008)(107886003)(66476007)(4326008)(52116002)(16526019)(54906003)(5660300002)(16576012)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 621bLEstNZ+41FQ1+QaZ6eo5yKYT6xYuODx1L9bD5RZlNJQHBYp8ohcVwtnovyOyMMNamRvcuINZy+cGJ6+CbI2OBu4S4F+fIveez/oiZJ+NQJ0NlN5f0vupg14DdVwRhUcJ18zNtRIu70IA8oP35Rr4j34Z7ZFDStH4vjOp5kDrXizwXKahm1DdQN9D/HKkLTN9xVgg5AqVHvEVRzYvUQ20dNz6DC9piY+vfM5pCr2fBRTQbMAmF+UCQkqIyLDYJsXN9u7AreH/cef8aCuiK2mdm5IxLOg6qAXRwkwWQKGwpKiucJnlqqVQ9Wgx8ZBy/kmWib71h43CQv0yVq0Yzh9J86QqS046A9cSJYFrFRvENQTwbbKVEwyfBJn6tm6d43QXsMzdLaMb+jON7VTzXYv0gnhcwNxk3JzXTTWXWoqu63YZ/laRDrnFkRva/Z5JqS5VkD9UH3it5bXDOD0ZRBbi/0AkzI7NS2d00lHXKMAqicCnVYJuXkWkXgfiSDfm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c657b4-d503-4c83-c644-08d8136ec0ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 10:02:47.7723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAUH3YXm5pYMDNVyveBhGgpXtccGUigiE5394rXLYOE6f3jsYvTEJUjhlBHV7hII+egCC2h0WBS11FwQaUaY2WL8VEn61RA3WEdngJDQbWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.21.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 06:02:48
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

16.06.2020 19:20, Denis V. Lunev wrote:
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
>   block/io.c            | 15 +++++++++++++++
>   include/block/block.h |  3 +++
>   migration/savevm.c    |  3 +++
>   4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 6936b25c83..3afa0ff7d5 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2177,16 +2177,20 @@ int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
>   int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>                        int64_t pos, int size)
>   {
> -    int ret;
> +    int ret, ret2;
>   
>       if (!blk_is_available(blk)) {
>           return -ENOMEDIUM;
>       }
>   
>       ret = bdrv_save_vmstate(blk_bs(blk), buf, pos, size);
> +    ret2 = bdrv_flush_vmstate(blk_bs(blk));
>       if (ret < 0) {
>           return ret;
>       }
> +    if (ret2 < 0) {
> +        return ret2;
> +    }
>   
>       if (ret == size && !blk->enable_write_cache) {
>           ret = bdrv_flush(blk_bs(blk));
> diff --git a/block/io.c b/block/io.c
> index df8f2a98d4..8718df4ea8 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2724,6 +2724,21 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>       return bdrv_rw_vmstate(bs, qiov, pos, true);
>   }
>   
> +static int coroutine_fn bdrv_co_flush_vmstate(BlockDriverState *bs)
> +{
> +    return 0;
> +}
> +
> +static int coroutine_fn bdrv_flush_vmstate_co_entry(void *opaque)
> +{
> +    return bdrv_co_flush_vmstate(opaque);
> +}
> +
> +int bdrv_flush_vmstate(BlockDriverState *bs)
> +{
> +    return bdrv_run_co(bs, bdrv_flush_vmstate_co_entry, bs);
> +}
> +
>   /**************************************************************/
>   /* async I/Os */
>   
> diff --git a/include/block/block.h b/include/block/block.h
> index 25e299605e..e532bcffc8 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -572,6 +572,9 @@ int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
>   
>   int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
>                         int64_t pos, int size);
> +/* bdrv_flush_vmstate() is mandatory to commit vmstate changes if
> +   bdrv_save_vmstate() was ever called */
> +int bdrv_flush_vmstate(BlockDriverState *bs);
>   
>   void bdrv_img_create(const char *filename, const char *fmt,
>                        const char *base_filename, const char *base_fmt,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index da3dead4e9..d984ce7aa1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -150,6 +150,9 @@ static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
>   
>   static int bdrv_fclose(void *opaque, Error **errp)
>   {
> +    int err = bdrv_flush_vmstate(opaque);
> +    if (err < 0)
> +        return err;

Qemu style wants braces anyway..

>       return bdrv_flush(opaque);
>   }

I'm not sure, that we want this on read path, neither, why we already do normal flush on read path. Anyway, it should be no-op on read path and won't hurt.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

