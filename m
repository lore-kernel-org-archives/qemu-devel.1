Received: from eggs.gnu.org ([2001:4830:134:3::10]:54589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKrH-0001hK-I1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKrE-000182-Ap
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daKrE-00017Z-1l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8DDF356F6
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:52:02 +0000 (UTC)
References: <20170726114437.19624-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dff2d29a-1c80-a624-6476-5104c0b5344e@redhat.com>
Date: Wed, 26 Jul 2017 06:52:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170726114437.19624-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="usVism282R7NSgAIF6h49siwQ6W9Hd5l7"
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--usVism282R7NSgAIF6h49siwQ6W9Hd5l7
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Message-ID: <dff2d29a-1c80-a624-6476-5104c0b5344e@redhat.com>
Subject: Re: [qemu-web PATCH] add Thomas's bug reporting dos and don'ts
References: <20170726114437.19624-1-pbonzini@redhat.com>
In-Reply-To: <20170726114437.19624-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:44 AM, Paolo Bonzini wrote:
> We don't want the page to become too long, but these are good suggestio=
ns.
>=20
> Also tone down the sentence about using the latest release or latest gi=
t
> tree, though we do prefer those.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  contribute.md              |  2 +-
>  contribute/report-a-bug.md | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20

>  * Reproduce the problem directly with a QEMU command-line.  Avoid fron=
tends and management stacks, to ensure that the bug is in QEMU itself and=
 not in a frontend.
> =20
> -* Include as information about the guest (operating system, version, 3=
2/64-bit).
> +* Include as information about the host and guest (operating system, v=
ersion, 32/64-bit).

Grammar. Your choice of which fix to use:
s/as //
s/as information/as much information as possible/

With that fixed:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--usVism282R7NSgAIF6h49siwQ6W9Hd5l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4gmAACgkQp6FrSiUn
Q2qWKggApotCQW5XWhCr6VyP0RwqezrOrPr29I9nkQ1xMjJuGbB9Geg45uzI0mLY
wY8bYwxTPm8BImP2RnBSFqTuxX+/qIm5SqPtZA+AjxURQVG5sUS0zBdWe3jMOzq2
/WwNz/OjxXR+VDi0MxABs/6tg8gGLyeNHXBDAcgPMNYRzMmZhNLMC36Ddk7GRC5E
yRuEqvyGE6k+hT0o2fFp04KCk8goG49XH78HideRF8WG4w4iUm1kLhjTNcS7+h3w
KAEQPhaeU5s+VK5OnRQcBPkMjrAGCucqXdbQYiyMrhGdDLcMbPs3fztlPmf5cuUy
ZYSq1iIQycFPVDfG2jua+MCo4Z34/Q==
=Ztug
-----END PGP SIGNATURE-----

--usVism282R7NSgAIF6h49siwQ6W9Hd5l7--
