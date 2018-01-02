Received: from eggs.gnu.org ([2001:4830:134:3::10]:34715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTzD-000673-1b
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTz8-00005y-QO
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWTz8-00005j-Fv
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:20:34 -0500
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p2ea569225550a2250ee75f76b482b7498@eucas1p2.samsung.com>
	<1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6edfb28b-09fe-5fe9-7457-ed1cf1064a89@redhat.com>
Date: Tue, 2 Jan 2018 15:20:28 -0600
MIME-Version: 1.0
In-Reply-To: <1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3nAL2poncJxc1WI7Vfld3sPPov9fpQ5hp"
Subject: Re: [Qemu-devel] [PATCH v12 1/6] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3nAL2poncJxc1WI7Vfld3sPPov9fpQ5hp
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com, i.maximets@samsung.com
Message-ID: <6edfb28b-09fe-5fe9-7457-ed1cf1064a89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 1/6] migration: introduce
 postcopy-blocktime capability
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
 <CGME20171030131647eucas1p2ea569225550a2250ee75f76b482b7498@eucas1p2.samsung.com>
 <1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  migration/migration.c | 9 +++++++++
>  migration/migration.h | 1 +
>  qapi/migration.json   | 6 +++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20

Is there any reason this has to be a new capability rather than
unconditionally enabled?  What are the trade-offs for enabling vs.
disabling the capability that warrant it being a knob?  Can we do a
better job of documenting in which cases the user would want to change
the knob from its default value, if we even need it to be a knob?

> +++ b/qapi/migration.json
> @@ -352,12 +352,16 @@
>  #
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
> +#                     (since 2.11)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
> -           'block', 'return-path', 'pause-before-switchover', 'x-multi=
fd' ] }
> +           'block', 'return-path', 'pause-before-switchover', 'x-multi=
fd',
> +           'postcopy-blocktime' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3nAL2poncJxc1WI7Vfld3sPPov9fpQ5hp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL95wACgkQp6FrSiUn
Q2p1QQgAksCbwnkYSj+p0MmMKByzfi2tJSOstByU1KPcu+7GweeqkppjQW7jL619
wxa237APox6XQtQjNFYJ1/+Qpoq0tqohq0pKE8Mc/YdxdJBqlckHtgeBBQw5jBbk
3Xwy4xDP8RuOIHpgY8bqC0DPRksdQQsOZQjcAsXfConFdbplDcxbCR8cwqo7S2Uu
F8Rb+YUoL0OpKUF9pIj3rLTvM0FN6irNn8UGPlDwBcbGewislLGwKcCmcBCGedOi
51UYHVc9Z90jLHBDsRb93B/QJ29XjntFjrBzjdA5GxZZtauZPXrLsJjtonbuuJQl
gdMo9PwXnfTPIaiVzC0H7hOniCLHuA==
=2YbS
-----END PGP SIGNATURE-----

--3nAL2poncJxc1WI7Vfld3sPPov9fpQ5hp--
