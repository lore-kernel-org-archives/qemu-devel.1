Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B01C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40931206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IghkGdP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40931206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYi5-0006fw-FW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxYhF-0006AO-Qv; Mon, 20 Jul 2020 12:31:21 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:47486 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxYhA-0005qs-9E; Mon, 20 Jul 2020 12:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAbboV/4vohEAGlGiIcD+EoukAOqpeqm/oP2757YLEVLzIydTNyaLjv5NWm186h+M9Rjef5bBfF8Lx3/X9bBltjVKAa3zPi8CJB5fOEZdWV8RT4BZ44EZ/d91Otl4sdTjg0qHY3xTQW8llfUyuzkygLcGL7RUlO2z7ZWQ3goai4LJhpVxhfYV0IzhzB3ohQZxR4y6DtXy5WdxJxAtEGB50LOBJqBWK9+F+ZxpU76oz4V1RKwc+AiMeQnVStuE/5Y4S7rQnYWCoyMUuwzKcvJcEV0WfvsL4eh+JfZlPlrWsxFl9hhPZIXRhBx/JT03xkXoqlBFoAvD5KHfCDiIJmRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWnd5JVJqNdraaPdGWSxk0FEf3EbWPWEiBbYGpbewfQ=;
 b=CVXR5F14pJ+o17rfFTcatCcgNKAWpU5pTJ0PD/Tfvv0FCbTOPUwZ4dF1QHsg25Xp0be2T7yfgbPsxhUu420CjSOgkIEK+8QQIAFPANewUZGYUhYlW0fVt96aWQ3RgdvlSMB7mDvLjzvPiz7lC/pN8B4gbMDUS7L7BuTIlbydjBO70+Utbpg41xV5q5NrBirRk2OCMjDkIQPaybvJcheecasZHUaPCvkJ55VAwJWtLRyNuoGAAkU6lH1YBIHwtkskbkfX0B005CmXe8fyWiev/lxIPYvKNk2AoH/Xfo7d5v+mAI4EA1d8n7V5Djwn3LlCUrhl075M7A5O94rOo+lh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWnd5JVJqNdraaPdGWSxk0FEf3EbWPWEiBbYGpbewfQ=;
 b=IghkGdP+bhTZ5iVeizj14zDu+MMrcJKsAH/ydLt1Ya+yhbBwOfPeLpPIhQPbejvvKPCPAChbCmv11hmDNf92PuhBMSU5hZxz07DRDqqGnHra/x9ijTd1v9/JNWZZ0Mk8ZPn0MuOrifq5lrAuW2rjCDfC23Ndf3fQPQWzUhREk8k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4600.eurprd08.prod.outlook.com (2603:10a6:20b:84::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Mon, 20 Jul
 2020 16:31:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:31:10 +0000
Subject: Re: [PATCH v2 1/3] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200716135303.319502-1-mreitz@redhat.com>
 <20200716135303.319502-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ab6c9048-868f-23bc-5366-ca53f11f01a5@virtuozzo.com>
Date: Mon, 20 Jul 2020 19:31:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200716135303.319502-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:208:55::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR04CA0124.eurprd04.prod.outlook.com (2603:10a6:208:55::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 16:31:09 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e2a5495-dab5-49ff-c84d-08d82cca4f97
X-MS-TrafficTypeDiagnostic: AM6PR08MB4600:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4600D5F12EDD21898225C593C17B0@AM6PR08MB4600.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dRtIt2NVqZ+esJuE6P2/dWDvVXNblglLsBUBIWWTfushg9Sk5WsPnQ9PQt+G6IZRpXbvyKEfaNCX8LAaN+NN/KmhGtXsWGYJJ+riHxAjC4NPAeL4gOUq9NNFlfNRM7YsUo+bTUKIvDfUkH94p511meU8631EGO5cCW67FO5ZXXUuDmR7bRBmYZitgZd/Tg4Bu6Rlfft5B2E8FapH2UzhYOs7NQ96J6B7zI35PJRX9xwvCAK+7X1QPH2YRODBuwzbHEeMRxbGFKCLHo7qBzFmXDCdqUihrb8MrwGUbAKJD/xmcBwzCKvshMG+pVSmayujFw8BYPJeym659p/lT/WCh584HYuhbmFN+EBa9I3+tqn1x2b/B7WrSUhqkRTAPYiu03oAjF7cUgQBMs16JlPcVZ7veBL97DxJ9dkMNoqDr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39840400004)(26005)(186003)(52116002)(16526019)(31696002)(86362001)(2616005)(2906002)(478600001)(83380400001)(16576012)(31686004)(6486002)(4326008)(66476007)(66556008)(66946007)(956004)(8676002)(36756003)(8936002)(5660300002)(316002)(54906003)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FUY1F905ffZ5wAtxAVEovg9R1NUXkorPNU0AzjAU8t8PRJaIjWMP5qJSFDt9DYjvrlyfUTmUZQQYnpnKaQj6RkKV1NzwYbUgvcBH0krwFe2kKW1PDYL54iZ5r7ZjpM0qmKzYsE4LYP1fS/DfCHKFzH9on8uiE8bg0wZy+5cRhhr6xIAQCvh3qNKXXvGRJqAL6UcTS7I/vMMCX5KtopzfZfDyh8gP+HeC0F1nX1hx6YpemU5AoZol4ycyVZ/UvLyCSOrcPgDIK2GTb6JRI4W01FOXBRfgRfwJfKy5olt9XZ54v+PWlGNqIU9ENu3ERoarx4w5wUFo0C2JnqN2J9VYGdUkbTz2v+EkDYE0VzIbViUlRK1zx9GTAtKmOWv36y4Ecszo78MSKRl+Be0m97JL6JxNjc9AZ9Rkm8mS7scw95/KePfX/y/2VqKcxRoiKFXTXDy79rPNUtWTZN1P29A0FLVM/mEnC5dJ1/qHYxozNYhmboEpDBw3SOF95xf2H7aX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a5495-dab5-49ff-c84d-08d82cca4f97
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 16:31:10.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Uc9RY/6lgHV2N7eqZ8iKlVSsXzUs4zUj/4x6jVa/mzU+01jhY6qlE8wvnMZOelxm9Ku8Fx6TfWwSR/cqxRwShgt4R2t/JNT8UZT27jIOMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
Received-SPF: pass client-ip=40.107.8.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 12:31:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 16:53, Max Reitz wrote:
> This migration parameter allows mapping block node names and bitmap
> names to aliases for the purpose of block dirty bitmap migration.
> 
> This way, management tools can use different node and bitmap names on
> the source and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Vladimir noted in v1 that it would be better to ignore bitmaps whose
> names aren't mapped, or that are on nodes whose names aren't mapped.
> One of the reasons he gave was that bitmap migration is inherently a
> form of postcopy migration, and we should not break the target when it
> is already running because of a bitmap issue.
> 
> So in this version, I changed the behavior to just ignore bitmaps
> without a mapping on the source side.  On the destination, however, I
> kept it an error when an incoming bitmap or node alias is unknown.
> 
> This is in violation of Vladimir's (rightful) reasoning that such
> errors should never break the already running target, but I decided to
> do so anyway for a couple of reasons:
> 
> - Ignoring unmapped bitmaps on the source is trivial: We just have to
>    not put them into the migration stream.
>    On the destination, it isn't so easy: We (I think) would have to
>    modify the code to actively skip the bitmap in the stream.
>    (On the other hand, erroring out is always easy.)

Agree. Actually, my series "[PATCH v2 00/22] Fix error handling during bitmap postcopy"
do something like this. But no sense in mixing such logic into your series :)

> 
> - Incoming bitmaps with unknown names are already an error before this
>    series.  So this isn't introducing new breakage.
> 
> - I think it makes sense to drop all bitmaps you don't want to migrate
>    (or implicitly drop them by just not specifying them if you don't care
>    about them) on the source.  I can't imagine a scenario where it would
>    be really useful if the destination could silently drop unknown
>    bitmaps.  Unknown bitmaps should just be dropped on the source.
> 
> - Choosing to make it an error now doesn't prevent us from relaxing that
>    restriction in the future.

Agree, that's all OK. Still we can at least ignore, if we don't get some
bitmap on destination, for which mapping is set (I think you do exactly
this, will see below).


> ---
>   qapi/migration.json            |  92 +++++++-
>   migration/migration.h          |   3 +
>   migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++++++++++-----
>   migration/migration.c          |  30 +++
>   monitor/hmp-cmds.c             |  30 +++
>   5 files changed, 473 insertions(+), 55 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..1b0fbcef96 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -507,6 +507,44 @@

[..]

>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.
> +#          The mapping must be one-to-one, and on the destination also
> +#          complete: On the source, bitmaps on nodes where either the
> +#          bitmap or the node is not mapped will be ignored.  In
> +#          contrast, on the destination, receiving a bitmap (by alias)
> +#          from a node (by alias) when either alias is not mapped will
> +#          result in an error.

Still, not receiving some bitmap is not an error. It's good. I think, should
be mentioned here too (does it violate "compelete" term?).

> +#          By default (when this parameter has never been set), bitmap
> +#          names are mapped to themselves.  Nodes are mapped to their
> +#          block device name if there is one, and to their node name
> +#          otherwise. (Since 5.2)
> +#
>   # Since: 2.4

[..]

> -static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s,
> +                                    GHashTable *alias_map)
>   {
> +    GHashTable *bitmap_alias_map = NULL;
>       Error *local_err = NULL;
>       bool nothing;
>       s->flags = qemu_get_bitmap_flags(f);
> @@ -676,25 +890,68 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>       nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
>   
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> -        if (!qemu_get_counted_string(f, s->node_name)) {
> -            error_report("Unable to read node name string");
> +        if (!qemu_get_counted_string(f, s->node_alias)) {
> +            error_report("Unable to read node alias string");
>               return -EINVAL;
>           }
> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +
> +        if (alias_map) {
> +            const AliasMapInnerNode *amin;
> +
> +            amin = g_hash_table_lookup(alias_map, s->node_alias);
> +            if (!amin) {
> +                error_report("Error: Unknown node alias '%s'", s->node_alias);
> +                return -EINVAL;
> +            }
> +
> +            bitmap_alias_map = amin->subtree;
> +            s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
> +        } else {
> +            s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias, &local_err);
> +        }
>           if (!s->bs) {
>               error_report_err(local_err);
>               return -EINVAL;
>           }
> -    } else if (!s->bs && !nothing) {
> +    } else if (s->bs) {
> +        if (alias_map) {
> +            const AliasMapInnerNode *amin;
> +
> +            /* Must be present in the map, or s->bs would not be set */
> +            amin = g_hash_table_lookup(alias_map, s->node_alias);
> +            assert(amin != NULL);
> +
> +            bitmap_alias_map = amin->subtree;
> +        }
> +    } else if (!nothing) {
>           error_report("Error: block device name is not set");
>           return -EINVAL;
>       }
>   
> +    assert(!!alias_map == !!bitmap_alias_map);

Actually one '!' is enough. But '!!' looks good too (usual convertion to bool, why not).

But what's more serious: this assertion will fail in case of "nothing"
(sorry my architecture :(.

I assume, by protocol, chunk with EOS flag may contain bitmap and/or node information or may not.

So, it most probably should be: assert(nothing || (!alias_map == !bitmap_alias_map))

(You can cover "nothing" case in test, if enable bitmap migrations when no bitmaps to migrate)

> +
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> -        if (!qemu_get_counted_string(f, s->bitmap_name)) {
> +        const char *bitmap_name;
> +
> +        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
>               error_report("Unable to read bitmap name string");
>               return -EINVAL;
>           }
> +
> +        if (bitmap_alias_map) {
> +            bitmap_name = g_hash_table_lookup(bitmap_alias_map,
> +                                              s->bitmap_alias);
> +            if (!bitmap_name) {
> +                error_report("Error: Unknown bitmap alias '%s' on node '%s' "
> +                             "(alias '%s')", s->bitmap_alias, s->bs->node_name,
> +                             s->node_alias);
> +                return -EINVAL;
> +            }
> +        } else {
> +            bitmap_name = s->bitmap_alias;
> +        }
> +
> +        g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));

Hmm. Actually, we should check that in alias map target bitmap_name is short enough. It may be done later.

>           s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>   
>           /* bitmap may be NULL here, it wouldn't be an error if it is the
> @@ -702,7 +959,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>           if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {


OK, with assertion fixed;

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's a bit weak, because:

  - I don't have good understanding all these migration parameters logics with this triple duplication. So if it works in test, it should be good enough.
  - The whole logic of bitmap migration is a bit hard to follow (I know, that it's my code :). I'll revisit it when rebasing my big series "[PATCH v2 00/22] Fix error handling during bitmap postcopy".

-- 
Best regards,
Vladimir

