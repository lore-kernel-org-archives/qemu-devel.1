Received: from eggs.gnu.org ([2001:4830:134:3::10]:54267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GoK-0002MI-9g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GoH-000381-0W
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9GoG-000362-Mz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:05:08 -0400
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512113222eucas1p218e8147a2c7d5c7ce9cbaf3d376b1332@eucas1p2.samsung.com>
	<1494588703-9076-9-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d9d643e6-7ab1-0df0-80b1-ef1a4c03cea8@redhat.com>
Date: Fri, 12 May 2017 15:05:02 -0500
MIME-Version: 1.0
In-Reply-To: <1494588703-9076-9-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TjvcBOalALOgG1O9VJHIIWT2Ln4wp7HMG"
Subject: Re: [Qemu-devel] [PATCH V4 8/9] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TjvcBOalALOgG1O9VJHIIWT2Ln4wp7HMG
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <d9d643e6-7ab1-0df0-80b1-ef1a4c03cea8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 8/9] migration: add postcopy total
 blocktime into query-migrate
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512113222eucas1p218e8147a2c7d5c7ce9cbaf3d376b1332@eucas1p2.samsung.com>
 <1494588703-9076-9-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494588703-9076-9-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 06:31 AM, Alexey Perevalov wrote:
> Postcopy total blocktime is available on destination side only.
> But query-migrate was possible only for source. This patch
> adds ability to call query-migrate on destination. To distinguish
> src/dst, state of the MigrationState is using, query-migrate prepares
> MigrationInfo for source machine only in case of migration's state is d=
ifferent
> than MIGRATION_STATUS_NONE.
>=20
> To be able to see postcopy blocktime, need to request postcopy-blocktim=
e
> capability.
>=20
> The query-migrate command will show following sample result:
> {"return":
>     "postcopy_vcpu_blocktime": [115, 100],
>     "status": "completed",
>     "postcopy_blocktime": 100
> }}
>=20

> +++ b/qapi-schema.json
> @@ -712,6 +712,8 @@
>  #              @status is 'failed'. Clients should not attempt to pars=
e the
>  #              error strings. (Since 2.7)
>  #
> +# @postcopy_vcpu_blocktime: list of the postcopy blocktime per vCPU (S=
ince 2.9)

New members should favor '-' over '_' in their name, unless being
consistent with exiting members...

> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -723,7 +725,9 @@
>             '*downtime': 'int',
>             '*setup-time': 'int',
>             '*cpu-throttle-percentage': 'int',
> -           '*error-desc': 'str'} }
> +           '*error-desc': 'str',
> +           '*postcopy_blocktime' : 'int64',
> +           '*postcopy_vcpu_blocktime': ['int64']} }

=2E..but existing members use '-', so these should be 'postcopy-blocktime=
'
and 'postcopy-vcpu-blocktime'.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TjvcBOalALOgG1O9VJHIIWT2Ln4wp7HMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhVuAAoJEKeha0olJ0NqFvAIALCv637Lk8RSdYSUxotLOdfq
nSQFUfKDBE25nS85aqcX03BDtCXwuQbBim3Nu2dCdjkCXuQtIsP6oAvEZWxq1qYK
Bdv0Y6bnvibJkzBXAF4HbgLzTc1/cZB2sHUlmnv9FjYCcqAbBK9LfNSPaw1Iq2Ft
zsa/fG9NWMQy9fOZgKnpeEV8oioMiJp0ipW4SxUuDd8PMLGymAuEVNVInbL4sX+2
JTTliln2F2RU6FQwws/b86SJ+41retzN/1WjC85q6Sak2z0tnjAPOnWVo4dp6z1A
1+UdogBNpfr5PQfRuDyJrcgP0OJBd5j+sbSNsczME5DxQj+nob47Hq/W/ssra/Q=
=8eKC
-----END PGP SIGNATURE-----

--TjvcBOalALOgG1O9VJHIIWT2Ln4wp7HMG--
