Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dNawP-0000f5-Pz
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dNawO-00006K-Ok
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:24:45 -0400
Date: Wed, 21 Jun 2017 09:24:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170621082434.GA16183@stefanha-x1.localdomain>
References: <20170619150002.3033-1-stefanha@redhat.com>
	<117743be-2351-7fe0-c777-c630bb850447@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <117743be-2351-7fe0-c777-c630bb850447@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Reda Sallahi <fullmanet@gmail.com>, qemu-block@nongnu.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 05:18:18PM +0200, Max Reitz wrote:
> On 2017-06-19 17:00, Stefan Hajnoczi wrote:
> > It's confusing when two different variables have the same name in one
> > function.
> >=20
> > Cc: Reda Sallahi <fullmanet@gmail.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-img.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/qemu-img.c b/qemu-img.c
> > index 0ad698d..c285c2f 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -4249,15 +4249,12 @@ static int img_dd(int argc, char **argv)
> >          case 'U':
> >              force_share =3D true;
> >              break;
> > -        case OPTION_OBJECT: {
> > -            QemuOpts *opts;
> > -            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> > -                                           optarg, true);
> > -            if (!opts) {
> > +        case OPTION_OBJECT:
> > +            if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, tr=
ue)) {
> >                  ret =3D -1;
> >                  goto out;
> >              }
> > -        }   break;
> > +            break;
> >          case OPTION_IMAGE_OPTS:
> >              image_opts =3D true;
> >              break;
>=20
> Hm, I basically reverted such a style in commit
> 3258b91141090b05edcaab8f1d1dd355ca91b49a. I find it confusing to use the
> same variable for two different things.

I don't follow how the commit you posted is related to this patch.  Did
you read the patch too quickly and think it uses the outer opts
variable?

This patch doesn't use a variable at all - there is no need for one.

Stefan

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZSi1BAAoJEJykq7OBq3PIFp4H/1gqryBVz/cMQ7A/zgw8V+9t
xO+i8lxkuZN03/hlPC0dsIm8zeRgPVi1vmOFoOKblzjyD4dvLtHzXSjWeryyfhUr
IsBbootqCWCxmzu2Qxn+7ZicopaeeLuMFFKPyAdP0yRQjqktiKA/SCyFwiUkW7uc
O3SFcyB6Ujbyb0YcqSSnXWE9ly0biVvm5cmY7OXKQHHunUxD7Tvlj1XaGThzoNJs
F2TZxq8VCIT2hKPks7DwRAzKOdShWzCHIJAT9lyE4c3QpjagBfDOYROnJczFhvDM
lfmOwBaMCdmCjiQbzw4OeB6mUnExNlrZcrPayp23LS6FEahp0tRUUP7xaVNIsSM=
=c2QY
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
