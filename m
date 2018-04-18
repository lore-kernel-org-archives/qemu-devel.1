Received: from eggs.gnu.org ([2001:4830:134:3::10]:52484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nNw-0001xc-KP
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nNs-00062O-JW
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:44:32 -0400
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
	<f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
	<6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66905e1f-9097-f912-2153-809cd45f214e@redhat.com>
Date: Wed, 18 Apr 2018 08:44:26 -0500
MIME-Version: 1.0
In-Reply-To: <6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YEYr6X8h36nKQGkboSo1N9xqLPEdCf2Ir"
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YEYr6X8h36nKQGkboSo1N9xqLPEdCf2Ir
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Message-ID: <66905e1f-9097-f912-2153-809cd45f214e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should be
 unsigned
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
 <df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
 <f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
 <6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
In-Reply-To: <6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 11:59 AM, Halil Pasic wrote:

> This ssize_t seems to be an rather interesting type. For instance POSIX=
 says
> """
> size_t
>     Used for sizes of objects.
> ssize_t
>     Used for a count of bytes or an error indication.
> """
> and
> """
> The type ssize_t shall be capable of storing values at least in the ran=
ge [-1, {SSIZE_MAX}].
> """
>=20
> And it does not mandate SSIZE_MIN in limits (but of course mandates SSI=
ZE_MAX.

I've tried to get POSIX to tighten things to require that 'size_t' and
'ssize_t' must have the same rank, so that you can sanely use
printf("%zd",(ssize_t)val), but we are not there yet.

>=20
> I don't like this 'counterpart' word here, because AFAIU these don't ha=
ve to
> be counterparts in any sense. That is SSIZE_MAX << SIZE_MAX is possible=
 for
> example. I'm not sure about the every positive has a negative thing, bu=
t
> that's not important here.

Indeed, until the POSIX wording is tightened, it is technically possible
(but a very poor quality of implementation, and none of qemu's
compilation platforms fall in that category) that ssize_t has a
different rank than size_t (whether or not they also have a different
width).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--YEYr6X8h36nKQGkboSo1N9xqLPEdCf2Ir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXS7oACgkQp6FrSiUn
Q2qOrAf/YdZvdQQ/aQYydnfA2svtdy5Ada5TMKUfhqqGVIwhjyhUY9OIhLo1RfQh
eoryVGSW3PLNpkyjTyDy5ucCzE9wNX3oJRAF2j+XhaDSypWkBvyLOlVqEd2vn/Qb
FGVFPuHkRIL3+VnjAxDoee37YsANB9lFv2/0myXUjCu9+f3T1urmxaykSDfyT85j
xVKCt6snyemP4s08sjlo+6ES8rLSLDT2r1rycrPVRTKEUaukt85m8BC896NArYSO
oxQy2GH4T2WX+07S2DBH72w+x9WsRbMD9t7sNWugF1zEVwbZgN9Fti6p6Xjs8QVi
/HZsxDwxhQMJb3noFzByvR80BSXRug==
=VRln
-----END PGP SIGNATURE-----

--YEYr6X8h36nKQGkboSo1N9xqLPEdCf2Ir--
