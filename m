Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11070C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1194207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSnYCIqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1194207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaicN-0001Dh-St
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jaibU-0000MD-Nc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jaibS-00020k-VQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KRs6jg2SNRkoEv+v0apRb39Kg2vRnAEw9NRLvQdpmQQ=;
 b=PSnYCIqkF3nBdMgElg8e8RvrXr64IMVN9pW+Xa+lx+4OLpG/knqGVTKTvSlnc9GYOLAKLz
 sVltfi1Z1/sz9GN3/+Up626fCkczN/Kpylb/sIN48VnxCDS/7bnIDKTQGaQs1aymAnxGc1
 av9jnxJ5wEbM2oVlh8W2SaMvehjmxqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-wfQzZ01mMv222dKufWiMmw-1; Mon, 18 May 2020 12:26:53 -0400
X-MC-Unique: wfQzZ01mMv222dKufWiMmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C73835B40;
 Mon, 18 May 2020 16:26:52 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 076453A1;
 Mon, 18 May 2020 16:26:50 +0000 (UTC)
Date: Mon, 18 May 2020 18:26:48 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200518162648.GC2995787@angien.pipo.sk>
References: <20200513145610.1484567-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200513145610.1484567-1-mreitz@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:
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

[...]

> ---
>  qapi/migration.json            | 36 ++++++++++++++++++++
>  migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
>  2 files changed, 94 insertions(+), 2 deletions(-)

I just started to write some quick and dirty hacks to test use of this
infrastructure in libvirt. I have 2 quick observations for now:

> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..97037ea635 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1621,3 +1621,39 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
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

We'd probably like a
'nodename:bitmapname' -> 'alias' mapping so that we can select which
bitmaps to migrate and where to migrate them to. The specific use case
is following:

Libvirt supports migration without shared storage (NFS/etc) where we
copy the disk images prior to the memory migration using qemu's NBD
server and the blockdev-mirror job. By default and the most simple way
which doesn't require users fudging with the disk images and copying
backing images themselves is that we flatten all the backing chain
during the copy ("sync":"full"). In this mode we'll need to do some
merging of the bitmaps prior to finalizing the copy.

It's not a problem to do it ourselves, but in the end we'll need to copy
only certain bitmaps which will be created temporarily on the source to
the destination where they'll be persisted.

For now (until I implement the use of the dirty-bitmap-populate blockjob
which I'm also doing in parallel with this kind of) when creating a
snapshot we create a new active bitmap in the overlay for every active
bitmap in the snapshotted image.

When flattening we'll then need to merge the appropriate ones. As said
it's not a problem to prepare all the bitmaps before but we then don't
need to migrate all of them.

By the way, that brings me to another question:

Is there any difference of handling of persistent and non-persistent
bitmaps? Specifically I'm curious what's the correct approach to do the
shared storage migration case when the source and destination image is
the same one. Should we also instruct to migrate the active ones? or are
they migrated by writing them to the image and reloading them?

> +##
> +# @migrate-set-bitmap-node-mapping:

qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
of migrate-set-parameters. Is it worth/necessary to add a new command
here?

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



