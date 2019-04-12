Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907E92084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907E92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvhV-0004OV-Jb
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:54:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvfw-0003PI-ER
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvfv-0005so-Ao
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEvfv-0005sC-1Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9342E308621C;
	Fri, 12 Apr 2019 12:52:57 +0000 (UTC)
Received: from vader (ovpn-117-148.ams2.redhat.com [10.36.117.148])
	by smtp.corp.redhat.com (Postfix) with SMTP id DCC9A19C65;
	Fri, 12 Apr 2019 12:52:53 +0000 (UTC)
Date: Fri, 12 Apr 2019 14:52:52 +0200
From: Eduardo Otubo <otubo@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190412125252.GB13589@vader>
References: <20190412113730.28828-1-otubo@redhat.com>
	<20190412113730.28828-2-otubo@redhat.com>
	<20190412114307.GK25308@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20190412114307.GK25308@redhat.com>
User-Agent: Mutt/1.8.3+47 (5f034395e53d) (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 12:52:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
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
Cc: peter.maydell@linaro.org, deller@gmx.de, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412125252.91PEzb57CTNSBzAJ2yUZCHCDxPMi_s5OxflKfFVg53I@z>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/04/2019 - 12:43:07, Daniel P. Berrange wrote:
> On Fri, Apr 12, 2019 at 01:37:30PM +0200, Eduardo Otubo wrote:
> > From: Helge Deller <deller@gmx.de>
> >=20
> > All major distributions do support libseccomp version >=3D 2.3.0, so th=
ere
> > is no need to special-case on various architectures any longer.
> >=20
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Eduardo Otubo <otubo@redhat.com>
>=20
> When sending pull requests the subsystem maintainer *must*
> add their Signed-off-by as this is what has legal meaning
> with respect to the developer certificate of origin.
>=20
> Acked-by is something that is used to give a different
> subsystem maintainer permission to merge a patch that
> would normally be your responsibility.
>=20
>=20

I think this issue was already raised by Peter on my last pull-request. My
appologies, I fixed the last pull request my didn't fix my script :/

Will send again after the release.
Thanks for pointing that out.

--=20
Eduardo Otubo

Red Hat GmbH,http://www.de.redhat.com/, Sitz: Grasbrunn,
Handelsregister: Amtsgericht M=C3=BCnchen, HRB 153243,
Gesch=C3=A4ftsf=C3=BChrer: Charles Cachera, Michael O'Neill, Tom Savage, Er=
ic Shander

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcsIokAAoJEN8y58Dw//mid+IH/1Z2Fd6DOW3qBCX1vFpyPyUR
iZH+5GsdbeIQ7CT36nMQStzBDSVtFk1wN03j4hEl4fuIjCQ62rc9OS4q4eeFZl1y
cye3tJcnKWwzvfyKrq5lrG1wBYkF7JEb5t+PGv7GyMncP+fMX4J9famMv8h/q+v4
gOsp+sC2pOCG1gULnu1GdXmSddLwOVGQO3aDoOy5QdpjKqVF2o3Q+NCrc0fSQrSZ
o4pUZstNLPRBNVuEzf69ioS4C9OyfwtBEs+X0OfKWHGg8uSvXznsatAGNwsRWvcb
N+VBZ2ZnuOyB63U6qF+cyPqtrRVDMoXY2OIRhultf1JRdJZgcIgMtg8Wk/v+Pgc=
=rUoV
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

