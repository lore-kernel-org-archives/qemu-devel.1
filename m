Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE96C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB07521835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQJPzuIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB07521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHC1-000513-1o
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1idFxM-0004PQ-3d
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1idFxK-00059T-RK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:55:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1idFxK-000585-Md
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575647746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqDLsg1VTf1Sx+WRIV8a1Em2YJc0K886tdHs4QW/uYA=;
 b=EQJPzuIRJLNfayIBsb03V332kS6KlEZz3M8Q09xSBw+i8NWyhTx/A+tS3/WyiINyiN24SQ
 NKis20GqyA9jBY/61KNZzZDctSeHWflrPDU8zHyPVd73fZiBq9/jvEDKQfM0wvKW6Rc07/
 9e9mPzXP368YIyl47+o86UzvcXzat/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-rw4bLbcyOL2NAQpE-a_K5A-1; Fri, 06 Dec 2019 10:55:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4D5800D41
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 15:55:43 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 739AE6B8F2;
 Fri,  6 Dec 2019 15:55:40 +0000 (UTC)
Date: Fri, 6 Dec 2019 15:55:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v2 1/5] virtiofsd: Get rid of unused fields
 in fv_QueueInfo
Message-ID: <20191206155538.GH2878@work-vm>
References: <20191204190836.31324-1-vgoyal@redhat.com>
 <20191204190836.31324-2-vgoyal@redhat.com>
 <20191204194250.GN3325@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191204194250.GN3325@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: rw4bLbcyOL2NAQpE-a_K5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: virtio-fs@redhat.com, mszeredi@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > There are some unused fields in "struct fv_QueueInfo". Get rid of these=
 fields.
> >=20
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  contrib/virtiofsd/fuse_virtio.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >=20
> > diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_v=
irtio.c
> > index 31c8542b6c..2a9cd60a01 100644
> > --- a/contrib/virtiofsd/fuse_virtio.c
> > +++ b/contrib/virtiofsd/fuse_virtio.c
> > @@ -50,12 +50,6 @@ struct fv_QueueInfo {
> >      int qidx;
> >      int kick_fd;
> >      int kill_fd; /* For killing the thread */
> > -
> > -    /* The element for the command currently being processed */
> > -    VuVirtqElement *qe;
> > -    /* If any of the qe vec elements (towards vmm) are unmappable */
> > -    unsigned int elem_bad_in;
> > -    bool reply_sent;
>=20
> Yep, those last two got moved into FVRequest as part of the thread pool
> stuff.
>=20
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I've merged that 1/5 into my world.

> >  };
> > =20
> >  /* A FUSE request */
> > --=20
> > 2.20.1
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


