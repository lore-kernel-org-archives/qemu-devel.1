Received: from eggs.gnu.org ([2001:4830:134:3::10]:56356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZzU-0005f0-Gf
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZzT-0003oj-9w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:18:32 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1162122-005f-d631-5c51-cdfa19df8df5@redhat.com>
Date: Thu, 2 Mar 2017 17:18:23 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LgPSSAArmkjnW3swuFlNxg8QNjWL1avgE"
Subject: Re: [Qemu-devel] [PATCH 04/15] sheepdog: Mark sd_snapshot_delete()
 lossage FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LgPSSAArmkjnW3swuFlNxg8QNjWL1avgE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <a1162122-005f-d631-5c51-cdfa19df8df5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/15] sheepdog: Mark sd_snapshot_delete()
 lossage FIXME
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> sd_snapshot_delete() should delete the snapshot whose ID matches
> @snapshot_id and whose name matches @name.  But that's not what it
> does.  If @snapshot_id is a valid ID, it deletes the snapshot with
> that ID, else it deletes the snapshot with that name.  It doesn't use
> @name at all.  Add suitable FIXME comments, so someone who actually
> knows Sheepdog can fix it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20

If a sheepdog maintainer wants to rewrite this patch to avoid FIXME, I'm
fine with that. But in the meantime, this doesn't change behavior, so
it's safe for freeze.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LgPSSAArmkjnW3swuFlNxg8QNjWL1avgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKg/AAoJEKeha0olJ0Nq6O8IAIiyQhQ9eZNnT7c4isojInHZ
LlmUHk2Bgo8NPu1YsW2pg9be0TnyV1V/GCCYXyCh4JInO0qMf4P/Z5aBg0wQpVHB
sPdSiyBTlQ+B8whs/RCTSOuzSBXsbFInMJuxoZ6it026+wuf5QH9JB+CsXJ2iJwP
CMTj9GjoG+bZHAzLvqOMM2qEMzuqNJZknGCxHjrzNDXRCbg5ZS2/o2wvIFwLjD9l
Gy6iECm3eopP//UzV59qOMLiHIIMX9ZASD4DeiEW6YNo0Yvo9C8llRJO9USGwtCb
ju8viJts6k9tdc+IUivQQM/JhZk+4/JETykughgzKtHdD7GXNMxq8hZicHcx/T0=
=tXaT
-----END PGP SIGNATURE-----

--LgPSSAArmkjnW3swuFlNxg8QNjWL1avgE--
