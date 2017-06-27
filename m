Received: from eggs.gnu.org ([2001:4830:134:3::10]:49351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwQf-0005JU-FG
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwQe-0006yG-Gj
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:45:41 -0400
References: <20170615195110.17479-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ec15191-82a6-d9bf-888b-b8bbbcca90b6@redhat.com>
Date: Tue, 27 Jun 2017 14:45:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170615195110.17479-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tPlMghfir37OKLR1TNH1FgfvsRSIu07e2"
Subject: Re: [Qemu-devel] [PATCH] nbd: fix NBD over TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tPlMghfir37OKLR1TNH1FgfvsRSIu07e2
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org
Message-ID: <6ec15191-82a6-d9bf-888b-b8bbbcca90b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: fix NBD over TLS
References: <20170615195110.17479-1-pbonzini@redhat.com>
In-Reply-To: <20170615195110.17479-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/15/2017 02:51 PM, Paolo Bonzini wrote:
> When attaching the NBD QIOChannel to an AioContext, the TLS channel sho=
uld
> be used, not the underlying socket channel.  This is because, trivially=
,
> the TLS channel will be the one that we read/write to and thus the one
> that will get the qio_channel_yield() call.
>=20
> Fixes: ff82911cd3f69f028f2537825c9720ff78bc3f19
> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tPlMghfir37OKLR1TNH1FgfvsRSIu07e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUrXcAAoJEKeha0olJ0Nqc+YH/0A4kaUDX0zrJEG4UEfMur+0
bppCshOuJYAA6AePTaL+fqg72JcCwnnYWwiua906AUEVFgEnQy2KaY0l8zaSObXg
YHgOerP8EH7sfsvSTidLi8fIMUXnwEOy96kZ3N1byuSXI1CZji/3UXVDn2MOYHQ8
PSbF4K+fZAQNcay/nE88zAn3J44kBv6cyQcNY+fstki2CKuH+VZ+tSQMLlmMLwrN
xT8SRlxnXAZc8brKvK+F8JCniROMSngxLsibrNx68BGP9yG2acscg0P88shDkIvC
3RoCXeqIEqAVcbZk5PmeFUsTBR7NRHkyAOEoC2mnOVflzEWH3lnvqNlJw8S2S/o=
=a6SU
-----END PGP SIGNATURE-----

--tPlMghfir37OKLR1TNH1FgfvsRSIu07e2--
