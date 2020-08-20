Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D08120658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IAkgLL7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kAY-0006uf-Lb
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8k94-0004zV-LT; Thu, 20 Aug 2020 08:58:19 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:46430 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8k91-0005V3-0M; Thu, 20 Aug 2020 08:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+bwag3Rr28wNuij4NsKdfGjDwTf7X2Bxr7oDImQxtXgjbQpmY282sjpsNLhsEIfty2Xv/AVBHMKtUqPuh7UuVcazSx4n+bze1Q/RxjtBePq2qwOzHtCIDh4A0Zt/m0nPIA1Aoc09HTF18pkSHi/+jWECa6OqzvmEu40Ipqff+Py9HMtGY/ZPZvryve+OI/Id7BN18UmZJAobpqV7DgZe9o0N2EGeSQ73kDCn/BOQ7isKb/JAxbHZy+hMbotmsUuJJTd0yMgJGz5ZJgOZsxI+mIyWYVPlytPpKGBrIHAUiC04MJrLhH8iVn2wKvywGoDiAvMZOryxJs1vPwh7GSuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVuPAZ/ZMJBwMF1rvLCGZqmBt9eq9LTk0j6FZ0CybnU=;
 b=cFY3M3P1njN9e/nzWjSgugxg/8HSVQe5Vrx+r/iiTkwDkPcO0YiAwaLEryzqQ36bIzNL59AIwBImpcLpsRrOw+SdYbCUFfp2yfR3VA9+9jnxtyNJd/HlnvSwbUdvsKaBzMxnYwilFVBLySAZzGA2Uhh3wV/WO4vJr+dbfzJx7D7o9gCRvjfRoQx4k4Z51mwBbXCEWX/M+Ou/8Jw8plG+am4a52B+1tEbbVaFMcW8azF/blDbcOs7Ds8JQu++0Lh2GlVbwNkF+eMC4Y+6s//ioKaIE+WNbNvh5h+b3h/g06goLdnMGi92Cu6edpggpWaFG281X/6Zfy/lrdE3uN4ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVuPAZ/ZMJBwMF1rvLCGZqmBt9eq9LTk0j6FZ0CybnU=;
 b=IAkgLL7yFdUCsICSpj0fyuWAnRnfg8nyfD7giOndjuq9wbBtggFiXLqLEk/PhWH3b1xtcB69IvKHMgbIfomGhcY2lT7Q3lGmnLsXeCn4uk0Xp2tCHkLkmTBV+/vEJpsOULXFb/hewjuhCPKljqsGuAe0o7uMtlL+tD8qeRFSnp0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2529.eurprd08.prod.outlook.com (2603:10a6:203:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 12:58:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 12:58:10 +0000
Subject: Re: [PATCH v4 1/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20376551-a9c1-75b0-d9fb-18a3f0ca997d@virtuozzo.com>
Date: Thu, 20 Aug 2020 15:58:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200818133240.195840-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 12:58:09 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6243d878-cfc2-439c-6bb3-08d84508b104
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2529:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25295C6EEAFF7DEC4110C3EFC15A0@AM5PR0802MB2529.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4LOmj7mpweSpcBaY4GpX2y0wd8e9J9elCD4XczkNPDyA5/+bIUanasE5rAaesSlpicsLV6ROhl9WbBCaBri47C2LfeRaGfdDDY5Ce4kRbGxh7NEdGLl3cvufsGyG/jl+lxfTPj6fvJfUsh4SUaUxTOfqTixVrlFfbO/H6VfKAQkeq0uOOcXZvOnp7SDAZv0ZLD8TjpsFIylQL1NeW4W+TmvINA5F2XyFkrkr6LOKkBGoq5gpRhqMZ7TyMjhHcLWyr7A8S07ivEYwWPxPb+fV7Nm2OZu8pnPxEbc9QM7xkqYYVKcrp/Eh8frbEjUKoLhoGj5IRaCtWRO0PkYD67hTEoFXxBKkyBiFpigW8/Pm7VzzQhf6jcK9WnDzMqkE4FvbSIQz3+3r4gY5nlEoIi5qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(366004)(396003)(478600001)(8676002)(54906003)(4326008)(8936002)(66946007)(956004)(2616005)(186003)(66556008)(66476007)(16576012)(316002)(16526019)(86362001)(36756003)(52116002)(5660300002)(31686004)(6486002)(31696002)(26005)(83380400001)(2906002)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qpdbS3NWn3fhTMy18Pp6sNi8PPrgV+Y+ioRMdnrCLrSKmQDjeM0jqVjSpOPL2nq8EvdR7P5jRb7564RygMj6vf61Bgf8npHgk0OqhdHKG8sB0TY3lBulkg89KkwOsGUaGtMlRTmw4BiBh83FUp81XB60e77mLJ8nGfEMC7AsI74wkpwCwfRN5fZc12JJCuxYZhXqdtb1IYRl6ZwwZ3rOJ8FQ8VHfLoDH4NlazTDNnzAi6oI+fZF1l4noT5Zr5yjp84m1AOFTvYkEVFvxXQkhCItsR4QD3NnfRIhsSxr/v9Y7Rad+liSYFYv3PWoOHk2kWYIixdOdTp7H7KRBTZICsHFtp7JtPMt1fAXFqcaRWW4R9qXc8WLPGf0brQ2pOslTY9jmj9Ckz7cyzaSYhG0mSevgBmC+9n2DU9IptXCMqY1WqgUrWj9NYWW1IWMkAQVsr2vHSHuKfq7UnbSWZixyxDtkSLPmdPFyRuxBUOPsZVB+pw2qOuBFc90QIgSZbx/6AEVhPWNwVIqOH603es6JnbcrW2e7ei9W43xa1xUu5sMziHTGw8bcpSJktu3XRKnRmfjSeVwJVXj0iBxWNiHdByOI/9mJ0632GayIPIqUr9+LpQ+4j3zV2WL+/ykIfLz6VeGyJjnkIzHT6hmqo1sUKg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6243d878-cfc2-439c-6bb3-08d84508b104
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 12:58:10.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25S2jwLiGvilv9u7eNHbVJ5G1fl1OIpp3IkCcg5+RX21FT0KbrBiKpA63UmUJjJWORi5651q9ZnwUp12+kqXtdCkQ5rDjWKaa0fz/1uJARM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2529
Received-SPF: pass client-ip=40.107.7.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:58:12
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

18.08.2020 16:32, Max Reitz wrote:
> This migration parameter allows mapping block node names and bitmap
> names to aliases for the purpose of block dirty bitmap migration.
> 
> This way, management tools can use different node and bitmap names on
> the source and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> While touching this code, fix a bug where bitmap names longer than 255
> bytes would fail an assertion in qemu_put_counted_string().
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/migration.json            | 101 +++++++-
>   migration/migration.h          |   3 +
>   migration/block-dirty-bitmap.c | 409 ++++++++++++++++++++++++++++-----
>   migration/migration.c          |  30 +++
>   monitor/hmp-cmds.c             |  30 +++
>   5 files changed, 517 insertions(+), 56 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ea53b23dca..0c4ae102b1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json

[..]

>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.
> +#          The mapping must be one-to-one, but not necessarily
> +#          complete: On the source, unmapped bitmaps and all bitmaps
> +#          on unmapped nodes will be ignored.  On the destination,
> +#          all unmapped aliases in the incoming migration stream will
> +#          be reported, but they will not result in failure.
Actually, on unknown alias we cancel incoming bitmap migration, which means that destination vm continues to run, other (non-bitmap) migration states continue to migrate but all further chunks of bitmap migration will be ignored. (I'm not sure it worth be mentioned)

> +#          Note that the destination does not know about bitmaps it
> +#          does not receive, so there is no limitation or requirement
> +#          regarding the number of bitmaps received, or how they are
> +#          named, or on which nodes they are placed.
> +#          By default (when this parameter has never been set), bitmap
> +#          names are mapped to themselves.  Nodes are mapped to their
> +#          block device name if there is one, and to their node name
> +#          otherwise. (Since 5.2)
> +#
>   # Since: 2.4
>   ##
>   { 'enum': 'MigrationParameter',
> @@ -656,7 +712,8 @@
>              'multifd-channels',
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
>              'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level' ,'multifd-zstd-level' ] }
> +           'multifd-zlib-level' ,'multifd-zstd-level',
> +           'block-bitmap-mapping' ] }
>   
>   ##

[..]

> @@ -303,21 +497,39 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
>           return 0;
>       }
>   
> +    bitmap_name = bdrv_dirty_bitmap_name(bitmap);
> +
>       if (!bs_name || strcmp(bs_name, "") == 0) {
>           error_report("Bitmap '%s' in unnamed node can't be migrated",
> -                     bdrv_dirty_bitmap_name(bitmap));
> +                     bitmap_name);
>           return -1;
>       }
>   
> -    if (bs_name[0] == '#') {
> +    if (alias_map) {
> +        const AliasMapInnerNode *amin = g_hash_table_lookup(alias_map, bs_name);
> +
> +        if (!amin) {
> +            /* Skip bitmaps on nodes with no alias */
> +            return 0;
> +        }
> +
> +        node_alias = amin->string;
> +        bitmap_aliases = amin->subtree;
> +    } else {
> +        node_alias = bs_name;
> +        bitmap_aliases = NULL;
> +    }
> +
> +    if (node_alias[0] == '#') {
>           error_report("Bitmap '%s' in a node with auto-generated "
>                        "name '%s' can't be migrated",
> -                     bdrv_dirty_bitmap_name(bitmap), bs_name);
> +                     bitmap_name, node_alias);
>           return -1;
>       }

This check is related only to pre-alias_map behavior, so it's probably better to keep it inside else{} branch above. Still, aliases already checked to be wellformed, so this check will be always false anyway for aliases and will not hurt.

>   
>       FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> -        if (!bdrv_dirty_bitmap_name(bitmap)) {
> +        bitmap_name = bdrv_dirty_bitmap_name(bitmap);
> +        if (!bitmap_name) {
>               continue;
>           }
>   

[..]

> @@ -770,8 +1014,10 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>       return 0;
>   }
>   
> -static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
> +static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
> +                                    GHashTable *alias_map)
>   {
> +    GHashTable *bitmap_alias_map = NULL;
>       Error *local_err = NULL;
>       bool nothing;
>       s->flags = qemu_get_bitmap_flags(f);
> @@ -780,28 +1026,73 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>       nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
>   
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> -        if (!qemu_get_counted_string(f, s->node_name)) {
> -            error_report("Unable to read node name string");
> +        if (!qemu_get_counted_string(f, s->node_alias)) {
> +            error_report("Unable to read node alias string");
>               return -EINVAL;
>           }
> +
>           if (!s->cancelled) {
> -            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +            if (alias_map) {
> +                const AliasMapInnerNode *amin;
> +
> +                amin = g_hash_table_lookup(alias_map, s->node_alias);
> +                if (!amin) {
> +                    error_setg(&local_err, "Error: Unknown node alias '%s'",
> +                               s->node_alias);
> +                    s->bs = NULL;
> +                } else {
> +                    bitmap_alias_map = amin->subtree;
> +                    s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
> +                }
> +            } else {
> +                s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
> +                                       &local_err);
> +            }
>               if (!s->bs) {
>                   error_report_err(local_err);
>                   cancel_incoming_locked(s);
>               }
>           }
> -    } else if (!s->bs && !nothing && !s->cancelled) {
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
> +    } else if (!nothing && !s->cancelled) {
>           error_report("Error: block device name is not set");
>           cancel_incoming_locked(s);
>       }
>   
> +    assert(nothing || s->cancelled || !!alias_map == !!bitmap_alias_map);
> +
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> -        if (!qemu_get_counted_string(f, s->bitmap_name)) {
> +        const char *bitmap_name;
> +
> +        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
>               error_report("Unable to read bitmap name string");

Probably s/name/alias/ like for node error message.

>               return -EINVAL;
>           }
> +
>           if (!s->cancelled) {
> +            if (bitmap_alias_map) {
> +                bitmap_name = g_hash_table_lookup(bitmap_alias_map,
> +                                                  s->bitmap_alias);
> +                if (!bitmap_name) {
> +                    error_report("Error: Unknown bitmap alias '%s' on node "
> +                                 "'%s' (alias '%s')", s->bitmap_alias,
> +                                 s->bs->node_name, s->node_alias);
> +                    cancel_incoming_locked(s);
> +                }
> +            } else {
> +                bitmap_name = s->bitmap_alias;
> +            }
> +
> +            g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>               s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>   
>               /*

[..]

> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -469,6 +469,32 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "%s: '%s'\n",
>               MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>               params->tls_authz);
> +
> +        if (params->has_block_bitmap_mapping) {
> +            const BitmapMigrationNodeAliasList *bmnal;
> +
> +            monitor_printf(mon, "%s:\n",
> +                           MigrationParameter_str(
> +                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
> +
> +            for (bmnal = params->block_bitmap_mapping;
> +                 bmnal;
> +                 bmnal = bmnal->next)
> +            {
> +                const BitmapMigrationNodeAlias *bmna = bmnal->value;
> +                const BitmapMigrationBitmapAliasList *bmbal;
> +
> +                monitor_printf(mon, "  '%s' -> '%s'\n",

'->' would look strange for incoming. Maybe, change to '--' or '~'.

> +                               bmna->node_name, bmna->alias);
> +
> +                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
> +                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
> +
> +                    monitor_printf(mon, "    '%s' -> '%s'\n",
> +                                   bmba->name, bmba->alias);
> +                }
> +            }
> +        }
>       }
>   
>       qapi_free_MigrationParameters(params);
> @@ -1384,6 +1410,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>           p->has_announce_step = true;
>           visit_type_size(v, param, &p->announce_step, &err);
>           break;
> +    case MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING:
> +        error_setg(&err, "The block-bitmap-mapping parameter can only be set "
> +                   "through QMP");
> +        break;
>       default:
>           assert(0);
>       }
> 

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

