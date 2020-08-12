Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF53C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A5A206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq+u+iP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A5A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5roN-0006YZ-Mn
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5rnc-00064p-1u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:32:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5rnZ-0004KX-8G
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597242731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkyt5e6vRLcJ+WBA+9WQYP79plP8i7eLyuUonTbwlho=;
 b=gq+u+iP3QJCxfsezLK3eEMAqmL/eTjeqEBhX3YC73okBS/0lsXY6SaGTLt8AoMITQB1Db1
 qtnctcGbzx7aU/pesJVweD3hmMGj6mb5lcfv/ORgrMWx8CeF+Z9LIjJScR/SsN4srzFmkg
 t3Alka8RkRj8VybCsudpuH1xVfyi+h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-6j5Wm42ZOzGEJSvp93Y54A-1; Wed, 12 Aug 2020 10:32:07 -0400
X-MC-Unique: 6j5Wm42ZOzGEJSvp93Y54A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CBC68912D8;
 Wed, 12 Aug 2020 14:32:06 +0000 (UTC)
Received: from [10.3.112.157] (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D701C600C5;
 Wed, 12 Aug 2020 14:32:04 +0000 (UTC)
Subject: Re: [PATCH for-5.2 v3 1/3] migration: Add block-bitmap-mapping
 parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200722080516.126147-1-mreitz@redhat.com>
 <20200722080516.126147-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e5d25c70-3214-09fe-cc2c-0320b6f836ef@redhat.com>
Date: Wed, 12 Aug 2020 09:32:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722080516.126147-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:32:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 3:05 AM, Max Reitz wrote:
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
>   qapi/migration.json            | 104 ++++++++-
>   migration/migration.h          |   3 +
>   migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++++++++++-----
>   migration/migration.c          |  30 +++
>   monitor/hmp-cmds.c             |  30 +++
>   5 files changed, 485 insertions(+), 55 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..d7e953cd73 100644
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

5.2, now, but I can touch that up if it is the only problem raised.

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

Grammar is a bit odd and it feels repetitive.  How about:

The mapping must not provide more than one alias for a bitmap, nor reuse 
the same alias across multiple bitmaps in the same node. On the source, 
an omitted node or bitmap within a node will ignore those bitmaps. In 
contrast, on the destination, receiving a bitmap (by alias) from a node 
(by alias) when either alias is not mapped will result in an error.

> +#          Note that the destination does not know about bitmaps it
> +#          does not receive, so there is no limitation or requirement
> +#          regarding the number of bitmaps received, or how they are
> +#          named, or on which nodes they are placed.
> +#          By default (when this parameter has never been set), bitmap
> +#          names are mapped to themselves.  Nodes are mapped to their
> +#          block device name if there is one, and to their node name
> +#          otherwise. (Since 5.2)

Looks good.


> @@ -781,6 +839,25 @@
>   #          will consume more CPU.
>   #          Defaults to 1. (Since 5.0)
>   #
> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
> +#          aliases for the purpose of dirty bitmap migration.  Such
> +#          aliases may for example be the corresponding names on the
> +#          opposite site.

Ah, the joys of duplicated text.

> +++ b/migration/block-dirty-bitmap.c

> @@ -128,7 +131,8 @@ typedef struct DirtyBitmapMigState {
>   
>   typedef struct DirtyBitmapLoadState {
>       uint32_t flags;
> -    char node_name[256];
> +    char node_alias[256];
> +    char bitmap_alias[256];

Do we properly check that alias names will never overflow?

> +static GHashTable *construct_alias_map(const BitmapMigrationNodeAliasList *bbm,
> +                                       bool name_to_alias,
> +                                       Error **errp)
> +{
> +    GHashTable *alias_map;
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

Maybe id_wellformed should enforce lengths?  Otherwise, I'm not seeing a 
length limit applied during the mapping process.

Modulo that, I think we're ready to go.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


