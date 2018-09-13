Received: from eggs.gnu.org ([2001:4830:134:3::10]:58056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0T7n-0008Tz-IN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0T7j-0004bc-EO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:01:43 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <581f1972-c722-a304-925b-af0375516b7d@redhat.com>
Date: Thu, 13 Sep 2018 17:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BoYS8A5092ha6f7BBAAO7faFgQlCW0Kik"
Subject: Re: [Qemu-devel] [PATCH v2 09/17] block-backend: Add .drained_poll
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BoYS8A5092ha6f7BBAAO7faFgQlCW0Kik
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <581f1972-c722-a304-925b-af0375516b7d@redhat.com>
Subject: Re: [PATCH v2 09/17] block-backend: Add .drained_poll callback
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-10-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> A bdrv_drain operation must ensure that all parents are quiesced, this
> includes BlockBackends. Otherwise, callbacks called by requests that ar=
e
> completed on the BDS layer, but not quite yet on the BlockBackend layer=

> could still create new requests.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BoYS8A5092ha6f7BBAAO7faFgQlCW0Kik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluae8YACgkQ9AfbAGHV
z0DPdgf/S+dKUbTL7cMjoQ/lzCPxzkaGAmPu0bGF5bbMB2ZQocdq23IgRbWNUQB1
7/U7WSTJeqeCpdDzmmLXIrWdDkcTHD3gisn9F9POdWqTjs21uXWkfRMNxm/CbFrx
IFNGrb0iggqR08OBnKXjWD0u/tyFhG9CjMx4iRI14l5Y4DnSYxENzCopn2rBVOg/
UudBynya7gAL74b50GoivJZMV+ppbqZa/ixjM4poaubXlpHvBzbvXcJrVcs/vieM
v8NypwrLlkunn1SzaYz+JTP91oPG6onp3WhoiKIL+X9yUXbcPDR4m9nHgTTLKM4f
0PNJWdLNLYG67tC2ikawHiH82hul+w==
=eqFf
-----END PGP SIGNATURE-----

--BoYS8A5092ha6f7BBAAO7faFgQlCW0Kik--
