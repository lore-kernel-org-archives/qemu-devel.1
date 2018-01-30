Received: from eggs.gnu.org ([2001:4830:134:3::10]:57249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaDP-0007aa-Kj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaCi-0001vP-V6
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:01:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaCi-0001tp-Nx
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:00:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67B96B258
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 18:00:19 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <503fab9f-50bf-19cc-9015-dcf4bc39dc6a@redhat.com>
Date: Tue, 30 Jan 2018 12:00:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-17-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zliY4EGGZtyDmjvxnDTSNUg6mokA0AUbB"
Subject: Re: [Qemu-devel] [PATCH 16/18] Drop superfluous includes of
 qapi/qmp/dispatch.h
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
--zliY4EGGZtyDmjvxnDTSNUg6mokA0AUbB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <503fab9f-50bf-19cc-9015-dcf4bc39dc6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/18] Drop superfluous includes of
 qapi/qmp/dispatch.h
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-17-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c                 | 1 -
>  qga/main.c                | 1 -
>  tests/test-qmp-commands.c | 1 -
>  3 files changed, 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zliY4EGGZtyDmjvxnDTSNUg6mokA0AUbB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwsrIACgkQp6FrSiUn
Q2oZmwf+IHxuNUG/YTwzPpxdOVpSnKRl/lqoQ2PhL8HJWD+e26YJYI2NpnvTccAv
D0eSscIv7vElAauwT4fj6Sj4xxTk4bgTevoQQ3mduQlZnDm+dGWAbyiBlZI/BgX/
LBMG5iyf8mINo0TUOzBwVm5xxSPL3Hz3q2bxvLgIHvHLqHdiwMB+TB0CYfbUYOeI
mUuV5JUIiDjkt/6X1Ea9EPoLKcis92dzqVnV2W8yGSpr76N7fimCEIa1gqruRekC
a03+tJPbxc6njihCXmyNDC+KhLVJ2u664lMCpVpsO5iX9Zl9tkogZx0FcYRNA+2K
k0XxvfEcn3GwHnSfVuGg3UEETRI6TQ==
=HlCV
-----END PGP SIGNATURE-----

--zliY4EGGZtyDmjvxnDTSNUg6mokA0AUbB--
