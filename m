Received: from eggs.gnu.org ([2001:4830:134:3::10]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3CA-0003gT-Gk
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3C7-0002vv-Ax
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cq3C7-0002vD-0e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:42:19 -0400
References: <1490026424-11330-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53330549-71ad-4e85-c1f6-5795a288ac97@redhat.com>
Date: Mon, 20 Mar 2017 14:42:15 -0500
MIME-Version: 1.0
In-Reply-To: <1490026424-11330-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Jr3ntrCOQOpvFhk6Lcc9R3sNthvWH7JS"
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] Fix string input visitor and
 "info memdev" regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Jr3ntrCOQOpvFhk6Lcc9R3sNthvWH7JS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <53330549-71ad-4e85-c1f6-5795a288ac97@redhat.com>
Subject: Re: [PATCH for-2.9 0/2] Fix string input visitor and "info memdev"
 regression
References: <1490026424-11330-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490026424-11330-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 11:13 AM, Markus Armbruster wrote:
> Markus Armbruster (2):
>   qapi: Fix string input visitor regression for empty lists
>   Revert "hostmem: fix QEMU crash by 'info memdev'"

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  backends/hostmem.c                | 22 ++++++++--------------
>  qapi/string-input-visitor.c       |  4 ++++
>  tests/test-string-input-visitor.c | 11 ++++++++---
>  3 files changed, 20 insertions(+), 17 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4Jr3ntrCOQOpvFhk6Lcc9R3sNthvWH7JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DCXAAoJEKeha0olJ0Nq6vQH/3gKIo5HkFiI34X3FFsKCImF
DQTUJAmPWRAUmMerlDSmPgPKpQ44hJC1q7Mf8Ukf8+dXOviCRIyb1uyN5i2VZfKW
SHiX9+YG7BdOEjW/8u8iyhBIonL3qYjLBiDslH5xb7BIa7tL829nT7c7ixZLj0yB
3lFeAwlFd+CkmFU1FGJefLvivc9vHcIgiuB4Uq1V4cRJ8D5uLLs8ECthPciepKHT
gFUDcSN+GumsapdxhksCDzAUlwLRmodX4IO026HvOxXd4iqxk0fO8SQY7Za9NiVu
pdl5twAqGsbOOTh/U8/A1cTKGOI77iezsyJyY2cOkE+2b3wc56u7BABu4DjuoGo=
=XuU/
-----END PGP SIGNATURE-----

--4Jr3ntrCOQOpvFhk6Lcc9R3sNthvWH7JS--
