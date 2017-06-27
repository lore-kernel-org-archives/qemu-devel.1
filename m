Received: from eggs.gnu.org ([2001:4830:134:3::10]:37369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgyJ-00027k-7m
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgyI-0001Ga-4g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:15:23 -0400
References: <20170516204724.1617-1-eblake@redhat.com>
	<20170516204724.1617-3-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57db90d1-9185-69e0-f27e-a3cee634aed8@redhat.com>
Date: Mon, 26 Jun 2017 22:15:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170516204724.1617-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LTTVKTnQubvbAEKB2B6pfKjrp6HfsIEDh"
Subject: Re: [Qemu-devel] [PATCH v2 02/12] migration: Don't lose errno
 across aio context changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LTTVKTnQubvbAEKB2B6pfKjrp6HfsIEDh
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <57db90d1-9185-69e0-f27e-a3cee634aed8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/12] migration: Don't lose errno across
 aio context changes
References: <20170516204724.1617-1-eblake@redhat.com>
 <20170516204724.1617-3-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 03:47 PM, Eric Blake wrote:
> set_dirty_tracking() was assuming that the errno value set by
> bdrv_create_dirty_bitmap() would not be corrupted by either
> blk_get_aio_context() or aio_context_release().  Rather than
> audit whether this assumption is safe, rewrite the code to just
> grab the value of errno sooner.
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20

This may still be appropriate for 2.9.1, but is no longer needed on
master thanks to Paolo's work in commit 2119882c7e.

I'll have to rebase and re-send this series, one patch shorter.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LTTVKTnQubvbAEKB2B6pfKjrp6HfsIEDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUc26AAoJEKeha0olJ0Nq1NIH/1YK2ca9xIaql+VvquVCQ35/
93QropQPXVuadT5ixjDAq/Mn+FvNYT6nGDwtTeR5siTgik0RUJMNAeBB7++2GDgm
vtZsuLC17v8ls5xelmmrkU/nJepztnkF+IIq7B6AWO2d9DohJvHC5iADD538244d
i9Zmh4Y7l3YllvR1C1nC98byDoMlDF4iaUAYpSIqrcZSdCylSg2qvyaUWIBo8F8O
yz08mi0DmrkL/x2mvnJaMqeAVVW2UvatbYmbqUTmplhUPrt36YlyaKjw4JV87E2q
L1xId4zJBJduO6UH/1ntw9/uGuR9mhaF7RaH4RkmF7cEOvmR+Q0LDlvr2cK9cSU=
=EkM8
-----END PGP SIGNATURE-----

--LTTVKTnQubvbAEKB2B6pfKjrp6HfsIEDh--
