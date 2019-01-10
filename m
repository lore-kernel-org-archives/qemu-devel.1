Received: from eggs.gnu.org ([209.51.188.92]:58497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfyA-0001b6-Dn
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfy8-0007nd-S4
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:26:22 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
Date: Thu, 10 Jan 2019 13:26:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FP17P3xeUE04tlx7PX73NIAlAza8m5A9H"
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
--FP17P3xeUE04tlx7PX73NIAlAza8m5A9H
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, armbru@redhat.com,
 qemu-block@nongnu.org
Message-ID: <edb4aed4-d032-2a8d-62d0-b5277ca137d5@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/6] include: Auto-generate the sizes
 lookup table
References: <20190110191901.5082-1-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 1:18 PM, Eric Blake wrote:
> Patches speak louder than words.  This is my counter-proposal to
> Leonid's thread on how best to respresent the S_*iB macros in units.h,
> where my proposal is that we don't need them at all. (hence my subject
> line, even though it is completely unrelated to the series)
>=20
> True, my diffstat is even bigger, but I think it is more maintainable
> in the long run (if calling QemuOpts maintainable is even appropriate).=


I wasn't brave enough to assert that def_value_str was used only with
QEMU_OPT_STRING, and that all uses of QEMU_OPT_{BOOL,NUMBER,SIZE} with a
default value are either defaulting to 0 or using def_value_int; that's
a bigger auditing task followup that could be given as a BiteSizedTask,
if you like this series.

Of course, if we ever get around to teaching the QAPI generators about
default values (where we could have strongly-typed defaults enforced by
the generator, rather than quacks-like-a-duck defaults in QemuOpts), and
converting more things to QAPI and away from QemuOpts, that's even
better (but an even bigger task).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FP17P3xeUE04tlx7PX73NIAlAza8m5A9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3nFAACgkQp6FrSiUn
Q2pzHAgAgJpXTSLUp0zNaGvd9g9GbPierXwCMAmMrHnpDVeMUKf2wEQsGPtr9nbY
vg2HM+CSvLmRQQRM8bfDXVza0pvC/8NCtC/U1jM56FjIl8iThGVuq6NNvsWIry8A
3pRF1dzu2JnxGJDhHHfZBO2w9jAffvLiYfmxj/j+SVEPGJkcfk0D3olI9MgDxZPJ
CPgk3t8XJNATLBzCvlU0ysMzKBr1sQVe65bGscivBgYMyVUguAsyVPj5ScO3FQn+
Hgofs6mZTfvfsdxA96jeJrINc0NgB7wVzeRY4MVMMq6bAR7KRKnFG/J7lLPU+GIX
IDGDIHGlENlbp0GBc24J78KbT8y2TQ==
=YjrJ
-----END PGP SIGNATURE-----

--FP17P3xeUE04tlx7PX73NIAlAza8m5A9H--
