Received: from eggs.gnu.org ([2001:4830:134:3::10]:37605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijzt-0005M6-0T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijzp-0000fR-Vc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:47:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cijzp-0000en-Hi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:47:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A505E9D50C
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:47:25 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-21-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a090f6d3-41a8-5422-f3dd-72115eb7ee89@redhat.com>
Date: Tue, 28 Feb 2017 09:47:23 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-21-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K0ueRA5liDMdW8sse6eTMpMm4XKSEIM7R"
Subject: Re: [Qemu-devel] [PATCH v2 20/26] test-string-input-visitor:
 Improve list coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K0ueRA5liDMdW8sse6eTMpMm4XKSEIM7R
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a090f6d3-41a8-5422-f3dd-72115eb7ee89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/26] test-string-input-visitor: Improve
 list coverage
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-21-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Lists with elements above INT64_MAX don't work (known bug).  Empty
> lists don't work (weird).
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-string-input-visitor.c | 85 +++++++++++++++++++++++++++++++=
++------
>  1 file changed, 72 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--K0ueRA5liDMdW8sse6eTMpMm4XKSEIM7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtZuLAAoJEKeha0olJ0NqKb4H/R4+gN+7VPZcGuwcXqnji6QE
HaXVooXsKtuDx+hufcjr0Efz4caezStwhxk5XsKEf+5Nh3sBLHTmAjslBU+dKzMT
YJKeSyzPcvqV9BIxeKbLyxIooKaLvRUc6aiW/5hTs0HYc0V1CYb3jRc5QwoThZT3
qh7XmT92L0kBsQ2OcLsIIzF7UzlkoykpL0QA6UfsqxyZDhoDs6gNmkSX3XWvS/21
ALW1I32Z/Chwcgef0MKPB891XdWvwlxLxHclBAmfzwO3DMM/JNgQiIMETaV4QlN6
CaGdcBHGT4KjJ+XS6idoAQ4TM4BX+LCSNQ62W8qWlmQQVFsai0Hdu4o+EcbUNEU=
=JETo
-----END PGP SIGNATURE-----

--K0ueRA5liDMdW8sse6eTMpMm4XKSEIM7R--
