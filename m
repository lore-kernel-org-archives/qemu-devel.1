Received: from eggs.gnu.org ([2001:4830:134:3::10]:48592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f45qH-0004BH-Af
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f45qC-00062D-E7
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:26:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f45qC-00060o-8o
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:26:16 -0400
Date: Thu, 5 Apr 2018 15:26:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180405142606.GB28352@stefanha-x1.localdomain>
References: <1522856003-26861-1-git-send-email-thuth@redhat.com>
	<39b47744-c5fb-f541-0e68-62d50bd85e5b@redhat.com>
	<62cabc20-dd16-07ae-5395-5e6f6f4d6135@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <62cabc20-dd16-07ae-5395-5e6f6f4d6135@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 0/2] net: Get rid of 'vlan'
 terminology and use 'hub' instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 05:55:57PM +0200, Thomas Huth wrote:
> On 04.04.2018 17:49, Paolo Bonzini wrote:
> > On 04/04/2018 17:33, Thomas Huth wrote:
> >> The 'vlan' term caused a lot of confusion in the past, so let's try
> >> to switch to the better word "hub" everywhere where it is appropriate.
> >> (Note: The CLI parameter "vlan=3Dxxx" still remains as is to not break=
 the
> >> compatibility with older versions)
> >>
> >> Thomas Huth (2):
> >>   net: Get rid of 'vlan' terminology and use 'hub' instead in the sour=
ce
> >>     files
> >>   net: Get rid of 'vlan' terminology and use 'hub' instead in the doc
> >>     files
> >=20
> > Bold proposal: remove 'vlan' property/suboption in 2.13, so that we can
> > remove the "aka"s altogether.  Yes, it's early, but even though I've
> > occasionally used vlans I've never used more than one...
>=20
> Fine for me, too - if we all feel confident enough already for that. The
> "vlan=3D..." parameter of "-net" has been declared as deprecated since
> QEMU v2.9, so unless somebody sees an urgent need to still keep it, I
> can add another patch to this series to remove it ("-net" will then only
> work with the default hub #0).

Sound good to me.

Stefan

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxjH+AAoJEJykq7OBq3PI0bsIAMBx1t8pCCPPXaflZA6is6Pi
eTuxyoYkm8b7nB88mZerQaamiNUOZTG9XhczJe2Gnpuid7GKGOv2aZGDj1cNZv+q
408fHEvqzGTwAQen8qomZrESV9g3RF0UzQ6DdCx9/sGTXSibiIWfsG7JsIWdkaKx
PC+UTsKJe2izG/IH7do5I/1utGY9ufiX+F7CZqP1cRKNkGwzunSayXVc9kHr5CLC
jVdf7eTh+OGMd2XhTVQZpJjO3QtD6iLQAhB1J5+BAXAKYBkM6K0jNrlFyCy6D9iQ
zMBq/Hs4CiXc51dA/CokymmIs0ikdpsFWZdHF+QNyCuGpMqVE3QTWYGdMP+Lju4=
=2SEQ
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
