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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62303C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8016521527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y+K65AfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8016521527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVy0o-0005Am-Db
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVxzQ-0004RT-8T; Fri, 23 Oct 2020 10:24:21 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com
 ([40.107.6.132]:23108 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVxzJ-0000nK-RL; Fri, 23 Oct 2020 10:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt4bYcBfsFMokAijkV3UbvXeL4czuLmpmOxAgaD7FPZyYNEkublbedUHa4jHzNbRPaFEuKst46ZqaxiNo/m9m4Rnm2CqiTHzGmOAXVwp3umcwbVnf8J1znMOoUBZjMyDN87SECtn3LfTSweTIlv8xUUAjdX3pNP8cBoJnKR592+8AQHTZ+RceO8GEfyAhtZpemedQ/4LV58G0bSC44r01CPMMdPzXA9+e0MEJ+zox/03c6OSXzSC/DJUitMYBXymNO8nwROjIuhLRxsDC/r0CEjjtYgzFfiy8jzi02Mg0biNBR9+qiiq3LAUWc/vxSjkFKKHcFU8PDRxGpKgMvZ4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQv1fFr2gvfGCSeZaXD3xFxEx/V3BPgYMhzP+NoUJRs=;
 b=WIDUA0k0Mlk0kLepAprqGgiXhEEPNyM3v/tExY4/AXDLft4n3DavxKrulPme3bmCSqoyfarukGjqFLejZHLRV+TcRpmHJ5oxkVR9Zfc0Xd/AusBNjt6hP0zNtlnPqXWQNP/6k9UqXGXKkU6e02BDmCi7fYoFHDwIziAkhSN/TjRiPMK2mBZBjSUz3yJ1/6qXH3eD947/lTtnFYcYKP1oCvdgdVCqD8BMdRAr2i6Lp4Ky2n7vM+wJlGVtZhk3WBQK/uYDZ47XDW6fmoE/4uYYdC4ZcR+YLXgXboUx8gFk8t85SrOjn4gb5qKgFFb+ba+R+Jnf7B7E7MXSaT2CUuqqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQv1fFr2gvfGCSeZaXD3xFxEx/V3BPgYMhzP+NoUJRs=;
 b=Y+K65AfMtZtfuZVlQJSf8MfgRVWKeol5aqb8S0LjIXfwti6DvlAxqJR3JwFHAXwfdAPGRyiAbPN9aBDwV+HK8IbhF+jvJ/BhRxgbAoYh9r/3BPYgLJirq9ryPT57jWS/d9axT6FP3ShAdREz/58Qok8tYKNWEwPY1laFfjJV+lk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4071.eurprd08.prod.outlook.com (2603:10a6:20b:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Fri, 23 Oct
 2020 14:24:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:24:10 +0000
Subject: Re: [PATCH v12 02/14] block: add insert/remove node functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <187027cf-fe54-f326-525b-59b2e18a31a4@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:24:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM0PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:208:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM0PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:208:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Fri, 23 Oct 2020 14:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29163f9c-de5c-41a4-7f9a-08d8775f4ea7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB407166C0B0F09AF4829F4540C11A0@AM6PR08MB4071.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrhjkPPQYTAQDWOJc0iaEZ2vk7lalbuYL1sDquf2meJg+eM4vq7HQ5uiq+rgHZSqbA2rF0qdG0sIMQola0zHOTU9EIgwl5baRPQRTscuK1lnOpXq5X9BrotMDlydHQTJIp155iawL+jH+Eiq6YAtsnB0fG4wImfRGNRs70Gj7puMhF6GyUKXkInK86bnBw7Kcp7SswfCSK8h5HLZMly1yGXH3X8oeTGeOosJCSgBQK6qriTjpbsHHtbVOQVNi98fIkdPgfyYq8lIy58dgW1UQ9CRzO3DdYekbQSXrwhrUbu0YALK8llr6JFVx9Ys5xm84cwoW8OkkKsUi5OFjPJcfwtGK7R0EhRx4BbPIMfbjnCxw3Xj5iueCwDiPdgpibO2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39850400004)(396003)(366004)(376002)(8676002)(6486002)(86362001)(52116002)(478600001)(36756003)(66476007)(66556008)(186003)(4326008)(83380400001)(26005)(31696002)(2616005)(66946007)(16526019)(2906002)(8936002)(31686004)(16576012)(956004)(107886003)(5660300002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XZ/StWTndmJO2EORa5jtBGY5HfNaUKaCGszoFhbLrCAQ3ICJwJamB4hbTsMXVJbBvj5vy3JUX1xLVCiLB7jzueGj8721k5JKCuVIGrlmAfChPUxT5o1p10b2CRL3cJCO1Dds2oYYHRn6jtPNMcPKoz/TuArHuiIGh+FuehDPwTZwvkOogWo0gICc2fUiyY5Dpy1r75hAVa6JBvHgFAZZS1NFLCsfvKZq8IYJJj54kqouS+YB2+rUmft9fozqra8u8leJXBcyxbVRCbiCr3+2Lyb3CvP36HSalCT0l7H379WkJ0nYovawAjhpa8+ABRVBa3RMK0wHDO5jOLpjyj5MdZ9vUFTOSQ9Z8K7uNQBsMbSj+2u5MwPEkxxua99Kum6/E5GRXYGP7jgcbpdFBWA2SIEWQFEoknwHCwEBkPctRc4IZlpQHR3HKLkznfPe374GwsjfOIlD1c0kna9NWlhPLNjz4UA4Zauj92rOqmAtmm/jTUJyBs7pUQZO4+CfEOAWUX+cD+WC8/vMw6SUD7+zyLmZwDgynqttjh1daYIHqYPBl5LPWdFWV6qyDXdnVf4IrC1AbrWUP9UaU+trqNpVLuR5j7tsXqAa/OsUZy5Ff+xmhHnLT+ZY68CUX9l4mTqqpz4XF9SEMQZAC8lUSkMnOA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29163f9c-de5c-41a4-7f9a-08d8775f4ea7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:24:10.0294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glVaLZ6+X5Tm+/C2Yj2pNwt44MwIJgypiW5fC9Fu4hdnLy2X54jhdqtFxplkvq60QFl/9QhdvcfEpkff8L+25Zcr+YbjvwEVtKPMKQTkdp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4071
Received-SPF: pass client-ip=40.107.6.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:24:11
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
> Provide API for a node insertion to and removal from a backing chain.
> 
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block.c               | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/block/block.h |  3 +++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 430edf7..502b483 100644
> --- a/block.c
> +++ b/block.c
> @@ -4670,6 +4670,55 @@ static void bdrv_delete(BlockDriverState *bs)
>       g_free(bs);
>   }
>   
> +BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
> +                                   int flags, Error **errp)
> +{
> +    BlockDriverState *new_node_bs;
> +    Error *local_err = NULL;
> +
> +    new_node_bs =  bdrv_open(NULL, NULL, node_options, flags, errp);
> +    if (new_node_bs == NULL) {
> +        error_prepend(errp, "Could not create node: ");
> +        return NULL;
> +    }
> +
> +    bdrv_drained_begin(bs);
> +    bdrv_replace_node(bs, new_node_bs, &local_err);
> +    bdrv_drained_end(bs);
> +
> +    if (local_err) {
> +        bdrv_unref(new_node_bs);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return new_node_bs;
> +}
> +
> +void bdrv_remove_node(BlockDriverState *bs)
> +{
> +    BdrvChild *child;
> +    BlockDriverState *inferior_bs;
> +
> +    child = bdrv_filter_or_cow_child(bs);
> +    if (!child) {
> +        return;
> +    }
> +    inferior_bs = child->bs;
> +
> +    /* Retain the BDS until we complete the graph change. */
> +    bdrv_ref(inferior_bs);
> +    /* Hold a guest back from writing while permissions are being reset. */
> +    bdrv_drained_begin(inferior_bs);
> +    /* Refresh permissions before the graph change. */
> +    bdrv_child_refresh_perms(bs, child, &error_abort);
> +    bdrv_replace_node(bs, inferior_bs, &error_abort);
> +
> +    bdrv_drained_end(inferior_bs);
> +    bdrv_unref(inferior_bs);
> +    bdrv_unref(bs);
> +}

The function is unused, and as I understand can't work as intended without s->active handling. I think it should be dropped

> +
>   /*
>    * Run consistency checks on an image
>    *
> diff --git a/include/block/block.h b/include/block/block.h
> index d16c401..ae7612f 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -350,6 +350,9 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>                    Error **errp);
>   void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>                          Error **errp);
> +BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
> +                                   int flags, Error **errp);
> +void bdrv_remove_node(BlockDriverState *bs);
>   
>   int bdrv_parse_aio(const char *mode, int *flags);
>   int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
> 


-- 
Best regards,
Vladimir

