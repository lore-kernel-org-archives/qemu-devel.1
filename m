Received: from eggs.gnu.org ([2001:4830:134:3::10]:35707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XYK-0007ff-OS
	for Qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XYH-0006rZ-Ko
	for Qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:13:48 -0400
References: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
	<20180409091146.GC5294@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <521f2f27-fd10-5745-ddfd-3cf1fff3013e@redhat.com>
Date: Mon, 9 Apr 2018 09:13:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180409091146.GC5294@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l3NHnmLYRiqNmIxIUV4tDOofc12tINbV3"
Subject: Re: [Qemu-devel] [Qemu-block] block-stream/commit and mixing
 internal and external snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l3NHnmLYRiqNmIxIUV4tDOofc12tINbV3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <521f2f27-fd10-5745-ddfd-3cf1fff3013e@redhat.com>
Subject: Re: [Qemu-block] block-stream/commit and mixing internal and external
 snapshots
References: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
 <20180409091146.GC5294@localhost.localdomain>
In-Reply-To: <20180409091146.GC5294@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2018 04:11 AM, Kevin Wolf wrote:
> Am 07.04.2018 um 00:16 hat Eric Blake geschrieben:
>> Perhaps others have already known this, but I just realized that if yo=
u
>> mix internal and external snapshots, you can set yourself up for massi=
ve
>> failures when trying to use block-stream or block-commit to consolidat=
e
>> data across the external backing chain, without also thinking about th=
e
>> internal snapshots.
>=20
> Yeah, internal and external snapshots don't mix well. Basically, the
> only thing that will work reliably is having a qcow2 image with interna=
l
> snapshots at the top, and then an immutable backing chain without
> internal snapshots below it.

I may try to tackle some safety valve additions in 2.13; but as the
problem is pre-existing and not a late regression in 2.12, it is not a
candidate for rushing anything into -rc3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l3NHnmLYRiqNmIxIUV4tDOofc12tINbV3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrLdRYACgkQp6FrSiUn
Q2oy0wf/b/Rv1LQHrNVa0CHBcEIUpqvWNDV8LpKMooJ80ZR9EJJsnuldvPqS7FTm
cjeLFs4jyob8aUEumI+eLv0ipy5XdhkD9aoYiqhI5KkaOvmMpMgSA/GO1xFEMy1O
ubky83F12mSGRBSqsJfz7QxQlit1uS9JCYEESydO1pGkwUvYq06640uVAWHQIepU
F8UFfDie+jhjjEnB1PiEueh4DPSFYvlvEDslKLiuri73I2eOgNjpyt30O8wOEi75
QlIfntIT1c+3AHeTbfSdNprjecFlAaplXxEVJCKx4RvUtDnXUm1Cnx+Q25lLE3ER
Ikf80F8zmRVQYNZlCDJMsxH6BR1YHw==
=Oz51
-----END PGP SIGNATURE-----

--l3NHnmLYRiqNmIxIUV4tDOofc12tINbV3--
