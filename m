Received: from eggs.gnu.org ([2001:4830:134:3::10]:51948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRA4-0007PT-Ci
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRA0-0002Et-F1
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:29:56 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1crRA0-0002Ef-8d
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:29:52 -0400
Received: by mail-wm0-x241.google.com with SMTP id u132so1307985wmg.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:29:52 -0700 (PDT)
Date: Fri, 24 Mar 2017 15:29:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170324152946.GS12560@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A2D69E@ORSMSX112.amr.corp.intel.com>
	<cce399b0-45d2-ac24-4975-6e27ad04f833@redhat.com>
	<20170323090516.GN16717@stefanha-x1.localdomain>
	<4712D8F4B26E034E80552F30A67BE0B1A3BA2D@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjXtncIm5b3tWrFJ"
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A3BA2D@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] only link current target arch traces to
 qemu-system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>


--qjXtncIm5b3tWrFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 12:29:39AM +0000, Xu, Anthony wrote:
> > Perhaps all trace.o files should be put into their own .a instead of
> > being added directly to the linker line:
> >=20
> > COMMON_LDADDS =3D $(trace-obj-y) libqemuutil.a libqemustub.a
> >=20
> > I think the linker would only pull in .o files containing symbols that =
are
> > actually referenced by the program.
>=20
> Hi Stefan,
>=20
> That's a good idea!
>=20
> Below patch creates libqemutrace.a.  ./trace.o, ./qapi/trace.o and=20
> ./util/trace.o are added into libqemuutil.a  to avoid recursive dependenc=
ies=20
> between libqemuutil.a and libqemutrace.a.

Please see the guidelines for submitting patches:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

Each patch revision should be sent as a separate email thread.

Each patch series must have your Signed-off-by and a commit
message/description.

Stefan

--qjXtncIm5b3tWrFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1TtqAAoJEJykq7OBq3PIw34IAMD6bupfUtQqbiId5M4yG49U
+vGldCEuTLTGr5UE8VlLSJEWYpqqkVcvNYbNqNTHJw5ROp5iIR0R4hVF/klXu3J2
Vn0m2eFBjM9cjH9U5t6Zep9FI/a0/+zIaWiZuGuOUXxyTyuR2U4h5hTA+1Fzy7T3
MUQn7j3kdjDLUN4vQ8542IGpR5Lh24ctDwOM41isaoucEqeN9rA/XFO5Te5c630Y
v6bQyxiFaO/R+1HhK0aqLJ4KDd3XvfTtZtNP7tklqISWh++LSLozeyJx6SIYd3om
81iKpLEsyrr/ONH3iBpRGYlhIpRmF+sJp6oYYGlPVPzC7dQQUzJkzvCLyydz1w8=
=0xTS
-----END PGP SIGNATURE-----

--qjXtncIm5b3tWrFJ--
