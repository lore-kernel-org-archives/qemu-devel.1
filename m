Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN42U-0006Kx-Qa
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN42U-0000VS-0O
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:49:06 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-8-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0661298c-5478-8608-a80c-09589c3555d1@redhat.com>
Date: Thu, 7 Dec 2017 15:48:53 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-8-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kgrBBphiAsFL5FgQgnDXPvcSoe4BMj6hs"
Subject: Re: [Qemu-devel] [PATCH v2 7/9] iothread: add iothread_by_id() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kgrBBphiAsFL5FgQgnDXPvcSoe4BMj6hs
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <0661298c-5478-8608-a80c-09589c3555d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/9] iothread: add iothread_by_id() API
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-8-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-8-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> Encapsulate IOThread QOM object lookup so that callers don't need to
> know how and where IOThread objects live.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/sysemu/iothread.h | 1 +
>  iothread.c                | 7 +++++++
>  2 files changed, 8 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kgrBBphiAsFL5FgQgnDXPvcSoe4BMj6hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopt0UACgkQp6FrSiUn
Q2r/YggApoZ2XW4yes3FIm/cSKngWiZ+8xbUip70Y4xEnavFaFE8h8Wy7FVhWySN
WeSptpogwXLEghPY9DlHY4zkEgHurakC+eXHEZMBL5sqE7JScVoxbPnmkK4LQtf8
A0H8Rtpb13fxR06AdO+JU5RCn6WGReRvMldfaB08QUmOsIiCa9nY0q7i0mA0SgMO
e178l33Fry0psHv1w1nS6+kGuE47jPPqt/5W1ffOOnca8fx2dLNe3a7+tXhClR58
1ktHM7fdaatHa2RLQe+n8YIMhQogHl3mcS0cTCn2wZ1Itob8No9rZ3Y4TL29d3ST
6KuTp1h/Cwnz5LIRhtFPcZToC3M1Rw==
=95SM
-----END PGP SIGNATURE-----

--kgrBBphiAsFL5FgQgnDXPvcSoe4BMj6hs--
