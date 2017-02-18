Received: from eggs.gnu.org ([2001:4830:134:3::10]:56278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cf4nt-0007qS-00
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 08:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cf4no-0001MG-4j
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 08:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cf4nn-0001LG-UQ
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 08:11:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3292C0467F1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 13:11:51 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3611b112-f976-a228-e54e-b3deadc1f52b@redhat.com>
Date: Sat, 18 Feb 2017 07:11:49 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wMvDhlWR3l81Hc6pf3131pdHBkCCVe9Hm"
Subject: Re: [Qemu-devel] [PATCH 03/14] check-qdict: Tighten
 qdict_crumple_test_recursive() some
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
--wMvDhlWR3l81Hc6pf3131pdHBkCCVe9Hm
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3611b112-f976-a228-e54e-b3deadc1f52b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] check-qdict: Tighten
 qdict_crumple_test_recursive() some
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Consistently check for unexpected QDict entries, and qdict_get_qdict()
> success.  The latter doesn't tighten the test, it only makes it fail
> more nicely.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qdict.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wMvDhlWR3l81Hc6pf3131pdHBkCCVe9Hm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYqEgVAAoJEKeha0olJ0Nqmk0IAKoRGNN6l1mMRvcfzYougcpw
mmc6gZBLANxdyXyX0RaJVFoZweUngytw1U8Xb+HXKeV2cNq+hmilL8P2SrhghZGi
90b8hkjB3swug13gqj992eUz6GSkGLneRRoULdbUMv5zZ6KY3eYy7iwCFhloxY7g
+66uI709Wx6ReVQfWR06daUBoMr11GdbcBYcEsSm1HIZkjEgCNLifD4RcAR7g8mm
S4QANxAYq6cSvHvlYDS2+0PnZUeG8/vPnr63cwtPxWhXutGfDNKMf2DxDvhwWLgt
GG0Lmid/U2GZE9Hqh8erBOvbixKHyzaZQwOKuDscfXyuGUZCv0XlzO5O3M8RRRc=
=cG84
-----END PGP SIGNATURE-----

--wMvDhlWR3l81Hc6pf3131pdHBkCCVe9Hm--
