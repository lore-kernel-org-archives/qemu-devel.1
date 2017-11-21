Received: from eggs.gnu.org ([2001:4830:134:3::10]:38281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7fL-0004Pr-RB
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7fJ-0000EY-4C
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:28:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eH7fI-0000E0-Tq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:28:37 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<243ad517-3fb9-43a4-5cb3-118b312a5720@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4a403ee-8981-5589-5a18-f7c499d1f89c@redhat.com>
Date: Tue, 21 Nov 2017 06:28:34 -0600
MIME-Version: 1.0
In-Reply-To: <243ad517-3fb9-43a4-5cb3-118b312a5720@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IWXxJrNfMEK7C8Gp55pfxGS3LL42UhSKw"
Subject: Re: [Qemu-devel] [PATCH v4 00/20] add byte-based block_status
 driver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IWXxJrNfMEK7C8Gp55pfxGS3LL42UhSKw
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Message-ID: <b4a403ee-8981-5589-5a18-f7c499d1f89c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/20] add byte-based block_status driver
 callbacks
References: <20171012185916.22776-1-eblake@redhat.com>
 <243ad517-3fb9-43a4-5cb3-118b312a5720@virtuozzo.com>
In-Reply-To: <243ad517-3fb9-43a4-5cb3-118b312a5720@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 05:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>=20
> Is it a latest portion of moving to byte-based? All other parts are
> already merged? Are you going to update it? (or this version if ok for
> review?)

This version is okay to review; although it will need a v5 respin once
2.12 is reopened for some minor merge conflicts that have crept in
during the meantime (regarding bs->drv NULL checks).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IWXxJrNfMEK7C8Gp55pfxGS3LL42UhSKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloUG/IACgkQp6FrSiUn
Q2rThQf/Q3b7kG8CfzSLo2FHUMnoCB6Q36Vi2L8Jn04HX85gOYGG4nF7YiOw8EX2
ZofM8cIaL0PoL5Xak7PIvdvYxFiVGPYzPhyFOcgOBFW4Ypy2JbB5nR/WhV/bfMCw
T/gtfQ2m3O/uiR2MYvHmCLdRFAiXA14aHkBDAfN6u8f5eNWbdLm0CsB1GOgRjnQ/
WlsHS++3TvppKfKB29+GWmVXBTX2B6pN9i/D0WZh3exYqay76lxVn3KeweZ0208+
NQ98LsTPJuAjchJtclmeVN4tC4JrY7Tv7MuzJFMH151M3BG8NXZ11FIw+Vs11laf
4Y9chbr9BXjbKTonzUIWGvYDGLznFg==
=WRnk
-----END PGP SIGNATURE-----

--IWXxJrNfMEK7C8Gp55pfxGS3LL42UhSKw--
