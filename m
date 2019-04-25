Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE7C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C84206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C84206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJbFP-0007oT-ST
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 06:04:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJbE5-0006zR-Cg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJbE3-0007FH-VE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJbE3-0007Ej-OQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E251881F13;
	Thu, 25 Apr 2019 10:03:30 +0000 (UTC)
Received: from localhost (ovpn-117-214.ams2.redhat.com [10.36.117.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C75A4648BC;
	Thu, 25 Apr 2019 10:03:27 +0000 (UTC)
Date: Thu, 25 Apr 2019 11:03:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190425100326.GF30231@stefanha-x1.localdomain>
References: <20190424110041.8175-1-marcandre.lureau@redhat.com>
	<20190424110041.8175-3-marcandre.lureau@redhat.com>
	<CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 25 Apr 2019 10:03:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] build-sys: move slirp as git
 submodule project
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
Cc: Jeff Cody <codyprime@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425100326.rL2gjw65zuZosgliSIBoqC8iEG4z-DyiQ9op2egLKpI@z>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 01:14:57PM +0100, Peter Maydell wrote:
> On Wed, 24 Apr 2019 at 12:13, Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The slirp project is now hosted on freedesktop at:
> > https://gitlab.freedesktop.org/slirp.
> >
> > The libslirp source was extracted from qemu/slirp filtered through
> > clang-format (available in project tree). The qemu slirp directory can
> > be swapped by a git submodule.
> >
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -52,3 +52,6 @@
> >  [submodule "roms/edk2"]
> >         path =3D roms/edk2
> >         url =3D https://github.com/tianocore/edk2.git
> > +[submodule "slirp"]
> > +       path =3D slirp
> > +       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
>=20
> We should prefer to set up a mirror of the git repo
> on git.qemu.org and use that, rather than a remote repo.
>=20
> We also need to do that for the berkeley softfloat
> and edk2 repos, I notice.
>=20
> Stefan or Jeff, could one of you set that up, please?

The mirrors are now set up:

  https://git.qemu.org/

I will send a .gitmodules patch that switches over to our mirrors.  I
will also include this libslirp submodule patch.

Stefan

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwYXuAAoJEJykq7OBq3PIZAMH/RP4VNIpHJFHGYNYbSHltvAO
HaVD5p6kMVSsYKTTvT1gESuy8B9RhEUK1gw3lKm/1ANXT/VuXq/qA2Ffvg9lSBcW
HDFox1Hj0BBJDZaMInh2HdzfnDRUPu1HAlgD0GCiIe8JpOETiDZk3aVRXBFu3uWq
L2hxmBXlAo9DdAXDeG+HaD37Nl/YuHkwrCQbASg9+IOcMtCyqFUzfFcuAevE3kE6
aGFstk2cTqq7e2OSl/W3PmYRDwp9grjh1IMC8XjU9AT01AY4qtiZBmG36LUqgFji
of5djH15euLghNFNEZZOMtpHDpX3i9UNVAcljeRN5VJq3YPKFrHf98p1ZtThIk0=
=korS
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

