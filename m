Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3236C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F1D2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F1D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvkT4-0006DH-Sx
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 11:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hvkSh-0005nE-2t
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hvkSg-0002lJ-6q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hvkSg-0002kP-0y
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 065793090FD0;
 Thu,  8 Aug 2019 15:36:17 +0000 (UTC)
Received: from localhost (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28F360BF4;
 Thu,  8 Aug 2019 15:36:12 +0000 (UTC)
Date: Thu, 8 Aug 2019 16:36:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190808153611.GB6547@stefanha-x1.localdomain>
References: <20190805031240.6024-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20190805031240.6024-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 15:36:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qtest: Rename qtest.c:qtest_init()
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 03:13:01AM +0000, Oleinik, Alexander wrote:
> Both the qtest client, libqtest.c, and server, qtest.c, used the same
> name for initialization functions which can cause confusion.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
> Thank you, Thomas Huth for the suggestion.
>=20
>  include/sysemu/qtest.h | 2 +-
>  qtest.c                | 3 +--
>  vl.c                   | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1MQWsACgkQnKSrs4Gr
c8hC3QgAmBZdgWQEDFlDNb6ROY76HqVDKZHN5Kk2D3fV3AFnptepGbrJ4IgCfJyx
4l7J2TvtePPaJMnBxuS7a11de2uh7j/oul2V00U67Mj2bXs7g9vH1gQzKim8xrMC
QikQNk4OIoGLt9xkM0kjQFc+deYTyAA178BqqkEkTxpNlQ1h39Eh3ohu2o/Fy0P8
7KQp7TKzSRFdFxNjGblpYmUqCefDJj0fdeIQxQotdjKDbN9tEkbDktvIbu8McXOL
5KCd3Mih3/8jpI8xJTnjdSxMLA2T+q/1cq4NmIt5pcSoEE9S8Fml3ugtay+P3vZz
FcFoXR+nioWcy90MVe13K2+MU0Twlg==
=eFFI
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

