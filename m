Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07DC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 04:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DA2218D4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 04:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DA2218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq9CB-0002F8-HC
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 00:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hq9C0-0001iy-Iq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 00:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hq9Bz-0005Ud-DM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 00:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hq9Bw-0005Rv-St; Wed, 24 Jul 2019 00:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CF223086262;
 Wed, 24 Jul 2019 04:47:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0807219C58;
 Wed, 24 Jul 2019 04:47:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7610E113865F; Wed, 24 Jul 2019 06:47:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190717173937.18747-1-jsnow@redhat.com>
Date: Wed, 24 Jul 2019 06:47:44 +0200
In-Reply-To: <20190717173937.18747-1-jsnow@redhat.com> (John Snow's message of
 "Wed, 17 Jul 2019 13:39:37 -0400")
Message-ID: <87imrsqbrj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 04:47:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add dirty-bitmaps to
 query-named-block-nodes result
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Let's add a possibility to query dirty-bitmaps not only on root nodes.
> It is useful when dealing both with snapshots and incremental backups.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [Added deprecation information. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/qapi.c         |  5 +++++
>  qapi/block-core.json |  6 +++++-
>  qemu-deprecated.texi | 12 ++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index 917435f022..15f1030264 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -79,6 +79,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>          info->backing_file = g_strdup(bs->backing_file);
>      }
>  
> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
> +        info->has_dirty_bitmaps = true;
> +        info->dirty_bitmaps = bdrv_query_dirty_bitmaps(bs);
> +    }
> +
>      info->detect_zeroes = bs->detect_zeroes;
>  
>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..9210ae233d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -360,6 +360,9 @@
>  # @write_threshold: configured write threshold for the device.
>  #                   0 if disabled. (Since 2.3)
>  #
> +# @dirty-bitmaps: dirty bitmaps information (only present if node
> +#                 has one or more dirty bitmaps) (Since 4.2)
> +#
>  # Since: 0.14.0
>  #
>  ##
> @@ -378,7 +381,7 @@
>              '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>              '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>              '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
> -            'write_threshold': 'int' } }
> +            'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo'] } }
>  
>  ##
>  # @BlockDeviceIoStatus:
> @@ -656,6 +659,7 @@
>  #
>  # @dirty-bitmaps: dirty bitmaps information (only present if the
>  #                 driver has one or more dirty bitmaps) (Since 2.0)
> +#                 Deprecated in 4.2; see BlockDirtyInfo instead.
>  #
>  # @io-status: @BlockDeviceIoStatus. Only present if the device
>  #             supports it and the VM is configured to stop on errors
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index c90b08d553..6374b66546 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -134,6 +134,18 @@ The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
>  the query-block command is deprecated. Two new boolean fields,
>  ``recording'' and ``busy'' effectively replace it.
>  
> +@subsection query-block result field dirty-bitmaps (Since 4.2)
> +
> +The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
> +the query-block command is itself now deprecated. The ``dirty-bitmaps``
> +field of the ``BlockDeviceInfo`` struct should be used instead, which is the
> +type of the ``inserted`` field in query-block replies, as well as the
> +type of array items in query-named-block-nodes.

Would the text be clearer if it talked only about commands, not about
types?

Here's my (laconic) try:

   @subsection query-block result field dirty-bitmaps (Since 4.2)

   In the result of query-block, member ``dirty-bitmaps'' has been moved
   into member ``inserted''.

Aside: same for existing @subsection query-block result field
dirty-bitmaps[i].status (since 4.0).

> +Since the ``dirty-bitmaps`` field is optionally present in both the old and
> +new locations, clients must use introspection to learn where to anticipate
> +the field if/when it does appear in command output.
> +

I find this hint a bit confusing.  Do we need it?

If yes, laconic me again:

   Clients should use introspection to learn whether ``dirty-bitmaps'' is
   in the new location.

>  @subsection query-cpus (since 2.12.0)
>  
>  The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.

