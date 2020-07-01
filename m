Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A059206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KYmzXmUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A059206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdqQ-0004Yx-EZ
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqdos-00039o-Uy; Wed, 01 Jul 2020 10:34:38 -0400
Received: from mail-eopbgr60114.outbound.protection.outlook.com
 ([40.107.6.114]:49406 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqdoo-0003v8-4h; Wed, 01 Jul 2020 10:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI/EM1wht54QL3pkrhL/UFIJsX9fZSE0qzjKCZpjBkgznIxq0ikxSlEoY0w4Why64QPhPYY4/leIFLcG/Rb23bhE6DhmTx5dba1mVu6T21XDizqe+rIUjpZkL3U6nzEDZlr/rAotrmzqVxD1ZEvtzuq4kSgUiBP8pB+GcrOIxJ3T5g7x+gw5YozAd3Cr4ewEf9/M7iMO7OtWAIpXBr9UFkwc8VEviG1YA3JhWLOrYQy0L5SJ5qPBs/efoLV4TCBRqDWm5ROjsSx0cXge5PWCykJ7njk83u9YORDkOYwJHJbkW2Pkkeodt0r1n6wYwTs69OVCxOL/0XW89tNilb4exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCs+P4exvUWUYM+bvAoJOzKxQrQpjZ2hcj4mLEGxPw0=;
 b=OfvrXDLm9o9e2Q4e8gFUlPH08tc1qS0mOfN0B6cbSYBJo4dAKkYuneMgIGVdaiyk7FLKvFNA0M9+sKzSYOx8ElnPbj3oZV9igAIdho4GzqbcZAdAfIWRq+Dro1k99l+j5tKwlWY/5I44JAkRWqTZLdbNO9WbqvVAMe/3K1r/67UvnZ9qBCxghoG2MmPsPMTI1RxWh8JwhQUJ0nhjKISgw0n0RQh+HYoZwJIeWVDnnXXGDKbegGsne2sbSTIBmy7MqpS6pHva68IftjBZ5MZNc6GJvHk7LRwhEnfdIx1Y0wEv4mKgh37KKfKl9oL6atsN2+w9CufD7KBdZhPEjd+WSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCs+P4exvUWUYM+bvAoJOzKxQrQpjZ2hcj4mLEGxPw0=;
 b=KYmzXmUA6kZZeGSI7u/nY9YC4JJmZ6r/io4iwK0JaC08lQl2ALLacHs5YKtD1P+p8JfYG4rV0xIkXiSHQG5lpfeuihFjsXhPv15h8Z4w3V3/JXUW185VHo/vyuF/8NtfGD65WVV0addELwbo5w21YCT3oIxoSQq7CjTbfF68qNA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3544.eurprd08.prod.outlook.com (2603:10a6:20b:4e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 14:34:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 14:34:30 +0000
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
Date: Wed, 1 Jul 2020 17:34:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200630084552.46362-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR01CA0117.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 14:34:29 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba56ac6-4edf-4bdf-2502-08d81dcbdd78
X-MS-TrafficTypeDiagnostic: AM6PR08MB3544:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3544B8DC674857B36ABC75C1C16C0@AM6PR08MB3544.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIZOnMoDP/gBtxe78x5208evIGaoYF15BLh28jn+c0s3u8R4PlJj5C8wDoPZ2jryD2wFB+TA451TPsebP034TthKjyeZgrMWQc+BcxMvHFTQCB2FODgDk6/jdGyND1TBcXyZEWiwmyHzqh0xEEl7ZCkGL5LvNraxfaGgrGckvPhMiI2uMTmSxNfHh5cb3QppEDrMcZkyPx/ZosTYe+ZPa7WzTIjy5gBdn7jKLt88qWNJrbmZYGmJ0lygwEsiWp02qHeoE4Oeq+cYkxPkwbh3/W95d/9yZrboOu43Kx6+xARZXvZZWKnRzePVpUlFCt1WWZCmxVrer4b2vWXpJEzgdKiFxQOGnoPkkMf0T8k28TwBIJmXvvsqDOsaLqE0lDVEIcvRyQ7wky6xOhvD/w6aGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(346002)(136003)(376002)(4326008)(83380400001)(66556008)(66946007)(66476007)(52116002)(36756003)(31686004)(2616005)(956004)(6486002)(54906003)(8936002)(186003)(16526019)(26005)(31696002)(8676002)(2906002)(30864003)(86362001)(316002)(16576012)(478600001)(5660300002)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gPJY7cuyJBthfPdcHGpZlEN5ZkcYaI6ibnJPiOj2U30JgbiE2SEAAb9ZF6WCRIXNR3EOn5uDoqJTYaa+J+JrhQpADgrV6DUFY/fc/Bi5u8o7EftuSffSzF5Tg1ddrLfVK2LwfviXY0wFWI3JziC7BSVT0d71WiXfdAlnWUoNDgKM8z2hqYy6ajA7dp0QiKM8UI23XJaCT761ST3qblUYkTFAlmeJh5wLk/DQ0J65e+QaiJL+f7TidpKb0beYSy2UM/3LL0ZmmUSkEn+BNKazMLYxygQ1Xpu63T+OqOZs8KO+hS/ZJIp7IRST4PbinFMrF81QJK7FZO9UVia8KLk8iW94KKFOvN+KxoDVzEIet3O9AFB89EE3/PksKrbKH5+wn/ZDwyEuTv2GjjKBlsC45NPwBqmX2XgHD1olkTKiYBPRLbI0Y4/H9OPKaKlbIB1yWosw8A+lKhxWbY9bKMn3VIayDMu2TEq9n8vjU+Sm+7s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba56ac6-4edf-4bdf-2502-08d81dcbdd78
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 14:34:30.6271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkTSYuAhtovgrV2XcLbf8zeNtHu+4Yp42V4GuMdC5vLDWuq3YpaxmvvZuYouzS8qbxqLNuXTDlSsT4dcYli1Or+HGX71cb6tC1UIXgKqhdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3544
Received-SPF: pass client-ip=40.107.6.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 10:34:31
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.06.2020 11:45, Max Reitz wrote:
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
>   qapi/migration.json            |  83 +++++++-
>   migration/migration.h          |   3 +
>   migration/block-dirty-bitmap.c | 372 ++++++++++++++++++++++++++++-----
>   migration/migration.c          |  29 +++
>   4 files changed, 432 insertions(+), 55 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..5aeae9bea8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -507,6 +507,44 @@
>     'data': [ 'none', 'zlib',
>               { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>   
> +##
> +# @BitmapMigrationBitmapAlias:
> +#
> +# @name: The name of the bitmap.
> +#
> +# @alias: An alias name for migration (for example the bitmap name on
> +#         the opposite site).
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'BitmapMigrationBitmapAlias',
> +  'data': {
> +      'name': 'str',
> +      'alias': 'str'
> +  } }
> +
> +##
> +# @BitmapMigrationNodeAlias:
> +#
> +# Maps a block node name and the bitmaps it has to aliases for dirty
> +# bitmap migration.
> +#
> +# @node-name: A block node name.
> +#
> +# @alias: An alias block node name for migration (for example the
> +#         node name on the opposite site).
> +#
> +# @bitmaps: Mappings for the bitmaps on this node.
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'BitmapMigrationNodeAlias',
> +  'data': {
> +      'node-name': 'str',
> +      'alias': 'str',
> +      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]

So, we still can't migrate bitmaps from one node to different nodes, but we
also don't know a usecase for it, so it seems OK. But with such scheme we
can select and rename bitmaps in-flight, and Peter said about corresponding
use-case.

I'm OK with this, still, just an idea in my mind:

we could instead just have a list of

BitmapMigrationAlias: {
  node-name
  bitmap-name
  node-alias
  bitmap-alias
}

so, mapping is set for each bitmap in separate.

> +  } }
> +
>   ##
>   # @MigrationParameter:
>   #
> @@ -641,6 +679,18 @@
>   #          will consume more CPU.
>   #          Defaults to 1. (Since 5.0)
>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.
> +#          The mapping must be one-to-one and complete: On the source,

I've recently faced the case where incomplete mapping make sence: shared
migration of read-only bitmaps in backing files: it seems better to not
migrate them through migration channel, they are migrating through
shared storage automatically (yes, we'll pay the time to load them on
destination, but I'm going to improve it by implementing lazy load of
read-only and disabled bitmaps, so this will not be a problem).

So, now I think that it would be good just ignore all the bitmap not
described by mapping

> +#          migrating a bitmap from a node when either is not mapped
> +#          will result in an error.  On the destination, similarly,
> +#          receiving a bitmap (by alias) from a node (by alias) when
> +#          either alias is not mapped will result in an error.
> +#          By default, all node names and bitmap names are mapped to
> +#          themselves. (Since 5.1)

This sentense is unclear, want means "by default" - if the mapping is
not specified at all or if some nodes/bitmaps are not covered. Still,
tha latter will conflict with previous sentencies, so "by default" is
about when mapping is not set at all. I suggest to word it directly:
"If mapping is not set (the command never called, or mapping was
removed".

And, actual behavior without mapping is not as simple: it actually tries
to use blk names if possible and node-names if not, and this veries
from version to version. So, I think not worth to document it in detail,
just note, that without mapping the behavior is not well defined and
tries to use block-device name if possible and node-name otherwise. And
of course direct mapping of bitmap names.

> +#
>   # Since: 2.4
>   ##
>   { 'enum': 'MigrationParameter',
> @@ -655,7 +705,8 @@
>              'multifd-channels',
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
>              'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level' ,'multifd-zstd-level' ] }
> +           'multifd-zlib-level' ,'multifd-zstd-level',
> +           'block-bitmap-mapping' ] }
>   
>   ##
>   # @MigrateSetParameters:
> @@ -781,6 +832,18 @@
>   #          will consume more CPU.
>   #          Defaults to 1. (Since 5.0)
>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.
> +#          The mapping must be one-to-one and complete: On the source,
> +#          migrating a bitmap from a node when either is not mapped
> +#          will result in an error.  On the destination, similarly,
> +#          receiving a bitmap (by alias) from a node (by alias) when
> +#          either alias is not mapped will result in an error.
> +#          By default, all node names and bitmap names are mapped to
> +#          themselves. (Since 5.1)

Do we really need this duplication? I'd prefere to document it once if possible.

> +#
>   # Since: 2.4
>   ##
>   # TODO either fuse back into MigrationParameters, or make
> @@ -811,7 +874,8 @@
>               '*max-cpu-throttle': 'int',
>               '*multifd-compression': 'MultiFDCompression',
>               '*multifd-zlib-level': 'int',
> -            '*multifd-zstd-level': 'int' } }
> +            '*multifd-zstd-level': 'int',
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>   
>   ##
>   # @migrate-set-parameters:
> @@ -957,6 +1021,18 @@
>   #          will consume more CPU.
>   #          Defaults to 1. (Since 5.0)
>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.
> +#          The mapping must be one-to-one and complete: On the source,
> +#          migrating a bitmap from a node when either is not mapped
> +#          will result in an error.  On the destination, similarly,
> +#          receiving a bitmap (by alias) from a node (by alias) when
> +#          either alias is not mapped will result in an error.
> +#          By default, all node names and bitmap names are mapped to
> +#          themselves. (Since 5.1)

once again..

> +#
>   # Since: 2.4
>   ##
>   { 'struct': 'MigrationParameters',
> @@ -985,7 +1061,8 @@
>               '*max-cpu-throttle': 'uint8',
>               '*multifd-compression': 'MultiFDCompression',
>               '*multifd-zlib-level': 'uint8',
> -            '*multifd-zstd-level': 'uint8' } }
> +            '*multifd-zstd-level': 'uint8',
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>   
>   ##
>   # @query-migrate-parameters:
> diff --git a/migration/migration.h b/migration/migration.h
> index f617960522..038c318b92 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -336,6 +336,9 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>   
>   void dirty_bitmap_mig_before_vm_start(void);
>   void init_dirty_bitmap_incoming_migration(void);
> +bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
> +                                      Error **errp);
> +
>   void migrate_add_address(SocketAddress *address);
>   
>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 47bc0f650c..621eb7e3f8 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -29,10 +29,10 @@
>    *
>    * # Header (shared for different chunk types)
>    * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
> - * [ 1 byte: node name size ] \  flags & DEVICE_NAME
> - * [ n bytes: node name     ] /
> - * [ 1 byte: bitmap name size ] \  flags & BITMAP_NAME
> - * [ n bytes: bitmap name     ] /
> + * [ 1 byte: node alias size ] \  flags & DEVICE_NAME
> + * [ n bytes: node alias     ] /
> + * [ 1 byte: bitmap alias size ] \  flags & BITMAP_NAME
> + * [ n bytes: bitmap alias     ] /
>    *
>    * # Start of bitmap migration (flags & START)
>    * header
> @@ -72,7 +72,9 @@
>   #include "migration/register.h"
>   #include "qemu/hbitmap.h"
>   #include "qemu/cutils.h"
> +#include "qemu/id.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-commands-migration.h"
>   #include "trace.h"
>   
>   #define CHUNK_SIZE     (1 << 10)
> @@ -103,7 +105,8 @@
>   typedef struct DirtyBitmapMigBitmapState {
>       /* Written during setup phase. */
>       BlockDriverState *bs;
> -    const char *node_name;
> +    char *node_alias;
> +    char *bitmap_alias;
>       BdrvDirtyBitmap *bitmap;
>       uint64_t total_sectors;
>       uint64_t sectors_per_chunk;
> @@ -128,7 +131,8 @@ typedef struct DirtyBitmapMigState {
>   
>   typedef struct DirtyBitmapLoadState {
>       uint32_t flags;
> -    char node_name[256];
> +    char node_alias[256];
> +    char bitmap_alias[256];
>       char bitmap_name[256];
>       BlockDriverState *bs;
>       BdrvDirtyBitmap *bitmap;
> @@ -144,6 +148,162 @@ typedef struct DirtyBitmapLoadBitmapState {
>   static GSList *enabled_bitmaps;
>   QemuMutex finish_lock;
>   
> +/* For hash tables that map node/bitmap names to aliases */
> +typedef struct AliasMapInnerNode {
> +    char *string;
> +    GHashTable *subtree;
> +} AliasMapInnerNode;

Probably, would be simpler to have (node,bitmap) <-> (node-alias,bitmap-alias) mapping than nested hash-tables, but this should work too, I don't have real arguments.

> +
> +static void free_alias_map_inner_node(void *amin_ptr)
> +{
> +    AliasMapInnerNode *amin = amin_ptr;
> +
> +    g_free(amin->string);
> +    g_hash_table_unref(amin->subtree);
> +    g_free(amin);
> +}
> +
> +/**
> + * Construct an alias map based on the given QMP structure.
> + *
> + * (Note that we cannot store such maps in the MigrationParameters
> + * object, because that struct is defined by the QAPI schema, which
> + * makes it basically impossible to have dicts with arbitrary keys.
> + * Therefore, we instead have to construct these maps when migration
> + * starts.)
> + *
> + * @bbm is the block_bitmap_mapping from the migration parameters.
> + *
> + * If @name_to_alias is true, the returned hash table will map node
> + * and bitmap names to their respective aliases (for outgoing
> + * migration).
> + *
> + * If @name_to_alias is false, the returned hash table will map node
> + * and bitmap aliases to their respective names (for incoming
> + * migration).
> + *
> + * The hash table maps node names/aliases to AliasMapInnerNode
> + * objects, whose .string is the respective node alias/name, and whose
> + * .subtree table maps bitmap names/aliases to the respective bitmap
> + * alias/name.
> + */
> +static GHashTable *construct_alias_map(const BitmapMigrationNodeAliasList *bbm,
> +                                       bool name_to_alias,
> +                                       Error **errp)
> +{
> +    GHashTable *alias_map = NULL;

dead assignment

> +
> +    alias_map = g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                      g_free, free_alias_map_inner_node);
> +
> +    for (; bbm; bbm = bbm->next) {
> +        const BitmapMigrationNodeAlias *bmna = bbm->value;
> +        const BitmapMigrationBitmapAliasList *bmbal;
> +        AliasMapInnerNode *amin;
> +        GHashTable *bitmaps_map;
> +        const char *node_map_from, *node_map_to;
> +
> +        if (!id_wellformed(bmna->alias)) {
> +            error_setg(errp, "The node alias %s is not well-formed",
> +                       bmna->alias);
> +            goto fail;
> +        }
> +
> +        if (name_to_alias) {
> +            if (g_hash_table_contains(alias_map, bmna->node_name)) {
> +                error_setg(errp, "The node name %s is mapped twice",
> +                           bmna->node_name);
> +                goto fail;
> +            }
> +
> +            node_map_from = bmna->node_name;
> +            node_map_to = bmna->alias;
> +        } else {
> +            if (g_hash_table_contains(alias_map, bmna->alias)) {
> +                error_setg(errp, "The node alias %s is used twice",
> +                           bmna->alias);
> +                goto fail;
> +            }
> +
> +            node_map_from = bmna->alias;
> +            node_map_to = bmna->node_name;
> +        }
> +
> +        bitmaps_map = g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                            g_free, g_free);
> +
> +        for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
> +            const BitmapMigrationBitmapAlias *bmba = bmbal->value;
> +            const char *bmap_map_from, *bmap_map_to;
> +
> +            if (name_to_alias) {
> +                bmap_map_from = bmba->name;
> +                bmap_map_to = bmba->alias;
> +
> +                if (g_hash_table_contains(bitmaps_map, bmba->name)) {
> +                    error_setg(errp, "The bitmap %s/%s is mapped twice",
> +                               bmna->node_name, bmba->name);
> +                    goto fail;

bitmaps_map is leaked here and ..

> +                }
> +            } else {
> +                bmap_map_from = bmba->alias;
> +                bmap_map_to = bmba->name;
> +
> +                if (g_hash_table_contains(bitmaps_map, bmba->alias)) {
> +                    error_setg(errp, "The bitmap alias %s/%s is used twice",
> +                               bmna->alias, bmba->alias);
> +                    goto fail;

.. here

Probably, simplest way to fix is to create AliasMapIneerNode and insert it into alias_map immediately after allocating bitmaps_map (prior to this loop).

> +                }
> +            }
> +
> +            g_hash_table_insert(bitmaps_map,
> +                                g_strdup(bmap_map_from), g_strdup(bmap_map_to));
> +        }
> +
> +        amin = g_new(AliasMapInnerNode, 1);
> +        *amin = (AliasMapInnerNode){

style: space before '{'

> +            .string = g_strdup(node_map_to),
> +            .subtree = bitmaps_map,
> +        };
> +
> +        g_hash_table_insert(alias_map, g_strdup(node_map_from), amin);
> +    }
> +
> +    return alias_map;
> +
> +fail:
> +    g_hash_table_destroy(alias_map);
> +    return NULL;
> +}
> +
> +/**
> + * Run construct_alias_map() in both directions to check whether @bbm
> + * is valid.
> + * (This function is to be used by migration/migration.c to validate
> + * the user-specified block-bitmap-mapping migration parameter.)
> + *
> + * Returns true if and only if the mapping is valid.
> + */
> +bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
> +                                      Error **errp)
> +{
> +    GHashTable *alias_map;
> +
> +    alias_map = construct_alias_map(bbm, true, errp);
> +    if (!alias_map) {
> +        return false;
> +    }
> +    g_hash_table_destroy(alias_map);
> +
> +    alias_map = construct_alias_map(bbm, false, errp);
> +    if (!alias_map) {
> +        return false;
> +    }
> +    g_hash_table_destroy(alias_map);
> +
> +    return true;
> +}
> +
>   void init_dirty_bitmap_incoming_migration(void)
>   {
>       qemu_mutex_init(&finish_lock);
> @@ -191,11 +351,11 @@ static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
>       qemu_put_bitmap_flags(f, flags);
>   
>       if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
> -        qemu_put_counted_string(f, dbms->node_name);
> +        qemu_put_counted_string(f, dbms->node_alias);
>       }
>   
>       if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> -        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
> +        qemu_put_counted_string(f, dbms->bitmap_alias);
>       }
>   }
>   
> @@ -263,15 +423,20 @@ static void dirty_bitmap_mig_cleanup(void)
>           QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
>           bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
>           bdrv_unref(dbms->bs);
> +        g_free(dbms->node_alias);
> +        g_free(dbms->bitmap_alias);
>           g_free(dbms);
>       }
>   }
>   
>   /* Called with iothread lock taken. */
> -static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
> +static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name,
> +                               GHashTable *alias_map)
>   {
>       BdrvDirtyBitmap *bitmap;
>       DirtyBitmapMigBitmapState *dbms;
> +    GHashTable *bitmap_aliases;

can bitmap_aliases be const ptr too?

> +    const char *node_alias, *bitmap_name, *bitmap_alias;
>       Error *local_err = NULL;
>   
>       bitmap = bdrv_dirty_bitmap_first(bs);
> @@ -279,21 +444,40 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>           return 0;
>       }
>   
> +    bitmap_name = bdrv_dirty_bitmap_name(bitmap);

Note, that bitmap is wrong here: it may be internal unnamed bitmap which we should ignore.
I have sent a patch for this: "[PATCH] migration/block-dirty-bitmap: fix add_bitmaps_to_list"

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
> +            error_report("Bitmap '%s' on node '%s' with no alias cannot be "
> +                         "migrated", bitmap_name, bs_name);

As I've said before, it may be reasonable to ignore bitmaps not referenced in the hash-table.
And it seems to be good default behavior. We are really tired from problems with bitmaps which
can't migrate for different reasons, when bitmaps are actually non-critical data, and choosing
from customer problems like:

  1. - Hey, after update migration is broken! It says that some bitmaps can't be migrated, what is that?
  
  2. - Hmm, it seems, that in some cases, incremental backup doesn't work after migration and full backup
       is automatically done instead.. Why?

I now prefer the [2].

> +            return -1;
> +        }
> +
> +        node_alias = amin->string;
> +        bitmap_aliases = amin->subtree;
> +    } else {
> +        node_alias = bs_name;
> +        bitmap_aliases = NULL;
> +    }

Hmm, actually bs_name argument is incompatiblewith alias_map, let's assert that they are not non-null simultaneously.

Ah stop, I see, you use bs_name as node-name later and before.. Hmm, seems all this a bit confused.

Prior the patch, why do we have bs_name: because it may be node-name or blk-name, to be use in migration protocol as (actually) an alias, so bs_name is more like an alias..

So, we have bs, which already have bs->node_name, we have alias_map, where we have relation node_name -> alias, and we have bs_name, which is something like an alias_name.

I think the most clean thing is to allow only one of bs_name and alias_map to be non-null, use bs_name only for old scenario, and for new scenario use bdrv_get_node_name() for error-reporting. And a comment about function semantics won't hurt.

upd: aha, I see that in case of new semantics, bs_name is exactly bdrv_get_node_name(). It's a bit redundant but OK too.. Let's at least add an assertion.

> +
> +    if (node_alias[0] == '#') {
>           error_report("Bitmap '%s' in a node with auto-generated "
>                        "name '%s' can't be migrated",
> -                     bdrv_dirty_bitmap_name(bitmap), bs_name);
> +                     bitmap_name, node_alias);

OK, this should not relate to mapped case, as aliases are well-formed.

>           return -1;
>       }
>   
>       FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> -        if (!bdrv_dirty_bitmap_name(bitmap)) {
> +        bitmap_name = bdrv_dirty_bitmap_name(bitmap);
> +        if (!bitmap_name) {
>               continue;
>           }
>   
> @@ -302,12 +486,24 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>               return -1;
>           }
>   
> +        if (bitmap_aliases) {
> +            bitmap_alias = g_hash_table_lookup(bitmap_aliases, bitmap_name);
> +            if (!bitmap_alias) {
> +                error_report("Bitmap '%s' with no alias on node '%s' cannot be "
> +                             "migrated", bitmap_name, bs_name);
> +                return -1;
> +            }
> +        } else {
> +            bitmap_alias = bitmap_name;
> +        }
> +

Hmm, we don't error-out if we didn't find a bitmap, specified in alias-map. But it seems to be an error from the user point-of-view (the required action can't be done).

So, probably, we want loop through the alias-map (and in this case we don't need a map, but can work with QAPI list), find corresponding bitmaps and migrate them, and fail if some specified in the alias-map bitmap is not found.

>           bdrv_ref(bs);
>           bdrv_dirty_bitmap_set_busy(bitmap, true);
>   
>           dbms = g_new0(DirtyBitmapMigBitmapState, 1);
>           dbms->bs = bs;
> -        dbms->node_name = bs_name;
> +        dbms->node_alias = g_strdup(node_alias);
> +        dbms->bitmap_alias = g_strdup(bitmap_alias);
>           dbms->bitmap = bitmap;
>           dbms->total_sectors = bdrv_nb_sectors(bs);
>           dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
> @@ -333,43 +529,52 @@ static int init_dirty_bitmap_migration(void)
>       DirtyBitmapMigBitmapState *dbms;
>       GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
>       BlockBackend *blk;
> +    const MigrationParameters *mig_params = &migrate_get_current()->parameters;
> +    GHashTable *alias_map = NULL;
> +
> +    if (mig_params->has_block_bitmap_mapping) {
> +        alias_map = construct_alias_map(mig_params->block_bitmap_mapping, true,
> +                                        &error_abort);
> +    }
>   
>       dirty_bitmap_mig_state.bulk_completed = false;
>       dirty_bitmap_mig_state.prev_bs = NULL;
>       dirty_bitmap_mig_state.prev_bitmap = NULL;
>       dirty_bitmap_mig_state.no_bitmaps = false;
>   
> -    /*
> -     * Use blockdevice name for direct (or filtered) children of named block
> -     * backends.
> -     */
> -    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> -        const char *name = blk_name(blk);
> -
> -        if (!name || strcmp(name, "") == 0) {
> -            continue;
> -        }
> +    if (!alias_map) {
> +        /*
> +         * Use blockdevice name for direct (or filtered) children of named block
> +         * backends.
> +         */
> +        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> +            const char *name = blk_name(blk);
>   
> -        bs = blk_bs(blk);
> +            if (!name || strcmp(name, "") == 0) {
> +                continue;
> +            }
>   
> -        /* Skip filters without bitmaps */
> -        while (bs && bs->drv && bs->drv->is_filter &&
> -               !bdrv_has_named_bitmaps(bs))
> -        {
> -            if (bs->backing) {
> -                bs = bs->backing->bs;
> -            } else if (bs->file) {
> -                bs = bs->file->bs;
> -            } else {
> -                bs = NULL;
> +            bs = blk_bs(blk);
> +
> +            /* Skip filters without bitmaps */
> +            while (bs && bs->drv && bs->drv->is_filter &&
> +                   !bdrv_has_named_bitmaps(bs))
> +            {
> +                if (bs->backing) {
> +                    bs = bs->backing->bs;
> +                } else if (bs->file) {
> +                    bs = bs->file->bs;
> +                } else {
> +                    bs = NULL;
> +                }
>               }
> -        }
>   
> -        if (bs && bs->drv && !bs->drv->is_filter) {
> -            if (add_bitmaps_to_list(bs, name)) {
> -                goto fail;
> +            if (bs && bs->drv && !bs->drv->is_filter) {
> +                if (add_bitmaps_to_list(bs, name, NULL)) {
> +                    goto fail;
> +                }
> +                g_hash_table_add(handled_by_blk, bs);
>               }
> -            g_hash_table_add(handled_by_blk, bs);
>           }
>       }
>   
> @@ -378,7 +583,7 @@ static int init_dirty_bitmap_migration(void)
>               continue;
>           }
>   
> -        if (add_bitmaps_to_list(bs, bdrv_get_node_name(bs))) {
> +        if (add_bitmaps_to_list(bs, bdrv_get_node_name(bs), alias_map)) {
>               goto fail;
>           }
>       }
> @@ -393,11 +598,17 @@ static int init_dirty_bitmap_migration(void)
>       }
>   
>       g_hash_table_destroy(handled_by_blk);
> +    if (alias_map) {
> +        g_hash_table_destroy(alias_map);
> +    }
>   
>       return 0;
>   
>   fail:
>       g_hash_table_destroy(handled_by_blk);
> +    if (alias_map) {
> +        g_hash_table_destroy(alias_map);
> +    }
>       dirty_bitmap_mig_cleanup();
>   
>       return -1;
> @@ -662,8 +873,10 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
>       return 0;
>   }
>   
> -static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s,
> +                                    GHashTable *alias_map)
>   {
> +    GHashTable *bitmap_alias_map = NULL;
>       Error *local_err = NULL;
>       bool nothing;
>       s->flags = qemu_get_bitmap_flags(f);
> @@ -672,25 +885,68 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
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
>           s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>   
>           /* bitmap may be NULL here, it wouldn't be an error if it is the
> @@ -698,7 +954,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>           if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>               error_report("Error: unknown dirty bitmap "
>                            "'%s' for block device '%s'",
> -                         s->bitmap_name, s->node_name);
> +                         s->bitmap_name, s->bs->node_name);
>               return -EINVAL;
>           }
>       } else if (!s->bitmap && !nothing) {
> @@ -711,6 +967,8 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
>   
>   static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>   {
> +    GHashTable *alias_map = NULL;
> +    const MigrationParameters *mig_params = &migrate_get_current()->parameters;

is it OK, that we don't use migration_incoming_get_current() instead?

>       static DirtyBitmapLoadState s;
>       int ret = 0;
>   
> @@ -720,10 +978,15 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>           return -EINVAL;
>       }
>   
> +    if (mig_params->has_block_bitmap_mapping) {
> +        alias_map = construct_alias_map(mig_params->block_bitmap_mapping,
> +                                        false, &error_abort);
> +    }
> +
>       do {
> -        ret = dirty_bitmap_load_header(f, &s);
> +        ret = dirty_bitmap_load_header(f, &s, alias_map);
>           if (ret < 0) {
> -            return ret;
> +            goto fail;
>           }
>   
>           if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
> @@ -739,12 +1002,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>           }
>   
>           if (ret) {
> -            return ret;
> +            goto fail;
>           }
>       } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>   
>       trace_dirty_bitmap_load_success();
> -    return 0;
> +    ret = 0;
> +fail:
> +    if (alias_map) {
> +        g_hash_table_destroy(alias_map);
> +    }
> +    return ret;
>   }
>   
>   static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
> diff --git a/migration/migration.c b/migration/migration.c
> index 47c7da4e55..23fc13e527 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -35,6 +35,7 @@
>   #include "block/block.h"
>   #include "qapi/error.h"
>   #include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-migration.h"
>   #include "qapi/qapi-visit-sockets.h"
>   #include "qapi/qapi-commands-migration.h"
>   #include "qapi/qapi-events-migration.h"
> @@ -825,6 +826,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>       params->has_announce_step = true;
>       params->announce_step = s->parameters.announce_step;
>   
> +    if (s->parameters.has_block_bitmap_mapping) {
> +        params->has_block_bitmap_mapping = true;
> +        params->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
> +                                                  params->block_bitmap_mapping);
> +    }
> +
>       return params;
>   }
>   
> @@ -1292,6 +1299,13 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
>                      "is invalid, it must be in the range of 1 to 10000 ms");
>          return false;
>       }
> +
> +    if (params->has_block_bitmap_mapping &&
> +        !check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
> +        error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
> +        return false;
> +    }
> +
>       return true;
>   }
>   
> @@ -1386,6 +1400,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>       if (params->has_announce_step) {
>           dest->announce_step = params->announce_step;
>       }
> +
> +    if (params->has_block_bitmap_mapping) {
> +        dest->has_block_bitmap_mapping = true;
> +        dest->block_bitmap_mapping = params->block_bitmap_mapping;
> +    }
>   }
>   
>   static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1498,6 +1517,16 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>       if (params->has_announce_step) {
>           s->parameters.announce_step = params->announce_step;
>       }
> +
> +    if (params->has_block_bitmap_mapping) {
> +        qapi_free_BitmapMigrationNodeAliasList(
> +            s->parameters.block_bitmap_mapping);
> +
> +        s->parameters.has_block_bitmap_mapping = true;
> +        s->parameters.block_bitmap_mapping =
> +            QAPI_CLONE(BitmapMigrationNodeAliasList,
> +                       params->block_bitmap_mapping);
> +    }
>   }
>   
>   void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> 


-- 
Best regards,
Vladimir

