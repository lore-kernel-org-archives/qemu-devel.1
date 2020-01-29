Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C16C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7522071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8voJMzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7522071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkpN-0005Vh-Am
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iwkoq-00056u-HB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iwkop-0001fY-Fv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:43:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44450
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iwkop-0001f1-Bp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580294614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAzRCvhgr8fg1gy3i4TrTyKkgZx6Gug+/CtFVTBhvjg=;
 b=K8voJMzqVdFIRupOURIL5KJwn53vfvvTSuxQzfOo+UqpukMqa/AoabjfTQMFVFSz4S60qh
 0O2uCvtkkpekcc/UX/UeLeVhlRqR3HYS1QcoTAnPAJnNJ1TtXz6yWVsJrp0+ShLbc9odlu
 7P7HS2dnhb7wwp7WsZSlySjZlr2FMQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-h3_tr0C0MMegblbX1R4SJg-1; Wed, 29 Jan 2020 05:43:29 -0500
X-MC-Unique: h3_tr0C0MMegblbX1R4SJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2895100550E;
 Wed, 29 Jan 2020 10:43:28 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38F255C1B5;
 Wed, 29 Jan 2020 10:43:28 +0000 (UTC)
Date: Wed, 29 Jan 2020 10:43:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH] docs: add virtiofsd(1) man page
Message-ID: <20200129104327.GB57189@stefanha-x1.localdomain>
References: <20200127162514.56784-1-stefanha@redhat.com>
 <539e9834-8b3f-5d7c-eb0c-ff2c19d44ff8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <539e9834-8b3f-5d7c-eb0c-ff2c19d44ff8@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 04:55:12PM +0000, Liam Merwick wrote:
> On 27/01/2020 16:25, Stefan Hajnoczi wrote:
> > Document the virtiofsd(1) program and its command-line options.  This
> > man page is a rST conversion of the original texi documentation that I
> > wrote.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Based-on: 20200124162606.8787-1-peter.maydell@linaro.org
> >            ("[PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-hel=
per: convert to rST")
> > ---
> >   MAINTAINERS                |   1 +
> >   Makefile                   |   8 ++-
> >   docs/interop/conf.py       |   5 +-
> >   docs/interop/index.rst     |   1 +
> >   docs/interop/virtiofsd.rst | 123 ++++++++++++++++++++++++++++++++++++=
+
> >   5 files changed, 136 insertions(+), 2 deletions(-)
> >   create mode 100644 docs/interop/virtiofsd.rst
> >=20
>=20
> [ ... deleted ...]
>=20
> > +
> > +Examples
> > +--------
> > +
> > +Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
> > +``/var/run/vm001-vhost-fs.sock``:
> > +
> > +::
> > +
> > +  host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o sour=
ce=3D/var/lib/fs/vm001
> > +  host# qemu-system-x86_64 \
> > +      -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> > +      -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> > +      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/s=
hm,share=3Don \
> > +      -numa node,memdev=3Dmem \
> > +      ...
> > +  guest# mount -t virtio_fs myfs /mnt
> >=20
>=20
> This should be 'mount -t virtiofs myfs /mnt' like on
> https://virtio-fs.gitlab.io/howto-qemu.html
>=20
> otherwise
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Will fix, thanks!

Stefan

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4xYc4ACgkQnKSrs4Gr
c8g0Ygf9H79b+1n1ey8ORwJmbVPshPqaE/JWn7rLFwsfIN2JMllf12IRaye23zVH
FUYzZ0x6MHlp7rKa2lfXEF22aczazCPYTrpUIzt3dTWCso2MXuIfYkUErbOxQVST
R8dZxefiP0V06ym4c2ny0z1MRIyWGxaBIar6G2kXGRO8qc4g1pn4oGOg9eMs+UJT
xG+WZcQX6ZK4pMSogNnrKjZqm9rPwRrJkhfieb8YGeORY7Esyk6Kt70tGHzckQV1
nLw8Kd4/LnlbPv8abzFc093e2C+mJ8X+mt1Z5unVPprjtTeRv88PaGMvzQbOSAKv
4FjsjXjYoNC/xJoqOctrtQYvqpqhFA==
=qu/y
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--


