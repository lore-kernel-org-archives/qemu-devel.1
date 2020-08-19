Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7FDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9CE207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUA/cRIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9CE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8U7L-0007UL-UY
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8U6Z-0006ua-UA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:50:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8U6X-0003Wk-Op
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597866636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IjIaVgy0CerJ+noFPw3SnZh84TBydK3nBoCQvXR5L4o=;
 b=gUA/cRIeaJ9GL/kcuAkwZ1z2ZzoKLQ+hp8//HFhT22JkoKrnbZt+FaPd4ijBQZ9OnaDuIl
 kCKTtiJ3xft5cDGDGzNpo5vEdh/z0W1f6TDQDHugmIa9DkS+IuujkRmcxeFdEoVfVT/59e
 87j8CptTWlHAGDzYEbrJ5BFSongb5Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-EJvi6G1VO3O90vGd5UCJzA-1; Wed, 19 Aug 2020 15:50:21 -0400
X-MC-Unique: EJvi6G1VO3O90vGd5UCJzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7577A807330;
 Wed, 19 Aug 2020 19:50:20 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1164E7DFFF;
 Wed, 19 Aug 2020 19:50:20 +0000 (UTC)
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b2958a79-f7c6-7bc2-8895-50924f15afd9@redhat.com>
Date: Wed, 19 Aug 2020 14:50:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-8-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cc: Peter Krempa

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> nbd-server-add tries to be convenient and adds two questionable
> features that we don't want to share in block-export-add, even for NBD
> exports:
> 
> 1. When requesting a writable export of a read-only device, the export
>     is silently downgraded to read-only. This should be an error in the
>     context of block-export-add.

I'd be happy for this to be an error even with nbd-export-add; I don't 
think it would harm any of libvirt's existing usage (either for storage 
migration, or for incremental backups).

Side note: In the past, I had a proposal to enhance the NBD Protocol to 
allow a client to advertise to the server its intent on being a 
read-only or read-write client.  Not relevant to this patch, but this 
part of the commit message reminds me that I should revisit that topic 
(Rich and I recently hit another case in nbdkit where such an extension 
would be nice, when it comes to using NBD's multi-conn for better 
performance on a read-only connection, but only if the server knows the 
client intends to be read-only)

> 
> 2. When using a BlockBackend name, unplugging the device from the guest
>     will automatically stop the NBD server, too. This may sometimes be
>     what you want, but it could also be very surprising. Let's keep
>     things explicit with block-export-add. If the user wants to stop the
>     export, they should tell us so.

Here, keeping the nbd command different from the block-export command 
seems tolerable.  On the other hand, I wonder if Peter needs to change 
anything in libvirt's incremental backup code to handle this sudden 
disappearance of an NBD device during a disk hot-unplug (that is, either 
the presence of an ongoing pull-mode backup should block disk unplug, or 
libvirt needs a way to guarantee that an ongoing backup NBD device 
remains in spite of subsequent disk actions on the guest).  Depending on 
libvirt's needs, we may want to revisit the nbd command to have the same 
policy as block-export-add, plus an introspectible feature notation.

> 
> Move these things into the nbd-server-add QMP command handler so that
> they apply only there.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/nbd.h   |  3 ++-

> +void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> +{
> +    blk_exp_add(export, errp);
>   }
>   
>   void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
>   {
> -    BlockExportOptions export = {
> +    BlockExport *export;
> +    BlockDriverState *bs;
> +    BlockBackend *on_eject_blk;
> +
> +    BlockExportOptions export_opts = {
>           .type = BLOCK_EXPORT_TYPE_NBD,
>           .u.nbd = *arg,
>       };
> -    qmp_block_export_add(&export, errp);
> +
> +    /*
> +     * nbd-server-add doesn't complain when a read-only device should be
> +     * exported as writable, but simply downgrades it. This is an error with
> +     * block-export-add.

I'd be happy with either marking this deprecated now (and fixing it in 
two releases), or declaring it a bug in nbd-server-add now (and fixing 
it outright).

> +     */
> +    bs = bdrv_lookup_bs(arg->device, arg->device, NULL);
> +    if (bs && bdrv_is_read_only(bs)) {
> +        arg->writable = false;
> +    }
> +
> +    export = blk_exp_add(&export_opts, errp);
> +    if (!export) {
> +        return;
> +    }
> +
> +    /*
> +     * nbd-server-add removes the export when the named BlockBackend used for
> +     * @device goes away.
> +     */
> +    on_eject_blk = blk_by_name(arg->device);
> +    if (on_eject_blk) {
> +        nbd_export_set_on_eject_blk(export, on_eject_blk);
> +    }

Wait - is the magic export removal tied only to exporting a drive name, 
and not a node name?  So as long as libvirt is using only node names 
whwen adding exports, a drive being unplugged won't interfere?

Overall, the change makes sense to me, although I'd love to see if we 
could go further on the writable vs. read-only issue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


