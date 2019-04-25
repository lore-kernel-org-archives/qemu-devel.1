Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2033C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83E6206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83E6206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfkZ-0005vM-Ow
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:53:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfjL-0005Kd-MR
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfjJ-00018K-5I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJfjH-00014I-Eu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 852A5C0495BB;
	Thu, 25 Apr 2019 14:52:00 +0000 (UTC)
Received: from localhost (ovpn-117-82.ams2.redhat.com [10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF921600C7;
	Thu, 25 Apr 2019 14:51:55 +0000 (UTC)
Date: Thu, 25 Apr 2019 15:51:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190425145154.GE17806@stefanha-x1.localdomain>
References: <20190425125650.28846-1-stefanha@redhat.com>
	<e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 25 Apr 2019 14:52:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] gitmodules: use qemu.org git mirrors
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425145154._Ae_seyz98qGoqhmjdxnwNTDwuJRVS_227xulV7En1k@z>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 03:14:29PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 4/25/19 2:56 PM, Stefan Hajnoczi wrote:
> > qemu.org hosts git repository mirrors of all submodules.  Update
> > .gitmodules to use the mirrors and not the upstream repositories.
> >=20
> > Mirroring upstream repositories ensures that QEMU continues to build
> > even when upstream repositories are deleted or temporarily offline.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Based-on: <20190424110041.8175-1-marcandre.lureau@redhat.com>
> >           "[PATCH v2 0/2] slirp: move slirp as git submodule project"
> >=20
> > Peter: Please apply Marc-Andr=E9's series.  I have set up the necessary
> > mirrors and this patch will fix up the libsirp URL as well as the
> > other URLs.
> >=20
> >  .gitmodules | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/.gitmodules b/.gitmodules
> > index aa77ce6f50..84b260031c 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -39,19 +39,19 @@
> >  	url =3D https://git.qemu.org/git/capstone.git
> >  [submodule "roms/seabios-hppa"]
> >  	path =3D roms/seabios-hppa
> > -	url =3D https://github.com/hdeller/seabios-hppa.git
> > +	url =3D https://git.qemu.org/git/seabios-hppa.git
> >  [submodule "roms/u-boot-sam460ex"]
> >  	path =3D roms/u-boot-sam460ex
> >  	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
> >  [submodule "tests/fp/berkeley-testfloat-3"]
> >  	path =3D tests/fp/berkeley-testfloat-3
> > -	url =3D https://github.com/cota/berkeley-testfloat-3
> > +	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
> >  [submodule "tests/fp/berkeley-softfloat-3"]
> >  	path =3D tests/fp/berkeley-softfloat-3
> > -	url =3D https://github.com/cota/berkeley-softfloat-3
> > +	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
> >  [submodule "roms/edk2"]
> >  	path =3D roms/edk2
> > -	url =3D https://github.com/tianocore/edk2.git
> > +	url =3D https://git.qemu.org/git/tianocore/edk2.git
>=20
> I'm getting:
>=20
> Entering 'roms/edk2'
> fatal: repository 'https://git.qemu.org/git/tianocore/edk2.git/' not found
>=20
> OK, got it, the correct URL is https://git.qemu.org/git/edk2.git
> (without 'tianocore')
>=20
> With the URL or the path locally updated:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Doh, I should have run "git submodule update --init" in addition to
=2E/configure && make.

Will fix in v2.

Stefan

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwcmKAAoJEJykq7OBq3PIcFQH/j+dBToCrhH863VaMKCvy7Zi
vkei3z9W51pH8cJoYhu3Cxfp9CUOUwlY847bc6owuZt19GXF/giohHZjsEga9Mfh
WZoAnpgps9GvY0b3al6aRYOEyaIsebXSw+fzpfEdN9QPAkRRu7JhT3u5XbW+rtAT
WMtqis8tHepbIvY+HpxRpf4rqKm8rFicvpgaBOEX+syKYSxR9orpbHjZAL3a8RLx
4yR1dc3kgF5q71OM6DCfhAihnaPNTcSzcZBumNReJmeE3HO4OPuZQoj3fWYC0UQM
r9R+RFUvIsa5Jc0w2TXv6QSecZwvyliZboR2mohlawy3s15SgwN4Y9CJQN2YnMA=
=4jgF
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

