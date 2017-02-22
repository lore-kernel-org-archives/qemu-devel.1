Received: from eggs.gnu.org ([2001:4830:134:3::10]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYcp-0002Qb-3b
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYcm-0003A6-0C
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:14:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgYcl-00038e-NO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:14:35 -0500
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
	<1487709988-14322-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba4677a9-6ef4-0e7e-43d4-7314aea26933@redhat.com>
Date: Wed, 22 Feb 2017 09:14:32 -0600
MIME-Version: 1.0
In-Reply-To: <1487709988-14322-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Mj7g4FDRwr45qbvSpwKlJBG2J5WXGoeF"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] i386/cpu: net: Flatten simple union
 GuestPanicInformationType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Mj7g4FDRwr45qbvSpwKlJBG2J5WXGoeF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba4677a9-6ef4-0e7e-43d4-7314aea26933@redhat.com>
Subject: Re: [PATCH v2 3/3] i386/cpu: net: Flatten simple union
 GuestPanicInformationType
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
 <1487709988-14322-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487709988-14322-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 02:46 PM, Markus Armbruster wrote:
> Simple unions are simpler than flat unions in the schema, but more
> complicated in C and on the QMP wire: there's extra indirection in C
> and extra nesting on the wire, both pointless.  They're best avoided
> in new code.  Fix up recent commit d187e08 accordingly.
>=20
> Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Cc: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json  | 14 ++++++++++++--
>  target/i386/cpu.c | 17 ++++++-----------
>  vl.c              | 12 ++++++------
>  3 files changed, 24 insertions(+), 19 deletions(-)

Very similar to Anton's patch which is on Paolo's queue:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04448.html

I don't care which version goes in, but will leave it to Markus and
Paolo to decide which queue it should go through.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5Mj7g4FDRwr45qbvSpwKlJBG2J5WXGoeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrarYAAoJEKeha0olJ0NqUgoIAKqcc2dbA9eulfau/GwHGIQ4
ulnnz1hfmC75U9UL+rXn1YrEkVHdTN/q5mdKhV5SQrN9GVnt3qmGymhc6wpLIkF4
7pww/ZSm9yprNdBbrwv8LtjYRYSihcHSWa53RJPx+ZjXocTGLhKkJY9L4a1jt3wk
rZcYqE+Vf1p7oTWuGa8UWeEaAuh2ZFIT9ou6giFYCj/zyTGWs1wnUzbMgGxWQXEf
BKANDYJ+ZQCfg/TnV1tkSfEN05CV8UEjMacv1nQxNYkMKhghpG9ndjqQLFN+530f
4ZGQevog5iIlBYHHfEad0j+TSf/VAhb76dyhXaRsx8LOB6aU5NWaM0Z0RF33u6A=
=nOT/
-----END PGP SIGNATURE-----

--5Mj7g4FDRwr45qbvSpwKlJBG2J5WXGoeF--
