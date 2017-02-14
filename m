Received: from eggs.gnu.org ([2001:4830:134:3::10]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkxi-0005TM-6k
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkxd-0008NV-Cl
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:48:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdkxd-0008NP-6y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:48:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3682EC0092CF
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:48:33 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec6c8b86-cc41-57ab-b3c5-61ecf30d704b@redhat.com>
Date: Tue, 14 Feb 2017 15:48:31 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ReAIMfCf9BnNJxvrv5fVvudqwnIQwBndx"
Subject: Re: [Qemu-devel] [PATCH 09/24] QemuOpts: Fix to reject numbers that
 overflow uint64_t
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
--ReAIMfCf9BnNJxvrv5fVvudqwnIQwBndx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ec6c8b86-cc41-57ab-b3c5-61ecf30d704b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/24] QemuOpts: Fix to reject numbers that
 overflow uint64_t
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> parse_option_number() fails to check for overflow after strtoull().
> Has always been broken.  Fix that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qemu-opts.c | 14 ++++++--------
>  util/qemu-option.c     | 11 ++++++++---
>  2 files changed, 14 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ReAIMfCf9BnNJxvrv5fVvudqwnIQwBndx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3svAAoJEKeha0olJ0NqZAwH/RtHna76G5hhpfxZAVai6N1k
eEGP+Jd/vaX2JeDIjdw/IWV16DcuAsjCq+N1tmmtsXaw4MIoEQNrGYNLSZJw7AKB
PATaVjf/gpIuUH0qvq2A/Aph0HOPwefn1KByMCEP0qzqbfLOy1jFxqRm+IxbPkCH
o2gurTI1VHfaD6YUFDEqAgeFiNTnHzPtYzaWdgViS2I97iZJmRyCI5r4rf37jWhb
XAdrxZeq4C1a3FYzAjQgp2xkLV5HPVf9ojdei496v7BISK0pwmkU/A/UFN5WkQEz
WCT4WZecgLWz+oAXqiwjmDPzVGuuwxWzEw5HOiTIm6gw9uPyzZBUZA7iXYJxS/4=
=u4F3
-----END PGP SIGNATURE-----

--ReAIMfCf9BnNJxvrv5fVvudqwnIQwBndx--
