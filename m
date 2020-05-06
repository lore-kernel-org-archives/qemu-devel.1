Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740EC47259
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE282073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0aHeDrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE282073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJfx-0003Lm-5r
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWJec-0002bv-4V
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:00:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWJea-0007D2-Q8
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588769999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aWSSnXNE3rbu8pT910WyADAnZZcDAU+LL7/p/B6q9U=;
 b=F0aHeDrRMiL6Ebx1jll9XH20v14N4fmrHFqOWBziTst8p4t35iUoy2Yqu2e1V1WTRb0qd8
 vTNKRRjNUvIBLzkzk9VChdlM4VoCVxT5H38g6yrfLNu65BJb7F8mEwUACOOED6y68ma1lf
 0EEZhfHuU9R+zGYw4WooCZ5db8qW33k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-c52dA4seMTefVNGxvankew-1; Wed, 06 May 2020 08:59:55 -0400
X-MC-Unique: c52dA4seMTefVNGxvankew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FFF189952F;
 Wed,  6 May 2020 12:59:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA676109F;
 Wed,  6 May 2020 12:59:53 +0000 (UTC)
Date: Wed, 6 May 2020 14:59:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 13/33] block: Add child_of_bds
Message-ID: <20200506125951.GD6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-14-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-14-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> Any current user of child_file, child_format, and child_backing can and
> should use this generic BdrvChildClass instead, as it can handle all of
> these cases.  However, to be able to do so, the users must pass the
> appropriate BdrvChildRole when the child is created/attached.  (The
> following commits will take care of that.)
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

>  block.c                   | 27 +++++++++++++++++++++++++++
>  include/block/block_int.h |  1 +
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 0f24546863..1d33f58ff8 100644
> --- a/block.c
> +++ b/block.c
> @@ -1094,6 +1094,33 @@ static void bdrv_inherited_options(BdrvChildRole r=
ole, bool parent_is_format,
>      *child_flags =3D flags;
>  }
> =20
> +static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *=
base,
> +                                        const char *filename, Error **er=
rp);

Actually, I should have saved the comment on the previous patch for this
one. The forward declaration could easily be avoided by moving
child_of_bds down to after bdrv_backing_update_filename().

Kevin


