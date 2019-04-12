Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0EE2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0EE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvjQ-0005s9-Tg
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:56:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvgU-0003qQ-Tp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvgT-00065G-Ec
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEvgS-00064T-NX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8100F3001AC2;
	Fri, 12 Apr 2019 12:53:26 +0000 (UTC)
Received: from vader (ovpn-117-148.ams2.redhat.com [10.36.117.148])
	by smtp.corp.redhat.com (Postfix) with SMTP id DC3AA5D9CD;
	Fri, 12 Apr 2019 12:53:22 +0000 (UTC)
Date: Fri, 12 Apr 2019 14:53:21 +0200
From: Eduardo Otubo <otubo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190412125321.GC13589@vader>
References: <20190412113730.28828-1-otubo@redhat.com>
	<CAFEAcA9k=rnQtJXsQ7D4EM6HeSnpJEyBHMTRp4SFb0_G7r+7uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9k=rnQtJXsQ7D4EM6HeSnpJEyBHMTRp4SFb0_G7r+7uA@mail.gmail.com>
User-Agent: Mutt/1.8.3+47 (5f034395e53d) (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 12:53:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/1] seccomp branch queue
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Helge Deller <deller@gmx.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412125321.4d2FkO7S3S1b1NfQJU7v6cBNpjDVj8F5-aaXnIIergg@z>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/04/2019 - 12:52:48, Peter Maydell wrote:
> On Fri, 12 Apr 2019 at 12:37, Eduardo Otubo <otubo@redhat.com> wrote:
> >
> > The following changes since commit 532cc6da74ec25b5ba6893b5757c977d5458=
2949:
> >
> >   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/otubo/qemu.git tags/pull-seccomp-20190412
> >
> > for you to fetch changes up to ee352b53b3e49ba9621149f9de7279a5cadd606c:
> >
> >   configure: Relax check for libseccomp (2019-04-12 13:30:40 +0200)
> >
> > ----------------------------------------------------------------
> > pull-seccomp-20190412
> >
> > ----------------------------------------------------------------
> > Helge Deller (1):
> >       configure: Relax check for libseccomp
>=20
> Is this really release critical? If you're sending pull
> requests for rc3/rc4 it is extremely helpful if you can
> give the justification for why they need to go into this
> release. (As it happens we're going to need an rc4, but
> I want to keep the set of changes in it to a minimum.)
>=20

This is not critical. I'll send again after the current release.

--=20
Eduardo Otubo

Red Hat GmbH,http://www.de.redhat.com/, Sitz: Grasbrunn,
Handelsregister: Amtsgericht M=C3=BCnchen, HRB 153243,
Gesch=C3=A4ftsf=C3=BChrer: Charles Cachera, Michael O'Neill, Tom Savage, Er=
ic Shander

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcsIpBAAoJEN8y58Dw//mi+0sH/3TOgNWOCj3i1JbHytrWacf1
Dk98rm/BMr//33tsKswdnQNMgRZZgkAb5HS620SpenbG3sBmUqZFq8j5Fnt+MSWg
9GgmyXNnhoEO//5XP8lmtrtRK6ePQmVsj+6qGaaAHZv6naqMo9mQfu1v4/t2niW1
f8wmeCpYrI8p4ZsaQ/xtXuKJXUa/Wh9/g0y5XphbY46v9WGVC7xx924wjIAXMwrY
tPJUps1/DBGA+S6BB59TiLEQWuPm77cPvq2sHhBRZSfopBilqqmIwOpHFfywEqhh
Cjll2h2czSr0LPBmkOKJHRpju8i0ArdIxt6TdbwfgzW78LuNl3XPexVk/URPnXM=
=A+0+
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--

