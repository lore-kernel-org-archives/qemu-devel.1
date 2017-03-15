Received: from eggs.gnu.org ([2001:4830:134:3::10]:39879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co9zG-0004l1-36
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co9zB-0005MG-D6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co9zB-0005M5-4Z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:33:09 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac97db47-5029-543d-e202-a14ef8b44526@redhat.com>
Date: Wed, 15 Mar 2017 09:33:06 -0500
MIME-Version: 1.0
In-Reply-To: <1489582656-31133-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="okcxE0ecFrHBDtJcuggGfDSTriThslgQN"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 05/47] qapi: Have each QAPI
 schema declare its returns white-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--okcxE0ecFrHBDtJcuggGfDSTriThslgQN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <ac97db47-5029-543d-e202-a14ef8b44526@redhat.com>
Subject: Re: [PATCH v2 for-2.9 05/47] qapi: Have each QAPI schema declare its
 returns white-list
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:56 AM, Markus Armbruster wrote:
> qapi.py has a hardcoded white-list of command names that may violate
> the rules on permitted return types.  Add a new pragma directive
> 'returns-whitelist', and use it to replace the hard-coded white-list.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--okcxE0ecFrHBDtJcuggGfDSTriThslgQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJYyVCiAAoJEKeha0olJ0NqZ+wH+JXqSq1oBItE809qkOMbV632
njIfPfHzXHwSfxmk+hGuJiSCZdfWlt9PuTuxIdiW7WMY0VjmtxzdNMNlCbVw6IFp
ru6DolUaNpBTGbX79YBUs5hpT75ULqDIwB+YD7h+dApj/w7eAzzjla43DGdn0PjJ
rYrWAByYBjj/sIlgO8yA/D3yrZ7F5cV0TnqVECE4mYObPvVgkplM7kqZLGcD39/Q
tryOWnCSCg92SGRHKX+T/G339N7zHRXnQQo6Vt4RGt4WhNrg5+dVCbPpVn8X/Vwb
3axGSl96142hBpRbBb3F5HKaHJHvCRrdsCt6fGOJU9cTL3vhcil4z9+NfBo/jQ==
=UnjB
-----END PGP SIGNATURE-----

--okcxE0ecFrHBDtJcuggGfDSTriThslgQN--
