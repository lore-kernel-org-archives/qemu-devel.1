Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv2pF-0004mm-DB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv2pA-0001U9-Fa
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:19:21 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv2pA-0001U1-99
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:19:16 -0400
Received: by mail-wr0-x242.google.com with SMTP id p52so34063359wrc.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:19:15 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:19:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403141912.GA3539@stefanha-x1.localdomain>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 01:49:44PM +0100, Peter Maydell wrote:
> On 27 March 2017 at 13:01, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > It would be nice to get rid of the legacy -net option in 3.0.0.  I have
> > added it and included pointers to loose ends.  I think this is doable
> > but will require some time to achieve.
>=20
> What's the syntax for using -netdev with embedded network
> devices that you can't create with -device ?
> (We should document this at
> http://wiki.qemu-project.org/Documentation/Networking)

I mentioned that on the wiki.  This isn't an option we can drop easily.
Work is necessary to make -netdev a complete replacement or to remove
the legacy stuff from -net.

Stefan

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4lngAAoJEJykq7OBq3PIAe0H/AjH/mZhZ9rvrou7aK7eia0E
CbfenVw9sJidzcLdXjaPNU/HLoTncvK5E4WvxxxYvypOjX8q0Tbq2bYGreVL6Km5
+ifuevNvLhesq/ecFHmGikSqhcUcGXV7/AFq5l6L1zMwpFHeCDn+HesIpQybxc8d
JYSYfck9CrDQFQ4mW+AvgldLrwgVL8inDQr+euPquejXlkFAYjL3yI55CHV/fa7a
lDh/jj7sPre+sFosChIszdI+yeTXu6ERSISnSv+kRMhZhggsv9ivaTpCeJwfXWSn
ePbs608br7K2O6t44Kb6dDjpeseGeexHeGVO2AzCNwnI0DOm13qK9YSXXEjjDH0=
=ERYp
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
