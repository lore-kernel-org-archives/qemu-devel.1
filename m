Received: from eggs.gnu.org ([2001:4830:134:3::10]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwxr-000743-FB
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwxh-0002op-Uv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpwxh-0002o2-Lz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A817561476
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 13:35:16 +0000 (UTC)
References: <cover.1504771369.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd548267-cae0-7087-caf8-fac63bf5c01b@redhat.com>
Date: Thu, 7 Sep 2017 08:35:13 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q9EahWrMljjgQXC4XhCWbKMTC5U9WNhu8"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q9EahWrMljjgQXC4XhCWbKMTC5U9WNhu8
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <dd548267-cae0-7087-caf8-fac63bf5c01b@redhat.com>
Subject: Re: [PATCH v5 0/3] watchdog.h: Drop local redefinition of actions
 enum
References: <cover.1504771369.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 03:05 AM, Michal Privoznik wrote:
> diff to v4:
> - in 3/3 compare passed action string case insensitively to the qapi en=
um
>=20
> Michal Privoznik (3):
>   qapi: Rename WatchdogExpirationAction enum
>   watchdog.h: Drop local redefinition of actions enum
>   watchdog: Allow setting action on the fly

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  hw/watchdog/watchdog.c    | 65 ++++++++++++++++++++++++---------------=
--------
>  hw/watchdog/wdt_diag288.c |  6 ++---
>  include/sysemu/watchdog.h | 12 ++-------
>  monitor.c                 |  4 +--
>  qapi-schema.json          |  9 +++++++
>  qapi/run-state.json       |  6 ++---
>  6 files changed, 52 insertions(+), 50 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--q9EahWrMljjgQXC4XhCWbKMTC5U9WNhu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxSxEACgkQp6FrSiUn
Q2oSAQf/fMgeJH/dlEeetZl+tHNHEB++deXu1Mxi8b6jieszgz29jveO8nuIKY8P
c+AXE6n7LdzmDM8r16b6NrLOOGPJ42/phk03Z1629YYhPF9imSEd/qNo/gnvY8jg
2JGQ5XHpVdtS6ZbEycEl3Fa0aj0KPSA+su8yiG5CImIO+cI18tpvNsQMSrNtSyYZ
DwO4xosGuaj9MBHYEN3xRiXe5A3Cf0lqficgfoYh/WX63fdVp3oPZ52uEmalhLes
CFuCwN65knxFIB7Y90PxWMGEgaOzQcQiUX5dglJtfxYzILf/lNiZvJMjDZxBJ3Af
hEyBx2Ljz2DLF3v11x8yowl6b7Lwpw==
=8OSA
-----END PGP SIGNATURE-----

--q9EahWrMljjgQXC4XhCWbKMTC5U9WNhu8--
