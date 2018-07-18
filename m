Received: from eggs.gnu.org ([2001:4830:134:3::10]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTr-00066z-7g
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTo-0004za-4k
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTn-0004yy-SS
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id r16-v6so5122309wrt.11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:35:03 -0700 (PDT)
Date: Wed, 18 Jul 2018 15:23:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718142357.GM21825@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
	<bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 04:58:41PM +0200, Paolo Bonzini wrote:
> On 11/07/2018 16:28, Stefan Hajnoczi wrote:
> >> + *
> >> + * QOSGraphObject also provides a destructor, used to deallocate the
> >> + * after the test has been executed.
> >> + */
> >> +struct QOSGraphObject {
> >> +    /* for produces, returns void * */
> >> +    QOSGetDriver get_driver;
> >=20
> > Unused?
> >=20
> >> +    /* for contains, returns a QOSGraphObject * */
> >> +    QOSGetDevice get_device;
> >=20
> > Unused?
>=20
> What is unused?

Neither of these fields are used in this patch.  Please introduce them
in the first patch that actually uses them.  This way code review can
proceed linearly and it also prevents deadcode when just part of a patch
series is merged or backported.

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT019AAoJEJykq7OBq3PIip8IALaYtOj+gTlEaxgxfpQGMoJk
icANfoJvDK95vzuzc9Byv2ZuBsP292kozKF3S34KCFwieEXWxbqUW876tRLks1Vn
jV0+r4YZ7RiDZMblTuMG3ZC1gEcwEcCkFmtNghQv0jj6dqp21GgfcbJ5PpIiMdAE
vZbuEXyTcVmzbStiQWhKeC2ww32ZkK8jXjvK6zztMfymiUeS3RNODlCKQpbPNBNy
iI6TwVoaDZz6B0OX/GqOBJVCgeS969c9oEYVU/STcLFZqVg7+UeZnNn23wuRjh7t
OmIsxr1p1GnEz+JtH8VD725r3G7yJqwcT2yMIcv8MrKb25kZu6bqWapnV4Rh26s=
=Kc8K
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--
