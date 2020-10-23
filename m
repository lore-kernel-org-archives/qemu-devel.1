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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03423C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A43721527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jvXrMS62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A43721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVy8i-00080i-Vg
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVy7X-00079I-4K; Fri, 23 Oct 2020 10:32:43 -0400
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:56321 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVy7U-00020X-Fb; Fri, 23 Oct 2020 10:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEtw5HzzV2ME7mu3jHhcSPXBV0oVs1UwNFgyVvo2l2UL+pYOpv9vNpxFutOH37vCASms1ZCOGDWm4aqc6kC3mreVOlcM1370z+Xbz3xbfubklTqsa07kElaomgwZmX0uTSWEXLFOpgEI+Rs5WpH+k22nmg2JY3HIm3wYPgtPYej2+JitbqQdW4Tv25/OGLK75uoJ7tvvMsryvrHecH8do/yo4kB8zKlx2J9iZmt+ZJK1ksOyMNdczd7n59BLkF5cbHplIuTMIKKVoBEIIxVPx4xOS2aQOFfFSq0bvc+xG9vLPScdjOASd/+enKAUx8/36PLpmGk9Y39j+mX6GFwWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtZi+kbIsiKP62sMfYwsxg3bJMdHS3GnKdsSVXL3TFA=;
 b=ayL/XIuVKXPy6pbJWVNj59CkZJXrCRgwGvV00AT9NGi0cFtYUrgX0zyw4rgvxKEHNnM3xEBhcm36CmHLt5RBx/AXe69qwaTwZTwhkN27QTy4EeQq/D0C3p09k14e65Y3z+4xfxKsyrnvWK19lt27cn1jAobqG3wUcAFiA53SiWVkg0b04pGB7ya3G4ueCTfcuqzV10Hg2lKobKBgylcmj+vT+7wvk3yCvMX6O3ZHCVfCyqcurRD25U55fFp6uMwxPtY31+Yvf9dbvFgqPgkgRqpgbirFlO4/7dtAzHW+WzhJtBgSh5cnNOjMM8TZF3Z8mhhI8ApME3gd6j9E2ZSb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtZi+kbIsiKP62sMfYwsxg3bJMdHS3GnKdsSVXL3TFA=;
 b=jvXrMS62zTkUQt+RmGwzsCPOVCkOr7vhKYfIeO77jzscD8wFCSbf/mqaluUpcWodmSOvDw7j525muzx3e57Uv6iTpkWUSwK83BKSOkmeX5BnRD5FANNuS8qTTiVSTjm5I+Y+l4dKKET96pTlCw7jT5DpR/o5DdvMM61OECLSK2U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 14:32:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:32:36 +0000
Subject: Re: [PATCH v12 02/14] block: add insert/remove node functions
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <187027cf-fe54-f326-525b-59b2e18a31a4@virtuozzo.com>
Message-ID: <758ee19b-aca4-5267-7c02-37ac21a1450a@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:32:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <187027cf-fe54-f326-525b-59b2e18a31a4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM0PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:208:be::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Fri, 23 Oct 2020 14:32:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dc3a41b-c8f7-41ca-b934-08d877607ca0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534B7B80F7066D9975C4DE6C11A0@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCQGsvBEtc5jnUsl+GfCrWuY8g1GLZODsSChYME1+KTRyhz4TU8TM2zNpxNtGF3q4Zc45DCpQ34NaefWHFvF82Lt6YPfCnfx6WvDMmtF+YJXH86VqrHWfbTZHRYISi5X5T3IolyAwYioNG4/bcLnjnM0MHDoOrz+IoyCJWI7Ay5DWlGEkINhsuXDf9hpkStQqA2nC5sLiQlDiyfb4mVCNMbf+8qUV6RTtcZxsc845AYMdJxBpIl6svtq9nWHXU2Vk779wyeJe5XDHsF0MpoiVXhABiL6pnjw8Xc3gAqLwqf4WKfxL0PoiamW+h4g2V6DbX1iyJ6LjoSkPW2A6WlHMkRKokspOlPv1JKrC2lSABTQBeqB/Nd75P3YyBaq29oJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(186003)(956004)(316002)(2616005)(31696002)(4326008)(26005)(31686004)(16526019)(52116002)(16576012)(8936002)(86362001)(5660300002)(8676002)(2906002)(6486002)(107886003)(36756003)(66946007)(478600001)(66476007)(83380400001)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Xt9kJq4FxWXBE2YqupQpmQOyXfXKXiU6t6D3pxGM4VtGKNfPrQsQefD9IxWEwdXMtYvzrF89bg5C3MHLMVBJSleenU1Kbgg5BzTeg/zV7MrA6ojiznBQyRZMR3I8M0AcjmM29cEQZvbdd5lmaClrXLW7v7NEfbr+z7HYKZRjXDncG4hkJNtk1MpDeYx8QU9WXS/K7iVx1yGTTc/5G9CZdTHcH3yTB+34zN6feXi/eNAlhiMNnRGdIUqo57eqI1R4rzkpxFXhuMmNCGR/KIDbhnQIx+jp3wJfh2DjRLwrGXKNSlsifiA/VqSDZRogTclGU6wxAY023IkdSaikmtSi6jaUG9wbXmSmNAPq86lWTfgXVQpGia4ObkG5HdkLeAqkWfWNHWLx6DQ7llJbp5/83eaUMs2KG9F2IrMsahhhawIFiRZAZa4+QylRR0p77W4NFYopQQkmTXnueqPoqRrrInqQgH9hqAsHweOFoV/p1EcAiqjZ4d/RYtKyg5KQQyqZPEC2gWhght8ELSFEOt2LACbgV9QNSAXBnVib9hTiX9x3q2nmbUD6YFmANHUA2owrJqTOV7ZQQMIFZuT+kX8DiYGX07ShkaWuma/PKkfgOywmjKhuZ2fkHxv6mVuXahi5E8eH3e5DfMSgXvMhCl7sVw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc3a41b-c8f7-41ca-b934-08d877607ca0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:32:36.5434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWSTIRe+I8+eqx0L8yEKdFJzf7d9Ljh/87kmDGycuO1EDDOPv1T/AihlV7xdPueELuKrmok7ZcynFbYXht0VyF/B+WFQcaF2LGPT54a3bfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.20.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:32:37
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

23.10.2020 17:24, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2020 21:13, Andrey Shinkevich wrote:
>> Provide API for a node insertion to and removal from a backing chain.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block.c               | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/block/block.h |  3 +++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 430edf7..502b483 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4670,6 +4670,55 @@ static void bdrv_delete(BlockDriverState *bs)
>>       g_free(bs);
>>   }
>> +BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
>> +                                   int flags, Error **errp)
>> +{
>> +    BlockDriverState *new_node_bs;
>> +    Error *local_err = NULL;
>> +
>> +    new_node_bs =  bdrv_open(NULL, NULL, node_options, flags, errp);
>> +    if (new_node_bs == NULL) {
>> +        error_prepend(errp, "Could not create node: ");
>> +        return NULL;
>> +    }
>> +
>> +    bdrv_drained_begin(bs);
>> +    bdrv_replace_node(bs, new_node_bs, &local_err);
>> +    bdrv_drained_end(bs);
>> +
>> +    if (local_err) {
>> +        bdrv_unref(new_node_bs);
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    return new_node_bs;
>> +}
>> +
>> +void bdrv_remove_node(BlockDriverState *bs)
>> +{
>> +    BdrvChild *child;
>> +    BlockDriverState *inferior_bs;
>> +
>> +    child = bdrv_filter_or_cow_child(bs);
>> +    if (!child) {
>> +        return;
>> +    }
>> +    inferior_bs = child->bs;
>> +
>> +    /* Retain the BDS until we complete the graph change. */
>> +    bdrv_ref(inferior_bs);
>> +    /* Hold a guest back from writing while permissions are being reset. */
>> +    bdrv_drained_begin(inferior_bs);
>> +    /* Refresh permissions before the graph change. */
>> +    bdrv_child_refresh_perms(bs, child, &error_abort);
>> +    bdrv_replace_node(bs, inferior_bs, &error_abort);
>> +
>> +    bdrv_drained_end(inferior_bs);
>> +    bdrv_unref(inferior_bs);
>> +    bdrv_unref(bs);
>> +}
> 
> The function is unused, and as I understand can't work as intended without s->active handling. I think it should be dropped

with bdrv_remove_node dropped:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> 
>> +
>>   /*
>>    * Run consistency checks on an image
>>    *
>> diff --git a/include/block/block.h b/include/block/block.h
>> index d16c401..ae7612f 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -350,6 +350,9 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>>                    Error **errp);
>>   void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>>                          Error **errp);
>> +BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
>> +                                   int flags, Error **errp);
>> +void bdrv_remove_node(BlockDriverState *bs);
>>   int bdrv_parse_aio(const char *mode, int *flags);
>>   int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
>>
> 
> 


-- 
Best regards,
Vladimir

