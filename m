Received: from eggs.gnu.org ([2001:4830:134:3::10]:39678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmxg-0005zO-Kq
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmxd-00016i-IU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:35:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvmxd-00016c-9q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:35:05 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
	<1491405505-31620-2-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
Date: Wed, 5 Apr 2017 10:35:00 -0500
MIME-Version: 1.0
In-Reply-To: <1491405505-31620-2-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IDPhijO5Ia4HvMg5ie7HJHFMseKHOkhqK"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: fix obvious coding style
 mitakes in block_int.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Klim Kireev <proffk@virtuozzo.mipt.ru>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IDPhijO5Ia4HvMg5ie7HJHFMseKHOkhqK
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Klim Kireev <proffk@virtuozzo.mipt.ru>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <74131dfa-9cd8-4d0c-6d2c-6a87358159bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: fix obvious coding style mitakes
 in block_int.h
References: <1491405505-31620-1-git-send-email-den@openvz.org>
 <1491405505-31620-2-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-2-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 10:18 AM, Denis V. Lunev wrote:
> From: Klim Kireev <proffk@virtuozzo.mipt.ru>

s/mitakes/mistakes/ in the subject

A blank commit message body doesn't help - the subject says what was
changed but not why (for example, output of checkpatch.pl without the
patch applied); and details may help in grepping past history when
looking for the change or even to justify that the change is not just chu=
rn.

>=20
> Signed-off-by: Klim Kireev <proffk@virtuozzo.mipt.ru>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

At any rate, all of the changes (the fact that we prefer binding the
pointer operator * to the name on the right rather than the type on the
left) look sane.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IDPhijO5Ia4HvMg5ie7HJHFMseKHOkhqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5Q6kAAoJEKeha0olJ0NqaekH/R+ghzVqPKCfChFNvJPaaIjo
IpNdrvtyUVVoGizOzU3YujwEoo+qC9C6+zDwg9ZV4kGoj44mfpSNtmZZNUMLSCvV
x8wo+hTT6V/p17G6oPfXcuop4LzeXWvHoLK2EuGAbujINOxtVMR+vxr5yH/TodMZ
j9EGrCjOwbTJPohvP9uEpBZsdTO+LZig3ovd6mWwqiH1OpU3fJOxpeZXeLAZXKS6
Npzls9FAKX6lzbAhiOK0eq0Y44Mj77AK4jVnTyUVB+PzKwHnl1VnUL5y3otHJbzp
YljsJ6IQNkavwrGxANLWw81VZOOuyEBqRY57ivaXvG3V0q8P/CGNubQ/wJkuRow=
=bmcI
-----END PGP SIGNATURE-----

--IDPhijO5Ia4HvMg5ie7HJHFMseKHOkhqK--
