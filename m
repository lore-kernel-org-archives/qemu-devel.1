Received: from eggs.gnu.org ([209.51.188.92]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgpi-00068q-VU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgpi-0005ok-4b
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:21:42 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
	<edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
Date: Thu, 10 Jan 2019 14:21:21 -0600
MIME-Version: 1.0
In-Reply-To: <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="11POPtN59hjwcCQ3i4OmcfRxOwgXjN8ks"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/6] include: Auto-generate
 the sizes lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--11POPtN59hjwcCQ3i4OmcfRxOwgXjN8ks
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com,
 qemu-block@nongnu.org
Message-ID: <23bcf66e-a485-0155-d808-ef7f436b56c8@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/6] include: Auto-generate the sizes
 lookup table
References: <20190110191901.5082-1-eblake@redhat.com>
 <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
In-Reply-To: <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 1:26 PM, Eric Blake wrote:
> On 1/10/19 1:18 PM, Eric Blake wrote:
>> Patches speak louder than words.  This is my counter-proposal to
>> Leonid's thread on how best to respresent the S_*iB macros in units.h,=

>> where my proposal is that we don't need them at all. (hence my subject=

>> line, even though it is completely unrelated to the series)
>>
>> True, my diffstat is even bigger, but I think it is more maintainable
>> in the long run (if calling QemuOpts maintainable is even appropriate)=
=2E
>=20
> I wasn't brave enough to assert that def_value_str was used only with
> QEMU_OPT_STRING, and that all uses of QEMU_OPT_{BOOL,NUMBER,SIZE} with =
a
> default value are either defaulting to 0 or using def_value_int; that's=

> a bigger auditing task followup that could be given as a BiteSizedTask,=

> if you like this series.

Hmm - I wonder if Coccinelle is powerful enough to find all QemuOptDesc
initializers that .type to something other than QEMU_OPT_STRING and also
set .def_value_str; including initializers that did not use C99
named-member initialization (if we have any of those). (Those are the
candidates to start using .def_value_int)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--11POPtN59hjwcCQ3i4OmcfRxOwgXjN8ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3qUEACgkQp6FrSiUn
Q2pAIgf+Md5qT1K4/exh9uOSntH5a+R/lXYuCMQRfG7wQ+mAowu3lMxft5SsaIyE
sRr4QR4LO+mT8DOIC6xhKp8ia7Y10U2uSJKjjop5CTxSqekQ/xM7/Q9KrFjGjZvR
yUYAGT1NXVvJKinyGoGxgfTE3zxEILUaQMtsmSiuWQ+qKCkSpEXn6Rzec/TvIzfD
uS2OxEUWLouGDv6RpE1QRmU9zYufn4lXk71cjtN2FOiYzcux68HCnKEYTglG5ldi
uHz6wjvHAaVffJupZ5iK03PJDDzM72DDPiTyeZNIw8kSXAg0hx6SnNhcWnwrRUta
hnTXqyS1zibzjrXNNn1K+JcEwDUGyQ==
=Ml9n
-----END PGP SIGNATURE-----

--11POPtN59hjwcCQ3i4OmcfRxOwgXjN8ks--
