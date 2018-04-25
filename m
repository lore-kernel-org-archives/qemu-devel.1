Received: from eggs.gnu.org ([2001:4830:134:3::10]:58205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPqj-0000hr-11
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPqe-0001WD-Az
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:13:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPqe-0001Vr-4T
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:13:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2387110183
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 19:12:56 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-6-lersek@redhat.com>
	<877eovahoq.fsf@dusky.pond.sub.org>
	<5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ccb8aaa0-c523-8360-be73-749cf08d074f@redhat.com>
Date: Wed, 25 Apr 2018 14:12:51 -0500
MIME-Version: 1.0
In-Reply-To: <5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PFScQzMaS8TLjH560lzrHJoJxmhiOzqML"
Subject: Re: [Qemu-devel] [PATCH 5/6] qapi: extract CpuInfoCommon to
 mitigate schema duplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PFScQzMaS8TLjH560lzrHJoJxmhiOzqML
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <ccb8aaa0-c523-8360-be73-749cf08d074f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] qapi: extract CpuInfoCommon to mitigate
 schema duplication
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-6-lersek@redhat.com>
 <877eovahoq.fsf@dusky.pond.sub.org>
 <5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
In-Reply-To: <5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 08:20 AM, Laszlo Ersek wrote:

> ...
>=20
> and people would ask themselves ever after, "are there some common
> fields in there that we could extract ... hmmm, @props and @arch, okay,=

> maybe, maybe not, grey area". Let's do it now and save them the thinkin=
g.

No, CpuInfo is slated for death in the next year or so; per commit
ff9a9156.  Once it disappears (in 2.14 or 2.15?), we will ONLY have
CpuInfoFast (although we might rename it at that time, as the name of
QMP structs is not part of the introspection interface).

So, my personal inclination is to just live with the mindless
near-duplication until the deprecation period ends, rather than wasting
cycles refactoring things just to refactor it back out when removing the
dead code later.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PFScQzMaS8TLjH560lzrHJoJxmhiOzqML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0zMACgkQp6FrSiUn
Q2p/Xwf+NK5Wtg1MRfqpaGsdKcpZfV7c60Q6+abRipxtEsboVoUQ86hgPLZqw/wV
wKLscgzQeY5cZunejUyVSbTKRPa6waZJsBPkuLKsx1RAVsl2v/Bhh5NPrhh6Au98
q09/i2rMcm8M9uh7Q3yLAia6cndMPu1UtkdK5k+x5e792bTPVWaBGIYSsxmgN66D
91LKR63cRVJ4inv/uUYdjqoEM51WO3OJll7TMG1ooLEC9Gxih0JCp0uRtkC+fXul
UVtRQYO6ivUuAle58abA+UK8ZGlGgddqlPIqFKChjZMbYEC0TABprWTIt4nkOyAX
fqO0DH5ygGWndR3kLat9Y1xHJrsaCQ==
=WzQG
-----END PGP SIGNATURE-----

--PFScQzMaS8TLjH560lzrHJoJxmhiOzqML--
