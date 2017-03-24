Received: from eggs.gnu.org ([2001:4830:134:3::10]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUKx-0001Ov-Nt
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUKu-0000hw-Na
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crUKu-0000hn-F8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:53:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45AA7C03BD7C
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:53:20 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63d75079-5933-7193-dd25-0094af1542e4@redhat.com>
Date: Fri, 24 Mar 2017 13:53:17 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3e6xX93jPEGla6BWejuwUhr2DusJR1RhP"
Subject: Re: [Qemu-devel] [PATCH RFC v2 5/9] rbd: Don't accept -drive
 driver=rbd, keyvalue-pairs=...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3e6xX93jPEGla6BWejuwUhr2DusJR1RhP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <63d75079-5933-7193-dd25-0094af1542e4@redhat.com>
Subject: Re: [PATCH RFC v2 5/9] rbd: Don't accept -drive
 driver=rbd,keyvalue-pairs=...
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> The way we communicate extra key-value pairs from
> qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
> "keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
> rename the parameter to "=3Dkeyvalue-pairs" to make it inaccessible.

We could also use the hack "x-keyvalue-pairs" to make it obvious that it
is unsupported as an external interface (we've used the hack "x-image"
in blkverify/blkdebug), or even "=3Dx-keyvalue-pairs" (combining your hac=
k
with the blkverify hack).  In fact, if your leading '=3D' hack is nice
enough, we could retrofit blkverify and blkdebug to use it instead of
(or in addition to) the leading "x-" hack.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3e6xX93jPEGla6BWejuwUhr2DusJR1RhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1WsdAAoJEKeha0olJ0Nqwc0H/2AcG4jgwGFQDFCF2cd1bkDb
0r+16A/DvJQcmfl+nhFuYkxl/xuvD167jd6IU7bCHhsbxBCKxdiwDRHtn3v9a94D
FsIqTwTZUd6ypX4M3KOIuHxraM4+WtwuIpwUvHRGwfR7KwpW+5rNTrjUp694MwLT
hZpsqHn9cv71xMe0cgPudWsymuN7pSOeoSw70Jw9jme+0VrwYV7tyTVWAapvNKjN
IFiZ96/WPl19/h+PKxvMBEN1/y0bQqZ39Wz8vwTYcUe56L4CAq9ebpHfV28/wevK
kVALTYb+a4/WrGLnUjkKevhcPXpYApB2TntBsX0bXWpwhfLfjmcxUe1uMGhqYiQ=
=srxq
-----END PGP SIGNATURE-----

--3e6xX93jPEGla6BWejuwUhr2DusJR1RhP--
