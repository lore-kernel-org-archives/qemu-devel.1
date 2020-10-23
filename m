Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F281F2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OPHl8K/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F281F2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyLU-0007Qv-Nm
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyJd-0006Pp-MJ; Fri, 23 Oct 2020 10:45:14 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com
 ([40.107.7.110]:20254 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyJa-0003aO-EZ; Fri, 23 Oct 2020 10:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLga/Ah44khPaI/yjdm1HlYU3VrkS9TdF50HM8CzR6qsX3gQdBASQwFHEiLJjVe0LbnqM1a0oU79bS2fyPADydhT7rtW1LWZQ573c9WOn/vY51W5a4isNkS4i83HKTQB6V+STX2ckJUq+bFKECmV5j0+UvUozjcWLpdrDvxsmo7b48tGrZRQvuWTkxUCf5Li1xoOjCUuku2EFfilfEvVdb2EIUMS1YoICLa1ohGEVAuRt8YL+VMn53NXd0bWagHoCcUGWP8y+09VZ0Ced8D0WjAaIOgita6v7/d/2n4xRTxJe3AtqXcofnC32N53lR2eKcET2x93CMOczyswAnBiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lov1HCgUU0mUWcVR+ZqEKmQpLFCxOjlmiFFVktVvcxQ=;
 b=jLkfSG43ThhkUMZnrN1J2xjyaOvgMCk+xdE2jh51bYa+Se3GJUr7kb525L2+IOhn5N4lZRbVX1FEnO2OR11D6S92ExqDdlmBmNanK78KWOCLcEQaZ8aS0QquhPI+UUntALxVyznSoDFtMpZZNjPfXYqGM6UuKlbmXY4YLN1BM9jP0TrePSWCNBGte4gMDd7DgqzGwxp6BJ17A5CoAZv4MeIKyIFtCL0zd7HbnN+gGP16zw7CDTO2hn7jNzLfiUh/nMsOC6WsY54MrcsloSngHH2spaxwGgbRry3ZZQN+OdAZhex0fAnVPt3dKENy3DdzoVK7iKk9Dld6+Uf6pHyQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lov1HCgUU0mUWcVR+ZqEKmQpLFCxOjlmiFFVktVvcxQ=;
 b=OPHl8K/cyBz4uTt0/dAta6kLNPhmaEbd8nxGIk4+p3ToNyApfiC59dSQ7+QkTxiyW+HeSczwB0qsSl6O/NCgfdGGX9uKJre+MlmeALK9AfVoJCX2bE+9bMB314D7NPOkMwcU2VesW6c5cLGkePoHJ+Jo4757d+v1UyqDDZBUYm4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 23 Oct
 2020 14:45:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:45:06 +0000
Subject: Re: [PATCH v12 06/14] copy-on-read: pass bottom node name to COR
 driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-7-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5cb6baa3-3035-9b50-3e45-a2a48bc8fdd6@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:45:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM0PR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM0PR01CA0108.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Fri, 23 Oct 2020 14:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93011986-dba1-4f47-24cd-08d877623ba2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382672A027FDF5003DEFD10C11A0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQmm/ESTcFyk6VvU6fSbOjYpbmL76i3wsRGzyQniGqZCBeS9XBnaxni1fPVoa3dlxfMNHYp/iv4/YZa5ZNKshH9CQSI9Ezs2vCytyBFuEvyFRG56YXay52w2kE0/7uRzvEtSNhmcgKZJv0O3R93A/0/+gpJvybk7XLZeyu4RKbKsS5jsWJJNye8fACxcbPg0ETELsqGEiqwbq0yGQGbppYHY0JZAuJJcGY5Z2vxn3KOd3iUxTfNs10+DqechIZgOJNkqMGfpDux7/RckSK18ovbmVpp0xkq/+nJU3o7/R03gz3CHAhIgrbyQVs7NrSKr5wJudeQhqwjDeEPKJoPCFjN/86jDzga7+DUarewypC0GCv5JMaW+5gAFbgrgBUr4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(2906002)(16576012)(6486002)(66946007)(31696002)(66556008)(66476007)(86362001)(31686004)(83380400001)(16526019)(316002)(26005)(8676002)(36756003)(478600001)(4326008)(5660300002)(956004)(2616005)(186003)(52116002)(107886003)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d+EvZgzl25jZw6tCTWsvmT1lZlJ/68bs4gJSv0+1ZfqQgII17/IJkYUosBkkDy/L5g4Y2R2ZqjhiBltWjTQWWtL9sTYDeUIpiUv634bAKPpSNriy5XglNIsJFZdTySwoj0rIXTBV3bEuXyVLy7BmhtBK0EBPQ1BCsz+IlJm73glEfMgLiQtpoQv993kMADQeFvAaPElclfl6WhvlI18XAgCThbHUTSN+DaBopHMeLaeIrhNmIecy5LmmC5BtFmIjUy1n74w/56k/iklU9HDNu9cNTV5SKLKHIWYAJoJkxk3r9RGJqOIBJINw2BjPmVi5rpZoEpyKfpo+ks2UhNbVWeE0So13CJXTLfcfFVm5kKkEoJodXOvji2+NMgLg8M9VpAGa5AMiQ+tz2BN4uI6E/FerpjLt4azYoKB3vJayHQfiO7ifsVBGoMJaBhGc20DYtKEK9NX+0+AeikW9kzzexgCotdsTesk9LxPTPrygm6hTYsIeepiZDvKM0Wt54KZ91+6SXBLtFfhMG2t3AlchNv5m88F8pV5R5txABM1ijbg2rPkfF4VEhwt9MFYInhFs0KFwcEfvtORAFqA/jda+f/WLOcMbZA4Sm8H8IzfoPlID9lt092enjmCHFSIjsvFQCQNIfz10JYmXIXVAHFo6rw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93011986-dba1-4f47-24cd-08d877623ba2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:45:06.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkXJZrN5VF51yV7tYodGx8q0QbmRECHVDbwmFiJSZxR2596uy0X3/wQUqmM4d7xEAlUUNe3q571lX9JY4cHebwrsH5eDNOpKw5i4jFGahu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.7.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:45:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.10.2020 21:13, Andrey Shinkevich wrote:
> We are going to use the COR-filter for a block-stream job.
> To limit COR operations by the base node in the backing chain during
> stream job, pass the bottom node name, that is the first non-filter
> overlay of the base, to the copy-on-read driver as the base node itself
> may change due to possible concurrent jobs.
> The rest of the functionality will be implemented in the patch that
> follows.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 618c4c4..3d8e4db 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -24,18 +24,24 @@
>   #include "block/block_int.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qdict.h"
>   #include "block/copy-on-read.h"
>   
>   
>   typedef struct BDRVStateCOR {
>       bool active;
> +    BlockDriverState *bottom_bs;
>   } BDRVStateCOR;
>   
>   
>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>                       Error **errp)
>   {
> +    BlockDriverState *bottom_bs = NULL;
>       BDRVStateCOR *state = bs->opaque;
> +    /* Find a bottom node name, if any */
> +    const char *bottom_node = qdict_get_try_str(options, "bottom");
>   
>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> @@ -51,7 +57,17 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
>   
> +    if (bottom_node) {
> +        bottom_bs = bdrv_lookup_bs(NULL, bottom_node, errp);
> +        if (!bottom_bs) {
> +            error_setg(errp, QERR_BASE_NOT_FOUND, bottom_node);

QERR_BASE_NOT_FOUND is unrelated here. Also, I see a comment in qerror.h that such macros should not be used in new code. And don't forget to drop qerror.h include line.

> +            qdict_del(options, "bottom");

this may be moved above "bottom_bs = ..", to not call it after "if" in separate.

> +            return -EINVAL;
> +        }
> +        qdict_del(options, "bottom");
> +    }
>       state->active = true;
> +    state->bottom_bs = bottom_bs;
>   
>       /*
>        * We don't need to call bdrv_child_refresh_perms() now as the permissions
> 


-- 
Best regards,
Vladimir

