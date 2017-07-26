Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKzu-0007k5-Tl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKzs-0006wD-C9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daKzs-0006vV-5g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6B98C0B2C6D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:00:58 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4066f6b3-5e9c-1179-fc9c-b0d52959ce98@redhat.com>
Date: Wed, 26 Jul 2017 07:00:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bED82LlNUk58BI7OeuAmIqS3vNgbR8aRV"
Subject: Re: [Qemu-devel] [PATCH 1/5] ui: add next and prior keysyms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bED82LlNUk58BI7OeuAmIqS3vNgbR8aRV
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4066f6b3-5e9c-1179-fc9c-b0d52959ce98@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] ui: add next and prior keysyms
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-2-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> Page-up and Page-down where renamed.  Add the names to the keysym list

s/where/were/

> so we can parse both old and new names.  The keypad versions are alread=
y
> present in the vnc map.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/curses_keys.h | 2 ++
>  ui/vnc_keysym.h  | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bED82LlNUk58BI7OeuAmIqS3vNgbR8aRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4hGAACgkQp6FrSiUn
Q2pmPgf+MvrqaD1bUO3HiKTYg57NXXf+x71fUUjPNbNTS9GTrLnwMZwvp6Tbtes4
T5J2dufbkWIfKsj/kmT4GqYyMmb61RePf+bR5UNdTHOcrFc6rKZEADkonViP9JAp
gAKPxzKVlZPwAUATbK2oayoAl0pbjqs0TrYHsqgvp+12895MEuUgWSmw00L4E4D8
GOHAtgViQF1Hm4EBBpPOcDkyOP12Wt2Nz+0d4fdep3/rRmgpUm/zDUKPjdQNWwAm
gIRElb5ncPIZeO5NEnluD/mRsS1vVOb4PailqJklYysDKTXsnGziVgoJzjh1V6Dj
5MSxPgMvfClQLkOiZsfQooKPv+uZUQ==
=FMfQ
-----END PGP SIGNATURE-----

--bED82LlNUk58BI7OeuAmIqS3vNgbR8aRV--
