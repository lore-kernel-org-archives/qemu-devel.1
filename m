Received: from eggs.gnu.org ([2001:4830:134:3::10]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw7NV-0000fr-RV
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw7NR-0006XH-TB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:23:09 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw7NR-0006Wy-Mf
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:23:05 -0400
Received: by mail-wr0-x241.google.com with SMTP id g19so11377178wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 06:23:05 -0700 (PDT)
Date: Thu, 6 Apr 2017 14:23:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406132301.GM21895@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
	<87y3vf9sn5.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline
In-Reply-To: <87y3vf9sn5.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH] Put all trace.o into libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 11:15:58AM +0300, Llu=EDs Vilanova wrote:
> Xu, Anthony writes:
>=20
> > Put all trace.o into libqemuutil.a
> > Currently all trace.o are linked into qemu-system, qemu-img,=20
> > qemu-nbd, qemu-io etc., even the corresponding components=20
> > are not included.
> > Put all trace.o into libqemuutil.a that the linker would only pull in .=
o=20
> > files containing symbols that are actually referenced by the=20
> > program.
>=20
> I think this change conflicts with some of the guest code tracing patches=
 I have
> in the queue (I won't be able to send the new series until the end of the=
 month,
> sorry).
>=20
> AFAIR, some of my patches need to link different code for utils and qemu'=
s main
> binaries. Although there might be a better way of doing it that I missed.

I don't know the details of your unsent patches, but one possible
solution is stubs/* where we stub out functions that are unavailable in
tools.  That way the same code links in the main QEMU program and in
utils.

When the code runs in utils, it either doesn't take the code path that
reaches the stub function or it calls the stub and continues unaware
that the call was a noop.

If you want to discuss further, feel free to post an RFC preview series
of your work in progress.

Stefan

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5kE1AAoJEJykq7OBq3PIUHoH/0O/uB24sWgrFlq7jg8tNg0W
vUtX3AeWv4GclbiS5yZsPAGdrIdTZuSypoymMUYMkTnEnMA34JG2ETh1hI0nHl2/
v3Xo7HpxlNitp2uXoq63M3YscEy5c+1EQoN90Q3UZaSmFAV4gzOuDMB4YmRYiJGn
i+pGDpV/eQ368yS4IMo1tgGYxrOrlhzP7eRnZbI2/0W7GSWIdzxSl0b85n+6B4nQ
CUsMlAtQNN1Lb5JMlQEjST9CMhvitc3gUNWFbZx1GAPGRGj724cda4vta05RDJyA
d1W+mdh4Qw9uSzG1SN4YVYQaj2ixmrWGjNQ3ueOPUKOkvh5j8+6dWiBO8GKdid4=
=5EyZ
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
