Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer2D-0000O0-HN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer28-0008BJ-LO
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cer28-0008AZ-Eg
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:29:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A7BF61B8A
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 22:29:44 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9de497d-9a58-45a3-cf44-2cc7beaf306d@redhat.com>
Date: Fri, 17 Feb 2017 16:29:42 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GWffb8MtgpemXDnOl2sEvxXJDlgmMFT4u"
Subject: Re: [Qemu-devel] [PATCH 01/14] qdict: Make qdict_get_qlist() safe
 like qdict_get_qdict()
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
--GWffb8MtgpemXDnOl2sEvxXJDlgmMFT4u
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e9de497d-9a58-45a3-cf44-2cc7beaf306d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/14] qdict: Make qdict_get_qlist() safe
 like qdict_get_qdict()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Commit 89cad9f changed qdict_get_qdict() to return NULL instead of
> crash when the key doesn't exist or its value isn't a QDict.
> Commit 2d6421a neglected to do the same for qdict_get_qlist().
> Correct that, and update the function comments.
>=20
> qdict_get_obj() is now unused, remove.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qobject/qdict.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GWffb8MtgpemXDnOl2sEvxXJDlgmMFT4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp3lWAAoJEKeha0olJ0NqcFUH/A0shEd+SH/D76taBKQ9LM1n
uXilN1FZTmK8sRN4VcnafGp3CNAE6uXkuj+wTVotOscorNseZZyyao0HYlowBCo1
TeHkSMRt6GIdvGbuUHWg4QbUNtz57hZ3KViZQ1txSL5m2JrrRzhd2bgq4K36Dl3x
0GMFeTj1stnny1R17vWltOKT50IA9olvh1BHm0vx+yzriDMRrJVyuPtkActX/2Wz
Pm/sp3msI+9MJmK5zeIwLmXPCQqShFY77HYh2S8BHYYSJt5ciafk/5TnkpusJ1xq
9PsAkCb0eZgVX7z2mi10bny9Y4rTho5P8mWvDwwmV2PmmJWuALO77SzYWXJMtP0=
=x2OK
-----END PGP SIGNATURE-----

--GWffb8MtgpemXDnOl2sEvxXJDlgmMFT4u--
