Received: from eggs.gnu.org ([2001:4830:134:3::10]:52338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duMX4-0006a1-OQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duMX0-0006CV-6t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duMWz-0006Bf-Tj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:41:58 -0400
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164827eucas1p231a5b9afd8e81427db114e57a0b6fbbe@eucas1p2.samsung.com>
	<1505839684-10046-11-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <455fc8e2-ca88-d32f-1aac-3d2f400dcaa4@redhat.com>
Date: Tue, 19 Sep 2017 12:41:51 -0500
MIME-Version: 1.0
In-Reply-To: <1505839684-10046-11-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1tspBr5UBAmLHCiFiUa13cScJbabXeqKc"
Subject: Re: [Qemu-devel] [PATCH v10 10/10] migration: add postcopy total
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
Cc: i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1tspBr5UBAmLHCiFiUa13cScJbabXeqKc
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com,
 quintela@redhat.com, heetae82.ahn@samsung.com
Message-ID: <455fc8e2-ca88-d32f-1aac-3d2f400dcaa4@redhat.com>
Subject: Re: [PATCH v10 10/10] migration: add postcopy total blocktime into
 query-migrate
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170919164827eucas1p231a5b9afd8e81427db114e57a0b6fbbe@eucas1p2.samsung.com>
 <1505839684-10046-11-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1505839684-10046-11-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 11:48 AM, Alexey Perevalov wrote:
> Postcopy total blocktime is available on destination side only.
> But query-migrate was possible only for source. This patch
> adds ability to call query-migrate on destination.
> To be able to see postcopy blocktime, need to request postcopy-blocktim=
e
> capability.
>=20

> +++ b/qapi/migration.json
> @@ -150,6 +150,13 @@
>  #              @status is 'failed'. Clients should not attempt to pars=
e the
>  #              error strings. (Since 2.7)
>  #
> +# @postcopy-blocktime: total time when all vCPU were blocked during po=
stcopy
> +#           live migration (Since 2.11)
> +#

You got this one right,

> +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (S=
ince 2.10)

but left this one at 2.10.  Should be 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1tspBr5UBAmLHCiFiUa13cScJbabXeqKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBVt8ACgkQp6FrSiUn
Q2oy1Af+LCgO8TfNhZNpEbTAJCs5BsUh/tVTbCqZQHp6Gm9jTQKg9T96QkRhHyFn
GPuT0upVcFq8H3HCg5PVRTkskJKPgeFrQrXYyxvKqTSRPULWcYDLTx/V6AzvN5Fs
HIoacrOw7P4o1TJhj2sT+bD8kxBTECbWVTMBYMCy0nqzAUEYtZGHEC3+rSLEtoNK
VCDzRFa6FJ2DzXH7byjY/c4PXZ0PbvTbS5CPOwr8SAJc7VTjk+sK6LvgtYyu6Qt6
rTwdjyK5aN9x63DUbJVLlPY/Z6Z31tJQPmKmHXIxsYB/u01GnvGzvC+7tUHYP2Ec
V6Knsu0FhaxQ/gO/Yo6KF1TqSStBZA==
=f61s
-----END PGP SIGNATURE-----

--1tspBr5UBAmLHCiFiUa13cScJbabXeqKc--
