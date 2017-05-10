Received: from eggs.gnu.org ([2001:4830:134:3::10]:34605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8Udo-0008EB-L6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8Udl-0002FE-Gs
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:39:08 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d8Udl-0002F9-B8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:39:05 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so149681qte.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 09:39:05 -0700 (PDT)
Date: Wed, 10 May 2017 12:39:02 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170510163902.GG19962@stefanha-x1.localdomain>
References: <20170510111535.11190-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <20170510111535.11190-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] docs: document support lifetime and
 deprecation policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 12:15:35PM +0100, Daniel P. Berrange wrote:
> The deprecation of features in QEMU is totally adhoc currently,
> with no way for the user to get a list of what is deprecated
> in each release. There is also no guidance on the duration of
> support for features such as versioned machine types, which
> have a finite useful life.
>=20
> This adds two new appendix entries to the main QEMU documentation.
> The first appendix lists items which have finite lifecycles,
> and sets out the policy that is used for deprecating & removing
> features which have indefinite lifecycles. The second appendix
> provides a list of all[1] currently deprecated features, along
> with the release they were deprecated in.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>=20
> [1] This is a lie. I've only listed one deprecated feature. Once
>     we agree on the general concept, we can fill out the doc
>     with the rest of the currently deprecated features.
> ---
>  qemu-doc.texi | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Peter maydell is away in May.  He usually participates in discussions on
this topic.  Unless there are urgent issues I suggest we wait until June
to commit QEMU to new policies.

> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 794ab4a..899808b 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -36,6 +36,8 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU User space emulator::
>  * Implementation notes::
> +* Support lifetime::
> +* Deprecations::
>  * License::
>  * Index::
>  @end menu
> @@ -2996,6 +2998,51 @@ Run the emulation in single step mode.
> =20
>  @include qemu-tech.texi
> =20
> +@node Support lifetime
> +@appendix Support lifetime
> +
> +Features provided by QEMU are subject to varying support lifetimes.
> +
> +In general features are intended to be supported indefinitely once
> +introduced. In the event that a feature needs to be removed, there
> +will be some period in which it will be marked as deprecated before
> +eventual removal. All deprecated features will be listed in the
> +``Deprecations'' appendix of this document. They may also generate
> +a warning if used when QEMU starts up/
> +
> +Certain features will have an inherently finite lifetime, and thus
> +will be removed on a fixed schedule.
> +
> +@node Machine types
> +@section Machine types
> +
> +For architectures which aim to support live migration compatibility
> +across releases, each release will introduce a new versioned machine
> +type. For example, the 2.8.0 release introduced machine types
> +``pc-i440fx-2.8'' and ``pc-q35-2.8' 'for the x86_64/i686 architectures.
> +
> +To allow live migration of a guest running on a 2.8.0 release to a
> +2.9.0, the QEMU 2.9.0 version must support the ``pc-i440fx-2.8'' and
> +``pc-q35-2.8''.  To allow users live migrating VMs to skip multiple
> +intermediate releases when upgrading, new releases of QEMU will
> +support machine types from many previous versions.
> +
> +The supported lifetime for machine types is 12 releases, which is
> +equivalent to 4 years worth of previous QEMU releases.
> +
> +@node Deprecations
> +@appendix Deprecations
> +
> +The following is a list of features which have been marked as deprecated,
> +pending removal in a future list:
> +
> +@section -drive boot=3Don|off (since v1.3.0)
> +Since release 1.3.0, the ``boot=3Don|off'' parameter to ``-drive''
> +is no longer honoured. It is currently ignored, but a future verson
> +will reject this parameter with an error. Applications should use
> +the ``bootindex=3DN'' parameter to set an absolute ordering between
> +devices instead.
> +
>  @node License
>  @appendix License
> =20
> --=20
> 2.9.3
>=20
>=20

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZE0ImAAoJEJykq7OBq3PIa6UH+gJ1ouDfDALJAazHPE330Ax+
0K5aXZ3oB7+gPy0O14Cm2b0aHvBIC61/ZRKnxR8Pi2XGgMIj954vx87DTbcMN36P
uIt0q2qHHFewjdENzaUEXBzgiQdesD+4y+xHiBLAzu7Ek2dPamw6v7J2WtRb+wji
XYImg40LAO3YFY/xxfsfLgZrcFVuzfNofVJkRD8Hjgz4a9sIOTXsbKIqpzDGVVSk
oTYXy81ztxNoofXsB1l/UUrZdgD6uTKdH0rCdTYsfl6XYAjUVJWmaZefKQUAvIMq
8kNhGLbEzJ7NxAcdhP4LO5JoscXbzeEviBvbpEn4SOY6UBur3P0S4O+Yxop+SJw=
=bOm8
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
