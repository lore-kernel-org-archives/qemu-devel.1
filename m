Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1EBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB76622400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLSbMbvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB76622400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX07R-0003dw-7A
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kX05c-00027i-CW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kX05Y-0006Hb-Hw
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C1c6ZL3IrqZyoFgtVPGmCxIg+IZO0dXVfN5gxBox7w=;
 b=JLSbMbvA1TbFY9HWxqbYzWKiwbmWA7M5jjIAUr4hG6DmL+HAtcI9Qoc0YEBb2h85uwobRK
 DDHy4mC2MIHT6TbYn/ys0T846rcUEsDmaLLsA0dR6tuq0zQV1Ay3s9I3HS/+tEm4smpS4h
 kcWFxSt9P+QBTJVjkBHckrRn2GM203M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-IVfgzSrWMHmCIeYTH-bH-g-1; Mon, 26 Oct 2020 06:50:51 -0400
X-MC-Unique: IVfgzSrWMHmCIeYTH-bH-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91A6B804B74;
 Mon, 26 Oct 2020 10:50:50 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B3910013D0;
 Mon, 26 Oct 2020 10:50:41 +0000 (UTC)
Date: Mon, 26 Oct 2020 11:50:39 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 06/12] nbd: Update qapi to support exporting multiple
 bitmaps
Message-ID: <20201026105039.GC727443@angien.pipo.sk>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-7-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023183652.478921-7-eblake@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 13:36:46 -0500, Eric Blake wrote:
> Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
> 5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
> nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
> changes to permit passing multiple bitmaps as distinct metadata
> contexts that the NBD client may request, but the actual support for
> more than one will require a further patch to the server.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/system/deprecated.rst |  4 +++-
>  qapi/block-export.json     | 18 ++++++++++++------
>  blockdev-nbd.c             | 13 +++++++++++++
>  nbd/server.c               | 19 +++++++++++++------
>  qemu-nbd.c                 | 10 +++++-----
>  5 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0cb..d6cd027ac740 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -268,7 +268,9 @@ the 'wait' field, which is only applicable to sockets in server mode
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> 
>  Use the more generic commands ``block-export-add`` and ``block-export-del``
> -instead.
> +instead.  As part of this deprecation, it is now preferred to export a
> +list of dirty bitmaps via ``bitmaps``, rather than a single bitmap via
> +``bitmap``.
> 
>  Human Monitor Protocol (HMP) commands
>  -------------------------------------
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 893d5cde5dfe..c7c749d61097 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -74,10 +74,10 @@
>  # @description: Free-form description of the export, up to 4096 bytes.
>  #               (Since 5.0)
>  #
> -# @bitmap: Also export the dirty bitmap reachable from @device, so the
> -#          NBD client can use NBD_OPT_SET_META_CONTEXT with the
> -#          metadata context name "qemu:dirty-bitmap:NAME" to inspect the
> -#          bitmap. (since 4.0)
> +# @bitmaps: Also export each of the named dirty bitmaps reachable from
> +#           @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
> +#           the metadata context name "qemu:dirty-bitmap:BITMAP" to inspect
> +#           each bitmap. (since 5.2)

Given unsynchronised release cycles between qemu and management apps
it's not cool to deprecate an interface without having at least one
release where the replacement interface is already stable.

This means that any project wanting to stay up to date will either have
to use deprecated interfaces for at least one release and develop the
replacement only when there's a stable interface or hope that they don't
have to change the interfaces too often.

This specifically impacts libvirt as we have validators which notify us
that a deprecated interface is used and we want to stay in sync, so that
there's one less group of users to worry about at the point qemu will
want to delete the interface.

>  # @allocation-depth: Also export the allocation depth map for @device, so
>  #                    the NBD client can use NBD_OPT_SET_META_CONTEXT with
> @@ -88,7 +88,7 @@
>  ##
>  { 'struct': 'BlockExportOptionsNbd',
>    'data': { '*name': 'str', '*description': 'str',
> -            '*bitmap': 'str', '*allocation-depth': 'bool' } }
> +            '*bitmaps': ['str'], '*allocation-depth': 'bool' } }

This adds 'bitmaps' also to nbd-server-add, which should not happen. You
probably want to stop using 'base' for 'NbdServerAddOptions' and just
duplicate everything else.

>  # @NbdServerAddOptions:
> @@ -100,12 +100,18 @@
>  # @writable: Whether clients should be able to write to the device via the
>  #            NBD connection (default false).
>  #
> +# @bitmap: Also export a single dirty bitmap reachable from @device, so the
> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with the metadata
> +#          context name "qemu:dirty-bitmap:BITMAP" to inspect the bitmap
> +#          (since 4.0).  Mutually exclusive with @bitmaps, and newer
> +#          clients should use that instead.

This doesn't make sense, nbd-server-add never had @bitmaps. Also adding
features to a deprecated interface doesn't IMO make sense if you want to
motivate users switch to thne new one.

> +#
>  # Since: 5.0
>  ##
>  { 'struct': 'NbdServerAddOptions',
>    'base': 'BlockExportOptionsNbd',
>    'data': { 'device': 'str',
> -            '*writable': 'bool' } }
> +            '*writable': 'bool', '*bitmap': 'str' } }
> 
>  ##
>  # @nbd-server-add:


