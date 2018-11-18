Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gOV00-00062b-Co
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 16:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gOUo1-0007LL-I6
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 16:40:40 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:40572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dfaggioli@suse.com>) id 1gOUo0-0006qT-QA
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 16:40:37 -0500
Message-ID: <177817734b4def66a3a0641ad2fba1ec9a4092cb.camel@suse.com>
From: Dario Faggioli <dfaggioli@suse.com>
Date: Sun, 18 Nov 2018 22:40:34 +0100
In-Reply-To: <87k1lai2vo.fsf@linaro.org>
References: <154238824601.3534.13597728205342770469.stgit@wayrath>
	<87k1lai2vo.fsf@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RAYtGvo6aioyBWTpFRh4"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] docker: dockerfile for openSUSE Leap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--=-RAYtGvo6aioyBWTpFRh4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-11-18 at 19:47 +0000, Alex Benn=C3=A9e wrote:
> Dario Faggioli <dfaggioli@suse.com> writes:
>=20
> > Dockerfile for building an openSUSE Leap container.
> >=20
> > Tracks the latest release (at the time of writing this
> > patch, it is Leap 15).
> >=20
> > Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> > ---
> > Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> > Cc: Fam Zheng <famz@redhat.com>
> > Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> > ---
> >  tests/docker/dockerfiles/opensuse-leap.docker |   62
> > +++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/opensuse-leap.docker
> >=20
> > diff --git a/tests/docker/dockerfiles/opensuse-leap.docker
> > b/tests/docker/dockerfiles/opensuse-leap.docker
> > new file mode 100644
> > index 0000000000..9d00861e66
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> > @@ -0,0 +1,62 @@
> > +FROM opensuse/leap
> > +ENV PACKAGES \
> <snip>
> > +    tar \
> > +    usbredir-devel \
> > +    virglrenderer-devel \
> > +    vte-devel \
> > +    which \
> > +    xen-devel
> > +    zlib-devel \
>=20
> This hasn't been tested because the docker image fails to build due
> to
> continuation breakage.
>
It is indeed broken.

Basically, I tested it thoroughly, and I'm quite sure it works ok
(although, I'm no docker expert).

Then, when I was about to send the mail, I saw in another commit that
it was best to have the package list sorted; so I did that, and forgot
to adjust the continuation. :-(

Sorry.

I'll send a v2 with this fixed.

Thanks and Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-RAYtGvo6aioyBWTpFRh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlvx3FIACgkQFkJ4iaW4
c+597w//Qcf5Lo618TjaL4CZRbO0JeqANLP8qAJR7sxX/124a3BFmuxftQFj7EbS
JuEzB7XrQB3oqowkM0sQfiyHJI8qrvIntWj1WXSKPOJe2LjVXw4Z207pQh5lgLxp
IWKJ+2LG9QUGD5eRi2kR9E+sOZcU3CAQr7E5q2hvsJJOjWIJKPmqmlpErltp1v6i
mZq/u83srvZVTyCghD52NZMRb3MIIKJjlLyD3fw+zJim5Ie2PVUasJygIU3p1+em
nL2WpuVdcMIcxbKW7COqyODpxODy17Vjiv1ljMkEHeeD5JUZ22t7U6gjlVghzlOq
vgqMckjzB868FPh0CZF7d/T+pfzKUi7Z7i3ENj0czFruEpKeKInI3y6Qr/pCx5Lx
F/INDun6rqbALVNI+WBVwLEiQ5TOeDgijJH97G3nsV/mQabnhZ20iyXMyjEmRBHb
TFb9Hv2C8DxMSM4+tZ+55iJpDtHKkZTTXym/Pjom3W0+ef5awe5Ndk12Kg+2x794
nGLq4/AuruxFmWHjXaj81jT1Z2s6rAwSjGqQthTKhN5UkNSZwKk2KIErycwd/nRS
5eE0giB4gzuz/TEDsjqc8uibj5i1y7qOiFqBSTpp1emxyuypobWo5KxN0gZCCTC8
qRFAoEKAI3aVwn4SHXutvATdnujpCOCtfLisIfXhnQ5ZdyBXuwg=
=rvSD
-----END PGP SIGNATURE-----

--=-RAYtGvo6aioyBWTpFRh4--
