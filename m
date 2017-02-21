Received: from eggs.gnu.org ([2001:4830:134:3::10]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgC0Y-00066P-4h
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgC0U-00026n-7l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgC0U-00026N-2M
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:34 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F37E80491
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 15:05:34 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2937d173-68d0-9a6f-4d0f-2e3c5cddda2b@redhat.com>
Date: Tue, 21 Feb 2017 09:05:32 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SJQkjxdc0hNoX2m018NnqF3X4lTPLGL1I"
Subject: Re: [Qemu-devel] [PATCH 07/14] Don't check qobject_type() before
 qobject_to_qdict()
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
--SJQkjxdc0hNoX2m018NnqF3X4lTPLGL1I
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2937d173-68d0-9a6f-4d0f-2e3c5cddda2b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/14] Don't check qobject_type() before
 qobject_to_qdict()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qdict(obj) returns NULL when obj isn't a QDict.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QDICT.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SJQkjxdc0hNoX2m018NnqF3X4lTPLGL1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrFc8AAoJEKeha0olJ0Nq2bIH/0yaHhYiGY5GQybHUNG+A9XB
8mnzzkGmIH8OCs/Syt50Vmiv4G6gT5Y7wWSdyg9Feko/oJ6O8QYGkDl0fGAmd0xH
3H4BgHXWXalJBtZ0georXOoGS9xivnMP1RdD36bjHrhk+QB1+NJRQTsppmor9yP5
X9HjFTrFJLc509z5B/Fw1mTEvDI0CnoHrvm4aaLqXwdQUseS2vsybXpIIbnnqsTW
5YjLf699K34mdO5Ii9rAawvpazg24x6zjqVNlPVXsgaLHdIvnmFA4TQVTORtWJq1
jjVQLjva+fxA08SX8nIIylG2EwXZgA/QQhslqHyQasZONK8cfcqUACEmYfjTKqQ=
=Wg3C
-----END PGP SIGNATURE-----

--SJQkjxdc0hNoX2m018NnqF3X4lTPLGL1I--
