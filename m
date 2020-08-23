Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B71520774
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sZ5+sMMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B71520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9vmx-0006Hv-KS
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vmN-0005mS-PJ; Sun, 23 Aug 2020 15:35:47 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com
 ([40.107.22.126]:20814 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vmL-0004hH-Jf; Sun, 23 Aug 2020 15:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwSzWrX8U1wvxUN0dm3AQIu9b4a2rKBEpXSAFp+OTkhiktRw6hLc7iTRVCfS+GTDXEzFfhugZh538BKmhrpJ018x8vSdWs2HSqli3xtqT3LbCM1UBhz/ZFryUGO+doHwtd0irxq/JZ0iALFXpgBIFqb+IHDGbnc2b3+4X9/PaYvp7c2DZLEpJhCbaLWuP31UoQnGS9K55O88w4GprwhYQuefQJKfanK5mUEEL7o7FnryZTZbChrRk7qfLzZ/ZPo7FQ87zZyatx4X+ELJgFffqtiPiEaS05KTiYiJNBXUyIhHDYz2Po/Q7IZJflLI2t+UIUFndzb6YATTSLD7GQgYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf0uVOa0oLBygmdFyC9oBCCyOSnX8mtpH2K+bR/Bm9g=;
 b=O+fcaN/8cceERHLdAzktBhSj8iv4LDLnZ//LIyCy1D3ScwdS5OutqTIOWaD0Kiw5PHL108yigmOMCEaHC3IS+KQSvwBTciZS5p6kPIuWJNqt+xefMqGfqPVN6VEe+jvKejhO7AD6GYjXCx+Fg94DumT36EtM2H9F7crHbszu3AxwMtEshwug0FoOQJFXkpg0wxC1D27AgVadPJCzgKw7ecsspwTzgeuwAuIY8xPkPobh8JOEGN/d/xSTi0eiGvKfICzKo6FGeVOFe4jMETaqnB5Hc8sTD2xO+SkOSSFKaPjUOvrFzElZeFCS1iPQlBUlTRjzSvxlLbJ5HTV3x7A28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf0uVOa0oLBygmdFyC9oBCCyOSnX8mtpH2K+bR/Bm9g=;
 b=sZ5+sMMREAxc11QfSowkydaLltBuEoIx2kW/dPDkmR9eCHQoYjtzWTQTDWpwhfWJeEdxkHcZCHqdyxWsrqg4wMHSetkDUxleOy6qFIKpkEpBm3GwW8fkLNyfJllf4Fgs2bSJ8cUJTx8RdfaRGqKplrcNN1lgGhFpK0eOJdf4fkY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1642.eurprd08.prod.outlook.com (2603:10a6:3:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:35:42 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Sun, 23 Aug 2020
 19:35:42 +0000
Subject: Re: [PATCH v6 2/4] copy-on-read: add filter append/drop functions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3f450bc2-73a5-49f8-53ad-d1bfa1051407@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <70d35670-2c60-eedc-c78b-29e249e88ad2@virtuozzo.com>
Date: Sun, 23 Aug 2020 22:35:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <3f450bc2-73a5-49f8-53ad-d1bfa1051407@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Sun, 23 Aug 2020 19:35:41 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c9e629-1208-4066-7cc6-08d8479bb8fa
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB16421A23D5476EBB25C10E9DF4590@HE1PR0801MB1642.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPIJXleRrXjBYff7WH4sEiyCrmN2RbBYbw1gmOHPUzT0AvP2tOqVRm4bwrCKXmVOGRDylw69l+mffOuobHO83sF+rZ2JHte7YDDRbcMCr1cHAr23J6bQVTv2lxLjzdhGB0qnGGc4yqvz53bumbB/pqPwObUUFNsUiGcCI8u1g1bjsQKlgMmYoLg2MS4AUL2OQCMIGEldJwmPLNswncnTsk4msaCh9uy1t+gISK3bfppBhFqYqv3xMuV/uHatlyaoPgiWgN0AkKBcjBhaEpIVgW/MgzxgaQJDI/nUNkcajbQBkrZ+UopFwSJCYSuy/9FMAM3YYt/dmHI+0pBzjUVz3HFT3POl6deCgHwGavVj1MphvaPA6fVcPmbI/1tuoaL/xA3Vth6EV8nIQmGZ+Le3Y2TU1yXLE+A/J0msm6JcWFEgyYPKYg2h8t9XyYg++JCsk8chORwqFN9gvPdcmkAk6iuEkCc8FXZmGNjWPIP62GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39830400003)(346002)(478600001)(66556008)(107886003)(8676002)(6512007)(31696002)(6486002)(8936002)(83380400001)(36756003)(66946007)(4326008)(66476007)(16526019)(186003)(26005)(53546011)(6506007)(52116002)(5660300002)(44832011)(2616005)(316002)(86362001)(956004)(2906002)(31686004)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K6pTnzzSRpun24kMMZW+C+MK8T+apRXcqvApkD3lcI3ymYdi2CBgx4le63jCk2y/8QChuWpUZITtXn5AIbu9BL+4ffo+tSzi32Y010c1KNsVeqQjCUdOY+0B70LkZDyIP31c2s3cdpeXJ+C3LWkiJcizGICyDsa3LHTJROSQBtI/+ONJ5m5vx76UXPDSF7LepgVFs49ara1sQwX5CXarv1diIZp/HipjEU89zYUIY3q7CDY2O2AtFvi/TT14yYDC/gIy5fOvTjeb4Tejf5mMimoRVeI5RZIzBSJb7AITKpO+uAFn6F8ID2nHYY+q6HfAx9YP4npfLI6qlKVKa+OgPDR7iP/8RbsYMIOMYpk5RoRkCQoqbFbVm/PzwuubJTYECkUfJA94VQFKpa3XmpdybD9XTteqkvQ6W5tRnfcPyedeTkRX3kIdzCd1zMfU8wViWQgejC+nSZqYm/of5vFCiMc5CE6r/G37G8bGDl+UWtMd5PtyCiIDzw/edynZqCpcrPOgJvJfHDWTbZK9e6FLPquIflOlfUx2sUJtAtpQykMIwtwdKjzyXgyFqggaxiLG2UVAp39F1KNDJqLIyhVoG+Wc1bKzEL8b4w1dBt0FEGhx9oipqDX2W4KrscsZwRRTb3zBMePHfcaWgFYopPKjZg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c9e629-1208-4066-7cc6-08d8479bb8fa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:35:42.3980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPhkxNAK0zo7xsjwQIljtP67Fw617JCMp8rK/IOfvD0IZ99w7dk2wqDZ5HrjfIIaxbkUtlwpsOMhTNbY8nRjmPpLzqQivyw+s3E59vY1XEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1642
Received-SPF: pass client-ip=40.107.22.126;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:35:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.08.2020 13:21, Vladimir Sementsov-Ogievskiy wrote:
> 19.08.2020 00:24, Andrey Shinkevich wrote:
>> Provide API for the COR-filter insertion/removal.
>> Also, drop the filter child permissions for an inactive state when the
>> filter node is being removed.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 103 
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/copy-on-read.h |  36 ++++++++++++++++++
>>   2 files changed, 139 insertions(+)
>>   create mode 100644 block/copy-on-read.h
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index cb03e0f..150d9b7 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -23,11 +23,21 @@
>>   #include "qemu/osdep.h"
>>   #include "block/block_int.h"
>>   #include "qemu/module.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qmp/qdict.h"
>> +#include "block/copy-on-read.h"
>> +
>> +
>> +typedef struct BDRVStateCOR {
>> +    bool active;
>> +} BDRVStateCOR;
>>       static int cor_open(BlockDriverState *bs, QDict *options, int 
>> flags,
>>                       Error **errp)
>>   {
>> +    BDRVStateCOR *state = bs->opaque;
>> +
>>       bs->file = bdrv_open_child(NULL, options, "file", bs, 
>> &child_of_bds,
>>                                  BDRV_CHILD_FILTERED | 
>> BDRV_CHILD_PRIMARY,
>>                                  false, errp);
>> @@ -42,6 +52,8 @@ static int cor_open(BlockDriverState *bs, QDict 
>> *options, int flags,
>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>               bs->file->bs->supported_zero_flags);
>>   +    state->active = true;
>
> We don't need to call bdrv_child_refresh_perms() here, as permissions 
> will be
> updated soon, when the filter node get its parent, yes?
>
> Let's add at least a comment on this.
>
>> +
>>       return 0;
>>   }
>>   @@ -57,6 +69,17 @@ static void cor_child_perm(BlockDriverState *bs, 
>> BdrvChild *c,
>>                              uint64_t perm, uint64_t shared,
>>                              uint64_t *nperm, uint64_t *nshared)
>>   {
>> +    BDRVStateCOR *s = bs->opaque;
>> +
>> +    if (!s->active) {
>> +        /*
>> +         * While the filter is being removed
>> +         */
>> +        *nperm = 0;
>> +        *nshared = BLK_PERM_ALL;
>> +        return;
>> +    }
>> +
>>       *nperm = perm & PERM_PASSTHROUGH;
>>       *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
>>   @@ -135,6 +158,7 @@ static void cor_lock_medium(BlockDriverState 
>> *bs, bool locked)
>>     static BlockDriver bdrv_copy_on_read = {
>>       .format_name                        = "copy-on-read",
>> +    .instance_size                      = sizeof(BDRVStateCOR),
>>         .bdrv_open                          = cor_open,
>>       .bdrv_child_perm                    = cor_child_perm,
>> @@ -159,4 +183,83 @@ static void bdrv_copy_on_read_init(void)
>>       bdrv_register(&bdrv_copy_on_read);
>>   }
>>   +
>> +static BlockDriverState *create_filter_node(BlockDriverState *bs,
>> +                                            const char 
>> *filter_node_name,
>> +                                            Error **errp)
>> +{
>> +    QDict *opts = qdict_new();
>> +
>> +    qdict_put_str(opts, "driver", "copy-on-read");
>> +    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
>> +    if (filter_node_name) {
>> +        qdict_put_str(opts, "node-name", filter_node_name);
>> +    }
>> +
>> +    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
>> +}
>> +
>> +
>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>> +                                         const char *filter_node_name,
>> +                                         Error **errp)
>> +{
>> +    BlockDriverState *cor_filter_bs;
>> +    BDRVStateCOR *state;
>> +    Error *local_err = NULL;
>> +
>> +    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
>> +    if (cor_filter_bs == NULL) {
>> +        error_prepend(errp, "Could not create filter node: ");
>> +        return NULL;
>> +    }
>> +
>> +    if (!filter_node_name) {
>> +        cor_filter_bs->implicit = true;
>> +    }
>> +
>> +    bdrv_drained_begin(bs);
>> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
>> +    bdrv_drained_end(bs);
>> +
>> +    if (local_err) {
>> +        bdrv_unref(cor_filter_bs);
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    state = cor_filter_bs->opaque;
>> +    state->active = true;
>
> hmm stop. it's already active, after create_filter_node, so you don't 
> need to set it again, isn't it?


I will remove the extra assignment from the cor_open() for consistancy.

Andrey


>
>> +
>> +    return cor_filter_bs;
>> +}
>> +
>> +
>> +void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
>> +{
>> +    BdrvChild *child;
>> +    BlockDriverState *bs;
>> +    BDRVStateCOR *s = cor_filter_bs->opaque;
>> +
>> +    child = bdrv_filter_child(cor_filter_bs);
>> +    if (!child) {
>> +        return;
>> +    }
>> +    bs = child->bs;
>> +
>> +    /* Retain the BDS until we complete the graph change. */
>> +    bdrv_ref(bs);
>> +    /* Hold a guest back from writing while permissions are being 
>> reset. */
>> +    bdrv_drained_begin(bs);
>> +    /* Drop permissions before the graph change. */
>> +    s->active = false;
>> +    bdrv_child_refresh_perms(cor_filter_bs, child, &error_abort);
>> +    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
>> +
>> +    bdrv_drained_end(bs);
>> +    bdrv_unref(bs);
>> +    bdrv_unref(cor_filter_bs);
>> +}
>> +
>> +
>>   block_init(bdrv_copy_on_read_init);
>> diff --git a/block/copy-on-read.h b/block/copy-on-read.h
>> new file mode 100644
>> index 0000000..db03c6c
>> --- /dev/null
>> +++ b/block/copy-on-read.h
>> @@ -0,0 +1,36 @@
>> +/*
>> + * Copy-on-read filter block driver
>> + *
>> + * The filter driver performs Copy-On-Read (COR) operations
>> + *
>> + * Copyright (c) 2018-2020 Virtuozzo International GmbH.
>> + *
>> + * Author:
>> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef COPY_ON_READ_FILTER
>> +#define COPY_ON_READ_FILTER
>> +
>> +#include "block/block_int.h"
>> +#include "block/block-copy.h"
>
> do you really need block-copy.h ?
>
>> +
>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>> +                                         const char *filter_node_name,
>> +                                         Error **errp);
>> +void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
>> +
>> +#endif /* COPY_ON_READ_FILTER */
>>
>
> Code seems correct to me, with extra "state->active = true;" dropped:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

