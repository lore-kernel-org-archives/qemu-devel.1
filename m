Received: from eggs.gnu.org ([2001:4830:134:3::10]:60955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBRAL-0004dt-TT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBRAH-0002jd-Vi
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:37:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBRAH-0002jH-Pg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:37:21 -0400
References: <20180425200326.72337-1-dgilbert@redhat.com>
	<20180425200326.72337-7-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9d3149c-f5a3-c220-a802-5ea7a4bffd90@redhat.com>
Date: Wed, 25 Apr 2018 15:37:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180425200326.72337-7-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lcNLCc6kzctchfZUhC5JIlIoTZMigV2vt"
Subject: Re: [Qemu-devel] [PULL 06/16] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lcNLCc6kzctchfZUhC5JIlIoTZMigV2vt
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 a.perevalov@samsung.com, xiaoguangrong@tencent.com
Message-ID: <a9d3149c-f5a3-c220-a802-5ea7a4bffd90@redhat.com>
Subject: Re: [Qemu-devel] [PULL 06/16] migration: add postcopy total blocktime
 into query-migrate
References: <20180425200326.72337-1-dgilbert@redhat.com>
 <20180425200326.72337-7-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-7-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 03:03 PM, Dr. David Alan Gilbert (git) wrote:
> From: Alexey Perevalov <a.perevalov@samsung.com>
>=20
> Postcopy total blocktime is available on destination side only.
> But query-migrate was possible only for source. This patch
> adds ability to call query-migrate on destination.
> To be able to see postcopy blocktime, need to request postcopy-blocktim=
e
> capability.

This prerequisite command...


> +++ b/qapi/migration.json
> @@ -155,6 +155,13 @@
>  # @error-desc: the human readable error description string, when
>  #              @status is 'failed'. Clients should not attempt to pars=
e the
>  #              error strings. (Since 2.7)
> +#
> +# @postcopy-blocktime: total time when all vCPU were blocked during po=
stcopy
> +#           live migration (Since 2.13)
> +#
> +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (S=
ince 2.13)

=2E.. should be documented here (something along the lines of "This field=

is only present if the postcopy-blocktime migration capability was enable=
d")

> +#
> +
>  #

Why the blank line addition?  More to include in your followup cleanup
patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lcNLCc6kzctchfZUhC5JIlIoTZMigV2vt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg5vYACgkQp6FrSiUn
Q2q9IQf+Migt79KMDyabiW2Pz9w+QwVshe/nLJKe6wE+bY2xFubwDGQQZbAoDtjL
wzFwmh3JQZYnNahfYGbVB79ouLqLcXG4pAf423PsS/FdklA8kHAIT1cI3otH7r2j
F4KNIw0d+4Upn8NDf2UQLpfFcBmhyhgfWB1/UNw2803eSeX2537nIufvU8E8UgC5
HK/kqqxoA0BboRgTQ9NshKB1IE89+K5lwIqEIf7HL+kBTpjFS6ysG9EP5TYsiC6q
5/y4WoKVhds43A5zsWV8HGoa7Z9FznaH4ozWpBU6BfVFxf7liK7TWQO4LRXwLOiG
zDu3NoBe/FriNzDjkEJ9APwlt32L2A==
=VRl5
-----END PGP SIGNATURE-----

--lcNLCc6kzctchfZUhC5JIlIoTZMigV2vt--
