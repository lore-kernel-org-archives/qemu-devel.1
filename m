Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E693120645
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E693120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsht-0006UL-0Y
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:07:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hLsh6-0005UH-KM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hLsh3-0007KZ-K6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hLsh3-0007F2-Dd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE02C83F3B;
	Wed,  1 May 2019 17:06:51 +0000 (UTC)
Received: from localhost (ovpn-116-250.ams2.redhat.com [10.36.116.250])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0994A12A47;
	Wed,  1 May 2019 17:06:48 +0000 (UTC)
Date: Wed, 1 May 2019 13:06:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190501170647.GC22391@stefanha-x1.localdomain>
References: <20190425145420.8888-1-stefanha@redhat.com>
	<CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 01 May 2019 17:06:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501170647.Qt47buOP6-zyle4gkXQxT1Yh8YXTRVIVFfJDxitikDc@z>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 04:53:08PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Apr 25, 2019 at 4:54 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > qemu.org hosts git repository mirrors of all submodules.  Update
> > .gitmodules to use the mirrors and not the upstream repositories.
> >
> > Mirroring upstream repositories ensures that QEMU continues to build
> > even when upstream repositories are deleted or temporarily offline.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Stefan, do you prepare a pullreq?

This patch isn't within the scope of my block or tracing trees.

Perhaps Peter is willing to apply it?

Stefan

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJ0icACgkQnKSrs4Gr
c8gQUgf+PiHaaTgD3rkcy0RfcaB4FGMcngIVCSK2otQZF5eDd+MFIsPQ9bo5RVKh
mXb7YrPSLWsUjyq+cGltg4P/XgZ5UU6EKnkKJHYFrjyi+3R6BkQIkhDU/0c99db0
Xbltv9HxjnkKIwq1v52bXTbCtVPyltumIlEqj+QntzdDZAsi0T5x7dWd/t7M/Uq4
hzOjXgAtvU3MB8XbgsCp3ZvsrWq+BSJmf2EVmn30HWYJ7aAV2OOP765xETzJQvyU
jf3Q2ss+YuX6vgu1bxPla7tRaianAo3ahl8AB9zXUufrZvxAZLzjBi08sRN+sTmf
u52O09N5rdMa4Ax2MYxsNbdURZVuSg==
=Galr
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

