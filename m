Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A19C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000B12073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvdsyfC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000B12073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icaZj-0000Xt-4R
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icaYG-0008T6-CJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icaYC-00060f-Tb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:43:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icaYB-0005sc-MM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575488582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJbHtRBQFV+tBr9hYrrFzU9OZwFAdSMI9BK7b8RI5q4=;
 b=hvdsyfC82wWHkE0Puyc4G+ogwBcLbVPN+LTHSfWb+r2mwWr8rKUXNXVztLYFc157A9tfRP
 Vw/NYYmfl3RbDswnzdNwIo55lPDnkwfHe3uFy9GREOoY5V87CmZMedcySNoyCSKMtcmZU0
 DwKG7DvBbuxkNDFpEEjBjda9C+tVBPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-0SEdXnCiOv2pySvYXnYQcw-1; Wed, 04 Dec 2019 14:42:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB02593A0
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:42:58 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A34C95C1B5;
 Wed,  4 Dec 2019 19:42:52 +0000 (UTC)
Date: Wed, 4 Dec 2019 19:42:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 1/5] virtiofsd: Get rid of unused fields in fv_QueueInfo
Message-ID: <20191204194250.GN3325@work-vm>
References: <20191204190836.31324-1-vgoyal@redhat.com>
 <20191204190836.31324-2-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204190836.31324-2-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0SEdXnCiOv2pySvYXnYQcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs@redhat.com, mszeredi@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> There are some unused fields in "struct fv_QueueInfo". Get rid of these f=
ields.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  contrib/virtiofsd/fuse_virtio.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
> index 31c8542b6c..2a9cd60a01 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -50,12 +50,6 @@ struct fv_QueueInfo {
>      int qidx;
>      int kick_fd;
>      int kill_fd; /* For killing the thread */
> -
> -    /* The element for the command currently being processed */
> -    VuVirtqElement *qe;
> -    /* If any of the qe vec elements (towards vmm) are unmappable */
> -    unsigned int elem_bad_in;
> -    bool reply_sent;

Yep, those last two got moved into FVRequest as part of the thread pool
stuff.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  };
> =20
>  /* A FUSE request */
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


