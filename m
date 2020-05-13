Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A321206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bGuKC8NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A321206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxiF-00057Z-T9
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYxhe-0004YA-1F; Wed, 13 May 2020 16:10:06 -0400
Received: from mail-eopbgr40100.outbound.protection.outlook.com
 ([40.107.4.100]:24886 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYxha-0001Fl-UV; Wed, 13 May 2020 16:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU9853Cy0HYQfC2/OYR2irbIp459cBAgJtgCZe+zKsTyMsH0ywVKcNHQ3z0dNjF+7l7d79C9rBgbp47yLb5235gcyPAXQoI1XZtqJb0h/hJEgXFVBnUHBh1H24DoBUma4qK5159eEzSMqeSIW7CuV+hlxKjEBLYW+E3VU+SU09u6ygqJnEABvWp1WDKyfkAlbRyHEU2gghQBKuNNqqn8JvamJ7828BD3MGFRZE0lC/xoWP7W90XyiA7HIAskz1SnvZTmhGEQtQzhFoN5rJIDfAs5wDjNO01bCCKZ95JFVrig/Kef87T4ESUyDgfE6dyz86if23LM8XfnIjgMAvJQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxmhwAxuwP7tcok/FRUsWBF1JJA+/ZcrrVYvMHf4LNA=;
 b=LS0t+rWJnvda47G5x9O9BUUwbYyusjaywblCPKML+N8k5ecTWlOEh5cjj0bR9/z0w88FbNco3dZnliErUOyGz4pOTkxllQe2JkEnrypJ2ejwxw6HI0wbWsgYgvi7dRQc3LupQtQxnsDSecyI8FIODoCeyIeiCWV1YhI/eeT33CBl1s1U51Sc9AlGWU9O3oBlucDt7wnuxSTd3UwrdfFS7bFva7SITeEs8VwqH9KTfLsejpXmnApoMjAN+pPaVqF7h0t5MgXobf7NWeCWr7wZu4pHvXrse8qfOaIqOMxaq+pEPgB7MV1N0uhOExu/+bhRzZQ1yufSVlQRdqfHm8wwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxmhwAxuwP7tcok/FRUsWBF1JJA+/ZcrrVYvMHf4LNA=;
 b=bGuKC8NQDpPvGBp+ZhG+zeKWv6u8AfW8TDrEGs2vNFLFVS98ERgVqA3o/CdZP8kzfLw3xktsk0gxIyMc5/DBfxGF4TkTTRI/YGi5mfg2xG04+7eVKqWkkdHhN8yG33qdg0liZtdbaU5D8dwM+fMB2B1cyMfrPLgZMceZtr1CT1M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4109.eurprd08.prod.outlook.com (2603:10a6:803:e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 20:09:59 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 20:09:58 +0000
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513145610.1484567-1-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a82008b-d272-82f2-a8a1-615437abcda7@virtuozzo.com>
Date: Wed, 13 May 2020 23:09:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513145610.1484567-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::29) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24 via Frontend Transport; Wed, 13 May 2020 20:09:57 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2f590a8-a3ed-4dd6-4e9e-08d7f7799c9c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4109:
X-Microsoft-Antispam-PRVS: <VI1PR08MB41096D7243B353E0C515D9E9C1BF0@VI1PR08MB4109.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jd4GU0AOC9RSvED+sfUA/ddNeQIvJZ6xlLbbrMsaixVK+CHOyaz8EvPVI/OlI7kbYrvS80Q9N6Cyw/RKZZBhxB1rsQ3GY2qn7wkfuZ207D5qEyrzmEY6dr83dHx4tniLYMLYsjraaNLhD8mmp0Q1Bn+oqVQecgWe72XhfLvGvHDcr81yEqCQ0s8no37eHvRcpVP0RcXtfppVBvGQUvjBgiw0OMswUEg/HLKr/fy8dosO9A/lCRIJcrS2EQb0XUfo6zV+hEe21ngo8AQbepqHWyRzTmA22kS+rhtmCtDLLZpufjYV/B+CV7h0Sg8Ae+D2UzNB8LDi6zuUau3ZyDMd6obDNFnBYwSM9IrpYO2OYbfBA4TQMkHeJHQXjKjtfeh6+i7WGIicyMwqEOcuZ1ynl/nV+CMjkvwESyFGFi8iTqLESjOFtxFNZiNHHDmzDP4V01lCwUQ5cNT47+/B7ODaLfx4Yb5OJIxx3BOzOil6dcS6pN5bV4nDJYIE/7uchK4g47mkOhM7A+WRzPE541bTkN47pAC1qwp23SKcRyRnRfkeo0/6ybdJyi6gJbtNbKfBd7DiIOClDZRo3d9JMkhM/f43cU9qWoQhRD5m6wjaIkanSW3vcrcWvbgNpuvxHVm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39840400004)(33430700001)(66946007)(966005)(478600001)(66476007)(66556008)(5660300002)(2616005)(31696002)(16576012)(54906003)(86362001)(8676002)(16526019)(31686004)(6486002)(956004)(4326008)(26005)(52116002)(2906002)(186003)(33440700001)(36756003)(8936002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 47DPmfWEFyYY5uOLX9vd2IiWYFhOjHpOYKMRQld/e0Mzl1eq0erd9YrSvfnQ8H+Uhuj+tFFj1Fk0Ac0mu2N9Wg+UoIvZXZc96Pn95o5mOVHs0ePMX/lB+wGx0hXLXYxmx5EqMuyweoK2rA0V5p7+ha1J72z/wErcTpiVUiPLT9IEXNUp2nPB55SIJ+UtFCILW7efVcu6WahAq79n0nx0SBNN3KfZFS3jRCm6H54AOu7G3qWPNkldqCtrDIf5+qPQ9vZU1Y7u+LPu/Ka83s4U6rjQd+Cz9zzxwjY0z6zidhEvHwJ2J1a0jeUXQjE+CKmdTXbd8FjNaAZZbRQQVcQ0pPqhOmDY4fy/ZuOrHRpGAEi6O6J6rpHZG8HZ8XyRlkq2sbZfWlE6qbFOOXPV/BnUeRAcqxtTJUPbp0vgkTfTogJjWH3EV6/t1lPUJlTdO1I1rmk2KXytV9e3wqGre2Kyb5LGufCmz8sVhhcVJYpLhL3BY0mcN0rTt/MP6Rpy9vXF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f590a8-a3ed-4dd6-4e9e-08d7f7799c9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 20:09:58.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbRW3f0BvzLaIV8AJGp/7KQ1B/I6g6c12nzACmyMWfi9NRxrCkfR6VP+CnVKficuCIBmfASNda+qwplLACRSMz6ksWj+y915erexgH5SrSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4109
Received-SPF: pass client-ip=40.107.4.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 16:10:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Krempa <pkrempa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 17:56, Max Reitz wrote:
> This command allows mapping block node names to aliases for the purpose
> of block dirty bitmap migration.
> 
> This way, management tools can use different node names on the source
> and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-rfc-v2
> Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-rfc-v2
> 
> (Sorry, v1 was just broken.  This one should work better.)
> 
> Vladimir has proposed something like this in April:
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00171.html
> 
> Now I’ve been asked by my manager to look at this, so I decided to just
> write a patch to see how it’d play out.

Great! Sometimes I remember about this thing, but never start implementing :)

> 
> This is an RFC, because I’d like to tack on tests to the final version,
> but I’m not sure whether I can come up with something before the end of
> the week (and I’ll be on PTO for the next two weeks).
> 
> Also, I don’t know whether migration/block-dirty-bitmap.c is the best
> place to put qmp_migrate_set_bitmap_mapping(), but it appears we already
> have some QMP handlers in migration/, so I suppose it isn’t too bad.
> ---
>   qapi/migration.json            | 36 ++++++++++++++++++++
>   migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
>   2 files changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..97037ea635 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1621,3 +1621,39 @@
>   ##
>   { 'event': 'UNPLUG_PRIMARY',
>     'data': { 'device-id': 'str' } }
> +
> +##
> +# @MigrationBlockNodeMapping:
> +#
> +# Maps a block node name to an alias for migration.
> +#
> +# @node-name: A block node name.
> +#
> +# @alias: An alias name for migration (for example the node name on
> +#         the opposite site).
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'MigrationBlockNodeMapping',
> +  'data': {
> +      'node-name': 'str',
> +      'alias': 'str'
> +  } }
> +
> +##
> +# @migrate-set-bitmap-node-mapping:
> +#
> +# Maps block node names to arbitrary aliases for the purpose of dirty
> +# bitmap migration.  Such aliases may for example be the corresponding
> +# node names on the opposite site.
> +#
> +# By default, every node name is mapped to itself.
> +#
> +# @mapping: The mapping; must be one-to-one, but not necessarily
> +#           complete.  Any mapping not given will be reset to the
> +#           default (i.e. the identity mapping).
> +#
> +# Since: 5.1
> +##
> +{ 'command': 'migrate-set-bitmap-node-mapping',
> +  'data': { 'mapping': ['MigrationBlockNodeMapping'] } }

Hm. I like it, it's simpler and clearer than what I was thinking about.

1. So, you decided to make only node-mapping, not bitmap-mapping, so we can't rename bitmaps in-flight and can't migrate bitmaps from one node to several and visa-versa. I think it's OK, nothing good in such possibilities, and this simplifies things.

2. If I understand correctly, default to node-name matching doesn't make real sense for libvirt.. But on the other hand, libvirt should not be considered as the ony user of Qemu. Still, the default seems unsafe.. Could we make it optional? Or add an option to disable this default for absolutely strict behavior?

May be, add a parameter

fallback: node-name | error | drop

where
   node-name: use node-name as an alias, if found bitmap on the node not mentioned in @mapping [should not be useful for libvirt, but may be for others]
   error: just error-out if such bitmap found [libvirt should use it, I propose it as a default value for @fallback]
   drop: just ignore such bitmap - it will be lost [just and idea, I doubt that it is really useful]

=======

Also, we should understand (and document here), that default behavior of this command and default behavior of bitmap migration (without this command) are different things:

if command is not called, device names may be used instead of node-names.

> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7eafface61..73f400e7ea 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c

conflicts with my series "[PATCH v2 00/22] Fix error handling during bitmap postcopy"..Still, not too difficult to rebase my series if this goes first.

> @@ -73,6 +73,8 @@
>   #include "qemu/hbitmap.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "qapi/qmp/qdict.h"
>   #include "trace.h"
>   
>   #define CHUNK_SIZE     (1 << 10)
> @@ -121,6 +123,9 @@ typedef struct DirtyBitmapMigState {
>       bool bulk_completed;
>       bool no_bitmaps;
>   
> +    QDict *node_in_mapping;
> +    QDict *node_out_mapping;
> +
>       /* for send_bitmap_bits() */
>       BlockDriverState *prev_bs;
>       BdrvDirtyBitmap *prev_bitmap;
> @@ -281,8 +286,13 @@ static int init_dirty_bitmap_migration(void)
>       dirty_bitmap_mig_state.no_bitmaps = false;
>   
>       for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
> +        const QDict *map = dirty_bitmap_mig_state.node_out_mapping;
>           const char *name = bdrv_get_device_or_node_name(bs);
>   
> +        if (map) {
> +            name = qdict_get_try_str(map, name) ?: name;
> +        }
> +
>           FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>               if (!bdrv_dirty_bitmap_name(bitmap)) {
>                   continue;
> @@ -600,6 +610,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
>   
>   static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>   {
> +    const QDict *map = dirty_bitmap_mig_state.node_in_mapping;
> +    const char *mapped_node = "(none)";
>       Error *local_err = NULL;
>       bool nothing;
>       s->flags = qemu_get_bitmap_flags(f);
> @@ -612,7 +624,13 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>               error_report("Unable to read node name string");
>               return -EINVAL;
>           }
> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +
> +        mapped_node = s->node_name;

I think, we can rename s->node_name to alias.. as well as in other places in the code, including migration format specification in the comment at file top.

> +        if (map) {
> +            mapped_node = qdict_get_try_str(map, mapped_node) ?: mapped_node;
> +        }
> +
> +        s->bs = bdrv_lookup_bs(mapped_node, mapped_node, &local_err);

Should we search by device name? I think, that if command set-mapping was called, it means that user is node-name oriented, and we should work only with node-names.

>           if (!s->bs) {
>               error_report_err(local_err);
>               return -EINVAL;
> @@ -634,7 +652,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>           if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>               error_report("Error: unknown dirty bitmap "
>                            "'%s' for block device '%s'",
> -                         s->bitmap_name, s->node_name);
> +                         s->bitmap_name, mapped_node);
>               return -EINVAL;
>           }
>       } else if (!s->bitmap && !nothing) {
> @@ -713,6 +731,44 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
>       return true;
>   }
>   
> +void qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList *mapping,
> +                                         Error **errp)
> +{

Ok, so, here we don't check existing of the nodes or bitmaps in them, and the command may safely called before creating referenced nodes. It's only mapping, nothing more.

> +    QDict *in_mapping = qdict_new();
> +    QDict *out_mapping = qdict_new();
> +
> +    for (; mapping; mapping = mapping->next) {
> +        MigrationBlockNodeMapping *entry = mapping->value;
> +
> +        if (qdict_haskey(out_mapping, entry->node_name)) {
> +            error_setg(errp, "Cannot map node name '%s' twice",
> +                       entry->node_name);
> +            goto fail;
> +        }
> +
> +        if (qdict_haskey(in_mapping, entry->alias)) {
> +            error_setg(errp, "Cannot use alias '%s' twice",
> +                       entry->alias);
> +            goto fail;
> +        }
> +
> +        qdict_put_str(in_mapping, entry->alias, entry->node_name);
> +        qdict_put_str(out_mapping, entry->node_name, entry->alias);
> +    }
> +
> +    qobject_unref(dirty_bitmap_mig_state.node_in_mapping);
> +    qobject_unref(dirty_bitmap_mig_state.node_out_mapping);
> +
> +    dirty_bitmap_mig_state.node_in_mapping = in_mapping;
> +    dirty_bitmap_mig_state.node_out_mapping = out_mapping;
> +
> +    return;
> +
> +fail:
> +    qobject_unref(in_mapping);
> +    qobject_unref(out_mapping);
> +}
> +
>   static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>       .save_setup = dirty_bitmap_save_setup,
>       .save_live_complete_postcopy = dirty_bitmap_save_complete,
> 


-- 
Best regards,
Vladimir

