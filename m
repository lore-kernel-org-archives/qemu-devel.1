Received: from eggs.gnu.org ([2001:4830:134:3::10]:40490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGkh-0002hC-9x
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGkg-0005Cc-5D
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:25:35 -0500
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af8b51d0-5ff7-08ad-7be0-3b5d470963a5@redhat.com>
Date: Thu, 18 Jan 2018 14:25:26 -0600
MIME-Version: 1.0
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8skQchrR481anu9pTtT0MdWZSZHVgNw8P"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8skQchrR481anu9pTtT0MdWZSZHVgNw8P
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <af8b51d0-5ff7-08ad-7be0-3b5d470963a5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Call check and invalidate_cache from
 coroutine context
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 06:43 AM, Paolo Bonzini wrote:
> Check and invalidate_cache share some parts of the implementation
> with the regular I/O path.  This is sometimes complicated because the
> I/O path wants to use a CoMutex but that is not possible outside corout=
ine
> context.  By moving things to coroutine context, we can remove special
> cases.  In fact, invalidate_cache is already called from coroutine cont=
ext
> because incoming migration is placed in a coroutine.
>=20
> While at it, I'm including two patches from Stefan to rename the
> bdrv_create callback to bdrv_co_create, because it is already called
> from coroutine context.  The name is now bdrv_co_create_opts, with
> bdrv_co_create reserved for the QAPI-based version that Kevin is
> working on.
>=20
> qcow2 still has cache flushing in non-coroutine context, coming from
> qcow2_reopen_prepare->qcow2_update_options_prepare and
> qcow2_close->qcow2_inactivate.
>=20
> Paolo
>=20

Modulo a commit message nit in 4/7, series

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8skQchrR481anu9pTtT0MdWZSZHVgNw8P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphArYACgkQp6FrSiUn
Q2rk6Af/YJom2l8rZSFDLyEkLO6xugbgMCIDwtfipPbruq0c2eO3hN/ik7hSw6y2
M+bEIbrIgV68eNWTUrgaFlPBcpA+QX7sAnjlvFX0wlnTu47526O1BBN0y6/G61wD
x4+BXa2k/EBNa9THueQXz0QzwW59WvdeCM4qhDk7Q1EeBEI9N5mrFwWq11LSGdnJ
HFH46XUo+zizuXhrjUgWABknAYl5FS6GRqYAM5Um6HDi+FWraNa1JVry7pO/cEKO
TOruSFpvmJiP6coKnCCRVaxRiFp5yhMbreuo0J164GxQmg2xkQ83z8pSpUbdwHdd
Gr+K9NUMK2QOvit6O+/Q2dfphEpffQ==
=7CZ6
-----END PGP SIGNATURE-----

--8skQchrR481anu9pTtT0MdWZSZHVgNw8P--
