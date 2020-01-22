Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7155C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E7721569
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq8rXoIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E7721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGMr-00017Z-6o
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuGLj-0000Ts-Jp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuGLi-00019P-HU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuGLi-000195-Dr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579700834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN7hYgu1CPUabf+h70M5VCu9XbbrZVni8IAHeigcBtw=;
 b=iq8rXoIWAd3HG/eblEEPg6uOWHIb20TBxuIt7xRqlhZX6nnhHSjtEtAubJPk0CSrRXoXpa
 3baWKHLjvbqMZxabmCKhhDyT16Mn5pTD7lUTbzMLmIaBHzg705v3MJ5z9vRh/CX7SNXFy5
 NKXCMO6LYkdTLOc0Jnf+a/o3R/PNPms=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0DLOw3V9MdqhDrezpNYG5Q-1; Wed, 22 Jan 2020 08:47:12 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2111984wma.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 05:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B4fyovY8zUfSnEVUFJYz3Ap51CEoJF6uPieMbApppWI=;
 b=cS9VkCwY5weIwpF06yPmDcWMIyL2LC/wB4OF/8Smh63HiONLFRug1kV/smvOOAx/VA
 fSzKAlexii0E9dAcNbj7XmvIQU7dBZ8q0JpzeCxK/gevysL2AeqsgmsHE/f6rlOQdsfh
 D2wxdrAdgEyfkeF+kOzfAB8UUizQ0S+sLD7zgXvyc9pbqaY2OkA5vhND3bS0Rykr9+Fi
 8U6MEWU9Tx8cUDa7yBFf/QvWglF9AzENhbZJ7a0Rmy1tRezfL/nKvJhLfK/aOx9w6Cfn
 xbuhZFT8EhFryPJ9XJqjwXwKbE+BKlt0aKfbsF4DyMBOGx+yt5u72qdsoreQyTNi5Qsh
 GR3w==
X-Gm-Message-State: APjAAAW1e8HxutWG3IbWzZvo7gfaEZb4kWKDPV2qBSJkRbH21zGhZzOp
 QSyuOc1MkMXd2/KeJ46YkSPbdyC1eV62xeHfiW6gQmpA7gxDKxMCdVGUv29SCR1fZkrrRzUWU5c
 dPBDXCuU1bZofWRM=
X-Received: by 2002:a5d:6349:: with SMTP id b9mr11341888wrw.346.1579700831103; 
 Wed, 22 Jan 2020 05:47:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfr1yFwnWkV15lkspSxYjRLTSWOhdwFyRupNuPws+oPHSGnqWzTkhUxf4ln7+Wzkkn7rLzzQ==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr11341861wrw.346.1579700830845; 
 Wed, 22 Jan 2020 05:47:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 f207sm4869335wme.9.2020.01.22.05.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 05:47:09 -0800 (PST)
Date: Wed, 22 Jan 2020 08:47:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH] vhost: coding style fix
Message-ID: <20200122084644-mutt-send-email-mst@kernel.org>
References: <20200122080840.592054-1-mst@redhat.com>
 <2b0670f2-f14e-b4f6-ad01-d1b2b28bdf06@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2b0670f2-f14e-b4f6-ad01-d1b2b28bdf06@redhat.com>
X-MC-Unique: 0DLOw3V9MdqhDrezpNYG5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 11:06:53AM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 1/22/20 6:08 AM, Michael S. Tsirkin wrote:
> > Drop a trailing whitespace. Make line shorter.
>=20
>=20
> hmmm... wondering why Patchew didn't catch that. Any idea?
>=20
> - Wainer

It did.

> >=20
> > Fixes: 76525114736e8 ("vhost: Only align sections for vhost-user")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/virtio/vhost.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 25fd469179..9edfadc81d 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -551,7 +551,7 @@ static void vhost_region_add_section(struct vhost_d=
ev *dev,
> >       trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_si=
ze,
> >                                      mrs_host);
> > -    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {
> > +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {
> >           /* Round the section to it's page size */
> >           /* First align the start down to a page boundary */
> >           size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
> > @@ -566,8 +566,8 @@ static void vhost_region_add_section(struct vhost_d=
ev *dev,
> >           if (alignage) {
> >               mrs_size +=3D mrs_page - alignage;
> >           }
> > -        trace_vhost_region_add_section_aligned(section->mr->name, mrs_=
gpa, mrs_size,
> > -                                               mrs_host);
> > +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_=
gpa,
> > +                                               mrs_size, mrs_host);
> >       }
> >       if (dev->n_tmp_sections) {


