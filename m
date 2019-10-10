Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCCC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9002206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9002206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbO3-0005vc-V4
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIb4M-0000oB-56
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIb4K-0008HW-NJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:13:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIb4K-0008HO-HG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:13:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76883306729E
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 16:13:35 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3587E5D713;
 Thu, 10 Oct 2019 16:13:34 +0000 (UTC)
Date: Thu, 10 Oct 2019 17:13:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] trace: avoid "is" with a literal Python 3.8 warnings
Message-ID: <20191010161333.GA5697@stefanha-x1.localdomain>
References: <20191010122154.10553-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20191010122154.10553-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 10 Oct 2019 16:13:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 01:21:54PM +0100, Stefan Hajnoczi wrote:
> The following statement produces a SyntaxWarning with Python 3.8:
>=20
>   if len(format) is 0:
>   scripts/tracetool/__init__.py:459: SyntaxWarning: "is" with a literal. =
Did you mean "=3D=3D"?
>=20
> Use the conventional len(x) =3D=3D 0 syntax instead.
>=20
> Reported-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2fWKwACgkQnKSrs4Gr
c8gj/ggAmimtbPwfsslaftWFGyeo7Wr2mrHxh8ECBqhTDiPAvrTEg701T2b/pc65
Ta8zYFX5mM5yqT4RVvbxtze5bIbCsgi+OnmKOBvnJ7EEz1CAygYxYELmUNC8tyvH
4P/7T1enBldJvnqBTTmfMlCs/OR/cl0OeBRhHb+Yt5xim9x1CvP/34V3odIeDiVI
ORZpiY+8zlJiPSTxkYC76fWv/sWRyvp0ceICXuT5V9UpA7ozpFGDVOpmUtt39Qac
kLlR80lUtqecqo4w2MLk+5zTBN6oU0gmI7nUCngTw+cidNUz39V8QF38WEj8yI2r
vXcq3njiETXZ2ZZgykrK8+9k29QIig==
=Lq/Q
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

