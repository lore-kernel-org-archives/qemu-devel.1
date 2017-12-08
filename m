Received: from eggs.gnu.org ([2001:4830:134:3::10]:58294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNM3X-000231-J1
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNM3W-0002VE-Jr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:03:23 -0500
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
	<1512733868-9009-3-git-send-email-pl@kamp.de>
	<dd61b219-a965-3794-5155-1483227d5e62@redhat.com>
	<4b0586ee-45cb-cfb1-288c-bcccf81c5212@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <295e577a-72e2-f397-ec44-ecdee248ff51@redhat.com>
Date: Fri, 8 Dec 2017 11:03:12 -0600
MIME-Version: 1.0
In-Reply-To: <4b0586ee-45cb-cfb1-288c-bcccf81c5212@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rvSn4Rb8S7cWO29DkR5qx6IjMfFjPh3JU"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/iscsi: only report an iSCSI
 Failure if we don't handle it gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, ronniesahlberg@gmail.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvSn4Rb8S7cWO29DkR5qx6IjMfFjPh3JU
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, ronniesahlberg@gmail.com,
 mreitz@redhat.com
Message-ID: <295e577a-72e2-f397-ec44-ecdee248ff51@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/iscsi: only report an iSCSI
 Failure if we don't handle it gracefully
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
 <1512733868-9009-3-git-send-email-pl@kamp.de>
 <dd61b219-a965-3794-5155-1483227d5e62@redhat.com>
 <4b0586ee-45cb-cfb1-288c-bcccf81c5212@kamp.de>
In-Reply-To: <4b0586ee-45cb-cfb1-288c-bcccf81c5212@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 10:14 AM, Peter Lieven wrote:
> Am 08.12.2017 um 16:11 schrieb Eric Blake:
>> On 12/08/2017 05:51 AM, Peter Lieven wrote:
>>> we currently report an "iSCSI Failure" in iscsi_co_generic_cb if the =
task
>>> hasn't completed with SCSI_STATUS_GOOD. However, we expect a failure =
in
>>> some cases and handle it gracefully. This is the case for misaligned =
UNMAPs
>> Is the block layer still capable of producing a misaligned UNMAP?  If
>> so, that's probably a bug in the block layer for not honoring the bloc=
k
>> limit geometries.
>=20
> In theory there should be none. I think we can drop this code.

Or, better yet, replace the check with an assert.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rvSn4Rb8S7cWO29DkR5qx6IjMfFjPh3JU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqxdAACgkQp6FrSiUn
Q2pOBQf+LhHfIYlRd2+MKPw5szLQOZl/X1QXRK4GMK1maajwH7lOJk7sFifhZjZB
RiXOQZOAeK4hrI1SNFXLDEOF0IeF+1sj8fkepdc4WQ2/EzoRwHwadiASWDVBeeWd
MEFzm076RdnwLfukH0NMhRi28eZPMXaC96ixHdT9zYmDHMN2ZzOowSMgGDE4lPMQ
VgKegz1h7aq6XdNHrYLFAmqAjfxreA/R2euEf73nG100kA/LKqSw4vmddfIWVPR9
pPl+TTPyJVSsAxPKm9ecykLKyYfGGbuEnZoUSO4/6yUA2tnUgx1onPC3D5jOIkvQ
2PbxRXknktOu0LAeKk1naImCQYV5aA==
=Fq/f
-----END PGP SIGNATURE-----

--rvSn4Rb8S7cWO29DkR5qx6IjMfFjPh3JU--
