Received: from eggs.gnu.org ([2001:4830:134:3::10]:57653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7Vi-0008TS-Gh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7Vc-0002Ge-On
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw7Vc-0002GK-H1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:31:32 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-4-eblake@redhat.com>
	<20170406093655.0deaafe2.cornelia.huck@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f3b667f-5049-03d8-9985-fe4b6236c76c@redhat.com>
Date: Thu, 6 Apr 2017 08:31:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170406093655.0deaafe2.cornelia.huck@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P0UN3CBVqr96XXbDLgKjFTdKVrCN8DoFu"
Subject: Re: [Qemu-devel] [PATCH v3 03/13] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, armbru@redhat.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P0UN3CBVqr96XXbDLgKjFTdKVrCN8DoFu
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, armbru@redhat.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <9f3b667f-5049-03d8-9985-fe4b6236c76c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/13] s390x: Drop useless casts
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-4-eblake@redhat.com>
 <20170406093655.0deaafe2.cornelia.huck@de.ibm.com>
In-Reply-To: <20170406093655.0deaafe2.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 02:36 AM, Cornelia Huck wrote:
> On Wed,  5 Apr 2017 14:47:31 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
>> An upcoming Coccinelle cleanup script wanted to reformat the casts
>> present in this file - but on closer look, we don't need the casts
>> at all because C automatically converts void* to any other pointer.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  target/s390x/cpu_models.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>

>=20
> Do you prefer to keep this in this series, or should we just go ahead
> and apply this via s390x?

I'm okay either way. It's trivial enough, and although I found it during
qapi cleanups, it is clearly independent enough that I don't mind
rebasing if you pick it up and apply first through a non-qapi tree.

>=20
> In any case,
>=20
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--P0UN3CBVqr96XXbDLgKjFTdKVrCN8DoFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kMxAAoJEKeha0olJ0NqlfwH/ilLffzm7pt8g0swnIIswvaE
FL6I1ukXhR8X6QUa5M1QAWO+/S9Kcp26CngyH4RX32/FcY5Md+OtXiup2Cnlr63g
QafUBmhhI+K/CdeZfWIf0VIlx2q/4aO8h27jW0vPbvIZNNMHynir6jIJBuJbo3dZ
Nh9GCAymzw2PDLXPafC6LyPWro6377puhWlApGSWvSMPZP4btziJEWlZHhGCUdwu
v4ERFNgFf6UqJonugRX5ALo2rpxwJmqblbUHNI/fKsw4iVPJXFO2TyORvDdm5IRd
OiucARO0TQt8PRqOyO0/PfKf0MOMBP0i89PvFdbQ8/lERYAZq48g8kYHeIX5G4E=
=KzCr
-----END PGP SIGNATURE-----

--P0UN3CBVqr96XXbDLgKjFTdKVrCN8DoFu--
