Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3401BC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008A1206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFCRSQ6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008A1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLYi-0000L2-Vp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inLXt-0008HJ-EC
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inLXq-000612-L2
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:55:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inLXq-0005qr-Db
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578052509;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoWKlntPa7RNn4Xt6ssTu5EmP33qXEqgPAsajUGNVZs=;
 b=XFCRSQ6PRskKNEDkWHyF/ucthvQhe2YlFzzljesr8FqboLom3ZpGEVzHeghDvIXfGRnfVd
 uQafc/QjUbaFVFv/cV9Gc5X3ZpRcD3v3v0MbICo+JSOlEwAHJpjaFD/NfwqfB4wYmk/arY
 mPNVQH3HBsUb59w2fPvlofLSJ6eSwV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240--Mit6gdNOKCNmLPneknl3w-1; Fri, 03 Jan 2020 06:55:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E14718A8C81
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 11:55:05 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 414EA6609E;
 Fri,  3 Jan 2020 11:55:01 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:54:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 001/104] virtiofsd: Pull in upstream headers
Message-ID: <20200103115458.GG2753983@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-2-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -Mit6gdNOKCNmLPneknl3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:21PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Pull in headers fromlibfuse's upstream fuse-3.8.0
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/fuse.h                | 1275 +++++++++++++++
>  tools/virtiofsd/fuse_common.h         |  823 ++++++++++
>  tools/virtiofsd/fuse_i.h              |  139 ++
>  tools/virtiofsd/fuse_log.h            |   82 +
>  tools/virtiofsd/fuse_lowlevel.h       | 2089 +++++++++++++++++++++++++
>  tools/virtiofsd/fuse_misc.h           |   59 +
>  tools/virtiofsd/fuse_opt.h            |  271 ++++
>  tools/virtiofsd/passthrough_helpers.h |   76 +
>  8 files changed, 4814 insertions(+)
>  create mode 100644 tools/virtiofsd/fuse.h
>  create mode 100644 tools/virtiofsd/fuse_common.h
>  create mode 100644 tools/virtiofsd/fuse_i.h
>  create mode 100644 tools/virtiofsd/fuse_log.h
>  create mode 100644 tools/virtiofsd/fuse_lowlevel.h
>  create mode 100644 tools/virtiofsd/fuse_misc.h
>  create mode 100644 tools/virtiofsd/fuse_opt.h
>  create mode 100644 tools/virtiofsd/passthrough_helpers.h

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


